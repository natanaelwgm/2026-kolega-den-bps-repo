/*==========================================================================
  Line 4: "number of worker"
  Data  : SI 2010-2022 (data/b14_si.dta), clean == 1
  Output sheets:
    t04_workers           workers (level & ln), production / non-production workers by KBLI 2-digit sector
    t04_size_class_share  % of firm-years per size class (<20 ... 500+) by KBLI 2-digit sector
==========================================================================*/
if "$B14" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B14_DATA/b14_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B14/_sumstats.do" "`WORK'" "kbli2" "t04_workers"
do "$B14/_shares.do" "size_class" "kbli2" "t04_size_class_share"
