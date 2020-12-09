import json
import pathlib
import os
import re
import subprocess
import sys
import hashlib

import click
from jinja2 import Environment, FileSystemLoader
import pyvips

SCORE_ONLY_PATH = 'lilywork/score_only'
PDF_DEFAULT_PATH = 'public/lilyout'
SOURCE_PATH = 'lilysource'

LOGGING = True
# for quick updates of irrelevant stuff, even if source file changed, lets allow to keep old
KEEP_OLD_FILE = False
GENERATE_ANYWAY = True
SITE_DOMAIN = 'https://noticky.eu'


@click.group()
def main():
    """click"""


def load_songs():
    # todo: store the results in a file, only check here whether the hash has changed
    metadata_path = 'log/metadata.json'
    try:
        with open(metadata_path) as metadata_file:
            previous_hashes = json.load(metadata_file)
    except (json.decoder.JSONDecodeError, FileNotFoundError):
        previous_hashes = {}
    glob = pathlib.Path(SOURCE_PATH).glob("*.ly")
    results = []
    hashes = {}
    for song in sorted(glob):
        filename = pathlib.Path(song).stem
        f = open(song, 'r')
        text = f.read()
        f.close()
        song_hash = hashlib.blake2b(text.encode('utf-8')).hexdigest()
        hashes[filename] = song_hash
        updated = False
        if filename not in previous_hashes:
            previous_hashes[filename] = ''
        if previous_hashes[filename] != song_hash:
            updated = True
        title_match = re.search('title = \"(?P<title>.+)\"', text)
        section_match = re.search('section = \"(?P<section>.+)\"', text)
        score_re = re.compile(r"\\score {\n(?P<score><<(\n.+)+\n>>)", re.MULTILINE)
        score_match = re.search(score_re, text)
        lyrics_re = re.compile(r"\\line {(?P<lyri>.+)}")
        lyrics_match = re.findall(lyrics_re, text)
        results.append({
            'filename': filename,
            'title': title_match.groupdict().get('title'),
            'score': score_match.groupdict().get('score', 'nada'),
            'lyrics': lyrics_match,
            'section': section_match.groupdict().get('section'),
            'updated': updated
            })
    metadata_file = open(metadata_path, 'w')
    json.dump(hashes, metadata_file, indent=4)
    metadata_file.close()
    return results


def run_lily(options):
    options.insert(0, 'lilypond')
    try:
        subprocess.run(options)
    except:
        e = sys.exc_info()[0]
        print(e)
    # todo: return possible issues / warnings ?


def prepare_svg(song):
    """ Take the score part of the ly file and generate and svg for the top of the page. """

    target_dir = 'templates/heads'
    # todo: ensure dir exists
    work_dir = 'work/svg'
    if should_skip(f'{target_dir}/{song["filename"]}.svg'):
        # todo: log we decided to skip it
        print(f'skipping svg for {song["filename"]}')
        return
    print('starting svg')
    first_line = '#(set-global-staff-size 34)'
    score = first_line + '\n' + song['score']
    # score = score.replace('\easyHeadsOn', '\easyHeadsOff')
    with open(f'{SCORE_ONLY_PATH}/{song["filename"]}.ly', 'w') as so:
        so.write(score)

    # would it be nicer to have this in some config aside ?
    options = [
        '-fsvg',
        '-dbackend=svg',
        f'--output={work_dir}',
        '-dno-point-and-click',
        '-s',
        '-dcrop',
        f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    ]
    # lily is decided to create 2 files, delete the other one
    run_lily(options)
    os.remove(f'{work_dir}/{song["filename"]}.svg')
    with open(f'{work_dir}/{song["filename"]}.cropped.svg') as cropped:
        svg_text = cropped.read()
        svg_text = svg_text.replace('<svg ', '<svg class="score" ')
    # todo: include in jinja also from other dirs ?
    with open(f'{target_dir}/{song["filename"]}.svg', 'w') as svg_res:
        svg_res.write(svg_text)
    os.remove(f'{work_dir}/{song["filename"]}.cropped.svg')


def should_skip(path):
    """Helper function to determine whether we should proceed generating the file or rather skip."""
    return os.path.isfile(path) and KEEP_OLD_FILE


def prepare_png(song):
    target_dir = 'work/ogimg'
    if should_skip(f'{target_dir}/{song["filename"]}.png'):
        # todo: log we decided to skip it
        return
    options = [
        '-fpng',
        f'--output={target_dir}',
        '-s',
        '-dcrop',
        f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    ]
    run_lily(options)


def generate_ogimage(song):
    """ prepare an image for the page to be used on the social media """
    filename = f'public/ogimg/{song["filename"]}.png'
    if should_skip(filename):
        return
    # TODO: add title as well (?)
    # todo: make it slightly bigger ?
    ogi = pyvips.Image.new_from_file(f'work/ogimg/{song["filename"]}.cropped.png')
    ogi = ogi.embed((1400-ogi.width)/2, (700-ogi.height)/2, 1400, 700, extend='white')
    ogi.write_to_file(filename)


def generate_pdf(song):
    if should_skip(f'{PDF_DEFAULT_PATH}/{song["filename"]}.pdf'):
        # todo: log we decided to skip it
        return

    options = [
        f'--output={PDF_DEFAULT_PATH}',
        '-dno-point-and-click',
        '-s',
        f'{SOURCE_PATH}/{song["filename"]}.ly'
    ]
    run_lily(options)


@click.command()
def publish():
    songs = load_songs()

    env = Environment(
        loader=FileSystemLoader('templates'),
    )
    sitemap = [f'{SITE_DOMAIN}/index.html']
    for song in songs:
        # todo: check whether source file changed
        if song['updated'] or GENERATE_ANYWAY:
            print(f'begin {song["filename"]}')
            prepare_svg(song)
            prepare_png(song)
            generate_ogimage(song)
            generate_pdf(song)
        else:
            print(f'skipping {song["filename"]}')
        with open(f'public/songs/{song["filename"]}.html', 'w') as s:
            s.write(env.get_template('song.html')
                .render(song=song))
        sitemap.append(f'{SITE_DOMAIN}/songs/{song["filename"]}.html')

    # todo separate sections
    with open('public/index.html', 'w') as f:
        f.write(env.get_template('index.html').render(songs=songs))

    with open('public/sitemap.txt', 'w') as sm:
        sm.write('\n'.join(sitemap))

    print(f'{len(songs)} songs listed in index')


@click.command()
def og_image_home():
    songs = load_songs()
    ogi = pyvips.Image.black(1400, 700)
    ogi = ogi.draw_flood(255, 0, 0)
    for i in range(0, 5):
        song = songs[i]
        lim = pyvips.Image.new_from_file(f'work/ogimg/{song["filename"]}.cropped.png')
        lim = lim.crop(0, 0, lim.width, 123)
        ogi = ogi.insert(lim, (1400-lim.width)/2, 125*i + 25, expand=False, background=255)
    ogi.write_to_file(f'public/ogimg/home.png')


main.add_command(publish)
main.add_command(og_image_home)

if __name__ == "__main__":
    main()
