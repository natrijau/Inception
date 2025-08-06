#!/bin/bash

# Verifie si wordpress est deja installé
if !(wp core is-installed --allow-root); then
	
	wp core install --url=https://${DOMAIN_NAME} \
					--title=${WP_TITLE}  \
					--admin_user=${WP_ADMIN}  \
					--admin_password=${WP_ADMIN_PASSWORD}  \
					--admin_email=${WP_ADMIN}@${WP_ADMIN_EMAIL}  \
					--allow-root --skip-email
	
	wp user create ${WP_USER} ${WP_USER_EMAIL} \
					--user_pass=${WP_USER_PASSWORD} \
					--role=author \
					--allow-root
fi

exec /usr/sbin/php-fpm7.4 -F