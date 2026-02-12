rector: ci-php-prepare ## Analyze code and suggest improvements using Rector (dry run only)
	$(call ci-php-composer-run , rector:dry)

rector-fix: ci-php-prepare ## Automatically refactor code with Rector based on defined rules
	$(call ci-php-composer-run , rector)
