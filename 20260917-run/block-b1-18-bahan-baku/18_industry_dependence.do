/*==========================================================================
  Line 18: "industry dependence on imported materials"
  Per KBLI 2-digit sector:
    SI 2010-2022    : % firms importing, total imports / total raw materials
    Roster 2021-22  : % firms importing, imported / total raw material value
  Output sheets:
    t18_si_sector   per KBLI2 x period (pool + by year)
    t18_bb_sector   per KBLI2 x period (pool + by year)
  Chart: fig18 (drawn in 12_figures.do)
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- SI ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
* imports are summed only over firms with a positive raw-material value
generate imports_m = imports if materials > 0 & !missing(materials)
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_importer = importer imports_m materials, by(kbli2 year)
generate pct_importer = 100 * n_importer / n_firms
generate imp_over_mat = imports_m / materials
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms pct_importer imp_over_mat
keep  kbli2 period n_firms pct_importer imp_over_mat
export excel using "$B18_XLSX", sheet("t18_si_sector", replace) firstrow(variables)

* ---- roster ----
use "$B18_DATA/b18_bb_firm.dta", clear
keep if !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms any_import val_import val_total, by(kbli2 year)
generate pct_firms_import = 100 * any_import / n_firms
generate import_share     = val_import / val_total
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms pct_firms_import import_share
keep  kbli2 period n_firms pct_firms_import import_share val_import val_total
export excel using "$B18_XLSX", sheet("t18_bb_sector", replace) firstrow(variables)
