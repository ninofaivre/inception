#!/bin/sh

wp config create --path="/volumes/wordpressFiles" --skip-check --force --dbname="$WordpressDBName" --dbuser="$WordpressDBUser" --dbpass="$WordpressDBPass" --dbhost="mariadb"
if wp core is-installed --path="/volumes/wordpressFiles"; then
	wp core download --path="/volumes/wordpressFiles"
fi

sed "s/listen = 127.0.0.1:9000/listen = 9000/" /etc/php8/php-fpm.d/www.conf -i

exec "$@" # launch service
