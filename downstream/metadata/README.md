# Final G1 variable labels and definitions

The G0 → G0.25 → G0.5 → G1 runner calls this finishing stage automatically.
It produces **516 readable Stata variable labels**, full embedded variable notes,
units, release-treatment explanations, exact masking formulas for derived values,
and a CSV/Markdown dictionary. Labels are at most Stata's 80-character limit.

The definitions describe the stored obscured development dataset. They do not
upgrade source-year unit evidence, original company linkage or nominal residuals
into verified real-input TFP. Preserved source status and threshold flags describe
G0; masking does not reclassify those categorical fields from changed values.

## Executable DAG

| Edge | Inputs | Output | Implementation |
|---|---|---|---|
| E063 | G1 estimates | `G1_FINAL_VALUES` numerical parent | `g025_to_g1/build.py:99_publish` |
| E064 | Numerical schema and source contracts | `G1_LABEL_CONTRACT` | `compile_metadata.py`, `definitions.py` |
| E065 | Parent and metadata contract | `G1_LABELLED` DTA | `../dag/edges/E065_apply_variable_metadata.do` |
| E066 | Parent, labelled DTA and contract | `MASKED_FINAL` published delivery | `finish.py` exact comparison gate |
| E067 | Validated final, dictionary and optional G0.5 input | `DATA_GUIDE` README + machine metadata | `data_guide.py` read-only dataset profiling |

Every node has a contract, triage and decision under `downstream/dag/nodes/`;
registries and `downstream/dag/DAG.md` link the edges. The numerical G1 body
E01-E19/N01-N07 remains separate from metadata finishing, so label changes do
not invalidate fitted model coefficients.

## Run on an accepted numerical result

From the repository root, with pandas available:

```sh
python3 downstream/metadata/finish.py /path/to/accepted.dta /path/to/new/SHARE-OBSCURED --work /path/to/new/METADATA
```

The input must be the reviewed 516-variable final schema. Output must be a
separate file. Stata applies metadata, checks the data signature, reapplies the
edge to check idempotence, saves, reopens and compares every value with `cf`.
Python independently checks all cells, types, order, missingness, exact variable
labels and preserved value-label dictionaries. Only a passing result is published.
The receipt records both parent and new DTA hashes. No seed or recovery data is
read, copied or changed by this stage.

`definitions.py` is the maintained definition source. `compiled/` is its
reviewable generated contract for the current schema; the runner regenerates
and snapshots the contract inside each run. No labels are inferred silently for
unknown variables; a schema expansion requires an explicit definition.

## Read in Stata

```stata
describe workers value_added_nominal dev_nominal_tfp_lp
notes workers
notes dev_nominal_tfp_lp
lookfor productivity
```

In Data Browser, select a variable to see its **Label** and **Notes** properties.
`dev_nominal_pred_lp` means residual availability (0/1), not predicted output.
`co2_scope1_complete` is a CO2 amount for the complete nine-fuel subset, not a
binary completeness flag. `firm_id` is a fictional company key within the release.

Detailed definitions are also in `metadata/variable_dictionary.csv` and
`metadata/CODEBOOK.md` beside the final DTA.

## Dataset README and nonbinding analysis recommendations

E067 writes `README.md`, `METADATA.json`, and `metadata/DATA_GUIDE_VALIDATION.json`
beside the final DTA. It records file roles, row/column counts, keys, years, panel
coverage, missingness, G1 method coverage and hashes. Recommendations explicitly
set `binding: false`; they are suggested starting points, not model/sample rules.
The default suggestion is the labelled G1 master; the pre-G1 obscured panel is
an optional input for fresh estimation. Actual owner-only data is not bundled.

The full masked runner calls E067 after final packaging. For an already validated
delivery, run only the documentation edge (no Stata rerun required):

```sh
python3 downstream/metadata/data_guide.py /path/to/SHARE-OBSCURED
```

The documentation edge reads `metadata/VALIDATION.json` and refuses a DTA with
a different hash. It checks dictionary labels against the DTA, reconciles observed
counts, confirms named fields/files, and proves all included DTAs retain their
original byte hashes after documentation is written.

## Dated block-0 snapshot

E068 makes an explicit local package; it refuses to overwrite a nonempty dated
folder. It copies only the public delivery, preserves DTA bytes, names the final
file `analysis_ready_data.dta`, regenerates README/metadata references and marks
the data OBSCURED. Each file hash is recorded in PACKAGE.json.

```sh
python3 downstream/metadata/package_block0.py /path/to/SHARE-OBSCURED 20260917-run/block-0-data-preparation
```

The DTA files are physically present in the local package and follow the repo's
existing data-artifact ignore policy. Publishing them to a private GitHub release
is a separate step; this local packaging command does not upload anything.

The 17 September snapshot is published as **one final DTA** in the [private release](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/tag/20260917-block-0-data-preparation). Its block README and RELEASE.json give the download instructions and hash; the pre-G1 intermediate is local-only. The packaging command itself still performs no upload.
