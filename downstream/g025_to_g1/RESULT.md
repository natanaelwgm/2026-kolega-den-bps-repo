# Accepted local obscured-input G1 result

Accepted: 2026-09-17T10:05:49.655709+07:00. Status: **PASS**.

The owner-selected order is **accepted G0 → G0.25 masking → G0.5 fictional panel → freshly estimated G1**. G0.5 applies no second numerical perturbation; nothing is masked after G1. This repair starts from the existing accepted G0 DTA; it does not rerun the raw annual Excel imports.

## Open the result

- Folder: `/Users/natanaelmassie/Downloads/00-OBSCURED-WITH-G1`
- DTA: `/Volumes/Extreme SSD/2026-kolega-g025-g05-g1/20260917-092025-e6b7fd/SHARE-OBSCURED/analysis_obscured_with_g1.dta`
- Stata launcher: `/Users/natanaelmassie/Downloads/00-OPEN-OBSCURED-WITH-G1.do`
- Full run with intermediates: `/Volumes/Extreme SSD/2026-kolega-g025-g05-g1/20260917-092025-e6b7fd`

The final DTA has **33,049 records, 516 fields and 10,463 fictional companies**. The extra field relative to the prior 515-field projection is `vs_industry_code`, copied exactly from G0 for the G1 input contract.

| G1 method | Records with a residual |
|---|---:|
| OP | 672 |
| LP | 10,284 |
| ACF | 10,284 |
| WRDG | 10,284 |

All source records remain. Missing residuals reflect calendar, domain and sample-support requirements, rather than rows removed from the final file.

## Verification

- Actual G0 hash: `d0438798e28d67f5ac4fce3ea6a07b46630be28d88fd6cb6f17c15dc99baca08`.
- G0.25 intermediate hash: `38f871c7faf0fcebf10e6c76290e183958b7856ce23815c21b9f50ad467d3a79`.
- G0.5 panel hash: `2eac69214768a8c4db3641f0cc1fa9b85d1a2e32eef20e94b86b10e8ab71278e`.
- G1 input manifest: `61dd0866d1c42707308c238e17a06cba68b037b4729516ae9ad2bc7a2047286c`.
- Final DTA hash: `f7916d6fcda541d54bff2dc1d4cf01377f181b2e4a99fa115483b74779603c58`.
- Masking: 51 independent continuous fields, 3 integer count fields, 2 percentages; 97 derived equations. Source categories and missingness retained. Native same-seed replay and encrypted exact recovery passed; small-count band exceptions documented.
- Fresh stage comparisons: all original 515 G0 projection fields preserved while adding the industry-status field; all 504 nonidentity fields unchanged from G0.25 to G0.5; all 41 G1 input fields exactly copied from G0.5.
- G1: 41 primary models succeeded. All 4,059 requested bootstrap draws succeeded; all 41 exploratory interval cells met the declared admission threshold.
- Independent input checks: **594 passed**. Independent nominal residual/bootstrap checks: **15,676 passed**.
- G1 master attachment compared **15,235,589 source cells** exactly (33,049 × 461).
- Final export: observation-key sets identical; all 460 other input fields identical when aligned by observation ID. Stata `xtset` sorts the final view by firm/year; physical row order is not used as a join key.
- Seed and backup remain present, both mode 0600 and equal. Public-folder seed scan passed; the folder has no actual DTA or recovery key/archive.

`latest.json` contains stage hashes, exact estimation-code hashes and all retained G1 intermediate DTA hashes. The private run retains code snapshots and recovery material. Only `SHARE-OBSCURED/` is the masked distribution folder; the parent run includes actual data and private mappings.

## Scope

The attached TFP fields are **nominal development residuals on a fictional panel**, computed from the final visible masked values. They are not verified actual-company TFP or unrestricted empirical readiness. Actual-linkage and real-TFP gates remain false. Retained source categories can support linkage; this masking does not guarantee anonymity.

The two local run fixes were Stata temporary-path quoting on the SSD and key-based final comparison after `xtset` sorting. Neither changed the fitted model equations, support thresholds or bootstrap rules. No GitHub push, demo deletion, or full infrastructure change was performed.
