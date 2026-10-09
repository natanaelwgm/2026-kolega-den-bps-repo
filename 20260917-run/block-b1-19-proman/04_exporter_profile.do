/*==========================================================================
  Line 4: "karakteristik firms yang export:"
  This line is the heading for lines 5-11, which each have their own file.
  This file gives the one-table overview: who are the exporting firms,
  compared with those that do not export.

  Export intensity groups (SI, exp_group made in 01a):
    0 Non-exporter
    1 Low intensity   exports < 50% of output
    2 High intensity  exports >= 50% of output
    3 Exporter whose export share is not reported (most exporters: the
      share is missing in 2015 and 2017 and often blank in other years)
  (change the 50 cut-off in 01a if needed)

  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1. 2022 has no
          exporter flag (see 01a), so it is not in this table.
  Output sheet:
    t04_profile   by intensity group x period (pool + by year):
                  n firms, % FDI, % importer, % large, % Java,
                  median VA per worker, median workers
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exp_group)

generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi pct_importer = importer pct_large = large pct_java = java ///
         (p50) med_va_pw = va_pw med_workers = workers, by(exp_group year)
foreach v in pct_fdi pct_importer pct_large pct_java {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
sort exp_group year
order exp_group period n_firms pct_fdi pct_importer pct_large pct_java med_va_pw med_workers
drop year
list if period == "pool", clean noobs
export excel using "$B19_XLSX", sheet("t04_profile", replace) firstrow(variables)
