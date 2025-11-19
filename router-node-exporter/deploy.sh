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

if $DOCKER_BIN ps -a | grep build-router-node-exporter | grep -q Up; then
  $DOCKER_BIN cp build-router-node-exporter:/root/node_exporter/node_exporter ./node_exporter
  ssh router 'set -ex ; mkdir -p /tmp/home/root/bin'
  for i in node_exporter start.sh; do
    # shellcheck disable=SC2029
    tar czvf - ./$i | ssh router "cat > /tmp/home/root/bin/deploy_$i.tgz"
    # shellcheck disable=SC2029
    ssh router "set -ex ; cd /tmp/home/root/bin && tar tzvf ./deploy_$i.tgz && tar xzvf ./deploy_$i.tgz && rm -v /tmp/home/root/bin/deploy_$i.tgz && chown \$USER:root /tmp/home/root/bin/$i && ls -l /tmp/home/root/bin/$i"
  done
  ssh router 'set -ex ; test -e /tmp/home/root/bin/._start.sh && rm /tmp/home/root/bin/._start.sh'
  ssh router 'set -ex ; ls -al /tmp/home/root/bin/'
  echo "OK: deployed 'node_exporter' to router"
else
  echo "ERROR: container 'build-router-node-exporter' not running, please run build.sh first"
  exit 1
fi
