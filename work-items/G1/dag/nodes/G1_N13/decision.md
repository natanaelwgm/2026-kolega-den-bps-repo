# G1_N13 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Decision.** Diagnose start/specification sensitivity and the distribution of previously executed bootstrap draws without pooling objectives or representing diagnostics as accepted-real inference.

**Direct inputs.** G1_N03, G1_N04, G1_N05; see exact resolved source objects and hashes in [contract.json](contract.json).

**Grain.** Existing fit rows compare each sector/method/sample variant with its primary fit; bootstrap rows summarize successful existing draw values by sector/method/sample/measure, with histogram bins for labor and capital.

**Denominator.** All declared sensitivity variants including skipped fits; bootstrap profiles retain requested and successful draw counts. Fit cells and bootstrap draws are not new fits. Objective functions remain method-specific and are not pooled across estimators.

**Calendar.** Reuses the owner-authorized all-years assumed-stock nominal fit results and the already executed exploratory synthetic-firm bootstrap draws; no re-estimation or new resampling.

**Units.** {"beta_L_beta_K": "dimensionless elasticities", "objective": "method-specific objective value; compare variants only under an unchanged objective", "delta": "variant minus primary within cell", "bootstrap_labor_capital": "draw values in fitted source log units", "counts": "requested/successful complete-process draws"}

**Missingness and disclosure.** Preserve unsupported variants and failed/missing draws. The objective_below_primary flag is descriptive within a fixed objective; a quadratic variant changes the specification. Keep all successful values and tails without trimming. Retain declared-cell N and requested/successful draw counts. Suppress exact bootstrap profiles when successful N<5; fixed-bin counts remain aggregate categories.

**Execution.** validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.
