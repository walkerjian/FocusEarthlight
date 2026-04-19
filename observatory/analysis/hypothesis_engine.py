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
