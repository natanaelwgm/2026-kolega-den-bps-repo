/*==========================================================================
  Line 5: "Untuk melihat apakah manufacturing mengalami efficiency improvement
           without full decarbonisation"
  Data  : SI 2010-2022 (data/b202_si.dta), clean == 1
  Output sheet:
    t05_synthesis   one sheet, intensity vs absolute emissions.
                    Rows: all manufacturing over 2010-2022, 2010-2015,
                    2017-2022, then each KBLI 2-digit sector over 2010-2022
                    (sectors with firms in both years).
                    Columns (100 x change in ln = log points):
                      d_co2           total CO2 (absolute emissions)
                      d_va            scale: total VA (nominal)
                      d_gj_per_va     energy intensity  (line 3)
                      d_co2_per_gj    carbon content    (line 4)
                      d_co2_per_va    carbon intensity  (= d_gj_per_va + d_co2_per_gj)
                      d_gj_pw         energy per worker (physical check)
                      check           d_co2 - d_va - d_gj_per_va - d_co2_per_gj (= 0)
                      reading_energy  energy intensity down/up x emissions down/up
                      reading_carbon  carbon intensity down/up x emissions down/up

  Total CO2 = VA x GJ/VA x CO2/GJ, so d_co2 = d_va + d_gj_per_va + d_co2_per_gj.
  "Efficiency improvement without full decarbonisation" = intensity falls
  while total emissions still rise.

  NOTE: VA is NOMINAL. Price inflation raises d_va and lowers d_gj_per_va
  by the same amount, so "intensity down" on VA may be partly prices.
  d_gj_pw has no price in it: if it rises, energy use per worker did not
  fall. 2015-2017 crosses the questionnaire change.
==========================================================================*/
if "$B202" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. all manufacturing, three windows ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1
collapse (sum) tot_co2 = co2_total tot_gj = gj_total tot_va = va tot_workers = workers, by(year)
tempfile yearly result
save `yearly'

local starts "2010 2010 2017"
local ends   "2022 2015 2022"
forvalues i = 1/3 {
    local a : word `i' of `starts'
    local b : word `i' of `ends'
    use `yearly', clear
    keep if year == `a' | year == `b'
    sort year
    generate d_co2        = 100 * (ln(tot_co2[2]) - ln(tot_co2[1]))
    generate d_va         = 100 * (ln(tot_va[2]) - ln(tot_va[1]))
    generate d_gj_per_va  = 100 * (ln(tot_gj[2] / tot_va[2]) - ln(tot_gj[1] / tot_va[1]))
    generate d_co2_per_gj = 100 * (ln(tot_co2[2] / tot_gj[2]) - ln(tot_co2[1] / tot_gj[1]))
    generate d_gj_pw      = 100 * (ln(tot_gj[2] / tot_workers[2]) - ln(tot_gj[1] / tot_workers[1]))
    keep in 1
    generate unit = "All manufacturing"
    generate window = "`a'-`b'"
    generate row = `i'
    if `i' > 1 append using `result'
    save `result', replace
}

* ---- B. each sector, 2010-2022 ----
use "$B202_DATA/b202_si.dta", clear
keep if clean == 1 & !missing(kbli2) & (year == 2010 | year == 2022)
generate n_firms = 1
collapse (sum) n_firms tot_co2 = co2_total tot_gj = gj_total tot_va = va tot_workers = workers, by(kbli2 year)
reshape wide n_firms tot_co2 tot_gj tot_va tot_workers, i(kbli2) j(year)
keep if !missing(n_firms2010, n_firms2022)
generate d_co2        = 100 * (ln(tot_co22022) - ln(tot_co22010))
generate d_va         = 100 * (ln(tot_va2022) - ln(tot_va2010))
generate d_gj_per_va  = 100 * (ln(tot_gj2022 / tot_va2022) - ln(tot_gj2010 / tot_va2010))
generate d_co2_per_gj = 100 * (ln(tot_co22022 / tot_gj2022) - ln(tot_co22010 / tot_gj2010))
generate d_gj_pw      = 100 * (ln(tot_gj2022 / tot_workers2022) - ln(tot_gj2010 / tot_workers2010))
decode kbli2, generate(unit)
generate window = "2010-2022"
generate row = 3 + kbli2
append using `result'

* ---- the reading ----
generate d_co2_per_va = d_gj_per_va + d_co2_per_gj
generate check = d_co2 - d_va - d_gj_per_va - d_co2_per_gj
generate reading_energy = ""
replace  reading_energy = "Decarbonising: energy intensity down, CO2 down"            if d_gj_per_va <  0 & d_co2 <= 0
replace  reading_energy = "Efficiency without decarbonisation: intensity down, CO2 up" if d_gj_per_va <  0 & d_co2 >  0
replace  reading_energy = "CO2 down without efficiency"                                if d_gj_per_va >= 0 & d_co2 <= 0
replace  reading_energy = "Neither: energy intensity up, CO2 up"                       if d_gj_per_va >= 0 & d_co2 >  0
generate reading_carbon = ""
replace  reading_carbon = "Decarbonising: carbon intensity down, CO2 down"            if d_co2_per_va <  0 & d_co2 <= 0
replace  reading_carbon = "Efficiency without decarbonisation: intensity down, CO2 up" if d_co2_per_va <  0 & d_co2 >  0
replace  reading_carbon = "CO2 down without lower intensity"                           if d_co2_per_va >= 0 & d_co2 <= 0
replace  reading_carbon = "Neither: carbon intensity up, CO2 up"                       if d_co2_per_va >= 0 & d_co2 >  0
replace  reading_energy = "" if missing(d_co2, d_gj_per_va)
replace  reading_carbon = "" if missing(d_co2, d_co2_per_va)

sort row
keep  unit window d_co2 d_va d_gj_per_va d_co2_per_gj d_co2_per_va d_gj_pw check reading_energy reading_carbon
order unit window d_co2 d_va d_gj_per_va d_co2_per_gj d_co2_per_va d_gj_pw check reading_energy reading_carbon
list unit window d_co2 d_gj_per_va d_co2_per_va reading_energy, clean noobs
tab reading_energy if unit != "All manufacturing"
tab reading_carbon if unit != "All manufacturing"
export excel using "$B202_XLSX", sheet("t05_synthesis", replace) firstrow(variables)
