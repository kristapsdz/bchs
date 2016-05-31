#! /bin/sh

cc -static -g -W -Wall -o cgi cgi.c -lkcgi -lz
doas install -u www -g www -m 0500 cgi /var/www/cgi-bin
doas rcctl enable slowcgi
doas rcctl start slowcgi
doas rcctl check slowcgi
doas rcctl restart httpd
