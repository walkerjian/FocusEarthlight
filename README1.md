# FOCUS: Earthlight

Early scaffold for a persistent colony-world platform with simulation, observatory analysis, and a Popperian constitutional core.

## Local development

Create venv:
  python3 -m venv .venv

Install:
  .venv/bin/python -m pip install -e ".[dev]"

Run tests:
  .venv/bin/python -m pytest sim/tests observatory/tests

Validate schemas:
  .venv/bin/python tools/validate_schemas.py

Seed world:
  .venv/bin/python tools/seed_world.py

Run one tick:
  .venv/bin/python tools/run_tick.py

Start UI:
  cd ui/web && npm install && npm run dev

## Important note

If Conda is installed, prefer `.venv/bin/python -m pytest` over bare `pytest`.
