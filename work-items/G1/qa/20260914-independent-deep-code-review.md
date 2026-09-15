# 2026-09-14 — Independent deep-stage source review

Root read the generalized N11 and N12 while the base bootstrap ran. This is a static review, not execution acceptance.

- N11 joins primary predictions on psid, sector, method, sample and exact destination calendar year. Year_from/year_to disambiguate annual intervals; pooled0/0 counts intervals rather than unique companies. The missing2016 calendar cannot be crossed.
- The complete source-pair grid retains empty prediction endpoints. Pooled endpoint denominators may count an observation at more than one interval endpoint; these are not unique-firm counts.
- Changes preserve each model's pooled dynamic normalizer across years. Raw and centered within-cell changes therefore agree; index ratios use exp of centered changes. Means/quantiles/correlations below5paired records remain suppressed.
- N12 uses saved slopes and normalizers, checks raw mean residual arithmetic, and distinguishes exp(mean centered residual) from mean(exp centered residual). Designed log inputs are explicitly illustrative and carry no observation count.
- Independent execution/schema/numeric validation and final prose/page review remain required after the fresh base run finishes.
