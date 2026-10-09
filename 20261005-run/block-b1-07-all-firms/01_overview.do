/*==========================================================================
  Line 1: "Elaborate semua data: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b07_si.dta), clean == 1
  Output sheets:
    t01_profile  share of all firms that export / import / are FDI / large / do R&D / are in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B07" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B07_DATA/b07_si.dta", clear
keep if clean == 1
do "$B07/_sumstats.do" "exporter importer fdi large rnd java" "" "t01_profile"
