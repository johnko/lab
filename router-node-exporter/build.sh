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

$DOCKER_BIN build --platform linux/arm64 -t build-router-node-exporter:latest .

cat <<EOF
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!  Keep this container running in this terminal  !!
!!  From another terminal run: bash deploy.sh     !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
EOF

$DOCKER_BIN run --rm --interactive --tty --entrypoint bash --name build-router-node-exporter build-router-node-exporter:latest
