#!/bin/sh

# Assemble and preprocess all the source files
for filename in text/ch*.txt; do
    [ -e "$filename" ] || continue
    pandoc --lua-filter=lua/labs.lua --lua-filter=lua/Pro.lua "$filename" --to markdown |
        pandoc --top-level-division=chapter --citeproc --to latex > "latex/$(basename "$filename" .txt).tex"
done

# Compile the book
pandoc -s latex/*.tex -o guide.tex
pandoc -N --quiet --variable "geometry=margin=1.2in" \
    --variable mainfont="Noto Sans Thin" \
    --variable sansfont="Noto Sans Thin" \
    --variable monofont="Noto Sans Thin" \
    --variable fontsize=12pt \
    --variable version=2.0 guide.tex \
    --pdf-engine=xelatex --toc -o guide.pdf
