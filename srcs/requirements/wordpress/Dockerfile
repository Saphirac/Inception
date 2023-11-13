FROM debian:11.8

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.3 php-fpm php-mysql

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update && apt-get install -y default-mysql-client
RUN apt-get install -y mariadb-client
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

# Expose port 9000 for PHP-FPM
EXPOSE 9000

COPY ./tools/wpscript.sh ./
RUN chmod +x ./wpscript.sh

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./init_launch_wp.sh"]