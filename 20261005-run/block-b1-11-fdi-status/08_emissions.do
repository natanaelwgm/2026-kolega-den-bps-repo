/*==========================================================================
  Line 8: "Emisi 1, 2, total"
  Data  : SI 2010-2022 (data/b11_si.dta), clean == 1
  Output sheets:
    t08_emissions  CO2 scope 1 / 2 / total (level & ln), CO2 per worker, per VA, per GJ by FDI (foreign ownership >=10%) vs domestic

  NOTE: Scope 1 = CO2 of diesel, petrol, coal, LPG; scope 2 = purchased
  electricity with the block 0 grid factor (2014 value carried forward after
  2014).
==========================================================================*/
if "$B11" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B11_DATA/b11_si.dta", clear
keep if clean == 1
local EMIS "co2_s1 ln_co2_s1 co2_s2 ln_co2_s2 co2_total ln_co2_total co2_pw co2_per_va co2_per_gj"
do "$B11/_sumstats.do" "`EMIS'" "fdi" "t08_emissions"
