from pydantic import BaseModel

class WorldState(BaseModel):
    schema_version: str = "0.1.0"
    tick: int
    colony_name: str
    air: float
    food: float
    power: float
    labor: float
    morale: float
