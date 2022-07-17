FROM alpine:3.15.4
RUN apk update && apk add --no-cache nginx openssl
RUN openssl genrsa -out /etc/ssl/certs/nginx.key 2048
RUN openssl req -x509 -nodes -days 365 -key /etc/ssl/certs/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=France/L=Paris/O=42/OU=42Paris/CN=42/emailAddress=42@42.42"
COPY ./srcs/default.conf /etc/nginx/http.d/default.conf
COPY ./srcs/init.sh /srcs/init.sh
ENTRYPOINT ["/srcs/init.sh"]
CMD ["nginx", "-g", "daemon off;"]
