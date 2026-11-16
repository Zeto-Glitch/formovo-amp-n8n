#!/usr/bin/env bash
set -euo pipefail

BASE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$BASE/data"

exec /usr/bin/podman run --rm \
  --name formovo-n8n \
  --pull=never \
  -p 127.0.0.1:5678:5678 \
  -v "$BASE/data:/home/node/.n8n:Z" \
  -e N8N_PORT=5678 \
  -e N8N_LISTEN_ADDRESS=0.0.0.0 \
  -e GENERIC_TIMEZONE=Europe/Warsaw \
  -e TZ=Europe/Warsaw \
  -e N8N_HOST=n8n.formovo.pl \
  -e N8N_PROTOCOL=https \
  -e N8N_EDITOR_BASE_URL=https://n8n.formovo.pl/ \
  -e WEBHOOK_URL=https://n8n.formovo.pl/ \
  -e N8N_PROXY_HOPS=1 \
  -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true \
  ghcr.io/n8n-io/n8n:2.47.7
