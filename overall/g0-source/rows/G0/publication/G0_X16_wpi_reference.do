* Tujuan: Rapikan nama kolom pada referensi WPI output—industri, indeks, tahun dasar, dan status sambungan—tanpa menerapkan deflator ke data perusahaan. // WFDOC-INJECTED
* Input: references/WPI_output_lookup.dta // WFDOC-INJECTED
* Output: corrections/reports/wpi_reference.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X16"
use "references/WPI_output_lookup.dta", clear
rename isic4 industry_key
rename wpi_output_index index_value
rename wpi_base_year base_year
rename wpi_spliced splice_status
generate str40 series_id="inherited_output_WPI_reference"
generate str64 source_sha256="6e41ec26e960ac290b88844960229bba6d4b8b72e110b539e817e1046c60d3c1"
generate str64 source_hash=source_sha256
recast double index_value wpi_cagr
generate str100 source_status="Actual macro reference; no accepted company bridge or price-concept admission"
isid source_year industry_key
save "corrections/reports/wpi_reference.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X16"
capture log close G0CHILD
