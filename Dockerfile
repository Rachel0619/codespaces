FROM python:3.13.5-slim-bookworm

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV PATH="/app/.venv/bin:$PATH"

WORKDIR /app

COPY ".python-version" "pyproject.toml" "uv.lock" "./"
RUN uv sync --locked

COPY "predict.py" "model.bin" "./"

EXPOSE 9696

ENTRYPOINT ["uvicorn", "predict:app", "--host", "0.0.0.0", "--port", "9696"]