/*==========================================================================
  Line 7: "Energi use scope 1, 2, total"
  Data  : SI 2010-2022 (data/b10_si.dta), clean == 1
  Output sheets:
    t07_energy          energy GJ scope 1 / 2 / total (level & ln), GJ per worker and per VA, electricity (kWh) by non-trading / export only / import only / export and import
    t07_main_src_share  % of firm-years per main energy source by non-trading / export only / import only / export and import

  NOTE: Scope 1 = GJ of the 4 fuels asked every year (diesel, petrol, coal,
  LPG); scope 2 = purchased electricity; own generation is not scope 2.
  Energy reporting changes between 2015 and 2017.
==========================================================================*/
if "$B10" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B10_DATA/b10_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 ln_gj_s1 gj_s2 ln_gj_s2 gj_total ln_gj_total gj_pw gj_per_va elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B10/_sumstats.do" "`ENERGY'" "trade_profile" "t07_energy"
do "$B10/_shares.do" "main_src" "trade_profile" "t07_main_src_share"
