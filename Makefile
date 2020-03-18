.SUFFIXES: .xml .html .dot .svg .gnuplot .png .c.xml

PREFIX		?= /var/www/vhosts/kristaps.bsd.lv/htdocs/bchs
DOCLEAN		 =
DOCLEANDIR	 =
DOINSTALL	 =
DOINSTALLDIR	 =
PAGES		 = auditing.html \
		   easy.html \
		   index.html \
		   json.html \
		   ksql.html \
		   kwebapp.html \
		   pledge.html \
		   portability.html \
		   rbac.html \
		   sqlbox.html \
		   tools.html \
		   translate.html \
		   typescript.html
CSSS		 = audit.css \
		   index.css \
		   highlight.css \
		   tools.css
GENS		 = highlight.css \
		   $(FAVICONS)
FAVICONS	 = favicon.ico \
		   favicon-196x196.png
BUILT		 = audit.js \
		   arrow-left.png \
		   arrow-right-long.png \
		   arrow-right.png \
		   arrow-up.png \
		   arrow-down.png \
		   background.jpg \
		   background-white.jpg \
		   puffy.png \
		   logo-blue.png \
		   logo-white.png \
		   sqlite.png

www: $(FAVICONS) $(PAGES)

include Makefile-easy
include Makefile-ksql
include Makefile-json
include Makefile-openradtool
include Makefile-pledge
include Makefile-portability
include Makefile-rbac
include Makefile-sqlbox

$(PAGES): highlight.css

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 $(DOINSTALL) $(BUILT) $(CSSS) $(PAGES) $(PREFIX)
	install -m 0444 $(FAVICONS) robots.txt sitemap.xml $(PREFIX)
	for f in $(DOINSTALLDIR) ; \
	do \
		tar cf - $$f | tar -xf - -C $(PREFIX) ; \
	done

clean:
	rm -f $(PAGES) $(GENS)
	rm -rf $(DOCLEANDIR)
	rm -f $(DOCLEAN)

.c.c.xml:
	( echo '<article data-sblg-article="1">' ; \
	  highlight -lf --out-format=xhtml --enclose-pre --src-lang=c $< ; \
	  echo '</article>' ; ) >$@

.xml.html:
	cp -f $< $@

.dot.svg:
	dot -Tsvg $< | xsltproc --novalid notugly.xsl - >$@

.gnuplot.png:
	gnuplot $<

highlight.css: github.theme
	highlight -O html --print-style --css $@ --config-file=github.theme

favicon-196x196.png: favicon.png
	convert favicon.png -resize 196 $@

favicon.ico: favicon.png
	convert favicon.png -resize 32 favicon-32x32.png
	convert favicon.png -resize 48 favicon-48x48.png
	convert favicon.png -resize 64 favicon-64x64.png
	convert favicon.png -resize 128 favicon-128x128.png
	convert favicon-32x32.png favicon-48x48.png favicon-64x64.png favicon-128x128.png $@
	rm -f favicon-32x32.png favicon-48x48.png favicon-64x64.png favicon-128x128.png
