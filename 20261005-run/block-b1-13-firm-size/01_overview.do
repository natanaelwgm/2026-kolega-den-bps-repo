/*==========================================================================
  Line 1: "Elaborate small vs large firms (>100): dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (medium (<=100 workers) vs large (>100 workers)), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
do "$B13/_shares.do" "large" "" "t01_group_share"
do "$B13/_sumstats.do" "exporter importer fdi large rnd java" "large" "t01_profile"
