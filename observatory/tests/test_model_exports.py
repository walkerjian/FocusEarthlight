from observatory.models import AuditRecord, EventObject, HypothesisCard, SourceRecord
from sim.models import Coordinates, KnowledgeLayers, SitePack, WorldState


def test_observatory_model_exports_exist() -> None:
    assert AuditRecord is not None
    assert EventObject is not None
    assert HypothesisCard is not None
    assert SourceRecord is not None


def test_sim_model_exports_exist() -> None:
    assert Coordinates is not None
    assert KnowledgeLayers is not None
    assert SitePack is not None
    assert WorldState is not None
