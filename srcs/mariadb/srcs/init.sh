#!/bin/sh

sed -e "s/#bind/bind/" -i /etc/my.cnf.d/mariadb-server.cnf
sed -e "s/skip-networking/#skip-networking/" -i /etc/my.cnf.d/mariadb-server.cnf
if [ ! -d /volumes/wordpressDB/mysql ]; then
	mysql_install_db
fi
/usr/share/mariadb/mysql.server start
mysql -u root -p"$MARIADB_ROOT_PASSWORD" -Bse "
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
DROP DATABASE IF EXISTS test;
DROP USER IF EXISTS ''@'localhost';
DROP USER IF EXISTS ''@'%';
DROP USER IF EXISTS ''@'$HOSTNAME';
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'localhost' IDENTIFIED BY '$WORDPRESS_DB_PASS';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'php.inception' IDENTIFIED BY '$WORDPRESS_DB_PASS';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'php.inception' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
FLUSH PRIVILEGES;"
/usr/share/mariadb/mysql.server stop

exec "$@" # launch service
