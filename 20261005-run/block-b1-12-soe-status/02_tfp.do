/*==========================================================================
  Line 2: "TFP (semua)"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t02_tfp  TFP, 4 methods (block 0 nominal development residuals) by SOE vs private, pool + by year

  NOTE: TFP = block 0 nominal development residuals on fictional firm links
  (not real TFP); OP has only 672 firm-years; the four methods are on
  different scales.
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
local TFP "tfp_op tfp_lp tfp_acf tfp_wrdg"
do "$B12/_sumstats.do" "`TFP'" "soe" "t02_tfp"
