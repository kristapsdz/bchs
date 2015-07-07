BLOGS		 = blog0.xml

www: index.html start.html 

index.html: index.xml $(BLOGS)
	sblg -o $@ -t index.xml $(BLOGS)

start.html: start.xml $(BLOGS)
	sblg -o $@ -t start.xml $(BLOGS)

installwww: www
	mkdir -p $(PREFIX)
	install -m 0444 logo-white.png index.html index.css start.html start.css $(PREFIX)

clean:
	rm -f index.html start.html 
