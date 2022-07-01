FROM alpine
RUN apk update && apk add --no-cache mariadb mariadb-client
COPY ./srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./srcs/init.sh /srcs/init.sh
ENTRYPOINT  ["/srcs/init.sh"]
CMD ["mysqld_safe"]
