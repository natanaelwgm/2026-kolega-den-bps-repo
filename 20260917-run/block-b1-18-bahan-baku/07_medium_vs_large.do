/*==========================================================================
  Line 7: "medium vs large"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t07_large_share       % large firms (>100 workers) among importers vs non-importers
    t07_by_size           importer rate and import share within each size group,
                          pool + by year
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are importers large? share of importers vs non-importers ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(large)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_large = large, by(importer year)
replace pct_large = 100 * pct_large
generate period = cond(year == 0, "pool", string(year))
sort importer year
order importer period n_firms pct_large
drop year
list if period == "pool", clean noobs
export excel using "$B18_XLSX", sheet("t07_large_share", replace) firstrow(variables)

* ---- B. importer rate and import share by large ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(large)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_importer = importer ///
         (p50) med_share_mat = imp_share_mat (mean) mean_share_mat = imp_share_mat, by(large year)
replace pct_importer = 100 * pct_importer
generate period = cond(year == 0, "pool", string(year))
sort large year
order large period n_firms pct_importer med_share_mat mean_share_mat
drop year
export excel using "$B18_XLSX", sheet("t07_by_size", replace) firstrow(variables)
