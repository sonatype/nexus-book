#!/bin/bash
set -e

cd figs
./convert.sh
cd ..

mkdir -p target/images
mkdir -p target/figs

# Build the Single HTML Page Version
asciidoc -o target/book-nexus.html book-nexus.asciidoc 

# Build the PDF
rm -rf target/images
rm -rf target/figs
rm -rf target/promo_*.*
cp -r figs target
cp -r images target
cp -r promos/* target

# Build eval guide
a2x --no-xmllint -v -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts=" --param=doc.lot.show=figure,table -P latex.output.revhistory=0 -s ./latex/custom-docbook.sty" -D target eval-guide.asciidoc

a2x -v -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 3" -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target eval-guide.asciidoc