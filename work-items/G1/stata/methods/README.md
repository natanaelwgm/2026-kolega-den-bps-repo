# G1 guarded Stata method layer

This directory contains executable OP, LP, ACF and Wooldridge branches. **No G0.5 coefficients are produced unless the caller supplies accepted panel, production-input and (for OP) survival evidence.** The top-level G1 diagnostic run currently records failed prerequisites. The small `tests/` data generator is a separate algorithm test and is never loaded by the G0.5 runner.

From the repository root:

```stata
run "work-items/G1/stata/methods/load.do"
g1_fit, method(lp) id(panel_id) time(year) output(log_real_va) ///
    labor(log_workers) capital(log_real_capital) proxy(log_real_materials) ///
    eligible(lp_eligible) panelverified(1) inputsverified(1) ///
    poly(3) start(ols)
```

**`eligible()` is the pre-lag domain. Do not pass a flag that already requires a lag; the wrapper constructs that transition itself.**

The call above documents the API; the placeholder variable names are not asserted to exist in current G0.5. `panelverified()` and `inputsverified()` must be set by the caller only after validating hash-bound receipts, field definitions, technology pool and domain. They are not permission to manufacture input fields or supply observation IDs as plant IDs. Pass exactly one accepted two-digit technology/specification/sample at a time; preserve risk records for that technology when testing OP.

Use `method(op)` with `proxy(log_real_investment) risk(risk_t) exit(exit_t) selectionverified(1)` for OP. The risk universe must include all authenticated selection observations, including those outside the production domain. `risk_t` refers to exposure during the `t-1` to `t` interval; `exit_t` is observed closure during that interval. These definitions must match the source receipt. Use `method(acf)` or `method(wrdg)` for the other branches. No automatic no-selection OP branch exists.

`poly(3)` is primary and `poly(2)` is sensitivity. `start(ols)`, `start(low_l)` = (.3,.7), and `start(high_l)` = (.7,.3) are the frozen starts. OP/LP/ACF default to `optimizer(nm)`; `optimizer(dfp)` is the registered alternative. WRDG requires GN and explicitly uses system GMM. There are no configurable gross-output or unregistered extra-instrument options.

After a successful fit, `_b[labor]`, `_b[capital]` and `e(sample)` are the actual accepted dynamic prediction domain. `e(N_domain)` is the first-stage domain; `e(N_selection)` and `e(selection_exits)` are separate OP counts. `e(objective)`, `e(converged)`, `e(iterations)`, first-stage/instrument/moment-Jacobian rank and actual/effective Stata versions support review. The point estimator does not report a covariance matrix as inferential evidence.

```stata
generate double log_va_residual = log_real_va - _b[labor]*log_workers ///
    - _b[capital]*log_real_capital if e(sample)
```

This measure includes transitory error. It is not directly observed latent productivity or technical efficiency. The calling module must attach method, specification, sample, normalization, input and acceptance hashes; perform keyed one-to-one attachment; and compute any separate centering rule on its explicitly defined denominator. Never use `predict, omega` for the four-method attachment.

For the accepted empirical source, keep the **whole source/risk universe** in memory and run the external bootstrap:

```stata
g1_bootstrap, id(panel_id) saving("LOCAL_OUTPUT/tfp_lp_bootstrap") ///
    draws(999) seed(90132026) method(lp) time(year) output(log_real_va) ///
    labor(log_workers) capital(log_real_capital) proxy(log_real_materials) ///
    eligible(lp_eligible) panelverified(1) inputsverified(1)
```

`g1_bootstrap` first fits the original source, then records 999 random plant draws separately. It gives new identifiers to repeated plants, rebuilds calendar lags and repeats OP selection where applicable. Failed draws remain in the output. Covariance uses only successful draws with denominator `B_success-1`; percentile intervals and successful/requested counts are returned. A reduced test count does not satisfy the 999-draw research requirement.

Rebuild and validate the adapter:

```bash
python3 work-items/G1/stata/methods/build_adapter.py
stata-se -b do work-items/G1/stata/methods/tests/guards.do
stata-se -b do work-items/G1/stata/methods/tests/algorithm.do
```

The vendor files match the current G1 plan exactly. `adapter.patch` records every change, including authenticated external OP selection, corrected WRDG starting names, retained shared nuisance coefficients, single-point execution, QR projection, double precision, and diagnostics. Preserve `vendor/` byte-for-byte and update hashes whenever executable files change. Equations, timing and denominators: [METHOD-CONTRACT.md](METHOD-CONTRACT.md). Full audit and citations: [METHOD-AUDIT.md](../../METHOD-AUDIT.md).

The fixture/arithmetic tests additionally run:

```bash
stata-se -b do work-items/G1/stata/methods/tests/algorithm.do /ABSOLUTE/EXTERNAL/method-tests
stata-se -b do work-items/G1/stata/methods/tests/bootstrap.do /ABSOLUTE/EXTERNAL/method-tests
python3 work-items/G1/stata/methods/tests/validate_arithmetic.py /ABSOLUTE/EXTERNAL/method-tests
```

All test DTA and fictional microdata stay in that external directory (default: Stata temporary directory). The repository keeps aggregate CSV, logs and validation receipts. `arithmetic-validation.json` records independent reconstruction of all four objective values and all four two-draw covariance matrices. This test does not satisfy the accepted-input 999-draw requirement.

Comment-only review persistence: the builder optionally reads `adapter-commentary.json` with `base_sha256` and `insertions` containing 1-based `before_line` and standalone `* WFDOC:`/`// WFDOC:` text. Inside Mata, use `// WFDOC:`. Insert only between complete commands. The builder rejects non-comment content, wrong base hashes, block-comment delimiters, and anchors inside a Stata continuation. `tests/validate_overlay.py` verifies this boundary and stripped-code identity without changing the delivered adapter.

`tests/pre-comment-run-manifest.json` binds the tested scientific code and receipts before the dedicated Luna commentary pass. Final commentary receipts must independently show executable continuity and refreshed full-file hashes.
