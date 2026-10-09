/*==========================================================================
  Line 7: "By sector 2 digit and 5 digit"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t07_kbli2_share  % of firm-years per KBLI 2-digit sector, all firms
    t07_kbli5_share  % of firm-years per KBLI 5-digit code, all firms
    t07_by_kbli2     TFP, VA, output, capital (level & ln) per KBLI 2-digit, pool + by year
    t07_by_kbli5     the same per KBLI 5-digit (pooled only)

  NOTE: Industry codes are as reported; block 0 has no bridge between
  classification versions.
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
do "$B07/_shares.do" "kbli2" "" "t07_kbli2_share"
do "$B07/_shares.do" "kbli5" "" "t07_kbli5_share"
local TFP "tfp_op tfp_lp tfp_acf tfp_wrdg"
local PROD "va ln_va va_pw ln_va_pw output ln_output out_pw ln_out_pw capital ln_capital cap_pw ln_cap_pw inputs ln_inputs materials ln_materials"
do "$B07/_sumstats.do" "`TFP' `PROD'" "kbli2" "t07_by_kbli2"
encode kbli5, generate(kbli5_code)
do "$B07/_sumstats.do" "`TFP' `PROD'" "kbli5_code" "t07_by_kbli5" "poolonly"
drop kbli5_code
