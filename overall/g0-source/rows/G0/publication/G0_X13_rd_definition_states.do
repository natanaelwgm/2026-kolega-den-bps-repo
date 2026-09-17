* Tujuan: Pisahkan status jawaban R&D dari statistik uang; kode pertanyaan bukan biaya, dan kategori COSTRD tidak diperlakukan sebagai jumlah uang. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta; corrections/reports/__binary.dta; dan 1 masukan lain // WFDOC-INJECTED
* Output: corrections/reports/__binary.dta; corrections/reports/__rd_amount.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X13"
use "data/analysis/G0_analysis_ready.dta", clear
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable long rows long yes long no long unknown double positive_share using "corrections/reports/__binary.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & rd_activity_flag==1
    local yes=r(N)
    quietly count if source_year==`y' & rd_activity_flag==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("rd_activity_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & rd_external_funding_flag==1
    local yes=r(N)
    quietly count if source_year==`y' & rd_external_funding_flag==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("rd_external_funding_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
postclose `p'
use "corrections/reports/__binary.dta", clear
isid source_year variable
rename variable measure
rename yes yes_n
rename no no_n
rename unknown unknown_n
rename positive_share legacy_positive_share
generate long value_n=yes_n+no_n
generate str32 measure_kind="legacy_binary_diagnostic"
tempfile rd_binary
save `rd_binary'
use source_year source_row rd_cost_nominal val_costrd using "data/analysis/G0_analysis_ready.dta", clear
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 measure str32 measure_kind long rows long value_n long unknown_n double mean double p50 using "corrections/reports/__rd_amount.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly summarize rd_cost_nominal if source_year==`y', detail
    local n=r(N)
* Untuk rd_cost_nominal, catat jumlah baris, nilai terisi/kosong, rerata, dan p50; ukurannya tetap berlabel kandidat nominal lama, bukan persentase jawaban R&D. // WFDOC-INJECTED
    post `p' (`y') ("rd_cost_nominal") ("legacy_nominal_amount_candidate") (`total') (`n') (`total'-`n') (r(mean)) (r(p50))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly summarize val_costrd if source_year==`y', detail
    local n=r(N)
* Untuk val_costrd, catat hanya keberadaan kategori; nilai mean/p50 dikosongkan karena kategori bukan nominal uang. // WFDOC-INJECTED
    post `p' (`y') ("val_costrd") ("raw_category_presence_only") (`total') (`n') (`total'-`n') (.) (.)
}
postclose `p'
use "corrections/reports/__rd_amount.dta", clear
drop if measure=="rd_cost_nominal"
tempfile rd_categories
save `rd_categories'
use "corrections/reports/core_descriptive_statistics.dta", clear
keep if variable=="rd_cost_nominal"
rename variable measure
rename n value_n
rename missing_rows unknown_n
generate str32 measure_kind="legacy_nominal_amount_candidate"
keep source_year measure measure_kind rows value_n unknown_n mean p50 release_status
append using `rd_categories'
append using `rd_binary'
* Bawa batas interpretasi ke tiap baris: kandidat biaya tidak disamakan dengan kode kategori COSTRD atau prevalensi pertanyaan R&D. // WFDOC-INJECTED
generate str150 definition_status="Legacy candidate only; COSTRD category is never an amount; accepted RND17=2 universe and 2017 funding prevalence unavailable"
generate long not_asked_n=.
generate long accepted_eligible_n=.
generate double accepted_positive_share=.
isid source_year measure
save "corrections/reports/rd_definition_states.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X13"
capture log close G0CHILD
