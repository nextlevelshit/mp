FROM nginx:latest

COPY nginx-template.conf /etc/nginx/nginx-template.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
