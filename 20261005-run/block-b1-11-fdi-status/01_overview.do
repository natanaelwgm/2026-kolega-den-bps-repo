/*==========================================================================
  Line 1: "Elaborate FDI firms vs domestic firms: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b11_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (FDI (foreign ownership >=10%) vs domestic), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B11" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B11_DATA/b11_si.dta", clear
keep if clean == 1
do "$B11/_shares.do" "fdi" "" "t01_group_share"
do "$B11/_sumstats.do" "exporter importer fdi large rnd java" "fdi" "t01_profile"
