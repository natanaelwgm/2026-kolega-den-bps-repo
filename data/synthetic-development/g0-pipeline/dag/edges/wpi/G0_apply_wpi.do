* Runs after verified annual mappings and working-field integration.
log using "dag/logs/G0_wpi_application.log", text replace
use "$G0D/G0_main_candidate.dta", clear
isid source_year source_row
* Old missing-only real fields were compressed to byte; widen BEFORE calculations.
recast double deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real
merge m:1 industry_code using "dag/data/references/WPI_fixture_bridge.dta", keep(master match) generate(wpi_bridge_merge)
merge m:1 isic4 source_year using "dag/data/references/WPI_output_lookup.dta", keep(master match) generate(wpi_index_merge)
rename isic4 wpi_isic4
assert _N==1200
isid source_year source_row
replace deflator_output=wpi_output_index/100 if wpi_output_index>0 & !missing(wpi_output_index)
replace deflator_applied=!missing(deflator_output)
replace gross_output_real=gross_output_nominal/deflator_output if deflator_output>0 & !missing(deflator_output,gross_output_nominal)
* Explicit single-output-deflator VA approximation; NOT double deflation.
replace value_added_real=value_added_nominal/deflator_output if deflator_output>0 & !missing(deflator_output,value_added_nominal)
replace deflator_status="output_WPI_2000; VA_single_deflator_proxy; input_capital_wages_absent" if deflator_applied
replace deflator_status="WPI_unmatched_industry_or_year; no_identity_deflator" if !deflator_applied
replace legacy_output_wpi_year_exists=!missing(wpi_output_index)
replace legacy_input_wpi_year_exists=0
generate byte real_va_is_single_proxy=deflator_applied
generate byte real_va_double_deflated=0
generate double ln_output_real=ln(gross_output_real) if gross_output_real>0 & !missing(gross_output_real)
generate double ln_va_real_proxy=ln(value_added_real) if value_added_real>0 & !missing(value_added_real)
generate double output_real_per_worker=gross_output_real/workers if workers>0 & !missing(workers,gross_output_real)
generate double va_real_proxy_per_worker=value_added_real/workers if workers>0 & !missing(workers,value_added_real)
generate double gj_per_real_output=total_gj_s1/gross_output_real if gross_output_real>0 & !missing(gross_output_real,total_gj_s1)
generate double co2_per_real_output=co2_total_s1/gross_output_real if gross_output_real>0 & !missing(gross_output_real,co2_total_s1)
label variable gross_output_real "SYNTHETIC output at 2000 Rp000; actual WPI; fixture sector bridge"
label variable value_added_real "SYNTHETIC VA at 2000 Rp000: single OUTPUT deflator PROXY, not double"
label variable deflator_output "Output conversion factor = WPI index (2000=100) / 100"
label variable real_va_is_single_proxy "1: VA divided by output deflator; approximation, not double deflation"
label variable gj_per_real_output "Partial nine-fuel GJ / output at 2000 Rp000; inherited factor assumptions"
label variable co2_per_real_output "Partial combustion CO2 / output at 2000 Rp000; inherited assumptions"
assert wpi_bridge_merge==3 & wpi_index_merge==3 & deflator_applied==1
foreach absent in deflator_inputs deflator_capital deflator_wages capital_real intermediate_inputs_real {
 assert missing(`absent')
}
assert abs(gross_output_real*deflator_output-gross_output_nominal)<1e-7
assert abs(value_added_real*deflator_output-value_added_nominal)<1e-7
preserve
generate byte wpi_matched=deflator_applied
generate byte wpi_unmatched=!deflator_applied
collapse (count) rows=source_row (sum) matched=wpi_matched unmatched=wpi_unmatched (mean) wpi_output_index, by(source_year industry_code wpi_isic4 wpi_spliced wpi_mapping_status)
isid source_year industry_code
assert rows==25 & matched==25 & unmatched==0
export delimited "results/wpi_merge_audit.csv", replace
restore
save "$G0D/G0_wpi_applied.dta", replace
save "$G0D/G0_main_candidate.dta", replace
preserve
use "dag/data/references/WPI_output_lookup.dta", clear
keep if inlist(isic4,1511,1711,2411,2811)
twoway (connected wpi_output_index source_year if isic4==1511) (connected wpi_output_index source_year if isic4==1711) (connected wpi_output_index source_year if isic4==2411) (connected wpi_output_index source_year if isic4==2811), title("Actual output WPI used on synthetic firms") ytitle("Index: 2000=100") xtitle("Year") legend(order(1 "Meat 1511" 2 "Textiles 1711" 3 "Chemicals 2411" 4 "Metal structures 2811") rows(2)) xline(2019.5, lpattern(dash)) note("2016 unavailable; 2020-2022 use supplied splice. No firm findings.") graphregion(color(white))
graph export "dag/reports/word_data/G0/20260910-code-verification/wpi_index_by_sector.png", width(1800) replace
restore
display "G0_WPI_APPLICATION_PASS 1200 output and single-deflator VA proxy values"
log close
