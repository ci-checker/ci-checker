CI_JS_EXEC ?= bash -c
CI_JS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
CI_JS_COLOR=\033[33m
CI_JS_COLOR_RESET=\033[0m

define ci-js-text-title
  printf "\n$(CI_JS_COLOR)****************************************************************\n"
  printf "*$(1)\n"
  printf "$(CI_JS_COLOR)****************************************************************$(CI_JS_COLOR_RESET)\n\n"
endef

define ci-js-npm
	if $(CI_JS_EXEC) "npm --prefix $(CI_JS_DIR) --workspaces --if-present $(1)"; then \
		printf "\n✅ [SUCCESS] completed successfully\n\n"; \
	else \
		printf "\n❌ [ERROR] failed\n\n"; \
		exit 1; \
	fi
endef

define ci-js-npm-run
	$(if $(2),,$(call ci-js-text-title, Running : $@))
	$(call ci-js-npm, run $(1))
endef

$(CI_JS_DIR)/node_modules: $(CI_JS_DIR)/package-lock.json
	$(call ci-js-text-title, Installing CI npm dependencies)
	$(call ci-js-npm, install --no-fund --no-audit)
	@touch -r $(CI_JS_DIR)/package-lock.json $(CI_JS_DIR)/node_modules

$(CI_JS_DIR)/package-lock.json:
	$(call ci-js-text-title, Generating package-lock.json. Do not forget to commit it !)
	$(call ci-js-npm, install)

ci-js-prepare: $(CI_JS_DIR)/node_modules

##
## CI: Javascript Tools
## -------
##

ci-js-update: ## Upgrade CI JS dependencies
	$(call ci-js-npm, update)

include $(CI_JS_DIR)/tools/**/Makefile
