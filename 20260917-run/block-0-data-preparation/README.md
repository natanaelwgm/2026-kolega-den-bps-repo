# Data preparation

**Shared dataset: [analysis_ready_data.dta](analysis_ready_data.dta).**
The dataset contains 33,049 observations and 516 labelled variables. Values are
obscured; firm identifiers and longitudinal links are fictional.

For downstream analysis, load this file directly. Rebuilding the source data
is independent of choosing an analysis sample or specification.

## Rebuild the dataset

1. Configure local paths in [settings.do](settings.do).
2. Set Stata's working directory to this folder.
3. Open [00_run.do](00_run.do) and execute the entire file with **Do**.

The master calls four steps in order. Each reads the preceding validated output
and writes a log. New results are saved under `WORK_DIR/<run>/output/`.

| Step | Process | Output |
|---|---|---|
| [01_clean_data.do](steps/01_clean_data.do) | Import annual files, harmonize variables, construct measures and validate. | Clean source data |
| [02_obscure_values.do](steps/02_obscure_values.do) | Apply seeded changes to base values and recompute derived measures. | Obscured numeric checkpoint |
| [03_construct_panel.do](steps/03_construct_panel.do) | Construct fictional firm-year links, preserving obscured values. | Development panel |
| [04_estimate_productivity.do](steps/04_estimate_productivity.do) | Estimate productivity specifications; attach results, labels and definitions. | `analysis_ready_data.dta` |

```text
Annual source files → Clean data → Obscured values → Panel
                                                     ↓
                                          Productivity estimates
                                                     ↓
                                          analysis_ready_data.dta
                                                     ↓
                                            Downstream analyses
```

Set `RESUME_RUN` to an existing run folder to continue from validated checkpoints.
The master reports the active step and stops if a required check fails.

## Documentation

- [Rebuild requirements, configuration and logs](documentation/REBUILD_GUIDE.md).
- [Dataset scope and optional analysis guidance](documentation/DATA_GUIDE.md).
- [Variable dictionary](metadata/variable_dictionary.csv).
- [Source concordance](documentation/SOURCE_CONCORDANCE.md), with [file-level mapping](documentation/source_concordance.csv) to the original local workflow.
- [Annual input filenames](support/input_files.csv).
- [Local execution and resume validation](documentation/VALIDATION.md).

The current adapters cover 2010–2015 and 2017–2022. New source schemas require
an adapter and validation update. Productivity results are nominal development
residuals; actual longitudinal identity and real TFP are not established by this
obscured dataset.

**Validation status:** all 17 raw stages and all four preparation steps passed
locally, including fresh estimation, metadata checks and a second GUI Do run
that reused unchanged checkpoints. The [validation record](documentation/VALIDATION.md)
distinguishes the tested rebuild from the unchanged dataset included here.
