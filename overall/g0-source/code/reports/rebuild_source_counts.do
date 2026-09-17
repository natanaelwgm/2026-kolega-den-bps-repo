* Tujuan: Hitung ringkasan yang didefinisikan di file ini dan tulis tabel keluaran pada nama/path yang tercantum di perintah ekspor. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_source_states.dta; dag/reports/word_data/G0/source_state_counts.csv // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "data/analysis/G0_analysis_ready.dta", clear
tempname s
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `s' int source_year str32 variable byte source_state long observations using "$G0D/G0_source_states.dta", replace
ds st_*
local states `r(varlist)'
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
* Ulangi blok untuk tiap v dalam daftar local states. // WFDOC-INJECTED
    foreach v of local states {
* Ulangi blok untuk setiap k dari 0 sampai 10. // WFDOC-INJECTED
        forvalues k=0/10 {
            quietly count if source_year==`y' & `v'==`k'
            post `s' (`y') ("`v'") (`k') (r(N))
        }
    }
}
postclose `s'
preserve
use "$G0D/G0_source_states.dta", clear
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
export delimited using "$G0R/source_state_counts.csv", replace
restore
