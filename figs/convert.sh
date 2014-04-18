#!/bin/bash

# Convert Originals to Web Images
for IMAGE in `find ./orig -name "*.png"`
do
 DEST_IMAGE=./web/`basename $IMAGE`
 if [[ ! -e $DEST_IMAGE || $IMAGE -nt $DEST_IMAGE ]] 
 then
# Old way of converting making a drop shadow
#     convert $IMAGE -compress jpeg \
#            -quality 80 -bordercolor None -border 3x3 \
#            \( +clone -background black -shadow 80x1+1+1 \) \
#            -compose DstOver -composite -compose Over \
#            $DEST_IMAGE
      convert -border 3 -bordercolor '#696969' $IMAGE $DEST_IMAGE
      echo "Converted $IMAGE creating $DEST_IMAGE"
 fi
done

exit 0





