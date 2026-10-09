/*==========================================================================
  Line 8: "Energi use scope 1, 2, total"
  Data  : SI 2010-2022 (data/b15_si.dta), clean == 1
  Output sheets:
    t08_energy_java          energy GJ scope 1 / 2 / total (level & ln), GJ per worker and per VA, electricity (kWh) by Java vs outside Java
    t08_main_src_share_java  % of firm-years per main energy source by Java vs outside Java
    t08_energy_prov          energy GJ scope 1 / 2 / total (level & ln), GJ per worker and per VA, electricity (kWh) by province
    t08_main_src_share_prov  % of firm-years per main energy source by province

  NOTE: Scope 1 = GJ of the 4 fuels asked every year (diesel, petrol, coal,
  LPG); scope 2 = purchased electricity; own generation is not scope 2.
  Energy reporting changes between 2015 and 2017.
==========================================================================*/
if "$B15" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B15_DATA/b15_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 ln_gj_s1 gj_s2 ln_gj_s2 gj_total ln_gj_total gj_pw gj_per_va elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B15/_sumstats.do" "`ENERGY'" "java" "t08_energy_java"
do "$B15/_shares.do" "main_src" "java" "t08_main_src_share_java"
local ENERGY "gj_s1 ln_gj_s1 gj_s2 ln_gj_s2 gj_total ln_gj_total gj_pw gj_per_va elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B15/_sumstats.do" "`ENERGY'" "prov" "t08_energy_prov"
do "$B15/_shares.do" "main_src" "prov" "t08_main_src_share_prov"
