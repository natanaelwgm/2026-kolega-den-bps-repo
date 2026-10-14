/*==========================================================================
  Line 6: "Energi use scope 1, 2, total"
  Data  : SI 2010-2022 (data/b12_si.dta), clean == 1
  Output sheets:
    t06_energy          energy GJ scope 1 / 2 / total (level & ln), GJ per worker and per VA, electricity (kWh) by SOE vs private
    t06_main_src_share  % of firm-years per main energy source by SOE vs private

  NOTE: Scope 1 = GJ of the 4 fuels asked every year (diesel, petrol, coal,
  LPG); scope 2 = purchased electricity; own generation is not scope 2.
  Energy reporting changes between 2015 and 2017.
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
local ENERGY "gj_s1 ln_gj_s1 gj_s2 ln_gj_s2 gj_total ln_gj_total gj_pw gj_per_va elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B12/_sumstats.do" "`ENERGY'" "soe" "t06_energy"
do "$B12/_shares.do" "main_src" "soe" "t06_main_src_share"
