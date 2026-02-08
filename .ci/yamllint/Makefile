YAMLLINT_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
YAMLLINT_VERSION=1.26

##
## CI - Yamllint
## -------
##

yamllint: ## Find error in yaml files
	docker run --rm -t -v $(PWD):/data cytopia/yamllint:$(YAMLLINT_VERSION) -c $(YAMLLINT_DIR)/config.yml .
