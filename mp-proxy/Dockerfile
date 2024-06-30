FROM nginx:latest

COPY nginx-template.conf /etc/nginx/nginx-template.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

## Redirect NGINX logs to stdout and stderr
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["/docker-entrypoint.sh"]
