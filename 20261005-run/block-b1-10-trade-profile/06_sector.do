/*==========================================================================
  Line 6: "By sector 2 digit and 5 digit"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t06_kbli2_share     % of firm-years per KBLI 2-digit sector by non-trading / export only / import only / export and import
    t06_kbli5_share     % of firm-years per KBLI 5-digit code by non-trading / export only / import only / export and import
    t06_group_by_kbli2  within each KBLI 2-digit sector: % of firm-years per group

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
do "$B10/_shares.do" "kbli2" "trade_profile" "t06_kbli2_share"
do "$B10/_shares.do" "kbli5" "trade_profile" "t06_kbli5_share"
do "$B10/_shares.do" "trade_profile" "kbli2" "t06_group_by_kbli2"
