#!/bin/sh

rc-status
touch /run/openrc/softlevel
rc-service mariadb setup
rc-service mariadb start
mysql -u root -Bse "CREATE DATABASE wordpress;GRANT ALL PRIVILEGES ON wordpress.* TO 'poulet'@'%' IDENTIFIED BY 'poulet';FLUSH PRIVILEGES"
rc-service mariadb stop
sed -e "s/#bind/bind/" /etc/my.cnf.d/mariadb-server.cnf -i
sed -e "s/skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf -i
/usr/bin/mysqld_safe
