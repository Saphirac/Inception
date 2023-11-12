#!/bin/sh

set -euo pipefail

service mysql start;

if [ $(ls /var/lib/mysql | wc -l) -eq 0 ]
then

	/etc/init.d/mariadb setup
	rc-service mariadb start

	mysql -u root -e " \
        CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD'; \
        CREATE DATABASE IF NOT EXISTS $SQL_DATABASE; \
        GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%'; \
        FLUSH PRIVILEGES; \
        ALTER USER '$SQL_ROOT_USER'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"

	mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
fi

mysqld_safe --datadir='/var/lib/mysql'
echo "MariaDB launching successfully! "
