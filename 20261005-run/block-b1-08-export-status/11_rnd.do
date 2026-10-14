/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t11_rnd_rate  share doing R&D by exporter vs non-exporter (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
do "$B08/_sumstats.do" "rnd" "exporter" "t11_rnd_rate"
