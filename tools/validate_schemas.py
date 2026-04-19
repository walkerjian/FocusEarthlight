from __future__ import annotations
import json
from pathlib import Path
from jsonschema import validate

ROOT = Path(__file__).resolve().parents[1]

def main() -> None:
    pairs = [
        ("data/fixtures/hypothesis-card.sample.json", "schemas/hypothesis-card.schema.json"),
        ("data/fixtures/world-state.sample.json", "schemas/world-state.schema.json"),
        ("data/fixtures/site-pack.sample.json", "schemas/site-pack.schema.json"),
        ("data/fixtures/audit-record.sample.json", "schemas/audit-record.schema.json"),
        ("data/fixtures/event-object.sample.json", "schemas/event-object.schema.json"),
    ]
    for fixture_rel, schema_rel in pairs:
        fixture = json.loads((ROOT / fixture_rel).read_text())
        schema = json.loads((ROOT / schema_rel).read_text())
        validate(instance=fixture, schema=schema)
        print(f"validated {fixture_rel}")

if __name__ == "__main__":
    main()
