import json
import shutil
from pathlib import Path

from jsonschema import validate

from sim.engine.tick import run_tick
from sim.models.world_state import WorldState


ROOT = Path(__file__).resolve().parents[2]
FIXTURE = ROOT / "data" / "fixtures" / "world-state.sample.json"
SCHEMA = ROOT / "schemas" / "world-state.schema.json"
RUNTIME = ROOT / "runtime"
STATE_FILE = RUNTIME / "world-state.json"


def test_worldstate_json_roundtrip() -> None:
    RUNTIME.mkdir(exist_ok=True)
    shutil.copyfile(FIXTURE, STATE_FILE)

    original_data = json.loads(STATE_FILE.read_text())
    original_model = WorldState.model_validate(original_data)

    updated_model = run_tick(original_model)
    STATE_FILE.write_text(updated_model.model_dump_json(indent=2))

    reloaded_data = json.loads(STATE_FILE.read_text())
    reloaded_model = WorldState.model_validate(reloaded_data)
    schema = json.loads(SCHEMA.read_text())

    validate(instance=reloaded_data, schema=schema)

    assert reloaded_model.tick == 1
    assert reloaded_model == updated_model
