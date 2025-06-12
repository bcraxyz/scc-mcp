# Stage 1 — Build
FROM python:3.11-slim AS build

WORKDIR /app
COPY pyproject.toml scc_mcp.py ./

RUN pip install --prefix=/python-deps --no-cache-dir .

# Stage 2 — Run (Distroless)
FROM gcr.io/distroless/python3-debian12

WORKDIR /app
COPY --from=build /python-deps /python-deps
COPY --from=build /app /app

ENV PYTHONPATH="/python-deps/lib/python3.11/site-packages"

USER nonroot
EXPOSE 8000

ENTRYPOINT ["python", "scc_mcp.py"]
