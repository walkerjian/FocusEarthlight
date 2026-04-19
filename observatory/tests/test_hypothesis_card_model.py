import json
from pathlib import Path

from observatory.models.hypothesis_card import HypothesisCard


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_hypothesis_card_fixture_loads() -> None:
    data = json.loads((FIXTURES / "hypothesis-card.sample.json").read_text())
    model = HypothesisCard.model_validate(data)
    assert model.id == "hc_001"
    assert model.confidence == 0.45
    assert len(model.alternative_hypotheses) > 0
    assert len(model.falsifiers) > 0
    assert model.review_date == "2026-05-01"
