/*==========================================================================
  Line 5: "apakah mereka fdi firms"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t05_fdi_share   % FDI among exporters vs non-exporters
    t05_by_fdi      exporter rate and export share (exporters with a reported
                    share) within each FDI / domestic group, pool + by year

  NOTE: 2020 FDI and the 2022 export flag are set missing (see 01a), so
  2020 and 2022 are not in these tables.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are exporters fdi? share of exporters vs non-exporters ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exporter) & !missing(fdi)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi, by(exporter year)
replace pct_fdi = 100 * pct_fdi
generate period = cond(year == 0, "pool", string(year))
sort exporter year
order exporter period n_firms pct_fdi
drop year
list if period == "pool", clean noobs
export excel using "$B19_XLSX", sheet("t05_fdi_share", replace) firstrow(variables)

* ---- B. exporter rate and export share by fdi ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(fdi) & !missing(exporter)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_exporter = exporter (count) n_share = exp_share ///
         (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(fdi year)
replace pct_exporter = 100 * pct_exporter
generate period = cond(year == 0, "pool", string(year))
sort fdi year
order fdi period n_firms pct_exporter n_share med_exp_share mean_exp_share
drop year
export excel using "$B19_XLSX", sheet("t05_by_fdi", replace) firstrow(variables)
