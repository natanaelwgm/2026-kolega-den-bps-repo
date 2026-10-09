/*==========================================================================
  Line 3: "Product concentration/HHI"
  Data  : Proman roster 2021-2022 (data/b21_pm_firm.dta)
          hhi = sum over the firm's products of (product value / firm's
          production value)^2. 1 = single product; near 0 = many products of
          similar size. eff_n_products = 1 / hhi.
  Output sheets:
    t03_hhi          stats of hhi and eff_n_products, pool + by year
    t03_single       % single-product firms (hhi = 1) and % diversified
                     firms (hhi < 0.5), pool + by year
  NOTE: firm = cell (province x KBLI5) until Kipb is available.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B21_DATA/b21_pm_firm.dta", clear
do "$B21/_sumstats.do" "hhi eff_n_products" "" "t03_hhi"

generate single      = (n_products == 1)
generate diversified = (hhi < 0.5)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_single = single pct_diversified = diversified ///
         (p50) med_hhi = hhi, by(year)
replace pct_single      = 100 * pct_single
replace pct_diversified = 100 * pct_diversified
generate period = cond(year == 0, "pool", string(year))
order period n_firms pct_single pct_diversified med_hhi
drop year
list, clean noobs
export excel using "$B21_XLSX", sheet("t03_single", replace) firstrow(variables)
