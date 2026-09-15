# G1 — production-function estimates on G0.5 v3

**The all-years assumed-capital development analysis is complete. These nominal results use fictional company links and are not final empirical findings.**

Run `v3-assumed-stock-all-years-02` produced 41 primary models, 123 successful sensitivity fits and 4,059 successful bootstrap draws out of 4,059 requested. The [continuous publication appendix](publication/G1-Appendix.pdf), [LaTeX body](publication/appendix.tex), [standalone wrapper](publication/main.tex), [Indonesian report](report.md) and [HTML report](report.html) describe the same result set. The reviewed PDF has 77 native tables, 49 vector figures and 29 numbered equations across 161 pages.

| Method | Sample | Primary sectors | Dynamic rows | Predicted rows | Admitted intervals |
| --- | --- | --- | --- | --- | --- |
| Olley–Pakes | own | 1 | 128 | 683 | 1 |
| Olley–Pakes | common | 1 | 128 | 676 | 1 |
| Levinsohn–Petrin | own | 12 | 5,041 | 10,315 | 12 |
| Levinsohn–Petrin | common | 1 | 128 | 676 | 1 |
| Ackerberg–Caves–Frazer | own | 12 | 5,041 | 10,315 | 12 |
| Ackerberg–Caves–Frazer | common | 1 | 128 | 676 | 1 |
| Wooldridge | own | 12 | 5,041 | 10,315 | 12 |
| Wooldridge | common | 1 | 128 | 676 | 1 |

Each row describes one method and one sample. Counts overlap across methods and samples and must not be added to count distinct companies. The four-method shared dynamic intersection contains 128 observations using own-sample estimates and 128 using common-sample estimates. The ledger retains 604 support skips and 0 failed fits; 0 primary models withhold intervals under the fixed bootstrap success threshold.

## Measurement and calendar coverage

The input contains 33,049 observations and 10,395 accepted fictional development companies across 2010, 2011, 2012, 2013, 2014, 2015, 2017, 2018, 2019, 2020, 2021, 2022. These IDs do not recover real company identities.

We assume reported capital stocks are year-end stocks in every supplied source year. Beginning capital uses the exact previous calendar year's value. We preserve the absent 2016 file, original source amounts and documentary flags. Positive reported additions provide a separate assumed investment candidate for Olley–Pakes; the stock assumption does not create missing additions. Potential production years are 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022; potential dynamic endpoints are 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022. The calendar table reports actual successful-fit coverage.

| Method | Sample | Dynamic estimation years | Prediction years |
| --- | --- | --- | --- |
| Olley–Pakes | own | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Olley–Pakes | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Levinsohn–Petrin | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Levinsohn–Petrin | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Ackerberg–Caves–Frazer | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Ackerberg–Caves–Frazer | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Wooldridge | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Wooldridge | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |

We pool supported transitions within sector and retain constant slopes and control laws across years, with no new year effects. Each primary fit predicts every valid observation in its declared domain and separately flags membership in dynamic estimation. These predictions are not annual coefficient estimates. We subtract each fit's mean native residual across its pooled dynamic sample and keep that constant in every prediction year. Exponentiation gives geometric mean one across the pooled fit sample; annual distributions need not have mean zero or geometric mean one. Nominal prices, unit conventions and changing composition remain part of the interpretation.

The [nominal specification](nominal-specification.json) and [diagnostic contract](deep-diagnostics-contract.json) define this calculation. Completion does not accept the separate real-input primary specification in issue 9. That requires real company links, accepted definitions and deflators, technology mapping, the specified real-primary inference and an explicitly selected actual-data rerun.

## Evidence and outputs

- [Acceptance](acceptance.json), [quality review](quality-review.md), [run manifest](release/run-manifest.json), [nominal validation](release/qa/nominal-validation.json), [master preservation](release/qa/full-master-validation.json), [diagnostic validation](deep-release/qa/deep-validation.json), [publication bindings](qa/publication-bindings-validation.json), and [final page review](qa/publication-final-review.json).
- [Coefficients and rejected obligations](release/outputs/nominal_coefficients.csv), [bootstrap summaries](release/outputs/nominal_bootstrap_summary.csv), [retained draws](release/outputs/bootstrap_draws/), [comparisons](release/outputs/nominal_pairwise_comparisons.csv), and [annual attachment](release/outputs/nominal_master_attachment.csv).
- [Diagnostic outputs](deep-release/outputs/), [diagnostic run manifest](deep-release/run-manifest.json), and [stage interpretation](stata/deep/README.md).
- [Full analytical DAG](dag/G1-full.svg), [readable DAG](dag/G1.svg), [edges](dag/registries/edges.csv), [exhibit obligations](registries/exhibits.csv), and [method contracts](registries/method-contracts.md).
- [Publication operands](publication/provenance/) and [current Luna/max comments](qa/luna-all-years-comment-review.json). Earlier review receipts retain their original scope.

The appendix applies [the owner's writing standard](../../WRITING-PREFERENCES-SEE-HERE.md) and the actual G0 reference: active academic English, definitions before abbreviations, method depth, coefficient tables with standard errors, annual distributions, worked calculations, native LaTeX mathematics, actual Times New Roman, vector charts, direct numeric labels, visible legends, and distinct Notes and Source. The [scoped LaTeX package](publication/g1-appendix.sty) provides portable references and host-derived numbering. Earlier v1 material remains in [history/v1](history/v1/README.md).

## Reproduce

Use a new external run ID and one Stata worker. From the repository root, with the declared Python dependencies, Stata SE 17, XeLaTeX and actual Times New Roman installed:

```sh
OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 python3 work-items/G1/run.py --run-id a-new-run-id --publish
```

Before the diagnostic run, preserve the previous diagnostic contract with its external run and register `base_run` in `deep-diagnostics-contract.json` as the exact new base directory name. Keep its scientific definitions unchanged. The independent validator rejects a run whose name differs from this explicit source binding. Freeze the corrected contract and code before execution.

```sh
stata-se -b do work-items/G1/stata/G1.do /absolute/repository /absolute/new-diagnostics-run diagnostics /absolute/base-run
python3 work-items/G1/validate_deep.py --base /absolute/base-run --run /absolute/new-diagnostics-run
```

After diagnostic validation, retain the former release with its external run. Copy only the CSVs enumerated in `deep-diagnostics-contract.json`, matching manifests, validation receipts and quiet execution log into `deep-release`. Keep record-level intermediates external. Then rebuild the publication:

```sh
python3 work-items/G1/build_contracts.py
python3 work-items/G1/build_report.py
python3 work-items/G1/publication/plot_deep_figures.py --base work-items/G1/release --deep work-items/G1/deep-release
python3 work-items/G1/publication/build_appendix.py --results work-items/G1/release
sh work-items/G1/publication/build.sh
python3 work-items/G1/validate_publication_bindings.py
python3 harness/manage.py validate
```

Inspect the compiled pages and regenerate exact-file visual and source-review receipts before running `python3 work-items/G1/build_closeout.py`. The builder checks matching base-run, diagnostic, specification, current Luna/max review and PDF identities before generating this README, acceptance and quality review. Compilation alone does not establish numerical or visual acceptance.

Record-level files, including `analysis/G1_main_with_tfp.dta`, remain in `<checkout>-g1-runs/<run-id>/`. The derivative preserves all original adapter fields and attaches distinct `dev_nominal_*` predictions and flags. The shared adapter checks the pinned G0.5 package. The [four-method fixture](stata/methods/README.md) tests algorithms separately and is never an input. [Measurement modes](stata/methods/MEASUREMENT-MODES.md) preserve the distinction from actual finalisation.
