# Utilise l'image officielle de Nginx comme image de base
FROM nginx:latest

# Copie un fichier de configuration personnalisé dans le conteneur
COPY nginx.conf /etc/nginx/nginx.conf

# Copie les fichiers du site dans le dossier HTML par défaut de Nginx
COPY ./html /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Commande de lancement (déjà incluse dans l’image nginx officielle)
CMD ["nginx", "-g", "daemon off;"]
