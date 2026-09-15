* Tujuan: Hitung ya, tidak, dan unknown per tahun; bagian positif memakai penyebut ya+tidak, sedangkan bagian unknown memakai semua baris. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/flag_rates.dta; corrections/data/C170.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C170_flag_rates"
* Hitung jumlah ya, tidak, dan tidak diketahui; persentase memakai penyebut jawaban ya+tidak, bukan seluruh baris. // WFDOC-INJECTED
use  using "data/analysis/G0_analysis_ready.dta", clear
tempname p
postfile `p' int source_year str32 variable long n_positive long n_zero long n_unknown long n_observed double share_positive_observed double share_unknown_all using "corrections/reports/flag_rates.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & own_gen_positive_reported==1
    local yes=r(N)
    quietly count if source_year==`y' & own_gen_positive_reported==0
    local no=r(N)
    quietly count if source_year==`y' & missing(own_gen_positive_reported)
    local unknown=r(N)
    assert `yes'+`no'+`unknown'==`total'
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("own_gen_positive_reported") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & any_negative_observed==1
    local yes=r(N)
    quietly count if source_year==`y' & any_negative_observed==0
    local no=r(N)
    quietly count if source_year==`y' & missing(any_negative_observed)
    local unknown=r(N)
    assert `yes'+`no'+`unknown'==`total'
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("any_negative_observed") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & any_negative_decision==1
    local yes=r(N)
    quietly count if source_year==`y' & any_negative_decision==0
    local no=r(N)
    quietly count if source_year==`y' & missing(any_negative_decision)
    local unknown=r(N)
    assert `yes'+`no'+`unknown'==`total'
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("any_negative_decision") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & all_applicable_tests_observed==1
    local yes=r(N)
    quietly count if source_year==`y' & all_applicable_tests_observed==0
    local no=r(N)
    quietly count if source_year==`y' & missing(all_applicable_tests_observed)
    local unknown=r(N)
    assert `yes'+`no'+`unknown'==`total'
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("all_applicable_tests_observed") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y'
    local total=r(N)
    quietly count if source_year==`y' & va_abs_tail_flag==1
    local yes=r(N)
    quietly count if source_year==`y' & va_abs_tail_flag==0
    local no=r(N)
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
    local unknown=r(N)
    assert `yes'+`no'+`unknown'==`total'
* Penyebut share teramati hanya menjumlahkan jawaban ya+tidak; unknown dikeluarkan dari share itu. // WFDOC-INJECTED
    local n=`yes'+`no'
* Simpan share ya di antara jawaban teramati dan share unknown di antara semua baris tahun ini. // WFDOC-INJECTED
    post `p' (`y') ("va_abs_tail_flag") (`yes') (`no') (`unknown') (`n') (cond(`n'>0,`yes'/`n',.)) (`unknown'/`total')
}
postclose `p'
use "corrections/reports/flag_rates.dta", clear
isid source_year variable
keep source_year variable n_positive n_zero n_unknown n_observed share_positive_observed share_unknown_all
order source_year variable
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C170_flag_rates" "C170"
