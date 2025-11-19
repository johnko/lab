#!/usr/bin/env bash
set -euxo pipefail

NODE_EXPORTER_VERSION=v1.10.2

apt update -y

apt install -y \
  curl \
  git \
  golang \
  make

cd /root

git clone https://github.com/prometheus/node_exporter.git

cd node_exporter

git checkout $NODE_EXPORTER_VERSION

make build

ls -l ./node_exporter
