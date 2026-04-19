import json
from pathlib import Path

from observatory.models.event import EventObject
from observatory.models.source_record import SourceRecord


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_event_object_references_existing_source_record() -> None:
    event_data = json.loads((FIXTURES / "event-object.sample.json").read_text())
    source_data = json.loads((FIXTURES / "source-record.sample.json").read_text())

    event = EventObject.model_validate(event_data)
    source = SourceRecord.model_validate(source_data)

    assert source.id in event.source_ids
    assert event.source_ids == ["source_001"]
    assert source.id == "source_001"
