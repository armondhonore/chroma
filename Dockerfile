FROM python:3.11

# nginx fronts Chroma so the bare "/" redirects to "/docs" (Chroma 404s on "/").
RUN apt-get update \
    && apt-get install -y --no-install-recommends nginx curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir chromadb

COPY nexlayer-nginx.conf /etc/nginx/conf.d/default.conf
COPY nexlayer-start.sh /usr/local/bin/nexlayer-start.sh
RUN chmod +x /usr/local/bin/nexlayer-start.sh \
    && rm -f /etc/nginx/sites-enabled/default

EXPOSE 8000
CMD ["/usr/local/bin/nexlayer-start.sh"]
