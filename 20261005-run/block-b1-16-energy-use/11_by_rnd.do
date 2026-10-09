/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t11_by_rnd  GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, R&D vs no R&D, 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
tabulate year rnd, missing row
do "$B16/_sumstats.do" "`ENERGY'" "rnd" "t11_by_rnd"
