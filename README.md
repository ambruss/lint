# flywheel/lint

Docker image for running format checks and linters in pre-commit/CI.

## Usage

### Running locally

```bash
docker run --rm -v $(pwd):/src flywheel/lint
```

### Running in CI

```yaml
stages:
  - test
  - lint

...

includes:
  - repo: flywheel/tools/lint
    file: ci-template.yaml
    ref: master

```


## Development

```bash
pre-commit install
```
