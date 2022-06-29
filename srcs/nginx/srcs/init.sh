#!/bin/sh

chown nginx:nginx /volumes/wordpressFiles

exec "$@" # launch service
