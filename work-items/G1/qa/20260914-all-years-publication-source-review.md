# All-years G1 publication source review

Reviewed 14 September 2026, Asia/Jakarta; source checkpoint updated 03:37 WIB. Agent: Codex, `/root/context_preferences`. Root: `/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913`. Scope: the five publication sources assigned by the takeover root, then `build_report.py` and the explicitly assigned G1 request/current-state mirrors; no analytical source or data changed by this agent.

The governing instruction is the all-years assumed-capital request recorded in `agent-history/20260914-0136-assumed-capital-all-years.md`, including its explicit resume. The detailed owner writing standard, latest G0 appendix prose, G1 issue packet, prior reader reviews and portability interface were read before editing.

## Source changes

- Removed the former 2012-only/520-record/five-sector conclusions and absent-OP assumptions from both templates and all three source generators. New result paragraphs select current aggregate rows and record their source operands.
- Defined the reported-stock assumption, separate reported-additions investment assumption, pooled constant coefficients/control relationships without new year effects, exact calendar consequences and one pooled dynamic reference mean used across all years.
- Kept the research question and operation before the term production residual, with source records and fictional links explained before mathematical estimation. Method names, data/timing, equations, uncertainty, coefficients, distributions, annual changes and sensitivity remain ordered by reader dependencies. Headings remain descriptive academic labels.
- Distinguished own-input and four-method-common-input specifications throughout. Combined tables contain both; combined and method figures identify own-sample estimates explicitly. Model counts and successful resample totals are separately bound for both sample definitions.
- Added conventional own/common coefficient tables with bootstrap SEs and admitted intervals, actual fitted endpoint coverage, full primary attempt ledgers and numerical-rank diagnostics. Source sample losses remain separate from numerical failure and zero estimates.
- Generalized annual scope/distribution tables to every supplied year with explicit pooled rows, retaining empty and suppressed groups. Paired tables retain every source interval plus pooled comparisons, explain repeated record-pair contributions, preserve missing 2016, and distinguish matched counts from endpoint prediction counts.
- Worked examples deterministically use the first and last releasable annual observed groups in the first eligible sector. The examples use the new `normalizer_value`, do not expose individual records and distinguish geometric from arithmetic means.
- Discover and include all continuation figure assets for annual quartiles, adjacent-year changes and sensitivity, retaining semantic label namespaces and root-controlled numbering.
- Added a manuscript-generation guard against combining the current specification with the old coefficient ID or diagnostic schema. Missing bootstrap intervals are reported as unavailable rather than assumed successful.
- Bound every included figure family to its current manifest, source aggregate hashes and PDF asset hashes. Added the separate common-sample four-method distribution exhibit, with shared-record counts and method-specific spread read from the current aggregate rows.
- Replaced outdated start-sensitivity conclusions with current paired-variant differences. The conclusion separates 37 own models from four common models, then reports observed ordering agreement, uncertainty and start sensitivity. Negative capital slopes identify their actual sectors and explain the resulting residual arithmetic; each method's bootstrap paragraph contrasts the selected largest labor SD with its median, P5/P95 and full range.
- Updated `build_report.py`, `docs/CURRENT-STATE.md`, the G1 request README/evidence/task, and only the corresponding registry JSON/CSV/index row. Historical assessments remain dated, original Word source fields remain unchanged, and publication/delivery are still explicitly in progress.

## Checks and limits

Python syntax compilation passed for all three publication generator modules and `build_report.py`. A static string scan found no unintended control characters or doubled LaTeX command prefixes in generated text constants. Numeric lineage keys now include paired `year_from` and `year_to`. No new numerical-operation type was added to the existing independent binding-validator contract. The task and registry row were checked for exact equality, preserving all 44 request rows and the original Word fields.

The source-level review does not establish that generated tables, figures or the compiled PDF pass. The released base run `v3-assumed-stock-all-years-02` now supplies 41 primary and 123 sensitivity fits, 4,059 successful bootstrap draws, and passing numerical/preservation receipts. New deep diagnostics and figure generation are still being completed separately. No manuscript was built against the old diagnostic aggregates. Source-bound generation, numerical binding, complete page inspection, host insertion, synchronized publication and delivery remain required after the validated new diagnostic release.


## Concrete longtable repair after the first compile

The first generated manuscript contained 77 native tables, 18,878 bound table cells and 194 numerical prose entries. The first two-pass compile produced a 167-page debug PDF but failed the guard. Every horizontal overflow was the same 15.32993pt at the full-width Notes minipage after a longtable. This equalled the body paragraph indent, so `main.tex` and the scoped `appnotes` definition in `g1-appendix.sty` now start the minipage with `noindent`. Table widths, values and font sizes were not reduced.

The repeated “Infinite glue shrinkage” diagnostics came from the installed `longtable` v4.24 output routine. This is [upstream LaTeX issue 1907](https://github.com/latex3/latex2e/issues/1907). The [official June 2026 release note](https://www.latex-project.org/news/latex2e-news/ltnews43.pdf) documents the finite-shrink repair; the [upstream source](https://raw.githubusercontent.com/latex3/latex2e/develop/required/tools/longtable.dtx) records it at v4.25, 23 December 2025. G1 applies the two upstream footer-glue replacements only for older package dates and only inside the `GOneBegin` group. It does not alter the installed TeX distribution or the host's output routine outside the appendix.

`test_portability.py` now saves the exact `LT@output` definition before inserting the complete appendix and compares it after `GOneEnd`, with an explicit TeX proof marker required by Python. The receipt records that assertion alongside restored counters. It also rejects ignored errors and allows two to six compilation passes, stopping when reference/table-width warnings clear. This source addition is not a claim that the final host test has already run.

The repaired debug build needed three serial XeLaTeX passes: the two known error classes disappeared after the first repair; seven width-change warnings after pass 2 disappeared after pass 3. The third-pass log has no overflow, ignored error, unresolved/duplicate-reference or table-width warning. It remains a debug artifact awaiting final figure revision and full visual inspection, not the published final PDF.

Recorded 2026-09-14 04:01 WIB. Debug PDF: `/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913-g1-runs/appendix-build-debug-02/main.pdf`; 167 pages; SHA-256 `eb3e65f99a0cc32656d1c6612865a0cc5060806df005f4840feddaa1e94b8ac3`. Exact repair files: `publication/g1-appendix.sty`, `publication/main.tex`, `publication/test_portability.py`.
