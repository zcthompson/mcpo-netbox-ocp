#!/bin/sh
set -e

# Optionally debug:
echo "API_TOKEN is: $API_TOKEN"

export UV_NATIVE_TLS=true

# Run mcpo with TLS enabled and token passed
exec uvx mcpo \
  --host 0.0.0.0 \
  --port 8000 \
  --api-key "$API_TOKEN" \
  -- \
  uv --directory /app/netbox-mcp-server run server.py
