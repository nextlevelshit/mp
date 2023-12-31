#!/usr/bin/env bash

if [ "$NODE_ENV" = "production" ]; then
  echo "Starting nginx"

  # Start Nginx
  if [ "$NGINX_DEBUG" = "true" ]; then
    sed -i 's/error\.log warn/error.log debug/' /etc/nginx/nginx.conf
    exec nginx-debug -g 'daemon off;'
  else
    exec nginx -g 'daemon off;'
  fi
else
  echo "Starting dev environment"

  exec npm start
fi
