# G1 v3 coordination: PR #23, PR #24 and the local implementation

Reviewed 13 September 2026 (Asia/Jakarta), after the owner's explicit G1 resume. Reviewer: independent Astra method audit. This review changed only this file, read the live issue/PR metadata and the exact local Git objects matching their live heads, and ran **no Stata estimation, data transformation, merge, branch overwrite or GitHub publication**.

**Neither PR supplies a single current-v3 OP, LP, ACF or Wooldridge fit, nor does either solve accepted deflators, real-input admission, same-version G2 acceptance or OP risk/exit evidence.** Both preserve useful v1 input audits and authored estimator workflows. The local method layer already has native execution and arithmetic evidence that those PRs explicitly lack. Keep the PRs as separately identified historical work and selectively reuse reviewed ideas rather than merging another competing G1 pipeline wholesale.

## Current authority and input

Live [issue #9](https://github.com/natanaelwgm/deasy-imed-si-research-2026/issues/9) was OPEN with no comments at read time. Its current input is **`g05-external-excel-panel-v3`**, source commit `a79cd5a5e8c1eb7fdf55c5c8aa698e4f5917f9ef`, manifest SHA256 `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`. Main at review is `73ef9279fc3be5275939dca93afcfbbe4deaf096`; its actual manifest bytes have that exact hash.

The current main instructions and data documentation explicitly accept the official fictional `psid` for **development**: 33,049 observations, 4,396 fields, 10,395 fictional firms, `psid_status=synthetic_development`. Mode-aware `load_data(require_panel=True)` and `(psid, source_year)` uniqueness are the relevant development checks. Lack of verified **real** company linkage is no longer a development blocker; it remains an actual-finalisation requirement. Actual mode must not inherit fictional links. The missing 2016 remains a real calendar gap.

The pause statement retained in main documents the earlier owner pause. The present explicit owner resume authorizes the current local G1 work. It does not turn either PR's old v1 results into v3 results or automatically accept capital, prices, quality masks, technology definitions or OP survival data. Identity repair changed metadata, not an accepted production-input specification.

## Exact reviewed heads and result coverage

| Item | PR #23 | PR #24 |
|---|---|---|
| Live title | G1: publish G0.5 results and guarded four-method TFP pipeline | G1: four-method TFP implementation and v1 audit; paused for v3 migration |
| URL | [PR #23](https://github.com/natanaelwgm/deasy-imed-si-research-2026/pull/23) | [PR #24](https://github.com/natanaelwgm/deasy-imed-si-research-2026/pull/24) |
| Head | `a5ce0d62c98d60ab1638c4c5bd2c17b605f81b2a` | `c759a0e1270d276d3ed2e53feb031998a34d7363` |
| Branch | `codex/g1-tfp-evidence-20260913` | `codex/issue-9-tfp-audit-and-estimators` |
| Merge base with current main | `fd3cfa37e24cd62eced5e1ca657722f134023fb5` | `73ef9279fc3be5275939dca93afcfbbe4deaf096` |
| Proposed scope | 479 files: 477 under `rows/G1`, one request-README edit, one history entry | 188 files: 185 under `modules/G1`, one request-README edit, one history entry, one workflow |
| Data manifest physically at branch head | v1: `85f7cd5e79bb7868cf6c0956cbc4ed2d6e8f84ecb1a44e7713d38570929a4270` | v3: `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260` because current main was incorporated |
| Manifest of executed G1 evidence | v1: `85f7…4270`, 33,049 × 4,379 | v1: `85f7…4270`, 33,049 × 4,379 |
| Native estimator execution claimed | None; Stata unavailable, acceptance CLOSED | None; Stata unavailable, acceptance CLOSED |
| Current-v3 coefficient/prediction/bootstrap evidence | None | None |
| Important status distinction | The title's “results” means measured input diagnostics, not TFP coefficients | A branch containing v3 data is still a v1-only G1 implementation; its status page states this explicitly |

The local remote-tracking refs matched both live `headRefOid` values exactly. The comparison used the full Git diff against each merge base, not the first 100 files returned by a PR API page. No branch fetch, checkout or merge was needed because root had already fetched the matching objects.

## Input/admission findings from actual code

### PR #23

- `rows/G1/edges/G1_E03_panel.do` requires `psid_status == "verified"` and `G1_PANEL_VERIFIED=1`. This directly rejects current official `synthetic_development` IDs. Its real-only gate cannot be adopted for development without a mode-aware correction.
- `rows/G1/python/inspect_input.py:478–486` deliberately expects `load_data(require_panel=True)` to fail and raises `ValueError("Panel gate unexpectedly accepted")` on success. Replaying that audit on valid v3 therefore fails for an obsolete expectation. Several output records also hard-code zero verified panel counts and “all psid missing”; a manifest update alone would leave false narratives.
- `rows/G1/edges/G1_E04_domains.do` **consumes**, rather than constructs, `value_added_real`, `capital_real`, real proxies and `g2_eligible`. It requires externally accepted semantics/G2 flags. Missing `investment_real`/`intermediate_inputs_real` are explicit missing placeholders. There is no discovered price series or accepted deflation bridge here.
- The retained acceptance JSON explicitly has `Stata_executed=false`, an empty `TFP_estimators_executed` list, C2/C3 blocked, and v1 manifest `85f7…4270`. The native review receipt is expressly static and marks native validation `NOT_RUN`.
- Its measured nominal domains are substantive historical diagnostics: 18,885 positive corrected nominal-stock observations, 18,872 positive nominal VA/labor/stock jointly, 5,603 nominal OP-domain records, 18,865 nominal LP/ACF/Wooldridge-domain records, and 5,601 common-domain records. These are **not accepted dynamic fit counts**. The v3 release states economic measurements were preserved, so these diagnostics are useful expected reconciliation targets; they must still be replayed/hash-bound before being presented as v3 evidence.
- Its source-preserving DTA is a 33,049 × 4,395 **v1 status attachment**: every TFP field is missing and every method estimation flag is zero. The reported 144,721,571 original-cell roundtrip covers 33,049 × 4,379 source cells, not current v3's full schema and not estimated TFP.

### PR #24

- `modules/G1/audit.py:26` pins `EXPECTED_MANIFEST=85f7…4270`; `verify_package()` rejects the current v3 manifest. `CURRENT-STATUS.md` explicitly records that the code has not been migrated and that no v3 G1 rerun occurred.
- `modules/G1/rows/G1/edges/G1_E03.do` also requires literal `psid_status == "verified"`. Its `blocked_unverified_panel` result describes the old v1 boundary; it must not be retained as the current development diagnosis.
- `canonical_boundary()` in `modules/G1/audit.py` forwards existing real/candidate fields, sets `real_investment` and OP risk/exit fields to missing, and sets `g2_eligible`, VA/labor/capital/investment/intermediate/technology/risk acceptance flags to zero. It is an explicit admission boundary, **not a source of missing deflators or approval**.
- E04 derives logs only after those flags, so it cannot open an eligible real-input branch by itself. E05 preserves OP risk records separately but does not discover or authenticate their outcomes.
- Its acceptance JSON reports zero native scripts executed, zero empirical methods executed, zero scientific exhibit families accepted, and the requested coefficient/TFP artifacts not produced. The retained report and charts are Python input-validation outputs.
- The PR explains that its full-source plan hash assertion failed after upstream moved to v3. This is an honestly preserved version failure, not evidence that a v3 numerical fit failed.

## Scientific implementation overlap and a concrete native defect

Both PRs follow the same pinned scientific architecture as the local `work-items/G1/stata/methods/` code: real-value-added Cobb–Douglas; positive-investment OP with full risk universe; LP NLS; ACF's distinct first stage and `[lag(labor), capital]` moments; restricted shared-theta Wooldridge system GMM; deterministic starts; exact calendar lags; full-process plant bootstrap; structural residual separated from latent proxy productivity. Their common design does not by itself add another validated numerical implementation.

A concrete incompatibility was identified in **PR #24**: `modules/G1/rows/G1/lib/g1_fit.do:309–315` supplies `technique(gn)` together with `conv_nrtol(1e-5)`. The installed Stata 17 source `/Applications/Stata/ado/base/_/_parse_gmm_optim_opts.ado:121–125` explicitly rejects that combination with return code 198. This finding is a static source comparison; no Stata execution was performed during this review. The existing local tested wrapper deliberately omits Newton tolerance for GN and records effective parameter/value tolerances separately. Do not replace it with this unexecuted command.

PR #23's `rows/G1/estimators/G1_Wooldridge.do` correctly omits that GN/Newton-tolerance conflict, preserves shared theta, uses actual instrument/Jacobian rank, and states its extra restriction. Its acceptance still requires native syntax, numerical and source-equivalence tests. No assertion of full native correctness is made here.

The local method tests already executed four distinct point fits and a bounded two-draw-per-method bootstrap on a **separate algorithm-only fixture**. Those are useful implementation evidence for the resumed task, not v3 empirical findings. The v3 input/selection/sample run remains separate and must retain its own receipts.

## Useful selective reuse

| Candidate | Concrete use | Required treatment |
|---|---|---|
| PR #23 `rows/G1/python/verify_attachment.py` and source-cell roundtrip receipt | Cross-check full original-column attachment methodology and alias preservation | Adapt current 4,396-column schema, identities and source hash; rerun locally; do not inherit the old pass |
| PR #23 diagnostic/report and chart checks | Additional nominal-stock comparison, accounting identity, log/level coherence and chart-geometry checks | Reconcile with current Stata-derived values; preserve the Python-inspection versus Stata-analysis distinction |
| PR #23 `rows/G1/estimators/G1_selection.do` | Separates OP risk-source, complete-lag risk and production denominators; common sample does not depend on OP coefficient convergence | Review against local event-time contract; numerical tests before any code replacement |
| PR #23 E16 and PR #24 `rows/G1/driver/G1_bootstrap.do` | Joint returns-to-scale draws/covariance; PR #24 uses the same cluster stream for own/common and paired shared-domain differences | Port the idea into the existing validated module if required; audit sample construction, repeated-draw IDs, numeric storage and covariance; a 999 loop is not an executed bootstrap |
| PR #24 method diagnostics | Explicit singular values and Jacobian-scale descriptions; expected-versus-observed parameter stripe checks | Useful additional diagnostics after focused native tests; retain the GN fix and current local adapter provenance |
| Both DAG/exhibit registries and quality reviews | Independent completeness checklist for the 24 exhibit families and C1–C4 | Reconcile, do not duplicate canonical registries or mark blocked families delivered |
| Both Luna comment receipts | Evidence that those historical code versions underwent a review | Do not transfer the receipt to different local/v3 code; rerun the dedicated comment/continuity pass for the delivered source |

## Integration recommendation

1. Continue from current main and keep `work-items/G1` as the current local implementation. Neither PR changes that directory directly; **file collisions are absent, but scientific/workflow duplication is substantial**. Their two request-README additions also need one coherent current navigation entry.
2. Preserve #23 and #24 unchanged while reviewing and reusing selected material. Keep their v1 inputs, snapshots, failures and result coverage explicit. Do not describe them as v3 fit work merely because #24 incorporates v3 main.
3. Implement one mode-aware development admission path using the official v3 `psid`; actual finalisation retains separate genuine-linkage checks. Do not weaken actual guards to accommodate development.
4. Resolve production inputs, accepted deflator choices, technology/sample classification, same-input G2 checks and OP risk evidence through the current root audit. **These PRs do not remove those prerequisites.** Positive nominal support is evidence for an input decision, not that decision itself.
5. Reuse tested local estimator machinery and bring across only a concrete missing feature. A borrowed code block needs new scientific review, native execution and hash/comment continuity evidence. Avoid importing PR #24's GN command or any real-only development gate.
6. Reconcile all required output families and publish one truthful current delivery linked to #9. If some core methods remain unsupported, retain method-specific reasons and an open issue. Ordinary reviewed integration can preserve both historical PRs as evidence without creating three independently active G1 pipelines.

This review does not certify a current v3 production sample, deflator or estimator result. Root owns that independent data audit and any subsequent integration decision.
