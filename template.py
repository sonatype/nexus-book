import airspeed
import glob
import os
import argparse

parser = argparse.ArgumentParser(description='Script to wrap produces html into template for site deploymenta')
parser.add_argument('-p','--path',help='Path in which to do the replacement', required=True)
args = parser.parse_args()
path = args.path

bookTitle = "Repository Management with Nexus"
bookId = "ss-book-nxbook"


t = airspeed.Template(open("site/book-template.html", "r").read())
for infile in glob.glob( os.path.join(path, '*.html') ):
  print "Reading File: " + infile
  body = open(infile, "r").read()
  title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]
  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]

  if "index.html" in infile:
    print ("Replacing bookTitle  - replacing with ToC" )
    title = "Table of Contents"
    body = body.replace(bookTitle, title)

  open(infile, "w").write( t.merge(locals()) );
