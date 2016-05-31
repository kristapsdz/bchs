.SUFFIXES: .xml .html

PREFIX		?= /var/www/vhosts/kristaps.bsd.lv/htdocs/bchs
PAGES		 = index.html start.html tools.html easy.html
CSSS		 = index.css start.css highlight.css
GENS		 = easy.c.xml highlight.css easy.conf.xml easy.sh.xml

www: $(PAGES) $(CSSS)

.xml.html:
	cp -f $< $@

highlight.css:
	highlight --print-style -c $@

easy.html: easy.xml easy.c.xml easy.conf.xml easy.sh.xml
	sblg -t easy.xml -o $@ easy.c.xml easy.conf.xml easy.sh.xml

easy.c.xml easy.sh.xml easy.conf.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight -f --out-format=xhtml --enclose-pre `basename $@ .xml` >>$@
	echo '</article>' >>$@

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 logo-white.png $(CSSS) $(PAGES) $(PREFIX)

clean:
	rm -f $(PAGES) $(GENS)
