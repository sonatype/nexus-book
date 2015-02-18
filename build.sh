#!/bin/bash
# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

./prepare.sh

echo "Building pdf version of book"
a2x -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts="-P toc.section.depth=0 -P latex.output.revhistory=0 -P doc.publisher.show=0 -s ./latex/custom-docbook.sty" -D target book-nexus.asciidoc

#gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf pdf/nexus-book-cover.pdf pdf/title-page.pdf pdf/blank-page.pdf target/book-nexus.pdf
#gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf target/book-nexus.pdf
#mv target/tmp.pdf target/book-nexus.pdf

echo "Building epub version of book"
a2x -fepub -D target book-nexus.asciidoc
echo "done"

echo "Building multi page html version of book"
# Build the Chunked HTML
a2x -k -a promo -fchunked --icons --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 1" -dbook --dblatex-opts=" -P doc.lot.show=  -P latex.output.revhistory=0 -P doc.publisher.show=0" -D target book-nexus.asciidoc
echo "done"

echo "Building pdf version of eval guide"
# Build eval guide
a2x  -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts="-P toc.section.depth=0 -P doc.lot.show=  -P latex.output.revhistory=0 -P doc.publisher.show=0 -s ./latex/custom-docbook.sty" -D target sonatype-nexus-eval-guide.asciidoc
echo "done"

echo "Building multi page html version of eval guide"
a2x  -k -a promo -fchunked --xsl-file=docbook-xsl/custom-chunked.xsl --xsltproc-opts "--stringparam chunk.section.depth 1 --stringparam toc.section.depth 1" -dbook --dblatex-opts=" -P doc.lot.show=  -P latex.output.revhistory=0 -P doc.publisher.show=0" -D target sonatype-nexus-eval-guide.asciidoc
echo "done"