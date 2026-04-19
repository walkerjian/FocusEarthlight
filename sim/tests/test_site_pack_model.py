import json
from pathlib import Path

from sim.models.site_pack import SitePack


ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT / "data" / "fixtures"


def test_site_pack_fixture_loads() -> None:
    data = json.loads((FIXTURES / "site-pack.sample.json").read_text())
    model = SitePack.model_validate(data)
    assert model.site_id == "candor"
    assert model.location_status == "real-region-scenario-site"
    assert "Coordinates are placeholders" in model.uncertainty_notes[0]
    assert model.provenance[0].kind == "scaffold"
