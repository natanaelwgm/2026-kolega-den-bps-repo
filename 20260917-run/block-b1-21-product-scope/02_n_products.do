/*==========================================================================
  Line 2: "Construct n-number of product per firms"
  Data  : Proman roster 2021-2022 (data/b21_pm_firm.dta, built in 01b)
          n_products = number of distinct products (KBKI code, or the name
          when the code is blank) a firm produces in a year
  Output sheets:
    t02_n_products  n / mean / sd / percentiles of n_products and its ln,
                    pool + 2021 + 2022
    t02_dist        % of firms with 1, 2, 3, 4-5, 6-10, 11+ products
  NOTE: Kipb is masked, so a "firm" is a cell (province x KBLI5). A cell
        holds several plants, so n_products is too high compared with real
        firms. With the real data (Kipb) this becomes a firm count.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B21_DATA/b21_pm_firm.dta", clear
do "$B21/_sumstats.do" "n_products ln_n_products" "" "t02_n_products"

* ---- distribution in bins ----
generate nbin = n_products
replace  nbin = 4 if inrange(n_products, 4, 5)
replace  nbin = 6 if inrange(n_products, 6, 10)
replace  nbin = 11 if n_products >= 11
label define nbin 1 "1" 2 "2" 3 "3" 4 "4-5" 6 "6-10" 11 "11+"
label values nbin nbin
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(nbin year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year nbin
decode nbin, generate(n_products)
keep period n_products n_firms pct_firms
order period n_products n_firms pct_firms
list, clean noobs
export excel using "$B21_XLSX", sheet("t02_dist", replace) firstrow(variables)
