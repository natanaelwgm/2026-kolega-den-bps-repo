* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* Adapt E006-E017 onto provenance key, preserving inputs and explicit missingness.
use "$G0D/G0_energy_fields.dta", clear
generate byte any_negative_quantity=0
generate byte any_implausible_price=0
foreach v of varlist fuel_* elec_* {
    generate double cl_`v'=`v' if `v'>=0 & !missing(`v')
}
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke firewood charcoal dieseloil fueloil lubricant biodiesel natgas {
    local unit ltr
    if inlist("`f'","coal","lpg","coalbriq","coke","firewood","charcoal","natgas") local unit kg
    if inlist("`f'","citygas","othergas") local unit m3
    replace any_negative_quantity=1 if fuel_`f'_`unit'<0 & !missing(fuel_`f'_`unit')
    generate double price_`f'=fuel_`f'_rp000/fuel_`f'_`unit' if fuel_`f'_`unit'>0 & !missing(fuel_`f'_`unit',fuel_`f'_rp000) & fuel_`f'_rp000>=0
    bysort source_year: egen double p99_`f'=pctile(price_`f'), p(99)
    replace any_implausible_price=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
}
foreach f in pln nonpln owngen {
    replace any_negative_quantity=1 if elec_`f'_kwh<0 & !missing(elec_`f'_kwh)
}
generate double price_elec=elec_pln_rp000/elec_pln_kwh if elec_pln_kwh>0 & !missing(elec_pln_kwh,elec_pln_rp000) & elec_pln_rp000>=0
bysort source_year: egen double p99_elec=pctile(price_elec), p(99)
replace any_implausible_price=1 if price_elec>10*p99_elec & !missing(price_elec,p99_elec) & p99_elec>0
generate byte energy_outlier_flag=any_negative_quantity | any_implausible_price
generate byte energy_outlier_flag_legacy=0
foreach f in diesel petrol kerosene coal lpg citygas othergas coalbriq coke elec {
    replace energy_outlier_flag_legacy=1 if price_`f'>10*p99_`f' & !missing(price_`f',p99_`f') & p99_`f'>0
}
foreach v in fuel_diesel_ltr fuel_petrol_ltr fuel_kerosene_ltr fuel_coal_kg fuel_lpg_kg fuel_citygas_m3 fuel_othergas_m3 fuel_coalbriq_kg fuel_coke_kg fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr elec_pln_kwh elec_nonpln_kwh elec_owngen_kwh {
    replace energy_outlier_flag_legacy=1 if `v'<0 & !missing(`v')
}
generate str80 outlier_rule="negative_or_gt10x_year_p99; all_mapped_prices; legacy_flag_separate"

generate str48 cleaning_status="retained_all_rows; negatives_excluded_in_cl_fields"
* Legacy 9-fuel factors. Original source quantity remains untouched.
local fuels "diesel petrol kerosene coal lpg citygas othergas coalbriq coke"
local units "ltr ltr ltr kg kg m3 m3 kg kg"
local c1 ".002654 .00231 .002494 .002496 .002876 .002695 .002695 .002877 .00284"
local c2 ".002978 .002479 .002616 .002448 .003293 .00219 .00219 .002032 .002907"
local gj ".035697 .033225 .034559 .0262 .045544 .048 .048 .029308 .026377"
forvalues i=1/9 {
    local f: word `i' of `fuels'
    local u: word `i' of `units'
    local a: word `i' of `c1'
    local b: word `i' of `c2'
    local c: word `i' of `gj'
    generate double co2_`f'_s1=cl_fuel_`f'_`u'*`a'
    generate double co2_`f'_s2=cl_fuel_`f'_`u'*`b'
    generate double gj_`f'=cl_fuel_`f'_`u'*`c'
}
egen byte co2_scope1_nfuels_s1=rownonmiss(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1)
egen double co2_scope1_s1=rowtotal(co2_diesel_s1 co2_petrol_s1 co2_kerosene_s1 co2_coal_s1 co2_lpg_s1 co2_citygas_s1 co2_othergas_s1 co2_coalbriq_s1 co2_coke_s1), missing
egen double co2_scope1_s2=rowtotal(co2_diesel_s2 co2_petrol_s2 co2_kerosene_s2 co2_coal_s2 co2_lpg_s2 co2_citygas_s2 co2_othergas_s2 co2_coalbriq_s2 co2_coke_s2), missing
egen double gj_fuel_s1=rowtotal(gj_diesel gj_petrol gj_kerosene gj_coal gj_lpg gj_citygas gj_othergas gj_coalbriq gj_coke), missing
generate byte nine_fuels_complete=co2_scope1_nfuels_s1==9
egen byte electricity_n_observed=rownonmiss(cl_elec_pln_kwh cl_elec_nonpln_kwh)
egen double elec_purchased_kwh=rowtotal(cl_elec_pln_kwh cl_elec_nonpln_kwh), missing
generate double gj_electricity=elec_purchased_kwh*.0036
generate double co2_scope2_s1=elec_purchased_kwh*grid_factor_s1
generate double co2_scope2_s2=elec_purchased_kwh*grid_factor_s2
generate double co2_total_s1=co2_scope1_s1+co2_scope2_s1
generate double co2_total_s2=co2_scope1_s2+co2_scope2_s2
generate double total_gj_s1=gj_fuel_s1+gj_electricity
generate double co2_scope1_complete=co2_scope1_s1 if nine_fuels_complete
generate double co2_scope2_complete=co2_scope2_s1 if electricity_n_observed==2
generate double co2_total_complete=co2_scope1_complete+co2_scope2_complete
generate double total_gj_complete=total_gj_s1 if nine_fuels_complete & electricity_n_observed==2
generate double co2_variant_static_grid=co2_scope1_s1+co2_scope2_s2
generate byte own_generation_reported=cl_elec_owngen_kwh>0 & !missing(cl_elec_owngen_kwh)
generate byte own_generation_added=0
generate byte extra_fuel_positive=0
foreach v in fuel_firewood_kg fuel_charcoal_kg fuel_dieseloil_ltr fuel_fueloil_ltr fuel_lubricant_ltr fuel_biodiesel_ltr fuel_natgas_kg {
    replace extra_fuel_positive=1 if `v'>0 & !missing(`v')
}
generate str80 energy_coverage_status="observed_components_only; absent_fuels_not_assumed_zero"
replace energy_coverage_status="nine_fuels_complete; additional_fuels_and_heat_not_certified" if nine_fuels_complete
* E017 corrected alternative bases; extended component reconciliation adds mapped new fuels.
egen double fuel_components_rp000=rowtotal(cl_fuel_diesel_rp000 cl_fuel_petrol_rp000 cl_fuel_kerosene_rp000 cl_fuel_coal_rp000 cl_fuel_lpg_rp000 cl_fuel_citygas_rp000 cl_fuel_othergas_rp000 cl_fuel_coalbriq_rp000 cl_fuel_coke_rp000 cl_fuel_firewood_rp000 cl_fuel_charcoal_rp000 cl_fuel_dieseloil_rp000 cl_fuel_fueloil_rp000 cl_fuel_lubricant_rp000 cl_fuel_other_rp000), missing
egen double fuel_components_extended=rowtotal(fuel_components_rp000 cl_fuel_biodiesel_rp000 cl_fuel_natgas_rp000), missing
generate double fuel_expenditure_rp000=cl_fuel_total_reported_rp000
generate str40 fuel_expenditure_basis="reported_total"
replace fuel_expenditure_rp000=fuel_components_extended if missing(fuel_expenditure_rp000)
replace fuel_expenditure_basis="observed_components_fallback" if missing(cl_fuel_total_reported_rp000) & !missing(fuel_components_extended)
replace fuel_expenditure_basis="unavailable" if missing(fuel_expenditure_rp000)
generate double fuel_reconciliation_gap=cl_fuel_total_reported_rp000-fuel_components_rp000
generate double fuel_reconciliation_gap_extended=cl_fuel_total_reported_rp000-fuel_components_extended
egen double electricity_expenditure_rp000=rowtotal(cl_elec_pln_rp000 cl_elec_nonpln_rp000), missing
egen byte electricity_cost_n_observed=rownonmiss(cl_elec_pln_rp000 cl_elec_nonpln_rp000)
generate double energy_expenditure_rp000=fuel_expenditure_rp000+electricity_expenditure_rp000
assert co2_total_s1==co2_scope1_s1+co2_scope2_s1
assert total_gj_s1==gj_fuel_s1+gj_electricity
assert energy_expenditure_rp000==fuel_expenditure_rp000+electricity_expenditure_rp000
assert own_generation_added==0
isid source_year source_row
save "$G0D/G0_energy_emissions.dta", replace
