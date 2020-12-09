import pathlib
import os
import re
import subprocess
import sys

import click
from jinja2 import Environment, FileSystemLoader
from PIL import Image, ImageDraw, ImageColor
import pyvips

SCORE_ONLY_PATH = 'lilywork/score_only'

@click.group()
def main():
    """click"""

def load_songs():
    glob = pathlib.Path("lilysource").glob("*.ly")
    results = []
    for song in sorted(glob):
        filename = pathlib.Path(song).stem
        f = open(song, 'r')
        text = f.read()
        f.close()
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
            })
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
    first_line = '#(set-global-staff-size 34)'
    score = first_line + '\n' + song['score']
    # score = score.replace('\easyHeadsOn', '\easyHeadsOff')
    with open(f'{SCORE_ONLY_PATH}/{song["filename"]}.ly', 'w') as so:
        so.write(score)

    # would it be nicer to have this in some config aside ?
    options = [
        '-fsvg',
        '-dbackend=svg',
        '--output=public/heads',
        '-dno-point-and-click',
        '-s',
        '-dcrop',
        f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    ]
    # lily is decided to create 2 files, delete the other one
    run_lily(options)

def prepare_png(song):
    # todo: add check whether exists !
    options = [
        '-fpng',
        '--output=work/ogimg',
        '-s',
        '-dcrop',
        f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    ]
    run_lily(options)

def generate_ogimage(song):
    """ prepare an image for the page to be used on the social media """
    # TODO: add title as well
    ogi = pyvips.Image.new_from_file(f'work/ogimg/{song["filename"]}.cropped.png')
    ogi = ogi.embed((1400-ogi.width)/2, (700-ogi.height)/2, 1400, 700, extend='white')
    ogi.write_to_file(f'public/ogimg/{song["filename"]}.png')


@click.command()
def publish():
    songs = load_songs()
    # todo: generate pdfs directly from here

    env = Environment(
        loader=FileSystemLoader('templates'),
    )
    sitemap = ['https://noticky.eu/index.html']
    for song in songs:
        prepare_svg(song)
        prepare_png(song)
        generate_ogimage(song)
        with open(f'public/songs/{song["filename"]}.html', 'w') as s:
            s.write(env.get_template('song.html')
                .render(song=song))
        sitemap.append(f'https://noticky.eu/songs/{song["filename"]}.html')

    # todo separate sections
    with open('public/index.html', 'w') as f:
        f.write(env.get_template('index.html').render(songs=songs))

    with open('public/sitemap.txt', 'w') as sm:
        sm.write('\n'.join(sitemap))

    print(f'{len(songs)} songs listed in index')

@click.command()
def play():
    songs = load_songs()
    ogi = pyvips.Image.black(1400, 700)
    ogi = ogi.draw_flood(255, 0, 0)
    for i in range(0, 5):
        song = songs[i]
        lim = pyvips.Image.new_from_file(f'work/ogimg/{song["filename"]}.cropped.png')
        lim = lim.crop(0, 0, lim.width, 123)
        ogi = ogi.insert(lim, (1400-lim.width)/2, 125*i + 25, expand=False, background=255)
        # ogi = ogi.join(lim, direction='top-bottom', expand=True, shim=3, background=225, align='centre')
    ogi.write_to_file(f'public/ogimg/home.png')


main.add_command(publish)
main.add_command(play)

if __name__ == "__main__":
    main()
