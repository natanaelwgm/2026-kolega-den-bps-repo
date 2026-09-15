# G0.5 data and panel generators

The active v3 contains 33,049 observations with 10,395 fictional company IDs. The owner explicitly authorized province × sector matching with 5–10 continuous variables. The implementation uses nine fully observed fields and preserves the existing perturbed measurements.

- `build_development.py`: verified actual G0 projection → coherent 0.1–0.5% disturbed measurements.
- `attach_ids.py`: append frozen observation IDs (historical intermediate; its missing company IDs are not the final development output).
- `external_workflow.py`: prepare/port/package outside G0; start with [the full workflow](EXTERNAL-WORKFLOW.md).
- `prepare_external_identity.py`: read Excel; reuse suitable existing IDs or generate a private identity spine.
- `port_external_identity.py`: prove Excel-to-G0 lineage and port screened IDs without changing G0.
- `panel_generator.py`: weighted ranks, annual clusters, optional one-to-one fictional panel assignment.
- `build_panel_package.py`: preserved v1 measurements + external identity payload → v3 wave parts and annual Excel views; exact full-input reorder/roundtrip checks.
- `replay_panel.py`: reproduce all active assignments from GitHub data alone.
- `audit_excel_panel_fields.py`: original Excel header/coverage audit, aggregate output only.
- `verify_package.py`, `verify_adapter.py`, `verify_panel.do`: independent package, actual/development and Stata calendar checks.
- `report_panel.py`: aggregate SVG/PNG diagnostics.
- `register_work_item.py`: current input policy for 43 downstream requests; original 44 source rows preserved.

Read the [full method and replay instructions](PANEL-GENERATOR.md), [active data and Excel downloads](../../data/g0-5-development/README.md), [mode interface](../../docs/DATA-MODES.md), and [ID contract](../../docs/DATA-IDENTIFIERS.md). Run focused tests with `python3 -m unittest discover -s harness/g05 -p 'test_*.py' -v`.

Python implements development-data packaging and fictional assignment; Stata remains the downstream estimation layer and independently checks panel/lag compatibility. No TFP/causal estimation is executed here. Actual mode retains observation IDs but clears fictional company links.
