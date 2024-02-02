FROM node:latest AS builder

WORKDIR /app

COPY ./package.json ./

RUN npm i --no-audit --no-fund --progress=false --no-warnings --log-level=error
COPY ./ ./

EXPOSE 9999

CMD ["npm", "start"]
