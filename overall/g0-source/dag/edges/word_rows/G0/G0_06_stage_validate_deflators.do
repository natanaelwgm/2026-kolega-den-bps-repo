* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_economic_fields.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_deflator_fields.dta; dag/reports/word_data/G0/deflator_coverage.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Independently blocked price branch. Legacy files located; new uploaded input not verified.
use "$G0D/G0_economic_fields.dta", clear
keep source_year source_row
* Ulangi blok untuk setiap v yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach v in deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real {
    generate double `v'=.
}
generate byte deflator_applied=0
generate str80 deflator_status="pending_uploaded_WPI_and_revision_bridge; no_real_values"
generate byte legacy_output_wpi_year_exists=source_year<=2012
generate byte legacy_input_wpi_year_exists=source_year<=2016
save "$G0D/G0_deflator_fields.dta", replace
preserve
collapse (count) observations=source_row (sum) real_rows=deflator_applied, by(source_year deflator_status legacy_output_wpi_year_exists legacy_input_wpi_year_exists)
export delimited using "$G0R/deflator_coverage.csv", replace
restore
