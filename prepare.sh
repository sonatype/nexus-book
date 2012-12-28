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