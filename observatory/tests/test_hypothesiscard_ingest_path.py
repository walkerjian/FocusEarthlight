import json
from pathlib import Path

from observatory.models.hypothesis_card import HypothesisCard


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_hypothesis_card_fixture_loads_through_model() -> None:
    data = json.loads((FIXTURES / "hypothesis-card.sample.json").read_text())
    model = HypothesisCard.model_validate(data)
    assert model.id == "hc_001"
    assert model.claim_type == "causal"
    assert model.review_date == "2026-05-01"
