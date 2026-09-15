* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
do "dag/edges/wpi/G0_stage_wpi.do"
* Independently blocked price branch. Legacy files located; new uploaded input not verified.
use "$G0D/G0_economic_fields.dta", clear
keep source_year source_row
foreach v in deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real {
    generate double `v'=.
}
generate byte deflator_applied=0
generate str80 deflator_status="WPI_staged; awaiting_verified_annual_mapping_before_deflation"
generate byte legacy_output_wpi_year_exists=0
generate byte legacy_input_wpi_year_exists=0
save "$G0D/G0_deflator_fields.dta", replace
preserve
collapse (count) observations=source_row (sum) real_rows=deflator_applied, by(source_year deflator_status legacy_output_wpi_year_exists legacy_input_wpi_year_exists)
export delimited using "$G0R/deflator_coverage.csv", replace
restore
