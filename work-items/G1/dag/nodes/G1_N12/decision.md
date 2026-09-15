# G1_N12 — decision

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

**Decision.** Show the residual identity mean(y)-beta_L*mean(l)-beta_K*mean(k)=mean(raw); subtract the pooled dynamic fit normalizer for the centered residual. Do not imply individual-firm examples.

**Direct inputs.** G1_N10; see exact resolved source objects and hashes in [contract.json](contract.json).

**Grain.** Sector × method × own/common × supported prediction year × observed_group_means or illustrative_fixed_log_inputs.

**Denominator.** Observed rows are the supported primary prediction group N; exact observed means are emitted only for N≥5. The illustrative row is a constructed arithmetic example and has no firm-record denominator.

**Calendar.** Observed calculations use all supported prediction years and the pooled method-specific slopes and reference mean. Illustrative rows use the same estimated slopes and reference.

**Units.** {"mean_y_mean_l_mean_k": "means of natural-log nominal VA, workers, and beginning capital", "beta_L_beta_K": "dimensionless elasticities", "products_and_residuals": "natural-log points", "exp_centered_and_mean_index": "dimensionless", "illustration": "designed logs y=10, l=3, k=8; not an observed firm"}

**Missingness and disclosure.** Observed means are checked against mean(raw residual); use means of logs, not logs of means. exp(mean(centered)) and mean(exp(centered)) are reported as distinct quantities. Hypothetical rows are explicitly typed and have no N. Suppress observed exact arithmetic when N<5. The designed example is not suppressed as an observed group and remains explicitly labelled illustrative.

**Execution.** validated_aggregate_receipt_validator_revision_documented_primary_dispatch_replay_pass_no_refit; deep output validation is separately receipt-bound. No new coefficient fits; primary real admission remains false.
