FROM node:alpine

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./
RUN npm run build

EXPOSE 8888
CMD [ "npm", "run", "production" ]
