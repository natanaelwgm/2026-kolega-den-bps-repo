/*==========================================================================
  Line 1: "Elaborate location by province and by java non java: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t01_group_share_java  % of firm-years in each group (Java vs outside Java), pool + by year
    t01_profile_java      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
    t01_group_share_prov  % of firm-years in each group (province), pool + by year
    t01_profile_prov      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
do "$B15/_shares.do" "java" "" "t01_group_share_java"
do "$B15/_sumstats.do" "exporter importer fdi large rnd java" "java" "t01_profile_java"
do "$B15/_shares.do" "prov" "" "t01_group_share_prov"
do "$B15/_sumstats.do" "exporter importer fdi large rnd java" "prov" "t01_profile_prov"
