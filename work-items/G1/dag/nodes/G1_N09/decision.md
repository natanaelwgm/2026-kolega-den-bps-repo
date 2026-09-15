# G1_N09 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Decision.** Show sequential and branch-specific attrition with exact denominator labels; preserve N03 own/common domains and current primary-fit skips.

**Direct inputs.** G1_N03, G1_N04; see exact resolved source objects and hashes in [contract.json](contract.json).

**Grain.** Sector × method × own/common sample × source year × sequential gate; OP synthetic-risk intervals are separately labelled rows.

**Denominator.** Original source-year rows in N03 for each sector/method/sample cell. Sequential counts use the previous gate; prediction_branch uses pre-lag sample-domain rows; OP risk denominators are synthetic intervals between adjacent supplied calendar years, not production rows.

**Calendar.** Funnel covers every supplied source year; OP intervals require adjacent calendar years. Sector universe is ALL plus every sector reported in N03.

**Units.** {"counts": "source rows or explicitly labelled adjacent-year synthetic risk intervals", "losses": "previous-gate count minus retained count", "admission": "primary-fit status from existing nominal coefficient receipt"}

**Missingness and disclosure.** Every gate and unsupported primary fit remains in the funnel. A zero retained count is an empty support cell, not zero productivity. No stage imputes missing values or re-estimates coefficients. Counts and named denominators are retained. No record identifiers are exported.

**Execution.** validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.
