#!/bin/bash

# Create the tex directory if it doesn't exist
mkdir -p tex

# Convert text files to LaTeX with UTF-8 encoding
pandoc --from=markdown --to=latex --output=tex/output.tex text/*.txt

# Create a temporary LaTeX file with correct encoding and font settings
echo '\documentclass{article}' > temp.tex
echo '\usepackage[utf8]{inputenc}' >> temp.tex
echo '\usepackage{libertine}' >> temp.tex  # Use Liberation font package
echo '\renewcommand*\familydefault{\ttdefault}' >> temp.tex  # Set as default typewriter font
cat tex/output.tex >> temp.tex

# Compile the PDF using pdflatex
pdflatex -output-directory=tex temp.tex

# Clean up temporary files
rm temp.tex

