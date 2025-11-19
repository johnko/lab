#!/usr/bin/env bash
set -exuo pipefail

/tmp/home/root/bin/node_exporter \
  --no-collector.filesystem \
  --no-collector.netdev.netlink \
  --web.disable-exporter-metrics

# --no-collector.filesystem because it's complaining and no realy disk to monitor in router anyway
# --no-collector.netdev.netlink to fall back to /proc/net/dev https://github.com/prometheus/node_exporter/issues/2502
# --web.disable-exporter-metrics to not monitor itself
