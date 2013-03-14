#!/bin/bash

rm -rf target/site/reference
rm -rf target/site/eval
rm -rf target/site/pdf

mkdir -p target/site/reference
mkdir -p target/site/eval
mkdir -p target/site/pdf

cp -r target/book-nexus.chunked/* target/site/reference
mkdir -p target/site/reference/css
cp -r site/css/book.css target/site/reference/css

cp -r target/sonatype-nexus-eval-guide.chunked/* target/site/eval
mkdir -p target/site/eval/css
cp -r site/css/book.css target/site/eval/css

cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
cp target/sonatype-nexus-eval-guide.pdf target/site/pdf/sonatype-nexus-eval-guide.pdf
python template.py
