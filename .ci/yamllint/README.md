# [Yamllint](https://yamllint.readthedocs.io)

There are no true Yaml standards to follow, but this tool ensures that the same convention is adopted across all Yaml files in the project.
Configuration can be found in the `config.yml` file.

---

## 📦 Operation

### Inclusion in the main `Makefile`

Add this line to your project's root `Makefile`:

```makefile
include .ci/yamllint/Makefile
```

### Inclusion in GitLab CI

```yaml
include:
  - local: '/.ci/yamllint/gitlab-ci.yml'
```

### Inclusion in GitHub CI

For inclusion in GitHub Actions, please refer to the [main CI README](../README.md#-github-actions).
