#!/bin/bash

# assemble.sh processes the output files created by build.sh and prepares
# the folders target/site and target/archive for rsync runs to
# staging and production

# see build.sh
# see deploy-to-prodcution.sh
# see deploy-to-staging.sh
# see deploy-locally.sh

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "Processing in ${dir}"

templateScript=../nexus-documentation-wrapper/apply-template.sh
docProperties=$dir/book.properties
source $docProperties

echo "Nexus Repository Manager Version $version"

if [ $publish_master == "true" ]; then
    echo "Preparing for master deployment"
    rm -rf target/site/reference
    rm -rf target/site/pdf
    rm -rf target/site/other
    mkdir -p target/site/reference
    mkdir -p target/site/pdf
    mkdir -p target/site/other 
fi

echo "Preparing for version $version deployment"
rm -rf target/site/$version/reference
rm -rf target/site/$version/pdf
rm -rf target/site/$version/other
mkdir -p target/site/$version/reference
mkdir -p target/site/$version/pdf
mkdir -p target/site/$version/other

if [ $publish_master == "true" ]; then
    echo "Copying for master deployment"
    cp -r target/book-nexus.chunked/*  target/site/reference
    cp target/book-nexus.pdf target/site/pdf/nxbook-pdf.pdf
    cp target/sonatype-nexus-eval-guide.pdf target/site/pdf/sonatype-nexus-eval-guide.pdf
    cp target/book-nexus.epub target/site/other/nexus-book.epub
fi

echo "Copying for version $version deployment"

# NOT copying the overall index into version specific directories since links would be broken and 
# it is an overall index
cp -r target/book-nexus.chunked/* target/site/$version/reference
cp target/book-nexus.pdf target/site/$version/pdf/nxbook-pdf.pdf
cp target/sonatype-nexus-eval-guide.pdf target/site/$version/pdf/sonatype-nexus-eval-guide.pdf
cp target/book-nexus.epub target/site/$version/other/nexus-book.epub
echo "Copying redirector"
cp -v site/global/index.html target/site/$version/

if [ $publish_master == "true" ]; then
echo "Invoking templating process for master"
$templateScript $dir/target/site/reference $docProperties "block" "../../" "book"
fi

echo "Invoking templating process for $version "
$templateScript $dir/target/site/$version/reference $docProperties "block" "../../../" "book"

if [ $publish_index == "true" ]; then
    echo "Preparing root index for deployment"
    echo "  Copying content and resources"
    cp target/index.html target/site
    echo "Invoking templating for index page"
    $templateScript $dir/target/site/ $docProperties "none" "../" "article"
    cp -rv site/global/sitemap*.xml target/site
    echo "... done"
fi
