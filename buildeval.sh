#!/bin/bash
set -e

./prepare.sh

# Build eval guide
a2x --no-xmllint -v -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts=" --param=doc.lot.show=figure,table -P latex.output.revhistory=0 -P doc.publisher.show=0 -s ./latex/custom-docbook.sty" -D target sonatype-nexus-eval-guide.asciidoc

a2x -v -k -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 3" -dbook --dblatex-opts=" -P latex.output.revhistory=0 -P doc.publisher.show=0" -D target sonatype-nexus-eval-guide.asciidoc