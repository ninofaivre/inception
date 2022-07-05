#!/bin/sh

if [ ! $(ls -A /volumes/wordpressFiles) ]; then
	wp core download
fi
wp config create --skip-check --force --dbname="$WordpressDBName" --dbuser="$WordpressDBUser" --dbpass="$WordpressDBPass" --dbhost="mariadb"

sed "s/listen = 127.0.0.1:9000/listen = php:9000/" /etc/php8/php-fpm.d/www.conf -i

exec "$@" # launch service
