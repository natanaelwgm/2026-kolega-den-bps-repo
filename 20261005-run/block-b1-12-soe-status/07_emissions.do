/*==========================================================================
  Line 7: "Emisi 1, 2, total"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t07_emissions  CO2 scope 1 / 2 / total (level & ln), CO2 per worker, per VA, per GJ by SOE vs private

  NOTE: Scope 1 = CO2 of diesel, petrol, coal, LPG; scope 2 = purchased
  electricity with the block 0 grid factor (2014 value carried forward after
  2014).
==========================================================================*/
if "$B12" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B12_DATA/b12_si.dta", clear
capture confirm variable soe
if _rc {
    display as error "No SOE / government-ownership variable in block 0: nothing to tabulate (see README)."
    exit
}
keep if clean == 1
local EMIS "co2_s1 ln_co2_s1 co2_s2 ln_co2_s2 co2_total ln_co2_total co2_pw co2_per_va co2_per_gj"
do "$B12/_sumstats.do" "`EMIS'" "soe" "t07_emissions"
