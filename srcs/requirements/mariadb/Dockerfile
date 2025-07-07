FROM debian:bullseye-slim

# Installer MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Créer les dossiers nécessaires
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copier la configuration personnalisée (optionnel)
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copier le script d'initialisation
COPY ./tools/setup_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_db.sh


EXPOSE 3306

# Point d'entrée = script de setup puis lancement de mysqld
ENTRYPOINT ["/usr/local/bin/setup_db.sh"]
