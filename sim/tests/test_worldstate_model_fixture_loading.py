import json
from pathlib import Path

from sim.models.world_state import WorldState


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_world_state_fixture_loads_through_model() -> None:
    data = json.loads((FIXTURES / "world-state.sample.json").read_text())
    model = WorldState.model_validate(data)
    assert model.tick == 0
    assert model.colony_name == "Candor"
    assert model.air == 100.0
    assert model.food == 100.0
    assert model.power == 100.0
    assert model.labor == 100.0
    assert model.morale == 100.0
