> Current owner delivery: [strong seeded masking and exact recovery](strong/README.md). The historical mild release below is superseded and failed a later categorical audit of the energy-cost completeness indicator. Use the strong builder for the current request.

# Actual and obscured + fictional panel pair

The current pair starts from the verified actual 515-column projection. It does
not reuse the older G0.5 numerical perturbation or its fitted G1 results.

1. Copy actual.dta byte-for-byte.
2. Pin the original G0 hash and bring three additional matching features from
   that same parent into the temporary native Stata state.
3. Generate a private record factor (±0.1–0.5%). Native Stata scales monetary and
   physical levels coherently, rounds worker counts, keeps the source >100 worker
   category, bounds percentage shares and preserves the FDI 10% threshold domain.
4. Shift logs and per-worker measures using the changed operands. Dimensionless
   ratios sharing the same level factor cancel and remain unchanged.
5. Use the existing nine-feature province × sector constrained generator to
   create fictional panel IDs from the obscured feature state. No real links are
   asserted. Annual gaps remain unchanged.
6. Export obscured_dummy.dta with the same 515 field names and original obs_id
   order. Every protected field and missingness mask is compared to actual.
7. Verify original equations on their previously coherent support, year counts,
   firm-year keys, stratum boundaries, exact actual hash, domains and metadata.

Category protection takes precedence over numerical-name rules, including
diagnostic fields such as `r_capital_stock_per_worker_state`. A separate semantic
category check compares all matching category/status/code fields independently
of the transformation policy. The accepted run is recorded in `latest.json`;
do not use older runs whose receipts mark them superseded.

Research categorical values, numeric codes, source flags, years and geography
are unchanged. Declared exceptions are new fictional identity/mode metadata.
Existing source-quality flags remain source-quality flags, not a new analysis
of perturbed values. Zero, missing and absent fields are not fabricated.

This is light development obscuring, not guaranteed anonymisation. Having an
actual counterpart or retained categories can reveal original information.
Private keys and factors are outside the delivered package and Git.

G1 result columns are missing in both files: actual never had admitted G1 real
results, and old G1 development estimates would be stale for these newly changed
numbers. The previous G1 dataset remains untouched; re-estimation is separate.

Build on the owner machine:

```
python downstream/obscure/build_pair.py "/path/to/output-volume"
```

The script reads the accepted actual input from downstream/reports/latest-build.json.
It creates a new timestamped folder for each run. Inspect reports/column_policy.csv,
reports/change_audit.csv, reports/dummy_panel.json and COMPLETE.json.
