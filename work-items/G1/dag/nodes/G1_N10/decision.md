# G1_N10 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Decision.** Report raw residual, pooled-fit-centered residual, and exp(centered) separately; distinguish all/in-fit/outside-fit records and source/domain/prediction coverage.

**Direct inputs.** G1_N01, G1_N03, G1_N04; see exact resolved source objects and hashes in [contract.json](contract.json).

**Grain.** Primary prediction summaries by sector × method × sample × production year × fit scope × residual measure; histograms add the lower bin boundary.

**Denominator.** N_source is the full N03 source-year sector count; N_domain is the frozen pre-lag method/common domain; N_predicted, N_in_fit, and N_outside_fit are prediction-side counts. Report each separately.

**Calendar.** All supported production prediction years; coefficients are pooled across valid dynamic transitions within sector and the pooled fit mean is held fixed across years.

**Units.** {"raw_and_centered": "natural-log residual points", "index": "exp(centered log residual), dimensionless; geometric mean one in the pooled dynamic fit group, not arithmetic mean one and not physical TFP", "counts": "observations", "share": "bin count / N_total"}

**Missingness and disclosure.** Only existing primary predictions are summarized. Preserve unsupported method/sample cells and empty histogram support. Tails are counted without trimming; a missing or zero count is not replaced with a fitted value. For N<5 suppress exact means, SDs, quantiles, fences, and related exact numeric summaries; retain N, named source/domain/prediction denominators, and fixed-bin counts/bounds. No obs_id or psid is released.

**Execution.** validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.
