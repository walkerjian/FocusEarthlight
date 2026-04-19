import json
from pathlib import Path

from jsonschema import validate

from sim.models.site_pack import SitePack


ROOT = Path(__file__).resolve().parents[2]
FIXTURE = ROOT / "data" / "fixtures" / "site-pack.sample.json"
SCHEMA = ROOT / "schemas" / "site-pack.schema.json"


def test_site_pack_json_roundtrip() -> None:
    original_data = json.loads(FIXTURE.read_text())
    model = SitePack.model_validate(original_data)

    dumped_data = model.model_dump(mode="python")
    schema = json.loads(SCHEMA.read_text())

    validate(instance=dumped_data, schema=schema)

    assert dumped_data["knowledge_layers"] == original_data["knowledge_layers"]
    assert dumped_data["provenance"] == original_data["provenance"]
    assert dumped_data["revision_history"] == original_data["revision_history"]
