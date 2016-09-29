#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

# load properties to be able to use them in here
source book.properties

echo "version set to $version"

function rsyncToDest {
    source=$1
    target=/var/www/domains/sonatype.com/www/shared/books/nexus-book/$2
    options=$3
    connection=deployer@marketing01.int.sonatype.com
    echo "Uploading $1 to $2 on $connection"
    ssh $connection mkdir -pv $target
    rsync -e ssh $options -av target/$source/ $connection:$target
}

if [ $publish_master == "true" ]; then
    rsyncToDest site/reference/ reference --delete
    rsyncToDest site/pdf/ pdf --delete
    rsyncToDest site/other/ other --delete
fi

if [ $publish_index == "true" ]; then
    rsyncToDest site/index.html  "" --delete
    rsyncToDest site/sitemap.xml  "" --delete
    rsyncToDest site/sitemap-nexus-2.xml  "" --delete
    rsyncToDest site/sitemap-nexus-3.xml  "" --delete
    rsyncToDest site/js/ js --delete
    rsyncToDest site/images/ images --delete
    rsyncToDest site/css/ css --delete
fi

rsyncToDest site/$version/ $version --delete

# Important to use separate rsync run WITHOUT --delete since its an archive! and we do NOT want old archives to be deleted
#rsyncToDest archive/ archive ""



