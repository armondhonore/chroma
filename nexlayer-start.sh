#!/usr/bin/env bash
# Start Chroma on an internal loopback port and put nginx in front on 8000.
# nginx redirects the bare "/" (which Chroma 404s by design) to "/docs" so the
# public routed path resolves to a 3xx/2xx, and proxies everything else through.
set -o errexit

echo "[nexlayer] starting chroma on 127.0.0.1:8001..."
chroma run --host 127.0.0.1 --port 8001 --path /chroma/chroma &

# Wait for chroma to accept connections before nginx starts proxying.
for i in $(seq 1 60); do
  if curl -fsS -o /dev/null "http://127.0.0.1:8001/api/v2/heartbeat" 2>/dev/null; then
    echo "[nexlayer] chroma is up."
    break
  fi
  echo "[nexlayer] waiting for chroma... ($i)"
  sleep 1
done

echo "[nexlayer] starting nginx (foreground) on :8000..."
exec nginx -g 'daemon off;'
