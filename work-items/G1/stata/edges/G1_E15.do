* WFDOC: g1_predicted_* hanya menandai ketersediaan nilai TFP nonmissing, bukan eligibility atau status konvergensi.
* WFDOC: Specification, normalisasi, dan measure_type menyatakan target; residual struktural masih ditandai NOT_ESTIMATED.
foreach m in op lp acf wrdg {
    assert missing(tfp_`m')
    gen byte g1_predicted_`m' = !missing(tfp_`m')
}
gen str32 g1_specification_id = "VA_CD_d3_pinned2018"
gen str40 g1_normalization_id = "raw_structural_log_VA_residual"
gen str45 g1_measure_type = "structural_log_VA_residual_NOT_ESTIMATED"
save "$G1_RUN/S15_prediction_status.dta", replace
