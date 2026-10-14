/*==========================================================================
  Line 3: "TFP (semua)"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t03_tfp_java  TFP, 4 methods (block 0 nominal development residuals) by Java vs outside Java, pool + by year
    t03_tfp_prov  TFP, 4 methods (block 0 nominal development residuals) by province, pool + by year

  NOTE: TFP = block 0 nominal development residuals on fictional firm links
  (not real TFP); OP has only 672 firm-years; the four methods are on
  different scales.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
local TFP "tfp_op tfp_lp tfp_acf tfp_wrdg"
do "$B15/_sumstats.do" "`TFP'" "java" "t03_tfp_java"
local TFP "tfp_op tfp_lp tfp_acf tfp_wrdg"
do "$B15/_sumstats.do" "`TFP'" "prov" "t03_tfp_prov"
