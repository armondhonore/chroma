# Nexlayer build guidance (do not regenerate Dockerfile)

The root `Dockerfile` is hand-authored: it installs Chroma plus nginx, and runs
`nexlayer-start.sh`, which launches `chroma` on 127.0.0.1:8001 and puts nginx on
:8000 in front. nginx redirects the bare `/` (which Chroma returns 404 for, by
design) to `/docs` (Swagger UI, 200) and proxies everything else through to
Chroma. This makes the public routed path resolve to a 3xx/2xx instead of 404.

Do NOT regenerate the Dockerfile. Do NOT drop nginx or the redirect. Keep
servicePort 8000 and `path: /`.

Pinned: true
