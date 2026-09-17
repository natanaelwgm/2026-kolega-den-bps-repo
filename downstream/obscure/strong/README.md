# Strong seeded masking and exact owner recovery

The v2 build makes a new actual-derived development dataset with independent
secret-seeded changes to primary numerical cells. It replaces the earlier
0.1–0.5% common-factor approach for the owner's obscuring use case. It does not
claim irreversible anonymisation, differential privacy, or fully synthetic data.

## Run and recover

```sh
python downstream/obscure/strong/build.py "/path/to/output-volume"
```

The input is the hash-pinned actual projection recorded in
`downstream/reports/latest-build.json`, with the same original G0 parent used for
three extra dummy-matching features. Never use an already obscured release as input.
The build creates a new version directory and refuses to publish a pass until
validation, replay and exact recovery succeed. `latest.json` identifies the pass.

The default seed lives at
`/Users/natanaelmassie/Downloads/.kolega-private/strong-v2/seed.key`, with a separate
`seed.backup.key` copy in that private directory. Both are retained, mode 0600.
`--seed-file /private/location/existing.key` reuses another 32-byte seed.
The seed is never printed, put in the dataset, committed or copied into delivery.
Its SHA256 identifier is not the seed. Keep the private seed and recovery archive.

The private `OWNER-RECOVERY.json` records the seed location and accepted archive.
The archive encrypts exact original DTA bytes, the original-to-dummy row mapping,
and a numerical delta table (masked minus original). It uses authenticated AES-GCM
with a separate encryption key derived from the retained seed. Recovery works even
if the old actual source file is unavailable; rounding cannot lose the original.

```sh
python downstream/obscure/strong/recover.py \
  --seed-file "/private/location/seed.key" \
  --archive "/accepted/run/OWNER-ONLY/recovery.aesgcm" \
  --output "/new/private/location/restored_actual.dta"
```

An optional `--audit-directory /new/private/directory` also extracts per-cell
deltas and the key mapping. Existing outputs are not overwritten.

## Variable rules

- Continuous primary amounts and quantities use independent HMAC-SHA256 channels
  per source hash × source observation × variable × rejection attempt. Magnitudes
  change by 20–30% with either sign. No single factor applies to an entire row.
- Workers, production workers and R&D workers are integer counts. Seeded rejection
  sampling selects admissible rounded values, respecting the worker >100 category
  and previously valid component ≤ total constraints. Some small counts have no
  integer 20–30% away: those use rounded proposals and are counted as exceptions.
- Valid percentage values remain in [0,100], with 0/100 endpoints and the FDI ≥10%
  category retained. Feasible proposals are sampled instead of piling values at
  clamp boundaries. A pre-existing invalid source percentage is perturbed while
  remaining outside the valid domain, not silently repaired. Retaining endpoint
  anchors reveals their actual values.
- Output is rebuilt from independently masked value added, intermediate inputs
  and the tiny source accounting residual. Energy/emission totals, per-worker
  measures, logs and ratios are recalculated from changed operands. Derived
  changes need not be in the 20–30% band. Algebraic identities remain meaningful.
- Category values, years, geography/industry codes, source flags, reference factors
  and missing masks stay exact. Status/count-of-observed-component variables are
  not monetary quantities. Flags describe actual-source quality; they are not a
  fresh quality assessment of the masked values.
- Observation keys and source row positions are replaced. Fictional company links
  are regenerated using obscured matching features within province × sector.
  A private map permits exact owner recovery; it is absent from masked delivery.

## Boundaries and evidence

Only `OBSCURED-ONLY/` is the masked delivery. `OWNER-ONLY/` contains the actual
dataset and encrypted recovery; do not send the complete parent folder as masked
data. The private seed directory is separate from both. The public folder contains
no seed, exact cell deltas, actual counterpart, original row key, or factor table.

`reports/column_policy_and_changes.csv` accounts for every field, unchanged cells
and range exceptions. `reports/equations.json` checks the 97 derived definitions
against actual and masked data. `reports/privacy_checks.json` tests whether a
known original amount plus its masked counterpart unlocks unrelated amounts by a
common multiplier. This is a narrow attack test, not a claim of general safety.
It also reports unique year × province × industry groups, which remain linkable.

Retained categories, zeros, small counts, endpoint percentages, known numerical
bounds and external knowledge can still reveal information. Related releases
can make linkage easier. No finite perturbation range can guarantee that original
values are unknowable. The version is for development and demos, not public
release certification or empirical inference. G1 must be re-estimated on new
masked inputs; old estimates are not attached.

Verification includes independent Pandas readback of Stata outputs, same-seed
native Stata `cf` replay, repeated dummy-panel generation, category/missingness
equality, domains, actual-byte equality, and recovery authentication failures.

Implementation references: [Python secrets](https://docs.python.org/3/library/secrets.html)
for generating a secret seed instead of a simulation seed, and
[AESGCM](https://cryptography.io/en/latest/hazmat/primitives/aead/#cryptography.hazmat.primitives.ciphers.aead.AESGCM)
for authenticated recovery storage. Data transformations are performed by native
Stata; Python generates keyed draws, orchestrates, validates and packages.
