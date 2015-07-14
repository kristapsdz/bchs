.SUFFIXES: .xml .html

PAGES		 = index.html start.html tools.html
CSSS		 = index.css start.css

www: $(PAGES)

.xml.html:
	cp -f $< $@

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 logo-white.png $(CSSS) $(PAGES) $(PREFIX)

clean:
	rm -f $(PAGES)
