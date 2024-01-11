#!/usr/bin/env bash
set -e


# Substitute environment variables in the NGINX configuration template
# shellcheck disable=SC2016
envsubst '$SHOP_ADDRESS $SHOP_API_ADDRESS $DEPOT_ADDRESS' < /etc/nginx/nginx-template.conf > /etc/nginx/nginx.conf

echo "Generated nginx.conf:"
echo ""
cat /etc/nginx/nginx.conf

echo "Starting nginx"
# Start Nginx
if [ "$NGINX_DEBUG" = "true" ]; then
  sed -i 's/error\.log warn/error.log debug/' /etc/nginx/nginx.conf
  exec nginx-debug -g 'daemon off;'
else
  exec nginx -g 'daemon off;'
fi
