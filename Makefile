PROJECT_NAME = inception

# Variables
DC=docker-compose
DC_FILE=docker-compose.yml

# Cibles
up:
	cd srcs && $(DC) -f $(DC_FILE) up -d
	@echo "----------------------------------------------"
	@echo "Le site est disponible ici : https://natrijau.42.fr"
	@echo "----------------------------------------------"

down:
	cd srcs && $(DC) -f $(DC_FILE) down

build:
	cd srcs && $(DC) -f $(DC_FILE) build

restart: down up

logs:
	@echo "Logs pour nginx :"
	@cd srcs && $(DC) -f $(DC_FILE) logs nginx
	@echo "--------------------------"
	@echo "Logs pour wordpress :"
	@cd srcs &&  $(DC) -f $(DC_FILE) logs wordpress
	@echo "--------------------------"
	@echo "Logs pour mariadb :"
	@cd srcs && $(DC) -f $(DC_FILE) logs mariadb

ps:
	cd srcs && $(DC) -f $(DC_FILE) ps

clean:
	cd srcs && $(DC) -f $(DC_FILE) down -v --remove-orphans
	docker system prune -f

.PHONY: up down build restart logs ps clean
