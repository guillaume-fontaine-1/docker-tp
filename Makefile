# Variables
DOCKER_COMPOSE = docker-compose
MYSQL_CONTAINER = database
MYSQL_DUMP_FILE = dump.sql

# Cibles par défaut
.PHONY: all build up-dev up-prod down restart clean exec-db-shell dump-dev-db

# Construction des images et lancement des services
all: build up-dev

# Construire les images
build:
	$(DOCKER_COMPOSE) build

# Lancer les services en mode développement
up-dev:
	$(DOCKER_COMPOSE) --env-file .env.dev up -d

# Lancer les services en mode production
up-prod:
	$(DOCKER_COMPOSE) --env-file .env.prod up -d

# Arrêter les services
down:
	$(DOCKER_COMPOSE) down

# Redémarrer les services
restart: down up-dev

# Nettoyer les volumes et les images
clean: down
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	$(DOCKER_COMPOSE) rm -f
	$(DOCKER_COMPOSE) rmi -f

# Ouvrir une session bash dans le conteneur MySQL
exec-db-shell:
	$(DOCKER_COMPOSE) exec $(MYSQL_CONTAINER) bash

# Réaliser un dump de la base de données docker_doc_dev
dump-dev-db:
	$(DOCKER_COMPOSE) exec $(MYSQL_CONTAINER) mysqldump -u db_client -p${MYSQL_PASSWORD} docker_doc_dev > $(MYSQL_DUMP_FILE)
