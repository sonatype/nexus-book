#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

# load properties to be able to use them in here
source nexus-book.properties

echo "nexus_version set to $nexus_version"

if [ $publish_master == "true" ]; then
    echo "Preparing for master deployment"
    rm -rf target/site/reference
    rm -rf target/site/pdf
    mkdir -p target/site/reference
    mkdir -p target/site/pdf
fi

echo "Preparing for version $nexus_version deployment"
rm -rf target/site/$nexus_version/reference
rm -rf target/site/$nexus_version/pdf
mkdir -p target/site/$nexus_version/reference
mkdir -p target/site/$nexus_version/pdf

if [ $publish_master == "true" ]; then
    echo "Copying for master deployment"
    cp -r target/book-nexus.chunked/* target/site/reference
    mkdir -p target/site/reference/css
    cp -r site/css target/site/reference
    cp -r site/js target/site/reference
    cp -r site/assets target/site/reference
    cp -r site/images target/site/reference
    cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
    cp target/sonatype-nexus-eval-guide.pdf target/site/pdf/sonatype-nexus-eval-guide.pdf

fi

echo "Copying for version $nexus_version deployment"

cp -r target/book-nexus.chunked/* target/site/$nexus_version/reference
mkdir -p target/site/$nexus_version/reference/css
cp -r site/css target/site/$nexus_version/reference
cp -r site/js target/site/$nexus_version/reference
cp -r site/assets target/site/$nexus_version/reference
cp -r site/images target/site/$nexus_version/reference

cp target/book-nexus.pdf target/site/$nexus_version/pdf/nxbook-pdf.pdf
cp target/sonatype-nexus-eval-guide.pdf target/site/$nexus_version/pdf/sonatype-nexus-eval-guide.pdf



python template.py -p "target/site/reference"
python template.py -p "target/site/$nexus_version/reference"