# Inception - Projet 42

Ce projet a pour but de créer une infrastructure Docker sécurisée et modulaire en utilisant **Docker Compose**. L’objectif est de déployer un site WordPress fonctionnel, sécurisé avec HTTPS, et relié à une base de données **MariaDB**.

---

## Sommaire

1. [Description du projet](#description-du-projet)
2. [Structure de l'infrastructure](#structure-de-linfrastructure)
3. [Installation et utilisation](#installation-et-utilisation)
4. [Utilisation du Makefile](#Utilisation-du-Makefile)
4. [Ce que j'ai appris](#Ce-que-jai-appris)
6. [Ressources utiles](#ressources-utiles)
Ce que j'ai appris
---

## Description du projet

L’objectif du projet **Inception** est de déployer plusieurs services web dans des **conteneurs Docker distincts**, interconnectés via un réseau Docker personnalisé, et configurés pour être **reproductibles, isolés et sécurisés**.

Les services mis en place :

- **NGINX** avec un certificat SSL en **TLSv1.2 ou TLSv1.3**
- **WordPress** fonctionnant avec **php-fpm**, sans serveur web embarqué
- **MariaDB**, base de données MySQL
- Un réseau Docker dédié pour l’ensemble des services
- Des **volumes persistants** pour la base de données et les fichiers WordPress

---

## Structure de l'infrastructure

Chaque service est contenu dans un conteneur Docker spécifique, basé sur :

- **Debian** ou **Alpine** (avant-dernière version stable uniquement)
- Un **Dockerfile personnalisé** (pas d’image préconstruite autorisée)
- Configuration via des **variables d’environnement** (aucun mot de passe en dur)

Le tout est orchestré via `docker-compose`.

---

## Installation et utilisation

### 1. Cloner le dépôt

```bash
git clone <repo-url>
cd inception
```

### 2. Configurer les variables d’environnement

Créer un fichier .env à la racine du projet.
exemple :
```bash
LOGIN=login
DOMAIN_NAME=login.com

MYSQL_ROOT_PASSWORD=your_root_password
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=wp_password

WP_ADMIN_USER=secure
WP_ADMIN_PASSWORD=admin_secure
WP_ADMIN_EMAIL=admin@example.com
WP_USER=guest
WP_USER_PASSWORD=guest123
WP_USER_EMAIL=guest@example.com

```

### 2. Lancer l'infrastructure

```bash
make
```
---

## Utilisation du Makefile

Le fichier `Makefile` centralise toutes les commandes utiles :

| Commande         | Description |
|------------------|-------------|
| `make up`        | Démarre les conteneurs en arrière-plan. Accès : [https://localhost](https://localhost) |
| `make down`      | Arrête les conteneurs. |
| `make build`     | Re-construit les conteneurs. |
| `make restart`   | Redémarre tous les conteneurs (`down` puis `up`). |
| `make logs`      | Affiche les logs de Nginx, WordPress et MariaDB. |
| `make ps`        | Affiche les conteneurs en cours d’exécution. |
| `make clean`     | Supprime conteneurs, volumes et orphelins + prune Docker. |

### Accès au site WordPress

Une fois les services lancés :

🔗 [https://localhost](https://localhost)

> ⚠️ Si vous utilisez un certificat auto-signé, acceptez l’exception de sécurité dans le navigateur.


### Accéder à MariaDB et consulter la base de données

#### 1. Lister les conteneurs actifs

```bash
docker ps
docker exec -it mariadb bash
mysql -u root -p
```

#### 2. Quelques commandes SQL utiles

```bash
SHOW DATABASES;
USE wordpress;
SHOW TABLES;
SELECT * FROM wp_comments LIMIT 10;
```

Pour quitter MariaDB

```bash
EXIT;
```

Pour sortir du conteneur

```bash
exit
```
---

## Ce que j'ai appris

- Utiliser Docker et Docker Compose  
- Gérer des volumes, réseaux, services et dépendances  
- Écrire mon propres Dockerfiles  
- Configurer un serveur sécurisé avec Nginx et certificats SSL  
- Orchestrer un service web complet (WordPress + MariaDB)  
- Automatiser avec un Makefile  

---

### Ressources utiles

- [Documentation Docker](https://docs.docker.com/)  
  Guide officiel pour comprendre la construction et l’utilisation des conteneurs Docker.

- [Docker Compose](https://docs.docker.com/compose/)  
  Orchestration de plusieurs conteneurs via un seul fichier `docker-compose.yml`.

- [NGINX – Configuration SSL](https://nginx.org/en/docs/http/configuring_https_servers.html)  
  Tutoriel officiel pour sécuriser un serveur NGINX avec TLS/SSL.

- [MariaDB – Documentation](https://mariadb.com/docs/)  
  Documentation complète sur l’installation, la configuration et l’utilisation de MariaDB.

- [WordPress CLI](https://developer.wordpress.org/cli/)  
  Interface en ligne de commande pour automatiser l’installation, la configuration et la gestion de WordPress.
