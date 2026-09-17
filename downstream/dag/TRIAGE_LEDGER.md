# Dataset readiness triage

- Structural build: PASSED; 33,049 rows × 515 columns in each mode; exact source comparisons, G1 N06 comparison, source hashes, keys, annual coverage and independent file readback passed.
- Actual company linkage: blocked pending verified crosswalk.
- District: all missing, needs source.
- Classification/deflator/units: inherit existing gates, do not waive.
- Development G1: retain existing values; reconcile to N06.
- Original raw overall rebuild remains unfinished and separate from this projection.

- 17 September 2026: strong seeded masking/recovery PASSED. 350 protected fields exact; 97 equations; same-seed native replay and byte-exact authenticated recovery. Retained categories remain linkable; not anonymisation certification. See `../obscure/strong/latest.json`.


## 17 September 2026 — masked-input G1 branch accepted

G025_STAGE, G05_MASKED_PANEL, G1_MASKED_ESTIMATION and MASKED_FINAL passed within
nominal development scope. 33,049 records, 516 fields, 10,463 fictional firms;
41 primary models and all 4,059 bootstrap draws succeeded. Exact input-cell,
residual, bootstrap and recovery checks passed. See downstream/g025_to_g1/RESULT.md.

G15_LINEAGE was superseded by the owner's G0 → G0.25 → G0.5 → G1 order.
No full raw-Excel rebuild or GitHub infrastructure/publication is claimed.
