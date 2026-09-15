* Tujuan: Pisahkan jawaban ya, tidak, dan unknown untuk beberapa definisi ekspor; persentase memakai penyebut ya+tidak, dan definisi langsung tetap terpisah dari definisi any. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__binary.dta; corrections/reports/export_definition_states.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X12"
use "data/analysis/G0_analysis_ready.dta", clear
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable long rows long yes long no long unknown double positive_share using "corrections/reports/__binary.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & export_flag==1
    local yes=r(N)
    quietly count if source_year==`y' & export_flag==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & export_any_binary==1
    local yes=r(N)
    quietly count if source_year==`y' & export_any_binary==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_any_binary") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & v_export_any_binary==1
    local yes=r(N)
    quietly count if source_year==`y' & v_export_any_binary==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("v_export_any_binary") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & export_direct_flag==1
    local yes=r(N)
    quietly count if source_year==`y' & export_direct_flag==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_direct_flag") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & export_verified_conflict==1
    local yes=r(N)
    quietly count if source_year==`y' & export_verified_conflict==0
    local no=r(N)
* Unknown adalah sisa dari seluruh baris setelah jawaban ya dan tidak dihitung; missing tidak diubah menjadi tidak. // WFDOC-INJECTED
    local unknown=`total'-`yes'-`no'
* Catat jumlah ya/tidak/unknown dan share ya di antara jawaban yang diketahui; penyebut share tidak memasukkan unknown. // WFDOC-INJECTED
    post `p' (`y') ("export_verified_conflict") (`total') (`yes') (`no') (`unknown') (cond(`yes'+`no'>0,`yes'/(`yes'+`no'),.))
}
postclose `p'
use "corrections/reports/__binary.dta", clear
isid source_year variable
generate str100 definition_status="Any/direct/working/verified meanings separate; direct-no does not imply any-export-no"
rename variable measure
rename yes yes_n
rename no no_n
rename unknown unknown_n
* Penyebut teramati adalah ya+tidak; baris unknown tetap dilaporkan terpisah. // WFDOC-INJECTED
generate long observed_denominator=yes_n+no_n
save "corrections/reports/export_definition_states.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X12"
capture log close G0CHILD
