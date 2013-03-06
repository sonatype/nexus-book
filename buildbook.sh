#!/bin/bash
set -e

a2x --no-xmllint -v -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts=" --param=doc.lot.show=figure,table -P latex.output.revhistory=0 -P doc.publisher.show=0 -s ./latex/custom-docbook.sty" -D target book-nexus.asciidoc

#gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf pdf/nexus-book-cover.pdf pdf/title-page.pdf pdf/blank-page.pdf target/book-nexus.pdf

#gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf target/book-nexus.pdf

#mv target/tmp.pdf target/book-nexus.pdf

# Build the Chunked HTML
a2x -v -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 3" -dbook --dblatex-opts=" -P latex.output.revhistory=0 -P doc.publisher.show=0" -D target book-nexus.asciidoc