* Tujuan: Bentuk kolom kerja tahunan dari sumber yang terverifikasi, sambil mempertahankan nilai awal dan status pengisian. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_verified_20260910.dta // WFDOC-INJECTED
* Output: data/intermediate/verified_wave_2010.dta; data/intermediate/verified_wave_2011.dta; dan 10 masukan lain // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak /Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
use "dag/data/word_data/G0/G0_main_verified_20260910.dta", clear
preserve
keep if source_year==2010
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2010.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2011
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2011.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2012
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2012.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2013
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2013.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2014
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2014.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2015
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2015.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2017
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2017.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2018
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2018.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2019
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2019.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2020
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2020.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2021
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2021.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
preserve
keep if source_year==2022
* Simpan data yang telah lolos pemeriksaan pada nama berkas di baris ini. // WFDOC-INJECTED
save "data/intermediate/verified_wave_2022.dta", replace
* Kembalikan data kerja ke salinan sebelum penyaringan sementara, agar iterasi berikut mulai dari tabel utuh. // WFDOC-INJECTED
restore
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2010.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2011.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2012.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2013.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2014.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2015.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2017.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2018.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2019.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2020.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2021.do"
* Jalankan tahap/berkas anak code/leaves/working/export_any_binary_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_any_binary_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_activity_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_activity_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/rd_external_funding_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/rd_external_funding_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_product_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_product_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_process_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_process_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_marketing_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_marketing_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_org_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_org_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/innovation_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/innovation_flag_2022.do"
* Jalankan tahap/berkas anak code/leaves/working/export_flag_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/leaves/working/export_flag_2022.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2010.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2011.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2012.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2013.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2014.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2015.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2017.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2018.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2019.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2020.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2021.do"
* Jalankan tahap/berkas anak code/annual/merge_working_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/merge_working_2022.do"
* Jalankan tahap/berkas anak code/stages/F060_finish_working.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/stages/F060_finish_working.do"
display "WF_STAGE_F060_PASS"
