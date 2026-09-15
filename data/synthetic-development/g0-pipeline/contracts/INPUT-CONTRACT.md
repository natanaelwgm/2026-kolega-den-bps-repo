# Synthetic G0 input contract

Authoritative files: [input-manifest.csv](input-manifest.csv), [excel-field-map.csv](excel-field-map.csv), and `../../schema/`.

Read exactly 12 annual `SYNTHETIC_sampel_mfgYYYY_aman.xlsx` workbooks, `SYNTHETIC_si2010.xlsx`, and four classification workbooks. Annual grain: source file year + 1-based Excel data-row index. Annual cardinality 100, old-reference cardinality 200. Headers must match the supplied header contract exactly, including duplicate positions. No formulas are accepted in the supplied raw/reference inputs. Data cells are imported as strings into Stata to retain source tokens and six-digit identifiers; numeric parsing occurs only in mapped analytical fields.

The supplied source-ID field is selected from the field/year map, **not necessarily the first Excel column**. Annual IDs must equal 800001–800100 and have length six; each ID appears once per actual year. The old reference is separately validated and never appended. Year 2016 is absent. Missing files, wrong headers/counts/IDs or duplicate keys fail; there is no original-data fallback.

All source paths are rooted within this repository's `data/synthetic-development/`. Schema/rule metadata and predecessor code are permitted; original observation files, existing G0 DTA, and illustrative output Excel are forbidden inputs. The historical source metadata does not authorize reading the path it describes.

Reference classification tables retain supplied strings and their original row grain; do not assert one-to-one HS/KBLI mapping without an appropriate key. No WPI or genuine identity crosswalk is supplied in this input contract.

## WPI extension

Owner-authorized actual macro references are in `../references/toar-wpi-20260910/`; full source provenance/hashes in `wpi-source-manifest.json`. No original company observations. The131-row delivered DTA, annual IHPB CSV and semantic concordance feed the Stata source-reconstruction edge. The seven-sheet XLSX is independently audited. `synthetic-industry-wpi-bridge.csv` is an explicit four-activity fixture bridge, not a general real-data annual KBLI crosswalk. All references retain original bytes. Source gaps/precision/splice limitations are documented in `../WPI-INTEGRATION.md`.
