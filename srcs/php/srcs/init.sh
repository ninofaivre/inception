#!/bin/sh

if ! wp core is-installed --path="/volumes/wordpressFiles"; then
	wp core download --path="/volumes/wordpressFiles"
	wp config create --path="/volumes/wordpressFiles" --skip-check --dbname="wordpress" --dbuser="poulet" --dbpass="poulet" --dbhost="172.20.2.3"
fi

sed "s/listen = 127.0.0.1:9000/listen = 9000/" /etc/php8/php-fpm.d/www.conf -i

exec "$@" # launch service
