/*==========================================================================
  Line 5: "By sector 2 digit and 5 digit"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t05_kbli2_share     % of firm-years per KBLI 2-digit sector by SOE vs private
    t05_kbli5_share     % of firm-years per KBLI 5-digit code by SOE vs private
    t05_group_by_kbli2  within each KBLI 2-digit sector: % of firm-years per group

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
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
do "$B12/_shares.do" "kbli2" "soe" "t05_kbli2_share"
do "$B12/_shares.do" "kbli5" "soe" "t05_kbli5_share"
do "$B12/_shares.do" "soe" "kbli2" "t05_group_by_kbli2"
