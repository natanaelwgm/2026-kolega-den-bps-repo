/*==========================================================================
  Line 3: "Sectors disic 2 dan disic 5"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t03_kbli2_share  firms, GJ scope 1 / 2 / total and % of all GJ per KBLI 2-digit, pool + by year
    t03_by_kbli2     GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, per KBLI 2-digit, pool + by year
    t03_by_kbli5     per KBLI 5-digit (pooled only): firms, sums, means, medians, % of all GJ

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"

* ---- A. which sectors use the most energy ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms gj_s1 gj_s2 gj_total, by(kbli2 year)
bysort year: egen gj_all = total(gj_total)
generate share_of_gj_pct = 100 * gj_total / gj_all
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms gj_s1 gj_s2 gj_total share_of_gj_pct
drop year gj_all
export excel using "$B16_XLSX", sheet("t03_kbli2_share", replace) firstrow(variables)

* ---- B. KBLI 2-digit, pool + by year ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
do "$B16/_sumstats.do" "`ENERGY'" "kbli2" "t03_by_kbli2"

* ---- C. KBLI 5-digit, pooled ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1 & kbli5 != ""
generate n_firms = 1
collapse (sum) n_firms sum_gj_s1 = gj_s1 sum_gj_s2 = gj_s2 sum_gj_total = gj_total ///
         (mean) mean_gj_s1 = gj_s1 mean_gj_s2 = gj_s2 mean_gj_total = gj_total ///
                mean_ln_gj_s1 = ln_gj_s1 mean_ln_gj_s2 = ln_gj_s2 mean_ln_gj_total = ln_gj_total ///
         (p50)  med_gj_total = gj_total med_gj_per_va = gj_per_va, by(kbli5)
egen gj_all = total(sum_gj_total)
generate share_of_gj_pct = 100 * sum_gj_total / gj_all
drop gj_all
generate period = "pool"
order kbli5 period n_firms
gsort -sum_gj_total
list kbli5 n_firms sum_gj_total share_of_gj_pct in 1/10, clean noobs
export excel using "$B16_XLSX", sheet("t03_by_kbli5", replace) firstrow(variables)
