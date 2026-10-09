/*==========================================================================
  Line 5: "number of worker"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t05_workers_java           workers (level & ln), production / non-production workers by Java vs outside Java
    t05_size_class_share_java  % of firm-years per size class (<20 ... 500+) by Java vs outside Java
    t05_workers_prov           workers (level & ln), production / non-production workers by province
    t05_size_class_share_prov  % of firm-years per size class (<20 ... 500+) by province
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B15/_sumstats.do" "`WORK'" "java" "t05_workers_java"
do "$B15/_shares.do" "size_class" "java" "t05_size_class_share_java"
local WORK "workers ln_workers prod_workers nonprod_workers prod_share"
do "$B15/_sumstats.do" "`WORK'" "prov" "t05_workers_prov"
do "$B15/_shares.do" "size_class" "prov" "t05_size_class_share_prov"
