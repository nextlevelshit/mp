FROM debian:latest

RUN apt-get update && apt-get install -y openssl

ENV HOST=${HOST} \
	EMAIL=${EMAIL}

COPY ./generate-self-signed-certs.sh /generate-self-signed-certs.sh

RUN chmod +x /generate-self-signed-certs.sh

ENTRYPOINT ["bash","/generate-self-signed-certs.sh"]
