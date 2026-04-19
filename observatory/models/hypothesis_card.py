from pydantic import BaseModel


class HypothesisCard(BaseModel):
    schema_version: str = "0.1.0"
    id: str
    claim: str
    claim_type: str
    status: str
    confidence: float | None = None
    evidence_for: list[str]
    evidence_against: list[str]
    alternative_hypotheses: list[str]
    falsifiers: list[str]
    review_date: str
    unknowns: list[str] = []
    notes: str | None = None
