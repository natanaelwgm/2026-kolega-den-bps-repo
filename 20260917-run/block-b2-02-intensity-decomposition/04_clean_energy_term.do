/*==========================================================================
  Line 4: "Energy menjadi lebih clean: compare scope 1 dan scope 2, dan total"
          (the second term of the decomposition: CO2 per GJ)
  Data  : SI 2010-2022 (data/b202_si.dta), clean == 1
  Output sheets:
    t04_by_scope     pool + by year: CO2 and GJ per scope; CO2/GJ for scope 1,
                     scope 2 and total; fuel share of GJ; scope 1 share of
                     CO2; total CO2/GJ with the grid factor held constant
                     (static) and with the sourced annual grid factor
    t04_cumulative   by year: change since 2010 in ln CO2/GJ (log points)
                     for scope 1, scope 2, total, total-static, total-sourced
    t04_by_kbli2     CO2/GJ scope 1, scope 2, total per KBLI 2-digit,
                     pool + by year
    t04_firm_stats   firm-level CO2/GJ (total, scope 1) level and ln, and the
                     fuel share of GJ, pool + by year

  Scope 1 = diesel, petrol, coal, LPG (CO2 and GJ of the same 4 fuels).
  Scope 2 = purchased electricity; own generation is in neither (its CO2 is
  already in the generator's fuel). Total CO2/GJ = GJ-weighted average of
  the scope 1 and scope 2 factors, so it moves when the factors move AND
  when the mix between fuel and electricity moves (gj_share_fuel).

  NOTE: scope 2 CO2/GJ is just the grid factor / 0.0036. Block 0's grid factor
  rises 2010-2014 and is held FLAT from 2014, so scope 2 after 2014 is an
  assumption, not a measurement. The static column holds the grid constant
  for all years (0.000867 t/kWh): what is left is fuel-mix change.
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. by scope, pool + by year ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total ///
         co2_total_static co2_total_sourced, by(year)
generate co2_per_gj_s1      = co2_s1 / gj_s1
generate co2_per_gj_s2      = co2_s2 / gj_s2
generate co2_per_gj_total   = co2_total / gj_total
generate gj_share_fuel      = gj_s1 / gj_total
generate pct_co2_scope1     = 100 * co2_s1 / co2_total
generate co2_per_gj_static  = co2_total_static / gj_total
generate co2_per_gj_sourced = co2_total_sourced / gj_total
* check: total = GJ-weighted average of the two scope factors (must be 0)
generate check_wavg = co2_per_gj_total - (gj_share_fuel * co2_per_gj_s1 + (1 - gj_share_fuel) * co2_per_gj_s2)
generate period = cond(year == 0, "pool", string(year))
order period n_firms co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_gj_s1 co2_per_gj_s2 ///
      co2_per_gj_total gj_share_fuel pct_co2_scope1 co2_per_gj_static co2_per_gj_sourced check_wavg
keep  period n_firms co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total co2_per_gj_s1 co2_per_gj_s2 ///
      co2_per_gj_total gj_share_fuel pct_co2_scope1 co2_per_gj_static co2_per_gj_sourced check_wavg
list period co2_per_gj_s1 co2_per_gj_s2 co2_per_gj_total gj_share_fuel co2_per_gj_static, clean noobs
export excel using "$B202_XLSX", sheet("t04_by_scope", replace) firstrow(variables)

* ---- B. cumulative change since 2010 ----
drop if period == "pool"
generate year = real(period)
sort year
foreach v in s1 s2 total static sourced {
    generate d_co2_per_gj_`v' = 100 * (ln(co2_per_gj_`v') - ln(co2_per_gj_`v'[1]))   // row 1 = 2010
}
keep year d_co2_per_gj_*
list, clean noobs
export excel using "$B202_XLSX", sheet("t04_cumulative", replace) firstrow(variables)

* ---- C. per KBLI 2-digit sector ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms co2_s1 co2_s2 co2_total gj_s1 gj_s2 gj_total, by(kbli2 year)
generate co2_per_gj_s1    = co2_s1 / gj_s1        if gj_s1 > 0
generate co2_per_gj_s2    = co2_s2 / gj_s2        if gj_s2 > 0
generate co2_per_gj_total = co2_total / gj_total  if gj_total > 0
generate gj_share_fuel    = gj_s1 / gj_total      if gj_total > 0
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
keep  kbli2 period n_firms co2_per_gj_s1 co2_per_gj_s2 co2_per_gj_total gj_share_fuel
order kbli2 period n_firms co2_per_gj_s1 co2_per_gj_s2 co2_per_gj_total gj_share_fuel
export excel using "$B202_XLSX", sheet("t04_by_kbli2", replace) firstrow(variables)

* ---- D. firm-level distribution ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(co2_per_gj)
do "$B202/_sumstats.do" "co2_per_gj ln_co2_per_gj co2_per_gj_s1 ln_co2_per_gj_s1 gj_share_s1" "" "t04_firm_stats"
