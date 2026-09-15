# What 00_MASTER.do actually calls

Yes: the master dispatches a cascade of child do-files. All those sources are in this repository. Python helpers handle input adaptation, fictional panel construction, provenance, workbooks and graphics; Stata do-files perform the statistical and estimation stages.

```text
demo/00_MASTER.do
├── demo/01_INPUTS.do                        annual file/column configuration
├── demo/code/live_progress.do              Results-window progress helpers
├── demo/code/driver.do
│   ├── scripts/workflow.py prepare          input validation / adapter / cache
│   ├── <new-run>/code/normalize.do          generated, for custom inputs only
│   ├── demo/code/input.do                  data and observation-key checks
│   ├── demo/code/waves.do                  optional annual DTA exports
│   ├── demo/code/coverage.do               variable/year coverage
│   ├── demo/code/panel.do                  panel diagnostics
│   ├── demo/code/summaries.do              descriptive statistics
│   ├── demo/code/g0_tables.do
│   │   └── <new-run>/code/g0_tables_generated.do
│   │       └── 16 accepted G0 table do-files, rebound into <new-run>/g0/
│   └── scripts/workflow.py present          workbook and graphics helpers
└── demo/code/g1_demo.do                     when RUN_TO = g1
    ├── scripts/demo.py prepare             selected G1 input + provenance
    ├── demo/code/nominal/N01_inputs.do
    ├── demo/code/nominal/N02_risk.do
    ├── demo/code/nominal/N03_samples.do
    ├── demo/code/nominal/N04_fits.do
    ├── demo/code/nominal/N05_bootstrap.do    optional; default off
    ├── demo/code/nominal/N06_outputs.do
    ├── demo/code/nominal/N07_master.do
    └── scripts/demo.py finish              independent checks + final outputs
```

Open the [master](../demo/00_MASTER.do), [driver](../demo/code/driver.do), [G1 driver](../demo/code/g1_demo.do), [G1 child do-files](../demo/code/nominal/) or [estimation routines](../work-items/G1/stata/methods/). The G1 routines include the point estimators, fitting and bootstrap programs. Optional stages are skipped according to the globals in the master.

The 16 reused G0 modules are enumerated in [scripts/g0_reuse.py](../demo/scripts/g0_reuse.py). Their original sources live in [the G0 preparation release](../releases/2026-09-13-data-foundation/stata-preparation/). During a run, the helper copies those modules into the new run directory and rebinds input/output paths. Thus the exact do-files used for that run are preserved alongside its logs. Downloaded proof of the successful cascade is under `outputs/demo-20260915/code/`, `outputs/demo-20260915/g0/` and `outputs/demo-20260915/g1/`.

## Separate full G0 reconstruction

The default demo starts from the accepted prepared G0/G0.5 master. It does **not** silently execute the entire raw-to-master G0 build on every click.

[02_REBUILD_G0.do](../demo/02_REBUILD_G0.do) calls [raw_replay.py](../demo/scripts/raw_replay.py), which validates the frozen inputs, copies the sealed original source into an isolated run and dispatches the 17 original Stata stages. Set `G0_EXECUTE 1` explicitly to execute; its default `0` prepares and checks only. The last stage is `H090`; `F010` runs only the initial fixture/input checks. The complete [stage registry](../releases/2026-09-13-data-foundation/stata-preparation/registry/stages.json) specifies the ordered child file for each stage.

This reconstruction starts from 12 frozen annual staged DTA files and accepted mappings. The original Excel/DBF sources are included for review, but the replay is not a newly generalized raw-Excel importer. All 17 stages have not been freshly rerun as part of this repository packaging.

## G0.5 construction versus reuse

For the default cached development demo, the already constructed fictional panel is hash-checked and reused. The panel-generation algorithm is in [harness/g05/panel_generator.py](../harness/g05/panel_generator.py); [PANEL-GENERATOR.md](../harness/g05/PANEL-GENERATOR.md) explains it. Custom development input can invoke identity construction through `workflow.py`. `code/panel.do` checks and reports panel structure; it is not itself the Python clustering algorithm.
