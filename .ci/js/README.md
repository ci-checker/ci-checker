# CI – JS

This folder contains the integration of analysis and code quality tools developed in JavaScript.
It is designed to be **modular**: each tool is automatically activated if it is present in the `tools/` folder.

---

## 📦 Operation

- `package.json` — Main JS CI `package.json`: this file uses the `workspaces` concept to include the `package.json` of each tool.
- `gitlab-ci.yml` — Entry point for GitLab CI JS: this file is responsible for including each tool's configuration.
- `tools/` folder — Contains one folder per tool.

### Inclusion in the main `Makefile`

Add this line to your project's root `Makefile`:

```makefile
include .ci/js/Makefile
```

Modify the `CI_JS_EXEC` variable to define the execution line corresponding to your context.

Example using `docker exec` on a running container:
```bash
CI_JS_EXEC=docker exec -it -u <my_container_user> <my_container_name> bash -c
```

Example using `docker run` with a standalone image:
```bash
CI_JS_EXEC=docker run -it --rm -v ./:/app -w /app -u 1000:1000 node bash -c
```

Without this override, tools will run natively on your system.

### Inclusion in GitLab CI

```yaml
include:
  - local: '.ci/js/gitlab-ci.yml'
```

Modify the `CI_JS_IMAGE` variable to define the docker image to be used within the job.

### Inclusion in GitHub CI

For inclusion in GitHub Actions, please refer to the [main CI README](../README.md).

## 🧩 Adding a Tool

To add a new tool, simply add a folder corresponding to the new tool in the `tools/` subfolder.
The system will automatically detect:
- The tool's Makefile if a `Makefile` is present.
- The corresponding GitLab CI job if a `gitlab-ci.yml` file is present.
- The GitHub Action job if a `github-ci.yml` file is present.
