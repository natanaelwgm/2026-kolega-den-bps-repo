/*==========================================================================
  Line 9: "RnD"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t09_rnd_rate  share doing R&D by SOE vs private (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
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
do "$B12/_sumstats.do" "rnd" "soe" "t09_rnd_rate"
