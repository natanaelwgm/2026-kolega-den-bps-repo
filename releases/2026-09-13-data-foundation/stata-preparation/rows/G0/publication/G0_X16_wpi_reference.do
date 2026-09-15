* Tujuan: Rapikan nama kolom pada referensi WPI output—industri, indeks, tahun dasar, dan status sambungan—tanpa menerapkan deflator ke data perusahaan. // WFDOC-INJECTED
* Input: references/WPI_output_lookup.dta // WFDOC-INJECTED
* Output: corrections/reports/wpi_reference.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L1:step-version" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L1:step-version" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 1 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L2:step-do" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L2:step-do" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 2 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L3:step-g0c_begin" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
g0c_begin "G0-X16"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L3:step-g0c_begin" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 3 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L4:step-use" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
use "references/WPI_output_lookup.dta", clear
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L4:step-use" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 4 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L5:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
rename isic4 industry_key
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L5:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 5 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L6:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
rename wpi_output_index index_value
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L6:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 6 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L7:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
rename wpi_base_year base_year
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L7:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 7 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L8:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
rename wpi_spliced splice_status
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L8:step-rename" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 8 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L9:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
generate str40 series_id="inherited_output_WPI_reference"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L9:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 9 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L10:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
generate str64 source_sha256="6e41ec26e960ac290b88844960229bba6d4b8b72e110b539e817e1046c60d3c1"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L10:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 10 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L11:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
generate str64 source_hash=source_sha256
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L11:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 11 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L12:step-recast" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
recast double index_value wpi_cagr
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L12:step-recast" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 12 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L13:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
generate str100 source_status="Actual macro reference; no accepted company bridge or price-concept admission"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L13:step-generate" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 13 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L14:step-isid" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
isid source_year industry_key
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L14:step-isid" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 14 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L15:step-save" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
save "corrections/reports/wpi_reference.dta", replace
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L15:step-save" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 15 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L16:step-display" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X16"
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L16:step-display" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 16 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rows/G0/publication/G0_X16_wpi_reference.do:L17:step-log" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture log close G0CHILD
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L17:step-log" "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "statement" 17 17 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rows/G0/publication/G0_X16_wpi_reference.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
