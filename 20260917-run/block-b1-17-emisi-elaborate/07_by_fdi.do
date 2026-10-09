/*==========================================================================
  Line 7: "FDI or not"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheet:
    t07_by_fdi   CO2 scope 1 / 2 / total (level & ln), intensities,
                 FDI (foreign ownership >= 10%) vs domestic, pool + by year

  NOTE: 2020 FDI is set missing (see 01a), so 2020 is not in this table.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "fdi" "t07_by_fdi"
