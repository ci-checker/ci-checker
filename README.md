# CI Checker

Copy one folder. Get a full quality pipeline — locally and in CI — with zero surprises.

## The Problem

Setting up code quality tools on a project means juggling multiple concerns: installing tools, configuring them, writing CI pipelines, and hoping your local checks match what runs in CI. Tools often end up mixed into your project's dependencies, creating version conflicts and bloated lock files.

## The Solution

CI Checker is a self-contained `.ci` folder that you drop into any project. It brings:

- **Isolated dependencies** — Quality tools live in `.ci/`, completely separate from your project's `composer.json` and `package.json`. No version conflicts, no bloat.
- **Same result everywhere** — Tools run under the same conditions locally and in CI (same versions, same configuration). No more "works on my machine" surprises.
- **GitLab CI + GitHub Actions, out of the box** — Each tool ships with pre-configured pipeline definitions for both platforms. No YAML to write from scratch.
- **Pick what you need** — Copy the folder, remove the tools you don't use, done.

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

You can also define a convenience target in your project's `Makefile` to run all the tools you selected at once:

```makefile
check: phpstan php-cs-fixer rector-fix eslint stylelint yamllint
```

## How It Works

Each tool provides a consistent set of files:

```
README.md       # Documentation
Makefile        # Local execution via Make
gitlab-ci.yml   # GitLab CI job definition
github-ci.yml   # GitHub Actions workflow definition
config.*        # Tool-specific configuration
```

See the [detailed documentation](.ci/README.md) for more information.

## Prerequisites

- [Make](https://www.gnu.org/software/make/)
- [Docker](https://www.docker.com/) (recommended, but not required for PHP and JS tools)

## License

[GPL-3.0](LICENSE)
