/*==========================================================================
  Line 4: "number of worker, medium vs large firms (>100)"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by SOE vs private
    t04_large_rate        share of large firms (>100 workers) by SOE vs private (mean x 100 = %)
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by SOE vs private

  NOTE: The survey covers firms with 20+ workers, so "medium" is 20-100
  workers.
==========================================================================*/
if "$B12" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B12_DATA/b12_si.dta", clear
capture confirm variable soe
if _rc {
    display as error "No SOE / government-ownership variable in block 0: nothing to tabulate (see README)."
    exit
}
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B12/_sumstats.do" "`WORK'" "soe" "t04_workers"
do "$B12/_sumstats.do" "large" "soe" "t04_large_rate"
do "$B12/_shares.do" "size_class" "soe" "t04_size_class_share"
