#!/bin/sh

sed "s/listen = 127.0.0.1:9000/listen = 9000/" /etc/php8/php-fpm.d/www.conf -i
php-fpm8 -F -R
