/*==========================================================================
  Line 11: "RnD"
  Data  : SI 2010-2022 (data/b09_si.dta), clean == 1
  Output sheets:
    t11_rnd_rate  share doing R&D by importer vs non-importer (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B09" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B09_DATA/b09_si.dta", clear
keep if clean == 1
do "$B09/_sumstats.do" "rnd" "importer" "t11_rnd_rate"
