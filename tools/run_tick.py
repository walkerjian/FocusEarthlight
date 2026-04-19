from __future__ import annotations
import json
from pathlib import Path
from sim.engine.tick import run_tick
from sim.models.world_state import WorldState

ROOT = Path(__file__).resolve().parents[1]
STATE_FILE = ROOT / "runtime" / "world-state.json"

def main() -> None:
    state = WorldState.model_validate(json.loads(STATE_FILE.read_text()))
    updated = run_tick(state)
    STATE_FILE.write_text(updated.model_dump_json(indent=2))
    print(f"tick advanced to {updated.tick}")

if __name__ == "__main__":
    main()
