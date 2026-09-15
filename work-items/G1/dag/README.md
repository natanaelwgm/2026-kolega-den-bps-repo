# G1 analytical DAG

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

[Readable DAG](G1.svg) · [Mermaid](G1.mmd) · [full input DAG](G1-full.svg) · [full Mermaid](G1-full.mmd) · [node contracts](registries/nodes.csv) · [edge mapping](registries/edges.csv) · [triage ledger](TRIAGE_LEDGER.md) · [decision/evidence mirror](registries/decision_evidence_ledger.csv) · [deep exhibit mapping](../registries/deep-exhibit-reconciliation.md).

The original source plan remains unchanged at 24 states, 19 edges, and 24 exhibit families. The generated DAG adds seven separate nominal-development stages N01–N07 and six deep diagnostic stages N08–N13, for 37 nodes and 32 producing edges. Every original state keeps its triage, decision and JSON contract. The readable diagram omits only transitive dependency arrows; G1-full and the edge registry retain every direct input edge.

The N08–N13 edges follow the actual source files: N08 uses S01 and N01; N09 uses N03 and N04; N10 uses N01, N03 and N04; N11 uses the N03 sector universe and the private paired predictions created from N10; N12 uses the private primary-prediction intermediate created by N10; N13 uses N03 for the sector universe plus N04 fits and N05 draw files. The single diagnostics entry point is `stata/G1.do`; its separately recorded diagnostics route calls child driver `stata/deep/G1_deep.do`, which dispatches the stage-specific `.do` files. Their screened aggregate evidence lives in `deep-release/`, separate from the primary `release/`. Record-level intermediates remain in the external run. The independent arithmetic receipt validates aggregates but does not admit real-primary TFP; method and common-sample support are reported from the current fit ledger.

Development input is the shared adapter's G0.5 projection. Observation joins use `obs_id`; development dynamics use the official v3 `synthetic_development` psid. Only actual finalisation requires authenticated real linkage. The older actual wave paths and private source-row keys remain historical provenance in `source_plan_node_preserved`, not current numerical operands.

Reproduce contracts from repository root with `python3 work-items/G1/build_contracts.py`; Graphviz `dot` renders the two SVG diagrams. The builder does not run Stata or compute chart values. It refreshes source and receipt hashes, all 37 node contracts, all 32 edge records, and separate 24-family and deep-diagnostics exhibit registries.

Each contract declares grain, keys, units, calendar coverage, denominator, missing states, input/output type, decisions and source hashes. All restricted record-level derivatives remain local.
