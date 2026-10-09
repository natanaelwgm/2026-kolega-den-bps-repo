/*==========================================================================
  Line 4: "number of worker, medium vs large firms (>100)"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by non-trading / export only / import only / export and import
    t04_large_rate        share of large firms (>100 workers) by non-trading / export only / import only / export and import (mean x 100 = %)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by non-trading / export only / import only / export and import

  NOTE: The survey covers firms with 20+ workers, so "medium" is 20-100
  workers.
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B10/_sumstats.do" "`WORK'" "trade_profile" "t04_workers"
do "$B10/_sumstats.do" "large" "trade_profile" "t04_large_rate"
do "$B10/_shares.do" "size_class" "trade_profile" "t04_size_class_share"
