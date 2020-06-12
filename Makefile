DOCKER_COMPOSE=@docker-compose $(COMPOSE_FILE_PATH)
COMPOSE_FILE_PATH := -f doctissimo-api/docker-compose.yml

install: buildImage

buildImage: ## Build the containers
	$(DOCKER_COMPOSE) build $(ARGUMENT)

start: ## Start the containers (only work when installed)
	$(DOCKER_COMPOSE) up -d $(ARGUMENT)