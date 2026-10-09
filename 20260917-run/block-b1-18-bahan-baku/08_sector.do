/*==========================================================================
  Line 8: "sector"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Output sheets:
    t08_sector_mix      which sectors (KBLI 2-digit) importers vs non-importers
                        are in: % of firms per sector, pool + by year
    t08_by_kbli2        importer rate and import share per KBLI 2-digit,
                        pool + by year
    t08_by_kbli5        same per KBLI 5-digit, pooled only
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. sector composition of importers vs non-importers ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(importer year kbli2)
bysort importer year: egen total = total(n_firms)
generate pct_of_group = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort importer year kbli2
order importer period kbli2 n_firms pct_of_group
drop year total
export excel using "$B18_XLSX", sheet("t08_sector_mix", replace) firstrow(variables)

* ---- B. importer rate and import share per sector ----
* loop: once for KBLI 2-digit (pool + by year), once for KBLI 5-digit (pool only)
foreach s in kbli2 kbli5 {
    use "$B18_DATA/b18_si.dta", clear
    keep if clean == 1 & !missing(`s')
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    if "`s'" == "kbli5" keep if year == 0
    collapse (sum) n_firms (mean) pct_importer = importer ///
             (p50) med_share_mat = imp_share_mat (mean) mean_share_mat = imp_share_mat, by(`s' year)
    replace pct_importer = 100 * pct_importer
    generate period = cond(year == 0, "pool", string(year))
    sort `s' year
    order `s' period n_firms pct_importer med_share_mat mean_share_mat
    drop year
    export excel using "$B18_XLSX", sheet("t08_by_`s'", replace) firstrow(variables)
}
