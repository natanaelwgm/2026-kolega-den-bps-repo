# Explicit measurement and selection modes

Updated 13 September 2026, Asia/Jakarta. This addendum describes the mode guards added to `g1_fit.ado`; it does not report a G0.5 estimate. The OP, LP, ACF and shared-theta Wooldridge equations, optimizer choices, starting values, rank checks and calendar-transition rules are unchanged.

The default is `measurementmode(real) selectionmode(authenticated)`. Existing accepted real-input callers retain their numerical behavior. `panelverified(1)` means the caller has accepted the applicable company/calendar identity contract. It does not require actual-company linkage when the official synthetic development panel is authorized. `inputsverified(1)` means acceptance of the **declared measurement contract**: accepted real inputs in real mode, or the expressly declared nominal candidate inputs in nominal development mode. Neither flag itself authenticates a receipt or measures input validity; the admission runner must bind these declarations to the exact input manifest and specification.

## Nominal development API

```stata
g1_fit, method(lp) id(psid) time(year) ///
    output(log_nominal_va) labor(log_workers) ///
    capital(log_nominal_begin_stock) proxy(log_nominal_materials) ///
    eligible(source_domain) panelverified(1) inputsverified(1) ///
    measurementmode(nominal_development) syntheticpanel(1) ///
    panelstatus(psid_status)
```

Nominal development requires both `syntheticpanel(1)` and a string `panelstatus()` variable equal to `synthetic_development` on **every retained source and risk row**. It rejects a dataset labelled `DEASY G0 ACTUAL` or carrying `_dta[deasy_data_mode]="actual"`. The caller must retain this status on constructed risk rows and verify the official generator/manifest upstream. The wrapper checks the status before preserving and renaming estimator variables; that variable need not survive inside the estimator's temporary dataset.

The intended separate v3 nominal candidate specification uses reported value added, workers, materials, and beginning capital equal to the preceding calendar year's reported 31 December stock. Documented stock years 2010–2012 support a 2011–2012 production domain and 2012 dynamic moments. The caller constructs the values and logs, freezes the specification and admits the rows. The wrapper creates no deflators, inputs or panel identifiers. This mode supplies neither real-input acceptance nor an actual-data result, and does not remove the primary real specification's input blockers.

`eligible()` denotes the complete, pre-lag production source domain. The wrapper itself requires both current and preceding calendar-year eligibility. Passing a domain already restricted to dynamic observations would apply that restriction twice. Risk rows remain in the full input universe even when production-ineligible.

## OP selection semantics

The authenticated default still requires the complete accepted risk/closure universe through `risk() exit() selectionverified(1)`. Both outcome values must be observed, the logit must converge without dropped observations or deficient rank, and every dynamic production observation must have a fitted selection probability and outcome zero. There is no uncorrected fallback.

For an explicitly synthetic development exercise, OP may additionally use:

```stata
measurementmode(nominal_development) syntheticpanel(1) ///
panelstatus(psid_status) selectionmode(synthetic_disappearance) ///
risk(generator_risk) exit(generator_disappeared) selectionverified(1)
```

This option is rejected in real measurement mode, including when the caller supplies the synthetic-panel flag. The caller derives risk and assignment disappearance from the documented generator across **consecutive observed calendar waves**. A missing wave does not create a transition. Outcome one means disappearance of a fictional generator assignment; it is not observed company closure, and disappearance of an actual company is not sufficient evidence of closure. The same selection-correction equations are evaluated under this explicitly different development interpretation.

The legacy scalar `e(selection_exits)` counts outcome-one observations in the fitted risk sample. Under `synthetic_disappearance` it therefore counts fictional assignment disappearances, not authenticated exits. For LP, ACF and Wooldridge, selection metadata describes the declared mode but `e(selection_mode_applied)=0`.

## Returned interpretation

| Result | Real default | Nominal development |
|---|---|---|
| `e(measurement_mode)` | `real` | `nominal_development` |
| `e(real_input_verified)` | 1 after the accepted real-input gate | 0 |
| `e(input_acceptance_scope)` | `accepted_real_input_contract` | `accepted_declared_nominal_candidate_contract` |
| `e(measure_type)` | `structural_log_VA_residual` | `structural_log_nominal_VA_residual` |
| `e(development_only)` | 1 when a synthetic flag or recognized development label/characteristic is present; otherwise 0 | 1 |
| `e(synthetic_panel_authorized)` | supplied flag, default 0 | 1 |
| `e(panel_identity_contract)` | `accepted_external_identity_contract`, or `official_synthetic_development` with the explicit flag | `official_synthetic_development` |

`e(selection_mode)` and `e(selection_timing)` retain the declared interpretation. Real measurement can still be a development-data exercise; `e(real_input_verified)=1` is not a claim of actual data. Nominal residuals must not be labelled verified real productivity. Source receipts and output metadata must preserve those distinctions outside the estimator.

## Bounded independent verification

`tests/measurement_mode.do` ran successfully in native Stata SE 17 on 13 September 2026 (log closed 19:57:02 local time). It reused the separately labelled `INDEPENDENT_ALGORITHM_TEST_NOT_G05` fixture: 180 fictional firms and 2,160 source rows. Thirteen negative tests reject missing synthetic authorization, missing/wrong status, synthetic disappearance in real mode, and known actual-data labels/characteristics. Eight point fits compare default real and explicit nominal calls for all four methods; coefficients and objectives are exactly equal after double-precision serialization, and estimation samples are identical (1,273 dynamic observations each). The nominal metadata assertions pass. No bootstrap was run and these are not G0.5 v3 or actual-data estimates.

Run from the repository root after the existing algorithm fixture has been generated outside the repository:

```sh
stata-se -b do work-items/G1/stata/methods/tests/measurement_mode.do /absolute/external/method-tests
```

The external directory must contain `fixture.dta`; the test writes `measurement-mode-results.dta` there. The tracked aggregate receipts are `tests/measurement_mode.log` and `tests/measurement-mode-results.csv`. Existing historical pre-comment receipts remain historical and are not rewritten to imply that they tested the new mode API.
