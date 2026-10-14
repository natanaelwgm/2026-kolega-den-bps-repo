/*==========================================================================
  Line 1: "Elaborate importing firms vs non importing firms: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b09_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (importer vs non-importer), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B09" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B09_DATA/b09_si.dta", clear
keep if clean == 1
do "$B09/_shares.do" "importer" "" "t01_group_share"
do "$B09/_sumstats.do" "exporter importer fdi large rnd java" "importer" "t01_profile"
