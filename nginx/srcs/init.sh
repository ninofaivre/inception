#!/bin/sh

rm /etc/nginx/http.d/default.conf
mv /default.conf /etc/nginx/http.d
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
rm /latest.tar.gz
mv /wordpress /test/wordpress
chown nginx test/wordpress
nginx -g "daemon off;"
