# G1_N11 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Decision.** Describe within-fictional-panel changes under pooled coefficients and fixed pooled normalization; do not describe them as real firm growth or causal effects.

**Direct inputs.** G1_N03, G1_N10; see exact resolved source objects and hashes in [contract.json](contract.json).

**Grain.** Sector × method × sample × measure × year_from × year_to for exact same-psid, same-sector adjacent-calendar pairs;0/0 marks pooled intervals; histogram rows additionally key the 0.25-log-point change bin.

**Denominator.** N_from and N_to count supported predictions in the paired endpoint years; N_pairs requires both values for the exact same fictional psid, sector, method, and sample. Preserve N_to in-fit and outside-fit counts.

**Calendar.** Every supported exact adjacent-year prediction pair; no bridge across2016. Same pooled coefficients and pooled dynamic fit normalizer across endpoints.

**Units.** {"raw_and_centered_change": "later-year minus prior-year natural-log residual points", "index_change": "change in exp(centered), dimensionless", "mean_index_ratio": "mean index_to/index_from", "correlations": "dimensionless Pearson/Spearman correlations on exact pairs", "histogram": "0.25-log-point centered-change bins; count and pair share"}

**Missingness and disclosure.** Pairs missing either year are excluded only from paired summaries; annual supported counts and pair exclusions remain explicit. All exact-pair changes are retained; no trimming and no causal or real-growth interpretation. Retain N values, direction counts, and fixed-bin counts. Suppress exact means, quantiles, SDs, correlations, and mean index ratios where N_pairs<5. No identifiers are exported.

**Execution.** validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.
