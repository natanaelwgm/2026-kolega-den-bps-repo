/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2017-2022 (data/b17_si.dta), clean == 1
  Output sheet:
    t11_by_rnd   CO2 scope 1 / 2 / total (level & ln), intensities,
                 R&D vs no R&D, pool (2017-2022) + by year

  NOTE: the R&D question is asked only in 2011 and 2017-2022, and even then
  about half the records leave it blank (missing, not "no"). 2011 is left
  out so the pool is one consistent questionnaire.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1 & year >= 2017
tabulate year rnd, missing row
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "rnd" "t11_by_rnd"
