/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t11_rnd_rate  share doing R&D by medium (<=100 workers) vs large (>100 workers) (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
do "$B13/_sumstats.do" "rnd" "large" "t11_rnd_rate"
