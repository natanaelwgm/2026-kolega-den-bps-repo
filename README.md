# Kolega DEN–BPS: G0 → G0.5 → G1

Latest obscured dataset: **[20260917-run / block 0](20260917-run/block-0-data-preparation/README.md)**, with the obscured `analysis_ready_data.dta`, readable labels, metadata and optional downstream guidance. Its **one final DTA is included directly in the block-0 folder on main**: [analysis_ready_data.dta](20260917-run/block-0-data-preparation/analysis_ready_data.dta). Cloning main includes it; the [17 September private release](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/tag/20260917-block-0-data-preparation) is an identical backup. The pre-G1 intermediate remains local.

Private coauthor workspace. This repository collects the data foundation, development panel, nominal production-function estimation, source inputs, outputs and review documents in one place. Source code and review text live on `main`; complete datasets and retained results are attached to the **[data release](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/tag/g0-g05-g1-2026-09-15)** in this same private repository.

A separate **[full raw-to-G1 overall master](docs/OVERALL-RUN.md)** is now present at `00_MASTER_OVERALL.do`. Its end-to-end verification is still in progress; the instructions below describe the previously tested fast demo.

## Start here

1. Clone this repository using your authorized GitHub account (`gh repo clone natanaelwgm/2026-kolega-den-bps-repo`).
2. Install Python 3.11+ and the packages in `requirements.txt`, preferably in a virtual environment. A licensed Stata 17+ installation is required to estimate.
3. Run `python scripts/download_data.py --profile demo` from this folder. GitHub CLI (`gh`) must be authenticated to an account with access. For **all source inputs, original G0 outputs and research material**, use `--profile all` instead. Reserve 25 GB for all assets and extraction; additional space is needed for new runs.
4. Run `python scripts/setup_coauthor.py --output /absolute/path/to/new-runs --stata /absolute/path/to/stata-se`. The output folder must be outside this checkout. This writes your machine-specific configuration and links the verified masters into the runner cache.
5. In Stata: `cd "/absolute/path/to/2026-kolega-den-bps-repo/demo"`, open **`00_MASTER.do`** in the Do-file Editor, and click **Do** for the entire file. Results appear in Stata, and each run gets a new output folder.

The supported demo launch path was developed on macOS/Stata SE 17. Dependencies and paths are explicit; Windows GUI/shell portability has not been validated.

See the **[DAG index](docs/DAG-INDEX.md)** for full G0 and G1 graphs and G0.5 node/edge contracts.

The **[execution cascade](docs/RUN-CASCADE.md)** lists each child do-file called by `00_MASTER.do`, the helper scripts, and the separate full G0 reconstruction.

## Choose the work

In `demo/00_MASTER.do`, set `RUN_TO` to `g0`, `g05`, or `g1`. Default `g1` uses the complete supplied development panel. For your own annual Excel/DTA files, choose `RUN_INPUT "custom"` and edit `demo/01_INPUTS.do`. `RUN_FULL_MASTER 0` retains every row and the G1 analytical columns; use `1` to retain the full 4,396-column master in the final G1 file, with higher disk needs. Sensitivity runs and bootstrap repetitions are optional and off in the quick demo.

**G0 here means preparation and diagnostics on the supplied accepted master.** The separate `demo/02_REBUILD_G0.do` prepares the original 17-stage replay from frozen staged annual inputs. It defaults to preparation only. That full 17-stage replay has not been freshly rerun as part of this coauthor packaging.

## What is included

| Area | Code and explanation | Complete data / results after download |
|---|---|---|
| G0 data foundation | `releases/2026-09-13-data-foundation/`; original stage code in the full release | `inputs/raw/`, `inputs/actual/`, `g0-original/`, foundation release results |
| G0.5 development panel | `harness/g05/`, `harness/data_source.py`, `work-items/G0.5/` | `data/g0-5-development/`, `inputs/development/` |
| G1 nominal estimation | `work-items/G1/`, `demo/code/nominal/` | `work-items/G1/{release,deep-release,publication}/`, `outputs/g1-research/` and `outputs/demo-20260915/g1/` |
| One-file demo | `demo/00_MASTER.do`, `demo/01_INPUTS.do` | `outputs/demo-20260915/DEMO.html`, workbooks, charts, datasets, logs and completion receipt |

The latest retained GUI demo passed with **33,049 rows, 41 primary fits, 23 SVG charts, a G0 workbook and a G1 workbook**. This result predates the repository relocation; see `docs/VALIDATION.md` for the packaging checks and their limits. `docs/source-file-inventory.json` enumerates every released file. `docs/release-assets.json` supplies archive checksums and sizes.

G0 actual values and G0.5 development values are separate. **G0.5 uses perturbed values and fictional longitudinal IDs. G1 is nominal development analysis, not verified real TFP or evidence that these IDs recover real companies.** Default demo estimates have no bootstrap standard errors. Existing research writeups explain the richer sensitivity/bootstrap exercises and their limitations.

## Collaborate

Read `CONTRIBUTING.md`, branch from `main`, and propose changes through a pull request. Record changed assumptions, input versions and validation results. Access is currently restricted to the owner only. Future coauthor access requires the owner to add your GitHub username under repository Settings → Collaborators; a private URL alone does not grant access.

This is a scoped snapshot of G0/G0.5/G1, not R1/R2/R3 or the entire 44-task research repository. Source provenance: `natanaelwgm/deasy-imed-si-research-2026`, commit `f021c1912`, plus the verified local demo corrections of 15 September 2026. Historical records retain original machine paths as evidence; current entry points use generated local configuration. Repeated failed demo runs, temporary scratch/runtime caches and unrelated conversations are not part of the accepted output collection.
