#!/bin/sh

sed -e "s/#bind/bind/" /etc/my.cnf.d/mariadb-server.cnf -i
sed -e "s/skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf -i
if [ ! -d /volumes/wordpressDB/mysql ]; then
	mysql_install_db
	/usr/share/mariadb/mysql.server start
	mysql -u root -Bse "
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MariaDBRootPassword';"
	/usr/share/mariadb/mysql.server stop
fi
/usr/share/mariadb/mysql.server start
mysql -u root -p"$MariaDBRootPassword" -Bse "
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON $WordpressDBName.* TO '$WordpressDBUser'@'%' IDENTIFIED BY '$WordpressDBPass';
FLUSH PRIVILEGES;"
/usr/share/mariadb/mysql.server stop

exec "$@" # launch service
