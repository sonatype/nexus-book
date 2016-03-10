#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# last folder needs to be nexus-book to reflect production setup
dest=$NEXUS_DOCUMENTATION/nexus-book
mkdir -p $dest

# load properties to be able to use them in here
source nexus-book.properties
echo "version set to $version"

function rsyncToDest {
    source=$1
    target=$dest/$2
    options=$3
    echo "Syncing $1 to $2 "
    mkdir -p $target
    rsync $options -av target/$source $target
}

if [ $publish_master == "true" ]; then
    rsyncToDest site/reference/ reference --delete
    rsyncToDest site/pdf/ pdf --delete
    rsyncToDest site/other/ other --delete
fi

rsyncToDest site/$version/reference/ $version/reference --delete
rsyncToDest site/$version/pdf/ $version/pdf --delete
rsyncToDest site/$version/other/ $version/other --delete
rsyncToDest site/$version/index.html $version --delete

if [ $publish_index == "true" ]; then
    rsyncToDest site/index.html  "" --delete
    rsyncToDest site/sitemap.xml "" --delete
    rsyncToDest site/sitemap-nexus-2.xml  "" --delete
    rsyncToDest site/sitemap-nexus-3.xml  "" --delete
    rsyncToDest site/js/ js --delete
    rsyncToDest site/images/ images --delete
    rsyncToDest site/css/ css --delete
    rsyncToDest site/sitemap.xml "" --delete
fi



