# Inception - Projet 42

Ce projet a pour but de créer une infrastructure Docker sécurisée et modulaire en utilisant **Docker Compose**. L’objectif est de déployer un site WordPress fonctionnel, sécurisé avec HTTPS, et relié à une base de données **MariaDB**.

---

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

---

## Accès au site WordPress

Une fois les services lancés :

🔗 [https://localhost](https://localhost)

> ⚠️ Si vous utilisez un certificat auto-signé, acceptez l’exception de sécurité dans le navigateur.

---

## Accéder à MariaDB et consulter la base de données

### 1. Lister les conteneurs actifs

```bash
docker ps
docker exec -it mariadb bash
mysql -u root -p
```

### 1. Quelques commandes SQL utiles

```bash
SHOW DATABASES;
USE nom_de_la_base;
SHOW TABLES;
SELECT * FROM table LIMIT 10;
```

Pour quitter MariaDB

```bash
EXIT;
```

Pour sortir du conteneur

```bash
exit
```

## Ce que j'ai appris

- Utiliser Docker et Docker Compose  
- Gérer des volumes, réseaux, services et dépendances  
- Écrire mon propres Dockerfiles  
- Configurer un serveur sécurisé avec Nginx et certificats SSL  
- Orchestrer un service web complet (WordPress + MariaDB)  
- Automatiser avec un Makefile  
