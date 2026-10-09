/*==========================================================================
  Line 6: "apakah mereka exporting firms"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t06_exporter_share    % exporters among importers vs non-importers
    t06_by_exporter       importer rate and import share within each exporter / non-exporter group,
                          pool + by year

  NOTE: the 2022 export flag is set missing (see 01a), so 2022 is not in
  these tables.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are importers exporter? share of importers vs non-importers ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(exporter)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_exporter = exporter, by(importer year)
replace pct_exporter = 100 * pct_exporter
generate period = cond(year == 0, "pool", string(year))
sort importer year
order importer period n_firms pct_exporter
drop year
list if period == "pool", clean noobs
export excel using "$B18_XLSX", sheet("t06_exporter_share", replace) firstrow(variables)

* ---- B. importer rate and import share by exporter ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(exporter)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_importer = importer ///
         (p50) med_share_mat = imp_share_mat (mean) mean_share_mat = imp_share_mat, by(exporter year)
replace pct_importer = 100 * pct_importer
generate period = cond(year == 0, "pool", string(year))
sort exporter year
order exporter period n_firms pct_importer med_share_mat mean_share_mat
drop year
export excel using "$B18_XLSX", sheet("t06_by_exporter", replace) firstrow(variables)
