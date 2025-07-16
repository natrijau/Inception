PROJECT_NAME = inception

# Variables
DC=docker-compose
DC_FILE=./srcs/docker-compose.yml

# Cibles
up:
	$(DC) -f $(DC_FILE) up -d
	@echo "----------------------------------------------"
	@echo "Le site est disponible ici : https://localhost"
	@echo "----------------------------------------------"

down:
	$(DC) -f $(DC_FILE) down

build:
	$(DC) -f $(DC_FILE) build

restart: down up

logs:
	@echo "Logs pour nginx :"
	@$(DC) -f $(DC_FILE) logs nginx
	@echo "--------------------------"
	@echo "Logs pour wordpress :"
	@$(DC) -f $(DC_FILE) logs wordpress
	@echo "--------------------------"
	@echo "Logs pour mariadb :"
	@$(DC) -f $(DC_FILE) logs mariadb

ps:
	$(DC) -f $(DC_FILE) ps

clean:
	$(DC) -f $(DC_FILE) down -v --remove-orphans
	docker system prune -f

.PHONY: up down build restart logs ps clean
