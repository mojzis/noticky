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
        title_match = re.search('title = \"(?P<title>.+)\"',text)
        section_match = re.search('section = \"(?P<section>.+)\"',text)
        score_re = re.compile(r"\\score {\n(?P<score><<(\n.+)+\n>>)", re.MULTILINE)
        score_match = re.search(score_re, text)
        lyrics_re = re.compile(r"\\line {(?P<lyri>.+)}")
        lyrics_match = re.findall(lyrics_re, text)
        results.append({
            'filename': filename,
            'title': title_match.groupdict().get('title'),
            'score': score_match.groupdict().get('score', 'nada'),
            'lyrics': lyrics_match
            # 'section' : section_match.groupdict().get('section'),
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
    with open(f'{SCORE_ONLY_PATH}/{song["filename"]}.ly', 'w') as so:
        so.write(score)

    # would it be nicer to have this in some config aside ?
    options = [
        '-fsvg',
        '-dbackend=svg',
        '--output=public/heads',
        '-s',
        '-dcrop',
        f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    ]
    # lily is decided to create 2 files, delete the other one
    run_lily(options)

def generate_ogimage(song):
    """ prepare an image for the page to be used on the social media """
    # options = [
    #     '-fpng',
    #     '--output=work/ogimg',
    #     '-s',  # silent
    #     '-dcrop',
    #     f'{SCORE_ONLY_PATH}/{song["filename"]}.ly'
    # ]
    # run_lily(options)
    svg = pyvips.Image.new_from_file(f'public/heads/{song["filename"]}.cropped.svg', dpi=180)
    svg.write_to_file(f'work/ogimg/{song["filename"]}.png')
    ogi = Image.new('RGB', (1400, 700), ImageColor.getrgb('white'))
    notes = Image.open(f'work/ogimg/{song["filename"]}.png')
    ogi.paste(notes)
    ogi.save(f'public/ogimg/{song["filename"]}.png')


@click.command()
def publish():
    songs = load_songs()
    # todo: generate pdfs directly from here

    env = Environment(
        loader=FileSystemLoader('templates'),
    )
    for song in songs:
        prepare_svg(song)
        generate_ogimage(song)
        with open(f'public/songs/{song["filename"]}.html','w') as s:
            s.write(env.get_template('song.html')
                .render(song=song))

    # todo separate sections
    with open('public/index.html', 'w') as f:
        f.write(env.get_template('index.html').render(songs=songs))
    
    print(f'{len(songs)} songs listed in index')

main.add_command(publish)

if __name__ == "__main__":
    main()