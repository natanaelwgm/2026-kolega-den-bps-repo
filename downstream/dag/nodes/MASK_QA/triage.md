# MASK_QA

Status: passed for bounded development masking and exact owner recovery. Opened by explicit owner direction on 17 September 2026.

Accepted run: /Volumes/Extreme SSD/2026-kolega-strong-obscured/20260917-071711-dde497. Evidence: downstream/obscure/strong/latest.json. No public-anonymity certification.

## 17 September 2026 — Additional G1.5 lineage requirement

The existing masking acceptance above remains limited to its actual-G0 parent.
The owner's newly requested G0 → G0.5 → G1 → G1.5 lineage is **not satisfied**:
the builder consumes the actual projection, regenerates fictional links and
leaves every G1 TFP estimate missing. Both historical branches have the same
hash-verified G0 parent, but the G1-to-masking edge is absent. Fresh native Stata
readback confirms 10,472 fictional firms in masked data versus 10,395 in G1.

Evidence: `downstream/reports/lineage-audit-20260917/REPORT.md` and `evidence.json`.
This audit did not rerun the full chain or modify GitHub/infrastructure. Reopen
for an explicitly pinned G1 parent, treatment of estimates after perturbation,
and a local run proving the complete requested chain before calling it G1.5.

The owner subsequently superseded post-G1 masking with G0 → G0.25 → G0.5 → G1. That replacement branch passed; see downstream/g025_to_g1/RESULT.md. The earlier failure remains the correct historical description of the old masked file.
