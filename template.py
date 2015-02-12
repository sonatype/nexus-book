import airspeed
import glob
import os
import argparse

parser = argparse.ArgumentParser(description='Script to wrap produces html into template for site deployment')
parser.add_argument('-p','--path',help='Path in which to do the replacement', required=True)
parser.add_argument('-t','--toindex',help='Relative path reference to the index for navigation', required=True)
# defaults to invisible for search and index pages to work ok
parser.add_argument('-s','--searchdisplay',help='CSS display style value for the search box, defaults to none (=invisible)', required=False)
parser.add_argument('-b','--body',help='Body open tag', required=False)
parser.add_argument('-v','--version',help='The version of Nexus the documents are for', required=True)


args = parser.parse_args()
path = args.path
bodyTag = args.body
toindex = args.toindex
searchdisplay = args.searchdisplay
version = args.version

if not bodyTag:
  bodyTag = "<body>"

if not searchdisplay:
  searchdisplay = "none"

bookTitle = "Repository Management with Nexus"
googleSearchToken = "011059148005191787079:jycarnaj42w"

print ("Applying template processing to ") + path
print ("  Path to index set to: ") + toindex


for infile in glob.glob( os.path.join(path, '*.html') ):
  print "  Reading File: " + infile
  body = open(infile, "r").read()
  if infile.endswith( 'search.html'):
    t = airspeed.Template(open("site/search.html", "r").read())
    print( "  search.html replacements" )
    body = body.replace(bookTitle, title)
  else:
    t = airspeed.Template(open("site/book-template.html", "r").read())
    title = body[ body.index( "<title>" ) + 7 : body.rindex("</title>") ]
    body = body[ body.index( bodyTag) + len(bodyTag) : body.rindex("</body>") ]

    if "index.html" in infile:
      print ("  Replacing bookTitle  - replacing with ToC" )
      title = "Table of Contents"
      body = body.replace(bookTitle, title)

  open(infile, "w").write( t.merge(locals()) );
