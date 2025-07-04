FROM    debian:bullseye

RUN     apt update && apt upgrade && apt add \
			openssl \
			nginx \
			curl \
			vim \
			sudo

RUN			rm -f /etc/nginx/nginx.conf

COPY		./conf/nginx.conf /etc/nginx/nginx.conf
COPY		scripts/setup_nginx.sh /setup_nginx.sh

RUN			chmod -R +x /setup_nginx.sh

# 443 c’est le port qui permet l’accès par https:// , et le 80 par http://
EXPOSE		443

ENTRYPOINT	["sh", "setup_nginx.sh"]

