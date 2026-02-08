CI_PHP_EXEC ?= bash -c
CI_PHP_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
CI_PHP_COLOR=\033[33m
CI_PHP_COLOR_RESET=\033[0m

define ci-php-text-title
  printf "\n$(CI_PHP_COLOR)****************************************************************\n"
  printf "*$(1)\n"
  printf "$(CI_PHP_COLOR)****************************************************************$(CI_PHP_COLOR_RESET)\n\n"
endef

define ci-php-composer
	if $(CI_PHP_EXEC) "composer --working-dir=$(CI_PHP_DIR) $(1)"; then \
		printf "\n✅ [SUCCESS] completed successfully\n\n"; \
	else \
		printf "\n❌ [ERROR] failed\n\n"; \
		exit 1; \
	fi
endef

define ci-php-composer-run
	$(if $(2),,$(call ci-php-text-title, Running : $@))
	$(call ci-php-composer, run-script $(1))
endef

$(CI_PHP_DIR)/vendor: $(CI_PHP_DIR)/composer.lock
	$(call ci-php-text-title, Installing CI composer dependencies)
	$(call ci-php-composer , install)
	@touch -r $(CI_PHP_DIR)/composer.lock $(CI_PHP_DIR)/vendor

$(CI_PHP_DIR)/composer.lock:
	$(call ci-php-text-title, Generating composer.lock. Do not forget to commit it !)
	$(call ci-php-composer, install)

ci-php-prepare: $(CI_PHP_DIR)/vendor


##
## CI - PHP Tools
## -------
##
ci-php-update: ## Upgrade CI PHP dependencies
	$(call ci-php-composer, update)

include $(CI_PHP_DIR)/tools/**/Makefile
