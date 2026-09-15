log using "dag/logs/G0_preparation_gaps.log", text replace
use "$G0D/G0_main_candidate.dta", clear
do "dag/edges/G0_economic_clean_program.do"
g0_economic_clean
* Recompute every affected ratio/log after final annual field mapping. Clear stale domains.
replace worker_denominator_state=cond(missing(workers),3,cond(workers==0,1,cond(workers<0,2,0)))
local nums "value_added_nominal gross_output_nominal capital_nominal intermediate_inputs_nominal rd_cost_nominal energy_expenditure_rp000 total_gj_s1 co2_total_s1 capital_stock_nominal capital_additions_nominal"
local outs "labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal inputs_per_worker_nominal rd_cost_per_worker_nominal energy_cost_per_worker total_gj_per_worker co2_per_worker capital_stock_per_worker capital_additions_per_worker"
forvalues i=1/10 {
 local v: word `i' of `nums'
 local z: word `i' of `outs'
 replace `z'=.
 replace `z'=`v'/workers if workers>0 & !missing(workers,`v')
}
local vals "gross_output_nominal value_added_nominal capital_nominal intermediate_inputs_nominal workers total_gj_s1 co2_total_s1 energy_expenditure_rp000 import_value_nominal rd_cost_nominal capital_stock_nominal capital_additions_nominal"
local logs "ln_output_nominal ln_va_nominal ln_capital_nominal ln_inputs_nominal ln_workers ln_total_gj_s1 ln_co2_total_s1 ln_energy_expenditure ln_import_nominal ln_rd_cost_nominal ln_capital_stock_nominal ln_capital_additions_nominal"
forvalues i=1/12 {
 local v: word `i' of `vals'
 local z: word `i' of `logs'
 replace `z'=.
 replace `z'=ln(`v') if `v'>0 & !missing(`v')
}
foreach v of varlist val_* {
 replace ln_`v'=.
 replace ln_`v'=ln(`v') if `v'>0 & !missing(`v')
 replace pw_`v'=.
 replace pw_`v'=`v'/workers if workers>0 & !missing(workers,`v')
}
label variable capital_nominal "LEGACY mixed capital alias; use capital_stock_nominal or capital_additions_nominal"
label variable capital_per_worker_nominal "LEGACY mixed alias/worker; primary stock measure is capital_stock_per_worker"
label variable ln_capital_nominal "LEGACY mixed alias log; primary stock log is ln_capital_stock_nominal"
* Refresh energy diagnostics after unit corrections (old flag used pre-conversion prices).
replace any_negative_quantity=0
replace any_implausible_price=0
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas {
 local unit ltr
 if inlist("`f'","coal","lpg","coalbriq","coke","firewood","charcoal","natgas") local unit kg
 if inlist("`f'","citygas","othergas") local unit m3
 replace any_negative_quantity=1 if fuel_`f'_`unit'<0 & !missing(fuel_`f'_`unit')
 replace price_`f'=.
 replace price_`f'=fuel_`f'_rp000/fuel_`f'_`unit' if fuel_`f'_`unit'>0 & !missing(fuel_`f'_`unit',fuel_`f'_rp000) & fuel_`f'_rp000>=0
 drop p99_`f'
 bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
 replace any_implausible_price=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
}
foreach f in pln nonpln owngen {
 replace any_negative_quantity=1 if elec_`f'_kwh<0 & !missing(elec_`f'_kwh)
}
replace any_implausible_price=1 if price_elec>10*p99_elec & !missing(price_elec,p99_elec) & p99_elec>0
replace energy_outlier_flag=any_negative_quantity | any_implausible_price
replace cleaning_status="all_rows_kept; clean_*_sensitivity_excludes_flags"
replace extra_fuel_positive=0
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg fuel_natgas_mmbtu fuel_biomass_kg {
 replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
}
generate byte energy_all_sources_complete=0
label variable energy_all_sources_complete "0: additional fuels/heat, unit and factor evidence not complete; not zero use"
generate byte energy_unit_gap_2018_19=inlist(source_year,2018,2019)
generate byte grid_factor_is_carried=source_year>2014
label variable grid_factor_is_carried "1: inherited post-2014 grid factor carry; not observed annual grid factor"
generate double gj_scope1_complete9=gj_fuel_s1 if nine_fuels_complete & !energy_unit_gap_2018_19
generate double gj_scope2_complete=gj_electricity if electricity_n_observed==2
generate double co2_scope2_no_grid_carry=co2_scope2_complete if !grid_factor_is_carried
generate double total_gj_clean_sensitivity=total_gj_s1 if energy_outlier_flag==0
* Reuse LUDI 16_energy_intensity.do reference heat factors; keep outside main totals.
generate double gj_firewood_reference=fuel_firewood_kg*.0156 if fuel_firewood_kg>=0 & !missing(fuel_firewood_kg)
generate double gj_charcoal_reference=fuel_charcoal_kg*.0295 if fuel_charcoal_kg>=0 & !missing(fuel_charcoal_kg)
generate double gj_lubricant_potential=fuel_lubricant_ltr*.03538 if fuel_lubricant_ltr>=0 & !missing(fuel_lubricant_ltr)
label variable gj_scope1_complete9 "Nine-fuel GJ only; all nine observed; excludes 2018/19 unit gap; factors conditional"
label variable gj_scope2_complete "Purchased electricity GJ; both PLN/non-PLN observed; own generation excluded"
label variable co2_scope2_no_grid_carry "Purchased-electricity CO2 subset with inherited observed-period grid factors"
label variable gj_firewood_reference "Reference wood GJ, IPCC 15.6 GJ/t; excluded from legacy total; units conditional"
label variable gj_charcoal_reference "Reference charcoal GJ, IPCC 29.5 GJ/t; excludes mixed biomass; units conditional"
label variable gj_lubricant_potential "Potential heat only, NOT actual combustion: LUDI .03538 GJ/litre"
label variable co2_scope1_complete "Complete NINE-FUEL subtotal only; not all Scope1 sources; factor assumptions"
label variable co2_total_complete "NINE-FUEL + purchased-electricity subtotal; not comprehensive emissions"
label variable total_gj_complete "NINE-FUEL + purchased-electricity subtotal; extra fuels/heat not certified"
label variable co2_scope1_s1 "Observed nine-fuel combustion CO2 tonnes, partial, factor scenario1; not CO2e"
label variable co2_scope2_s1 "Purchased-electricity CO2 tonnes, partial and grid carry scenario1"
label variable co2_total_s1 "Partial nine-fuel + purchased-electricity CO2 tonnes; no own-generation addition"
assert own_generation_added==0
isid source_year source_row
save "$G0D/G0_preparation_completed.dta", replace
save "$G0D/G0_main_candidate.dta", replace
preserve
collapse (count) rows=source_row (sum) out_checked_* energy_outlier_flag extra_fuel_positive (count) stock_observed=capital_stock_nominal additions_observed=capital_additions_nominal, by(source_year)
export delimited "results/preparation_gap_controls.csv", replace
restore
display "G0_PREPARATION_GAPS_PASS"
log close
