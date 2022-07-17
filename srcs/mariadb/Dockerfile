FROM alpine:3.15.4
RUN apk update && apk add --no-cache mariadb mariadb-client
COPY ./srcs/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./srcs/init.sh /srcs/init.sh
STOPSIGNAL SIGKILL
ENTRYPOINT  ["/srcs/init.sh"]
CMD ["mysqld"]
