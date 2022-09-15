#!/bin/bash

case "$1" in

  'nginx')
        exec nginx -g 'daemon off;error_log /dev/stdout info;'
        ;;

  'ui')
        exec /app/nginx-ui --config app.ini
        ;;

  *)
        nginx
        /app/nginx-ui --config app.ini
        ;;
esac
