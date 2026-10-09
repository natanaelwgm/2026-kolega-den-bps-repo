/*==========================================================================
  Line 7: "By sector 2 digit and 5 digit"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t07_kbli2_share     % of firm-years per KBLI 2-digit sector by exporter vs non-exporter
    t07_kbli5_share     % of firm-years per KBLI 5-digit code by exporter vs non-exporter
    t07_group_by_kbli2  within each KBLI 2-digit sector: % of firm-years per group

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
do "$B08/_shares.do" "kbli2" "exporter" "t07_kbli2_share"
do "$B08/_shares.do" "kbli5" "exporter" "t07_kbli5_share"
do "$B08/_shares.do" "exporter" "kbli2" "t07_group_by_kbli2"
