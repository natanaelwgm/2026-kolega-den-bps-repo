/*==========================================================================
  Line 10: "Location (province, kab kota dan kecamatan kalau ada), dalam
            Kawasan industry or not"
  Data  : SI 2010-2022 (data/b17_si.dta), clean == 1
  Output sheets:
    t10_by_java       CO2 scope 1 / 2 / total (level & ln), intensities,
                      Java vs outside Java, pool + by year
    t10_by_province   the same per province, pool + by year
    t10_by_kab        the same per district -- only written if the district
                      code is filled in (it is blank in this release)

  NOT AVAILABLE: district (kabupaten/kota) is blank in block 0; sub-district
  (kecamatan) and industrial-estate (kawasan industri) membership are not in
  block 0 at all. Add them to 01a and copy the _sumstats line when available.
==========================================================================*/
if "$B17" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B17_DATA/b17_si.dta", clear
keep if clean == 1
local EMIS "co2_s1 co2_s2 co2_total ln_co2_s1 ln_co2_s2 ln_co2_total co2_per_va co2_pw"
do "$B17/_sumstats.do" "`EMIS'" "java" "t10_by_java"
do "$B17/_sumstats.do" "`EMIS'" "prov" "t10_by_province"

* district: only if block 0 ever fills it in
use "$SI_DATA", clear
count if district_code != ""
if r(N) == 0 {
    display as error "District code is blank in this release: no t10_by_kab."
    display as error "Sub-district and industrial estate are not in block 0."
}
else {
    keep year source_row district_code
    merge 1:1 year source_row using "$B17_DATA/b17_si.dta", keep(match) nogenerate
    keep if clean == 1 & district_code != ""
    encode district_code, generate(kab)
    do "$B17/_sumstats.do" "`EMIS'" "kab" "t10_by_kab"
}
