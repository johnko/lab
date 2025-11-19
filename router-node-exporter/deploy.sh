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

if $DOCKER_BIN ps -a | grep build-router-node-exporter | grep Up; then
  $DOCKER_BIN cp build-router-node-exporter:/root/node_exporter/node_exporter ./node_exporter
  ssh router 'set -ex ; mkdir -p /tmp/home/root/bin'
  tar czvf - ./node_exporter | ssh router 'cat > /tmp/home/root/bin/deploy_node_exporter.tgz'
  ssh router 'set -ex ; cd /tmp/home/root/bin && tar tzvf ./deploy_node_exporter.tgz && tar xzvf ./deploy_node_exporter.tgz && rm -v /tmp/home/root/bin/deploy_node_exporter.tgz && chown $USER:root /tmp/home/root/bin/node_exporter && ls -l /tmp/home/root/bin/node_exporter'
else
  echo "ERROR: container 'build-router-node-exporter' not running, please run build.sh first"
  exit 1
fi
