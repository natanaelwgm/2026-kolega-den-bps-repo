# G05_S04 decision

Read the original Excel outside G0, using the private source observation key. Use all nine fields present in every supplied wave; exclude partial production-worker counts and unverified capital inputs.

Process: `prepare_external_identity.py::read_excel; audit_excel_panel_fields.py`.

Evidence: `source-selected-fields.json; panel-generation.json feature_coverage` under data/g0-5-development unless a code path is named. Outputs are reproducible in-memory states plus persisted aggregate/assignment receipts.

No actual company continuity or downstream research completion is asserted.
