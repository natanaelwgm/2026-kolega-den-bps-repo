* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_economic_fields.dta; dag/data/word_data/G0/G0_energy_emissions.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_derived_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
use "$G0D/G0_economic_fields.dta", clear
merge 1:1 source_year source_row using "$G0D/G0_energy_emissions.dta", assert(match) nogen
* Domain-safe status definitions; no invalid code interpreted as observed no.
generate byte export_share_valid=inrange(export_share_pct,0,100)
generate byte export_binary_valid=inlist(export_binary_raw,0,1,2)
generate byte export_flag_conditional=export_share_pct>0 if export_share_valid
replace export_flag_conditional=export_binary_raw==1 if missing(export_flag_conditional) & export_binary_valid
generate byte export_definition_conflict=export_flag_conditional!=(export_binary_raw==1) if export_share_valid & export_binary_valid
replace export_flag_conditional=. if export_definition_conflict==1
generate byte export_binary_assumed_flag=export_binary_raw==1 if export_binary_valid
* Main definition uses verified numeric percentage domain only. Binary codes are unverified sensitivity.
generate byte export_flag=export_share_pct>0 if export_share_valid
generate byte export_observed=!missing(export_flag)
generate str80 export_definition_status=cond(export_share_valid,"valid_numeric_share_only","main_unavailable; binary_interpretation_unverified")
label variable export_flag_conditional "Sensitivity: assumed binary 0/2=no 1=yes, combined with share"
label variable export_binary_assumed_flag "Sensitivity only: unverified binary 0/1/2 interpretation"
label variable export_definition_conflict "Diagnostic disagreement under assumed binary code; not certified error"
label variable export_binary_valid "In assumed 0/1/2 domain; source code meanings not validated"
generate byte import_flag=import_value_nominal>0 if import_value_nominal>=0 & !missing(import_value_nominal)
generate byte import_observed=!missing(import_flag)
generate byte fdi_any_flag=foreign_ownership_pct>0 if inrange(foreign_ownership_pct,0,100)
generate byte fdi_10_flag=foreign_ownership_pct>=10 if inrange(foreign_ownership_pct,0,100)
generate byte fdi_observed=!missing(fdi_10_flag)
generate byte large_gt100_flag=workers>100 if workers>=0 & !missing(workers)
generate double accounting_gap=gross_output_nominal-value_added_nominal-intermediate_inputs_nominal
generate byte accounting_identity_valid=abs(accounting_gap)<.000001 if !missing(accounting_gap)
generate str80 inputs_definition_status="IINPUT reported total inputs; not a validated TFP materials proxy"
* Owner/manager capital correction grounded in original questionnaires 2010-2012.
generate double capital_prior_mixed_nominal=capital_nominal
generate byte capital_stock_verified=inrange(source_year,2010,2012) & st_capital_stock_nominal!=4
generate byte capital_additions_verified=inrange(source_year,2010,2012) & st_capital_additions_nominal!=4
generate str80 capital_definition_status=cond(source_year<=2012,"stock_V1115_and_additions_CTTTCU_verified_questionnaire","later_same_code_candidates_unverified_questionnaire")
generate str80 capital_prior_status="uncertified_mixed_prior_map; not_capital_stock_intensity"
generate byte worker_denominator_state=cond(missing(workers),3,cond(workers==0,1,cond(workers<0,2,0)))
local numerators "value_added_nominal gross_output_nominal capital_nominal intermediate_inputs_nominal rd_cost_nominal energy_expenditure_rp000 total_gj_s1 co2_total_s1"
local outputs "labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal inputs_per_worker_nominal rd_cost_per_worker_nominal energy_cost_per_worker total_gj_per_worker co2_per_worker"
* Ulangi blok untuk setiap i dari 1 sampai 8. // WFDOC-INJECTED
forvalues i=1/8 {
    local v: word `i' of `numerators'
    local t: word `i' of `outputs'
    generate double `t'=`v'/workers if worker_denominator_state==0 & !missing(`v')
}
* Ulangi blok untuk v: stock, additions. // WFDOC-INJECTED
foreach v in stock additions {
    generate double capital_`v'_per_worker=capital_`v'_nominal/workers if worker_denominator_state==0 & !missing(capital_`v'_nominal)
    generate double ln_capital_`v'_nominal=ln(capital_`v'_nominal) if capital_`v'_nominal>0 & !missing(capital_`v'_nominal)
    label variable capital_`v'_nominal "Capital `v' candidate; definition verified 2010-2012 only"
    label variable capital_`v'_per_worker "Capital `v' candidate / worker; definition verified 2010-2012 only"
    label variable ln_capital_`v'_nominal "ln capital `v' candidate; positive values; verified 2010-2012 only"
}
generate double value_added_share_of_output=value_added_nominal/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,value_added_nominal)
generate double energy_intensity_monetary=energy_expenditure_rp000/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,energy_expenditure_rp000)
generate double energy_intensity_gj_nominal=total_gj_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,total_gj_s1)
generate double co2_intensity_nominal=co2_total_s1/gross_output_nominal if gross_output_nominal>0 & !missing(gross_output_nominal,co2_total_s1)
local vals "gross_output_nominal value_added_nominal capital_nominal intermediate_inputs_nominal workers total_gj_s1 co2_total_s1 energy_expenditure_rp000 import_value_nominal rd_cost_nominal"
local logs "ln_output_nominal ln_va_nominal ln_capital_nominal ln_inputs_nominal ln_workers ln_total_gj_s1 ln_co2_total_s1 ln_energy_expenditure ln_import_nominal ln_rd_cost_nominal"
* Ulangi blok untuk setiap i dari 1 sampai 10. // WFDOC-INJECTED
forvalues i=1/10 {
    local v: word `i' of `vals'
    local l: word `i' of `logs'
    generate double `l'=ln(`v') if `v'>0 & !missing(`v')
    assert missing(`l') if `v'<=0 | missing(`v')
}
* Ulangi blok sesuai rentang atau daftar yang ditetapkan di baris ini. // WFDOC-INJECTED
foreach v of varlist val_* {
    generate double ln_`v'=ln(`v') if `v'>0 & !missing(`v')
    generate double pw_`v'=`v'/workers if worker_denominator_state==0 & !missing(`v')
}
* Diagnose economic tails within year; do not delete or winsorize.
* Ulangi blok untuk v: gross_output_nominal, value_added_nominal, capital_nominal, workers. // WFDOC-INJECTED
foreach v in gross_output_nominal value_added_nominal capital_nominal workers {
    bysort source_year: egen double __p99=pctile(`v'), p(99)
    generate byte out_`v'=`v'>10*__p99 & !missing(`v',__p99) & __p99>0
    drop __p99
}
isid source_year source_row
save "$G0D/G0_derived_fields.dta", replace
