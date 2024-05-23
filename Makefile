M = $(shell printf "\033[34;1m▶\033[0m")

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################
### MAIN FUNCTIONS ###
######################

.PHONY: start_swarm
start_swarm: ## Start the kuma docker container in swarm mode
	$(info $(M) Starting an instance of kuma in swarm mode)
	@docker stack rm kuma
	@docker stack deploy -c ./docker/docker-compose-swarm.yml kuma

.PHONY: stop_swarm
stop_swarm: ## Stopping running kuma instances in swarm mode
	$(info $(M) Stopping kuma instance in swarm mode)
	@docker stack rm kuma

.PHONY: start
start: ## Start the kuma docker container
	$(info $(M) Starting an instance of kuma at : kuma.local.io)
	@docker-compose -f ./docker/docker-compose.yml up -d

.PHONY: stop
stop: ## Stopping running kuma instances
	$(info $(M) Stopping kuma instance)
	@docker-compose -f ./docker/docker-compose.yml down

.DEFAULT_GOAL := help