# CI Configuration

This folder contains all the configurations for CI (Continuous Integration) tools.

## Execution Contexts

- `Makefile` targets for local execution
- GitLab jobs for GitLab execution
- GitHub Actions workflows for GitHub execution

### Makefile

Activating tools involves including their respective `Makefile` in your project's main `Makefile`.

### GitLab CI

Activating tools involves including their respective templates in your project's `.gitlab-ci.yml` file.

### GitHub Actions

Unlike GitLab, GitHub Actions does not allow dynamic inclusion of files located outside the `.github/workflows/` folder. For your tools to be activated, their configuration files must be physically present in this folder.

To simplify management and avoid manual duplication, a synchronization script is provided: `github-workflows-sync.sh`.

This script is responsible for replicating the `github-ci.yml` files from your various contexts to the `.github/workflows/` folder, renaming them appropriately.

**Usage:**
```bash
bash .ci/github-workflows-sync.sh
```

This script must be run after each addition or modification of a CI tool.

### General Organization

In general, each tool comes with a set of files:
- `README.md` — Associated documentation
- `Makefile` — Tool execution locally
- `gitlab-ci.yml` — For execution on GitLab
- `github-ci.yml` — For execution on GitHub

### Detailed Information

Please refer to each tool's `README.md` documentation.
