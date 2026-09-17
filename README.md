# Kolega DEN–BPS research data

The working entry point is **[20260917-run / block-0-data-preparation](20260917-run/block-0-data-preparation/README.md)**.

- **Analyze:** load [analysis_ready_data.dta](20260917-run/block-0-data-preparation/analysis_ready_data.dta). The single final dataset is included directly in Git.
- **Rebuild:** configure [settings.do](20260917-run/block-0-data-preparation/settings.do), then execute [00_run.do](20260917-run/block-0-data-preparation/00_run.do) in Stata.
- **Trace the source:** consult the [source concordance](20260917-run/block-0-data-preparation/documentation/SOURCE_CONCORDANCE.md).

The preparation sequence is **clean data → obscure values → construct panel → estimate productivity**. Its final dataset is the common input for downstream analysis. Coauthors can choose their own samples and specifications without rebuilding the upstream data.

The shared dataset contains obscured values, fictional firm-year links, and nominal development productivity residuals. It does not establish actual longitudinal firm identity or real TFP. [Metadata and variable definitions](20260917-run/block-0-data-preparation/documentation/DATA_GUIDE.md) describe its coverage.

## Source inputs and original workflow

This private repository retains the full preparation and estimation source code. The [DAG index](docs/DAG-INDEX.md) and source concordance link the descriptive entry points to the original local workflow.

Rebuilding requires licensed Stata 17+ and Python dependencies from `requirements.txt`. To retrieve the original source inputs and retained results, run `python scripts/download_data.py --profile all` using an authenticated GitHub account with access. Raw source data, working outputs, seeds and recovery material remain local. See the [rebuild guide](20260917-run/block-0-data-preparation/documentation/REBUILD_GUIDE.md) for configuration and supported inputs.

The previously published final DTA remains byte-identical. The new preparation entry points are undergoing local end-to-end validation; their status is recorded in the data-preparation block. [Historical runners and results](docs/LEGACY-RUNNERS.md) remain available for provenance.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md), branch from `main`, and propose changes through a pull request. Record input versions, changed assumptions and validation results. Access currently remains owner-only.

Original research source: `natanaelwgm/deasy-imed-si-research-2026`, commit `f021c1912d0c80b8c168ca0f23ec575ba036a7d0`; later preparation, obscuring and metadata changes are versioned in this repository.
