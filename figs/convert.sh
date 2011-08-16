#!/bin/bash

# Convert Originals to Web Images
for IMAGE in `find ./orig -name "*.png"`
do
 DEST_IMAGE=./web/`basename $IMAGE`
 if [[ ! -e $DEST_IMAGE || $IMAGE -nt $DEST_IMAGE ]] 
 then
     convert $IMAGE -verbose -compress jpeg \
            -quality 80 -bordercolor None -border 10x10 \
            \( +clone -background black -shadow 80x3+5+5 \) \
            -compose DstOver -composite -compose Over \
            $DEST_IMAGE
 fi
done

exit 0





