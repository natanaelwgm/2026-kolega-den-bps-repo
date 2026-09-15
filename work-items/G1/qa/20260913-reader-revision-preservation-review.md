# Reader-revision preservation review

Reviewed 2026-09-13T16:20:49.522465+00:00 against HEAD `15ae3739b5502f75475bc105fe3b385b8c294084`. Scope: eight authoring files and checks for changes to frozen inputs. No estimation, Stata execution or publication build was run.

## Result

All displayed equations are identical to HEAD. Every prior semantic label and every distinct source `@@token@@` remains present. Every source lookup, value, format, declared-value and plot-annotation call is unchanged, apart from the authorized display-label substitution from Native log to Uncentered log. The three table/prose builders have identical nontext Python abstract syntax trees after masking literal text.

Frozen data, analytical Stata sources, nominal/deep specifications, aggregate CSVs, source gates and the diagnostic validator show no changes against HEAD in this review. This statement concerns the current readability revision, not an assertion that earlier project work never changed those sources.

The manuscript removes one repeated introduction occurrence each of `@@rho_lpw@@` and `@@rho_lpa@@`; both results remain bound and displayed in the comparison section. Token occurrences fall from 43 to 41 without losing either result or its token definition. This is editorial reduction of repetition, not strict occurrence-by-occurrence preservation. The method chapter adds `sec:method-uncertainty`; no prior label disappears. Added inline symbols explain notation rather than modify displayed formulas.

The plot changes expand method names and adjust margins. All numeric annotation calls are unchanged. Independently reconstructing the old and new method-name pivots confirms the identical correlation heatmap matrix, including missing values and row order. Margin changes affect layout rather than analytical values.

## Scientific wording

- The revised explanation distinguishes Pearson linear association from equality of values, and Spearman association of ranks. Zero correlation is not presented as statistical independence.
- The 2012 dynamic-stage mean remains the centering reference for both years. Index ratios use the same sector and method. Means of logs, exponentials of mean logs, and means of exponentials remain distinct.
- Eligible 2011 and outside-dynamic 2012 records may contribute to LP/ACF first-stage regressions. A calculated residual neither creates a new pair nor re-estimates the model. The final dynamic sample still ends in 2012.
- Bootstrap descriptions retain complete fictional-history resampling, 99 draws, conditional inference, percentile intervals and wide ACF uncertainty. The coefficient-sum standard error retains labor-capital covariance rather than adding the separate standard errors.
- Wooldridge retains shared current/lagged proxy coefficients and a separate drift. The text preserves the random-walk special case and does not substitute a general productivity transition.
- The nominal-price and fictional-identity limitations remain explicit. Later source availability does not automatically expand the declared construction history or create more estimation years.

## Corrections raised

The revised OP figure note initially called the selection-risk denominator a continuation sample of links. I reported that unmatched assignments also contribute risk intervals. The root confirmed a correction to a selection sample including eligible assignments absent the following year, before production restrictions.

I also recommended replacing the Wooldridge residual-section phrase “2012 second-stage sample” with “2012 dynamic sample” or “2012 system-estimation sample.” Its equations use the same jointly estimated sample; two-step GMM weighting should not be confused with LP/ACF sample stages. This is a terminology recommendation, not a numerical discrepancy.

## Integration boundary

This is authoring-source preservation review. The root reported that a draft compilation was rejected for overflow and did not replace the visible PDF. This review therefore does not certify a revised PDF, final pagination, or refreshed publication hashes. The successful final build must verify added cross-references and their targets. File hashes below identify the exact source snapshots reviewed; later changes require the corresponding focused check.

Reviewed snapshots:

- `manuscript-template.tex` — `7b228d1a2dcd4850fd989149b16015a05afdac9d05a351f35ac06997ae1a329a`; 7 displayed equation blocks and 21 prior semantic labels preserved.
- `method-chapters-template.tex` — `b77089f9c4121013968a17a664fc3359f83b69608381e8d2d9f14759da3bebf9`; 18 displayed equation blocks and 49 prior semantic labels preserved.
- `deep_publication.py` — `b29cd02bdc0791d8c58636c3cb650d2dc573f6af1cf56c34cec6504dd51dfaec`; 0 displayed equation blocks and 7 prior semantic labels preserved; 67 binding/annotation calls unchanged.
- `build_appendix.py` — `7e4de783c918df76b04d46c123478d848a9c38f37faee85cd208f74586a43bc5`; 0 displayed equation blocks and 2 prior semantic labels preserved; 38 binding/annotation calls unchanged.
- `method_tables.py` — `b73dedcf86fec6051c19fff9b365d3e8f026b11c5538712b2bcc0f51b69e5b17`; 0 displayed equation blocks and 3 prior semantic labels preserved; 22 binding/annotation calls unchanged.
- `plot_figures.py` — `ef34788c92258efef835dc9f913cc8c17c9702ce0b88a1e179f60b65f496f88c`; 0 displayed equation blocks and 0 prior semantic labels preserved; 8 binding/annotation calls unchanged.
- `plot_deep_figures.py` — `45f1aee89ab77ddcad1ce815a97b69e9878553249a917377d5c61b8a52ce50dc`; 0 displayed equation blocks and 0 prior semantic labels preserved; 11 binding/annotation calls unchanged.
- `main.tex` — `219befc696a1338b1d38b61e869b8a07fcc700230fd94873d9c523cd2fd6d764`; 0 displayed equation blocks and 0 prior semantic labels preserved.
