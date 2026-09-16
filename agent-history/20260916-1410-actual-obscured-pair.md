# 2026-09-16 14:10 WIB — Actual plus obscured numeric/dummy identity pair

> CORRECTION: The initial pass recorded below was invalidated by an independent
> categorical audit before final delivery. Four `per_worker_state` fields had
> been transformed by an overbroad numeric-name rule. That run is superseded.
> The accepted replacement is `20260916-140834-00486b`; see the appended correction.

- Agent/runtime: Codex desktop, `/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo`, branch feat/raw-overall-master; prior commit 6e55621.
- User: wants one actual dataset and one obscured + dummy version; numerical magnitudes altered, categorical variables kept.
- Decision: build directly from the verified actual 515-column projection. Keep research categories, codes, flags, geography, years, observation key and missingness exact. Dummy identity and mode metadata are explicit exceptions. Do not attach old G1 estimates to newly perturbed data.
- Method: private HMAC row factors ±0.1–0.5%; native Stata changes coherent money/physical levels, integer worker counts, bounded shares. Logs/per-worker measures follow changed operands. Source worker >100 and ownership 10% category domains retained. Ratios whose common scaling cancels remain equal. Province×sector nine-feature fictional identity generation uses the existing audited generator, three extra matching fields read only from the SAME hash-pinned G0 parent.
- Outputs: `/Volumes/Extreme SSD/2026-kolega-obscured-pair/20260916-140509-435b5e/data/actual.dta` and `obscured_dummy.dta`; each 33,049×515. Downloads alias `00-ACTUAL-AND-OBSCURED` targets that run. Both have open-data do-files. Actual byte-identical to previous verified actual projection, firm IDs remain missing. Obscured has 10,378 fictional firms.
- Checks: 350 protected fields exact; 135 numerical fields / 2,300,488 cells changed. All missing masks (except declared dummy metadata), obs order, field set and calendar preserved. Dummy firm-year unique with no cross-stratum links. Native lag check keeps 2017 L1 missing without 2016. Source-applicable log/ratio equations: zero new failures. Independent follow-up verified all 124 scale-rule fields within bounds and with signs/zeros preserved; production/rd worker counts had zero new parent-count violations.
- G1: 54 G1 columns remain missing from the actual parent in both new files. Old G1 results preserved in previous package. G1 must be re-estimated if wanted for new obscured values; not performed or claimed here.
- Runtime repairs: first attempt failed on quoted SSD command-line path; fixed by invoking the script basename from its run cwd. Second failed on unsupported set maxvar 2000; fixed to 5000. Third full build and all checks passed. Failed run evidence retained. Ephemeral factor DTA from failed runs removed from owned private scratch; private keys remain outside Git/package. Never expose key contents.
- Scope: development perturbation, not anonymity guarantee or recovery of true identities. Source quality/classification/deflator gates inherited. No original dataset, previous result, GUI editor or master was overwritten.

## Correction and accepted delivery — 16 September 2026, Asia/Jakarta

- Pre-correction source commit: `2236016`. The third-run pass was not sufficient:
  its policy-derived comparison shared the same incorrect numeric classification.
- Root cause: `_per_worker` matched four diagnostic state fields. Category rules
  now override numeric rules. Added an independent semantic-category comparison
  to prevent this failure from being hidden by the policy table.
- Accepted run: `/Volumes/Extreme SSD/2026-kolega-obscured-pair/20260916-140834-00486b`.
  The Downloads alias `00-ACTUAL-AND-OBSCURED` now points there. Each file contains
  33,049 rows and 515 fields. Actual SHA256 remains
  `1ed0dc0049fdefeea2e05e3c8e23c3850d4fb7e383ee316563118965d7931cd8`.
  Obscured SHA256 is
  `30432396e9da2f53cc0e8c77824770818a4b67049d74126f8ed5265b2140ec44`.
- Corrected checks: 354 protected fields exact, including 256 independently
  identified semantic category fields; 131 numerical fields and 2,299,327 cells
  changed. There are 10,392 fictional firms. All original applicable log/ratio
  equations have zero new failures; native Stata stages and calendar-lag check pass.
- Independent follow-up: all 16 `_state` fields exact (including the four formerly
  affected fields); all 124 scale-policy fields obey the 0.1–0.5% absolute relative
  change and preserve signs/zeros. Previously valid component-worker counts remain
  bounded by total workers. Actual firm IDs remain missing; dummy IDs are complete.
- The previous receipt and README are explicitly marked superseded with the
  reason and replacement path. Old evidence is retained. The current receipt also
  records source-code hashes and independent follow-up results. Private factors
  were removed after the successful build; private keys remain outside delivery.
- G1 was not re-estimated. Its result fields remain missing in the new pair,
  and the historical development/G1 dataset remains available unchanged.
- Remaining broader work: full raw overall cascade validation and GitHub merge
  are separate, unfinished work; this delivery does not claim either completed.
