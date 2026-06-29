# Nexlayer build guidance

Build from the simple root `Dockerfile` (`pip install chromadb`, run the chroma
server). Do NOT generate a Chroma-from-source (rust/protoc/maturin) build — that
build fails at `make -C idl proto_python` and is unnecessary; the pip package
provides the server.

Chroma returns 404 at `/` by design and 410 for the deprecated `/api/v1`. The pod
`path` is set to `/docs` (Swagger UI, 2xx/3xx) so the routed public path resolves.
`/api/v2/heartbeat` returns 200.

Pinned: true
