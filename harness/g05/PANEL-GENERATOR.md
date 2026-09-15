# Province × sector development panel

The owner requested a working fictional longitudinal panel for GPT Pro and all
downstream development. G0.5 v3 supplies that panel using nine continuous fields
read directly from the supplied Excel waves, outside G0. Frozen normalized ranks
and private-keyed observation tokens are included in the screened package so the
assignments can also be replayed from GitHub alone. Follow the
[external workflow](EXTERNAL-WORKFLOW.md) for preparation, existing-ID reuse,
porting and packaging; no step executes or modifies G0.

## Two different IDs

- `dev_cluster_id` labels a group of economically similar observations **within
  one year and province × sector**. Cluster labels can change between years.
- `psid` labels a **fictional firm trajectory** assembled by one-to-one matching.
  There is at most one observation for a given `psid` in a given calendar year.
- `obs_id` still identifies the same frozen source observation as in G0.5 v1.

## Variables and distance

| Family; total weight | Fields; weight within family | Purpose |
|---|---|---|
| Employment; 20% | `workers`; 100% | Employment scale |
| Financial scale; 20% | `gross_output_nominal`, `value_added_nominal`, `intermediate_inputs_nominal`; one third each | Output and production-account scale |
| Materials; 20% | `val_rtlvcu`; 100% | Raw-material intensity/scale proxy |
| Energy; 20% | `val_efuvcu`, `elec_pln_kwh`; one half each | Reported fuel/lubricant expenditure and purchased PLN electricity |
| Payroll; 20% | `val_zpdvcu`, `val_zndvcu`; one half each | Production/nonproduction payroll-field proxies |

The payroll labels are source-mapping proxies, not newly verified compensation
definitions. All nine fields have complete finite nonnegative coverage in this
release. Production-worker counts were considered but excluded because annual
coverage falls to about 53%; capital and treatment variables are not used.

Each feature is converted to a mid-rank in `[0,1]` within year × two-digit sector.
This reduces outlier and unit-scale dominance, including changes in nominal
currency scale. It does not estimate real prices or preserve aggregate sector
growth. Zeros remain observed values. Missing/negative values remain unavailable
for distance calculation; a candidate needs at least six shared features.

The compulsory block is the literal two-digit province code and the first two
digits of a valid five-digit manufacturing industry code (sectors 10–33). The
source has no usable district codes. Boundary/code-vintage equivalence is not
assumed. Malformed codes retain an isolated fictional firm ID and explicit status.

## Annual clusters and longitudinal assignment

1. Sort by year and stable observation ID. In each block-year, use Ward clustering
   on the weighted rank features, with `k = min(8, ceil(sqrt(n/8)))`. Missing ranks
   receive .5 **only for clustering**; matching retains the missingness mask.
2. Between adjacent supplied waves, compute weighted RMS feature distance. The
   assignment cost is 80% record distance plus 20% cluster-centroid distance.
   Cluster labels themselves are not forced to match across years.
3. Use optional one-to-one minimum-cost assignment, with a record-distance
   threshold of .25 and unmatched-endpoint penalties of .125 each. Augmented
   dummy choices allow either side to remain unmatched. This uses SciPy's
   [linear assignment solver](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.linear_sum_assignment.html).
   A seed of 20260913 adds only a tiny tie-break to otherwise equivalent costs.
4. A matched record inherits its simulated predecessor's `psid`; an unmatched
   record gets a new 48-bit positive integer derived from its frozen external
   observation token (`dev_identity_key`). Porting later preserves the existing
   G0.5 `obs_id` and translates predecessor references to that namespace.
   Collisions cause an error. Firm IDs stay exact in Stata double and Excel.
5. Store predecessor observation/year, distance, cluster, stratum and reason.
   The absent 2016 wave remains absent: 2015→2017 is a two-calendar-year gap.
   There is no silent reconnection after a firm misses a supplied wave.

For a block with five observations followed by three, at most three continue.
If only two meet the matching rule, two continue, one is new, and three previous
records are unmatched. None of those counts proves actual entry or closure.

Similarity-based matching intentionally creates continuity in these variables.
TFP, pretrends, survival and other results derived from it are development
simulation results, not evidence about actual firm trajectories. Other method
inputs and source-definition requirements still apply to each research module.

## Reproduce and validate

Follow the commands and private configuration in [EXTERNAL-WORKFLOW.md](EXTERNAL-WORKFLOW.md).
`build_panel_package.py` takes the preserved v1 measurements and the separately
ported `--identity-payload`. It does not match a second time on disturbed levels.

```sh
python3 -m unittest discover -s harness/g05 -p 'test_*.py' -v
python3 harness/g05/replay_panel.py --package data/g0-5-development --output /local/replay-receipt-001.json
```

Replay uses the nine published `dev_rank_*` fields and `dev_identity_key`, with
exact output comparison by `obs_id`. These ranks preserve the Excel-stage feature
ordering, not original numeric levels. The current generated panel replays all
assignments; reused existing continuity is checked as an explicit input instead.

The original Excel coverage audit can be rerun locally with
`audit_excel_panel_fields.py --inventory /local/source-inventory.json --output
/local/aggregate-audit.json`. It publishes no record values or original IDs.

The builder checks full-data reorder reproducibility, unchanged measurement
payloads, Parquet roundtrips and annual Excel roundtrips. Independent package
verification checks every link, year, boundary, schema and checksum. The Stata
check verifies `isid psid source_year`, `xtset`, exact calendar lags and the mode
label on all supplied observations. It executes no TFP or causal estimation.

Actual mode copies only `obs_id` from the frozen map. Synthetic `psid`, clusters,
predecessors, identity tokens and normalized rank metadata are cleared. Actual
`require_panel=True` therefore continues to require an independently accepted real
company linkage input. Finalisation reruns the same analysis body; it does not copy
simulated estimates or links.
