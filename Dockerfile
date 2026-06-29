FROM python:3.11
RUN pip install --no-cache-dir chromadb
EXPOSE 8000
CMD ["chroma", "run", "--host", "0.0.0.0", "--port", "8000", "--path", "/chroma/chroma"]
