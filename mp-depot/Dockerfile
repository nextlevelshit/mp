FROM node:alpine

RUN apk update && \
    apk add --no-cache build-base gcc autoconf automake \
        zlib-dev libpng-dev nasm bash vips-dev

ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

ARG PORT
ENV PORT=${PORT}

WORKDIR /opt/

COPY ./package.json ./

ENV PATH /opt/node_modules/.bin:$PATH

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
RUN npm i --ignore-scripts=false --foreground-scripts --verbose sharp

WORKDIR /opt/app

COPY ./ ./

RUN chown -R node:node /opt/app

USER node

RUN npm run build

RUN chmod +x /opt/app/docker-entrypoint.sh

ENTRYPOINT ["/opt/app/docker-entrypoint.sh"]

EXPOSE ${PORT}
