#!/bin/sh

# generate a self-signed SSL certificate for secure server communication
openssl req -x509 -nodes -newkey rsa:4096 \
        -keyout /etc/ssl/private/selfsigned-ssl.key \
        -out /etc/ssl/certs/selfsigned-ssl.crt \
        -days 365 -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=mcourtoi.42.fr"

# check nginx config
nginx -t

nginx -g "daemon off;"
