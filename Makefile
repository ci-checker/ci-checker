ifndef VERBOSE
.SILENT:
endif

CI_PHP_EXEC=docker run -it --rm -v ./:/app -w /app -u 1000:1000 composer/composer  bash -c
include .ci/php/Makefile

CI_JS_EXEC=docker run -it --rm -v ./:/app -w /app -u 1000:1000 node bash -c
include .ci/js/Makefile

include .ci/yamllint/Makefile

check: phpstan twig-cs-fixer rector-fix php-cs-fixer composer-require-checker eslint stylelint yamllint ## Run a full check before committing

run:
	$(CI_PHP_EXEC) "composer install";
	$(CI_JS_EXEC) "npm install";
	$(MAKE) check

.DEFAULT_GOAL := help
help:
	@grep -Eh '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
