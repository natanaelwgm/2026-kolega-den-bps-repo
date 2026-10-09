/*==========================================================================
  Line 3: "Export concentration index/ diversification of destinations"
  Data  : Proman roster 2021-2022 (data/b21b_pm_rows.dta), exported products
          with a named destination
  Measures (1 row = firm x year, saved to data/b21b_firm_conc.dta):
    n_dest      number of distinct destination countries
    n_regions   number of distinct regions (EU, US, China, ASEAN, Japan, India, Others)
    hhi_dest    HHI of export value across destination countries (0-1;
                1 = everything goes to one country). Only firms with a
                positive export value.
    hhi_region  the same across regions
  Output sheets:
    t03_firm_conc      stats of n_dest, n_regions, hhi_dest, hhi_region, pool + by year
    t03_ndest_dist     % of exporting firms with 1, 2, 3, 4, 5+ destinations
    t03_sector_conc    per KBLI 2-digit: firms, mean destinations, median firm
                       HHI, and the sector's own HHI across countries
    t03_national_conc  all exports: number of countries, HHI, top-1/3/5
                       country shares, HHI across regions, pool + by year
  Chart: fig03 (drawn in 05_figures.do)

  NOTE: Proman gives ONE main destination per product, so a firm with one
  product always has 1 destination and HHI = 1. With cells instead of firms
  (Kipb masked) a "firm" can hold several plants, so n_dest is higher than
  for a single plant. Read the pattern, not the level.
==========================================================================*/
if "$B21B" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B21B_DATA/b21b_pm_rows.dta", clear
keep if dest_country != ""
tempfile dest
save `dest'

* ---- firm level ----
* HHI across countries
collapse (sum) exp_value, by(firm_key year kbli2 dest_country)
bysort firm_key year: egen total = total(exp_value)
generate s2 = (exp_value / total)^2 if total > 0
collapse (count) n_dest = exp_value (sum) hhi_dest = s2 (max) total, by(firm_key year kbli2)
replace hhi_dest = . if !(total > 0)
drop total
tempfile firm
save `firm'
* HHI across regions
use `dest', clear
collapse (sum) exp_value, by(firm_key year region)
bysort firm_key year: egen total = total(exp_value)
generate s2 = (exp_value / total)^2 if total > 0
collapse (count) n_regions = exp_value (sum) hhi_region = s2 (max) total, by(firm_key year)
replace hhi_region = . if !(total > 0)
drop total
merge 1:1 firm_key year using `firm', nogenerate
label variable n_dest     "Number of destination countries"
label variable n_regions  "Number of destination regions"
label variable hhi_dest   "HHI of export value across countries (0-1)"
label variable hhi_region "HHI of export value across regions (0-1)"
order firm_key year kbli2 n_dest n_regions hhi_dest hhi_region
save "$B21B_DATA/b21b_firm_conc.dta", replace

do "$B21B/_sumstats.do" "n_dest n_regions hhi_dest hhi_region" "" "t03_firm_conc"

* ---- distribution of the number of destinations ----
use "$B21B_DATA/b21b_firm_conc.dta", clear
generate ndest_group = min(n_dest, 5)
label define ndest_group 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+"
label values ndest_group ndest_group
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms, by(ndest_group year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year ndest_group
order ndest_group period n_firms pct_firms
drop year total
export excel using "$B21B_XLSX", sheet("t03_ndest_dist", replace) firstrow(variables)

* ---- by sector: firm averages + the sector's own HHI ----
use "$B21B_DATA/b21b_firm_conc.dta", clear
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) mean_n_dest = n_dest (p50) med_hhi_firm = hhi_dest, by(kbli2 year)
tempfile sec_firm
save `sec_firm'
use `dest', clear
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) exp_value, by(kbli2 year dest_country)
bysort kbli2 year: egen total = total(exp_value)
generate s2 = (exp_value / total)^2 if total > 0
collapse (count) n_countries = exp_value (sum) hhi_sector = s2, by(kbli2 year)
merge 1:1 kbli2 year using `sec_firm', nogenerate
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms n_countries mean_n_dest med_hhi_firm hhi_sector
drop year
export excel using "$B21B_XLSX", sheet("t03_sector_conc", replace) firstrow(variables)

* ---- national: all exports together ----
use `dest', clear
expand 2, generate(copy)
replace year = 0 if copy == 1
preserve
collapse (sum) exp_value, by(year region)
bysort year: egen total = total(exp_value)
generate s2 = (exp_value / total)^2
collapse (sum) hhi_region = s2, by(year)
tempfile reg
save `reg'
restore
collapse (sum) exp_value, by(year dest_country)
bysort year: egen total = total(exp_value)
generate share = exp_value / total
gsort year -share
by year: generate rank = _n                     // 1 = largest destination
generate s2   = share^2
generate top1 = share * (rank == 1)
generate top3 = share * (rank <= 3)
generate top5 = share * (rank <= 5)
collapse (count) n_countries = share (sum) hhi_country = s2 top1 top3 top5, by(year)
merge 1:1 year using `reg', nogenerate
generate period = cond(year == 0, "pool", string(year))
order period n_countries hhi_country top1 top3 top5 hhi_region
drop year
list, clean noobs
export excel using "$B21B_XLSX", sheet("t03_national_conc", replace) firstrow(variables)
