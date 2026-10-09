/*==========================================================================
  Line 2: "Untuk melihat apakah carbon performance membaik karena:"
          (heading over lines 3 and 4: less energy, or cleaner energy?)
  Data  : SI 2010-2022 (data/b202_si.dta), clean == 1
  Output sheets:
    t02_cumulative     by year: change since 2010 in ln CO2/VA, ln GJ/VA and
                       ln CO2/GJ (x100 = log points), and the same on the
                       per-worker denominator. CO2/VA change = GJ/VA change
                       + CO2/GJ change, every year.
    t02_change_split   the change over windows 2010-2022, 2010-2015,
                       2017-2022 and the 2015-2017 step, split into the
                       energy term (line 3) and the clean-energy term (line 4)
    t02_split_by_kbli2 the 2010-2022 split per KBLI 2-digit sector
                       (sectors with firms in both 2010 and 2022)

  How to read: a negative energy term = less energy per unit of VA (line 3);
  a negative clean term = less CO2 per GJ, i.e. cleaner energy (line 4).
  All changes are 100 x difference in ln (log points), aggregate ratios
  (total CO2 / total VA of all firms).

  NOTE: VA is NOMINAL. Read the per-worker columns (physical) beside the VA
  ones. The 2015-2017 step crosses the questionnaire change (energy
  reporting jumps), so 2010-2015 and 2017-2022 are the cleaner windows.
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- aggregate ratios by year (kept in a tempfile for A and B) ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1
collapse (sum) tot_co2 = co2_total tot_gj = gj_total tot_va = va tot_workers = workers, by(year)
generate ln_co2_per_va = ln(tot_co2 / tot_va)
generate ln_gj_per_va  = ln(tot_gj / tot_va)
generate ln_co2_per_gj = ln(tot_co2 / tot_gj)
generate ln_co2_pw     = ln(tot_co2 / tot_workers)
generate ln_gj_pw      = ln(tot_gj / tot_workers)
sort year
tempfile yearly
save `yearly'

* ---- A. cumulative change since 2010 ----
foreach v in co2_per_va gj_per_va co2_per_gj co2_pw gj_pw {
    generate d_`v' = 100 * (ln_`v' - ln_`v'[1])      // row 1 = 2010
}
generate check_identity = d_co2_per_va - d_gj_per_va - d_co2_per_gj
keep year d_co2_per_va d_gj_per_va d_co2_per_gj d_co2_pw d_gj_pw check_identity
list, clean noobs
export excel using "$B202_XLSX", sheet("t02_cumulative", replace) firstrow(variables)

* ---- B. change over windows ----
local starts "2010 2010 2017 2015"
local ends   "2022 2015 2022 2017"
tempfile windows
forvalues i = 1/4 {
    local a : word `i' of `starts'
    local b : word `i' of `ends'
    use `yearly', clear
    keep if year == `a' | year == `b'
    sort year
    foreach v in co2_per_va gj_per_va co2_per_gj co2_pw gj_pw {
        generate d_`v' = 100 * (ln_`v'[2] - ln_`v'[1])
    }
    keep in 1
    generate window = "`a'-`b'"
    generate w_order = `i'
    if `i' > 1 append using `windows'
    save `windows', replace
}
sort w_order
* which term moved CO2/VA more?
generate main_driver = cond(abs(d_gj_per_va) > abs(d_co2_per_gj), "energy use (GJ/VA)", "carbon content (CO2/GJ)")
rename (d_co2_per_va d_gj_per_va d_co2_per_gj) (d_co2_per_va_total d_gj_per_va_energy d_co2_per_gj_clean)
keep  window d_co2_per_va_total d_gj_per_va_energy d_co2_per_gj_clean main_driver d_co2_pw d_gj_pw
order window d_co2_per_va_total d_gj_per_va_energy d_co2_per_gj_clean main_driver d_co2_pw d_gj_pw
list, clean noobs
export excel using "$B202_XLSX", sheet("t02_change_split", replace) firstrow(variables)

* ---- C. 2010-2022 split per sector ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(kbli2) & (year == 2010 | year == 2022)
generate n_firms = 1
collapse (sum) n_firms tot_co2 = co2_total tot_gj = gj_total tot_va = va tot_workers = workers, by(kbli2 year)
generate ln_co2_per_va = ln(tot_co2 / tot_va)
generate ln_gj_per_va  = ln(tot_gj / tot_va)
generate ln_co2_per_gj = ln(tot_co2 / tot_gj)
generate ln_gj_pw      = ln(tot_gj / tot_workers)
keep kbli2 year n_firms ln_*
reshape wide n_firms ln_co2_per_va ln_gj_per_va ln_co2_per_gj ln_gj_pw, i(kbli2) j(year)
keep if !missing(n_firms2010, n_firms2022)
generate d_co2_per_va_total = 100 * (ln_co2_per_va2022 - ln_co2_per_va2010)
generate d_gj_per_va_energy = 100 * (ln_gj_per_va2022 - ln_gj_per_va2010)
generate d_co2_per_gj_clean = 100 * (ln_co2_per_gj2022 - ln_co2_per_gj2010)
generate d_gj_pw            = 100 * (ln_gj_pw2022 - ln_gj_pw2010)
generate main_driver = cond(abs(d_gj_per_va_energy) > abs(d_co2_per_gj_clean), "energy use (GJ/VA)", "carbon content (CO2/GJ)")
keep  kbli2 n_firms2010 n_firms2022 d_co2_per_va_total d_gj_per_va_energy d_co2_per_gj_clean main_driver d_gj_pw
order kbli2 n_firms2010 n_firms2022 d_co2_per_va_total d_gj_per_va_energy d_co2_per_gj_clean main_driver d_gj_pw
sort kbli2
list, clean noobs
export excel using "$B202_XLSX", sheet("t02_split_by_kbli2", replace) firstrow(variables)
