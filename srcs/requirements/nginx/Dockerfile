FROM    debian:bullseye

# Met à jour et installe les paquets nécessaires, avec -y pour confirmer automatiquement
RUN apt update && apt upgrade -y && apt install -y \
    openssl \
    nginx \
    curl \
    vim \
    sudo

# Supprime la config nginx par défaut
RUN			rm -f /etc/nginx/nginx.conf

# Copie le script de setup
COPY		./conf/nginx.conf /etc/nginx/nginx.conf

# Copie le script de setup
COPY		scripts/setup_nginx.sh /setup_nginx.sh
RUN			chmod -R +x /setup_nginx.sh


RUN 		chmod 755 /var/www/html
RUN 		chown -R www-data:www-data /var/www/html

#SSL generate
RUN			mkdir -p /etc/nginx/ssl/
RUN 		mkdir -p /var/run/nginx
RUN  		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=natrijau.42.fr/UID=natrijau"

# 443 c’est le port qui permet l’accès par https:// , et le 80 par http://
EXPOSE		443

CMD [ "nginx", "-g", "daemon off;" ]

