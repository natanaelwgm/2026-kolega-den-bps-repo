/*==========================================================================
  Line 1: "Elaborate semua sektor by disic2 : dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b14_si.dta), clean == 1
  Output sheets:
    t01_group_share  % of firm-years in each group (KBLI 2-digit sector), pool + by year
    t01_profile      share of each group that exports / imports / is FDI / large / does R&D / is in Java (mean x 100 = %), pool + by year
==========================================================================*/
if "$B14" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B14_DATA/b14_si.dta", clear
keep if clean == 1
do "$B14/_shares.do" "kbli2" "" "t01_group_share"
do "$B14/_sumstats.do" "exporter importer fdi large rnd java" "kbli2" "t01_profile"
