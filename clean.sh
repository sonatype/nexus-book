#!/bin/bash

# clean.sh 

# fail if anything errors
set -e
# fail if a function call is missing an argument
set -u

rm -rf figs/web/*.png
rm -rf target
echo "Cleaning up completed"