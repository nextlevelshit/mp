FROM node:alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && \
    apk add --no-cache build-base gcc autoconf automake \
        zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

ARG PORT
ENV PORT=${PORT}

WORKDIR /opt/

COPY ./package.json ./

ENV PATH /opt/node_modules/.bin:$PATH

#COPY package.json yarn.lock ./
#RUN yarn config set network-timeout 600000 -g && \
#    yarn install
RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
#RUN npm install --platform=linuxmusl --arch=x64 sharp
RUN npm install --ignore-scripts=false --foreground-scripts --verbose sharp

WORKDIR /opt/app

COPY ./ .

RUN chown -R node:node /opt/app

USER node

RUN npm run build

# ENTRYPOINT ["node"] ?

EXPOSE ${PORT}

CMD ["npm", "run", "develop"]
