#!/bin/sh

until mysql -h mariadb -u $WordpressDBUser -p"$WordpressDBPass" $WordpressDBName -e "\c" 2>/dev/null; do
	sleep 0.1
done

if ! wp core is-installed 2>/dev/null; then
	wp core download
	wp config create --dbname="$WordpressDBName" --dbuser="$WordpressDBUser" --dbpass="$WordpressDBPass" --dbhost="mariadb"
	wp core install --url="localhost" --title="$WordpressSiteTitle" --admin_user="$WordpressAdminUser" --admin_password="$WordpressAdminPassword" --admin_email="$WordpressAdminEmail" --skip-email
fi

sed "s/listen = 127.0.0.1:9000/listen = php:9000/" /etc/php8/php-fpm.d/www.conf -i
sed "s/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = $(ping nginx -c 1 -s 0 | awk 'NR==2 { print substr($4, 1, length($4) - 1) ; exit }')/" /etc/php8/php-fpm.d/www.conf -i

exec "$@" # launch service
