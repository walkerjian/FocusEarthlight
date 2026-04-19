#!/usr/bin/env bash
set -euo pipefail

say() { printf "\n==> %s\n" "$*"; }
warn() { printf "\n[warn] %s\n" "$*" >&2; }

safe_write() {
  local path="$1"
  if [[ -e "$path" ]]; then
    warn "Exists, skipping: $path"
  else
    mkdir -p "$(dirname "$path")"
    cat > "$path"
    printf "created %s\n" "$path"
  fi
}

safe_mkdir() {
  mkdir -p "$1"
  printf "ensured %s\n" "$1"
}

say "Creating directory tree"
dirs=(
  "docs/adr"
  "docs/diagrams"
  "docs/prompts"
  "schemas"
  "data/seed"
  "data/fixtures"
  "sim/engine"
  "sim/models"
  "sim/tests"
  "observatory/ingest"
  "observatory/analysis"
  "observatory/models"
  "observatory/tests"
  "ui/web/app"
  "ui/web/components"
  "ui/web/lib"
  "ui/web/public"
  "ui/tests"
  "worker/jobs"
  "infra/docker"
  "infra/compose"
  "infra/scripts"
  "tools"
  ".github/ISSUE_TEMPLATE"
  ".github/workflows"
)
for d in "${dirs[@]}"; do
  safe_mkdir "$d"
done

say "Creating Python package markers"
touch sim/__init__.py sim/engine/__init__.py sim/models/__init__.py
touch observatory/__init__.py observatory/ingest/__init__.py observatory/analysis/__init__.py observatory/models/__init__.py
touch worker/__init__.py worker/jobs/__init__.py

safe_write ".gitignore" <<'EOF2'
.DS_Store
__pycache__/
*.py[cod]
.pytest_cache/
.mypy_cache/
.ruff_cache/
.venv/
venv/
dist/
build/
*.egg-info/
node_modules/
.next/
coverage/
.env
.env.local
.vscode/
.idea/
*.sqlite3
*.db
runtime/
artifacts/
EOF2

safe_write ".editorconfig" <<'EOF2'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true

[*.py]
indent_size = 4

[Makefile]
indent_style = tab
EOF2

safe_write ".env.example" <<'EOF2'
APP_ENV=development
DATABASE_URL=sqlite:///runtime/focus_earthlight.db
EARTH_SIGNAL_ENABLE=false
EARTH_SIGNAL_FEEDS=
EOF2

safe_write "LICENSE" <<'EOF2'
TBD: choose a license.
Suggested starting point:
- MIT for code
- CC BY-SA or similar for design docs
EOF2

safe_write "README.md" <<'EOF2'
# FOCUS: Earthlight

A persistent colony-world platform combining:
- high-fidelity space-settlement simulation
- AI-assisted organic narrative and mission generation
- reflective analysis of manipulation, power, and rhetoric
- optional real-world signal intake from Earth news
- Popperian constitutional rules

## Core principles
1. Preserve the constitution and schema clarity.
2. Prefer boring, legible implementations.
3. Separate observation, inference, prediction, recommendation, and rhetoric.
4. Keep all state versioned and replayable.
5. No hidden magic, no silent coupling.
EOF2

safe_write "Makefile" <<'EOF2'
PYTHON ?= python3

.PHONY: venv install test lint format ui-install ui-dev validate seed tick

venv:
	$(PYTHON) -m venv .venv

install:
	. .venv/bin/activate && pip install -e ".[dev]"

test:
	. .venv/bin/activate && pytest

lint:
	. .venv/bin/activate && ruff check .

format:
	. .venv/bin/activate && black .

ui-install:
	cd ui/web && npm install

ui-dev:
	cd ui/web && npm run dev

validate:
	. .venv/bin/activate && python tools/validate_schemas.py

seed:
	. .venv/bin/activate && python tools/seed_world.py

tick:
	. .venv/bin/activate && python tools/run_tick.py
EOF2

safe_write "pyproject.toml" <<'EOF2'
[build-system]
requires = ["setuptools>=68", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "focus-earthlight"
version = "0.1.0"
description = "FOCUS: Earthlight simulation and observatory platform"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
  "pydantic>=2.8",
  "jsonschema>=4.23",
]

[project.optional-dependencies]
dev = [
  "pytest>=8.3",
  "ruff>=0.6",
  "black>=24.8",
]

[tool.setuptools]
packages = ["sim", "sim.engine", "sim.models", "observatory", "observatory.ingest", "observatory.analysis", "observatory.models", "worker", "worker.jobs"]

[tool.black]
line-length = 100

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.pytest.ini_options]
testpaths = ["sim/tests", "observatory/tests"]
EOF2

safe_write "package.json" <<'EOF2'
{
  "name": "focus-earthlight-root",
  "private": true,
  "version": "0.1.0"
}
EOF2

safe_write "docs/constitution.md" <<'EOF2'
# Constitution

## Primum mobile
The colony treats all significant claims as provisional conjectures rather than final truths.

## Hard rules
1. Separate observation, inference, prediction, recommendation, and rhetoric.
2. Preserve rival hypotheses where warranted.
3. State what would count against a claim.
4. Keep retrospective score on forecasts and analyses.
5. Reward correction over confidence theatre.
6. No covert optimization for compliance, addiction, or factional capture.
7. Physical world models must distinguish observation, inference, and scenario assumption.
8. Site updates require provenance, uncertainty annotation, and operational consequences.
EOF2

safe_write "schemas/hypothesis-card.schema.json" <<'EOF2'
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://focus-earthlight.local/schemas/hypothesis-card.schema.json",
  "title": "HypothesisCard",
  "type": "object",
  "required": [
    "schema_version",
    "id",
    "claim",
    "claim_type",
    "status",
    "evidence_for",
    "evidence_against",
    "alternative_hypotheses",
    "falsifiers",
    "review_date"
  ],
  "properties": {
    "schema_version": { "type": "string" },
    "id": { "type": "string" },
    "claim": { "type": "string" },
    "claim_type": {
      "type": "string",
      "enum": ["descriptive", "causal", "predictive", "normative", "strategic"]
    },
    "status": {
      "type": "string",
      "enum": ["draft", "active", "revised", "retired"]
    },
    "confidence": { "type": "number", "minimum": 0, "maximum": 1 },
    "evidence_for": { "type": "array", "items": { "type": "string" } },
    "evidence_against": { "type": "array", "items": { "type": "string" } },
    "alternative_hypotheses": { "type": "array", "items": { "type": "string" } },
    "falsifiers": { "type": "array", "items": { "type": "string" } },
    "unknowns": { "type": "array", "items": { "type": "string" } },
    "review_date": { "type": "string", "format": "date" },
    "notes": { "type": "string" }
  },
  "additionalProperties": false
}
EOF2

safe_write "schemas/world-state.schema.json" <<'EOF2'
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://focus-earthlight.local/schemas/world-state.schema.json",
  "title": "WorldState",
  "type": "object",
  "required": [
    "schema_version",
    "tick",
    "colony_name",
    "air",
    "food",
    "power",
    "labor",
    "morale"
  ],
  "properties": {
    "schema_version": { "type": "string" },
    "tick": { "type": "integer", "minimum": 0 },
    "colony_name": { "type": "string" },
    "air": { "type": "number" },
    "food": { "type": "number" },
    "power": { "type": "number" },
    "labor": { "type": "number" },
    "morale": { "type": "number" }
  },
  "additionalProperties": false
}
EOF2

safe_write "data/fixtures/hypothesis-card.sample.json" <<'EOF2'
{
  "schema_version": "0.1.0",
  "id": "hc_001",
  "claim": "The greenhouse power dip was caused by routine load balancing.",
  "claim_type": "causal",
  "status": "active",
  "confidence": 0.45,
  "evidence_for": ["Recent scheduled maintenance in adjacent sector."],
  "evidence_against": ["No confirmed maintenance notice attached to this incident."],
  "alternative_hypotheses": ["Sensor fault", "Unauthorized load draw", "Transient battery bus issue"],
  "falsifiers": ["Verified grid log showing no balancing event occurred at that time."],
  "unknowns": ["Full battery telemetry not yet ingested."],
  "review_date": "2026-05-01",
  "notes": "Starter fixture."
}
EOF2

safe_write "data/fixtures/world-state.sample.json" <<'EOF2'
{
  "schema_version": "0.1.0",
  "tick": 0,
  "colony_name": "Candor",
  "air": 100.0,
  "food": 100.0,
  "power": 100.0,
  "labor": 100.0,
  "morale": 100.0
}
EOF2

safe_write "sim/models/world_state.py" <<'EOF2'
from pydantic import BaseModel

class WorldState(BaseModel):
    schema_version: str = "0.1.0"
    tick: int
    colony_name: str
    air: float
    food: float
    power: float
    labor: float
    morale: float
EOF2

safe_write "sim/engine/tick.py" <<'EOF2'
from sim.models.world_state import WorldState

def run_tick(state: WorldState) -> WorldState:
    return state.model_copy(
        update={
            "tick": state.tick + 1,
            "air": max(0.0, state.air - 0.1),
            "food": max(0.0, state.food - 0.2),
            "power": max(0.0, state.power - 0.15),
            "labor": max(0.0, state.labor - 0.05),
            "morale": max(0.0, min(100.0, state.morale + 0.01))
        }
    )
EOF2

safe_write "observatory/analysis/hypothesis_engine.py" <<'EOF2'
def build_stub_hypothesis_card(event_id: str, claim: str) -> dict:
    return {
        "schema_version": "0.1.0",
        "id": f"hc_{event_id}",
        "claim": claim,
        "claim_type": "causal",
        "status": "draft",
        "confidence": 0.2,
        "evidence_for": [],
        "evidence_against": [],
        "alternative_hypotheses": ["Boring institutional explanation pending"],
        "falsifiers": ["Contrary direct evidence"],
        "unknowns": ["Insufficient evidence ingested yet"],
        "review_date": "2026-05-01",
        "notes": "Auto-generated stub"
    }
EOF2

safe_write "tools/validate_schemas.py" <<'EOF2'
from __future__ import annotations
import json
from pathlib import Path
from jsonschema import validate

ROOT = Path(__file__).resolve().parents[1]

def main() -> None:
    pairs = [
        ("data/fixtures/hypothesis-card.sample.json", "schemas/hypothesis-card.schema.json"),
        ("data/fixtures/world-state.sample.json", "schemas/world-state.schema.json"),
    ]
    for fixture_rel, schema_rel in pairs:
        fixture = json.loads((ROOT / fixture_rel).read_text())
        schema = json.loads((ROOT / schema_rel).read_text())
        validate(instance=fixture, schema=schema)
        print(f"validated {fixture_rel}")

if __name__ == "__main__":
    main()
EOF2

safe_write "tools/seed_world.py" <<'EOF2'
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RUNTIME = ROOT / "runtime"
SEED = ROOT / "data" / "fixtures" / "world-state.sample.json"

def main() -> None:
    RUNTIME.mkdir(exist_ok=True)
    target = RUNTIME / "world-state.json"
    target.write_text(SEED.read_text())
    print(f"seeded {target}")

if __name__ == "__main__":
    main()
EOF2

safe_write "tools/run_tick.py" <<'EOF2'
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
EOF2

safe_write "sim/tests/test_tick.py" <<'EOF2'
from sim.engine.tick import run_tick
from sim.models.world_state import WorldState

def test_run_tick_advances_and_changes_resources() -> None:
    state = WorldState(
        tick=0,
        colony_name="Candor",
        air=100.0,
        food=100.0,
        power=100.0,
        labor=100.0,
        morale=100.0,
    )
    updated = run_tick(state)
    assert updated.tick == 1
    assert updated.air < state.air
    assert updated.food < state.food
    assert updated.power < state.power
EOF2

safe_write "observatory/tests/test_hypothesis_stub.py" <<'EOF2'
from observatory.analysis.hypothesis_engine import build_stub_hypothesis_card

def test_build_stub_hypothesis_card() -> None:
    card = build_stub_hypothesis_card("event_001", "Test claim")
    assert card["id"] == "hc_event_001"
    assert card["claim"] == "Test claim"
    assert card["status"] == "draft"
EOF2

safe_write "ui/web/package.json" <<'EOF2'
{
  "name": "focus-earthlight-ui",
  "private": true,
  "version": "0.1.0",
  "scripts": {
    "dev": "node server.js"
  }
}
EOF2

safe_write "ui/web/server.js" <<'EOF2'
const http = require("http");

const html = `<!doctype html>
<html>
<head>
  <meta charset="utf-8" />
  <title>FOCUS: Earthlight</title>
  <style>
    body { font-family: sans-serif; margin: 2rem; background: #111; color: #eee; }
    .grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1rem; }
    .card { border: 1px solid #444; border-radius: 10px; padding: 1rem; background: #1a1a1a; }
    h1, h2 { margin-top: 0; }
  </style>
</head>
<body>
  <h1>FOCUS: Earthlight</h1>
  <div class="grid">
    <div class="card"><h2>World State</h2><p>Candor placeholder panel.</p></div>
    <div class="card"><h2>Earth Signal Desk</h2><p>Ingest and event clustering will appear here.</p></div>
    <div class="card"><h2>Hypothesis / Audit</h2><p>Structured claim analysis and audit trail will appear here.</p></div>
  </div>
</body>
</html>`;

http.createServer((_, res) => {
  res.writeHead(200, { "Content-Type": "text/html; charset=utf-8" });
  res.end(html);
}).listen(3000, () => {
  console.log("FOCUS UI running at http://localhost:3000");
});
EOF2

safe_write ".github/workflows/ci.yml" <<'EOF2'
name: ci

on:
  push:
  pull_request:

jobs:
  python:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: python -m pip install --upgrade pip
      - run: pip install -e ".[dev]"
      - run: pytest
      - run: python tools/validate_schemas.py
EOF2

if [[ ! -d .git ]]; then
  git init >/dev/null 2>&1 || true
fi

say "Bootstrap complete"
