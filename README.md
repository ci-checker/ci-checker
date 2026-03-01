# CI Checker

Copy one folder. Get a full quality pipeline — locally and in CI — with zero surprises.

![demo](docs/demo.gif)

## The Problem

Every project needs code quality checks. But setting them up means repeating the same work: installing tools, pinning versions, writing CI config, and hoping local runs match what happens in CI. Across multiple projects or repositories, this friction compounds — configs drift, versions diverge, and the pipeline becomes a source of uncertainty rather than confidence.

## The Solution

CI Checker is a self-contained `.ci` folder you drop into any project. Quality tools live entirely inside it, isolated from your project's own dependencies.

- **Isolated dependencies** — Tools are installed in `.ci/`, separate from `composer.json` and `package.json`. No version conflicts, no lock file pollution.
- **Same result everywhere** — Local and CI runs use identical versions and configuration. What passes locally will pass in CI.
- **GitLab CI + GitHub Actions, ready to use** — Each tool ships with pre-configured pipeline definitions for both platforms.
- **Pick what you need** — Delete the tools you won't use. Each one is fully self-contained.

## Quick Start

### 1. Add the `.ci` folder to your project

From your project's root directory:

```bash
curl -sL https://github.com/adpeyre/ci-checker/archive/refs/heads/main.tar.gz | tar xz --strip-components=1 --wildcards '*/.ci'
```

### 2. Keep only the tools you need

Each tool is self-contained in its own directory. Simply delete the ones you won't use.

### 3. Adapt the tool configurations

Each tool comes with a default configuration. Review and adjust it to match your project's needs (analysis paths, coding rules, etc.). Refer to each tool's `README.md` for details.

### 4. Wire up the Makefile and CI

Include the Makefiles and CI configurations for the tools you kept. Each technology's README explains how to do this, including Docker configuration:

- [PHP](.ci/php/README.md)
- [JS](.ci/js/README.md)
- [yamllint](.ci/yamllint/README.md)

For GitHub Actions, see the [CI documentation](.ci/README.md).

### 5. Run

Each tool registers its own Make target. You can run them individually:

```bash
make phpstan  # Run a specific tool
make eslint
```

Or define a combined target in your project's `Makefile`:

```makefile
check: phpstan php-cs-fixer rector-fix eslint stylelint yamllint
```

## Folder Structure

```
.ci/
├── php/
│   └── tools/
│       ├── phpstan/
│       ├── php-cs-fixer/
│       ├── rector/
│       ├── twig-cs-fixer/
│       └── composer-require-checker/
├── js/
│   └── tools/
│       ├── eslint/
│       └── stylelint/
└── yamllint/
```

Each tool follows the same layout:

```
README.md       # Documentation
Makefile        # Local execution via Make
gitlab-ci.yml   # GitLab CI job definition
github-ci.yml   # GitHub Actions workflow definition
config.*        # Tool-specific configuration
```

See the [detailed documentation](.ci/README.md) for more information.

## Available Tools

### PHP

| Tool | Purpose |
|------|---------|
| [PHPStan](.ci/php/tools/phpstan/) | Static analysis — catches bugs, wrong types, dead code |
| [PHP-CS-Fixer](.ci/php/tools/php-cs-fixer/) | Automatic code formatting to follow PHP standards |
| [Rector](.ci/php/tools/rector/) | Automated refactoring and PHP version upgrades |
| [Twig CS Fixer](.ci/php/tools/twig-cs-fixer/) | Enforces coding standards on Twig templates |
| [Composer Require Checker](.ci/php/tools/composer-require-checker/) | Detects missing dependencies in `composer.json` |

### JavaScript

| Tool | Purpose |
|------|---------|
| [ESLint](.ci/js/tools/eslint/) | Static analysis for JavaScript code |
| [Stylelint](.ci/js/tools/stylelint/) | Linting for CSS/SCSS stylesheets |

### YAML

| Tool | Purpose |
|------|---------|
| [yamllint](.ci/yamllint/) | Validates YAML file syntax and conventions |

## Prerequisites

- [Make](https://www.gnu.org/software/make/)
- [Docker](https://www.docker.com/) (recommended, but not required for PHP and JS tools)

## License

[GPL-3.0](LICENSE)
