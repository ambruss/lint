#!/usr/bin/env bash
CONFIG=.pre-commit-config.yaml
test -f "$CONFIG" && mv "$CONFIG" "$CONFIG.bak"
cp "/lint/$CONFIG" "$CONFIG"
pre-commit run --all-files
EXIT_CODE=$?
test -f "$CONFIG.bak" && mv "$CONFIG.bak" "$CONFIG"
exit "$EXIT_CODE"
