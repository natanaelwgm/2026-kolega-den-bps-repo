/*==========================================================================
  Line 10: "RnD"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t10_rnd_rate_java  share doing R&D by Java vs outside Java (mean x 100 = %), 2017-2022
    t10_rnd_rate_prov  share doing R&D by province (mean x 100 = %), 2017-2022

  NOTE: R&D is used for 2017-2022 only (as b1-17); many records leave the
  question blank.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
do "$B15/_sumstats.do" "rnd" "java" "t10_rnd_rate_java"
do "$B15/_sumstats.do" "rnd" "prov" "t10_rnd_rate_prov"
