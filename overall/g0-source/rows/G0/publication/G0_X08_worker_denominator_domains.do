* Tujuan: Hitung pekerja positif, nol, negatif, dan missing per tahun agar pembagi yang layak dapat dibedakan dari yang tidak layak. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/__worker_ratio_domains.dta; corrections/reports/worker_denominator_domains.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "G0-X08"
use source_year source_row workers using "data/analysis/G0_analysis_ready.dta", clear
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long positive_workers_n=workers>0 & !missing(workers)
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long zero_workers_n=workers==0
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long negative_workers_n=workers<0 & !missing(workers)
* Hitung masing-masing pekerja positif, nol, negatif, atau missing; hanya nilai positif terisi yang dapat menjadi pembagi. // WFDOC-INJECTED
generate long missing_workers_n=missing(workers)
generate long rows=1
* Jumlahkan empat kategori menjadi hitungan per tahun; kategori tidak dilebur ke satu angka pekerja. // WFDOC-INJECTED
collapse (sum) rows positive_workers_n zero_workers_n negative_workers_n missing_workers_n, by(source_year)
assert positive_workers_n+zero_workers_n+negative_workers_n+missing_workers_n==rows
tempfile worker_domains
save `worker_domains'
use "data/analysis/G0_analysis_ready.dta", clear
tempname p
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
postfile `p' int source_year str32 ratio long ratio_eligible_n using "corrections/reports/__worker_ratio_domains.dta", replace
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_labor_productivity_nominal)
    post `p' (`y') ("r_labor_productivity_nominal") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_output_per_worker_nominal)
    post `p' (`y') ("r_output_per_worker_nominal") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_capital_per_worker_nominal)
    post `p' (`y') ("r_capital_per_worker_nominal") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_inputs_per_worker_nominal)
    post `p' (`y') ("r_inputs_per_worker_nominal") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_rd_cost_per_worker_nominal)
    post `p' (`y') ("r_rd_cost_per_worker_nominal") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_energy_cost_per_worker)
    post `p' (`y') ("r_energy_cost_per_worker") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_total_gj_per_worker)
    post `p' (`y') ("r_total_gj_per_worker") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_co2_per_worker)
    post `p' (`y') ("r_co2_per_worker") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_capital_stock_per_worker)
    post `p' (`y') ("r_capital_stock_per_worker") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_capital_additions_per_worker)
    post `p' (`y') ("r_capital_additions_per_worker") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cbdacu)
    post `p' (`y') ("r_pw_val_cbdacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cbfpcu)
    post `p' (`y') ("r_pw_val_cbfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cbsacu)
    post `p' (`y') ("r_pw_val_cbsacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cbttcu)
    post `p' (`y') ("r_pw_val_cbttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cldacu)
    post `p' (`y') ("r_pw_val_cldacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_clfpcu)
    post `p' (`y') ("r_pw_val_clfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_clsacu)
    post `p' (`y') ("r_pw_val_clsacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_clttcu)
    post `p' (`y') ("r_pw_val_clttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cmdacu)
    post `p' (`y') ("r_pw_val_cmdacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cmfpcu)
    post `p' (`y') ("r_pw_val_cmfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cmsacu)
    post `p' (`y') ("r_pw_val_cmsacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cmttcu)
    post `p' (`y') ("r_pw_val_cmttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_codacu)
    post `p' (`y') ("r_pw_val_codacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cofpcu)
    post `p' (`y') ("r_pw_val_cofpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cosacu)
    post `p' (`y') ("r_pw_val_cosacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_costrd)
    post `p' (`y') ("r_pw_val_costrd") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cottcu)
    post `p' (`y') ("r_pw_val_cottcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_csdacu)
    post `p' (`y') ("r_pw_val_csdacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_csfpcu)
    post `p' (`y') ("r_pw_val_csfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cssacu)
    post `p' (`y') ("r_pw_val_cssacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_csttcu)
    post `p' (`y') ("r_pw_val_csttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ctdacu)
    post `p' (`y') ("r_pw_val_ctdacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ctfpcu)
    post `p' (`y') ("r_pw_val_ctfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ctsacu)
    post `p' (`y') ("r_pw_val_ctsacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cttcu)
    post `p' (`y') ("r_pw_val_cttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ctttcu)
    post `p' (`y') ("r_pw_val_ctttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cvdacu)
    post `p' (`y') ("r_pw_val_cvdacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cvfpcu)
    post `p' (`y') ("r_pw_val_cvfpcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cvsacu)
    post `p' (`y') ("r_pw_val_cvsacu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_cvttcu)
    post `p' (`y') ("r_pw_val_cvttcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_devvcu)
    post `p' (`y') ("r_pw_val_devvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ecavce)
    post `p' (`y') ("r_pw_val_ecavce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ecavcu)
    post `p' (`y') ("r_pw_val_ecavcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvce)
    post `p' (`y') ("r_pw_val_ecbvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ecbvcu)
    post `p' (`y') ("r_pw_val_ecbvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eckvce)
    post `p' (`y') ("r_pw_val_eckvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eckvcu)
    post `p' (`y') ("r_pw_val_eckvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eclvce)
    post `p' (`y') ("r_pw_val_eclvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eclvcu)
    post `p' (`y') ("r_pw_val_eclvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_edivce)
    post `p' (`y') ("r_pw_val_edivce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_edivcu)
    post `p' (`y') ("r_pw_val_edivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_efovce)
    post `p' (`y') ("r_pw_val_efovce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_efovcu)
    post `p' (`y') ("r_pw_val_efovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_efuvce)
    post `p' (`y') ("r_pw_val_efuvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_efuvcu)
    post `p' (`y') ("r_pw_val_efuvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_egavce)
    post `p' (`y') ("r_pw_val_egavce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_egavcu)
    post `p' (`y') ("r_pw_val_egavcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_egovce)
    post `p' (`y') ("r_pw_val_egovce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_egovcu)
    post `p' (`y') ("r_pw_val_egovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_elpvce)
    post `p' (`y') ("r_pw_val_elpvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_elpvcu)
    post `p' (`y') ("r_pw_val_elpvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eluvce)
    post `p' (`y') ("r_pw_val_eluvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eluvcu)
    post `p' (`y') ("r_pw_val_eluvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_encvce)
    post `p' (`y') ("r_pw_val_encvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_encvcu)
    post `p' (`y') ("r_pw_val_encvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_engvce)
    post `p' (`y') ("r_pw_val_engvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_engvcu)
    post `p' (`y') ("r_pw_val_engvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_enpvcu)
    post `p' (`y') ("r_pw_val_enpvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eoivce)
    post `p' (`y') ("r_pw_val_eoivce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eoivcu)
    post `p' (`y') ("r_pw_val_eoivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_epevce)
    post `p' (`y') ("r_pw_val_epevce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_epevcu)
    post `p' (`y') ("r_pw_val_epevcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_eplvcu)
    post `p' (`y') ("r_pw_val_eplvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_esdvce)
    post `p' (`y') ("r_pw_val_esdvce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_esdvcu)
    post `p' (`y') ("r_pw_val_esdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_esovce)
    post `p' (`y') ("r_pw_val_esovce") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_esovcu)
    post `p' (`y') ("r_pw_val_esovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ibrvcu)
    post `p' (`y') ("r_pw_val_ibrvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_icovcu)
    post `p' (`y') ("r_pw_val_icovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_idevcu)
    post `p' (`y') ("r_pw_val_idevcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iinput)
    post `p' (`y') ("r_pw_val_iinput") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iinvcu)
    post `p' (`y') ("r_pw_val_iinvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iisfov)
    post `p' (`y') ("r_pw_val_iisfov") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iislov)
    post `p' (`y') ("r_pw_val_iislov") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iisvcu)
    post `p' (`y') ("r_pw_val_iisvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ikivcu)
    post `p' (`y') ("r_pw_val_ikivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iklvcu)
    post `p' (`y') ("r_pw_val_iklvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ikovcu)
    post `p' (`y') ("r_pw_val_ikovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ilrvcu)
    post `p' (`y') ("r_pw_val_ilrvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_insvcu)
    post `p' (`y') ("r_pw_val_insvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_intvcu)
    post `p' (`y') ("r_pw_val_intvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iotvcu)
    post `p' (`y') ("r_pw_val_iotvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ipkvcu)
    post `p' (`y') ("r_pw_val_ipkvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iprvcu)
    post `p' (`y') ("r_pw_val_iprvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_irdvcu)
    post `p' (`y') ("r_pw_val_irdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_irevcu)
    post `p' (`y') ("r_pw_val_irevcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_irrvcu)
    post `p' (`y') ("r_pw_val_irrvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_itxvcu)
    post `p' (`y') ("r_pw_val_itxvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_iuwvcu)
    post `p' (`y') ("r_pw_val_iuwvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_nopvcu)
    post `p' (`y') ("r_pw_val_nopvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_othvcu)
    post `p' (`y') ("r_pw_val_othvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_output)
    post `p' (`y') ("r_pw_val_output") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_rdnvcu)
    post `p' (`y') ("r_pw_val_rdnvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_renvcu)
    post `p' (`y') ("r_pw_val_renvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_rimvcu)
    post `p' (`y') ("r_pw_val_rimvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_rtlvcu)
    post `p' (`y') ("r_pw_val_rtlvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfbvcu)
    post `p' (`y') ("r_pw_val_sfbvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfcvcu)
    post `p' (`y') ("r_pw_val_sfcvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfdvcu)
    post `p' (`y') ("r_pw_val_sfdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfgvcu)
    post `p' (`y') ("r_pw_val_sfgvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfjvcu)
    post `p' (`y') ("r_pw_val_sfjvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfkvcu)
    post `p' (`y') ("r_pw_val_sfkvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfnvcu)
    post `p' (`y') ("r_pw_val_sfnvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfovcu)
    post `p' (`y') ("r_pw_val_sfovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfrvcu)
    post `p' (`y') ("r_pw_val_sfrvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfsvcu)
    post `p' (`y') ("r_pw_val_sfsvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_sfuvcu)
    post `p' (`y') ("r_pw_val_sfuvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_shdvcu)
    post `p' (`y') ("r_pw_val_shdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_shfvcu)
    post `p' (`y') ("r_pw_val_shfvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_shjvcu)
    post `p' (`y') ("r_pw_val_shjvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_srdvcu)
    post `p' (`y') ("r_pw_val_srdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_srjvcu)
    post `p' (`y') ("r_pw_val_srjvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_srmvcu)
    post `p' (`y') ("r_pw_val_srmvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_stdvcu)
    post `p' (`y') ("r_pw_val_stdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_stjvcu)
    post `p' (`y') ("r_pw_val_stjvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_stlvcu)
    post `p' (`y') ("r_pw_val_stlvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_vtlvcu)
    post `p' (`y') ("r_pw_val_vtlvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yelvcu)
    post `p' (`y') ("r_pw_val_yelvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yisvcu)
    post `p' (`y') ("r_pw_val_yisvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yisvdo)
    post `p' (`y') ("r_pw_val_yisvdo") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yisvfo)
    post `p' (`y') ("r_pw_val_yisvfo") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ykdvcu)
    post `p' (`y') ("r_pw_val_ykdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ykfvcu)
    post `p' (`y') ("r_pw_val_ykfvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ykivcu)
    post `p' (`y') ("r_pw_val_ykivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yprvcu)
    post `p' (`y') ("r_pw_val_yprvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yrnvcu)
    post `p' (`y') ("r_pw_val_yrnvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_yrsvcu)
    post `p' (`y') ("r_pw_val_yrsvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ysnvcu)
    post `p' (`y') ("r_pw_val_ysnvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_ytovcu)
    post `p' (`y') ("r_pw_val_ytovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znavcu)
    post `p' (`y') ("r_pw_val_znavcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zndvcu)
    post `p' (`y') ("r_pw_val_zndvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znevcu)
    post `p' (`y') ("r_pw_val_znevcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znhvcu)
    post `p' (`y') ("r_pw_val_znhvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znivcu)
    post `p' (`y') ("r_pw_val_znivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znovcu)
    post `p' (`y') ("r_pw_val_znovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znpvcu)
    post `p' (`y') ("r_pw_val_znpvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znrvcu)
    post `p' (`y') ("r_pw_val_znrvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_znsvcu)
    post `p' (`y') ("r_pw_val_znsvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zntvcu)
    post `p' (`y') ("r_pw_val_zntvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpavcu)
    post `p' (`y') ("r_pw_val_zpavcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpdvcu)
    post `p' (`y') ("r_pw_val_zpdvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpevcu)
    post `p' (`y') ("r_pw_val_zpevcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zphvcu)
    post `p' (`y') ("r_pw_val_zphvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpivcu)
    post `p' (`y') ("r_pw_val_zpivcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpovcu)
    post `p' (`y') ("r_pw_val_zpovcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zppvcu)
    post `p' (`y') ("r_pw_val_zppvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zprvcu)
    post `p' (`y') ("r_pw_val_zprvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zpsvcu)
    post `p' (`y') ("r_pw_val_zpsvcu") (r(N))
}
* Ulangi blok untuk setiap y yang tercantum di daftar pada baris ini. // WFDOC-INJECTED
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    quietly count if source_year==`y' & !missing(r_pw_val_zptvcu)
    post `p' (`y') ("r_pw_val_zptvcu") (r(N))
}
postclose `p'
use "corrections/reports/__worker_ratio_domains.dta", clear
merge m:1 source_year using `worker_domains', assert(match) nogen
assert ratio_eligible_n<=positive_workers_n
isid source_year ratio
save "corrections/reports/worker_denominator_domains.dta", replace
display "G0C_EXHIBIT_AGGREGATE_PASS G0-X08"
capture log close G0CHILD
