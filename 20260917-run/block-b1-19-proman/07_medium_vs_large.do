/*==========================================================================
  Line 7: "medium vs large"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t07_large_share   % large firms (>100 workers) among exporters vs
                      non-exporters
    t07_by_size       exporter rate and export share (exporters with a
                      reported share) within each size group, pool + by year

  NOTE: the 2022 export flag is set missing (see 01a), so 2022 is not in
  these tables.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are exporters large? share of exporters vs non-exporters ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exporter) & !missing(large)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_large = large, by(exporter year)
replace pct_large = 100 * pct_large
generate period = cond(year == 0, "pool", string(year))
sort exporter year
order exporter period n_firms pct_large
drop year
list if period == "pool", clean noobs
export excel using "$B19_XLSX", sheet("t07_large_share", replace) firstrow(variables)

* ---- B. exporter rate and export share by size ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(large) & !missing(exporter)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_exporter = exporter (count) n_share = exp_share ///
         (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(large year)
replace pct_exporter = 100 * pct_exporter
generate period = cond(year == 0, "pool", string(year))
sort large year
order large period n_firms pct_exporter n_share med_exp_share mean_exp_share
drop year
export excel using "$B19_XLSX", sheet("t07_by_size", replace) firstrow(variables)
