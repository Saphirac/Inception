FROM debian:11.8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx vim curl openssl

# create necessary repertories if not existing already
RUN mkdir -p /etc/nginx/ssl /var/run/nginx

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY init-script.sh /tmp/init-script.sh
RUN chmod +x /tmp/init-script.sh

ENTRYPOINT ["sh", "./init_launch_ng.sh"]

