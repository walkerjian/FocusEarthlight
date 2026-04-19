from observatory.analysis.hypothesis_engine import build_stub_hypothesis_card

def test_build_stub_hypothesis_card() -> None:
    card = build_stub_hypothesis_card("event_001", "Test claim")
    assert card["id"] == "hc_event_001"
    assert card["claim"] == "Test claim"
    assert card["status"] == "draft"
