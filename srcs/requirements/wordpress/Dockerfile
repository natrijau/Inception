FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	wget \
	php7.4-fpm \
	php-mysql \
	php-curl \
	php-gd \
	php-xml \
	php-mbstring \
	php-zip \
	curl \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer un utilisateur et un groupe pour PHP-FPM
WORKDIR /var/www/html

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz && \
	tar -xzf wordpress-6.0-fr_FR.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress wordpress-6.0-fr_FR.tar.gz && \
	chown -R www-data:www-data /var/www/html

# Téléchargement et installation de WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Copie et configuration de PHP-FPM
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copier et configurer le script d'installation WordPress
COPY ./tools/setup_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wp.sh

# Créer le répertoire racine de WordPress et y accéder
RUN mkdir -p /var/www/html

# Créer le dossier nécessaire à php-fpm pour son PID
RUN mkdir -p /run/php

# Copier le fichier de configuration wordpress
COPY ./conf/wp-config.php .

EXPOSE 9000
CMD ["setup_wp.sh"]
