/*==========================================================================
  Line 6: "number of worker"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t06_by_size_class  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, by size class
    t06_by_large       the same, medium (<=100) vs large (>100 workers)
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
do "$B16/_sumstats.do" "`ENERGY'" "size_class" "t06_by_size_class"
do "$B16/_sumstats.do" "`ENERGY'" "large" "t06_by_large"
