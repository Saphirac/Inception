#!/bin/bash
#set -euo pipefail

# Initialisation de MariaDB
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation de la base de données MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Démarrage temporaire de MariaDB en arrière-plan pour la configuration
mysqld_safe --nowatch &

# Attendre que MariaDB démarre
while ! mysqladmin ping --silent; do
    sleep 1
done

# Configuration de la base de données et des utilisateurs
echo "Config databases and users"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Arrêt de la base de données après la configuration
echo "Arrêt du serveur MariaDB temporaire..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Démarrage du serveur MariaDB en mode foreground pour le conteneur Docker
echo "Démarrage du serveur MariaDB..."
exec mysqld_safe
