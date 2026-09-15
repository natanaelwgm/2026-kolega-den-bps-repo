* Tujuan: Periksa bahwa belum ada deflator diterapkan dan nilai riil masih kosong; laporkan jumlah nominal, yang layak harga, dan nilai riil per tahun. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__real_gates.dta; corrections/reports/nominal_real_gate.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X18"
use source_year source_row gross_output_nominal value_added_nominal capital_stock_nominal capital_additions_nominal gross_output_real value_added_real capital_real deflator_applied using "data/analysis/G0_analysis_ready.dta", clear
* Pastikan nilai riil tetap kosong dan flag deflator nol; laporan ini memeriksa gerbang, bukan mengubah nominal menjadi riil. // WFDOC-INJECTED
assert deflator_applied==0 & missing(gross_output_real) & missing(value_added_real) & missing(capital_real)
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 concept long nominal_n long price_eligible_n long real_n double index_value str100 gate_status using "corrections/reports/__real_gates.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(gross_output_nominal)
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("reported_output_income") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(value_added_nominal)
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("reported_value_added") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(capital_stock_nominal)
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("capital_stock_candidate") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(capital_additions_nominal)
* Catat nilai nominal, jumlah yang layak harga, nilai riil, indeks, dan alasan gerbang per tahun. // WFDOC-INJECTED
    post `p' (`y') ("capital_additions_candidate") (r(N)) (0) (0) (.) ("No accepted price concept/link; no real series constructed; nominal concept remains candidate")
}
postclose `p'
use "corrections/reports/__real_gates.dta", clear
isid source_year concept
generate str70 approximation="No real approximation constructed; candidate nominal amounts only"
save "corrections/reports/nominal_real_gate.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X18"
capture log close G0CHILD
