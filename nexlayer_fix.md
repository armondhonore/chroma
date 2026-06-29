# Nexlayer build guidance

Deploy the PREBUILT official image `ghcr.io/chroma-core/chroma:1.0.15` directly.
Do NOT build Chroma from source (the generated rust/protoc/maturin build fails at
`make -C idl proto_python`) and do NOT generate a Dockerfile — there is no
Dockerfile in this branch on purpose so the pipeline deploys the image as-is.

Chroma returns 404 at `/` by design and 410 for the deprecated `/api/v1`. The
real health/landing paths are `/docs` (Swagger UI, 200/3xx) and
`/api/v2/heartbeat` (200). Keep `path: /` and servicePort 8000.

Pinned: true
