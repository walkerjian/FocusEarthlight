# FOCUS: Earthlight

FOCUS: Earthlight is an early-stage platform for a persistent colony-world simulation that combines:

- high-fidelity space-settlement simulation
- AI-assisted narrative, mission, and event generation
- observatory-style analysis of signals, claims, rhetoric, and manipulation
- optional ingestion of real Earth-side news and data as off-world signals
- a Popperian constitutional core: claims must remain open to disproof, revision, and audit

The project is intended to grow into a world that is not merely generated, but **grounded**:
in physics, in site realism, in provenance, in explicit uncertainty, and in inspectable reasoning.

## Design intent

FOCUS: Earthlight is meant to sit at the intersection of:

- simulation
- civic epistemics
- reflective gameplay
- distributed compute
- educational instrumentation
- worldbuilding under constraint

The long-term vision is a colony simulation where players can:

- inhabit a physically grounded settlement
- experience narrative and social dynamics that emerge from systems, not only scripts
- inspect incentives, power, framing, and manipulation within the simulation
- analyze real-world incoming signals from Earth through structured, auditable tools
- compare hypotheses, evidence, and outcomes over time

## Constitutional core

The project’s primum mobile is in `docs/constitution.md`.

The guiding principle is:

> The colony treats significant claims as provisional conjectures rather than final truths.

This has practical consequences:

- observation must be distinguished from inference
- inference must be distinguished from prediction
- recommendation must be distinguished from rhetoric
- provenance must be explicit
- uncertainty must be visible
- world state should be replayable where practical
- updates should be corrigible rather than silently overwritten
- systems must not covertly optimize for user compliance, addiction, or factional capture

## Current state

This repository is currently at a scaffold / milestone-0 stage.

### Working now

- Python package scaffold
- minimal world-state model
- minimal tick loop
- minimal observatory hypothesis stub
- JSON schema validation
- placeholder UI page
- GitHub repo, issue backlog, and labels
- basic CI stub

### Not working yet

- real site-pack schema
- provenance plumbing
- audit-record schema
- Earth Signal Desk ingest
- event-object schema
- real Candor site pack
- real NPC, faction, and mission systems
- durable persistence model beyond simple JSON state
- real observatory UI surfaces

## Repo layout

```text
docs/          design notes, constitution, ADRs, prompts
schemas/       JSON schemas for core objects
data/          fixtures and seed data
sim/           simulation models and tick logic
observatory/   event and hypothesis analysis
tools/         validation, seeding, and replay helpers
ui/            user interface
worker/        background job stubs
```

## Local development

### 1. Create the virtual environment

```bash
python3 -m venv .venv
```

### 2. Install dependencies

```bash
.venv/bin/python -m pip install -e ".[dev]"
```

### 3. Run tests

```bash
.venv/bin/python -m pytest sim/tests observatory/tests
```

Or via Make:

```bash
make test
```

### 4. Validate schemas

```bash
.venv/bin/python tools/validate_schemas.py
```

### 5. Seed the world state

```bash
.venv/bin/python tools/seed_world.py
```

### 6. Advance one tick

```bash
.venv/bin/python tools/run_tick.py
```

### 7. Start the placeholder UI

```bash
cd ui/web
npm install
npm run dev
```

The placeholder UI listens on:

```text
http://localhost:3000
```

## Important note on Conda / pytest

If Conda is installed, bare `pytest` may resolve to the wrong interpreter even when the shell prompt shows `(.venv)`.

Safer pattern:

```bash
.venv/bin/python -m pytest
```

Safer install pattern:

```bash
.venv/bin/python -m pip install -e ".[dev]"
```

The Makefile should prefer `python -m ...` for this reason.

## Immediate priorities

The initial backlog is tracked in GitHub issues labeled:

- `foundation`
- `m0`

Current opening issues include:

1. strengthen repo bones
2. define site-pack schema for real, corrigible colony locations
3. implement audit-record and event-object schemas
4. build Candor v0 site pack fixture
5. implement world-state tick persistence and replay path
6. add source-record schema and provenance plumbing
7. add basic issue templates and PR constitution checklist
8. expand README with exact local development workflow

## Working conventions

### Development approach

Prefer:

- boring, legible implementations
- explicit schemas before clever coupling
- replayable state where practical
- small issue-sized changes
- branch-per-issue
- testable deltas
- visible assumptions

Avoid:

- hidden magic
- silent coupling
- “AI does everything” handwaving
- burying uncertainty inside fluent prose
- treating placeholder data as authoritative

### Recommended workflow

A sane near-term loop is:

1. pick one GitHub issue
2. create a branch for that issue
3. make the smallest useful change
4. run tests and validation
5. commit
6. push
7. open a PR
8. move to the next issue

## Candor

`Candor` is currently a placeholder colony seed and narrative anchor.

At present, Candor is **not yet** tied to a verified final real-world site model. Placeholder coordinates and assumptions should be treated as temporary scaffolding only.

Longer term, each colony site should become a **versioned site pack** that records:

- coordinates or bounded region
- whether the site is real, real-region-scenario-site, or hypothetical
- terrain summary
- hazards
- provenance
- revision history
- uncertainty
- distinction between:
  - observation
  - inference
  - scenario assumption

## Intended future subsystems

### 1. Site realism layer

A proper site-pack model for physically grounded colony locations with explicit provenance and revision history.

### 2. World simulation layer

Resource, morale, labor, power, policy, environment, and faction dynamics that evolve through ticks and recorded state changes.

### 3. Observatory layer

A reflective analysis layer for:

- claims
- evidence
- rival hypotheses
- incentives
- framing
- propaganda or manipulation dynamics
- retrospective scorekeeping

### 4. Earth Signal Desk

A structured ingest layer for real-world incoming signals, with provenance, hypothesis generation, and auditability.

### 5. Worker / distributed task layer

Background jobs for analysis, simulation sweeps, quest/event generation, memory consolidation, and later distributed compute participation.

## Short-term Milestone 0 goals

Milestone 0 is about giving the project real bones.

Done means:

- the repo is coherent
- local setup is reproducible
- tests run cleanly
- schemas exist for the first important objects
- documentation points to the actual workflow
- the constitution is clear enough to guide coding work

## Notes

- This is not yet a finished game, not yet a finished simulator, and not yet a finished platform.
- It is a disciplined scaffold.
- The point right now is not maximal feature count.
- The point is to establish ontology, workflow, and constitutional constraints before complexity blooms.

## License

`LICENSE` is currently a placeholder and should be finalized deliberately.

A likely split would be:

- MIT for code
- a suitable Creative Commons license for documentation, if desired

## Contribution note

If you are using an AI coding assistant on this repo, instruct it to:

- read `docs/constitution.md` first
- preserve observation / inference separation
- keep uncertainty explicit
- avoid silent coupling
- prefer small, reviewable edits
- respect schemas as contracts
