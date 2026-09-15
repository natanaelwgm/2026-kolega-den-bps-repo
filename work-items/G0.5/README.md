# G0.5 — disturbed development data and fictional firm panels

G0.5 is the owner's operational work item between actual G0 preparation and downstream development. It is not an additional row invented in Deasy's original 44-row Word list.

**v3 repairs the incomplete v1 identifier treatment.** The active package contains 33,049 observations × 4,396 columns in 12 waves, with 10,395 fictional company IDs and 22,654 constructed links. Province × sector is compulsory; nine consistently observed continuous fields drive annual clusters and one-to-one cross-wave matching. All current development `psid` values are populated. Actual mode does not inherit fictional links.

Read the [dataset, annual Excel files and proof](../../data/g0-5-development/README.md), [generator specification](../../harness/g05/PANEL-GENERATOR.md), [owner correction](OWNER-REQUEST.md), [ID contract](../../docs/DATA-IDENTIFIERS.md) and [mode interface](../../docs/DATA-MODES.md).

The original 0.1–0.5% coherent measurement perturbations remain unchanged. Existing observation IDs remain unchanged. The original Excel sources remain unchanged. The complete G0.5 v1 was preserved locally before the unpublished v2 prototype; that prototype was also preserved before the Excel-first v3; historical `pre-panel-*` receipts retain their v1 scope.

The analytical DAG separates source-feature choice, scaling/weighting, annual clusters, one-to-one panel assignment and package validation. Source rows, original PIC/numbering and completion cells remain unchanged. Routing applies to all 43 downstream source requests. Fourteen published implementation issues cover G1–G3 and R1–R11.

This correction validates the development identity contract, full-input replay, annual Excel exports and Stata calendar lags. It does not establish actual company identity, resolve every module's price/capital/treatment prerequisites, run TFP, finish the 44 research rows or itself resume G1. The owner later explicitly resumed the separate G1 task.

The [external Excel-first workflow](../../harness/g05/EXTERNAL-WORKFLOW.md) prepares or reuses identity outside G0, then ports it into G0.5. It can prepare before G0 exists and never runs or edits G0. Frozen rank inputs and keyed observation tokens make the final assignments reproducible from GitHub alone.

For owner-operated runs, use [00_RUN_ME.do and the per-year Excel/DTA mappings](../../run-g0-g05/README.md). This accepts the frozen v3 package or separate custom inputs without overwriting G0 or publishing new company records.
