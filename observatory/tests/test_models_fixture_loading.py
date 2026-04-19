import json
from pathlib import Path

from observatory.models.audit_record import AuditRecord
from observatory.models.event import EventObject
from observatory.models.source_record import SourceRecord


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_audit_record_fixture_loads() -> None:
    data = json.loads((FIXTURES / "audit-record.sample.json").read_text())
    model = AuditRecord.model_validate(data)
    assert model.id == "audit_001"


def test_event_object_fixture_loads() -> None:
    data = json.loads((FIXTURES / "event-object.sample.json").read_text())
    model = EventObject.model_validate(data)
    assert model.id == "event_001"


def test_source_record_fixture_loads() -> None:
    data = json.loads((FIXTURES / "source-record.sample.json").read_text())
    model = SourceRecord.model_validate(data)
    assert model.id == "source_001"
