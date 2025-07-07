#!/bin/bash
set -e

echo "🛠️ Initialisation de la base de données MariaDB..."
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "📁 Initialisation du data directory..."

    echo "⏳ Lancement temporaire de mysqld..."
    mysqld --skip-networking &
    pid="$!"

    # Attente que le socket soit créé
    echo "⏳ Attente de mysqld..."
	# Wait for MariaDB server to start
	until mysqladmin ping --silent; do
		sleep 1
	done

    echo "🧱 Création base & utilisateur..."
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "DROP USER IF EXISTS '${MYSQL_USER}'@'%';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    echo "🛑 Arrêt du serveur temporaire..."
	mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

    wait "$pid"
else
    echo "✅ Base déjà initialisée."
fi

echo "🚀 Lancement final de mysqld..."
exec mysqld

