/*==========================================================================
  Line 6: "share own electricity thd total electricity"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Share = own-generated kWh / (own-generated + purchased kWh), 0-1.
  Output sheets:
    t06_share_stats   share, OWN-GENERATORS ONLY (with non-generators the
                      median is 0), pool + by year
    t06_share_bands   own-generators by share band: <10% (standby-like),
                      10-50%, 50-90%, >=90% (nearly off-grid), pool + by year
  The aggregate share (all own kWh / all kWh) is in t05_totals.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B206_DATA/b206_si.dta", clear
keep if clean == 1 & has_owngen == 1 & !missing(owngen_share)
do "$B206/_sumstats.do" "owngen_share" "" "t06_share_stats"

* ---- share bands ----
generate band = 1 if owngen_share < 0.10
replace  band = 2 if owngen_share >= 0.10 & owngen_share < 0.50
replace  band = 3 if owngen_share >= 0.50 & owngen_share < 0.90
replace  band = 4 if owngen_share >= 0.90
generate b1 = (band == 1)
generate b2 = (band == 2)
generate b3 = (band == 3)
generate b4 = (band == 4)
generate n_owngen = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_owngen (mean) pct_lt10 = b1 pct_10_50 = b2 pct_50_90 = b3 pct_ge90 = b4, by(year)
foreach v in pct_lt10 pct_10_50 pct_50_90 pct_ge90 {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
order period n_owngen pct_lt10 pct_10_50 pct_50_90 pct_ge90
drop year
list, clean noobs
export excel using "$B206_XLSX", sheet("t06_share_bands", replace) firstrow(variables)
