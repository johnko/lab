#!/usr/bin/env bash
set -euo pipefail

if type docker &>/dev/null; then
  DOCKER_BIN=docker
else
  if type podman &>/dev/null; then
    DOCKER_BIN=podman
  fi
fi

set -x

$DOCKER_BIN rm -f build-router-node-exporter || true

$DOCKER_BIN build -t build-router-node-exporter:latest .

$DOCKER_BIN run --rm --interactive --tty --entrypoint bash --name build-router-node-exporter build-router-node-exporter:latest
