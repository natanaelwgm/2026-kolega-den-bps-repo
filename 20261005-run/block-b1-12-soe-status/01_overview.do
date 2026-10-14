/*==========================================================================
  Line 1: "Elaborate SOE firms vs private firms: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (SOE vs private), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
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
do "$B12/_shares.do" "soe" "" "t01_group_share"
do "$B12/_sumstats.do" "exporter importer fdi large rnd java" "soe" "t01_profile"
