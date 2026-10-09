/*==========================================================================
  Line 5: "Main/core product share"
  Data  : Proman roster 2021-2022 (data/b21_pm_firm.dta)
          core_share = value of the firm's largest product / the firm's
          total production value (0-1)
  Output sheets:
    t05_core_share   stats of core_share, pool + by year, for all firms and
                     for multi-product firms only (single-product firms have
                     core_share = 1 by definition)
    t05_core_bins    % of firms whose core product is <50%, 50-75%, 75-90%,
                     90-99% and 100% of production value
  NOTE: firm = cell (province x KBLI5) until Kipb is available.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B21_DATA/b21_pm_firm.dta", clear
generate firms = 1 + (n_products > 1)
label define firms 1 "Single-product" 2 "Multi-product"
label values firms firms
* the same firms twice: once as "All firms", once in their own group
expand 2, generate(copy_all)
replace firms = 0 if copy_all == 1
label define firms 0 "All firms", add
do "$B21/_sumstats.do" "core_share" "firms" "t05_core_share"

use "$B21_DATA/b21_pm_firm.dta", clear
generate core_bin = 1 if core_share < 0.5
replace  core_bin = 2 if core_share >= 0.5  & core_share < 0.75
replace  core_bin = 3 if core_share >= 0.75 & core_share < 0.9
replace  core_bin = 4 if core_share >= 0.9  & core_share < 0.99999
replace  core_bin = 5 if core_share >= 0.99999
label define core_bin 1 "<50%" 2 "50-75%" 3 "75-90%" 4 "90-99%" 5 "100%"
label values core_bin core_bin
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(core_bin year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year core_bin
keep period core_bin n_firms pct_firms
order period core_bin
list if period == "pool", clean noobs
export excel using "$B21_XLSX", sheet("t05_core_bins", replace) firstrow(variables)
