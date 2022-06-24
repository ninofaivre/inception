#!/bin/sh

rc-status
touch /run/openrc/softlevel
rc-service mariadb setup
rc-service mariadb start
mysql -u root -Bse "CREATE DATABASE wordpress;GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress password';FLUSH PRIVILEGES;"
/usr/bin/mysqld_safe
