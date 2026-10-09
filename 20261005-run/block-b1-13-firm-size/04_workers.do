/*==========================================================================
  Line 4: "number of worker"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by medium (<=100 workers) vs large (>100 workers)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by medium (<=100 workers) vs large (>100 workers)
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B13/_sumstats.do" "`WORK'" "large" "t04_workers"
do "$B13/_shares.do" "size_class" "large" "t04_size_class_share"
