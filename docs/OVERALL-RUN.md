> Current entry point: [data preparation](../20260917-run/block-0-data-preparation/README.md). This page describes a retained earlier runner.

# Full raw-to-G1 run

**Status: implementation present; full end-to-end verification remains unfinished.**
The first native Stata GUI run stopped during preparation, before raw imports,
because exFAT metadata files were counted as raw input files. That preparation
bug is corrected. Do not interpret the historical demo receipts as proof that
this new overall route has passed.

Open the repository root `00_MASTER_OVERALL.do`. It leaves
`demo/00_MASTER.do` as the separate previously tested fast runner.

The overall entry directly calls:

1. `overall/code/01_raw_imports.do`: twelve native Excel imports (2010–2015,
   2017–2022), each compared with its frozen annual staging witness.
2. `overall/code/02_all_g0.do`: all 17 registered G0 stages, including the
   annual column mapping children, corrections, wave publication, reports,
   numerical comparisons, schema checks and histogram bins. The complete
   active code is under `overall/g0-source/`.
3. `overall/code/03_build_g05.do`: native summaries of the new G0 master,
   workbook/chart formatting, then new perturbation and fictional panel IDs
   from that freshly rebuilt master.
4. `overall/code/04_all_g1.do`: G1 E01–E19 source checks, nominal N01–N07
   estimation (including enabled sensitivity/bootstrap), and N08–N13 deep
   diagnostics through `overall/code/05_g1_diagnostics.do`.

Each child call prints a `CALL` or stage banner in Stata Results. Helpers
stream their progress through the existing Stata progress helper. The final
success marker is `OVERALL_DONE`, backed by `OVERALL_COMPLETE.json`; a folder
or partial workbook alone is not a success receipt.

## Input setup

Download the complete private data release with
`python scripts/download_data.py --profile all`. The raw ZIP contains 17
original files. Twelve annual sample Excel files are imported; the remaining
five classification/source reference files are retained alongside them.
Accepted mappings and other frozen witness inputs are still required. This
route does not infer a new classification mapping automatically from those
five files.

Set paths in a local, ignored `overall.local.do`, for example:

```stata
global OVERALL_OUTPUT "/absolute/path/to/new-runs"
global OVERALL_RAW_ZIP "/absolute/path/to/inputs/raw/Deasy-Imed-17-Raw-Inputs-20260915.zip"
global OVERALL_WITNESS "/absolute/path/to/g0-original"
global OVERALL_PYTHON "/absolute/path/to/python3"
```

Start Stata in the repository root before clicking Do. The raw annual filenames
and first-row header format currently follow the accepted 17-file source
bundle. Adapting arbitrary new annual layouts requires explicit mappings; the
older demo's custom-input adapter is not yet an arbitrary raw-to-G0 rebuild.

Every normal run uses a new output directory. The internal preparation retry
option only accepts a marked, unstarted preparation with no analytical
execution receipt and no staged annual DTA. It is not analytical stage resume.
On exFAT, many small files occupy far more space than their byte sizes: choose
an output volume with substantial headroom beyond the input download size.

G0.5 IDs are fictional, and G1 remains nominal development analysis. Running
all stages does not establish real company links or admit actual TFP results.
