# Including the G1 appendix

The continuous manuscript is `appendix.tex`. `main.tex` is only its standalone wrapper. `g1-appendix.sty` supplies namespaced headings, references, asset paths and scoped exhibit counters; it does not choose host fonts, margins, pages or appendix letters.

Load `g1-appendix.sty` on the host's TeX search path. The host also needs the bibliography commands used by the body (`natbib`), the chosen text/math fonts, and ordinary article-style section counters. For a subsection such as A.1:

```latex
\usepackage{g1-appendix}
\usepackage[authoryear,round]{natbib}
\renewcommand{\GOneBasePath}{appendices/g1}
\renewcommand{\GOneRootLevel}{2}
% The host chooses its appendix mode and enclosing section.
\appendix
\section{Supplementary analysis}
\input{appendices/g1/appendix.tex}
See Table~\ref{g1:tab:deep-lp-regression}.
```

`GOneRootLevel=1` places the root at section level; `2` places it at subsection level. Relative internal headings extend through the corresponding article hierarchy. No unsupported root level is silently accepted. The manuscript's deeper variable-source, year-coverage and transformation headings are relative too.

The default exhibit separator is a period, so root A.1 has figures A.1.1, A.1.2, etc. The standalone wrapper chooses an empty separator under root A, yielding A1, A2, etc. These are formatting choices outside the body. The host controls page numbering and the enclosing appendix letter.

Inside the body, use `GOneLabel`, `GOneRef`, `GOneEqref`, and `GOneInput`; they preserve the native label hooks and add the configurable `g1:` namespace. Outside the body, use the compiled full label, such as `g1:sec:lp` or `g1:eq:lp-objective`. No bare equation or exhibit number is embedded in prose. The package restores host figure, table, equation and heading-depth counters after the body, while preserving the host's ancestor section.

Run `python3 test_portability.py` from any directory for an actual two-pass host insertion test. It compiles the full body after main material and before another appendix, checks the nested root and representative equation/table/figure labels, and asserts restored counters. The PDF stays outside the repository; `provenance/portability-test.json` binds its exact sources, result and PDF hash. This is a formatting test, not a new empirical run.

The normal rebuild is:

```sh
python3 build_appendix.py
./build.sh
```

The builder reads `../release/outputs` and `../deep-release/outputs`; it formats released Stata aggregates and records source operands for numerical cells and prose. The build runs XeLaTeX twice in a temporary directory and replaces `G1-Appendix.pdf` only after successful compilation with no unresolved references, duplicate identifiers or overflowing boxes. `provenance/pdf-build.json` includes only the figures and tables actually referenced in the manuscript. Visual page inspection remains a separate check.
