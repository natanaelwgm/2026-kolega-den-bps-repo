/*==========================================================================
  Line 3: "Sectors disic 2 dan disic 5"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheets:
    t03_kbli2_share   total CO2 per KBLI 2-digit and its share of all CO2,
                      pool + by year
    t03_by_kbli2      CO2 scope 1 / 2 / total (level & ln), intensities,
                      per KBLI 2-digit, pool + by year
    t03_by_kbli5      the same per KBLI 5-digit, pooled only (too many cells
                      for by year): n, total, mean, median
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"

* ---- A. which sectors emit the most ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms co2_s1 co2_s2 co2_total, by(kbli2 year)
bysort year: egen co2_all = total(co2_total)
generate share_of_co2_pct = 100 * co2_total / co2_all
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms co2_s1 co2_s2 co2_total share_of_co2_pct
drop year co2_all
export excel using "$B17_XLSX", sheet("t03_kbli2_share", replace) firstrow(variables)

* ---- B. KBLI 2-digit, pool + by year ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
do "$B17/_sumstats.do" "`EMIS'" "kbli2" "t03_by_kbli2"

* ---- C. KBLI 5-digit, pooled ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1 & kbli5 != ""
generate n_firms = 1
collapse (sum) n_firms sum_co2_s1 = co2_s1 sum_co2_s2 = co2_s2 sum_co2_total = co2_total ///
         (mean) mean_co2_s1 = co2_s1 mean_co2_s2 = co2_s2 mean_co2_total = co2_total ///
                mean_ln_co2_s1 = ln_co2_s1 mean_ln_co2_s2 = ln_co2_s2 mean_ln_co2_total = ln_co2_total ///
         (p50)  med_co2_total = co2_total med_co2_per_va = co2_per_va, by(kbli5)
egen co2_all = total(sum_co2_total)
generate share_of_co2_pct = 100 * sum_co2_total / co2_all
drop co2_all
generate period = "pool"
order kbli5 period n_firms
gsort -sum_co2_total
list kbli5 n_firms sum_co2_total share_of_co2_pct in 1/10, clean noobs
export excel using "$B17_XLSX", sheet("t03_by_kbli5", replace) firstrow(variables)
