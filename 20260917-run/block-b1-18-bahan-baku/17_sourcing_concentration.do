/*==========================================================================
  Line 17: "concentration of imported sourcing"
  Data  : Bahan Baku roster 2021-2022
  Two levels:
    firm     : origin_hhi = HHI of imported value across origin countries (0-1)
               n_origins  = number of origin countries
               (built in 13; only firms with a reported origin country)
    national : HHI and share of the top-1 / top-3 / top-5 countries,
               by year + pool
  Output sheets:
    t17_firm_hhi       stats of origin_hhi & n_origins, pool + by year
    t17_national_conc  national concentration
  NOTE: origin country is reported for only part of the imports (see
  t11_coverage).
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- firm level ----
use "$B18_DATA/b18_bb_firm.dta", clear
keep if n_origins > 0
do "$B18/_sumstats.do" "origin_hhi n_origins" "" "t17_firm_hhi"

* ---- national level ----
use "$B18_DATA/b18_bb_rows.dta", clear
keep if imported == 1 & origin_name != "(not reported)"
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) val_import, by(year origin_name)
bysort year: egen total = total(val_import)
generate share = val_import / total
gsort year -share
by year: generate rank = _n                     // 1 = largest origin country
generate s2   = share^2
generate top1 = share * (rank == 1)
generate top3 = share * (rank <= 3)
generate top5 = share * (rank <= 5)
collapse (sum) hhi = s2 top1 top3 top5 (count) n_countries = share, by(year)
generate period = cond(year == 0, "pool", string(year))
order period n_countries hhi top1 top3 top5
drop year
list, clean noobs
export excel using "$B18_XLSX", sheet("t17_national_conc", replace) firstrow(variables)
