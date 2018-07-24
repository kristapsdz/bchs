.SUFFIXES: .xml .html .dot .svg .gnuplot .png .c.xml

PREFIX		?= /var/www/vhosts/kristaps.bsd.lv/htdocs/bchs
PAGES		 = auditing.html \
		   easy.html \
		   index.html \
		   json.html \
		   ksql.html \
		   kwebapp.html \
		   pledge.html \
		   rbac.html \
		   tools.html
CSSS		 = audit.css \
		   easy.css \
		   index.css \
		   json.css \
		   ksql.css \
		   kwebapp.css \
		   pledge.css \
		   rbac.css \
		   style.css \
		   tools.css
GENS		 = auditing-fig4.xml \
		   auditing-fig5.xml \
		   auditing-fig6.xml \
		   auditing-fig9.xml \
		   easy.c.xml \
		   style.css \
		   easy.conf.xml \
		   easy.sh.xml \
		   json.c.xml \
		   json.json.xml \
		   json.xhtml.xml \
		   kwebapp.txt.xml \
		   kwebapp.main1.c.xml \
		   kwebapp.main2.c.xml \
		   ksql-fig1.c.xml \
		   ksql-fig2.c.xml \
		   ksql-fig4.c.xml \
		   ksql-fig5.c.xml \
		   $(GENHTMLS) \
		   $(IMAGES)
GENHTMLS	 = audit-out.js \
		   kwebapp.db.c.html \
		   kwebapp.db.h.html \
		   kwebapp.db.js.html \
		   kwebapp.db.sql.html \
		   kwebapp.db.sqldiff.html \
		   kwebapp.main.c.html \
		   rbac-ex1.c.html \
		   rbac-ex1.h.html \
		   rbac-ex2.c.html \
		   rbac-ex2.h.html
IMAGES		 = auditing-fig1.svg \
		   auditing-fig2.svg \
		   auditing-fig3.svg \
		   auditing-fig8.svg \
		   pledge-fig1.svg \
		   pledge-fig2.svg \
		   pledge-fig3.png \
		   ksql-fig3.svg \
		   ksql-fig6.svg \
		   kwebapp-fig1.svg \
		   kwebapp-fig2.svg \
		   rbac-fig1.svg \
		   rbac-fig2.svg \
		   rbac-fig3.svg \
		   rbac-fig4.svg
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

www: $(PAGES) 

.xml.html:
	cp -f $< $@

.dot.svg:
	dot -Tsvg $< | xsltproc --novalid notugly.xsl - >$@

.gnuplot.png:
	gnuplot $<

pledge-fig3.png: pledge-fig3.dat

easy.html: easy.xml easy.c.xml easy.conf.xml easy.sh.xml
	sblg -s cmdline -t easy.xml -o $@ easy.c.xml easy.conf.xml easy.sh.xml

json.html: json.xml json.c.xml json.json.xml json.xhtml.xml
	sblg -s cmdline -t json.xml -o $@ json.c.xml json.json.xml json.xhtml.xml

json.xhtml.xml: json.xhtml
json.json.xml: json.json
easy.sh.xml: easy.sh
easy.conf.xml: easy.conf
kwebapp.txt.xml: kwebapp.txt

easy.sh.xml easy.conf.xml json.json.xml json.xhtml.xml kwebapp.txt.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight -l -f --out-format=xhtml --enclose-pre `basename $@ .xml` >>$@
	echo '</article>' >>$@

kwebapp.db: kwebapp.db.c kwebapp.main.c kwebapp.db.h
	$(CC) -W -Wall $(CFLAGS) -I/usr/local/include -L/usr/local/lib -static -o $@ kwebapp.db.c kwebapp.main.c -lkcgi -lz -lksql -lsqlite3 -lpthreads

kwebapp.db.c.html: kwebapp.db.c
	highlight --config-file=github.theme -l --css=style.css --src-lang=c kwebapp.db.c > $@

kwebapp.db.c: kwebapp.txt
	kwebapp-c-source -vj -h kwebapp.db.h kwebapp.txt > $@

kwebapp.db.h.html: kwebapp.db.h
	highlight --config-file=github.theme -l --css=style.css --src-lang=c kwebapp.db.h > $@

kwebapp.db.h: kwebapp.txt
	kwebapp-c-header -vj kwebapp.txt > $@

kwebapp.db.sql.html: kwebapp.txt
	kwebapp-sql kwebapp.txt | highlight --config-file=github.theme -l --css=style.css --src-lang=sql > $@

kwebapp.db.sqldiff.html: kwebapp.txt
	kwebapp-sqldiff kwebapp.old.txt kwebapp.txt | highlight --config-file=github.theme -l --css=style.css --src-lang=sql > $@

kwebapp.db.js.html: kwebapp.txt
	kwebapp-javascript kwebapp.txt | highlight --config-file=github.theme -l --css=style.css --src-lang=js > $@

kwebapp.main.c.html: kwebapp.main.c
	highlight --config-file=github.theme -l --css=style.css --src-lang=c kwebapp.main.c > $@

kwebapp.main1.c.xml: kwebapp.main.c
	echo '<article data-sblg-article="1">' >$@
	sed -n '212,225p' kwebapp.main.c |  highlight -l -f --out-format=xhtml --enclose-pre --src-lang=c >>$@
	echo '</article>' >>$@

kwebapp.main2.c.xml: kwebapp.main.c
	echo '<article data-sblg-article="1">' >$@
	sed -n '124,140p' kwebapp.main.c |  highlight -l -f --out-format=xhtml --enclose-pre --src-lang=c >>$@
	echo '</article>' >>$@

rbac-ex1.h.html: rbac-ex1.txt
	kwebapp-c-header -vj rbac-ex1.txt | \
		highlight --config-file=github.theme -l --css=style.css --src-lang=c >$@

rbac-ex1.c.html: rbac-ex1.txt
	kwebapp-c-source -vj -h rbac-ex1.h rbac-ex1.txt | \
		highlight --config-file=github.theme -l --css=style.css --src-lang=c >$@

rbac-ex2.h.html: rbac-ex2.txt
	kwebapp-c-header -vj rbac-ex2.txt | \
		highlight --config-file=github.theme -l --css=style.css --src-lang=c >$@

rbac-ex2.c.html: rbac-ex2.txt
	kwebapp-c-source -vj -h rbac-ex2.h rbac-ex2.txt | \
		highlight --config-file=github.theme -l --css=style.css --src-lang=c >$@

pledge.html: pledge-fig1.svg \
	pledge-fig2.svg \
	pledge-fig3.png

auditing-fig4.xml auditing-fig5.xml: auditing-fig4.conf

auditing-fig4.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight -l -f --out-format=xhtml --enclose-pre auditing-fig4.conf >>$@
	echo '</article>' >>$@

auditing-fig5.xml:
	echo '<article data-sblg-article="1">' >$@
	kwebapp-c-header -s auditing-fig4.conf 2>/dev/null | \
		sed '1,11d' | head -n30 | \
		highlight -l -f --out-format=xhtml --enclose-pre -S c >>$@
	echo '</article>' >>$@

auditing-fig6.xml:
	echo '<article data-sblg-article="1">' >$@
	diff -u auditing-fig4.conf auditing-fig6.conf | \
		highlight -l -f --out-format=xhtml --enclose-pre -S diff >>$@
	echo '</article>' >>$@

auditing-fig9.xml:
	echo '<article data-sblg-article="1">' >$@
	diff -u auditing-fig6.conf auditing-fig8.conf | \
		highlight -l -f --out-format=xhtml --enclose-pre -S diff >>$@
	echo '</article>' >>$@

AUDIT_DEPS  = auditing-fig4.xml \
	      auditing-fig5.xml \
	      auditing-fig6.xml \
	      auditing-fig7.xml \
	      auditing-fig9.xml

AUDIT_MEDIA = audit-out.js \
	      auditing-fig1.svg \
	      auditing-fig2.svg \
	      auditing-fig3.svg \
	      auditing-fig8.svg 

audit-out.js: auditing-fig6.conf
	kwebapp-audit-json user auditing-fig6.conf > $@

auditing-fig8.svg: auditing-fig8.conf
	kwebapp-audit-gv default auditing-fig8.conf | dot -Tsvg -o$@

auditing.html: auditing.xml $(AUDIT_DEPS) $(AUDIT_MEDIA)
	sblg -s cmdline -t auditing.xml -o $@ $(AUDIT_DEPS)

KWEB_MEDIA = kwebapp-fig1.svg \
	     kwebapp-fig2.svg \
	     kwebapp.db.c.html \
	     kwebapp.db.h.html \
	     kwebapp.db.sql.html \
	     kwebapp.db.sqldiff.html \
	     kwebapp.db.js.html \
	     kwebapp.main.c.html
KWEB_DEPS  = kwebapp.txt.xml \
	     kwebapp.main1.c.xml \
	     kwebapp.main2.c.xml
RBAC_MEDIA = rbac-ex1.h.html \
	     rbac-ex1.c.html \
	     rbac-ex2.h.html \
	     rbac-ex2.c.html \
	     rbac-fig1.svg \
	     rbac-fig2.svg \
	     rbac-fig3.svg \
	     rbac-fig4.svg
KSQL_MEDIA = ksql-fig3.svg \
	     ksql-fig6.svg
KSQL_DEPS  = ksql-fig1.c.xml \
	     ksql-fig2.c.xml \
	     ksql-fig4.c.xml \
	     ksql-fig5.c.xml

kwebapp.html: kwebapp.xml $(KWEB_DEPS) $(KWEB_MEDIA)
	sblg -s cmdline -t kwebapp.xml -o $@ $(KWEB_DEPS)

rbac.html: $(RBAC_MEDIA)

.c.c.xml:
	echo '<article data-sblg-article="1">' >$@
	highlight -l -f --out-format=xhtml --enclose-pre --src-lang=c $< >>$@
	echo '</article>' >>$@

ksql.html: ksql.xml $(KSQL_DEPS) $(KSQL_MEDIA)
	sblg -s cmdline -t ksql.xml -o $@ $(KSQL_DEPS)

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 $(IMAGES) $(GENHTMLS) $(BUILT) $(CSSS) $(PAGES) $(PREFIX)
	install -m 0444 icons/*.{png,ico,xml,json,svg} $(PREFIX)
	install -m 0444 robots.txt sitemap.xml $(PREFIX)

clean:
	rm -f $(PAGES) $(GENS) kwebapp.db.c kwebapp.db.h
