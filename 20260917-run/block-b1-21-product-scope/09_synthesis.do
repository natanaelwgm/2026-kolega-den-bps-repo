/*==========================================================================
  Line 9: "Questions: apakah internationalisation mengubah what firms
           produce?"
  No new computation: collects the pooled evidence of lines 4 and 8 into
  one sheet, internationalised group (exporter / importer / FDI) next to
  the comparison group.
  Output sheet:
    t09_synthesis   1 row = split x measure:
                    mean_0 / mean_1 (comparison / internationalised group),
                    gap = mean_1 - mean_0, medians, number of firms
  HOW TO READ IT:
    - Lines 2/3/5/6/7 rows compare DIFFERENT firms (between-firm); they say
      whether internationalised firms produce differently, not that
      internationalisation changed what they produce.
    - Line 4 rows (entry/exit 2021->2022 by 2021 status) are the only
      within-firm evidence: do internationalised firms add or drop more
      products? With firm = cell (Kipb masked) this is weak; and one year
      is short. A real answer needs the real Kipb and more roster years.
    - The SI product-innovation rows (2017-2018) are self-reported.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
tempfile stack
clear
save `stack', emptyok

* ---- lines 2, 3, 5, 6, 7 (between firms) ----
foreach s in exporter importer fdi {
    import excel using "$B21_XLSX", sheet("t08_by_`s'") firstrow clear
    keep if period == "pool"
    generate g = inlist(group, "Exporter", "Importer", "FDI")
    keep variable g n mean p50
    reshape wide n mean p50, i(variable) j(g)
    generate split = "`s'"
    generate evidence = "Lines 2-7: between firms, roster 2021-2022 pooled"
    append using `stack'
    save `stack', replace
}

* ---- line 4 (within firm, 2021 -> 2022) ----
import excel using "$B21_XLSX", sheet("t08_entry_exit") firstrow clear
generate g = inlist(group, "Exporter", "Importer", "FDI")
rename n_firms n
foreach v in pct_adding pct_dropping mean_n_added mean_n_dropped mean_share_val_new mean_share_val_dropped {
    rename `v' m_`v'
}
keep split g n m_*
reshape long m_, i(split g) j(variable) string
rename m_ mean
reshape wide n mean, i(split variable) j(g)
generate evidence = "Line 4: product entry/exit 2021->2022 by 2021 status"
append using `stack'
save `stack', replace

* ---- SI product innovation (2017-2018 pooled) ----
import excel using "$B21_XLSX", sheet("t08_si_prod_innov") firstrow clear
keep if period == "pool"
generate g = inlist(group, "Exporter", "Importer", "FDI")
rename (n_firms pct_prod_innov) (n mean)
generate variable = "pct_prod_innov"
keep split g variable n mean
reshape wide n mean, i(split variable) j(g)
generate evidence = "SI 2017-2018: % plants with product innovation"
append using `stack'

* ---- tidy ----
generate comparison = "Exporter vs non-exporter" if split == "exporter"
replace  comparison = "Importer vs non-importer" if split == "importer"
replace  comparison = "FDI vs domestic"          if split == "fdi"
generate gap = mean1 - mean0
rename (mean0 mean1 p500 p501 n0 n1) (mean_0 mean_1 median_0 median_1 n_0 n_1)
generate order_ev = 1 if substr(evidence, 1, 7) == "Lines 2"
replace  order_ev = 2 if substr(evidence, 1, 6) == "Line 4"
replace  order_ev = 3 if substr(evidence, 1, 2) == "SI"
sort order_ev split variable
keep evidence comparison variable mean_0 mean_1 gap median_0 median_1 n_0 n_1
order evidence comparison variable mean_0 mean_1 gap median_0 median_1 n_0 n_1
list evidence comparison variable mean_0 mean_1 gap, clean noobs
export excel using "$B21_XLSX", sheet("t09_synthesis", replace) firstrow(variables)
