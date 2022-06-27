FROM alpine
RUN apk add php8 php8-fpm php8-opcache php8-gd php8-mysqli
EXPOSE 9000
COPY ./srcs/init.sh /
CMD ./init.sh
