#!/bin/sh

# Convert Originals to Web Images
find ./orig -name "*.png" | \
 xargs -n1 \
   sh -c 'convert $0 -verbose -compress jpeg \
            -quality 80 -bordercolor None -border 10x10 \
            \( +clone -background black -shadow 80x3+5+5 \) \
            -compose DstOver -composite -compose Over \
            ./web/`basename $0`'

# Convert Originals to Print Images
find ./orig -name "*.png" | \
 xargs -n1 \
   sh -c 'convert $0 -resize 250% -compress jpeg \
            -quality 50 -density 150 -verbose \
            -bordercolor None -border 10x10 \
            \( +clone -background black -shadow 80x3+5+5 \) \
            -compose DstOver -composite -compose Over \
            ./print/`basename $0 .png`.pdf'

exit 0





