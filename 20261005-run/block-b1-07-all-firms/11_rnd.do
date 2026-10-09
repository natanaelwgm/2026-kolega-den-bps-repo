/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t11_rnd_rate  share doing R&D, all firms (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
do "$B07/_sumstats.do" "rnd" "" "t11_rnd_rate"
