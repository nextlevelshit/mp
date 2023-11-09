FROM node:16-alpine

WORKDIR /app

COPY ./package.json ./
#COPY package*.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./
#RUN npm run build

EXPOSE 7777
CMD [ "npm", "start" ]
