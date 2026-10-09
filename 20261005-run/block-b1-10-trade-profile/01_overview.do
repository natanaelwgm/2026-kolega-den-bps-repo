/*==========================================================================
  Line 1: "Elaborate importing & exporting firms vs non trading firms vs just doing export vs just doing import: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (non-trading / export only / import only / export and import), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
do "$B10/_shares.do" "trade_profile" "" "t01_group_share"
do "$B10/_sumstats.do" "exporter importer fdi large rnd java" "trade_profile" "t01_profile"
