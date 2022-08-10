#!/bin/sh

until mysql -h mariadb -u "$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASS" "$WORDPRESS_DB_NAME" -e "\c" 2>/dev/null; do
	sleep 0.1
done

if ! wp core is-installed 1>&2 2>/dev/null; then
	downloadResult=$(wp core download 2>&1)
	until echo "$downloadResult" | grep "Success"; do
		if echo "$downloadResult" | grep "already be present"; then
			break
		fi
		echo "-- Wordpress download failed, trying again..." >&2
		downloadResult=$(wp core download 2>&1)
	done
	wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASS" --dbhost="mariadb"
	wp core install --url="localhost" --title="$WORDPRESS_SITE_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --skip-email
fi

if [ ! -f /volumes/wordpressFiles/adminer/index.php ]; then
	echo "-- Downloading adminer..."
	mkdir -p /volumes/wordpressFiles/adminer
	wget https://www.adminer.org/latest-mysql-en.php --no-cache --tries=0 -O /volumes/wordpressFiles/adminer/index.php 2>/dev/null
	echo "-- Adminer Downloaded."
fi

sed "s/listen = 127.0.0.1:9000/listen = php:9000/" -i /etc/php8/php-fpm.d/www.conf
sed "s/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = $(ping nginx -c 1 -s 0 | awk 'NR==2 { print substr($4, 1, length($4) - 1) ; exit }')/" -i /etc/php8/php-fpm.d/www.conf

echo "-- UP"

exec "$@" # launch service
