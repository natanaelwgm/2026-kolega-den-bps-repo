# Independent G1 source and scientific review

Reviewed 13 September 2026, 18:03 WIB / 11:03 UTC. Reviewer: independent GPT-6 Astra prerequisite-review subagent. Scope: static review of the G0.5 audit entrypoint, validation, source-evidence binding, sample edges and the four-method implementation. Only this file is written by this review task. No Stata run, company-data load or executable-code change was performed by this reviewer.

**Status at this checkpoint: corrections identified and communicated; final acceptance not yet certified.** The current G0.5 empirical branch remains blocked. The review finds that the guarded wrapper follows the pinned four-method equations, while identifying validation and adapter hardening needed before describing the delivered package as fully checked.

## Fixed findings from the prerequisite review

- `G1_E05.do` now intersects OP's real stage with its positive nominal/concept stage, requires a positive nonmissing `g1_real_investment`, and includes the timing gate. The real investment variable remains missing on this unsupported input; no substitute value is invented.
- `G1_E06.do` now intersects its real stage with prior nominal/concept support. The fixed baseline therefore preserves the declared sequential attrition structure.
- `G1_E04.do` now outputs `source_status.csv` from the selected `vs_*` fields, alongside the distinct numeric-domain table.
- `source-gates.json` pins exact release/admission, identity, classification, price and method-plan evidence. `run.py` validates those hashes before loading the selected G0.5 columns.

These findings were checked directly in changed source, not inferred from an implementer's assurance. Source-level correction is distinct from successful rerun evidence.

## Remaining findings sent to the implementers

| ID | Location | Finding and required action | Checkpoint status |
|---|---|---|---|
| IR-01 | `validate.py` | Row-by-row validation checks only rows that exist. Missing/duplicate source-state, variable-year or funnel cells can escape that form of check. Assert expected variable × 12-year domains, key uniqueness and full mutually exclusive-state totals. | Reported to root; final correction/retest not yet inspected. |
| IR-02 | `validate.py` | Funnel counts are checked against Stata-created `g1_*` flags. That validates aggregation but would not detect an incorrectly constructed eligibility flag. Independently reconstruct nominal base, OP/material positive domains and inherited concept masks from unchanged source values, then compare observation masks and aggregates. | Reported to root; final correction/retest not yet inspected. |
| IR-03 | `g1_prodest_point.ado` | The direct adapter accepts `opprob()` but only asserts probability bounds if nonmissing. Its retained Mata conditional selects an uncorrected polynomial when any `PR_HAT` is missing. `g1_fit` guards its own dynamic sample, but a malformed direct adapter call can still bypass required OP correction. Add a nonmissing/range assertion after the actual OP transition sample is formed, with a targeted malformed-probability refusal test. | Reported to method implementer and root; final correction/retest not yet inspected. |
| IR-04 | `g1_fit.ado` eligibility contract | `eligible()` is a pre-lag source-domain mask, and the wrapper constructs `domain & L.domain`. Root `g1_eligible_*` flags already include lag support. Future integration must pass an explicitly documented pre-lag mask, otherwise it applies eligibility/lag selection twice. | Interface clarification required before future empirical wiring. Current blocked branch does not call the fitter. |
| IR-05 | `g1_prodest_point.ado` diagnostics | The optimized transition nuisance matrix, including OP probability polynomials/interactions, is solved with QR but its rank/columns/condition are not recorded. First-stage and instrument ranks are different checks. Retain actual transition-design diagnostics and explicitly reject or document rank deficiency; do not describe complete rank coverage without them. | Reported to method implementer and root; final correction/retest not yet inspected. |
| IR-06 | Wooldridge tolerance receipt | The inherited GN branch deliberately does not pass `conv_nrtol(tolerance)` to `gmm`; `tolerance(.00001)` therefore does not establish an effective GN tolerance of 1e-5. Retain exact effective/default settings or state the limitation accurately. | Reported to method implementer and root. |
| IR-07 | `run.py` publication | Copying new files over `release/` with `dirs_exist_ok=True` leaves obsolete generated files if a later run renames or omits them. Preserve the already-backed-up prior release and publish a clean staged directory whose contents reconcile to the new manifest. | Reported to root; final correction/retest not yet inspected. |
| IR-08 | `run.py` failure provenance | Code pins are retained only in the success manifest. Save start/code/input metadata before Stata launch so a failed run remains bound to the exact attempted code, as required by the execution-evidence contract. | Reported to root; final correction/retest not yet inspected. |
| IR-09 | `validate.py` source preservation | `assert_frame_equal(..., check_dtype=False)` permits default floating tolerance. The check promises exact source-cell preservation, so add `check_exact=True` or zero tolerances. | Reported to root; final correction/retest not yet inspected. |
| IR-10 | `validate.py` chart/table coverage | The `estimator_status` heatmap reads `eligibility_gates.csv`, which was not yet independently reconciled. Check all 11 gates × 12 years, unique keys and exact pass/unknown/not-pass counts; independently validate exported numeric-domain minima/maxima as well. | Reported to root; final correction/retest not yet inspected. |

IR-01/02 and IR-07/08 concern coverage and reproducibility, not an observed change to current source records. IR-03 concerns direct adapter calls; the inspected `g1_fit` wrapper already rejects unavailable probabilities on its production transitions. None of these points permits relaxing the missing G0.5 scientific prerequisites.

## Scientific checks of the wrapper and point adapter

The review read the current `pinned_method_contract`, `METHOD-AUDIT.md`, the wrapper, bootstrap source, exact vendor-to-adapter diff and relevant vendor sections. The following agreements were verified statically:

- All four guarded methods explicitly select value-added Cobb–Douglas. OP uses an investment proxy and required selection correction; LP uses the registered partially linear/NLS branch; ACF uses the complete labor/capital/proxy first-stage polynomial and lag-labor/current-capital moments; Wooldridge explicitly selects `method(wrdg) gmm`.
- The primary Wooldridge system preserves the pinned shared nuisance `theta` across current and lagged bases. Its structural starting values use the actual GMM parameter names. The separate-nuisance-coefficient alteration in historical PR #4 is not silently imported.
- ACF's cubic Markov projection and weighting formula `invsym(Z'Z)/N` match the pinned source. Degree-two sensitivity affects the first-stage proxy polynomial, not the cubic Markov stage.
- OP selection is estimated on the full retained authenticated risk universe before filtering the production sample. The wrapper rejects missing risk/exit evidence, absent variation in exit outcomes, rank failure, nonconvergence, perfectly predicted/dropped selection records, and unavailable production-transition probabilities. Risk timing is explicitly an interval from calendar t−1 to t.
- The wrapper uses `xtset id time, delta(1)` and checks the actual estimator transition count against its expected exact-calendar sample. No conversion of `obs_id` or row order to company identity was found in this path.
- NM/d0 or registered DFP, deterministic coefficient starts and the installed GMM compatibility cap at Stata 14 are explicit. Optimizer success is not represented as proof of timing, scalar proxy inversion or economic identification.
- `g1_bootstrap` first computes an original estimate, then independently resamples the whole retained source/risk universe by plant. `idcluster()` gives repeated sampled plants separate bootstrap identities. It reconstructs lags and refits all selected stages. The original estimate is not counted as a random draw. Successful draws and failed return codes are saved, and sample covariance uses the successful-draw set with its declared B−1 denominator.
- Point estimates do not advertise an internal-bootstrap covariance or generic latent-productivity `predict, omega`. Common production residual interpretation retains measurement/transitory error. A separately authenticated future empirical branch is still needed for inference, common-sample comparisons and attachment.

This is verification against the **pinned implementation contract**, not a general proof of all possible OP/LP/ACF/Wooldridge variants or a substitute for economic identification review.

## Runtime evidence actually inspected

The reviewer inspected the existing guard log, four-method algorithm source/result CSV, and the independent arithmetic-oracle source. The algorithm source constructs an independent fictional test, clearly labelled `INDEPENDENT_ALGORITHM_TEST_NOT_G05`; it is not a G0.5 input option. Its fixtures use 180 plants and 2,160 retained rows with no 2016. The arithmetic receipt present at this checkpoint reports PASS for 1,273 dynamic transitions and 1,348 OP-selection records. Its `bootstrap` list is empty at the moment read, so this review does **not** claim bootstrap runtime/covariance validation from that receipt. The method implementer was continuing targeted validation while this independent static review ran.

Existing logs are evidence of the other implementer's runs. This reviewer did not initiate Stata or perform independent empirical fits. Later changed source requires its own fresh matching execution receipt; an older successful log cannot certify an updated adapter automatically.

## Reviewed source hashes

These hashes identify the source snapshot examined. They are a checkpoint, not a claim that still-changing files are final.

| File | SHA256 |
|---|---|
| `run.py` | `43a8d0969db6015cab7f7d810b65767750006897137b4073dd62016e739f8e27` |
| `validate.py` | `a909bfbdc7aa2e45e72e0a489daac40fdcb188fa05442f9f290c78b867fe7ef8` |
| `source-gates.json` | `e61c4660e5f92ab6ac7316e9fdbe7c3229395d41d9775f5ac31b1d0f4b575a14` |
| `stata/edges/G1_E04.do` | `decd09d8b8d0afb3b896a5f71e1699ad98112aac87c1a57706c85f72b7d1bdd2` |
| `stata/edges/G1_E05.do` | `d3a3d6bd3f91caa3c5ea1e7ddd9d0055bbf8222b5740a6075194119e166a23b9` |
| `stata/edges/G1_E06.do` | `6568fbdafb056e95c2b34ee11568e5897a417eb4af3bb43ea6d825a85144c5ec` |
| `stata/methods/g1_fit.ado` | `25b64c2936c141cbaafb8614fee9821962617024aa47e1e5dd76287cfd8cf6b4` |
| `stata/methods/g1_bootstrap.ado` | `4e79e17c87dafc37440f5a8123eab2b9eb7195b52ac133d3e205f92d92aba16a` |
| `stata/methods/g1_prodest_point.ado` | `9d2e1fbcebf1fc78d611a10f27a9b1cde818224109bb90eff25074da5fa42927` |
| `METHOD-AUDIT.md` | `e5f70606fe4f262c5807ed664f33ff73f1e23a5dd0979586bd5b3256f19c4a5e` |

The empirical status remains: zero G0.5 fits, no admitted panel/real-input/price/OP-risk branch, and no basis to close issue #9. The legitimate next steps are correcting these bounded implementation findings, preserving corresponding rerun evidence, and keeping unsupported empirical outputs explicitly open.
