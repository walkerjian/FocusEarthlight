import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "tools" / "validate_schemas.py"


def test_validate_schemas_tool_succeeds_for_current_fixtures() -> None:
    result = subprocess.run(
        [sys.executable, str(SCRIPT)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )

    assert result.returncode == 0
    assert "validated data/fixtures/hypothesis-card.sample.json" in result.stdout
    assert "validated data/fixtures/world-state.sample.json" in result.stdout
    assert "validated data/fixtures/site-pack.sample.json" in result.stdout
    assert "validated data/fixtures/audit-record.sample.json" in result.stdout
    assert "validated data/fixtures/event-object.sample.json" in result.stdout
    assert "validated data/fixtures/source-record.sample.json" in result.stdout
