/*==========================================================================
  Line 7: "By sector 2 digit and 5 digit"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t07_kbli2_share     % of firm-years per KBLI 2-digit sector by medium (<=100 workers) vs large (>100 workers)
    t07_kbli5_share     % of firm-years per KBLI 5-digit code by medium (<=100 workers) vs large (>100 workers)
    t07_group_by_kbli2  within each KBLI 2-digit sector: % of firm-years per group

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
do "$B13/_shares.do" "kbli2" "large" "t07_kbli2_share"
do "$B13/_shares.do" "kbli5" "large" "t07_kbli5_share"
do "$B13/_shares.do" "large" "kbli2" "t07_group_by_kbli2"
