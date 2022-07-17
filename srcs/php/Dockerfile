FROM alpine:3.15.4
RUN apk update && apk add --no-cache php8 php8-fpm php8-opcache php8-gd php8-mysqli php8-phar php8-iconv wget mariadb-client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && chmod +x /usr/local/bin/wp
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php8 /usr/bin/php; fi
COPY ./srcs/config.yml /etc/wp-cli/config.yml
COPY ./srcs/init.sh /srcs/init.sh
ENTRYPOINT ["/srcs/init.sh"]
CMD ["php-fpm8", "-F", "-R"]
