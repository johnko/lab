#!/usr/bin/env bash
set -exuo pipefail

/tmp/home/root/bin/node_exporter \
  --no-collector.filesystem \
  --web.disable-exporter-metrics
