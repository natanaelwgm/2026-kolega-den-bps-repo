/*==========================================================================
  Line 10: "Firms characteristics: tfp, va, capital dll"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Output sheet:
    t10_char_importer   n mean sd p10-p90 min max, importer vs non-importer,
                        levels and ln, pool + by year

  NOTE: TFP = block 0's nominal development residuals (tfp_op has far fewer
  observations than the other three). Every money value is nominal.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1

* add or remove variables in this list as needed
local V "tfp_op tfp_lp tfp_acf tfp_wrdg va output capital workers va_pw out_pw cap_pw ln_va ln_output ln_capital ln_workers ln_va_pw ln_out_pw ln_cap_pw"
do "$B18/_sumstats.do" "`V'" "importer" "t10_char_importer"
