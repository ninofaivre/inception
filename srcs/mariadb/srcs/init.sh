#!/bin/sh

sed -e "s/#bind/bind/" /etc/my.cnf.d/mariadb-server.cnf -i
sed -e "s/skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf -i
if [ ! -d /volumes/wordpressDB/mysql ]; then
	mysql_install_db
fi
/usr/share/mariadb/mysql.server start
mysql -u root -p"$MariaDBRootPassword" -Bse "
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MariaDBRootPassword';
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON $WordpressDBName.* TO '$WordpressDBUser'@'php.inception' IDENTIFIED BY '$WordpressDBPass';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;"
/usr/share/mariadb/mysql.server stop

exec "$@" # launch service
