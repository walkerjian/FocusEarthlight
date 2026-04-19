from pydantic import BaseModel


class Coordinates(BaseModel):
    latitude: float
    longitude: float


class KnowledgeLayers(BaseModel):
    observation: list[str]
    inference: list[str]
    scenario_assumption: list[str]


class SitePack(BaseModel):
    schema_version: str = "0.1.0"
    site_id: str
    name: str
    world_body: str
    location_status: str
    coordinates: Coordinates | None = None
    knowledge_layers: KnowledgeLayers
    terrain_summary: str | None = None
    hazard_summary: str | None = None
    uncertainty_notes: list[str] = []
    provenance: list[str]
    revision_history: list[str]
    notes: str | None = None
