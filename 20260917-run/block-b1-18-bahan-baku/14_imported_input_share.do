/*==========================================================================
  Line 14: "imported input share/total input"
  Two sources, two definitions:
    SI 2010-2022    : imports / raw materials (imp_share_mat)
                      imports / total intermediate inputs (imp_share_int)
                      -> among importers only
    Roster 2021-22  : imported / total raw material value (import_share)
  Output sheets:
    t14_si_share   stats of the SI shares, importers only, pool + by year
    t14_bb_share   stats of the roster share: all firms and importers only
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- SI ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & importer == 1
do "$B18/_sumstats.do" "imp_share_mat imp_share_int" "" "t14_si_share"

* ---- roster (construct built in 13_construct.do) ----
use "$B18_DATA/b18_bb_firm.dta", clear
generate import_share_importers = import_share if any_import == 1
do "$B18/_sumstats.do" "import_share import_share_importers" "" "t14_bb_share"
