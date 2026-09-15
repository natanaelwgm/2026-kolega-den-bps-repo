* Tujuan: Bandingkan statistik nilai tambah bertanda dengan/ tanpa nilai di atas 10 kali ambang persentil ke-99 per tahun. // WFDOC-INJECTED
* Input: data/analysis/signed_thresholds.dta; data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/outlier_signed_thresholds.dta; corrections/reports/__outlier.dta; dan 1 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X11"
use "data/analysis/signed_thresholds.dta", clear
save "corrections/reports/outlier_signed_thresholds.dta", replace
use "data/analysis/G0_analysis_ready.dta", clear
* Pasangkan satu ambang p99 nilai absolut untuk tiap tahun ke baris master pada tahun sama. // WFDOC-INJECTED
merge m:1 source_year using "data/analysis/signed_thresholds.dta", assert(match) nogen keepusing(p99_abs_va)
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 variable str40 variant long n double mean double p1 double p25 double p50 double p75 double p99 double min double max double threshold long flagged_n long missing_flag_n using "corrections/reports/__outlier.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_va==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_va)
    local flagmissing=r(N)
    quietly summarize p99_econ_va if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize value_added_nominal if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("value_added_nominal") ("reported_signed") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_va==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_va)
    local flagmissing=r(N)
    quietly summarize p99_econ_va if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize clean_va_nominal if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_va_nominal") ("inherited_negative_exclusion") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & va_abs_tail_flag==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
    local flagmissing=r(N)
    quietly summarize p99_abs_va if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize va_signed_nominal if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("va_signed_nominal") ("signed_preserved") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & va_abs_tail_flag==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(va_abs_tail_flag)
    local flagmissing=r(N)
    quietly summarize p99_abs_va if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize va_signed_tail_sensitivity if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("va_signed_tail_sensitivity") ("absolute_tail_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_workers==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_workers)
    local flagmissing=r(N)
    quietly summarize p99_econ_workers if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize workers if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("workers") ("reported_worker_candidate") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_workers==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_workers)
    local flagmissing=r(N)
    quietly summarize p99_econ_workers if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize clean_workers_count if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_workers_count") ("inherited_worker_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_stock==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_stock)
    local flagmissing=r(N)
    quietly summarize p99_econ_stock if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize capital_stock_nominal if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("capital_stock_nominal") ("reported_stock_candidate") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & out_checked_stock==1
    local flagged=r(N)
    quietly count if source_year==`y' & missing(out_checked_stock)
    local flagmissing=r(N)
    quietly summarize p99_econ_stock if source_year==`y', meanonly
    local cutoff=10*r(mean)
    quietly summarize clean_stock_nominal if source_year==`y', detail
    local n=r(N)
* Simpan statistik pada kelompok pembanding yang sedang dihitung bersama ambang dan jumlah baris bertanda. // WFDOC-INJECTED
    post `p' (`y') ("clean_stock_nominal") ("inherited_stock_sensitivity") (`n') (r(mean)) (r(p1)) (r(p25)) (r(p50)) (r(p75)) (r(p99)) (r(min)) (r(max)) (`cutoff') (`flagged') (`flagmissing')
}
postclose `p'
use "corrections/reports/__outlier.dta", clear
generate str35 release_status="legacy_candidate_display_only"
isid source_year variable variant
save "corrections/reports/outlier_sensitivity.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X11"
capture log close G0CHILD
