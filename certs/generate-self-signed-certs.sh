#!/bin/bash

mkdir -p /etc/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/cert.pem.key \
  -out /etc/ssl/cert.pem \
  -subj "/C=DE/ST=Baden-Württemberg/L=Stuttgart/O=MUELLERPRINTS/CN=${HOST}"

if [ -f /etc/ssl/cert.pem.key ] && [ -f /etc/ssl/cert.pem ]; then
  	exit 0
else
  	exit 1
fi
