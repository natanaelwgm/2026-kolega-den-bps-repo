/*==========================================================================
  Line 2: "Sectors disic 2 dan disic 5"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t02_kbli2_share_java     % of firm-years per KBLI 2-digit sector by Java vs outside Java
    t02_kbli5_share_java     % of firm-years per KBLI 5-digit code by Java vs outside Java
    t02_group_by_kbli2_java  within each KBLI 2-digit sector: % of firm-years per group
    t02_kbli2_share_prov     % of firm-years per KBLI 2-digit sector by province
    t02_kbli5_share_prov     % of firm-years per KBLI 5-digit code by province
    t02_group_by_kbli2_prov  within each KBLI 2-digit sector: % of firm-years per group

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
do "$B15/_shares.do" "kbli2" "java" "t02_kbli2_share_java"
do "$B15/_shares.do" "kbli5" "java" "t02_kbli5_share_java"
do "$B15/_shares.do" "java" "kbli2" "t02_group_by_kbli2_java"
do "$B15/_shares.do" "kbli2" "prov" "t02_kbli2_share_prov"
do "$B15/_shares.do" "kbli5" "prov" "t02_kbli5_share_prov"
do "$B15/_shares.do" "prov" "kbli2" "t02_group_by_kbli2_prov"
