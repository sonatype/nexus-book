#!/bin/sh

# Convert Originals to Web Images
CONVERT_OPTS=" -verbose -bordercolor None -border 10x10 \( +clone -background black -shadow 80x3+5+5 \) -compose DstOver -composite -compose Over ";
find ./orig -name "*.png" | tee orig_png.tmp | sed -e 's/orig/web/g' | xargs -L1 echo $CONVERT_OPTS > command.tmp
paste orig_png.tmp command.tmp | xargs -L1 echo "convert " | sed -e 's/(/\\(/g' | sed -e 's/)/\\)/g' > orig_web.tmp
sh ./orig_web.tmp

# Convert Originals to Print Images
CONVERT_OPTS=" -resize 250% -density 150 -verbose -bordercolor None -border 10x10 \( +clone -background black -shadow 80x3+5+5 \) -compose DstOver -composite -compose Over ";
find ./orig -name "*.png" | tee orig_png.tmp | sed -e 's/orig/print/g' | sed -e 's/png/pdf/g' | xargs -L1 echo $CONVERT_OPTS > command.tmp
paste orig_png.tmp command.tmp | xargs -L1 echo "convert " | sed -e 's/(/\\(/g' | sed -e 's/)/\\)/g' > orig_print.tmp
sh ./orig_print.tmp




