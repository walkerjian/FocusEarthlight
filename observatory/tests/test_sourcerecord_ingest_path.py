import json
from pathlib import Path

from observatory.models.source_record import SourceRecord


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_source_record_fixture_loads_through_model() -> None:
    data = json.loads((FIXTURES / "source-record.sample.json").read_text())
    model = SourceRecord.model_validate(data)
    assert model.id == "source_001"
    assert model.source_type == "news_article"
    assert model.provenance == "Sample source fixture for provenance linkage testing."
