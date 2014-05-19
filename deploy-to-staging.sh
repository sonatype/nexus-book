#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

# load properties to be able to use them in here
source nexus-book.properties

echo "nexus_version set to $nexus_version"

# can we get rid of this? 
./assemble.sh

function rsyncToStage {
    source=$1
    target=$2
    options=$3
    echo "Uploading $1 to $2"
    ssh deployer@marketing02.int.sonatype.com mkdir -pv /var/www/domains/sonatype.com/www/shared/books/nexus-book/$target
    rsync -e ssh $options -av target/$source/ deployer@marketing02.int.sonatype.com:/var/www/domains/sonatype.com/www/shared/books/nexus-book/$target
}

if [ $publish_master == "true" ]; then
    rsyncToStage site/reference/ reference --delete
    rsyncToStage site/pdf/ pdf --delete
fi

# making directory for specific version
ssh deployer@marketing02.int.sonatype.com mkdir -p /var/www/domains/sonatype.com/www/shared/books/nexus-book/$nexus_version

rsyncToStage site/$nexus_version/reference/ $nexus_version/reference --delete
rsyncToStage site/$nexus_version/pdf/ $nexus_version/pdf --delete

# Important to use separate rsync run WITHOUT --delete since its an archive! and we do NOT want old archives to be deleted
#rsyncToStage archive/ archive

