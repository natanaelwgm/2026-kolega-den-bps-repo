/*==========================================================================
  Line 9: "Emisi 1, 2, total"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t09_emissions_stats         CO2 scope 1 / 2 / total (level & ln), CO2 per GJ, per VA, per worker, pool + by year
    t09_by_co2_{s1,s2,total}_q  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, by CO2 quintile (within year)

  NOTE: Scope 1 = CO2 of diesel, petrol, coal, LPG; scope 2 = purchased
  electricity with the block 0 grid factor (2014 value carried forward after
  2014).
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"

* ---- emissions themselves ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
do "$B16/_sumstats.do" "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_gj co2_per_va co2_pw" "" "t09_emissions_stats"

* ---- energy use by emissions quintile ----
foreach v in co2_s1 co2_s2 co2_total {
    use "$B16_DATA/b16_si.dta", clear
    keep if clean == 1
    generate q_`v' = 0 if `v' == 0
    levelsof year if `v' > 0 & !missing(`v'), local(years)
    foreach y of local years {
        xtile tmp = `v' if year == `y' & `v' > 0, nquantiles(5)
        replace q_`v' = tmp if year == `y' & `v' > 0 & !missing(`v')
        drop tmp
    }
    label define quint 0 "Zero" 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4" 5 "Q5 (highest)", replace
    label values q_`v' quint
    local short = subinstr("`v'", "co2_", "", 1)
    do "$B16/_sumstats.do" "`ENERGY'" "q_`v'" "t09_by_co2_`short'_q"
}
