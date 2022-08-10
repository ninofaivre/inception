#!/bin/sh

sed -e "s/#bind/bind/" -i /etc/my.cnf.d/mariadb-server.cnf
sed -e "s/skip-networking/#skip-networking/" -i /etc/my.cnf.d/mariadb-server.cnf
if [ ! -d /volumes/wordpressDB/mysql ]; then
	mysql_install_db
fi
/usr/share/mariadb/mysql.server start
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -Bse "
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'php.inception' IDENTIFIED BY '$WORDPRESS_DB_PASS';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;"
/usr/share/mariadb/mysql.server stop

exec "$@" # launch service
