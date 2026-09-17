# Local validation

**Status: passed on 17 September 2026.** The [validation receipt](RUN_VALIDATION.json)
records the tested run, file hash, model coverage and checkpoint checks.

| Component | Evidence |
|---|---|
| Raw data preparation | 12 fresh annual imports; all 17 original stages passed; native comparison of all 30 reference report tables passed. |
| Stata master | Opened `00_run.do` in the Do-file Editor and clicked Do. All four preparation steps completed. |
| Obscuring and panel | Numeric replay, panel replay and exact owner recovery passed. Panel construction continued the same numeric checkpoint. |
| Productivity | 38 primary models; all 3,762 requested bootstrap draws succeeded. Independent source, nominal-result and full-master validators passed. |
| Final dataset | 33,049 observations, 516 variables, 10,530 fictional firms; unique `firm_id year` and observation keys. |
| Variable metadata | All 516 labels and notes verified; all 17,053,284 cells unchanged by metadata finishing. |
| Resume | Clicked Do again with `RESUME_RUN`; all four checkpoints reused. Hashes and modification times of 31 files remained unchanged. |

The raw rebuild was completed separately, including documented repairs and
resumption. The GUI test explicitly reused that freshly validated cleaning run;
obscuring, panel construction and productivity estimation were fresh. This is
not a claim that a second raw rebuild ran inside the GUI test.

The new local result has 652 nonmissing OP residuals and 9,979 each for LP, ACF
and Wooldridge. Missing estimates remain missing outside the supported model
samples. These are nominal development residuals on fictional panel links.

The DTA tracked in this block remains the previously accepted publication,
with its existing metadata and lineage. Its bytes were not replaced by the new
test result. The receipt distinguishes the published and rebuilt hashes;
both use the same final schema and downstream entry filename.

To verify a completed local run from the repository root:

```sh
python3 downstream/simple/validate_run.py /path/to/completed/run
```

The [source concordance](SOURCE_CONCORDANCE.md) maps the descriptive steps to
the original local workflow. Execution is verified on macOS with Stata SE 17
and the pinned Python packages. New source schemas require adapter and
validation updates.
