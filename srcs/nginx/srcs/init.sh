#!/bin/sh

chown nginx:nginx /volumes/wordpressFiles
openssl genrsa -out test.key 2048
openssl req -x509 -nodes -days 365 -key test.key -out test.crt -subj "/C=FR/ST=France/L=Paris/O=42/OU=42Paris/CN=42/emailAddress=42@42.42"

exec "$@" # launch service
