# G1 prerequisite audit — G0.5 DEVELOPMENT

> **Version note, 13 September 2026:** The audit below preserves its original review scope. G0.5 v3 now supplies the official fictional panel accepted for development. The current nominal development fits and their limitations are documented in [the current report](report.md), [the economic v3 audit](qa/v3-economic-prerequisites.md), and [measurement-mode addendum](stata/methods/MEASUREMENT-MODES.md). Earlier references to unverified identities do not block the authorized development panel.

Audit date: 13 September 2026, Asia/Jakarta. Runtime: independent GPT-6 Astra prerequisite-review subagent. Checkout: `g1/issue-9-g05-20260913`, base `fd3cfa37e24cd62eced5e1ca657722f134023fb5`. This audit reads source definitions, metadata and live G2 issue/PR descriptions. It does not execute TFP, certify a panel, or read actual company records. It writes only this file.

**The current G0.5 input cannot support an empirical fit of any of the four requested panel estimators.** There are zero verified longitudinal links, no populated real production-input variables, no admitted company-to-price bridge, and no authenticated OP risk/exit universe. Useful observation-level input audits can be run on the frozen development package. Their counts must not be called an eligible estimation sample.

## Frozen input and evidence

| Object | SHA256 / state |
|---|---|
| [G0.5 manifest](../../data/g0-5-development/manifest.json) | `85f7cd5e79bb7868cf6c0956cbc4ed2d6e8f84ecb1a44e7713d38570929a4270` |
| [G0.5 variable-year inventory](../../data/g0-5-development/variable-year-coverage.csv) | `2b122efcef5d75ac087d22b5035c3dce92b604b2bca69a3f581ec3bb0ecf6e89` |
| [Shared adapter](../../harness/data_source.py) at audit | `e9e15cf813e505871330ef9951a56a80bef82f398cd1feb2c1219b5b5a166b6d` |
| [Latest G1 row plan](../../releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json) | `6a0d8af0bcf1c8e57268896d9fa348c5408b552e26038ad47aef021cede132e5` |
| G0.5 version | `g05-coherent-level-jitter-v1`; 33,049 observations × 4,379 fields; 28 Parquet parts |
| Calendar | 2010–2015, 2017–2022; no 2016 |
| Accepted actual parent DTA hash | `d0438798e28d67f5ac4fce3ea6a07b46630be28d88fd6cb6f17c15dc99baca08`; recorded for lineage only, not loaded |
| G2 PR #3 | OPEN; `g2/word-row-pr-20260910`; head `55166acf50a1bdb7a3ed9585944ffcb43edaf32f` at live inspection |

The audit read root `AGENTS.md`, the current-state/decisions/dependencies documents, the G1 source/README/task/evidence packet, the complete current data-mode and identifier contracts, the G0.5 manifest/dictionary/value labels/variable-year inventory, the latest G1 row plan including its pinned method contract, the G0 source identity/classification/price/definition receipts and source code, the G0 source-clarification questions, G2's source packet, and live issue #10 and PR #3. Directory searches covered current `docs/`, `work-items/`, `data/`, `harness/`, the two current G0 releases, and relevant project working-understanding documents. No accepted alternative G0.5 panel derivative was found in these sources. That is an evidence-search result, not a claim that a future real crosswalk is impossible.

## Identity and real calendar

[DATA-IDENTIFIERS.md](../../docs/DATA-IDENTIFIERS.md) and [the G0.5 decision](../G0.5/decision.md) explicitly state that `obs_id` identifies a frozen observation, while `psid` is reserved for longitudinal linkage. The [source identity acceptance](../../releases/2026-09-13-data-foundation/results/core/identity_acceptance.csv) records zero verified links and zero dummy links in all 12 supplied years. Source-record uniqueness does not identify a recurring establishment.

The adapter's `load_data(require_panel=True)` checks that every selected row has a nonmissing `psid`, every `psid_status` equals `verified`, and `(psid, source_year)` is unique. The baseline fails the required premise by construction. Reading the adapter establishes its behavior; this audit does not claim a fresh runtime test of that branch. A new accepted linkage version must bind to the same frozen source records, keep raw-to-canonical keys private, assign stable numeric surrogate IDs, validate establishment/company grain and ambiguous matches, and revalidate the G0.5 manifest. Merely editing a status flag does not meet this requirement. `frame.attrs['deasy_data']['panel_identity_verified']` is currently hardcoded false and would also need deliberate review when a genuine new version is accepted.

The historical [identity-mode script](../../releases/2026-09-13-data-foundation/stata-preparation/dag/edges/word_rows/G0/G0_select_identity_mode.do) supports `off`, fictional `dummy`, and externally supplied `real` crosswalk modes. It does not contain the missing accepted real crosswalk. Its dummy random-slot construction is not an admissible G0.5 derivative. The [source-clarification request SRC-02](../../releases/2026-09-13-g0/results/1014-research/source-clarifications/README.md) still requests an anonymous stable plant ID or authenticated annual linkage with split/merger/coverage rules. The owner discussion recorded in `docs/DECISIONS.md` withdrew a categorical “panel impossible” assumption; it did not supply verified links for these records.

Once links exist, lags must use actual `source_year`. A 2017 observation does not have a 2016 lag in this package. Observed absence must remain different from verified exit: the OP selection contract requires independently authenticated risk and closure information, including risk-set records outside the positive-investment estimation sample.

## Definition and price gates

**Inherited verification flags have narrower meaning than their names suggest.** `capital_stock_verified` and `capital_additions_verified` are generated for 2010–2012 based on questionnaire evidence and source presence. They must not override the newer release's source-admission gate. The latest [variable-year release status](../../releases/2026-09-13-data-foundation/results/core/variable_year_release_status.csv) labels relevant monetary/count candidates `legacy_candidate_display_only`, with `accepted_unit=False`. The detailed [annual source metadata](../../releases/2026-09-13-g0/source/source-metadata/inputs/annual_metadata.csv) retains `measurement_admitted=0` when supplier scale/release binding is unverified. For example, the [2010 capital stock acceptance code](../../releases/2026-09-13-g0/source/source-metadata/edges/source_semantics/S2-2010-capital_stock.do) asserts document/code evidence but `s2_scale==0`, `s2_release==0`, and `measurement_admitted==0`.

| Intended role | G0.5 field(s) / documented concept | Current admissibility and required resolution |
|---|---|---|
| Production outcome | `gross_output_nominal`, raw annual OUTPUT; `value_added_nominal`, raw annual VTLVCU | Reported output/income and reported signed VA candidates. OUTPUT must be distinguished from production YPRVCU; 2018 revenue/output perimeter needs exact source evidence. Do not replace reported VA with an accounting residual merely to force identity. Validate annual monetary scale and outcome concept. |
| Labor | `workers`, annual LTLNOU | Reported total-worker candidate. Validate its survey timing and headcount versus average/FTE perimeter before production-function use. Positive-domain audit is possible now. |
| Capital stock | `capital_stock_nominal`, mapped to `raw_v1115` | Documentary description: estimated current-price fixed capital at 31 December, including land. Separate from additions. Questionnaire concept is supported for 2010–2012, but exact supplier scale/release admission remains pending; later-year definitions remain candidates. Choose a defensible capital stock concept/price treatment. |
| OP investment proxy | `capital_additions_nominal`, annual CTTTCU | Documentary description: purchases/additions/construction/major repairs during year; not year-end stock and not net investment after sales. No active additions source in 2015. Verify annual scope, positive investment, price treatment and investment-proxy assumptions. |
| Legacy capital alias | `capital_nominal`, `capital_prior_mixed_nominal`, `ln_capital_nominal` | Explicit mixed legacy aliases. Never use as an accepted stock merely because positive or logged. |
| Total inputs | `intermediate_inputs_nominal`, annual IINPUT | Explicit source status says “IINPUT reported total inputs; not a validated TFP materials proxy.” Candidate coverage/accounting audit only. |
| Materials candidates | `val_rtlvcu` total, `val_rdnvcu` domestic, `val_rimvcu` imported | Annual raw bindings exist. Audit `RTLV = RDN + RIM` only as a candidate accounting relationship, preserving gaps and source states. Numeric presence and component identity cannot certify flexible-input timing, monotonicity or materials quantity. Exact annual source definitions and materials prices remain necessary. |
| Output/input/capital prices | `deflator_output`, `deflator_inputs`, `deflator_capital`, `deflator_wages` | All empty in G0.5. Historical WPI references exist, but no accepted current company/classification-to-price bridge. Never set an identity deflator or re-use the fictional industry bridge. |
| Real production inputs | `gross_output_real`, `value_added_real`, `capital_real`, `intermediate_inputs_real` | All empty in current G0.5. A current output-only deflator approximation would not supply real stock/investment/materials or satisfy the full four-method gate. |
| Industry pooling | `industry_code`, `classification_status` | Reported code is available. Annual classification edition and accepted inter-edition/price bridge remain unverified. Raw code prefixes may be shown as provisional within-wave diagnostic groups, never labelled homogeneous verified two-digit technologies. `demo_industry2` is entirely missing and is not the source industry field. |

[G0_06_stage_validate_deflators.do](../../releases/2026-09-13-data-foundation/stata-preparation/dag/edges/word_rows/G0/G0_06_stage_validate_deflators.do) deliberately creates empty real/price fields. [G0_local_prepare_numeric.do](../../releases/2026-09-13-data-foundation/stata-preparation/dag/edges/word_rows/G0/G0_local_prepare_numeric.do) retains `wpi_company_bridge_verified=0`. The [company-price gate](../../releases/2026-09-13-data-foundation/results/core/company_price_gate.csv) and [classification acceptance](../../releases/2026-09-13-data-foundation/results/core/classification_acceptance.csv) explicitly distinguish a WPI reference from a certified company match. They are semantic evidence, not G0.5 chart-data sources.

## Bounded G0.5 metadata audit

The following sums are independently reconstructed from the **current G0.5** `variable-year-coverage.csv`, not copied from historical actual statistics. “Nonzero” includes any negative values; it is deliberately not labelled “positive” or “eligible”. A subsequent Stata sign/domain audit must distinguish positive, zero, negative, missing, source-absent and masked/invalid states.

| Field | Nonnull/nonempty rows | Nonzero numeric rows |
|---|---:|---:|
| `obs_id` | 33,049 | not applicable |
| `psid` | 0 | 0 |
| `gross_output_nominal` | 33,049 | 33,049 |
| `value_added_nominal` | 33,049 | 33,049 |
| `workers` | 33,049 | 33,021 |
| `capital_stock_nominal` | 31,924 | 18,885 |
| `capital_additions_nominal` | 29,657 | 6,172 |
| `capital_stock_verified` | 33,049 | 7,030 |
| `capital_additions_verified` | 33,049 | 7,030 |
| `intermediate_inputs_nominal` | 33,049 | 33,028 |
| `val_rtlvcu` | 33,049 | 31,895 |
| `val_rdnvcu` | 33,049 | 31,404 |
| `val_rimvcu` | 33,049 | 12,206 |
| `deflator_output`, `deflator_inputs`, `deflator_capital` (each) | 0 | 0 |
| `gross_output_real`, `value_added_real`, `capital_real`, `intermediate_inputs_real` (each) | 0 | 0 |
| `wpi_company_bridge_verified`, `real_panel_ready` (each) | 33,049 | 0 |
| `industry_code` | 33,049 | not applicable |
| `demo_industry2` | 0 | not applicable |

The wave denominators are 2,334 (2010), 2,337 (2011), 2,359 (2012), 2,369 (2013), 2,452 (2014), 2,632 (2015), 3,357 (2017), 3,011 (2018), 3,007 (2019), 2,936 (2020), 3,078 (2021), 3,177 (2022), summing to 33,049 observation records. They are not a count of distinct companies.

For the G1 preparation boundary, select only required fields through `harness.data_source.load_data(mode="development", columns=[...])`. Useful groups are:

- Identity/calendar: `source_year`, `obs_id`, `psid`, `psid_status`, `real_panel_ready`.
- Candidate values: `gross_output_nominal`, `value_added_nominal`, `workers`, `capital_stock_nominal`, `capital_additions_nominal`, `intermediate_inputs_nominal`, `val_rtlvcu`, `val_rdnvcu`, `val_rimvcu`.
- Source/value flags: corresponding `st_...` and `vs_...` fields, `inputs_definition_status`, `capital_definition_status`, `capital_stock_verified`, `capital_additions_verified`.
- Price/measurement gates: `deflator_output`, `deflator_inputs`, `deflator_capital`, `gross_output_real`, `value_added_real`, `capital_real`, `intermediate_inputs_real`, `deflator_applied`, `wpi_company_bridge_verified`.
- Provisional grouping: `industry_code`, `classification_status`.

Source-state labels in [value-labels.json](../../data/g0-5-development/value-labels.json) are 0 positive, 1 zero, 2 negative, 3 observation missing, 4 source absent, 5 parse failure (`G0_source_state`). The richer `G0_tunnel_state` additionally distinguishes invalid code, missing code evidence, outside universe, retired alias and provisional observed values. Do not treat every missing value as source absence or every stored `st_` field as semantic admission. Select fields from the current manifest before export; some Stata names exceed 32 characters and require explicit deterministic export aliases with a reversible name registry.

## G2 compatibility and focused work

Live [issue #10](https://github.com/natanaelwgm/deasy-imed-si-research-2026/issues/10) is open and had no comments when inspected. It requires refreshed G0.5 quality masks bound to the same manifest as G1. Live [PR #3](https://github.com/natanaelwgm/deasy-imed-si-research-2026/pull/3), “G2: execute synthetic quality audit with eligibility and replication”, is also open and explicitly binds its results to 1,200 fictional observations, 100 fictional IDs, input SHA256 `ebded0518f4ccbcbbe8da980a716ca797953d0d1f4fe83e5285dfd9a7ff8489e`. It has no current G0.5 eligibility receipt and must not be merged as G1's current input acceptance. Its definitions/rule structure may inform focused new checks; its values, masks and fixture panel cannot be substituted.

G1 can perform the narrow production-input subset of G2 without duplicating the full energy/R&D/trade/FDI audit: mutually exclusive source/value/domain states for Y/L/K/I/materials, candidate accounting gaps, inherited-versus-current admission flags, and method gate counts by year and provisional reported industry. Store record-level masks locally and publish aggregate checks bound to this exact G0.5 manifest. If another worker provides current G2 later, require matching input hash, stable `obs_id` and one-to-one cardinality; compare overlapping rules before adopting masks.

## Implications for implementation and acceptance

The latest G1 plan is more specific than the older README. Its `pinned_method_contract` requires a real-VA Cobb–Douglas primary comparison, within verified two-digit technologies; exact-calendar transitions; separately supported OP investment/selection and LP/ACF/Wooldridge materials timing; explicit `valueadded`; ACF instruments `[lag(l), k]`; and Wooldridge `method(wrdg) gmm` with the installed source's shared nuisance coefficients. It also requires deterministic starts, genuine objective/rank/convergence diagnostics, full-process bootstrap covariance from successful draws, and 999 external plant-cluster draws for accepted empirical inference. A bounded independent method test can establish executable arithmetic but cannot claim this current empirical contract ran.

The old installed `prodest` behavior needs deliberate changes before reuse: it derives exit from the final observed row, may silently drop failed selection correction, randomizes unspecified starts, counts the original fit inside `reps`, and has a suspect Wooldridge start-parameter map. Preserve the full authenticated OP risk universe during sample formation/bootstrap. Never call a structural log-VA residual directly observed technical efficiency; preserve estimator/specification/sample/normalization metadata and distinguish proxy-based latent-productivity companions.

The empirical release must stay open until these exact inputs are supplied and accepted:

1. A source-version-bound real establishment/company crosswalk with stable surrogate `psid`, linkage evidence, ambiguity/grain policy and true calendar validation.
2. Annual source admission for output/VA/labor/stock/investment/materials concepts and stored units; 2015 additions remains genuinely absent unless a legitimate upstream replacement exists.
3. Appropriate output, materials and capital/investment deflators with admitted annual classification/concept bridges and a declared VA construction.
4. Authenticated OP risk/exit universe and selection outcomes; absence from a supplied sample is insufficient.
5. Current-input quality eligibility, followed by identified/supportable samples, moments/rank, convergence, sensitivity, full-process inference, residual attachment and all empirical charts.

G1-C1 can display numerical candidate-domain losses and exact blocking gates now, clearly separating these from estimator eligibility. G1-C2 coefficient/uncertainty and G1-C3 productivity-distribution exhibits remain blocked. G1-C4 can show the current not-attempted/failure reasons now; rank/scatter/convergence results require actual fitted methods. A gate-status visual is useful but must not be counted as delivery of unavailable coefficients, productivity distributions or rank comparisons. All 24 planned exhibit families require explicit reconciliation with these distinctions.

**Audit conclusion:** available evidence supports a reproducible, nonempty G0.5 prerequisite/coverage package and independent method validation. It supplies no legitimate numerical route around the core panel, measurement, price and OP-selection prerequisites. Preserve achieved implementation work, state exact unfinished branches, and leave #9 open while those inputs remain unsupported.

## Independent review of the initial G1 audit implementation

Reviewed `config.json`, `stata/G1.do`, and `stata/edges/G1_E01.do` through `G1_E19.do` after the prerequisite investigation. Review-set SHA256 is `ce50bb4d58c4f0c72add16c9f50733a850435a032d3f2045a230bfd2d364b728`, computed by concatenating each relative path, a zero byte, file bytes, and a zero byte, with config/main first then sorted edges. This is a static source review; no Stata success is claimed by this receipt.

The source-denominator handling, numeric missing/zero/negative/positive partition, exact-calendar operator use on verified rows, refusal to infer firms from observation IDs, and one-to-one status-sidecar merge are consistent with the frozen input contract. All-blocked estimator branches assert zero eligibility; the four numerical TFP fields stay missing. `G1_main_with_tfp.dta` is explicitly a selected-column status derivative, not a completed full-master numerical TFP attachment.

The following findings were sent to the root implementer for correction/review:

| Finding | Scope and disposition at this review |
|---|---|
| E05 real-OP stage is not intersected with its positive/domain-verified investment stage, contains no accepted real-investment operand, and OP final eligibility omits the timing gate. | Current fixed-zero upstream gates prevent a false baseline fit. Before this stage can be described as reusable eligibility, require positive accepted real investment, prior input/concept support and timing. Do not infer real investment from a boolean price flag. |
| Sequential real-input stages do not explicitly inherit every previous stage's domain/definition restrictions. | Baseline all-real-missing means current attrition is monotone. Intersect stages explicitly so future accepted data cannot increase retained counts or bypass a prerequisite. |
| E04 numeric-domain partition does not yet publish source/value states from the loaded `vs_*` fields. | Add mutually exclusive source-state × variable × year counts to distinguish source absence, masked/invalid and ordinary missing. Keep numeric domains as an independent table. `st_val_rtlvcu`, `vs_val_rtlvcu`, and corresponding RDN/RIM flags exist in the current manifest. |
| `g1_verified_*` intermediate names can overstate what inherited capital flags establish. | Use reader-facing “questionnaire concept supported” labels, with source-admission shown separately at zero. Bind the latter to the exact metadata receipt, not a naked configurable boolean. |

This section records the initial review honestly. Corrected source and focused runtime/independent numeric checks require a separate completion receipt; an initial-review hash must not be presented as the final code hash.
