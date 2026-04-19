import json
from pathlib import Path

from observatory.models.audit_record import AuditRecord


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_audit_record_fixture_loads_through_model() -> None:
    data = json.loads((FIXTURES / "audit-record.sample.json").read_text())
    model = AuditRecord.model_validate(data)
    assert model.id == "audit_001"
    assert model.record_type == "analysis"
    assert model.outcome == "pending"
