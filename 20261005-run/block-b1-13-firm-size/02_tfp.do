/*==========================================================================
  Line 2: "TFP (semua)"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t02_tfp  TFP, 4 methods (block 0 nominal development residuals) by medium (<=100 workers) vs large (>100 workers), pool + by year

  NOTE: TFP = block 0 nominal development residuals on fictional firm links
  (not real TFP); OP has only 672 firm-years; the four methods are on
  different scales.
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
local TFP "tfp_op tfp_lp tfp_acf tfp_wrdg"
do "$B13/_sumstats.do" "`TFP'" "large" "t02_tfp"
