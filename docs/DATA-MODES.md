# One analysis interface, two data modes

**Default: G0.5 development data. Finalisation: explicit actual input stored locally.** This policy applies to new work on all downstream Deasy requests, including GPT Pro. Historical code and reports retain their dates and do not override this current input policy.

```python
from harness.data_source import load_data

# Code development, including a selected wave:
data = load_data(years=2017, columns=[
    "source_year", "obs_id", "psid", "psid_status",
    "gross_output_nominal", "workers"
])

# The identical downstream analysis body uses this input at finalisation:
data = load_data(mode="actual", actual_path="/local/G0_analysis_ready.dta",
                 years=2017, columns=[
                     "source_year", "obs_id", "psid", "psid_status",
                     "gross_output_nominal", "workers"
                 ])
```

Actual input can also be the exact verified local Parquet package retained before G0.5. The adapter requires the accepted source checksum and rejects a different master version or a development package passed as actual. Use `DEASY_DATA_MODE` and `DEASY_ACTUAL_DATA` to select the same inputs through configuration. There is no automatic actual-data fallback.

Both modes expose the same names and logical types: 4,376 original projection fields plus twenty observation/panel metadata fields. Numerical fields use a consistent numeric representation across parts; raw numeric text remains text. The full local master can have additional original columns; they are projected away unless a future version explicitly extends this shared contract.

## Stata

Export the selected input locally, then keep the module body the same:

```sh
python3 harness/data_source.py --mode development --year 2017 --columns source_year,obs_id,psid,psid_status,gross_output_nominal,workers --export /local/G0_input_dev.dta
python3 harness/data_source.py --mode actual --actual-path /local/G0_analysis_ready.dta --year 2017 --columns source_year,obs_id,psid,psid_status,gross_output_nominal,workers --purpose final --export /local/G0_input_actual.dta
```

```stata
do harness/g05/use_data.do development /local/G0_input_dev.dta
* Same analytical module body follows.
```

Use `actual` and the actual export path at finalisation. The helper checks the data label and keeps the mode in the dataset characteristics. The Python export/readback is tested; this does not claim that all historical Stata entrypoints have been made portable or that the new Stata wrapper was executed on the full research pipeline. Historical preparation scripts still have source-specific paths. New downstream code must enter through this boundary.

## Output separation and finalisation

Keep development outputs and actual final outputs in different run directories. `write_run_receipt()` records the input kind/version and exact code hash. It refuses a final-purpose receipt on development data. A provenance receipt is not statistical validation.

Do not convert development coefficients into actual coefficients or reuse fitted models as final estimates. Rerun transformations, sample selection, models, tables and figures from actual data with the same code version. Validate the result on actual data and resolve the original request's acceptance criteria.

G0.5 v3 supplies fictional firm IDs. Development panel code uses `load_data(require_panel=True)` or the equivalent Stata checks: `psid_status == "synthetic_development"` and `isid psid source_year`. The command-line exporter also accepts `--require-panel`.

Actual mode clears the fictional firm/cluster/predecessor fields, preserves `obs_id`, and refuses `require_panel=True` for the currently unverified actual parent. A real company crosswalk remains a separate finalisation input. The same analysis body and field names apply; do not copy simulated identities or results into actual mode.

The full development panel passed Stata 17 SE checks: 33,049 rows, 10,395 fictional firms, 20,579 annual lags and 2,075 two-calendar-year links across absent 2016. Export version 118 supports this field count on SE. This checks the input and lag contract, not all downstream estimators or historical entrypoints.

## Current routes

- Active dataset: [G0.5 package](../data/g0-5-development/README.md).
- Machine routing: [active-dataset.json](../data/active-dataset.json).
- All 44 original rows plus the separate G0.5 producer: [execution routing](../work-items/G0.5/downstream-routing.json).
- Detailed ID, company crosswalk and treatment policy: [identifiers](DATA-IDENTIFIERS.md).
- G0.5 contract and ID treatment: [work item](../work-items/G0.5/README.md).

The package remains private and actual-derived. Small perturbations do not erase the actual data previously committed to Git or anonymise all retained fields.

The [external Excel-first workflow](../harness/g05/EXTERNAL-WORKFLOW.md) prepares or reuses identity outside G0, then ports it into G0.5. It can prepare before G0 exists and never runs or edits G0. Frozen rank inputs and keyed observation tokens make the final assignments reproducible from GitHub alone.
