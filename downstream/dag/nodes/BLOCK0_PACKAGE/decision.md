# BLOCK0_PACKAGE

E068 packages the accepted obscured final and optional pre-G1 input. The primary file is named `analysis_ready_data.dta` as requested, and README/METADATA mark it OBSCURED. Public metadata, dictionaries, masking reports and upstream documentation are included through an explicit allow-list. Original actual data and private seed/recovery material are excluded. No DTA bytes change.

Local acceptance: 21 files; 33,049 x 516 final DTA; final and G0.5 hashes identical to accepted inputs; README links and all manifest entries verified. Evidence: `20260917-run/block-0-data-preparation/PACKAGE.json`. The owner subsequently authorized publication to main and clarified that there is one final dataset. RELEASE.json selects only analysis_ready_data.dta for the private release. The pre-G1 intermediate remains local; no DTA bytes change.

Owner location correction: the final DTA must be directly in the block-0 repository folder. Add one exact .gitignore exception and track the unchanged DTA on main. The existing release remains an identical mirror; it is not a second dataset.

The block now also provides `00_run.do`, `settings.do` and four descriptive
preparation steps. These coordinate the original source; they do not change
the accepted package's numerical bytes. The source concordance and execution
overview connect the new entry points to existing nodes and edges. New runs
write one final DTA under their own output folder, with local intermediates.
