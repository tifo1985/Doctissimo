DOCKER_COMPOSE=@docker-compose $(COMPOSE_FILE_PATH)
COMPOSE_FILE_PATH := -f docker-compose.yml
DOCKER_EXEC_CMD=$(DOCKER_COMPOSE) exec
DOCKER_SQL := $(DOCKER_EXEC_CMD) doctissimo-api-mysql mysql -u root -proot -e
DB_NAME=$(shell grep ^DB_NAME= ./doctissimo-api/.env | cut -d '=' -f 2-)
DB_USERNAME=$(shell grep ^DB_USERNAME= ./doctissimo-api/.env | cut -d '=' -f 2-)
DB_PASSWORD=$(shell grep ^DB_PASSWORD= ./doctissimo-api/.env | cut -d '=' -f 2-)

install: buildImage start afterBuild

buildImage: ## Build the containers
	$(DOCKER_COMPOSE) build $(ARGUMENT)

start: ## Start the containers (only work when installed)
	$(DOCKER_COMPOSE) up -d $(ARGUMENT)

afterBuild: destroyCreateDB migrateDB

destroyCreateDB: ## create the asked database and user
	$(DOCKER_SQL) "drop database if exists $(DB_NAME)"
	$(DOCKER_SQL) "drop user if exists $(DB_USERNAME)"
	$(DOCKER_SQL) "create database $(DB_NAME)"
	$(DOCKER_SQL) "create user '$(DB_USERNAME)'@'%' identified by '$(DB_PASSWORD)';"
	$(DOCKER_SQL) "GRANT ALL PRIVILEGES ON $(DB_NAME).* TO '$(DB_USERNAME)'@'%' WITH GRANT OPTION;"

migrateDB: ## Execute a database SQL file.
	$(DOCKER_EXEC_CMD) -T doctissimo-api-mysql mysql -u root -proot $(DB_NAME) < doctissimo-api/database.sql
