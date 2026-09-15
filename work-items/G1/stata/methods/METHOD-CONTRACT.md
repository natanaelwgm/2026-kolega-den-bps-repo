# Executable mathematical contract

This contract implements the current G1 pinned plan. It is conditional on upstream acceptance of one technology pool, one source version and the declared economic timing. It does not certify those inputs.

## Input and output grain

`g1_fit` receives the entire accepted plant/calendar source universe in memory. The key is numeric verified plant ID plus integer actual calendar year; it must be unique and nonmissing. `eligible()` is the **pre-lag source domain**: accepted positive real inputs, suitable technology and quality eligibility. It must not already require a prior eligible year. The wrapper creates the dynamic sample `D_t = eligible_t × eligible_(t−1)` using `xtset id year, delta(1)` and complete current/lagged logged production fields. A missing 2016 yields no 2017 transition. `obs_id` alone is never a plant ID.

For OP the input additionally contains independently authenticated risk/exit records even where production eligibility is zero. Each row is at plant/year grain. `risk_t=1` means observed exposure to possible closure during `(t−1,t]`; `exit_t=1` means authenticated closure in that interval. Production observations used at `t` must be authenticated continuers. This event-time definition must match the source receipt before the caller sets `selectionverified(1)`.

Returned coefficients have method/specification/sample grain; `e(sample)` has source-row grain. The wrapper returns separate source, first-stage, dynamic and OP selection denominators. It leaves original records in memory and supplies no automatic proxy-productivity prediction. A successful point fit provides no empirical standard errors.

## Shared production model and basis

The maintained value-added model is:

`y_it = beta_L l_it + beta_K k_it + omega_it + epsilon_it`.

`y` is log accepted real value added; `l` log accepted labor; `k` log accepted real capital stock. OP `p` is log accepted positive real investment; all other methods use log accepted positive real intermediate-input proxy. Real input definitions, price bases and positivity are upstream contracts; the method never substitutes nominal values or stock additions.

`B_d(k,p) = { k^a p^b : 1 ≤ a+b ≤ d }`. The primary degree is 3; degree 2 is the registered sensitivity. Intercepts are separate. ACF uses `B_d(l,k,p)` with all unique monomials of total degree 1 through `d`, with one copy of linear labor. No extra calendar controls or optional instruments are silently added.

## OP

First stage: least squares of `y` on `[l,1,B_d(k,p)]`. Retain `beta_L` and `phi = fitted_y − beta_L l`.

Selection stage: on the full authenticated risk universe with complete real-calendar-lagged `B_d(k,p)`, fit `Pr(exit_t=1 | B_(t−1))` by logit. Production eligibility is imposed only after fitting this model. Require variation in the observed exit outcome, convergence, full selection-design rank and no rows silently removed by perfect prediction. Keep the risk source in every bootstrap draw.

For candidate `b_K`, form `omega = phi − b_K k` and `omega_lag = phi_lag − b_K k_lag`. Define the transition matrix:

`H = [1,w,w²,w³,q,q²,q³,qw,q²w,qw²]`,

where `w=omega_lag` and `q` is the authenticated fitted exit probability. Least squares projects current `omega` on `H`. Minimize `sum[(y−beta_L l)−b_K k−H g_hat]²` on `D_t`. The transition matrix must be full rank at the optimum. Direct low-level calls with missing required probabilities also abort. There is no uncorrected fallback.

## LP

Use the intermediate-input proxy in the same partially linear first stage, retaining `beta_L` and `phi`. For candidate `b_K`, project `omega=phi−b_K k` on `[1,w,w²,w³]` and minimize `sum[(y−beta_L l)−b_K k−g_hat(w)]²`. This is the pinned NLS implementation. The primary LP branch has no attrition correction; its scientific applicability remains conditional on the accepted sample/timing assumptions.

## ACF

Regress `y` on `[1,B_d(l,k,p)]`, obtaining `phi`. For `b=(b_L,b_K)`, form `omega=phi−b_L l−b_K k`; obtain the innovation `xi` after projecting `omega` onto `[1,omega_lag,omega_lag²,omega_lag³]`. Use `Z=[l_lag,k]` and the pinned objective:

`Q(b) = (Z'xi)' [invsym(Z'Z)/N] (Z'xi)`.

Current capital is predetermined; lag labor is orthogonal to the current innovation under the maintained timing. Record actual `rank(Z)`, conditioning and local numerical rank of `d mean(Z xi)/d b` at the solution. Exact rank failure is fatal. These diagnostics do not prove the timing or proxy-inversion assumptions.

## Wooldridge: pinned shared-theta system

The implemented primary system is the exact pinned prodest restriction:

`r1 = y − b_L l − b_K k − a0 − B_d(k,p)'theta`,

`r2 = y − b_L l − b_K k − a0 − e0 − B_d(k_lag,p_lag)'theta`.

`theta` is shared; a separate-theta model is not secretly substituted. Instruments are `Z1=[1,l,B_d(k,p)]` and `Z2=[1,k,l_lag,B_d(k_lag,p_lag)]`. The source explicitly executes `method(wrdg) gmm` with two-step weighting initialized by `winitial(unadjusted,independent)` and GN. Parameter names in starting values match the structural `b_L,b_K` names; the analytic derivatives match both equations, including shared theta.

The actual matrices and the stacked moment Jacobian must have full estimable rank. Wrapper `instrument_rank` is the rank of the block instrument matrices, not Stata `e(rank)`. The source's `e(rank)` is retained only in low-level diagnostics alongside weight/covariance evidence.

The installed source invokes GMM under `version min(max(10,current),14)`. The wrapper records actual Stata and effective compatibility. For GN, source `tolerance(1e-5)` does not set Newton tolerance: explicit Newton tolerance is incompatible with GN. Native parser values for parameter and criterion convergence are read under version 14 and returned; the current Stata 17 parser supplies 1e-6 and 1e-7. `gmm_nr_tolerance_applied=0` prevents an incorrect tolerance claim.

## Numerical and inferential rules

For OP/LP/ACF retain NM, evaluator d0, maximum 10,000 iterations, nrtol 1e-5 and simplex delta 1e-5. DFP is the registered alternative. Starts are deterministic OLS or (.3,.7)/(.7,.3); non-ACF OP/LP use only the capital component in stage two. Transition polynomial degree remains 3 for both proxy-polynomial degrees.

The adapter uses double intermediates and QR projection instead of normal-equation inversion. These changes preserve the objective's mathematical definition and are independently checked. It rejects missing/nonconverged solutions, mismatched dynamic sample counts and exact rank deficiencies; no attractive coefficient restriction is imposed.

The full-process bootstrap counts the original point fit separately, samples plants from the entire frozen source/risk universe, assigns new draw IDs, reconstructs actual calendar lags and refits every selected stage. Default random draws = 999. All return codes and unsuccessful draws remain visible. For `B_s` successful draws, the returned covariance is `sum[(b_j−mean_b)(b_j−mean_b)']/(B_s−1)`. Percentile intervals are conditional on those successful draws and must be accompanied by failures. Two-draw execution tests only validate mechanics and arithmetic.

## Attachment and metadata

The common four-method measure is `r_it = y_it−beta_L l_it−beta_K k_it`, labelled `measure_type=structural_log_VA_residual`. It contains transitory error. Raw residuals and any centered form have different normalization IDs. Upstream caller owns one-to-one source-row joins, original-column preservation, specification/sample/normalization/input hashes, and a documented centering denominator. A method-specific first-stage proxy-omega companion, if later exposed, needs its own name and definition; there is no fake Wooldridge `predict,omega` counterpart.
