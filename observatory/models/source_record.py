from pydantic import BaseModel


class SourceRecord(BaseModel):
    schema_version: str = "0.1.0"
    id: str
    source_type: str
    title: str | None = None
    url: str | None = None
    provenance: str
