#!/bin/bash

# permet d'arreter le script si une commande echoue
set -e

echo "🛠️ Initialisation de la base de données MariaDB..."

# on verifie si le repertoire de database existe sinon on le créer
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	echo "📁 Initialisation du data directory..."

	echo "⏳ Lancement temporaire de mysqld..."

	# Demarre le serveur MariaDB en arriere-plan sans prise en charge reseau
	# Utile pour l'initialisation
	# On récupere l'ID du process du serveur MariaDB
	mysqld --skip-networking &
	pid="$!"

	# Attente que le socket soit créé
	echo "⏳ Attente de mysqld..."
	# Wait for MariaDB server to start
	until mysqladmin ping --silent; do
		sleep 1
	done

	# On créer une database si elle n'existe pas
	echo "🧱 Création base & utilisateur..."
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "DROP USER IF EXISTS '${MYSQL_USER}'@'%';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

	echo "🛑 Arrêt du serveur temporaire..."

	# On stop le serveur MariaDB temporaire
	mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

	# On attend que le processus du serveur MariaDB se termine (similaire waitpid)
	wait "$pid"
else
	echo "✅ Base déjà initialisée."
fi

echo "🚀 Lancement final de mysqld..."

# Remplace le processus actuel par le serveur MariaDB
# qui devient alors le processus principal du conteneur
exec mysqld

