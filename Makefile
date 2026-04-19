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
