from pathlib import Path
from pydantic_settings import BaseSettings, SettingsConfigDict


class AppSettings(BaseSettings):
    WEBHOOK_SECRET: str

    APP_ROOT_PATH: Path

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8"
    )

# Single instance
settings = AppSettings()