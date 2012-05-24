#!/bin/bash

cd figs
./convert.sh
cd ..

mkdir -p target/images
mkdir -p target/figs

# Build the Single HTML Page Version
asciidoc -o target/book-nexus.html book-nexus.doc 

# Build the PDF
rm -rf target/images
rm -rf target/figs
cp -r figs target
cp -r images target

a2x --no-xmllint -v -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts=" -P latex.output.revhistory=0 -s ./latex/custom-docbook.sty" -D target book-nexus.doc

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf pdf/nexus-book-cover.pdf pdf/title-page.pdf pdf/blank-page.pdf target/book-nexus.pdf

mv target/tmp.pdf target/book-nexus.pdf

# Build the Chunked HTML
a2x -v -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1" -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target book-nexus.doc
