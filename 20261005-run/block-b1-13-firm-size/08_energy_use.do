/*==========================================================================
  Line 8: "Energi use scope 1, 2, total"
  Data  : SI 2010-2022 (data/b13_si.dta), clean == 1
  Output sheets:
    t08_energy          energy GJ scope 1 / 2 / total (level & ln), GJ per worker and per VA, electricity (kWh) by medium (<=100 workers) vs large (>100 workers)
    t08_main_src_share  % of firm-years per main energy source by medium (<=100 workers) vs large (>100 workers)

  NOTE: Scope 1 = GJ of the 4 fuels asked every year (diesel, petrol, coal,
  LPG); scope 2 = purchased electricity; own generation is not scope 2.
  Energy reporting changes between 2015 and 2017.
==========================================================================*/
if "$B13" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B13_DATA/b13_si.dta", clear
keep if clean == 1
local ENERGY "gj_s1 ln_gj_s1 gj_s2 ln_gj_s2 gj_total ln_gj_total gj_pw gj_per_va elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B13/_sumstats.do" "`ENERGY'" "large" "t08_energy"
do "$B13/_shares.do" "main_src" "large" "t08_main_src_share"
