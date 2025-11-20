#!/usr/bin/env bash
set -exo pipefail

BACKGROUND="$1"
if [[ -z $BACKGROUND ]]; then
  BACKGROUND=""
fi

set -u

NODE_EXPORT_ARGS=" \
--no-collector.filesystem \
--no-collector.netdev.netlink \
--web.disable-exporter-metrics
"
# --no-collector.filesystem because it's complaining and no realy disk to monitor in router anyway
# --no-collector.netdev.netlink to fall back to /proc/net/dev https://github.com/prometheus/node_exporter/issues/2502
# --web.disable-exporter-metrics to not monitor itself

# no pgrep in router
# shellcheck disable=SC2009
if ps | grep -v grep | grep node_exporter; then
  echo 'ERROR: already running'
  exit 1
fi

if [[ "nohup" == "$BACKGROUND" ]]; then
  # shellcheck disable=SC2086
  nohup /tmp/home/root/bin/node_exporter $NODE_EXPORT_ARGS >/dev/null 2>&1 &
else
  # shellcheck disable=SC2086
  /tmp/home/root/bin/node_exporter $NODE_EXPORT_ARGS
fi
