/*==========================================================================
  Line 1: "Elaborate exporting firms vs non exporting firms: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b08_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (exporter vs non-exporter), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B08" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B08_DATA/b08_si.dta", clear
keep if clean == 1
do "$B08/_shares.do" "exporter" "" "t01_group_share"
do "$B08/_sumstats.do" "exporter importer fdi large rnd java" "exporter" "t01_profile"
