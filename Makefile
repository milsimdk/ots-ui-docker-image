include .env
# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build Images
	docker compose build --no-cache

retag: ## Stop OpenTAKServer
	git tag -d ${OTSUI_VERSION}
	git push origin :refs/tags/${OTSUI_VERSION}
	git tag ${OTSUI_VERSION} -m "Version ${OTSUI_VERSION} released"
	git push origin ${OTSUI_VERSION}

tag: ## Restart OpenTAKServer
	git tag ${OTSUI_VERSION} -m "Version ${OTSUI_VERSION} released"

commit: ## Logs for OpenTAKServer
	git add .
	git commit -m'Working on ${OTSUI_VERSION}'
