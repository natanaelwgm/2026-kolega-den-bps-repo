# 2026-09-17 07:08 WIB — Strong masking with retained owner seed

- Agent/runtime: Codex desktop; root/cwd `/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo`.
- Branch/starting commit: `feat/raw-overall-master`, `64c91a9`.
- User intent: improve resistance to recovering actual values; randomized seeded
  ±20–30% changes; count variables integer, monetary levels continuous; keep
  research categories. Explicit follow-up: retain the seed so the owner can know
  and reproduce changes and reverse them.
- Interpretation: best-effort bounded masking, not irreversible synthetic data.
  Same secret seed reproduces numerical changes; an authenticated recovery archive
  also preserves exact original bytes because rounding loses information.
- Decisions: independent variable/cell factors; rebuild 97 derived equations;
  preserve category/flag/reference fields and source missingness; regenerate dummy
  observation and company keys; keep actual and masked-only delivery in separate
  directories. Never publish seed, actual-to-masked map, factors or cell deltas.
- Found another semantic issue in the earlier mild masking policy:
  `energy_cost_reported_partial` and `energy_cost_reported_complete` are 0/1 flags,
  not expenditure. v2 protects them explicitly. Old mild release is unsuitable
  for the new objective and must not be described as anonymised.
- Source equation preflight: all 97 relations agree on observed actual support.
  Five accounting residuals are floating-point roundoff (maximum absolute
  9.5367431640625e-7), not exactly zero. Initial preflight correctly stopped on the
  overly strict zero assertion; new version explicitly masks these tiny residuals
  and retains them in the output accounting equation. The same seed was retained.
- Focused synthetic boundary checks passed: deterministic and separated variable
  channels; counts 0/1/2/3/100/101; component-count bounds; shares 0/100/9.99/10/99;
  FDI threshold; 1,000 factor-range checks. Three tiny-count exceptions are explicit.
- Resource baseline: 10 cores, load around 10–11, zero swap; internal disk ~854 MiB
  free, SSD ~44 GiB free. Single sequential numerical worker chain, BLAS threads 1;
  Stata temp and generated data on SSD. No unrelated process or GUI was changed.
- Files: `downstream/obscure/strong/{policy,seeded,build,recover}.py`, README.
- Execution: first preflight-only run `20260917-070850-bf7447` failed as described;
  new build `20260917-071007-15c631` running at this checkpoint. No pass claimed yet.
- Next: finish native run/replay, independent categorical/equation audit, exact
  encrypted recovery and negative authentication tests; update delivery aliases
  only on successful validation; record final result and limitations below.

## 2026-09-17 07:22 WIB — Accepted strong pair and recovery proof

- Accepted run: `/Volumes/Extreme SSD/2026-kolega-strong-obscured/20260917-071711-dde497`. Final masked SHA256
  `c51a4c8b05035d6caba93253496a1f155f0654deceedd9faf3b7f2e87d66fc7e`; actual SHA256
  `1ed0dc0049fdefeea2e05e3c8e23c3850d4fb7e383ee316563118965d7931cd8`.
- 33,049 rows × 515 fields; 350 protected fields exactly unchanged; 51 independent
  continuous fields, 97 recomputed definitions, 3 count fields, 2 percentage fields.
  134 numerical fields actually changed; 10,472 fictional company IDs.
- True out-of-band integer exceptions: workers 95, production workers 210,
  R&D workers 714. Production has 213 fallback events: three still land in-band.
  Report corrected to distinguish events from actual exceptions. Some small
  integers have no admissible 20–30% alternative. All count domains and previously
  valid component ≤ total relationships pass; worker >100 and FDI ≥10 categories pass.
- One source export share is invalid (>100). It is perturbed while retaining its
  invalid domain; valid shares remain in [0,100]. No silent source repair claimed.
- Native Stata numerical replay `cf _all` exact; independently repeated fictional
  panel generator exact; all categories/missing masks verified against actual;
  all 97 formula checks pass. Three focused contract tests pass.
- Four known-original/common-factor attack tests: 105,444 nonzero target cases;
  zero exact reconstructions at relative tolerance 1e-12, but 10,023 approximations
  are within 1%. This is deliberately NOT a general reconstruction-safety proof.
  There are 7,240 singleton year×province×industry groups; exact categories remain
  identifying information and must not be called anonymous.
- Private seed and backup retained at the documented private Downloads paths,
  both mode 0600. Contents never printed/committed/published. Authenticated AES-GCM
  recovery archive retains original DTA bytes, per-cell numerical deltas and key
  mapping. Wrong seed and modified ciphertext rejected. Separate recover.py CLI
  restored original bytes with the exact original hash; restored proof copy kept.
- Runtime repairs: quoted Stata tempfile paths on SSD; explicit invalid-percentage
  domain; corrected integer audit count. Final acceptance checks all completed,
  then cleanup encountered an exFAT sidecar already removed by the filesystem.
  Cleanup-only fix accepts an already absent sidecar; owned plaintext temporary
  DTA files across all five attempts removed afterward. No numerical algorithm
  changed after the accepted run. DataFrame packaging was also consolidated to
  suppress fragmentation warnings; original run and final source hashes retained.
- Seed, actual, recovery archive and outputs were never removed. Source snapshots
  retained in OWNER-ONLY/code, alongside portable recovery instructions. Latest
  receipt includes CLI recovery, private seed mode and public-folder seed scan.
- Downloads links: `00-OBSCURED-20-30` → masked-only folder;
  `00-ACTUAL-AND-OBSCURED` → new local owner wrapper, preserving old data-file
  link paths; `00-OBSCURED-OWNER-RECOVERY.md` gives private recovery locations.
  Finder was opened and showed obscured_dummy.dta (72.9 MB), README and reports.
- Old mild accepted receipt now explicitly invalidated for the energy-cost
  completeness flag classification error and superseded by v2. Historical files
  remain retained. Do not distribute old mild and new versions together as a
  privacy measure; repeated versions can enable linkage.
- Resources: single sequential heavy chain, zero swap throughout; final SSD
  headroom ~44 GiB, internal ~847 MiB. All owned batch processes exited.
- Scope complete: requested strong masked/actual pair, retained seed and exact
  recovery. G1 re-estimation and raw-overall-master validation/merge remain separate
  unfinished work. No original fast master or owner GUI Stata editor was changed.
