/*==========================================================================
  Line 8: "Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t08_java_share     % of firm-years in Java / outside Java by SOE vs private
    t08_prov_share     % of firm-years per province by SOE vs private
    t08_group_by_java  within Java and outside Java: % of firm-years per group
    t08_kab_share      % of firm-years per district -- only written if the district code is filled in

  NOTE: NOT AVAILABLE: district (kab/kota) is blank in block 0; kecamatan and
  kawasan industri are not in block 0.
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
do "$B12/_shares.do" "java" "soe" "t08_java_share"
do "$B12/_shares.do" "prov" "soe" "t08_prov_share"
do "$B12/_shares.do" "soe" "java" "t08_group_by_java"

* district (kab/kota): only if block 0 ever fills it in
preserve
use "$SI_DATA", clear
quietly count if district_code != ""
local nkab = r(N)
restore
if `nkab' == 0 {
    display as error "District code is blank in this release: no t08_kab_share."
    display as error "Kecamatan and kawasan industri are not in block 0."
}
else {
    merge 1:1 year source_row using "$SI_DATA", keepusing(district_code) keep(master match) nogenerate
    encode district_code if district_code != "", generate(kab)
    do "$B12/_shares.do" "kab" "soe" "t08_kab_share"
}
