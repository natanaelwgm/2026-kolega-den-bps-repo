/*==========================================================================
  Line 15: "number/variety of imported inputs"
  Data  : Bahan Baku roster 2021-2022 (data/b18_bb_firm.dta, from 13)
  Output sheets:
    t15_variety_stats  n_items_imp, n_items, share_items_imp; importers only,
                       pool + by year
    t15_variety_dist   distribution of the number of imported materials
                       (1, 2, 3, 4, 5+), pool + by year
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_bb_firm.dta", clear
keep if any_import == 1

do "$B18/_sumstats.do" "n_items_imp n_items share_items_imp" "" "t15_variety_stats"

* ---- distribution ----
generate n_imp_cat = min(n_items_imp, 5)
label define n_imp_cat 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+"
label values n_imp_cat n_imp_cat
generate one = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms = one, by(n_imp_cat year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year n_imp_cat
order period n_imp_cat n_firms pct_firms
drop year total
list, clean noobs
export excel using "$B18_XLSX", sheet("t15_variety_dist", replace) firstrow(variables)
