# G1_LABELLED

Native Stata applies labels and edge-owned notes. Preserve all existing value labels and other notes; idempotent reapplication.

Grain: Same rows, columns, storage types, order and missingness as G1_FINAL_VALUES.

Artifact: `METADATA/G1_labelled.dta; METADATA/00_finish.log`. Evidence: `downstream/metadata/latest.json` after local execution. The original numerical parent is retained; label changes must not change any cell or overwrite unrelated notes.

Local PASS: 516 exact labels and serialized full notes; 17,053,284 cells, schema, order, missingness and value-label dictionaries unchanged. Native note reapplication is idempotent.
