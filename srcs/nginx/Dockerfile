FROM alpine
RUN apk add nginx
EXPOSE 80
COPY ./srcs/init.sh /
COPY ./srcs/default.conf /
CMD ./init.sh
