/*==========================================================================
  Line 10: "Location (province, kab kota dan kecamatan kalau ada), dalam Kawasan industry or not"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t10_by_java      GJ scope 1 / 2 / total (level & ln), GJ per VA and per worker, Java vs outside Java
    t10_by_province  the same per province
    t10_by_kab       the same per district -- only written if the district code is filled in

  NOTE: NOT AVAILABLE: district (kab/kota) is blank in block 0; kecamatan and
  kawasan industri are not in block 0.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw"
do "$B16/_sumstats.do" "`ENERGY'" "java" "t10_by_java"
do "$B16/_sumstats.do" "`ENERGY'" "prov" "t10_by_province"

* district: only if block 0 ever fills it in
use "$SI_DATA", clear
count if district_code != ""
if r(N) == 0 {
    display as error "District code is blank in this release: no t10_by_kab."
    display as error "Kecamatan and kawasan industri are not in block 0."
}
else {
    keep year source_row district_code
    merge 1:1 year source_row using "$B16_DATA/b16_si.dta", keep(match) nogenerate
    keep if clean == 1 & district_code != ""
    encode district_code, generate(kab)
    do "$B16/_sumstats.do" "`ENERGY'" "kab" "t10_by_kab"
}
