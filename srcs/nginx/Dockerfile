FROM alpine
RUN apk update && apk add --no-cache nginx
EXPOSE 80
COPY ./srcs/default.conf /etc/nginx/http.d/default.conf
COPY ./srcs/init.sh /srcs/init.sh
ENTRYPOINT ["/srcs/init.sh"]
CMD ["nginx", "-g", "daemon off;"]
