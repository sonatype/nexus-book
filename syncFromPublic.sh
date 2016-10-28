#!/bin/bash

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

git remote rm public
git remote add public git@github.com:sonatype/nexus-book.git

function sync {
    branch=$1
    git checkout $branch
    git pull public $branch
    git push origin $branch
}


sync master
sync nexus-3.1.x
sync nexus-3.0.x
sync nexus-2.13.x
sync nexus-2.12.x
sync nexus-2.11.x
sync nexus-2.10.x
sync nexus-2.9.x
sync nexus-2.8.x
sync nexus-2.7.x