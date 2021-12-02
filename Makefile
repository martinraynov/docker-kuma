M = $(shell printf "\033[34;1m▶\033[0m")

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################
### MAIN FUNCTIONS ###
######################

.PHONY: kuma_start
kuma_start: ## Start the kuma docker container
	$(info $(M) Starting an instance of kuma)
	@docker stack rm kuma
	@docker stack deploy -c ./docker/docker-compose-swarm.yml kuma

.PHONY: kuma_stop
kuma_stop: ## Stopping running kuma instances
	$(info $(M) Stopping kuma instance)
	@docker stack rm kuma

.DEFAULT_GOAL := help