COPY pyproject.toml .
RUN pip install .
COPY . .
CMD ["scc_mcp"]
