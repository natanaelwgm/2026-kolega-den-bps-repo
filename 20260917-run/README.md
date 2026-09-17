# Run snapshot — 17 September 2026

## Block 0: data preparation

Start with [the block-0 README](block-0-data-preparation/README.md).

- [analysis_ready_data.dta](block-0-data-preparation/analysis_ready_data.dta): **OBSCURED** firm-year panel with productivity estimates; 33,049 rows and 516 labelled variables.
- [00_run.do](block-0-data-preparation/00_run.do): rebuild through clean data, obscured values, panel construction and productivity estimation; configure [settings.do](block-0-data-preparation/settings.do) first.
- [METADATA.json](block-0-data-preparation/METADATA.json): file catalogue, keys, coverage, hashes and nonbinding analysis suggestions.
- [PACKAGE.json](block-0-data-preparation/PACKAGE.json): integrity manifest for the published package, with the intermediate explicitly marked local-only.

The **one final DTA is stored directly in the block-0 folder on main**, alongside
its README and metadata. Cloning main includes the dataset. An identical
[private release copy](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/tag/20260917-block-0-data-preparation) remains available. The optional pre-G1
intermediate is retained locally only. Recommendations remain optional.
