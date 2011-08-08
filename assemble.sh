#!/bin/bash

mkdir -p target/site/reference
mkdir -p target/site/pdf
cp -r target/book-nexus.chunked/* target/site/reference
cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
python template.py
rsync -e ssh -av target/site/* deployer@www.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/nexus-book/
