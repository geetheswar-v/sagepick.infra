from fastapi import Header, HTTPException, status

from .config import settings
from .security import verify_token

async def require_token(x_webhook_token: str | None = Header(default=None, alias="X-Webhook-Token")) -> None:
    if not verify_token(settings.WEBHOOK_SECRET, x_webhook_token):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Unauthorized")