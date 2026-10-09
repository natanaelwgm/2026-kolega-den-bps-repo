/*==========================================================================
  Line 5: "apakah mereka fdi firms"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Two ways to read the question, one sheet each:
    t05_fdi_share         % FDI among importers vs non-importers
    t05_by_fdi            importer rate and import share within each FDI / domestic group,
                          pool + by year

  NOTE: 2020 FDI is set missing (see 01a), so 2020 is not in these tables.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are importers fdi? share of importers vs non-importers ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(fdi)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi, by(importer year)
replace pct_fdi = 100 * pct_fdi
generate period = cond(year == 0, "pool", string(year))
sort importer year
order importer period n_firms pct_fdi
drop year
list if period == "pool", clean noobs
export excel using "$B18_XLSX", sheet("t05_fdi_share", replace) firstrow(variables)

* ---- B. importer rate and import share by fdi ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(fdi)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_importer = importer ///
         (p50) med_share_mat = imp_share_mat (mean) mean_share_mat = imp_share_mat, by(fdi year)
replace pct_importer = 100 * pct_importer
generate period = cond(year == 0, "pool", string(year))
sort fdi year
order fdi period n_firms pct_importer med_share_mat mean_share_mat
drop year
export excel using "$B18_XLSX", sheet("t05_by_fdi", replace) firstrow(variables)
