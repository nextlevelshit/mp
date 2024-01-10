#!/usr/bin/env bash
set -e


# Substitute environment variables in the NGINX configuration template
# shellcheck disable=SC2016
envsubst '$SHOP_ADDRESS $SHOP_API_ADDRESS $DEPOT_ADDRESS' < /etc/nginx/nginx-template.conf > /etc/nginx/nginx.conf

# Optionally add the Certbot location block based on a condition
if [ -n "$CERTS_PORT" ]; then
    # Replace the placeholder in the NGINX configuration template directly
    sed -i "s|##CERTBOT_LOCATION_BLOCK##|location /.well-known/acme-challenge/ {\
        proxy_pass http://${CERTS_DOCKER_CONTAINER}:${CERTS_PORT};\
        proxy_set_header Host \$host;\
        proxy_set_header X-Real-IP \$remote_addr;\
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;\
        proxy_set_header X-Forwarded-Proto \$scheme;\
    }|" /etc/nginx/nginx.conf
else
    # Remove the placeholder if Certbot is not enabled
    sed -i "s|##CERTBOT_LOCATION_BLOCK##||" /etc/nginx/nginx.conf
fi

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
