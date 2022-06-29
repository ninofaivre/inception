#!/bin/sh

sed -e "s/#bind/bind/" /etc/my.cnf.d/mariadb-server.cnf -i
sed -e "s/skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf -i
mysql_install_db
/usr/share/mariadb/mysql.server start
mysql -Bse "
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'poulet'@'%' IDENTIFIED BY 'poulet';
FLUSH PRIVILEGES;"
/usr/share/mariadb/mysql.server stop

exec "$@" # launch service
