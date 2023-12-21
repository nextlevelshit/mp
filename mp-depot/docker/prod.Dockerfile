FROM node:alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && \
    apk add --no-cache build-base gcc autoconf automake \
        zlib-dev libpng-dev nasm bash vips-dev

ENV NODE_ENV=production

ARG PORT
ENV PORT=${PORT}

WORKDIR /opt/

COPY package.json ./

ENV PATH /opt/node_modules/.bin:$PATH

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error

RUN npm install --ignore-scripts=false --foreground-scripts --verbose sharp

WORKDIR /opt/app

COPY ./ .

RUN chown -R node:node /opt/app

USER node

RUN npm run build

# ENTRYPOINT ["node"] ?

EXPOSE ${PORT}

CMD ["npm", "run", "start"]
