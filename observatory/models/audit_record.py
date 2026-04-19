from pydantic import BaseModel


class AuditRecord(BaseModel):
    schema_version: str = "0.1.0"
    id: str
    record_type: str
    created_at: str
    summary: str
    references: list[str] = []
    outcome: str | None = None
