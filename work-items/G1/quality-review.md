# G1 quality review

**The authorized all-years calculation and appendix are complete under the stated stock and investment assumptions.** We distinguish this nominal development analysis from the unaccepted real-input specification in issue 9. Run `v3-assumed-stock-all-years-02` produced 41 primary models, 123 successful sensitivity fits and 4,059 successful bootstrap draws out of 4,059 requested.

## Results and calendar coverage

| Method | Sample | Primary sectors | Dynamic rows | Predicted rows | Admitted intervals |
| --- | --- | --- | --- | --- | --- |
| Olley–Pakes | own | 1 | 128 | 683 | 1 |
| Olley–Pakes | common | 1 | 128 | 676 | 1 |
| Levinsohn–Petrin | own | 12 | 5,041 | 10,315 | 12 |
| Levinsohn–Petrin | common | 1 | 128 | 676 | 1 |
| Ackerberg–Caves–Frazer | own | 12 | 5,041 | 10,315 | 12 |
| Ackerberg–Caves–Frazer | common | 1 | 128 | 676 | 1 |
| Wooldridge | own | 12 | 5,041 | 10,315 | 12 |
| Wooldridge | common | 1 | 128 | 676 | 1 |

Each row describes one method and one sample. Counts overlap across methods and samples and must not be added to count distinct companies. The four-method shared dynamic intersection contains 128 observations using own-sample estimates and 128 using common-sample estimates.

| Method | Sample | Dynamic estimation years | Prediction years |
| --- | --- | --- | --- |
| Olley–Pakes | own | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Olley–Pakes | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Levinsohn–Petrin | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Levinsohn–Petrin | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Ackerberg–Caves–Frazer | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Ackerberg–Caves–Frazer | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |
| Wooldridge | own | 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022 |
| Wooldridge | common | 2012, 2013, 2014, 2019, 2020, 2021, 2022 | 2011, 2012, 2013, 2014, 2018, 2019, 2020, 2021, 2022 |

We assume reported capital stocks are year-end stocks in every supplied source year. Beginning capital uses the exact previous calendar year's value. We preserve the absent 2016 file, original source amounts and documentary flags. Positive reported additions provide a separate assumed investment candidate for Olley–Pakes; the stock assumption does not create missing additions. Potential production years are 2011, 2012, 2013, 2014, 2015, 2018, 2019, 2020, 2021, 2022; potential dynamic endpoints are 2012, 2013, 2014, 2015, 2019, 2020, 2021, 2022. The calendar table reports actual successful-fit coverage.

We pool supported transitions within sector and retain constant slopes and control laws across years, with no new year effects. Each primary fit predicts every valid observation in its declared domain and separately flags membership in dynamic estimation. These predictions are not annual coefficient estimates. We subtract each fit's mean native residual across its pooled dynamic sample and keep that constant in every prediction year. Exponentiation gives geometric mean one across the pooled fit sample; annual distributions need not have mean zero or geometric mean one. Nominal prices, unit conventions and changing composition remain part of the interpretation.

## Unsupported and failed obligations

The ledger retains all 768 declared sector/method/sample/variant obligations: 164 attempts, 164 successful fits, 0 failed fits and 604 support skips. A successful sensitivity does not replace a failed primary model.

| Method | Sample | Primary success | Support skip | Fit failure | Withheld intervals |
| --- | --- | --- | --- | --- | --- |
| Olley–Pakes | own | 1 | 23 | 0 | 0 |
| Olley–Pakes | common | 1 | 23 | 0 | 0 |
| Levinsohn–Petrin | own | 12 | 12 | 0 | 0 |
| Levinsohn–Petrin | common | 1 | 23 | 0 | 0 |
| Ackerberg–Caves–Frazer | own | 12 | 12 | 0 | 0 |
| Ackerberg–Caves–Frazer | common | 1 | 23 | 0 | 0 |
| Wooldridge | own | 12 | 12 | 0 | 0 |
| Wooldridge | common | 1 | 23 | 0 | 0 |

## Conditional uncertainty and numerical sensitivity

We retain 0 failed draws within completed bootstrap calls and report 0 failed bootstrap calls separately. Of 41 primary models, 41 admit percentile intervals and 0 withhold them under the fixed minimum of 95 successful draws out of 99.

The resampling unit is the complete supplied history of a fictional company within its technology cell, including selection-risk intervals. Each draw reconstructs exact-calendar lags and reruns the method. This uncertainty conditions on frozen fictional links and the nominal measurement convention, excludes uncertainty in constructing the links, and does not meet the separate 999-draw real-primary requirement.

The table reports the largest absolute coefficient difference between a fixed primary fit and successful low-labor or high-labor starting-value alternatives, matching method, sample and sector. These are numerical sensitivity measures, not hypothesis tests. The fixed primary remains in place regardless of which start has the lowest objective. The quadratic specification is a separate sensitivity and is excluded from this starting-value comparison.

| Method | Sample | Alternative fits compared | Maximum labor difference | Maximum capital difference |
| --- | --- | --- | --- | --- |
| Olley–Pakes | own | 2 | 0.0000 | 0.0001 |
| Olley–Pakes | common | 2 | 0.0000 | 0.0000 |
| Levinsohn–Petrin | own | 24 | 0.0000 | 0.0002 |
| Levinsohn–Petrin | common | 2 | 0.0000 | 0.0003 |
| Ackerberg–Caves–Frazer | own | 24 | 0.9262 | 0.0255 |
| Ackerberg–Caves–Frazer | common | 2 | 0.7471 | 0.0980 |
| Wooldridge | own | 24 | 0.0000 | 0.0000 |
| Wooldridge | common | 2 | 0.0000 | 0.0000 |

The Wooldridge implementation shares its proxy-function coefficients between the current and lagged equations. The appendix explains the maintained random-walk-plus-drift restriction. Its quadratic sensitivity changes those two proxy bases; the other declared branches retain their separate cubic productivity transitions. Convergence does not establish a unique global optimum, precise inference or correct economic timing.

## Numerical and publication evidence

| Check | Current evidence | Scope |
|---|---|---|
| Full master preservation | 145,283,404 exact cells across 33,049 rows and 4,396 original columns | Preserves the declared input and order; does not authenticate actual company identity. |
| Independent nominal arithmetic | 15,676 checks; PASS | Timing, domains, masks, residuals, aggregates and bootstrap arithmetic; Stata performs estimation. |
| Expanded diagnostics | 2,588,035 aggregate cells checked; PASS | Same new base run and fixed coefficients; source availability, sample losses, annual distributions, tails, pairs and worked calculations. |
| Analytical lineage | 37 nodes and 32 edges | Original exhibit obligations and explicit dependencies retained. |
| Current source comments | New all-years Luna/max review is PASS | Current source hashes checked; 4 earlier receipts retain historical scope. |
| Compiled publication | 161 pages, 77 native tables, 49 vector figures and 29 equations | Counts come from the reviewed PDF; page count is descriptive, not an acceptance threshold. |
| Publication bindings | 20,680 source operands and 3,314 chart annotations | Exact operands, formats, source hashes and compiled-file identity reconcile. |

The appendix follows [the owner's writing standard](../../WRITING-PREFERENCES-SEE-HERE.md) and the actual G0 reference: connected active academic prose, explained terms and symbols, construction before each exhibit and interpretation afterward, descriptive headings, actual Times New Roman, native mathematics, numeric chart labels, visible legends, distinct Notes and Source, and host-derived references. The binding audit and final page review identify the same PDF. Numerical checks do not substitute for reading the science and inspecting the pages.

## Remaining real-input requirements

- Accepted real measurement, units, concept-specific deflation and technology mapping.
- Scientifically accepted investment and selection definitions for real-input Olley–Pakes estimation.
- Four-method common-sample estimates under the accepted real-input specification.
- Same-version G2 admission where the original request requires it.
- Required 999-draw real-primary inference; the current nominal analysis is exploratory.
- Explicit verified local actual input and real company linkage, followed by the required rerun.

These requirements do not undo the completed owner-authorized development calculation. Actual finalisation has not run. Approximate-real nonland preparation and price references remain separately scoped preparation; no approximate-real estimate is claimed. Record-level intermediates and the full derivative remain external. Private GitHub publication and Telegram delivery have separate completion evidence.

[Acceptance](acceptance.json), [quality review](quality-review.md), [run manifest](release/run-manifest.json), [nominal validation](release/qa/nominal-validation.json), [master preservation](release/qa/full-master-validation.json), [diagnostic validation](deep-release/qa/deep-validation.json), [publication bindings](qa/publication-bindings-validation.json), and [final page review](qa/publication-final-review.json).
