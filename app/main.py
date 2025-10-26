import logging
import shutil
import subprocess
from pathlib import Path
from typing import Any

from fastapi import Depends, FastAPI, HTTPException, status

from .config import settings
from .helper import require_token

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

app = FastAPI(title="Sagepick Deploy Webhooks")


def run_compose_commands(core_dir: Path) -> list[dict[str, str]]:
    commands = (
        ["docker", "compose", "pull"],
        ["docker", "compose", "up", "-d"],
    )

    if shutil.which("docker") is None:
        logger.warning("Docker binary not found; returning dry-run status")
        return [{"command": " ".join(cmd), "status": "skipped"} for cmd in commands]

    results: list[dict[str, str]] = []
    for cmd in commands:
        completed = subprocess.run(cmd, cwd=core_dir, capture_output=True, text=True)
        if completed.returncode != 0:
            logger.error("Command failed (%s): %s", " ".join(cmd), completed.stderr.strip())
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=completed.stderr.strip())
        results.append(
            {
                "command": " ".join(cmd),
                "status": "ok",
                "stdout": completed.stdout.strip(),
            }
        )
    return results


@app.post("/core", status_code=status.HTTP_202_ACCEPTED)
async def core_webhook(_: None = Depends(require_token)) -> dict[str, Any]:
    try:
        core_dir = (settings.APP_ROOT_PATH / "core").resolve()
    except OSError as exc:
        logger.error("Failed to prepare core layout: %s", exc)
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(exc)) from exc

    command_results = run_compose_commands(core_dir)

    logger.info("Core service refreshed via webhook")

    return {
        "status": "accepted",
        "commands": command_results,
    }


@app.get("/healthz", status_code=status.HTTP_200_OK)
async def healthcheck() -> dict[str, str]:
    return {"status": "ok"}
