version 17
args mode
if "$DS_RUN"=="" error 198
* Preserve source values/uncertainty. No imputation, deflation or new estimation.
do "$DS_ROOT/downstream/code/missing_`mode'.do"
do "$DS_ROOT/downstream/code/labels.do"
if "`mode'"=="actual" {
 generate str80 dev_panel_stratum=""
 generate str80 dev_prev_obs_id=""
 generate int dev_prev_year=.
 generate str80 dev_link_status="not_available_actual"
}
generate byte g1_results_attached=("`mode'"=="development")
generate byte g1_real_tfp_ready=0
foreach m in op lp acf wrdg {
 if "`mode'"=="actual" assert missing(dev_nominal_tfp_`m')
 label variable dev_nominal_tfp_`m' "G1 `m' nominal development residual; NOT verified real TFP"
}
label variable g1_results_attached "Existing nominal DEVELOPMENT G1 results attached"
label variable g1_real_tfp_ready "Real TFP readiness: false; deflated estimates not admitted"
order obs_id firm_id year province_code district_code industry_code industry2_reported dataset_mode panel_id_synthetic panel_empirical_ready workers gross_output_nominal value_added_nominal va_signed_nominal intermediate_inputs_nominal capital_stock_nominal capital_additions_nominal export_share_pct import_value_nominal foreign_ownership_pct
char _dta[scope] "Structural dataset; variable/year and model-specific admission required"
char _dta[identity] "Actual: unlinked. Development: fictional IDs and perturbed values."
char _dta[calendar] "2010-2015,2017-2022; 2016 missing"
char _dta[source_path] "$DS_ACTUAL"
if "`mode'"=="development" char _dta[source_path] "$DS_G1"
label data "`mode': G0/G1 source projection; NOT all empirical analyses"
noisily display as result "FEATURES OK | `mode' | source values preserved"
