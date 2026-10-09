/*==========================================================================
  Line 6: "apakah mereka importing firms"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t06_importer_share  % importers (of raw materials) among exporters vs
                        non-exporters
    t06_by_importer     exporter rate and export share (exporters with a
                        reported share) within each importer / non-importer
                        group, pool + by year

  NOTE: the 2022 export flag is set missing (see 01a), so 2022 is not in
  these tables. The importer rate jumps between 2015 and 2017
  (questionnaire change, not a trend).
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are exporters importers? share of exporters vs non-exporters ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exporter) & !missing(importer)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_importer = importer, by(exporter year)
replace pct_importer = 100 * pct_importer
generate period = cond(year == 0, "pool", string(year))
sort exporter year
order exporter period n_firms pct_importer
drop year
list if period == "pool", clean noobs
export excel using "$B19_XLSX", sheet("t06_importer_share", replace) firstrow(variables)

* ---- B. exporter rate and export share by importer ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(exporter)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_exporter = exporter (count) n_share = exp_share ///
         (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(importer year)
replace pct_exporter = 100 * pct_exporter
generate period = cond(year == 0, "pool", string(year))
sort importer year
order importer period n_firms pct_exporter n_share med_exp_share mean_exp_share
drop year
export excel using "$B19_XLSX", sheet("t06_by_importer", replace) firstrow(variables)
