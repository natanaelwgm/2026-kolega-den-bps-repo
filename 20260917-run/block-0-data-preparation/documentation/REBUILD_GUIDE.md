# Rebuild guide

To use the shared data, open `../analysis_ready_data.dta`. Rebuilding requires
access to the original local inputs and validation references.

## Configuration

The runner is tested on macOS with Stata SE 17. It uses Python 3.11+ and
`pandas`, `numpy`, `cryptography`, `openpyxl`, and `matplotlib`. Windows execution
has not been tested.

Configure [settings.do](../settings.do):

| Setting | Value |
|---|---|
| `RAW_DATA` | Folder containing the 12 annual Excel files and 5 source reference files. |
| `WORK_DIR` | Working folder outside the repository; allow at least 30 GiB for a full rebuild. |
| `REFERENCE_DATA` | Accepted reference package containing `G0-wave-foundation-v2` and `G0-rebuild`. These files validate the rebuilt data; they do not replace raw imports. |
| `PYTHON` | Python executable with the required packages. |
| `RESUME_RUN` | Leave empty for a new run; set to an existing run folder to resume. |
| `REUSE_CLEAN_RUN` | Optional validated raw-to-clean run to reuse. Leave empty to rebuild the annual inputs. |

Use a filesystem with small allocation units, such as APFS. Large-allocation
exFAT volumes are inefficient for the source workflow's many intermediate files.
On the owner's Mac, the compact work image is mounted at `/Volumes/Kolega-Prep-Work`;
that path is available while the image is mounted.

[Annual input filenames](../support/input_files.csv) can be changed for the
supported years. The current adapters use `Sheet1` and the accepted source
schemas. Adding years or changing variable definitions requires updating the
relevant adapter and validation references.

An optional `settings.local.do` overrides machine-specific paths and is excluded
from Git. The seed is stored in `WORK_DIR/private/seed.key`, unless the owner has
configured an existing retained seed. Keep seeds, recovery material and actual
data outside the repository.

## Execution and outputs

Set Stata's working directory to `block-0-data-preparation`, then execute
[00_run.do](../00_run.do). The Results window displays the active step.

```text
<run>/
├── intermediate/             # local checkpoints; not a publication folder
│   ├── clean_data.dta
│   ├── obscured_values.dta    # source keys retained at this stage
│   └── panel.dta
├── logs/                     # step logs
├── private/                  # source work, factors, recovery and estimates
├── output/
│   ├── analysis_ready_data.dta
│   ├── README.md
│   ├── COMPLETE.json
│   └── documentation/
└── step-1.json … step-4.json
```

The four step files can also be run individually from the block folder or
`steps/`. Each requires its preceding checkpoint within the same run.

A resumed run verifies completed output hashes. An interrupted cleaning stage
restarts from the last completed source stage; an interrupted estimation is
rerun before publication. Keep inputs and scientific code fixed during a run.
New output does not automatically replace the dataset tracked in Git.

The step files call the source code listed in the
[source concordance](SOURCE_CONCORDANCE.md). Changes to mappings or formulas
must be accompanied by the relevant validation updates. A changed result should
be reviewed rather than silently accepted against the old comparison data.
