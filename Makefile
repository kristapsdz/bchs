.SUFFIXES: .xml .html .dot .svg .gnuplot .png

PREFIX		?= /var/www/vhosts/kristaps.bsd.lv/htdocs/bchs
PAGES		 = index.html \
		   start.html \
		   tools.html \
		   easy.html \
		   json.html \
		   pledge.html \
		   kwebapp.html
CSSS		 = index.css \
		   start.css \
		   highlight.css \
		   highlight.light.css \
		   easy.css \
		   json.css \
		   pledge.css \
		   kwebapp.css
GENS		 = easy.c.xml \
		   highlight.css \
		   highlight.light.css \
		   easy.conf.xml \
		   easy.sh.xml \
		   json.c.xml \
		   json.json.xml \
		   json.xhtml.xml \
		   kwebapp.txt.xml \
		   kwebapp.db.c.html \
		   kwebapp.db.h.html \
		   kwebapp.db.js.html \
		   kwebapp.db.sql.html \
		   kwebapp.db.sqldiff.html \
		   kwebapp.main.c.html \
		   kwebapp.main1.c.xml \
		   kwebapp.main2.c.xml \
		   $(IMAGES)
IMAGES		 = pledge-fig1.svg \
		   pledge-fig2.svg \
		   pledge-fig3.png \
		   kwebapp-fig1.svg \
		   kwebapp-fig2.svg
THEMEDIR	 = /usr/local/share/highlight/themes
BUILT		 = arrow-left.png \
		   arrow-right-long.png \
		   arrow-right.png \
		   arrow-up.png \
		   arrow-down.png \
		   logo-white.png
HIGHLIGHT_FLAGS	 = -l --config-file=$(THEMEDIR)/biogoo.theme

www: $(PAGES) $(CSSS)

.xml.html:
	cp -f $< $@

.dot.svg:
	dot -Tsvg $< | xsltproc --novalid notugly.xsl - >$@

.gnuplot.png:
	gnuplot $<

pledge-fig3.png: pledge-fig3.dat

highlight.css:
	highlight $(HIGHLIGHT_FLAGS) --print-style -c $@

highlight.light.css:
	highlight -l --config-file=$(THEMEDIR)/github.theme --print-style -c $@

easy.html: easy.xml easy.c.xml easy.conf.xml easy.sh.xml
	sblg -s cmdline -t easy.xml -o $@ easy.c.xml easy.conf.xml easy.sh.xml

json.html: json.xml json.c.xml json.json.xml json.xhtml.xml
	sblg -s cmdline -t json.xml -o $@ json.c.xml json.json.xml json.xhtml.xml

json.xhtml.xml: json.xhtml
json.json.xml: json.json
json.c.xml: json.c
easy.c.xml: easy.c
easy.sh.xml: easy.sh
easy.conf.xml: easy.conf
kwebapp.txt.xml: kwebapp.txt

easy.c.xml easy.sh.xml easy.conf.xml json.c.xml json.json.xml json.xhtml.xml kwebapp.txt.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight $(HIGHLIGHT_FLAGS) -f --out-format=xhtml --enclose-pre `basename $@ .xml` >>$@
	echo '</article>' >>$@

kwebapp.db: kwebapp.db.c kwebapp.main.c kwebapp.db.h
	$(CC) -W -Wall $(CFLAGS) -I/usr/local/include -L/usr/local/lib -static -o $@ kwebapp.db.c kwebapp.main.c -lkcgi -lz -lksql -lsqlite3 -lpthreads

kwebapp.db.c.html: kwebapp.db.c
	highlight $(HIGHLIGHT_FLAGS) --src-lang=c kwebapp.db.c > $@

kwebapp.db.c: kwebapp.txt
	kwebapp -Ocsource -Fjson -Fvalids kwebapp.db.h kwebapp.txt > $@

kwebapp.db.h.html: kwebapp.db.h
	highlight $(HIGHLIGHT_FLAGS) --src-lang=c kwebapp.db.h > $@

kwebapp.db.h: kwebapp.txt
	kwebapp -Ocheader -Fjson -Fvalids kwebapp.txt > $@

kwebapp.db.sql.html: kwebapp.txt
	kwebapp -Osql kwebapp.txt | highlight $(HIGHLIGHT_FLAGS) --src-lang=sql > $@

kwebapp.db.sqldiff.html: kwebapp.txt
	kwebapp -Osqldiff kwebapp.old.txt kwebapp.txt | highlight $(HIGHLIGHT_FLAGS) --src-lang=sql > $@

kwebapp.db.js.html: kwebapp.txt
	kwebapp -Ojavascript kwebapp.txt | highlight $(HIGHLIGHT_FLAGS) --src-lang=js > $@

kwebapp.main.c.html: kwebapp.main.c
	highlight $(HIGHLIGHT_FLAGS) --src-lang=c kwebapp.main.c > $@

kwebapp.main1.c.xml: kwebapp.main.c
	echo '<article data-sblg-article="1">' >$@
	sed -n '212,225p' kwebapp.main.c |  highlight $(HIGHLIGHT_FLAGS) -f --out-format=xhtml --enclose-pre --src-lang=c >>$@
	echo '</article>' >>$@

kwebapp.main2.c.xml: kwebapp.main.c
	echo '<article data-sblg-article="1">' >$@
	sed -n '124,140p' kwebapp.main.c |  highlight $(HIGHLIGHT_FLAGS) -f --out-format=xhtml --enclose-pre --src-lang=c >>$@
	echo '</article>' >>$@

pledge.html: pledge-fig1.svg \
	pledge-fig2.svg \
	pledge-fig3.png

kwebapp.html: kwebapp-fig1.svg \
	kwebapp-fig2.svg \
	kwebapp.db.c.html \
	kwebapp.db.h.html \
	kwebapp.db.sql.html \
	kwebapp.db.sqldiff.html \
	kwebapp.db.js.html \
	kwebapp.main.c.html \
	kwebapp.main1.c.xml \
	kwebapp.main2.c.xml

kwebapp.html: kwebapp.xml kwebapp.txt.xml kwebapp.main1.c.xml kwebapp.main2.c.xml
	sblg -s cmdline -t kwebapp.xml -o $@ kwebapp.txt.xml kwebapp.main1.c.xml kwebapp.main2.c.xml

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 $(IMAGES) $(BUILT) $(CSSS) $(PAGES) $(PREFIX)

clean:
	rm -f $(PAGES) $(GENS) kwebapp.db.c kwebapp.db.h
