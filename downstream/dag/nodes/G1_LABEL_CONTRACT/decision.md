# G1_LABEL_CONTRACT

Compile source-grounded short labels <=80 characters, full notes, units, masking treatment, explicit derived formulas and CSV/Markdown dictionary. Unknown variables fail.

Grain: One definition per delivered variable; exactly 516.

Artifact: `METADATA/contract/variable_dictionary.csv; labels_and_notes.do; contract.json`. Evidence: `downstream/metadata/latest.json` after local execution. The original numerical parent is retained; label changes must not change any cell or overwrite unrelated notes.

Local PASS: 516 exact labels and serialized full notes; 17,053,284 cells, schema, order, missingness and value-label dictionaries unchanged. Native note reapplication is idempotent.
