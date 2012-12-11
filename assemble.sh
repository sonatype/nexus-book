#!/bin/bash

rm -rf target/site/reference
rm -rf target/site/pdf


mkdir -p target/site/reference
mkdir -p target/site/pdf

cp -r target/book-nexus.chunked/* target/site/reference
mkdir -p target/site/reference/css
cp -r site/css/book.css target/site/reference/css

cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
python template.py
