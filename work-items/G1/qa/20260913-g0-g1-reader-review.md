# G0–G1 comparative reader review

Reviewed 13 September 2026, 23:08 WIB (Asia/Jakarta). Reviewer: Codex Astra, `/root/g0_flow_review`. Root: `/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913`. Baseline: branch `g1/issue-9-g05-20260913`, commit `15ae3739b5502f75475bc105fe3b385b8c294084`.

This is an editorial review of the retained G0 manuscript and G1 templates, not a new analytical audit. It reads the repository `AGENTS.md`, `WRITING-PREFERENCES-SEE-HERE.md`, G0's continuous body and included introduction/construction/diagnostics/atlas/conclusion, and G1's two prose templates. Line references below identify the baseline templates; subsequent edits can move them. The baseline review was read-only. Root subsequently assigned this reviewer the prose strings in `method_tables.py`; the integration record at the end distinguishes those edits from the original findings. No estimation, numerical source, or PDF has been changed by this reviewer.

## Assessment

G1 has considerably more detail than its earlier short versions, but its first-use order still obstructs comprehension. The issue is not chiefly sentence length or a missing glossary. G1 announces conclusions using methods, measurements, and sample restrictions that it has not yet made meaningful. It then explains some of those objects, starts again, and repeatedly interrupts the substantive comparison with reminders about what the analysis cannot claim. G0 more consistently moves from an observable pattern to what we do, why we do it, the evidence, and its implication.

Adding the full names of LP, ACF, and OP to the existing first sentence would leave the central problem intact. Readers need to know what all four methods attempt to estimate, why ordinary input comparisons are insufficient, and which question distinguishes each method before a comparison of their names conveys information.

## Prioritized findings

### 1. Rebuild the introduction's dependency order

**G1 evidence.** `publication/manuscript-template.tex:8` opens with “The development panel supports a comparison of three nominal production-residual constructions” and immediately invokes LP, Wooldridge, ACF, and OP. “Development panel,” “nominal,” “production-residual,” the names, “input coefficients,” “selection,” and fictional longitudinal assignments all arrive in a single paragraph. The concrete manufacturer example follows at line 10, after the reader has been asked to understand the conclusions. The remainder definition appears again at line 12. Source orientation appears only at line 14.

**G0 comparison.** `releases/2026-09-13-g0-appendix/sections/introduction.tex:1–9` opens with a visible distributional pattern: “Upper tails and recorded zeros are both central to these manufacturing distributions.” It then explains why an average is incomplete and says, “We examine the center and spread of each distribution together with its response composition.” Lines 11–18 explain what we assemble and what the records permit. Even where G0 retains technical vocabulary, the reader has an object and reason for the analysis before the source limitation.

**Correction.** Lead with the plain substantive result: the methods attribute different contributions to workers and capital, and this can change the ordering of the same records. Explain the adjustment's economic purpose. Identify the source records, modified values, fictional annual links, nominal measurement and production window before the first formula. Introduce each method through its role, then its full name and abbreviation. Reserve rank-correlation numbers for a paragraph in which ranking and a correlation measure have a stated meaning, or defer them to the comparison section. Do not repeat the residual definition in two adjacent paragraphs.

An answer-first opening does not require a conclusion that can only be understood after reading the appendix. A plain-language answer can precede technical names and numerical detail.

### 2. Use researcher actions to carry the explanation

**G1 evidence.** At `manuscript-template.tex:12`, “This appendix develops that account before presenting the estimates” describes the document's intentions. At line 14, “The data are a perturbed development version of supplied manufacturing records” gives an opaque status label rather than an action or source explanation. At line 20, the roadmap “identifies the question answered at each step and why that answer is needed next”; line 30 then tells two kinds of reader how to use the roadmap.

**G0 comparison.** `sections/construction.tex:18–24` uses a sequence of concrete actions: “We retain every original value and create companion variables”; “we map source fields, parse their values, construct the measures”; “We then select samples and calculate all descriptive statistics.” The reason follows: this keeps construction consistent. `sections/diagnostics.tex:8–18` similarly introduces division by employment through the calculation we perform and then explains why its sample differs.

**Correction.** Prefer “We use…,” “We estimate…,” “We subtract…,” “We compare…,” followed by why the action answers the substantive question. Delete the paragraphs announcing that the explanation will be explanatory. Keep result subjects where they read naturally: “The capital estimates change when…” is better than forcing every sentence to begin with “We.”

### 3. Give the methods' data requirements before their estimation sequence

**G1 evidence.** LP's stages start at `method-chapters-template.tex:58`, but its “Variables and timing” starts at line 84. ACF's stages begin at line 179, with variables at line 203; Wooldridge's equation sequence begins at line 239, with variables at line 285. The reader receives several mathematical operations before being told which years, records, and input stocks actually supply them.

**G0 comparison.** G0 first identifies annual records and mappings in `sections/construction.tex:8–24`, then distinguishes measurement concepts at lines 81–104, and only then imposes transformation rules in `sections/diagnostics.tex:8–19`. The reader does not need to hold an unidentified data object in memory through several pages of mathematics.

**Correction.** Within each method: economic problem and distinctive assumption → variables and timing, including source/missingness tables → estimation procedure → worked calculation → conventional coefficient table and uncertainty → residual distributions and comparisons → sensitivity. Preserve all technical steps. This is reordering by dependency, not a reason to compress detail.

For the shared opening sections, a short source orientation before the first equation is enough; the full eligibility table can remain after the derivation of logarithms. That order allows the positivity requirement to be explained before its exclusion counts. The root's proposed integration uses this arrangement and satisfies the reader dependency.

### 4. Remove labels that require explanations without adding economic meaning

**G1 evidence.** `manuscript-template.tex:53–60` introduces “Native log residual,” then devotes a sentence to what “native” is meant to mean. Line 96 calls the available fields “nominal candidates.” `method-chapters-template.tex:86` says “capital coordinate”; line 287 combines “measurement coordinates” and “nominal candidates.” “Own-domain records,” “source-domain count,” “retained implementation,” and “declared” recur.

**Correction.** Prefer the direct substantive objects below. These are context-dependent editorial substitutions, not global replacements in code, filenames, or numerical provenance.

| Baseline wording | Reader-facing wording |
|---|---|
| Native log residual | Uncentered residual; state that it uses the logged reported variables |
| Capital coordinate | Logged beginning-of-year capital, or capital measure |
| Nominal candidate | Reported monetary measure; explain unresolved units where relevant |
| Source domain | Observations with the required positive measurements |
| Dynamic domain | Eligible consecutive-year pairs, after defining their fictional links |
| Sample support | Sample requirements, or sufficient observations for this estimation stage |
| Retained implementation | We estimate / We implement, followed by the exact method |
| Declared convention | The actual convention, such as reported prices and preceding-December stock |

Keep “candidate coefficient” when the optimizer is actually evaluating alternative coefficient values. That use distinguishes a trial value from the fitted estimate and is not interchangeable with a source variable.

### 5. Introduce technical terms through their job in the calculation

**G1 evidence.** The common-method opening at `method-chapters-template.tex:3` is one of the strongest existing paragraphs: favorable conditions prompt firms to use more inputs, so regression can mix the contribution of inputs with the conditions that prompted their use. Its next paragraph shifts abruptly to “regressors,” “structural interpretation,” “identify the slopes,” and later “innovation,” “moment conditions,” “polynomial basis,” and “function space.” The first equation in `manuscript-template.tex:38` uses subscripts `i,t` before explaining them.

**Correction.** Retain the technical vocabulary required for replication, but connect each term to its purpose before using it repeatedly. Examples:

- Define `i` as a fictional cross-year company assignment and `t` as calendar year before the first indexed equation. A source record and the assignment linking records must remain distinct.
- Explain “elasticity” as the proportional change in the modeled outcome associated with a proportional input change, with other terms held constant. Keep the qualification that the source records do not establish the economic interpretation.
- Introduce “innovation” as the part of this year's unobserved production conditions that the specified past information does not predict. Do not call all unexplained variation permanent productivity.
- Explain an instrument's role before stating a moment restriction: use an observed quantity that the timing assumptions allow to be related to an input while unrelated to the new production shock. The required absence of correlation is an assumption, not established by a full-rank matrix.
- Explain a polynomial as the chosen approximation to an unknown relation, using powers and products of observed variables; then display the complete basis and retain its degree and intercept details.
- Explain the bootstrap as repeatedly resampling whole fictional company histories and rerunning the estimator, before “conditional company-history bootstrap” becomes a compressed label. Its uncertainty remains conditional on the fictional links and reported-price convention.

Do not replace precise equations with analogies. The accessible sentence establishes why the following mathematical object exists; the formula supplies the exact calculation.

### 6. Attach caveats to the finding they qualify, without repeating a defensive closing rhythm

**G1 evidence.** LP distribution, sensitivity, ACF coefficient/distribution/sensitivity, and Wooldridge distribution/sensitivity passages repeatedly end with variants of “does not establish,” “does not show,” or “not a verified measure.” Several qualifications are scientifically essential, but their repeated placement causes each argument to end in generic withdrawal. Examples include `method-chapters-template.tex:116,219,227,235,299,307,315`.

**G0 comparison.** After its sample chart, G0 states the observed count changes and then explains the exact reason those counts cannot identify establishment entry or exit (`construction.tex:67`). The caveat is specific to the displayed statistic. Its response-state discussion explains that positive value added with zero employment cannot support a per-worker ratio (`diagnostics.tex:68`), preserving the link from observation to implication.

**Correction.** Preserve the global source and identity limits once in the source discussion, and repeat them where an otherwise plausible interpretation would be materially wrong. Keep local, result-specific limits: an ACF near-zero objective does not test its exactly identified model; Wooldridge's stable numerical starts do not relax its transition restriction; an OP disappearance is an assignment event, not authenticated closure; a positive-index ratio is not a physical-productivity ratio. Replace rhetorical fences such as “not mere printed-digit differences,” “economic truth,” or “does not require pretending” with the magnitude, assumption, or precise implication.

### 7. Rework the roadmap and conclusion as part of the argument

**G1 evidence.** `manuscript-template.tex:21–28` has six imperative reading instructions, including “Understand the measure before reading its values” and “Return to what the exercise establishes.” `manuscript-template.tex:164` concludes chiefly by listing requirements for OP and real-productivity interpretation. It does not synthesize the actual agreement, coefficient uncertainty, and sensitivity established in the preceding pages.

**G0 comparison.** The three bold roadmap leads in `sections/introduction.tex:20–51` state connected substantive relationships and link the relevant sections. Its conclusion returns to dispersion, reporting prevalence, and transformation samples, with links to concrete supporting exhibits; then it states the limits.

**Correction.** Use three connected roadmap paragraphs: what we measure and which records supply it; how the methods assign input contributions and how uncertain those estimates are; how their residual distributions and rankings compare. Put method-specific technical subsections beneath the corresponding method. End with the actual comparative answer—similar LP/Wooldridge rankings, more different and uncertain ACF estimates, unavailable OP under fixed sample requirements—and the evidence needed to apply the calculation to real productivity. Link existing semantic labels; do not type exhibit numbers.

## Proposed opening and introduction sequence

The following is an editorial model for the opening, not a replacement for bound numerical prose or a revised empirical finding. “Value added” must remain the **reported source measure**: do not invent an accounting identity or imply that source labels establish it.

> Our estimates assign different contributions to workers and capital, and these differences can change the relative position of the same manufacturing record. Two methods produce similar rankings after we account for those inputs; a third changes the ordering more and estimates labor's contribution less precisely in several industries. We therefore need to examine the estimated input contributions alongside the comparisons they produce.
>
> We use reported value added as the outcome and estimate how it varies with employment and the capital available at the beginning of the year. Value added is reported in money, so differences in prices can affect it as well as differences in production. We express the outcome and inputs in logarithms to compare proportional differences. After subtracting the contributions assigned to labor and capital, we compare the remaining component—the production residual. Section [production residuals] derives that calculation and explains its scale.
>
> We develop this calculation using the supplied manufacturing records in a version with perturbed values and fictional company identifiers linking annual records. [State the documented source version, production window and preceding-December capital timing in direct language.] These links let us carry out calculations that require consecutive years. They do not establish the histories of actual companies. We retain the reported monetary conventions, so the residual can also contain price and measurement differences.

The next paragraph should introduce the economic estimation problem through companies choosing workers and materials in response to production conditions they can observe. Then introduce the methods by their distinctive role, followed by full names/abbreviations:

- Materials purchases represent production conditions known to the company in the Levinsohn–Petrin approach (LP).
- Ackerberg–Caves–Frazer (ACF) changes the stage at which labor and capital contributions are estimated, because labor and materials can reflect the same production information.
- Wooldridge estimates related current and past-information equations jointly; the exact transition restriction belongs in its technical section.
- Olley–Pakes (OP) uses investment and accounts for continuation. In this development exercise its required sample is insufficient, so there are no OP coefficients or residuals to compare. Preserve the distinction between fictional continuation and real establishment survival.

Give this orientation in prose rather than forcing a terminology checklist into the published introduction. The method chapters should supply the deeper restrictions, sample counts, exact estimator variants, equations, instruments, and uncertainty procedures. The introduction need not front-load every acronym, statistic, numerical implementation choice, or prohibition.

## Reader check for the revision

Read from the title onward without following forward links. At every first use, ask whether the preceding text has established the term's object and purpose. A glossary elsewhere or an eventual definition does not answer that question. At each section opening, identify the single substantive question we are answering; at its end, identify what the evidence establishes and why the next section follows. Check the generated exhibit prose as well as these two templates: an improved introduction does not fix later unexplained captions, sample labels, or repetitive interpretation.

The review does not recommend new numerical analysis. Preserve every equation's scientific meaning, the exact estimator variants, all coefficient/SE/interval evidence, the source mappings and missingness counts, fixed sample thresholds, nominal-price limits, fictional linkage, and the absence of OP estimates. Root handles integration, source-binding checks, compilation, and visual review of the actual PDF.

## Integration follow-up

After the root revised the opening, I reread the updated introduction, residual definitions, and shared data section. The opening now explains the task before method abbreviations and identifies modified values and fictional links before the first equation. I sent the remaining concrete corrections to root: explain logarithms before the introductory subtraction; reduce repetition between the opening and residual-orientation paragraph; replace “dynamic moments” before the dynamic sample has been introduced; repair the positive-index paragraph's leftover “twice” reference; and define the indexed company explicitly as the fictional assignment used for this exercise.

Root then assigned `work-items/G1/publication/method_tables.py` for prose-only revision. I revised the source-variable, year-coverage, and sample-restriction paragraphs; table captions, headers and Notes; and coefficient-table introductions and interpretations. The tables retain every source operand, trace key, formula, and numeric calculation. Longer sample-column labels use native LaTeX line breaks and require review in the compiled pages.

The sample explanation now distinguishes the three uses of a record: first-stage approximation, a consecutive-year pair in the dynamic stage, and calculation of a residual with already estimated coefficients. In particular, it no longer claims that every observation outside the dynamic sample supplies no information to estimation. LP and ACF can use such observations in their first stages. Calculating another residual does not itself add a dynamic pair or rerun estimation.

Verification: Python successfully parses the edited builder. Comparing its AST with `git show HEAD:work-items/G1/publication/method_tables.py` after masking string constants gives exact equality. Thus the edits changed string content only; non-string structure, numbers, functions, and computational operations remain identical. No build or numerical rerun was performed by this reviewer. Root owns final integration, complete source-binding validation, and inspection of the actual compiled PDF.

## Independent reread of the rewritten root prose

I reread the full rewritten `manuscript-template.tex` and the revised `method_tables.py`, including the root's results and conclusion. The exact reviewed hashes were:

- `manuscript-template.tex`: `9168cacb533e67c5e040403b02cd11630d25ec1daad2c692921c141218d305ab`.
- `method_tables.py`: `b73dedcf86fec6051c19fff9b365d3e8f026b11c5538712b2bcc0f51b69e5b17`.

These hashes identify the reread, not the later final PDF or an unconditional acceptance of subsequent changes. Root received the following remaining corrections. No direct manuscript edits were made by this reviewer.

### Necessary interpretation corrections

1. **Index ratios need the common reference restriction (`manuscript-template.tex:92`).** The ratio of two centered-residual indices cancels the reference mean only within the same sector and method. The current unqualified comparison could encompass different sector reference means. State: “Within a sector and method, the ratio of two indices equals the ratio of their exponentiated uncentered residuals.” Then retain the accessible interpretation and physical-productivity limitation.
2. **A perfect correlation does not imply equal levels (`manuscript-template.tex:152`).** Pearson correlation equal to one means an exact positive linear relationship, not identical residual values. Spearman correlation equal to one refers to the ordering. Replace “perfect agreement of the relevant kind” with these distinctions and state explicitly that neither guarantees equal residual levels. This matters because the paper compares both magnitudes and rankings.
3. **Name the centering sample precisely (`manuscript-template.tex:75`).** “Fitted 2012 sample” and “observations used” could include records used in a first-stage approximation. The reference actually uses the 2012 records in the consecutive-year estimation stage. Name that sample before defining the set and its size. This is the same distinction corrected in the method-table prose.
4. **Keep real monetary values distinct from observed physical quantities (`manuscript-template.tex:100`).** Replace “quantities at common prices” with “amounts at common prices” or “values at common prices.” Applying a price adjustment does not, by itself, produce an observed physical-output quantity.

### Smaller clarity points

- At line 22, call the `@@primary@@` results models or model fits, rather than individual “estimates”; every fitted model supplies both labor and capital estimates. The later results section already uses models consistently.
- The final sentence of introduction paragraph 22 repeats the preceding three-method scope and can be removed without losing the result or limitation.
- The full company-history bootstrap explanation in `method_tables.py` is useful at the first method's coefficient table. Later method tables can refer back briefly, while retaining their own estimate, standard-error, interval and sample evidence. This is optional economy; retaining a short construction explanation in every method is reasonable for readers consulting one method separately.

### What this reread resolves

The root opening now states what we calculate before introducing method abbreviations. The four methods receive an economic role rather than only an expanded name. The data orientation precedes the first equation; `i` is explicitly the fictional company assignment and `t` the calendar year. The log calculation follows its purpose and domain. The results distinguish coefficient uncertainty across resamples from residual dispersion across records, explain histograms and ranking measures in context, and connect the conclusion to actual comparative findings. These changes resolve the principal first-use and argument-order failures identified in the baseline review, subject to the exact corrections above and the separate method-chapter/exhibit checks. This is an editorial judgment on the identified source versions; compilation, numerical binding validation, and inspection of final pages remain the root's work.
