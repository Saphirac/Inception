FROM debian:bullseye

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y nginx vim curl openssl

# create necessary repertories if not existing already
RUN mkdir -p /etc/nginx/ssl /var/run/nginx
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=$DOMAIN_NAME"

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
#COPY ./tools/index.html /var/www/localhost/htdocs/

CMD [ "nginx", "-g", "daemon off;" ]
