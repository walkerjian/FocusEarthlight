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
