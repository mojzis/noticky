# CLAUDE.md

Noticky is a static site (noticky.eu, hosted on Netlify from `public/`) with easy-to-read piano sheet music for kids: note names inside the note heads (`\easyHeadsOn`), printable PDFs, and HTML pages that work on mobile.

## Commands

```sh
sudo pacman -S lilypond        # system dep, 2.26+
uv sync                        # python deps (pyvips[binary] bundles libvips)
mkdir -p log lilywork/score_only work/svg work/ogimg   # gitignored work dirs, must exist
uv run python do.py publish        # build everything into public/
uv run python do.py og-image-home  # homepage OG image (collage of the first 5 songs)
convert-ly -e lilysource/X.ly      # upgrade a source file to the installed lilypond version
```

There are no tests or linters.

## Build pipeline (`do.py`)

`publish` does this for each `lilysource/*.ly` (`*.lily` files are unfinished drafts and are skipped):

1. `load_songs()` pulls metadata out of the `.ly` text with **regexes**, so the source files have to keep a fixed shape:
   - `title = "..."` and `section = "..."` in `\header`. Section is `koledy` or `lidovky`.
   - `\score {` followed on the **next line** by `<<`, with the matching `>>` on its own line. This block is copied out to make the web SVG.
   - Extra verses go in a `\markup { \column { \line {...} } }` block. Each `\line {…}` becomes a lyrics line on the HTML page.
2. It compares each file's blake2b hash with `log/metadata.json`. **Only changed songs are re-engraved.**
3. For changed songs:
   - `prepare_svg` writes the score block into `lilywork/score_only/`, renders a cropped SVG with lilypond and saves it to `templates/heads/<name>.svg`. `song.html` inlines it with a Jinja `{% include %}`.
   - `prepare_png` + `generate_ogimage` make a cropped PNG and pad it to 1400×700 as `public/ogimg/<name>.png` using pyvips.
   - `generate_pdf` renders the full `.ly` into `public/lilyout/` (PDF, plus MIDI from `\midi {}`).
4. It always re-renders `public/songs/*.html`, `public/index.html` and `public/sitemap.txt` from `templates/`. `content/*.md` (frontmatter + mistune 3) becomes `public/<name>.html`.

Flags at the top of `do.py`: `KEEP_OLD_FILE = True` skips any output file that already exists, even when the song changed. `GENERATE_ANYWAY = True` ignores the hash check. **To force a full rebuild**, set `GENERATE_ANYWAY = True` and `KEEP_OLD_FILE = False`, then change them back.

Generated output (`public/`, `templates/heads/`) is committed; Netlify serves it as-is.

## Song conventions

Copy an existing `.ly` file (e.g. `skakal_pes.ly`) as the template: A4 landscape, `\easyHeadsOn`, lyrics in a `\new Lyrics \lyricsto "melody"`, `\layout` + `\midi {}` inside `\score`, `tagline = ##f`. Songs are mostly Czech. Some are transposed to C so beginners can play them.
