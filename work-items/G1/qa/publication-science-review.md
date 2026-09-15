# G1 publication science and source review

Review owner: `/root/prerequisite_audit`, Codex. Checkpoint 2026-09-13T13:34:19.512750+00:00, repository main `d596babfc8686f5f279cdd238a681edb1c56253e`. This is an independent read-only publication audit. No Stata, analytical mutation, source edit, report edit or figure edit was performed by this reviewer. The only worktree deliverable written by this reviewer for this task is this file.

## Current decision

**The publication's numerical and scientific review passes within its explicit nominal DEVELOPMENT scope; final visual/provenance acceptance remains pending two concrete corrections.** The complete 11-page appendix was read and visually inspected. Current numerical tables, prose and annotation traces match their sources. Resolve the Figure A4 colorbar-title clipping and refresh the N06 source-code hash after the comment pass before claiming the final PDF package passed. The earlier ACF interpretation, nonzero precision, histogram legend, transition-scope and own/common display findings have been addressed in the reviewed appendix. This is not a real-primary completion or economic-identification pass.

## Scope and source receipts

- Read the complete `WRITING-PREFERENCES-SEE-HERE.md` and reference main/appendix LaTeX, including the construction table and histogram examples. Reference PDF `releases/2026-09-13-g0-appendix/G0-Appendix.pdf` has the exact required SHA256 `d8469e1537bb0dafaf8fdd8624043246e3ac726fca63fba923946c10d88bec6c`; 51 pages. Visually inspected reference pages A-1 and A-51. `pdffonts` confirms embedded Times New Roman variants and separately declared STIX Two Math in the reference.
- Current G0.5 manifest SHA256 remains `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`, v3, 33,049 rows and 4,396 columns. This is distinct from the reference appendix's actual G0 master and its 4,593 columns.
- Result source: `/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913-g1-runs/v3-nominal-fit-01/outputs/`. Core SHA256 receipts: coefficients `9b46f6b00163e89187a55816e3e5446992da59d66c857bd44d9cda4b362403e5`; bootstrap summary `5feb71f8342119eed1ddc02b92fc9f84bfd7d61fa0ccc831400c926f2d291c88`; distributions `82ca9d838a9659142d2979a2e2badbb740367f01d6f53ed7210448652f914bba`; pairwise comparisons `e2179f29ee76dd39a8157b531f1cf3c933b6c151d8e590f5c1ee70b706fc8817`.
- All six current `source-gates.json` dependencies still match their pinned SHA256 after the main fast-forward: variable-year release status, identity acceptance, company-price gate, classification acceptance, exact annual metadata, and original G1 row plan. The explicit synthetic-development override remains in the file. Current N01–N07 source-code hashes also match their DAG contracts. The new writing guide did not alter these analytical gates or the original plan.

## Verified scientific claims

1. The declared nominal grid contains 768 cells: 60 successful fits (15 primary and 45 sensitivity) and 708 support skips. Successful primary cells are LP, ACF and Wooldridge in reported sectors 10, 12, 13, 14 and 23. Their per-sector dynamic 2012 counts are 230, 53, 94, 64 and 79, totaling 520 for each method. These are 520 shared original records, not 1,560 unique observations.
2. All six unordered method pairs remain in the comparison exports. OP–LP, OP–ACF and OP–Wooldridge have zero shared predictions. LP–ACF, LP–Wooldridge and ACF–Wooldridge each compare the same 520 own-sample records. Their aggregate Spearman correlations are approximately 0.850614, 0.994857 and 0.866078. The separately recorded four-method scope is empty for all six pairs; pairwise support does not substitute for that obligation.
3. No OP or four-method common cell clears the frozen support rules. Maximum eligible selection count is 75 versus required 100; maximum simulated disappearance count is five versus required ten. The synthetic-development identity is present and accepted. Missing authenticated REAL company links are not the development blocker.
4. All 15 primary cells have 99 successful bootstrap draws: 1,485 requested and 1,485 successful. The original estimate is separate. The intervals are exploratory percentile intervals conditional on one frozen fictional assignment and the nominal measurement convention. They omit uncertainty in the generator and do not complete the separate 999-draw accepted-real primary.
5. ACF labor coefficients exceed LP and Wooldridge in all five sectors. Negative or near-zero capital estimates remain in the source. ACF labor intervals are especially wide in sector 13 (1.0256628 to 13.1916768) and sector 14 (0.8139019 to 13.4695189). Successful numerical returns do not imply precision or economic identification.
6. Reported output is log nominal VA, with positive reported workers, beginning capital from the prior calendar year's documented December stock, and nominal materials/investment proxies. No price deflation was used in these fitted results. The 2010 history / 2011–2012 production / 2012 dynamic timing is preserved.
7. Approximate-real nonland preparation is a separate registered sensitivity using actual macro price references. No approximate-real fit occurred. Raw nonland investment adds no positive observations beyond canonical positive additions; the preparation cannot be described as resolving current OP support or accepted-real primary admission.
8. Narrow inspection of the private N04 sidecar confirmed that 2011 domain predictions and all sensitivity variants remain there, while fitted observations are 2012. Only aggregate counts were read/output by this reviewer. The final full-master preservation claim still requires its final receipt; `build_report.py` appropriately loads that receipt before generating the report.

## Findings for the current publication authors

### P1 — interpret material ACF initialization dependence

`publication/plot_figures.py` originally stated that alternative-start symbols were coincident while labelling only primary/degree-two coefficients. The saved ACF numbers contradict coincidence. Labor estimates under primary/lower/higher starts are respectively: sector10 1.080622/0.378701/0.719126; sector12 1.328086/0.367278/0.709263; sector13 1.174847/0.932100/0.992684; sector14 0.973014/0.389373/0.730937; sector23 1.415755/0.726571/0.721758. The largest lower/higher-start differences from primary are 0.9608075803 and 0.6939964908.

Alternative starts also produce lower same-method objective values in sectors10,12,13,14. For example sector10 primary is about0.007851 versus lower-start0.000124; sector14 primary about0.002355 versus lower-start0.000026. Preserve the predeclared primary, but explain that these results remain initialization-sensitive and that numerical convergence has not demonstrated a unique or globally best optimum. Do not silently select the smallest objective as a new primary. Label material alternative estimates or provide their complete native table; do not describe them as coincident or generally robust. This is a reporting correction, not permission to rerun or mutate the frozen analysis.

### P2 — preserve nonzero capital precision

The LP sector14 capital coefficient is `-0.0001416294951891`. A uniform `.3f` formatter prints `-0.000` in the current coefficient chart and would do the same in a matching table. Use a consistent precision within the capital coefficient column/series that preserves the nonzero value, such as four decimals (`-0.0001`), and apply the same convention in its trace/table. Counts should remain integers.

### P2 — histogram fill legend must identify the visible colors

The first new histogram render had LP/ACF/Wooldridge colored fills but only a gray generic-fill legend. The guide explicitly says panel titles do not replace a meaningful-color legend. Use a matching legend for all three method colors, or one uniform gray bar color matching the fill legend. Parent acknowledged a pending code correction. The selected-bin leader legend is already present.

## Figure trace audit and superseded findings

The new `publication/plot_figures.py` produces six vector figures and an operand trace. At the reviewed checkpoint, all 125 numeric annotations resolved to exactly one row across five hash-bound Stata CSVs. Every unrounded value, display scale, numeric format and printed string matched independently; zero trace mismatches were found. Each entry also records its plotting anchor. The manifest includes explicit Times New Roman font-file hashes.

The new histogram uses fixed-width bars at the original bin coordinates, so empty ACF and Wooldridge bins remain empty. This resolves the earlier legacy connected-step error that visually bridged gaps. New coefficient plots show a point/interval legend and preserve the full wide ACF intervals. New rank plots show all six pairs and identify unsupported cells. These changes supersede the old `plot_nominal.py` findings; the wrapper should continue pointing to these reviewed publication assets.

Visually inspected the first new coefficient, histogram and sensitivity figure renders. Coefficient intervals are not clipped; tiny histogram shares remain positive under three-decimal percent formatting. PDF-level pagination, Source/Notes separation, actual embedded fonts, figure order, legend collisions and construction→exhibit→interpretation sequencing remain to be checked on the completed appendix.

## Pending final-publication checks

- Read the finished `publication/build_appendix.py`, continuous `appendix.tex` and native table cells against the exact result/source rows; verify provider-specific Source lines and no false attribution of private sample records to a particular BPS official release.
- Inspect every compiled page, especially tables, wide ACF intervals, histogram leaders, shared-record rank figures, sensitivity interpretation and final references. Check ordinary numbering and that substantive interpretation follows its exhibit without nearly empty orphan pages.
- Confirm actual embedded Times New Roman plus explicitly declared mathematical font. Confirm the live PDF, LaTeX, vector figures and final manifest hashes match.
- Revalidate annotations and source/table/prose trace after any final numeric formatting revision. Compilation alone is not a scientific or visual pass.


## Completed appendix and PDF review — 13 September 2026

Reviewed the complete `publication/build_appendix.py`, `appendix.tex`, six native tables and six vector figures. Read and visually inspected every page A-1 through A-11 of `publication/G1-Appendix.pdf`, SHA256 **`16273128196d8f5855cc00e3d3a5b810c66f442c94c11a350d25cef69af9331f`**, 309,937 bytes, compiled 13:37:01 UTC. This exact PDF is also the PDF named in its build manifest. No LaTeX warning, undefined reference or overfull-box message appeared in the retained compile log. `pdffonts` reports embedded Times New Roman regular/bold/italic variants and explicitly declared STIX Two Math; no substitute body font was observed.

The continuous English appendix uses ordinary numbering, native tables and separate Notes/Source lines for every numbered exhibit. Construction precedes each exhibit, and substantive interpretation follows. It does not present operational validation panels as research findings. Sources identify the G0.5 development derivative and fictional assignments; they do not authenticate the private source sample as a particular official BPS dissemination release. The complete source/price interpretation remains in the companion provenance. No approximate-real estimation is claimed in the paper.

All 270 table-cell records and 37 numerical-prose/design records were independently checked. This covered **743 operand checks**, recomputation of **19 derived statistics**, and **53 textual code/method mappings**, with zero numerical/value/format mismatches. Design-only records were checked against the declared contract and previously reviewed N06/bootstrap/start code. The global degree-two maximum now includes all relevant candidate operands. All **155** current numerical figure annotations resolve to exactly one source row in five hash-bound CSVs and reproduce their values and printed strings. The additional sensitivity labels show every displayed matrix cell, rather than suggesting materially different starts coincide.

The following earlier review findings are resolved in this PDF:

- ACF labor and LP capital initialization dependence are explicit. The text retains the predeclared primary without claiming a unique global optimum; Table A6 and Figure A6 disclose the relevant differences. Figure A6 is correctly described as labor-coefficient sensitivity.
- Table A3 uses four decimals for all coefficient/interval columns. Figure A2 preserves the small LP sector14 capital coefficient as `-0.0001`; the long ACF labor intervals remain visible without clipping.
- Figure A3 uses bars at actual occupied-bin coordinates, keeps empty bins empty, labels first/modal/last occupied bins with counts and three-decimal percentages, and now has actual method-color and leader legends.
- Figure A1 explicitly displays own-domain transitions, with four-method transitions referred to Table A2. These pre-fit transition counts are distinct from zero supported common-model predictions.
- The method narrative and sensitivity notes distinguish the retained cubic OP/LP/ACF transition from Wooldridge's jointly changed current/lagged proxy bases.
- All six method pairs and zero supported four-method prediction denominators are retained, with missing correlations displayed as em dashes rather than zeros.

### Remaining P2 visual correction: Figure A4 colorbar title

On page A-8, the vertical `Spearman correlation` title lies beyond the right canvas boundary and is visibly clipped. The clipping is present in `publication/figures/rank_comparison.png` itself, so a LaTeX margin change alone is insufficient. Move the colorbar/axes inward or remove the redundant vertical title while retaining a complete visible scale/legend. Rebuild the figure and PDF, then inspect the affected page. The Figure A6 horizontal colorbar title is also tightly spaced against panel x-axis labels; improve separation if adjusting that figure, without changing its values.

Page A-6 has substantial unused lower space because the histogram moves to A-7, but it contains a substantive table and interpretation rather than a nearly empty orphan paragraph. This is a layout refinement opportunity, not a numerical/source defect. The page breaks preserve the interpretation order. Page A-11 contains references after the preceding conclusion and is not an unexplained blank page.

### Remaining provenance refresh: comment-only N06 source revision

The reviewed `numerical-prose.json` currently pins `stata/nominal/N06_outputs.do` at `b6584d81e1d4c78d81e2815a13abb2ecb929ac0b9e5dac90a5286516e655c3d4`; the current file hash is `a2cce0b771d4752d0adc1a8419e444d9eda74010e9c7360068a94de7f738c55a` following concurrent comment work. No result CSV hash changed during this audit. Freeze the comment pass, rerun the appendix provenance generator and DAG contract builder, and recompile before final package acceptance. Do not treat this as permission to regenerate statistical results or alter their lineage.

The [official Stata Journal article record](https://www.stata-journal.com/article.html?article=st0537) independently confirms the Rovigatti–Mollisi article title, authors, volume18(3), pages618–662, and the cited foundational papers' years/volumes/pages. The retained bibliography matches this record. Separate web retrieval of the two NBER pages returned403 and the DOI resolver routes did not open through the web tool; no claim that all five publisher pages were individually retrieved is made.

### Resource and ownership receipt

Used one sequential Poppler renderer at95dpi for11 pages; it exited normally in under two seconds. No concurrent renderer, Stata process, browser or long-lived worker was created. Temporary rendered pages occupy only the review directory under `/tmp/g1-publication-science-qa/`. The cheap system check showed21GiB free on the output volume and high existing machine load; protected `sysctl` queries were unavailable. Work remained bounded to the small existing PDF and aggregate CSVs. No unrelated process was stopped or modified.
