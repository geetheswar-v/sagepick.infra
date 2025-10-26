## Sagepick Deploy Webhooks

Small FastAPI service that accepts authenticated webhook calls to refresh the Sagepick Service stack.

### Requirements
- Python 3.12+
- Docker CLI available on the host.

### Configuration
Create a `.env` file beside `pyproject.toml`:

```
WEBHOOK_SECRET=super-secret-value
APP_ROOT_PATH=/path/to/deployment/root
```

`APP_ROOT_PATH` must contain a `core/` directory with a `docker-compose.yml`.

### Running locally

```bash
uvicorn app.main:app --reload
```

### Endpoints
- `POST /core` &ndash; requires header `X-Webhook-Token` equal to `WEBHOOK_SECRET`; runs `docker compose pull` then `docker compose up -d` inside `<APP_ROOT_PATH>/core`.
- `GET /healthz` &ndash; simple health check returning `{ "status": "ok" }`.
