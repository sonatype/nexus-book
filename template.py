import airspeed
import glob
import os

t = airspeed.Template(open("site/book-template.html", "r").read())
bookTitle = "Repository Management with Nexus"
bookId = "nxbook"
 
path = 'target/site/reference'
for infile in glob.glob( os.path.join(path, '*.html') ):
  body = open(infile, "r").read()
  body = body[ body.index( "<body>") + 6 : body.rindex("</body>") ]
  title = "Repository Management with Nexus"
  open(infile, "w").write( t.merge(locals()) );
