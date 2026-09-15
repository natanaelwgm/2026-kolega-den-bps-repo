* Tujuan: Hitung ringkasan yang didefinisikan di file ini dan tulis tabel keluaran pada nama/path yang tercantum di perintah ekspor. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: report/tables/new_token_field_coverage.dta; report/tables/new_token_field_coverage.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use source_year source_row rd17_own_token_class rd17_external_token_class using "data/analysis/G0_analysis_ready.dta", clear
tempname q
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `q' str32 variable int source_year long rows observed missing_rows using "report/tables/new_token_field_coverage.dta", replace
* Ulangi blok untuk v: rd17_own_token_class, rd17_external_token_class. // WFDOC-INJECTED
foreach v in rd17_own_token_class rd17_external_token_class {
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
 foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
  quietly count if source_year==`y'
  local n=r(N)
  quietly count if source_year==`y' & !missing(`v')
  post `q' ("`v'") (`y') (`n') (r(N)) (`n'-r(N))
 }
}
postclose `q'
use "report/tables/new_token_field_coverage.dta", clear
isid variable source_year
assert _N==24
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
export delimited using "report/tables/new_token_field_coverage.csv", datafmt quote replace
