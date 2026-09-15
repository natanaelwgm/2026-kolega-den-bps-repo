# 2026-09-15 Asia/Jakarta — Private coauthor repository

- Agent/runtime: Codex desktop.
- Root/cwd: /Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo.
- Branch: main, initial snapshot based on original source commit f021c1912.
- User intent: create a separate private repository under the authenticated GitHub account, with G0/G0.5/G1, all their inputs/outputs and READMEs for coauthors.
- Decision: source/review text on main; complete datasets and retained outputs in the same private repository's versioned release. Current explicit input-upload authorization applies to this private scoped copy.
- Source demo: corrected noisy and repeat-safe master, verified GUI run 20260915-200658-g05_full-0e9c16. 33,049 rows, 41 primary fits, no bootstrap. Full live chart windows remain future work.
- Resource constraint: internal disk initially 1 GiB free. One streaming archive/upload worker; only its own remotely verified temporary archives are removed. Original inputs, runs and caches are preserved.
- Exclusions: unrelated tasks/chats, local credentials, private reversal keys, repeated failed demo runs and temporary runtime/scratch caches. Full G0 accepted data outputs and declared frozen input references are included.
- Next actions: finish uploads, verify release checksums and setup portability, record final remote status. Coauthor identities have not been supplied, so no invitations have been issued.

## Owner clarifications and verification

- Owner confirmed authenticated account, private visibility, and owner-only access for now; GitHub collaborator listing returned only natanaelwgm. No invitations sent.
- Owner asked for full DAG coverage and the do-file cascade. Added DAG-INDEX.md, full G0 JSON and G1 diagrams directly on main, plus RUN-CASCADE.md. G0.5 has 13 node contracts and 16 edges. There is no unified interactive canvas.
- Archive 02 was freshly downloaded from private GitHub and restored: 371 files, all dashboard links resolve, 23 SVGs, G0 workbook 23 sheets, G1 workbook 6 sheets, receipt confirms 33,049 rows and 41 primary fits. This is restoration validation, not fresh estimation.
- Focused packaging tests pass: extraction safety, preservation of edits, idempotent setup, both relocated cache keys and changed-input rejection. All six frozen G1 source-gate files exist and match their hashes.
