/*==========================================================================
  Line 4: "number of worker, medium vs large firms (>100)"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers, all firms
    t04_large_rate        share of large firms (>100 workers), all firms (mean x 100 = %)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+), all firms

  NOTE: The survey covers firms with 20+ workers, so "medium" is 20-100
  workers.
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B07/_sumstats.do" "`WORK'" "" "t04_workers"
do "$B07/_sumstats.do" "large" "" "t04_large_rate"
do "$B07/_shares.do" "size_class" "" "t04_size_class_share"
