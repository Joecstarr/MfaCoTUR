@_default:
    just --list

# Set up development environment
bootstrap:
    uv venv
    uv pip install -r requirements.txt

# Build course design docs
[working-directory: 'course_planning']
design:
    myst clean --all -y
    myst init --write-toc
    myst build ./course_design.md
    cp -r materials ./_build/exports/materials
    just rename

# Rename files: .doc -> .docx
rename:
    find . -iname "*.doc" -exec sh -c 'mv "${1}" "${1%.*}.docx" ' sh {} \;

# This will only work for how I (@joecstarr) have zotero set up.
bib:
    curl http://127.0.0.1:23119/better-bibtex/export/collection?/4/LFR2PSPL.biblatex > ./refs.bib

# Build all the things.
all:
    just design
