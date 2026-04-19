from pydantic import BaseModel


class EventObject(BaseModel):
    schema_version: str = "0.1.0"
    id: str
    title: str
    event_type: str
    summary: str | None = None
    claims: list[str]
    source_ids: list[str] = []
