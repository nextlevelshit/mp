FROM node:latest AS builder

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ /app

ENV NGINX_DEBUG="false" \
    NODE_ENV="production"

RUN npm run build-only

FROM nginx:latest

COPY --from=builder /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./docker-entrypoint.sh /app/docker-entrypoint.sh

RUN chmod 700 /app/docker-entrypoint.sh

EXPOSE 9999

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]
