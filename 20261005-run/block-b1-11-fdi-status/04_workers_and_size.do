/*==========================================================================
  Line 4: "number of worker, medium vs large firms (>100)"
  Data  : SI 2010-2022 (data/b11_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by FDI (foreign ownership >=10%) vs domestic
    t04_large_rate        share of large firms (>100 workers) by FDI (foreign ownership >=10%) vs domestic (mean x 100 = %)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by FDI (foreign ownership >=10%) vs domestic

  NOTE: The survey covers firms with 20+ workers, so "medium" is 20-100
  workers.
==========================================================================*/
if "$B11" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B11_DATA/b11_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B11/_sumstats.do" "`WORK'" "fdi" "t04_workers"
do "$B11/_sumstats.do" "large" "fdi" "t04_large_rate"
do "$B11/_shares.do" "size_class" "fdi" "t04_size_class_share"
