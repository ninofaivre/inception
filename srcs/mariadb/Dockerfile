FROM alpine
RUN apk add mariadb mariadb-client openrc
EXPOSE 3306
COPY ./srcs/init.sh /
CMD ./init.sh
