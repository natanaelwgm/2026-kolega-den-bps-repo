/*==========================================================================
  Line 9: "Create gini/Lorenz curve untuk emission"
  Data  : SI 2010-2022 (data/b203_si.dta), clean == 1 and CO2 > 0
  Method (no user-written package; sort, sum and generate only):
    - sort plants from smallest to largest emitter within the year,
      i = rank (1 = smallest), n = plants, x = CO2
    - Lorenz curve: cumulative share of CO2 held by the smallest p% of plants
    - Gini = 2 x sum(i x x_i) / (n x sum x) - (n + 1) / n
      (0 = every plant emits the same, 1 = one plant emits everything)
    Pool = all plant-years 2010-2022 treated as one distribution.
  Output sheets:
    t09_gini      Gini by year + pool, with n plants and total CO2
    t09_lorenz    Lorenz points: period, pct_plants (0, 1, ..., 100),
                  cum_share_co2 (%)
  Chart: fig09_lorenz and fig09_gini (drawn in 11_figures.do)

  NOTE: masking adds noise to each plant's value, which tends to push a Gini
  up a little. The unit is the plant-year.
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

use "$B203_DATA/b203_si.dta", clear
keep if clean == 1 & co2_total > 0 & !missing(co2_total)
keep year co2_total
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1

* smallest emitter first
sort year co2_total
by year: generate i = _n
by year: generate n = _N
by year: egen total = total(co2_total)
by year: generate cum_share = 100 * sum(co2_total) / total
generate ix = i * co2_total
by year: egen sum_ix = total(ix)
generate gini = 2 * sum_ix / (n * total) - (n + 1) / n
save "$B203_DATA/b203_lorenz_rows.dta", replace

* ---- Gini table ----
collapse (first) n total gini, by(year)
generate period = cond(year == 0, "pool", string(year))
order period n gini total
keep  period n gini total
label variable n     "Plants with CO2 > 0"
label variable total "Total CO2 (t)"
list period n gini, clean noobs
export excel using "$B203_XLSX", sheet("t09_gini", replace) firstrow(variables)

* ---- Lorenz points at every percentile of plants ----
use "$B203_DATA/b203_lorenz_rows.dta", clear
* the plant at position ceil(n x p / 100) closes the first p% of plants
generate pct_plants = .
forvalues p = 1/100 {
    quietly replace pct_plants = `p' if i == ceil(n * `p' / 100)
}
keep if !missing(pct_plants)
keep year pct_plants cum_share
* add the origin (0% of plants hold 0% of CO2)
by year: generate first = (_n == 1)
expand 2 if first == 1, generate(origin)
replace pct_plants = 0 if origin == 1
replace cum_share  = 0 if origin == 1
generate period = cond(year == 0, "pool", string(year))
sort year pct_plants
rename cum_share cum_share_co2
order period pct_plants cum_share_co2
keep  period pct_plants cum_share_co2
export excel using "$B203_XLSX", sheet("t09_lorenz", replace) firstrow(variables)
