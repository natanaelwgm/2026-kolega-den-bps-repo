# WRITING PREFERENCES — SEE HERE

Owner: Natanael. Recorded from the publication corrections in the 13 September 2026 conversation. These rules describe the current preference for this research publication. Later explicit owner instructions take precedence; record any change in the owner history so an older rule does not silently return.

This is the primary guide to what the owner expects and what future agents should reproduce. Read it before editing a paper, table, caption, or chart. Use the concrete examples below to resolve ordinary design choices, and preserve later corrections rather than reverting to an older screenshot.

The reference is the revised [54-page G0 appendix PDF](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/G0-Appendix.pdf). [main.tex](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/main.tex) supplies the standalone wrapper; [appendix.tex](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/appendix.tex) is the continuous manuscript body. The example PDF has SHA-256 `985485baefbb862e562f8fe14a0556ab803fa33fee22cdaf577a2312734ae39d`. Check this hash when following a mutable `main` link.

The [owner preference history](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/docs/OWNER-PREFERENCE-HISTORY-2026-09-13.md) records the sequence of corrections and which earlier instructions the current rules supersede.

## Introduce the purpose and data before the findings

Begin the appendix by explaining its purpose, the data or object it describes, the scope of that material, and the measures we construct and why. Then give an explicit roadmap with linked section references. Readers need this context before specific empirical findings can carry meaning. The Pyramid Principle means an orderly hierarchy of ideas here; it does not require an empirical headline, an aphorism, or a slogan before every paragraph.

**Preferred opening:** “In this appendix, we describe the annual manufacturing data and explain how we construct the measures used in the descriptive analysis.” Continue with the scope of the annual samples and the purpose of the constructions before introducing the roadmap. This is a concrete model for the opening, not a numerical result.

**Rejected opening:** “Upper tails and recorded zeros are both central to these manufacturing distributions.” The owner rejected this sentence as the opening of the latest PDF. It introduces a finding before the reader knows the data, measures, or descriptive purpose. Do not restore it or replace it with another headline claim.

Use bold only when it helps a useful roadmap label stand out, and follow that label with a substantive explanation of what the section does and why it belongs in the sequence. For example, **Data and construction.** Explain which records and measures the section establishes, then link to that section. Do not make bold assertions the organizing device throughout the manuscript. Write the body in normal connected paragraphs.

The owner specifically approved the useful prose that followed the inserted slogans. Preserve those active scholarly construction and sample paragraphs. Do not prepend rhetorical lead-ins, including the rejected Section 1.1 phrase “The unit of observation is an annual source record” or Section 1.2 phrase “A common name does not guarantee a common measure.” The rejection concerns their insertion as bold lead-ins; it does not remove the need to explain record identity or measurement comparability precisely in the substantive prose.

**Preferred Section 1.1 beginning:** “We assemble 33,049 observations from twelve annual manufacturing files covering 2010–2015 and 2017–2022.” Continue with the existing explanation of the sample and its interpretation. This sentence directly identifies the researchers’ action and the material being described; it needs no slogan in front of it. The count remains a source-bound value in the actual manuscript and must be regenerated from the verified numerical source when the data change.

Connect sections through natural transitions that explain the relationship between their subjects. **Weak:** “The next section presents energy.” **Useful:** “The per-worker measures describe monetary activity relative to employment. We next examine energy quantities to describe another dimension of production inputs.” The transition supplies a reason for moving to energy without suggesting that energy quantities resolve monetary source-scale uncertainty. Keep existing transitions that already make this relationship clear; do not add a stock transition mechanically to each paragraph.

Close with a substantive synthesis of what the evidence establishes for the appendix’s stated purpose and where interpretation remains limited. **Weak:** “All checks pass and all graphs are finished.” **Useful, illustrative synthesis:** “The distributions document differences in reported scale and response coverage within the annual samples. Stronger longitudinal interpretations require the corresponding identity and measurement evidence.” Do not introduce new findings or replace the conclusion with workflow status, generic future work, or an exhibit inventory.

This correction supersedes the earlier instruction to lead with a governing empirical finding and to add bold substantive leads throughout the paper. It preserves the explicit linked roadmap, coherent hierarchy, active academic prose, natural transitions, and substantive conclusion.

## Explain each concept before relying on it

The owner's later G1 correction on 13 September requires a reader to follow the appendix from the top without prior knowledge of its methods or internal workflow. Lead with a concrete research question, action or finding in familiar language. An answer-first opening does not justify naming unexplained methods or compressing several undefined concepts into the first sentence.

Introduce the purpose of a method before its full name and abbreviation. Explain why a transformation, sample restriction or assumption is needed before relying on it in a formula or result. Explain symbols when they first appear. Expanding an acronym alone does not explain the method. Preserve full technical detail beneath this conceptual account.

**Wrong:** “The development panel supports three nominal production-residual constructions; LP and Wooldridge rank similarly.”

**Preferred approach:** Explain how we account for workers and capital, what remains unexplained, and why estimating the input contributions is difficult. Identify the modified records and fictional company links in ordinary language. Only then introduce the methods and compare their results.

Use “we” for the researcher's actions where it makes responsibility and reasoning clear; let the evidence or a logical consequence be the subject when that reads more naturally. Avoid mannered announcements such as “This appendix develops that account before presenting the estimates.” A transition must carry a substantive relationship or it should be removed. Do not replace jargon with patronizing glossary sentences: explain the operation and why it matters in connected prose.

At review, compare the actual G0 and G1 paragraphs, not just their typography or heading styles. Check whether the next sentence depends on knowledge the preceding text has supplied. Put method-specific variables and timing before estimation equations; explain resampling and uncertainty before their first coefficient table. Retain construction → exhibit → interpretation, all numerical evidence and every scientific qualification that affects the claim. More pages, more uses of “we”, and a mechanically expanded acronym list are not substitutes for readable reasoning.

## Use descriptive academic headings

The owner's later G1 correction on 13 September requires short, descriptive academic headings, following the actual G0 appendix. Use names such as **Levinsohn–Petrin**, **Variables and timing**, **Estimation procedure**, **Coefficient estimates**, and **Residual distributions**. Put findings and their implications in the connected prose. Do not turn section titles or captions into slogans, sales claims, or full-sentence conclusions. The answer-first introduction and substantive roadmap leads remain appropriate; they do not require claim-style headings throughout the paper.

Subordinate the technical detail by meaning. Within each method, give data construction its own section, with source variables, year coverage, missingness and transformations beneath it. Separate those questions from estimation equations, coefficient results and uncertainty, predicted residuals, annual comparisons, outliers and sensitivity. A technical appendix should provide the calculations and conventional estimate tables needed to inspect each result; adding pages without answering those questions does not meet this requirement.

## Write as the researchers

Use active, natural academic English. State what we construct or calculate, why that measure answers the descriptive question, and what the results show. A reader should be able to follow the argument without knowing the development process.

Each exhibit needs a connected sequence:

1. Before the exhibit, explain the construction, calculation, sample, and reason for showing it. Identify the measure and denominator where relevant.
2. Present the figure or native table, with its caption, any necessary Notes, and a separate Source line.
3. After the exhibit, interpret the actual pattern. Explain its implication and any limitation needed to understand that implication. Do not merely restate the title or leave interpretation before a floating exhibit.

Keep operational status, internal validation commentary, build instructions, and workflow notes in the companion documentation. Scientific qualifications belong in the paper when they affect interpretation. Integrate them with the relevant finding instead of collecting repetitive defensive paragraphs.

The owner flagged these passive examples; punctuation below is normalized from the spoken fragments:

| Flagged wording | Preferred active rewrite |
|---|---|
| “Original values are retained alongside transformed variables.” | “We retain every original value and create companion variables for the transformations described below.” |
| “Changes in sample size are not interpreted as entry.” | “We report changes in the annual sample size. Those counts alone do not identify establishment entry; we need a longitudinal identifier to study entry.” |

The point is to make the researcher’s action and its scientific consequence explicit, not to replace every passive verb mechanically. Do not force “We” into every sentence. A result, a comparison, or a logical consequence can be the subject when that makes the paragraph read naturally.

## Produce an actual publication appendix

Use one continuous LaTeX appendix that can be included in a manuscript, with a separate standalone wrapper for compilation. Use ordinary figure and table numbering, native LaTeX tables, and vector charts. Avoid report cards, internal status panels, or screenshots of tables.

The requested visual brief is an economics-paper appendix with QJE/AER-like restraint. That is a design brief, not a claim of journal certification, editorial acceptance, or completed empirical identification.

Use the actual Times New Roman font for body text, tables, captions, notes, chart labels, and legends. Do not silently substitute a font that merely resembles Times. Keep the font mapping explicit, including any separately documented mathematical-glyph font needed by the LaTeX build.

Maintain a live view of the compiled PDF while revising. Update that view from a successful compilation of the current LaTeX and assets. An HTML viewer may display the actual PDF; it must not substitute a different HTML report for the requested paper. Replace the displayed PDF only after a successful build, and keep figures, text, and the file shown to the owner synchronized.

Keep the construction → exhibit → interpretation sequence intact during pagination. Avoid nearly empty pages containing only a short interpretation paragraph. Fix spacing or chart geometry without making fonts unreadable, deleting substantive interpretation, or moving the explanation ahead of its exhibit.

## Make numbering portable and references clickable

Use the implemented [g0-appendix.sty](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/g0-appendix.sty) interface. The host controls fonts, margins, page numbering, appendix lettering, and ancestor counters. `\GZeroRootLevel` selects whether the G0 root is a section (`1`), subsection (`2`), or subsubsection (`3`). `\GZeroSection` and `\GZeroSubsection` then place its internal headings relative to that root. `\GZeroBasePath` locates the included body and assets.

An illustrative host setup is:

```latex
\usepackage{g0-appendix} % Put the package on the host's TeX search path.
\renewcommand{\GZeroBasePath}{appendices/g0}
\renewcommand{\GZeroRootLevel}{2}
% Within the desired host section:
\input{appendices/g0/appendix.tex}
% Outside the included body:
See Figure~\ref{g0:fig:sample}.
```

The body calls `\GZeroBegin` and `\GZeroEnd` to scope its settings and restore the host's figure, table, and equation counters. Its exhibit and equation numbers derive from the actual G0 root number. The current standalone wrapper prints **Appendix 1** and numbers its figures **1.1**, **1.2**, and so on; those are output conventions, not literal strings to copy into prose.

Inside the body, use the explicit semantic helpers `\GZeroLabel{fig:sample}` and `\GZeroRef{fig:sample}`. The package adds the configured `g0:` namespace and delegates to the environment-native label/reference commands; it does not locally redefine the `\label` primitive. Outside the body, use the compiled name, such as `\ref{g0:fig:sample}`. Do not add the prefix twice. Use the same helpers for headings and tables; place exhibit labels after captions and formula labels inside their equation environments. Refer to formulas with `\GZeroEqref{eq:per-worker}`. Hyperlink support must remain active.

**Wrong:** Type “Section A.8,” “Figure A28,” or “Equation (A2)” directly into manuscript prose, or embed `A.8` in a heading title. **Right:** Write `Section~\GZeroRef{sec:annual-distributions}` inside the G0 body and let the host compilation supply the number and link.

```latex
\GZeroSection{Annual distributions}
\GZeroLabel{sec:annual-distributions}
See Table~\GZeroRef{tab:atlas-elec-purchased-kwh}.
```


Test insertion in an actual host with preceding material and another appendix. Confirm that all heading, formula, figure, and table references resolve, follow the host hierarchy, and link to the right destinations; check duplicate anchors and restored host counters. A standalone build alone does not prove portability. The concrete numbers and pages in this guide are snapshots for inspecting the linked example, not a numbering scheme for another manuscript. Refresh them from the final compilation when the reference changes.

## Give every exhibit a separate Source

Every numbered figure and table needs an explicit **Source:** line distinct from **Notes:**. Notes explain the calculation and reading of the exhibit; Sources identify the underlying data, questionnaire, reference series, or conversion material.

Name a provider, publication, edition, year, or questionnaire page only when the evidence supports that attribution. The supplied sample files, an official questionnaire used to interpret their fields, a supplied price-reference package, and inherited conversion schedules are different sources. Do not treat a matching field name or a copied CSV as proof that a private sample came from a particular official release.

Use source wording specific to the exhibit family. A price-series chart or a conversion-factor schedule must not inherit a manufacturing-records-only Source line. Preserve precise citations and source evidence in the provenance companion.

## Put calculated values on charts

Generate direct numerical labels from the same source arrays used to draw the marks. Retain the exact unrounded source value, row key, field, display scale, decimal format, printed string, and plotting anchor in the annotation trace. A visual revision may change placement or formatting; it must not manually enter or alter a result.

Apply the current rules consistently:

- **Annual quartile intervals:** show all three numerical values for every available year. Use numbers only beside the marks, without repeated `P25`, `Med`, or `P75` prefixes. Make the median number bold. Explain the dot and interval in an actual legend. If values coincide, share a label rather than print overlapping copies; preserve the median’s identification.
- **Time-series lines:** label each series at its first and last available observations only. Apply the same endpoint rule to every series. This supersedes the earlier permission to add extrema or middle points. Do not restore scattered interior labels unless the owner changes the rule.
- **Counts in bars and matrices:** label the applicable marks directly with their source-derived counts, including genuine zeros where the exhibit distinguishes them from missingness.
- **Histograms:** retain a consistent rule suited to bins rather than years. The current design labels the modal bin and the first and last occupied bins with the supplied share and count. Explain that selection in the legend and notes. Preserve tiny positive shares when formatting.

## Give every visual an actual legend

Every visual needs a visible legend identifying its meaningful colors, shades, symbols, line styles, backgrounds, or other encodings. Direct labels, panel titles, axis labels, Notes, and Source lines do not replace this legend.

Examples include the median dot and quartile interval, response-composition fills, eligibility shading, a full-denominator background bar, price-series line styles, and histogram annotation leaders. A gray band marking the missing 2016 annual file must have an explicit **No annual file** key. A reader should not have to infer what an unexplained gray region means.

Use consistent legend wording and mark styles across related figures. Reserve enough space for the legend and inspect the actual compiled page for collisions and clipping.

## Keep precision consistent with the quantity

Choose precision by unit and column, then apply it consistently within that column or equivalent series. Do not change decimal places from one row to the next merely because one value happens to be small or round.

- Use integers for counts and for displayed quantities whose intended reporting unit does not require fractions.
- Preserve a meaningful fixed decimal precision for shares, ratios, indices, small quantities, and factors. Avoid rounding a positive value into a misleading displayed zero.
- Keep missing values distinct from zeros. Do not fill an unavailable year or source value to make a table or chart look continuous.
- Retain exact source values in the trace; rounding is a presentation operation.

The current appendix applies whole source units to the threshold columns, one decimal to the displayed price indices, six decimals to grid factors, two decimals to R&D percentages, and three decimals to all selected histogram shares. The last rule keeps a tiny occupied tail visible as `0.003%`. These are unit-specific applications, not a rule to use the same number of decimals for every quantity.

## What right and wrong look like in practice

### Interpretation must say something the exhibit establishes

**Wrong:** “Figure 1.2 shows the sensitivity results. The results are robust.” This neither tells the reader what we examined nor limits the claim to what is visible.

**Right:** The actual appendix explains why we compare medians and interquartile ranges under three value-added samples, then states: “The three panels show closely aligned central distributions.” It immediately explains that this agreement does not establish that the mean or maximum is insensitive to the rule. The conclusion follows from the plotted quantities. Do not turn agreement in the center into a claim about every aspect of the distribution.

### Source lines must identify the relevant material

**Wrong:** Put only “Notes: Authors’ calculations” below a table, or copy “Source: Annual manufacturing extracts” below a price-reference chart.

**Right:** Figure 1.3 names the supplied *WPI Output Deflator—Indonesian Manufacturing, 2000–2022* package, its documented BPS *Indeks Harga Perdagangan Besar Indonesia* basis, and authors’ calculations. The R&D exhibits separately identify the 2017 manufacturing extract and the BPS questionnaire reproduced in *Statistik Industri Besar Sedang Provinsi Kalimantan Timur 2017* (2019), pp. 21–24. Neither citation authenticates the sample itself as a particular BPS release.

The appendix macro keeps the Source distinct from Notes. This excerpt preserves the routing table's source wording and first notes sentence:

```latex
\appnotes[2017 manufacturing extract; BPS,
\textit{Statistik Industri Besar Sedang Provinsi Kalimantan Timur 2017}
(2019), questionnaire, pp.~21--24; authors' calculations.]{
Indented rows partition the eligible group rather than add observations.}
```

### Label policy must be systematic

**Wrong:** Show quartiles for only a few convenient years, repeat “P25/Med/P75” beside every mark, or put an interior maximum on one price line while labeling only endpoints on another.

**Right:** Figure 1.2 labels all twelve available years in every panel. Its 2010 reported-value panel shows 8.64, **1.75**, and 0.50 in millions of source units; the bold middle value identifies the median. The legend explains the dot and interval. Figure 1.3 labels only each series’ first and last available values: for example, series 1511 is labeled 331.1 and 753.6. The same rule applies to all four series.

Never type those example results into a chart builder. The examples describe the reference output. The implementation must read the corresponding source cells, as in this display-format operation from the histogram workflow:

```python
printed_share = format(float(row['proportion']) * 100, '.3f')
```

Keep `row['proportion']` unchanged in the trace. Record its source file, bin key, field, scale of 100, format `.3f`, printed string, and true bar anchor. Drawing a label and tracing it must use the same value.

### A legend must explain the visible encoding

**Wrong:** Assume that a gray band is self-explanatory, or that a caption saying “natural gas quantity” explains the shades in a composition panel.

**Right:** Figure 1.28 identifies the median mark, quartile interval, response-composition fills, and gray **No annual file** band. That last key distinguishes the missing annual file from a company’s missing response. The histogram legends explain both the bar fill and which occupied bins receive numerical labels. A visible legend remains necessary even when the Notes also explain the method.

### Precision must communicate the reporting unit

**Wrong:** Switch among formats such as `58,173`, `58,173.0`, and `5.8173e4` within an otherwise uniform kWh column, or round an occupied histogram tail to `0.00%`.

**Right:** Table 1.33 reports purchased-electricity summaries in whole kWh throughout its corresponding columns, while sample and state counts remain integers. The price table preserves one decimal even in values such as `496.0`; the grid table preserves six, including `0.000690`. Histogram shares uniformly use three decimals, so a one-observation tail remains visible as `0.003%`. These formats are deliberate reporting choices, not changes to the source values.

## Preserve the scientific and provenance boundaries

Keep the publication layer separate from upstream data construction. Consume the frozen, verified master and aggregate exports. A wording, legend, precision, or layout request does not authorize changes to raw records, source mappings, the master dataset, upstream Stata calculations, or scientific assumptions.

Retain the complete source and transformation lineage, including the original DAG, source and codebook evidence, master identity, aggregate hashes, execution receipts, native table cells, figure assets, numerical prose, annotation operands, and their links to numbered exhibits and the compiled PDF. Preserve relevant original dependencies rather than presenting a shortened display diagram as the entire analytical graph.

If analytical inputs change under an authorized research task, regenerate and verify the affected calculations before rebuilding the publication. Do not treat a newly compiled PDF as evidence of a new empirical run. Keep published interpretation within the evidence actually established, including unresolved record identity, units, classifications, price assignments, or conversion conventions.

After a presentation change, inspect the affected compiled pages, verify the source-to-label/table bindings, refresh the provenance to the exact PDF shown, and package the matching LaTeX, figures, PDF, and companion evidence together.

## Exact reference examples

The following numbers and pages come from the 54-page reference build identified above. Open that PDF page, then inspect the linked semantic LaTeX label or prose block. For example, the source key `fig:tail-sensitivity` compiles as `g0:fig:tail-sensitivity`, currently Figure 1.2. Recheck the labels when another manuscript changes the printed numbers.

| Example | PDF page | LaTeX example | What to reproduce |
|---|---|---|---|
| Introduction and roadmap | 1 | [introduction.tex, line 1](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/introduction.tex#L1) | Purpose, data and scope before findings; substantive linked roadmap; no rhetorical opening slogan. |
| Table 1.1 | 2 | [construction.tex, line 29](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/construction.tex#L29) | Active construction prose, native table, separate Notes and Source. |
| Figure 1.2 | 11 | [diagnostics.tex, line 283](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/diagnostics.tex#L283) | Every annual quartile value, numeric-only labels, bold median, actual legend. |
| Figure 1.3 | 16 | [diagnostics.tex, line 530](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/diagnostics.tex#L530) | Consistent first/last labels, four-series legend, specific price Source. |
| Figure 1.4 | 20 | [diagnostics.tex, line 708](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/diagnostics.tex#L708) | Direct count labels, response-state legend, interpretation after the exhibit. |
| Table 1.33 | 35 | [atlas.tex, line 715](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/atlas.tex#L715) | Consistent whole-kWh precision and integer count columns. |
| Figure 1.28 | 45 | [atlas.tex, line 1249](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/atlas.tex#L1249) | Complete legend, including the unavailable-year band and composition fills. |
| Figure 1.35 | 53 | [rd-hist.tex, line 212](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/rd-hist.tex#L212) | Source-derived bin labels, three-decimal shares, actual legends, and interpretation on the page. |
| Summary of data construction and descriptive evidence, Section 1.11 | 54 | [conclusion.tex, line 2](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/sections/conclusion.tex#L2) | Synthesis tied to the stated descriptive purpose, linked supporting evidence, explicit interpretive limits. |

For implementation, inspect [build_diagnostics.py](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/provenance/presentation/build_diagnostics.py), [diagnostics_prose.py](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/provenance/presentation/diagnostics_prose.py), [build_atlas.py](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/provenance/presentation/build_atlas.py), and [build_rd_hist.py](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/releases/2026-09-13-g0-appendix/provenance/presentation/build_rd_hist.py). They are examples of reproducible generation, not permission to alter the frozen statistical inputs.

## Know which results the example represents

This appendix redraws existing certified **actual G0 aggregates** bound to the local master with 33,049 records and 4,593 columns, SHA-256 `d0438798e28d67f5ac4fce3ea6a07b46630be28d88fd6cb6f17c15dc99baca08`. It covers twelve annual samples, 2010–2015 and 2017–2022, and 36 verified aggregate CSVs. It does not establish a longitudinal identity crosswalk or complete the downstream research plans.

It is not a G0.5 rerun. Respect the repository’s current [data modes](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/docs/DATA-MODES.md) and [identifier policy](https://github.com/natanaelwgm/deasy-imed-si-research-2026/blob/main/docs/DATA-IDENTIFIERS.md): new downstream development uses the perturbed G0.5 development input through `harness.data_source.load_data()`; actual finalisation uses explicitly selected, verified local actual input. G0.5 `psid` values are fictional. A publication-format revision must neither change those policies nor relabel development results as actual findings.

## Copy-paste instruction for the next agent

> Read WRITING-PREFERENCES-SEE-HERE.md and inspect the linked PDF/LaTeX examples before editing. Open with the appendix’s purpose, data or object, scope, and constructions and their motivation, then give an explicit linked roadmap. Introduce specific findings after that context. Treat the Pyramid Principle as orderly hierarchy, not headline claims or aphorisms. Use bold only for useful roadmap labels with substantive explanations, and write the body in normal connected paragraphs. Preserve the existing active sample and construction prose; never prepend slogans such as “The unit of observation is an annual source record” or “A common name does not guarantee a common measure.” Connect the sections through natural transitions and close by synthesizing the argument. Preserve active academic prose: explain the construction and purpose, show the exhibit, then interpret the actual result. Use actual Times New Roman, native LaTeX tables, vector charts, and a separate Source line for every exhibit. Derive numerical labels from their source cells. Show every annual quartile value with a bold median and numeric-only labels; use first/last labels only on time-series lines. Add an actual legend for every meaningful encoding, including unavailable-year bands. Keep precision consistent by unit and column while preserving tiny positives. Use namespaced semantic labels and clickable references for headings, formulas, figures, and tables; let the host manuscript control numbering and test insertion into another appendix sequence. Respect current repository data modes and upstream isolation. Rebuild and inspect the actual PDF, repair overlaps or orphaned discussion, verify table/label operands, and bind the matching sources, assets, provenance, and PDF together.
