# Observation, cluster and company identifiers

G0.5 v3 has **33,049 unique observations**, **10,395 fictional companies**, and **22,654 constructed links**. Development `psid` is populated on every row. Real company identity has not been recovered.

| Identifier | Development | Actual mode |
|---|---|---|
| `obs_id` | Same frozen HMAC observation token as v1. | Same token, bound to the exact local G0 parent and order. |
| `psid` | Stable positive numeric fictional company ID. | Missing until an independently accepted real identity input exists. |
| `psid_status` | `synthetic_development`. | `unverified_no_longitudinal_crosswalk` for the current actual parent. |
| `dev_cluster_id` | Annual cluster of similar records within province × sector. | Cleared. |
| `dev_prev_obs_id`, `dev_prev_year`, `dev_link_distance` | Constructed predecessor and distance. | Cleared. |
| `source_year` | Supplied calendar year, unchanged. | Same calendar year. |

The owner explicitly authorized compulsory province × sector boundaries with 5–10 consistent continuous variables. The implemented nine-variable rule, weights, clusters, unmatched options and seed are in the [generator specification](../harness/g05/PANEL-GENERATOR.md). All accepted firm-year keys are unique; all accepted links stay in their block. Four-digit malformed industry codes are isolated, not padded or guessed. District codes cannot be used because they are masked throughout the current sources.

`obs_id` is not a company ID. Neither is an annual cluster label. A trajectory's new `psid` is a 48-bit positive integer derived from the seed and its first frozen observation ID; collisions fail the build. It remains exactly representable in Stata double and Excel. Reordering/chunking the same input does not change the assignment. A changed source, feature set, weights or matching rule requires a new version and fresh receipts.

Use `load_data(require_panel=True)` in development. Its mode-aware check accepts explicitly fictional IDs for development and refuses the currently unverified actual panel. The old v1 rule that blocked fictional development pending real identity verification is superseded.

## Treatment and calendar

Existing treatment indicators, categories, source years and timing fields are unchanged at the observation level. They have not been forced to be constant or plausible along invented trajectories. If treatment is derived from continuous data, run the same declared rule separately in each mode. First observed participation is not first-ever entry; absence from a wave is not proof of closure. 2016 remains absent and annual lags do not jump over it.

## Actual finalisation

Actual mode transfers **only `obs_id`** from the frozen observation map. It never transfers fictional firm IDs, clusters or predecessor records. Accept a genuine company crosswalk separately, preserve unresolved links as missing, verify company/establishment grain and firm-year uniqueness, and version the actual input interface. This future crosswalk is not implemented by the fictional generator.

The same downstream analysis body can then be rerun on actual inputs. Coefficients, fitted models, samples and tables must be recomputed. Development estimates are never converted numerically or relabelled as actual findings. [Validation receipts and annual files](../data/g0-5-development/README.md).

The [external Excel-first workflow](../harness/g05/EXTERNAL-WORKFLOW.md) prepares or reuses identity outside G0, then ports it into G0.5. It can prepare before G0 exists and never runs or edits G0. Frozen rank inputs and keyed observation tokens make the final assignments reproducible from GitHub alone.
