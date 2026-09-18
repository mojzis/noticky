"""Generate a coloring-page illustration for a song, using ../bookmaker's style,
personas and prompt code so characters match the bookmaker comics.

Run with bookmaker's environment (it holds the Replicate token in .env):

    cd ~/git/bookmaker && uv run python ~/git/noticky/scripts/gen_image.py dobry_kral_vaclav

Writes images/<song>-color.png (watercolour) and images/<song>.png (coloring page),
each with a .prompt.txt next to it. Existing files are kept unless --force.
"""
import io
import pathlib
import sys

from PIL import Image

from bookmaker import store
from bookmaker.images import _prompt_note, run_one
from bookmaker.prompts import build_prompt, coloring_prompt

NOTICKY = pathlib.Path(__file__).resolve().parent.parent
OUT = NOTICKY / 'images'

SONGS = {
    'dobry_kral_vaclav': {
        'comic': 'good-king-wenceslaus',
        'style': 'akvarel',
        'aspect': '2:3',
        'personas': ['vaclav-knize', 'podiven'],
        'variants': {'vaclav-knize': 'zima', 'podiven': 'zima'},
        'ref_panels': ['kdo_to_je'],
        'prompt': (
            "This is Bohemia in 930 AD: wool and linen, simple iron. A tall upright picture. "
            "Winter night, a round full moon high in the sky, a few big snowflakes falling, "
            "a line of snowy pine trees at the back and a smooth white snowfield. "
            "Two men walk toward us one behind the other, wading through deep snow. "
            "In front, nearer to us and bigger: {vaclav-knize}, walking steadily toward us, "
            "a bundle of firewood logs tied on his back, his right hand holding up a small "
            "iron lantern, his face calm and kind. "
            "A step behind him and a little to the side, partly hidden by him: {podiven}, "
            "carrying a basket with a loaf of bread on his arm, his head bent against the "
            "cold, following close in the prince's wake. "
            "The snow in front of them is smooth and untouched. "
            "Both figures full length, large in the picture, clear simple silhouettes."
        ),
        'coloring_hint': (
            "This page is printed small, next to song lyrics: keep the lines bold and clear, "
            "the shapes big and simple, and leave generous open white areas to color in. "
            "The moon, snowflakes and footprints stay as simple outlines."
        ),
    },
}


def save_png(blob, path):
    """The model may answer with a JPEG; lilypond's \\image wants a real PNG."""
    Image.open(io.BytesIO(blob)).save(path, 'PNG')


def main(song_id, force=False):
    cfg = SONGS[song_id]
    OUT.mkdir(exist_ok=True)
    color_path = OUT / f'{song_id}-color.png'
    bw_path = OUT / f'{song_id}.png'
    style = store.load_styles()[cfg['style']]
    personas = {pid: store.load_persona(pid) for pid in cfg['personas']}

    comic = store.load_comic(cfg['comic'])
    refs = []
    for pid in cfg['ref_panels']:
        _, panel = store.find_panel(comic, pid)
        refs.append(store.panel_image(cfg['comic'], panel))
    refs += [store.persona_image(pid) for pid in cfg['personas']]
    refs = [r for r in refs if r]

    if force or not color_path.exists():
        prompt = build_prompt(style, cfg['prompt'], cfg['personas'], personas, cfg['variants'])
        print(f'painting {color_path.name} ({len(refs)} refs)')
        save_png(run_one(prompt, cfg['aspect'], refs), color_path)
        color_path.with_suffix('.prompt.txt').write_text(
            _prompt_note('default', cfg['aspect'], refs, prompt))

    if force or not bw_path.exists():
        prompt = coloring_prompt(store.coloring_prompt(), style,
                                 {'coloring_hint': cfg['coloring_hint']})
        print(f'coloring {bw_path.name}')
        save_png(run_one(prompt, cfg['aspect'], [color_path]), bw_path)
        bw_path.with_suffix('.prompt.txt').write_text(
            _prompt_note('default', cfg['aspect'], [color_path], prompt))


if __name__ == '__main__':
    main(sys.argv[1], force='--force' in sys.argv)
