PROJECT_NAME = inception

DC = docker-compose
DC_FILE = docker-compose.yml

up:
	cd srcs && $(DC) -f $(DC_FILE) up -d
	@echo "----------------------------------------------"
	@echo "Le site est disponible ici : https://natrijau.42.fr"
	@echo "----------------------------------------------"

down:
	@echo "----------------------------------------------"
	@echo "Arrêt des services et suppression des containers..."
	@echo "----------------------------------------------"
	cd srcs && $(DC) -f $(DC_FILE) down

build:
	@echo "----------------------------------------------"
	@echo "Construction des images Docker..."
	@echo "----------------------------------------------"
	cd srcs && $(DC) -f $(DC_FILE) build

stop:
	@echo "----------------------------------------------"
	@echo "Arrêt temporaire des services ..."
	@echo "----------------------------------------------"
	cd srcs && $(DC) -f $(DC_FILE) stop

re: 
	@echo "----------------------------------------------"
	@echo "Redémarrage complet des services (down + up)..."
	@echo "----------------------------------------------"
	$(MAKE) down
	$(MAKE) up

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
	@echo "----------------------------------------------"
	@echo "Liste des containers actifs via le docker-compose :"
	@echo "----------------------------------------------"
	cd srcs && $(DC) -f $(DC_FILE) ps

clean:
	@read -p "Supprimer containers et volumes. Continuer ? (o/n) " confirm; \
	if [ "$$confirm" = "o" ] || [ "$$confirm" = "O" ]; then \
		cd srcs && $(DC) -f $(DC_FILE) down -v ; \
	else \
		echo "Annulé."; \
	fi

rmi:
	@read -p "Supprimer toutes les images Docker ? (o/n) " confirm; \
	if [ "$$confirm" = "o" ] || [ "$$confirm" = "O" ]; then \
		docker rmi -f $$(docker images -qa); \
	else \
		echo "Annulé."; \
	fi

volumes:
	@echo "----------------------------------------------"
	@echo "Liste des volumes Docker présents sur la machine :"
	@echo "----------------------------------------------"
	docker volume ls

rmvolumes:
	@read -p "Supprimer tous les volumes Docker ? (o/n) " confirm; \
	if [ "$$confirm" = "o" ] || [ "$$confirm" = "O" ]; then \
		docker volume rm $$(docker volume ls -q); \
	else \
		echo "Annulé."; \
	fi

.PHONY: up down build re logs ps clean rmi volumes rmvolumes
