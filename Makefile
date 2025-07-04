# Nom du projet (optionnel)
PROJECT_NAME = inception

# Fichier docker-compose (si autre que docker-compose.yml)
COMPOSE_FILE = ./srcs/docker-compose.yml

up:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) up -d

down:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) down

restart: down up

logs:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) logs -f

build:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) build

ps:
	docker-compose -p $(PROJECT_NAME) -f $(COMPOSE_FILE) ps
