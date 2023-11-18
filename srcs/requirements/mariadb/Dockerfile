FROM debian:bullseye

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y mariadb-server \
    && apt-get install -y mariadb-client \
    && apt-get install -y procps

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld \
    &&  mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/ \
    && chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/ \
    && chmod -R 755 /var/lib/mysql/

EXPOSE 3306

COPY ./tools/init_launch_db.sh /tmp
RUN chmod +x /tmp/init_launch_db.sh

ENTRYPOINT ["sh", "/tmp/init_launch_db.sh"]