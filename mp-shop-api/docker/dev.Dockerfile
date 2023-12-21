FROM node:alpine

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./

EXPOSE 8888
CMD [ "npm", "start" ]
