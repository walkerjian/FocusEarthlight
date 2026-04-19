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
