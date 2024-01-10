FROM node:alpine

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./
RUN npm run build

COPY ./docker-entrypoint.sh /app/
RUN chmod +x /app/docker-entrypoint.sh

ENTRYPOINT ["/app/docker-entrypoint.sh"]

EXPOSE 8888
