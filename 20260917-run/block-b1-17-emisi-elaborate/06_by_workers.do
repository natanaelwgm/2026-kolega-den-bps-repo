/*==========================================================================
  Line 6: "number of worker"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheets:
    t06_by_size_class   CO2 scope 1 / 2 / total (level & ln), intensities,
                        by worker size class (<20, 20-49, 50-99, 100-499, 500+),
                        pool + by year
    t06_by_large        the same, medium (<=100) vs large (>100 workers)

  NOTE: the survey covers firms with 20+ workers, but 13% of records report
  fewer than 20 (masked counts); they are kept as their own class.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "size_class" "t06_by_size_class"
do "$B17/_sumstats.do" "`EMIS'" "large" "t06_by_large"
