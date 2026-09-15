* WFDOC: Script ini memakai empat baris angka buatan untuk menguji penolakan prasyarat sebelum estimasi; tidak membaca atau menulis data perusahaan.
* WFDOC: guards.log merekam kode keluar yang diharapkan; assert pada _N dan variabel sumber memeriksa bahwa pemanggil dipulihkan setelah gagal.
version 17
clear all
set more off
capture log close
log using "work-items/G1/stata/methods/tests/guards.log", text replace
run "work-items/G1/stata/methods/load.do"
* WFDOC: Nilai konstan, ID awal yang hilang, dan tahun berurutan hanya membentuk kasus batas; tidak memiliki satuan ekonomi atau dukungan sampel penelitian.
set obs 4
gen double id=.
gen int year=2010+_n
gen double y=1
gen double l=1
gen double k=1
gen double p=1
gen byte eligible=1
* WFDOC: Dengan panelverified(0), seluruh empat metode harus berhenti sebelum menyentuh data karena linkage perusahaan-kalender belum disahkan.
foreach method in op lp acf wrdg {
    capture noisily g1_fit, method(`method') id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(0) inputsverified(0)
    assert _rc==459
    assert _N==4
    assert missing(id)
}
* WFDOC: Setelah ID contoh diisi, flag inputsverified(0) tetap harus menghentikan seluruh metode karena definisi output, tenaga kerja, modal dan proxy belum lolos.
replace id=1
foreach method in op lp acf wrdg {
    capture noisily g1_fit, method(`method') id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(1) inputsverified(0)
    assert _rc==459
}
* WFDOC: OP ditolak karena uji ini tidak memberi risk/exit terautentikasi; program tidak boleh menganggap baris terakhir sampel produksi sebagai penutupan.
capture noisily g1_fit, method(op) id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(1) inputsverified(1)
assert _rc==459
* WFDOC: Tahun berselang dua membuat tidak ada transisi kalender t-1 yang lengkap; LP harus menolak sampel dinamis kosong dengan kode 2001.
replace year=2010+2*_n
capture noisily g1_fit, method(lp) id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(1) inputsverified(1)
assert _rc==2001
replace year=2010+_n
* WFDOC: Kolom konstan membuat desain tahap pertama ACF tidak berpangkat penuh; kegagalan harus eksplisit dan data pemanggil tetap empat baris.
capture noisily g1_fit, method(acf) id(id) time(year) output(y) labor(l) capital(k) proxy(p) eligible(eligible) panelverified(1) inputsverified(1)
assert _rc==459
assert _N==4
assert y==1
assert k==1
assert l==1
assert p==1
* WFDOC: Pesan akhir merangkum sebelas kasus penolakan pada fixture, bukan keberhasilan estimasi.
di "G1_METHOD_GUARDS_PASS: four panel refusals, four input refusals, OP selection refusal, calendar refusal, rank refusal; caller preserved"
log close
