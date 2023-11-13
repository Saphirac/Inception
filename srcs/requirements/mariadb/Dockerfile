FROM debian:11.8

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN apt-get install -y procps

COPY ./conf/mariadb.conf /etc/my.cnf.d

RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

EXPOSE 3306

COPY ./tools/init_launch_db.sh /tmp
RUN chmod +x /tmp/init_launch_db.sh

ENTRYPOINT ["bash", "/tmp/init_launch_db.sh"]
