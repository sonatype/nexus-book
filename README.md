The Nexus Book

Yep, this is it.  The Nexus Book, and, guess what?  The Nexus Book is
in an asciidoc format.  To edit asciidoc, use Emacs, use vi, use
TextMate, use Notepad.  There's really just a single file you need to
worry about:

* book-nexus.doc

Figures?  You want to add figures, look in the figs/web directory.
You'll see a lot of distracting files in that directory.  For now, you
should just ignore them.  Actually, in general, you'll notice a number
of distracting files in this project.  Really, just ignore them.  Once
I figure out this new reality, I'd like for this project to simple
contain content.

Q: Right, so how do you build the book?

A: I knew you'd ask that, and here's the simple answer:

. On an OSX/Ubuntu machine:

.. Install asciidoc

.. Install dblatex and the docbook xsl style sheets

.. Install python

.. run build.sh

. On a Windows/CentOS machine:

.. Don't bother.

. On a Solaris machine:

.. What's Solaris?

Q: That's an answer?

A: Yes.  Ideally someone will show up and tell us how to use https://github.com/schacon/git-scribe

Q: All this seems a bit creaky at the moment.  What happened?

A: I came to the realization that we needed a more nimble approach to all of our documentation.   From books to training to blogging, it was a pretty quick transition, but from this point forward - it's asciidoc or bust.
