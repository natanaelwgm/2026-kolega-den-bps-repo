/*==========================================================================
  Line 5: "own generated electricity"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Output sheets:
    t05_kwh_stats   own-generated kWh, level and ln, OWN-GENERATORS ONLY
                    (n mean sd p10-p90 min max), pool + by year
    t05_totals      by year + pool: total own-generated kWh, total purchased
                    kWh (firms asked), and own kWh as % of all electricity
  NOTE: kWh are masked in the development data: read the pattern, not levels.
  The mean is driven by a few very large self-generators; use the median.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
* ---- distribution among own-generators ----
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1 & has_owngen == 1
do "$B206/_sumstats.do" "own_kwh ln_own_kwh" "" "t05_kwh_stats"

* ---- totals ----
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1 & !missing(has_owngen)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_owngen = has_owngen own_kwh purch_kwh, by(year)
generate pct_own_of_all = 100 * own_kwh / (own_kwh + purch_kwh)
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_owngen own_kwh purch_kwh pct_own_of_all
drop year
list, clean noobs
export excel using "$B206_XLSX", sheet("t05_totals", replace) firstrow(variables)
