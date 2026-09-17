* Tujuan: Bentuk satu berkas raw per tahun dari sumber tahunan yang terdaftar, lalu cek kunci tahun/baris. // WFDOC-INJECTED
* Input: code/annual/raw_2010.do; code/annual/raw_2011.do; dan 10 masukan lain // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* Jalankan tahap/berkas anak code/annual/raw_2010.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2010.do"
* Jalankan tahap/berkas anak code/annual/raw_2011.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2011.do"
* Jalankan tahap/berkas anak code/annual/raw_2012.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2012.do"
* Jalankan tahap/berkas anak code/annual/raw_2013.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2013.do"
* Jalankan tahap/berkas anak code/annual/raw_2014.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2014.do"
* Jalankan tahap/berkas anak code/annual/raw_2015.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2015.do"
* Jalankan tahap/berkas anak code/annual/raw_2017.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2017.do"
* Jalankan tahap/berkas anak code/annual/raw_2018.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2018.do"
* Jalankan tahap/berkas anak code/annual/raw_2019.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2019.do"
* Jalankan tahap/berkas anak code/annual/raw_2020.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2020.do"
* Jalankan tahap/berkas anak code/annual/raw_2021.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2021.do"
* Jalankan tahap/berkas anak code/annual/raw_2022.do; tahap ini bergantung pada hasilnya sebelum melanjutkan. // WFDOC-INJECTED
do "code/annual/raw_2022.do"
display "WF_STAGE_F010_PASS"
