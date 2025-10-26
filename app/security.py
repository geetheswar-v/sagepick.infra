import logging

logger = logging.getLogger(__name__)


def verify_token(secret: str, provided: str | None) -> bool:
    if not provided:
        logger.warning("Rejecting webhook without authentication token")
        return False
    if provided != secret:
        logger.error("Rejecting webhook with invalid authentication token")
        return False
    return True
