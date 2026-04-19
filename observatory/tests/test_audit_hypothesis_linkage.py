import json
from pathlib import Path

from observatory.models.audit_record import AuditRecord
from observatory.models.hypothesis_card import HypothesisCard


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_audit_record_references_existing_hypothesis_card() -> None:
    audit_data = json.loads((FIXTURES / "audit-record.sample.json").read_text())
    hypothesis_data = json.loads((FIXTURES / "hypothesis-card.sample.json").read_text())

    audit_record = AuditRecord.model_validate(audit_data)
    hypothesis_card = HypothesisCard.model_validate(hypothesis_data)

    assert hypothesis_card.id in audit_record.references
    assert audit_record.references == ["hc_001"]
    assert hypothesis_card.id == "hc_001"
