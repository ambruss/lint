FROM buildpack-deps:buster

# dockerfile lint
RUN set -eux \
    && curl -LSso /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64 \
    && chmod +x /usr/local/bin/hadolint

# go and go lint
RUN set -eux \
    && curl -LSs https://dl.google.com/go/go1.14.linux-amd64.tar.gz | tar xzC /usr/local \
    && ln -s /usr/local/go/bin/* /usr/local/bin \
    && curl -LSs https://github.com/golangci/golangci-lint/releases/download/v1.29.0/golangci-lint-1.29.0-linux-amd64.tar.gz | tar xz \
    && mv golangci-lint-*-linux-amd64/golangci-lint /usr/local/bin \
    && rm -rf golangci-lint-*-linux-amd64

# helm lint
RUN set -eux \
    && curl -LSs https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz | tar xz \
    && mv linux-amd64/helm /usr/local/bin \
    && rm -rf linux-amd64

# terraform lint
RUN set -eux \
    && curl -LSso tflint.zip https://github.com/terraform-linters/tflint/releases/download/v0.18.0/tflint_linux_amd64.zip \
    && unzip -d /usr/local/bin tflint.zip \
    && rm tflint.zip

# shell lint
RUN set -eux \
    && curl -LSs https://github.com/koalaman/shellcheck/releases/download/v0.7.1/shellcheck-v0.7.1.linux.x86_64.tar.xz | tar -xJ \
    && mv shellcheck-*/shellcheck /usr/local/bin \
    && rm -rf shellcheck-*

# prepare nodejs and python
RUN set -eux \
    && curl -LSs https://deb.nodesource.com/setup_14.x | bash \
    && apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends \
        nodejs \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# nodejs packages
RUN set -eux \
    && npm install --global \
        jsonlint \
        markdownlint-cli

# python packages
RUN set -eux \
    && pip3 install -U setuptools wheel \
    && pip3 install \
        ansible-lint \
        black \
        flake8 \
        isort \
        pipenv \
        pre-commit \
        pylint \
        yamllint

COPY . /lint
WORKDIR /src
CMD ["/lint/run.sh"]
