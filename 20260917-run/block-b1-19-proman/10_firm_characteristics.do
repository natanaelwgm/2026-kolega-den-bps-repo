/*==========================================================================
  Line 10: "Firms characteristics: tfp, va, capital dll"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
  Output sheet:
    t10_char_exporter   n mean sd p10-p90 min max, exporter vs non-exporter,
                        levels and ln, pool + by year
  Chart: fig10 (drawn in 12_figures.do)

  NOTE: TFP = block 0's nominal development residuals (tfp_op has far fewer
  observations than the other three). Every money value is nominal.
  2022 has no exporter flag (see 01a), so it is not in this table.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1

* add or remove variables in this list as needed
local V "tfp_op tfp_lp tfp_acf tfp_wrdg va output capital workers va_pw out_pw cap_pw co2_per_va ln_va ln_output ln_capital ln_workers ln_va_pw ln_out_pw ln_cap_pw ln_co2_per_va"
do "$B19/_sumstats.do" "`V'" "exporter" "t10_char_exporter"
