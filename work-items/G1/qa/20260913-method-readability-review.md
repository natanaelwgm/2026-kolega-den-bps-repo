# G1 method chapter readability review

- Timestamp: 2026-09-13T23:17:32.451011+07:00 (Asia/Jakarta)
- Agent/runtime: `/root/method_readability`, Astra subagent
- Root: `/Users/natanaelmassie/Downloads/deasy-g1-issue9-20260913`
- Branch/HEAD at review: `g1/issue-9-g05-20260913` / `15ae3739b5502f75475bc105fe3b385b8c294084`
- Owned manuscript: `work-items/G1/publication/method-chapters-template.tex`

## G0 comparison

Read root `AGENTS.md`, `WRITING-PREFERENCES-SEE-HERE.md`, the actual G0 continuous appendix routing source, and its `sections/introduction.tex` and `sections/construction.tex`. G0 introduces the observable question, explains the researcher action and its purpose, establishes the measurement and sample, then interprets the evidence. The old G1 template repeatedly named technical operations before explaining their purpose, used internal terms such as domain/coordinate/native, and placed data supply after estimation equations.

## Revision

Rewrote the common method section and all four method chapters in active academic English. The common section now explains why input choices complicate estimation before introducing the four full method names and their abbreviations. It builds the meaning of materials inversion/monotonicity, predetermined capital, productivity innovations, polynomial approximations and input-median versus residual-mean subtraction through their role in the calculation.

Moved every method's variables/timing and source-table placeholders before estimation equations/procedures. LP and OP's conceptual equations also follow their measurement blocks. Worked-calculation placeholders follow the mathematical procedures. Added a common coefficient-uncertainty subsection before the first method estimate table: complete-history resampling, repeated estimation, standard errors, percentile intervals and the scope of uncertainty conditional on fictional links and measurement choices.

LP now explains trial capital coefficients, refitting productivity transitions and squared-error minimization before naming profiled nonlinear least squares. OP explains selection and the risk sample before its probability equation, preserving the absence of an eligible OP estimate. ACF explains independent labor variation, instruments, moments and rank checks in context. Wooldridge explains why its two equations have different errors and instruments, then states the shared-coefficient random-walk restriction before the implemented equations. Figure discussions explain what we calculate and interpret the actual coefficient, distribution and sensitivity patterns.

The source distinguishes the broader LP/ACF first-stage sample from the 2012 dynamic-stage sample: a record outside the latter may still have contributed to the first stage. Reader prose uses uncentered/centered residuals; the internal native equation label remains unchanged.

## Checks

Exact pre/post multisets match for all 40 placeholders, 18 complete equation environments, 49 semantic labels, 31 semantic references and 6 citations. All original digit-based numeric occurrences remain represented; added 95 percent wording explains the existing percentile interval rather than changing it. Data sections precede each method's estimation-procedure label. The edited source contains no standalone reader-facing use of native after removing semantic references. No estimator, data, sample, coefficient, chart operand or bootstrap calculation changed. This agent ran no estimation or build.

- Before SHA-256: `e4f58e7eb941bc04ed7c3fc0f7584468807beb35651cf8a5044fb8194b450e57`
- Edited SHA-256: `ae56922d27be49c4771c162873df228ca3752284fbf2b7eab9091e8410a342e2`

## Integration

The parent and other assigned agents own the introduction, common measurement discussion and generated exhibit prose. The template is frozen for the parent's build. Inspect pagination and PDF links after integration because the expanded explanation and moved data blocks change placements. Generated distribution prose must preserve the difference between records outside the dynamic-stage sample and records unused in all estimation stages. Generated OP prose must continue to distinguish its hypothetical estimation procedure from the absence of an admissible estimate. No commit or push by this agent.

## Compiled-text review

Timestamp: 2026-09-13T23:20:46.856751+07:00 (Asia/Jakarta). Read the common methods and method-specific explanation in the 76-page build, PDF SHA-256 `c2fb2553c341ea6de9b8a0b17ef8b96d30afe56d1b945c840f91f79cb5740119`, using the extracted reader text. The explanations now precede the operations they motivate, including proxy inversion, moments, profile estimation, coefficient uncertainty and the Wooldridge restriction. No new equation or identification concern found. Parent corrections concerning Wooldridge system-estimation sample, the uncertainty semantic label and the simultaneity explanation are present.

Reported two small final wording fixes to the parent without editing the frozen source: the generated OP source-table lead on page 32 says “to estimate OP” although no OP estimate exists; it should describe assessing OP requirements. The OP selection-equation opening says “this possibility” after intervening data pages; naming selective continuation restores the connection. Generated prediction prose explicitly limits first-stage participation of outside-fit observations to LP or ACF. Visual layout review remains with the parent.
