# Repository Guidelines

## Project Structure & Module Organization
Core Python packages live in `sim/` and `observatory/`. Use `sim/models/` and `sim/engine/` for colony state and tick logic; use `observatory/models/`, `observatory/analysis/`, and `observatory/ingest/` for signal, evidence, and hypothesis work. Keep background-job stubs in `worker/`, schema definitions in `schemas/`, fixtures in `data/fixtures/`, and developer utilities in `tools/`. The current UI stub is in `ui/web/` with `server.js` as its entry point. Tests sit beside their domains in `sim/tests/` and `observatory/tests/`.

## Build, Test, and Development Commands
Create a venv with `make venv`, then install with `make install`. Prefer `.venv/bin/python -m ...` if your shell also has Conda active.

- `make test`: run all Python tests with `pytest`
- `make lint`: run `ruff check .`
- `make format`: run `black .`
- `make validate`: validate JSON schema and fixture compatibility
- `make seed`: generate a seed world state
- `make tick`: advance the simulation one tick
- `make ui-install && make ui-dev`: install and start the placeholder UI on `http://localhost:3000`

## Coding Style & Naming Conventions
Target Python 3.11+, use 4-space indentation, and keep lines within 100 characters. `black` and `ruff` are the source of truth for formatting and linting. Follow existing naming patterns: modules and functions in `snake_case`, classes and Pydantic models in `PascalCase`, constants in `UPPER_SNAKE_CASE`. Prefer explicit, legible model fields and small, testable functions over implicit coupling.

## Testing Guidelines
Use `pytest` and place tests under `sim/tests/` or `observatory/tests/` with names like `test_tick.py` and `test_model_exports.py`. Test names should describe behavior directly, for example `test_run_tick_advances_and_changes_resources`. Add or update tests for every behavior change, especially schema, model, and serialization paths. Run `make test` before opening a PR.

## Commit & Pull Request Guidelines
Recent history uses issue-oriented subjects such as `Issue #33: structure site-pack provenance`. Keep commit titles short, imperative, and scoped to one change. PRs should include the linked issue, a brief behavior summary, the commands you ran (`make test`, `make validate`, etc.), and screenshots only when UI output changes. Keep changes small and replayable where practical.

## Configuration & Data Notes
Treat fixtures and schema files as versioned interfaces. Do not silently change sample data shapes without updating the matching tests and validation flow.
