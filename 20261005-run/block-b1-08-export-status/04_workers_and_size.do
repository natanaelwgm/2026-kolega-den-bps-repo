/*==========================================================================
  Line 4: "number of worker, medium vs large firms (>100)"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by exporter vs non-exporter
    t04_large_rate        share of large firms (>100 workers) by exporter vs non-exporter (mean x 100 = %)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by exporter vs non-exporter

  NOTE: The survey covers firms with 20+ workers, so "medium" is 20-100
  workers.
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B08/_sumstats.do" "`WORK'" "exporter" "t04_workers"
do "$B08/_sumstats.do" "large" "exporter" "t04_large_rate"
do "$B08/_shares.do" "size_class" "exporter" "t04_size_class_share"
