#!/bin/bash
set -e

echo "Converting images"
cd figs
./convert.sh
cd ..

mkdir -p target/images
mkdir -p target/figs

# Build the Single HTML Page Version
echo "Building single page html book" 
asciidoc -o target/book-nexus.html book-nexus.asciidoc 

echo "Preparing output folders"
rm -rf target/images
rm -rf target/figs
rm -rf target/promo_*.*
cp -r figs target
cp -r images target
cp -r promos/* target