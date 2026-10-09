/*==========================================================================
  Line 9: "Carbon productivity (VA/CO2)"
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t09_total      all manufacturing: carbon productivity VA/CO2,
                   as an AGGREGATE ratio: total VA / total CO2;
                   pool + by year, index 2010 = 100 and ln
    t09_by_kbli2   the same per KBLI 2-digit sector, pool + by year
    t09_firm_stats distribution across firms (n mean sd p10-p90 min max),
                   level and ln, pool + by year
  This is the inverse of CO2/VA (line 7). Firm level: only firms with
  CO2 > 0.

  The aggregate ratio is what "manufacturing as a whole" did; the firm
  distribution shows the typical firm (big emitters weigh less there).
  "pool" = the sums over all years put together.
  NOTE: VA is nominal and masked, so a change can be price inflation
  rather than cleaner production. Energy = scope 1 fuels (diesel, petrol, coal, LPG)
  + purchased electricity; CO2 = scope 1 + scope 2 (see 04, 05). Energy
  reporting changes between 2015 and 2017. There is no 2016 survey.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. aggregate ratio: all manufacturing and per sector ----
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
generate n_firms = 1
expand 2, generate(copy_s)            // copy of every row as sector 0 = all manufacturing
replace kbli2 = 0 if copy_s == 1
expand 2, generate(copy_y)            // copy of every row with year = 0 for "pool"
replace year = 0 if copy_y == 1
collapse (sum) n_firms va co2_total, by(kbli2 year)
generate va_per_co2 = va / co2_total if co2_total > 0
foreach v in va_per_co2 {
    egen base = total(cond(year == 2010, `v', .)), by(kbli2)
    generate idx_`v' = 100 * `v' / base if base > 0 & year > 0
    generate ln_`v'  = ln(`v') if `v' > 0
    drop base
}
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms va co2_total va_per_co2
drop year

preserve
keep if kbli2 == 0
drop kbli2
list period n_firms va_per_co2, clean noobs
export excel using "$B201_XLSX", sheet("t09_total", replace) firstrow(variables)
restore
keep if kbli2 > 0
export excel using "$B201_XLSX", sheet("t09_by_kbli2", replace) firstrow(variables)

* ---- B. distribution across firms ----
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
do "$B201/_sumstats.do" "va_per_co2 ln_va_per_co2" "" "t09_firm_stats"
