/*==========================================================================
  Line 2: "Desc stats by firms (domestic oriented vs export), pool dan yearly"
  Data  : Proman roster 2021-2022, by firm (data/b19_pm_firm.dta)
  Output sheets:
    t02_totals      total domestic vs exported production value, number of
                    firms by orientation, by year + pool
    t02_firm_stats  per-firm stats: domestic, exported and total production
                    value, export share (level & ln), pool + by year.
                    exp_share here includes domestic-only firms (= 0)
    t02_by_orient   same, by orientation: domestic only / mainly domestic
                    (exports <50% of production) / export-oriented (>=50%)

  NOTE: Kipb is masked in the sample files, so a "firm" is a cell
  (year x province x KBLI5) until the real data arrive (see 01b).
  Firms with an exported product whose share is unknown have no export
  value and no orientation; t02_totals counts them in n_share_unknown.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B19_DATA/b19_pm_firm.dta", clear
foreach v in val_domestic val_export val_prod {
    generate ln_`v' = ln(`v') if `v' > 0
}

* ---- 1. total domestic vs exported value (aggregate) ----
preserve
generate n_firms = 1
generate n_share_unknown = (n_unknown > 0)
generate n_domestic_only = (orient == 0)
generate n_mainly_domestic = (orient == 1)
generate n_export_oriented = (orient == 2)
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
* the value split uses firms with a known export value only
generate val_prod_known = val_prod if !missing(val_export)
collapse (sum) n_firms any_export n_domestic_only n_mainly_domestic n_export_oriented ///
         n_share_unknown val_domestic val_export val_prod_known, by(year)
generate pct_firms_export  = 100 * any_export / n_firms
generate share_domestic_pct = 100 * val_domestic / val_prod_known
generate share_export_pct   = 100 * val_export / val_prod_known
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_export pct_firms_export n_domestic_only n_mainly_domestic ///
      n_export_oriented n_share_unknown val_domestic val_export val_prod_known ///
      share_domestic_pct share_export_pct
drop year
list, clean noobs
export excel using "$B19_XLSX", sheet("t02_totals", replace) firstrow(variables)
restore

* ---- 2. per-firm statistics, pool + by year ----
local V "val_domestic val_export val_prod exp_share ln_val_domestic ln_val_export ln_val_prod"
do "$B19/_sumstats.do" "`V'" "" "t02_firm_stats"

* ---- 3. split by orientation ----
do "$B19/_sumstats.do" "`V'" "orient" "t02_by_orient"
