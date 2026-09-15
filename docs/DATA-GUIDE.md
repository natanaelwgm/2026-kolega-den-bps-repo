# Data and output guide

All archives belong to the same private release. `python scripts/download_data.py --profile all` restores their repository-relative paths and checks their SHA-256 digests. Access is owner-only as requested.

| Archive | Files | Unpacked GiB | Contents |
|---|---:|---:|---|
| `01-foundation-development-and-research.tar.gz` | 22,345 | 0.75 | Original scoped research sources, G0 release, G0.5 annual Parquet/Excel and legacy synthetic fixtures; G1 publications and aggregates |
| `02-verified-demo-results.tar.gz` | 371 | 0.23 | Verified recent demo, intermediate datasets, two workbooks, 23 charts, logs and test evidence |
| `03-g0-frozen-inputs.tar.gz` | 6,283 | 2.13 | Every input declared by the sealed G0 manifest, including annual staged DTA and validation references |
| `04-g0-source-and-evidence.tar.gz` | 16,417 | 0.70 | Original G0 stage code, documentation, mappings, provenance and audit evidence |
| `05-g0-data-outputs.tar.gz` | 9,645 | 5.53 | Retained original G0 data outputs and DAG/correction outputs |
| `06-development-master.tar.gz` | 3 | 1.33 | Complete perturbed development master and its cache receipts |
| `07-actual-master.tar.gz` | 4 | 2.02 | Original accepted actual source master plus exported actual cache and receipts |
| `08-raw-excel-and-classifications.tar.gz` | 1 | 0.04 | Seventeen original Excel/DBF input files in their supplied ZIP |
| `09-g1-complete-research-runs.tar.gz` | 248 | 3.32 | Complete accepted G1 primary/bootstrap run and subsequent diagnostic run, including full record-level masters |

The legacy synthetic fixture dataset under `data/synthetic-development/` is distinct from the accepted 33,049-row G0.5 development panel under `data/g0-5-development/`. Actual data are under `inputs/actual/`; never interpret development values or fictional IDs as verified actual panel evidence.

The raw ZIP is under `inputs/raw/`. Unzip it into a separate working folder when reviewing annual source Excel and classification DBF files. The accepted G0 replay starts from frozen staged DTA files, not a newly generalized importer for these raw Excel files.

The recent demo has 41 primary fits and no bootstrap. The retained formal G1 run has 41 primary fits, 123 successful sensitivity fits and 4,059 successful bootstrap draws, subject to the admission and measurement limitations documented in `work-items/G1/README.md`.

Historical receipts and code snapshots retain their original paths/hashes. The preserved demo dashboard uses relative links and has been checked after download from GitHub. Temporary runtime and scratch caches, duplicated failed demos and unrelated work are excluded. Some historical verification configurations remain inside the evidence bundle; they are records, not current setup files.
