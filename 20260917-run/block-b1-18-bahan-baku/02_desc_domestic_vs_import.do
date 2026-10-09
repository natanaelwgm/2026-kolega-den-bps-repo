/*==========================================================================
  Line 2: "Desc stats by firms (domestic sourcing vs imports), pool dan yearly"
  Data  : Bahan Baku roster 2021-2022 (data/b18_bb_rows.dta)
  Output sheets:
    t02_totals       total domestic vs imported raw material value, by year + pool
    t02_firm_stats   per-firm stats: domestic, imported, total value and import
                     share (level & ln), pool + by year
    t02_by_importer  same, split into firms that import vs firms that do not
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_bb_rows.dta", clear

* ---- from material rows to firms (firm_key x year) ----
collapse (sum) val_local val_import val_total, by(firm_key year)
generate import_share = val_import / val_total
generate any_import   = (val_import > 0)
label define any_import 0 "Non-importer" 1 "Importer"
label values any_import any_import
foreach v in val_local val_import val_total {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- 1. total domestic vs imported value (aggregate) ----
preserve
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms any_import val_local val_import val_total, by(year)
generate share_local_pct  = 100 * val_local / val_total
generate share_import_pct = 100 * val_import / val_total
generate pct_firms_import = 100 * any_import / n_firms
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_import pct_firms_import val_local val_import val_total share_local_pct share_import_pct
drop year
list, clean noobs
export excel using "$B18_XLSX", sheet("t02_totals", replace) firstrow(variables)
restore

* ---- 2. per-firm statistics, pool + by year ----
local V "val_local val_import val_total import_share ln_val_local ln_val_import ln_val_total"
do "$B18/_sumstats.do" "`V'" "" "t02_firm_stats"

* ---- 3. split: firms that import vs firms that do not ----
do "$B18/_sumstats.do" "`V'" "any_import" "t02_by_importer"
