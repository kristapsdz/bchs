.SUFFIXES: .xml .html

PREFIX		?= /var/www/vhosts/kristaps.bsd.lv/htdocs/bchs
PAGES		 = index.html start.html tools.html easy.html
CSSS		 = index.css start.css highlight.css easy.css
GENS		 = easy.c.xml highlight.css easy.conf.xml easy.sh.xml
THEMEDIR	 = /usr/local/share/highlight/themes
HIGHLIGHT_FLAGS	 = -l --config-file=$(THEMEDIR)/biogoo.theme

www: $(PAGES) $(CSSS)

.xml.html:
	cp -f $< $@

highlight.css:
	highlight $(HIGHLIGHT_FLAGS) --print-style -c $@

easy.html: easy.xml easy.c.xml easy.conf.xml easy.sh.xml
	sblg -s cmdline -t easy.xml -o $@ easy.c.xml easy.conf.xml easy.sh.xml

easy.c.xml: easy.c
easy.sh.xml: easy.sh
easy.conf.xml: easy.conf

easy.c.xml easy.sh.xml easy.conf.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight $(HIGHLIGHT_FLAGS) -f --out-format=xhtml --enclose-pre `basename $@ .xml` >>$@
	echo '</article>' >>$@

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 logo-white.png $(CSSS) $(PAGES) $(PREFIX)

clean:
	rm -f $(PAGES) $(GENS)
