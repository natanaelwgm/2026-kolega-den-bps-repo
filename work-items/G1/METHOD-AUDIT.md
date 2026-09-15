# G1 independent scientific and implementation audit

> **Version note, 13 September 2026:** The audit below preserves its original review scope. G0.5 v3 now supplies the official fictional panel accepted for development. The current nominal development fits and their limitations are documented in [the current report](report.md), [the economic v3 audit](qa/v3-economic-prerequisites.md), and [measurement-mode addendum](stata/methods/MEASUREMENT-MODES.md). Earlier references to unverified identities do not block the authorized development panel.

Audit date: 13 September 2026, Asia/Jakarta. Reviewer: delegated Astra method audit. Scope: G1 only. PR #4 reviewed at `c13bc2ab5fc7cdf169145ba918fc743b31cd7d62`; this is a read-only review of that branch. New implementation is under `work-items/G1/stata/methods/`. No original company records or historical actual datasets were read for this audit.

**Finding:** PR #4 contains real, distinct OP, LP, ACF and Wooldridge implementations and useful diagnostics, but it neither supplies G0.5 estimates nor implements the currently pinned primary contract in full. The new guarded adapter preserves the current contract and has passed four-method execution on a newly generated, separately labelled algorithm fixture. G0.5 remains empirically blocked by source prerequisites documented in this delivery. Algorithm success cannot close issue #9.

## Evidence reviewed

- Root `AGENTS.md`, G1 request `SOURCE.md`, `README.md`, and the full `pinned_method_contract` from `releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json`.
- PR #4: `data/synthetic-development/g1-tfp/code/G1_01_contract.do`, `G1_02_scenario.do`, `G1_03_fit.do`, method dispatch children, `G1_04_compare.do`, `G1_05_uncertainty.do`, `G1_07_rank.do`, `instrument_package.py`, `validate_results.py`, `vendor/prodest.ado`, `g1_prodest.ado`, `contracts/SPECIFICATION.md`, retained coefficient tables and probe logs.
- Predecessor `references/cips-harness/files/ART-01-65f84f83/C850_build_csis_prodest_tfp.do`: historical LP, LP-ACF and Wooldridge implementations. Earlier time compression, selected histories, proxy deflation and gross-output choices are not accepted current choices.
- Installed prodest 1.2.2 and help/prediction files: all three match the hashes pinned in the current G1 plan. Copies are retained unchanged in `stata/methods/vendor/`; the installed package was not changed.

## What can and cannot be reused from PR #4

| Component | Verdict and reason |
|---|---|
| Unchanged prodest source | Reuse with exact source hashes and original attribution. The source implements distinct statistical branches. |
| Controlled scenario design | Useful historical test evidence; do not use as the new input or transfer its coefficients. Its 600 simulated plants and 7,200 rows are separate from both the old 1,200-row G0 and current G0.5. |
| Exact `xtset id year` and gap assertions | Retain this principle. 2015 to 2017 cannot create a one-year lag. |
| Source preservation and one-to-one join assertions | Retain the checks, with the current verified keys/version. Old `selected_firm_id` identities cannot be substituted for G0.5 `obs_id`. |
| QR projection, double intermediates, explicit deterministic starts | Reuse after an exact diff and arithmetic checks. QR changes numerical evaluation, not the population moment equations. |
| WRDG separate `xd` nuisance coefficients | **Do not carry into the primary estimator.** The latest plan explicitly retains the installed source's shared `theta`. A separate-coefficient system requires a separately frozen sensitivity specification; it is not a harmless diagnostic patch. |
| PR #4 adapter claim “no equation changes” | Incorrect: separating the nuisance coefficients changes restrictions. The new manifest says precisely which equations are retained. |
| OP built-in sample exit indicator | **Reject.** The vendor labels the last selected row before maximum sample date as an exit, after production filtering. This can turn missingness or failed domains into a closure. |
| OP fall-through when logit fails | **Reject.** A failed selection model must not become a successful uncorrected primary OP result. |
| Instrument diagnostics | PR #4 also reconstructs actual instrument matrices, which is useful. Its generic `G1_opt` last column for WRDG is `e(rank)`, not rank of an instrument matrix; keep these quantities separately named. |
| Bootstrap | PR #4 has 50 full plant resamples per method/sample, useful development diagnostics. This is not the current 999-draw requirement, not an empirical G0.5 confidence interval, and not evidence of required OP selection resampling. |
| PR #4 numeric validation | It validates preservation, arithmetic, samples and convergence on its own fixture. It does not establish economic identification, broad Monte Carlo validity, OP selection validity or G0.5 readiness. |

PR #4 explicitly writes four missing TFP fields and zero eligibility into its old 1,200-row G0 derivative. Its successful coefficients come from its independent scenario. This distinction was verified in actual code and retained outputs, not inferred from its title.

## Scientific contract retained in the new adapter

All four methods estimate the same registered value-added Cobb–Douglas structural coefficients: `y = beta_L*l + beta_K*k + omega + epsilon`. `y` must be the log of an accepted real value-added measure, `k` the log of an accepted real capital stock, and `l` log labor. A material/intermediate-input proxy is not an extra value-added production coefficient. Nominal money, capital additions, and total expenditure are not automatic replacements. The choice of real VA remains conditional on the upstream deflation decision.

OP uses positive real investment, a partially linear first stage and a cubic conditional productivity/selection projection. LP uses the registered intermediate proxy and the pinned nonlinear least-squares second stage without selection correction. ACF uses the full first-stage polynomial in labor, capital and proxy, then estimates both structural coefficients using innovations instrumented by lag labor and current predetermined capital. Wooldridge explicitly invokes system `gmm`, with common structural coefficients, shared nuisance `theta`, current and lagged proxy bases, and separate equation instruments as pinned. The pinned shared-theta restriction is an implementation-specific maintained restriction; it must not be described as the unrestricted general Wooldridge formulation.

The primary proxy polynomial is degree 3; degree 2 changes the proxy polynomial only. The productivity transition remains cubic. Primary NM/d0 settings, 10,000 iterations, nrtol 1e-5 and simplex delta 1e-5 are retained; DFP is the registered diagnostic alternative. OLS starts are supplied deterministically, with the two registered coefficient starts available. WRDG uses GN under the source's Stata compatibility version cap of 14, even when run on Stata 17.

Neither full matrix rank nor a converged optimizer proves the economic timing, scalar proxy inversion, or monotonicity assumptions. The wrapper rejects exact first-stage or instrument rank failure and inspects optimized transition/selection-polynomial rank, the local ACF moment Jacobian and the stacked WRDG Jacobian; substantive assumptions remain part of the accepted specification.

## OP risk timing and source boundary

The wrapper fixes `risk_t` as independently authenticated membership in the risk set for the interval from calendar `t-1` to `t`, and `exit_t` as authenticated closure during that interval. Observed current survivors have `exit_t=0`. Risk/exit-only rows outside the positive-investment production sample remain in memory during selection fitting and are included in a plant resample. No row is invented by the wrapper.

The logit uses the actual calendar-lagged degree-d capital/investment basis on that authenticated risk universe. Unknown risk status or missing lagged inputs does not enter the logit. The fitted selection sample, exit count, rank and likelihood are returned separately. Both observed outcomes are required; nonconvergence, exact rank failure, dropped perfectly predicted observations or an unavailable probability on a coefficient-estimation transition abort OP. There is no no-exit fallback in the required primary branch.

This explicit event-time convention is an implementation contract requiring verification against incoming survival evidence. Existing unverified G0.5 identifiers or observation absence cannot satisfy it.

## Implemented corrections and checks

1. `g1_fit` rejects unverified panel/input receipts before forming lags. The supplied integer switches are deliberate programmer gates, not independent certificates: the calling module must hash-bind and verify the source/approval receipts.
2. `g1_prodest_point` consumes externally fitted authenticated OP probabilities; it never generates an exit indicator or disables selection on failure.
3. One point estimate is exposed with `reps(1)`; default internal bootstrap and its covariance denominator are unavailable. `g1_bootstrap` resamples the entire retained source/risk universe by plant, assigns fresh draw IDs, reconstructs lags and reruns all stages.
4. WRDG starts bind to the real structural parameter names, with exact analytic derivatives that preserve shared `theta`. The dynamic estimation sample is checked against the wrapper's exact-calendar sample.
5. The optimized transition matrix rank/columns/condition are returned for OP/LP/ACF. A direct low-level OP call also refuses missing selection probabilities; the negative test executes that refusal. Effective GN parameter/value tolerances are read from the current Stata parser under compatibility version 14, with explicit `gmm_nr_tolerance_applied=0`.
6. Structural residuals are defined as `y-beta_L*l-beta_K*k`, with measurement/output error retained. No generic `predict, omega` is supplied; e(V) is not presented as inference from a point fit.
7. Rank, objective, convergence and sample records are separate. Numerical failures remain failures; coefficients are not constrained toward plausible values.
8. Vendor hashes, adapter hash, deterministic builder and full source diff make every edit inspectable. No installed Stata package is modified.

## Execution evidence and limits

`stata/methods/tests/guards.log` records successful refusal for all four methods with an unverified panel, all four with unverified inputs, OP without authenticated selection, a dataset containing only skipped calendar transitions, and a rank-deficient ACF design. Caller records survived failed fits unchanged.

`stata/methods/tests/algorithm.do` constructs **new, explicitly labelled algorithm-only data**: 180 fictional plants, 2,160 retained plant-years over 2010–2022 without 2016, with independently generated noise and authenticated simulated risk outcomes. A random-walk productivity process is chosen so that the pinned shared-theta WRDG restriction is compatible with the test design. This is neither an input option nor a fallback for G0.5.

The retained point-run log shows all four distinct methods converged on 1,273 production transitions. OP selection uses 1,348 observations, proving that 75 selection observations outside the production-transition sample were retained. Estimated labor/capital coefficients were OP 0.598625/0.314289; LP 0.598625/0.313009; ACF 0.606783/0.315471; WRDG 0.598700/0.313208 against fixture coefficients 0.6/0.3. These numbers only test the algorithm. They are not research findings and are not the inferential coverage of G0.5.

An additional bounded run executed two external full-process draws per method (eight draws total), including repeated OP selection. All eight succeeded. Independent NumPy/SciPy reconstruction matched the four Stata objective values to at most 3.33e-11 absolute error and the four `B_success−1` covariance matrices to at most 3.92e-17. The exact errors, counts and test scope are in `stata/methods/tests/arithmetic-validation.json`; `bootstrap.log` retains execution. Two draws validate implementation mechanics, not interval adequacy.

This bounded execution does not replace the 999-draw accepted-input bootstrap, specification/optimizer sensitivity grid, common-sample comparisons, or scientific examination of a future accepted panel. The audit does not certify all possible data-generating processes. Current empirical closure remains impossible without verified identifiers, real input/deflator definitions and OP risk/exit evidence.

## Primary scholarly sources

- [Olley and Pakes, NBER working paper and published-version record](https://www.nber.org/papers/w3977): models productivity jointly with input choice and survival; this motivates an authenticated selection universe rather than a last-row indicator.
- [Levinsohn and Petrin, NBER working paper and published-version record](https://www.nber.org/papers/w7819): intermediate inputs can serve as controls for unobserved productivity under the maintained restrictions.
- [Ackerberg, Caves and Frazer, Econometric Society](https://www.econometricsociety.org/publications/econometrica/2015/11/01/identification-properties-recent-production-function-estimators): explains the functional-dependence problem and why ACF is a distinct estimator.
- [Wooldridge, publisher DOI](https://doi.org/10.1016/j.econlet.2009.04.026): primary reference for the system GMM formulation. Publisher access returned HTTP 403 during this audit; exact implemented equations were reviewed directly in the pinned source/help and the G1 contract, not claimed as newly read from the unavailable full article.
- [Rovigatti and Mollisi, Stata Journal](https://www.stata-journal.com/article.html?article=st0537): primary implementation reference, including numerical sensitivity to optimizers/starts. This is the basis for recording diagnostics rather than treating package success as sufficient validation.
