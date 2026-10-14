/*==========================================================================
  Line 9: "Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t09_java_share     % of firm-years in Java / outside Java by non-trading / export only / import only / export and import
    t09_prov_share     % of firm-years per province by non-trading / export only / import only / export and import
    t09_group_by_java  within Java and outside Java: % of firm-years per group
    t09_kab_share      % of firm-years per district -- only written if the district code is filled in

  NOTE: NOT AVAILABLE: district (kab/kota) is blank in block 0; kecamatan and
  kawasan industri are not in block 0.
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
do "$B10/_shares.do" "java" "trade_profile" "t09_java_share"
do "$B10/_shares.do" "prov" "trade_profile" "t09_prov_share"
do "$B10/_shares.do" "trade_profile" "java" "t09_group_by_java"

* district (kab/kota): only if block 0 ever fills it in
preserve
use "$SI_DATA", clear
quietly count if district_code != ""
local nkab = r(N)
restore
if `nkab' == 0 {
    display as error "District code is blank in this release: no t09_kab_share."
    display as error "Kecamatan and kawasan industri are not in block 0."
}
else {
    merge 1:1 year source_row using "$SI_DATA", keepusing(district_code) keep(master match) nogenerate
    encode district_code if district_code != "", generate(kab)
    do "$B10/_shares.do" "kab" "trade_profile" "t09_kab_share"
}
