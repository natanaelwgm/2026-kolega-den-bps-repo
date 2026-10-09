/*==========================================================================
  Line 1: "Elaborate emisi scope 1, scope 2, dan total: dicek original value
           dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheets:
    t01_totals   by year + pool: n firms, % firms with any CO2, total CO2
                 scope 1 / scope 2 / total, scope 1 share of the total
    t01_stats    per-firm stats of scope 1, scope 2, total CO2 (level & ln)
                 and intensities, pool + by year
  Lines 2-11 repeat t01_stats, broken down by one variable each.

  Scope 1 = the 4 fuels asked in every year (diesel, petrol, coal, LPG).
  Scope 2 = purchased electricity (block 0 grid factor). Own generation is
  not in scope 2 (its fuel is scope 1 of the firm).
  NOTE: ln is missing for firms with zero emissions, so the ln rows have a
  smaller n. Energy reporting jumps between 2015 and 2017 (questionnaire
  change, not a trend). Values are masked development data.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 1. aggregate totals ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
generate n_firms = 1
generate any_co2 = (co2_total > 0 & !missing(co2_total))
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms any_co2 co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total, by(year)
generate pct_any_co2  = 100 * any_co2 / n_firms
generate s1_share_pct = 100 * co2_s1 / co2_total
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_co2 pct_any_co2 co2_s1 co2_s2 co2_total s1_share_pct gj_s1 gj_s2 gj_total
drop year
list period n_firms pct_any_co2 co2_s1 co2_s2 co2_total s1_share_pct, clean noobs
export excel using "$B17_XLSX", sheet("t01_totals", replace) firstrow(variables)

* ---- 2. per-firm statistics, level & ln, pool + by year ----
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
local V "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va ln_co2_per_va co2_pw co2_per_out"
do "$B17/_sumstats.do" "`V'" "" "t01_stats"
