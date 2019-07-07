#! /bin/sh
cc -static -g -W -Wall -Wextra -o cgi cgi.c
doas install -o www -g www -m 0500 cgi /var/www/cgi-bin
doas rcctl enable slowcgi
doas rcctl start slowcgi
doas rcctl check slowcgi
doas rcctl restart httpd
