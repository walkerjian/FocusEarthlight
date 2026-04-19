import json
from pathlib import Path

from observatory.models.event import EventObject


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_event_object_fixture_loads_through_model() -> None:
    data = json.loads((FIXTURES / "event-object.sample.json").read_text())
    model = EventObject.model_validate(data)
    assert model.id == "event_001"
    assert model.event_type == "local_ops"
    assert model.source_ids == ["source_001"]
