FROM node:latest AS builder

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ /app

ARG VITE_BASE_URL
ARG VITE_PAYMENT_ENVIRONMENT
ARG VITE_UMAMI_WEBSITE_ID

ENV NGINX_DEBUG="false" \
    NODE_ENV="production" \
    VITE_BASE_URL=${VITE_BASE_URL} \
    VITE_PAYMENT_ENVIRONMENT=${VITE_PAYMENT_ENVIRONMENT} \
    VITE_UMAMI_WEBSITE_ID=${VITE_UMAMI_WEBSITE_ID}

RUN npm run build-only

FROM nginx:latest

COPY --from=builder /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY ./docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]

EXPOSE 9999
