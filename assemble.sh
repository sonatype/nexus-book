#!/bin/bash

rm -rf target/site/reference
rm -rf target/site/eval
rm -rf target/site/pdf

mkdir -p target/site/reference
mkdir -p target/site/eval
mkdir -p target/site/pdf

cp -r target/book-nexus.chunked/* target/site/reference
mkdir -p target/site/reference/css
cp -r site/css target/site/reference
cp -r site/assets target/site/reference
cp -r site/images target/site/reference

cp -r target/sonatype-nexus-eval-guide.chunked/* target/site/eval
mkdir -p target/site/eval/css
cp -r site/css target/site/eval
cp -r site/assets target/site/eval
cp -r site/images target/site/eval

cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
cp target/sonatype-nexus-eval-guide.pdf target/site/pdf/sonatype-nexus-eval-guide.pdf
python template.py
