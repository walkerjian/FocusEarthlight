import json
from pathlib import Path

from sim.models.site_pack import SitePack


ROOT = Path(__file__).resolve().parents[2]
FIXTURE = ROOT / "data" / "fixtures" / "site-pack.sample.json"


def test_site_pack_preserves_knowledge_layer_separation() -> None:
    data = json.loads(FIXTURE.read_text())
    model = SitePack.model_validate(data)

    assert model.knowledge_layers.observation
    assert model.knowledge_layers.inference
    assert model.knowledge_layers.scenario_assumption
    assert "Coordinates are placeholders" in model.uncertainty_notes[0]
    assert all(
        "Coordinates are placeholders" not in inference
        for inference in model.knowledge_layers.inference
    )
