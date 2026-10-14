/*==========================================================================
  Line 3: "Value added per worker, value added, output, output per worker, capital, capital per worker,"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t03_va_output_capital  VA, VA/worker, output, output/worker, capital, capital/worker (+ inputs, materials), level & ln, all firms

  NOTE: Money values are nominal and masked (not deflated).
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
local PROD "va ln_va va_pw ln_va_pw output ln_output out_pw ln_out_pw capital ln_capital cap_pw ln_cap_pw inputs ln_inputs materials ln_materials"
do "$B07/_sumstats.do" "`PROD'" "" "t03_va_output_capital"
