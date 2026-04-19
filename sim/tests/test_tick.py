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
