#!/bin/sh

chown nginx:nginx /volumes/wordpressFiles

echo "-- UP"

exec "$@" # launch service
