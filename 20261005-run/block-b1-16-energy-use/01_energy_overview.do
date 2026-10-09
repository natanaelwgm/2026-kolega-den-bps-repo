/*==========================================================================
  Line 1: "Elaborate energy use scope 1, scope 2, dan total: dicek original value dan ln, dicek pool dan jg by year"
  Data  : SI 2010-2022 (data/b16_si.dta), clean == 1
  Output sheets:
    t01_totals    sum over firms of GJ scope 1 / 2 / total (and CO2, kWh), % of firms with energy use, pool + by year
    t01_stats     per firm-year: GJ scope 1 / 2 / total (level & ln), GJ per VA, GJ per worker, electricity, pool + by year
    t01_fuel_qty  reported physical fuel quantities, pool + by year

  NOTE: Scope 1 = GJ of the 4 fuels asked in every year (diesel, petrol, coal,
  LPG); scope 2 = purchased electricity (PLN + non-PLN); own generation is
  not scope 2. Energy reporting changes between 2015 and 2017.
==========================================================================*/
if "$B16" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 1. aggregate totals ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
generate n_firms = 1
generate any_gj = (gj_total > 0 & !missing(gj_total))
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms any_gj gj_s1 gj_s2 gj_total co2_s1 co2_s2 co2_total elec_purch_kwh elec_owngen_kwh, by(year)
generate pct_any_gj   = 100 * any_gj / n_firms
generate s1_share_pct = 100 * gj_s1 / gj_total
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_gj pct_any_gj gj_s1 gj_s2 gj_total s1_share_pct co2_s1 co2_s2 co2_total elec_purch_kwh elec_owngen_kwh
drop year
list period n_firms pct_any_gj gj_s1 gj_s2 gj_total s1_share_pct, clean noobs
export excel using "$B16_XLSX", sheet("t01_totals", replace) firstrow(variables)

* ---- 2. per-firm statistics, level & ln, pool + by year ----
use "$B16_DATA/b16_si.dta", clear
keep if clean == 1
local V "gj_s1 gj_s2 gj_total ln_gj_s1 ln_gj_s2 ln_gj_total gj_per_va gj_pw elec_purch_kwh elec_owngen_kwh elec_total_kwh ln_elec_total_kwh selfgen_share"
do "$B16/_sumstats.do" "`V'" "" "t01_stats"

* ---- 3. reported physical quantities ----
do "$B16/_sumstats.do" "fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr coal_kg_fix fuel_lpg_kg fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_natgas_mmbtu fuel_biodiesel_ltr" "" "t01_fuel_qty"
