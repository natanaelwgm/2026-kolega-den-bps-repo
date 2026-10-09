/*==========================================================================
  Line 10: "RnD"
  Data  : SI 2010-2022 (data/b11_si.dta), clean == 1
  Output sheets:
    t10_rnd_rate  share doing R&D by FDI (foreign ownership >=10%) vs domestic (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B11" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B11_DATA/b11_si.dta", clear
keep if clean == 1
do "$B11/_sumstats.do" "rnd" "fdi" "t10_rnd_rate"
