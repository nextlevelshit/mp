FROM node:latest AS builder
WORKDIR /app
COPY ./package.json ./
RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./
# Set environment variables @todo not working
#ARG API_URL

ENV NGINX_DEBUG="true" \
    NODE_ENV="production"
#    API_URL="$API_URL"

EXPOSE 3333

CMD ["npm", "start"]

#RUN npm run build-only

#FROM nginx:latest
#
#COPY --from=builder /app/dist /usr/share/nginx/html
#COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#COPY ./docker-entrypoint.sh /app/docker-entrypoint.sh
