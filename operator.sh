#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

# make sure you've got `kubectl proxy` running

while read -r event; do
  echo "$event" \
    | jq -r '"\(.type) \(.object.metadata.namespace)/\(.object.metadata.name)"'
done < <(http --stream :8001/api/v1/pods?watch)

