* Tujuan: Untuk 2019, ubah raw_irdvcu19 menjadi rd_cost_nominal; vs_rd_cost_nominal mencatat 3 untuk nilai kosong/penanda yang dibiarkan kosong; 5 untuk teks yang tidak dapat dibaca sebagai angka; 2 untuk angka negatif, 1 untuk nol, dan 0 untuk angka lain yang terbaca. // WFDOC-INJECTED
* Input: Kolom yang dimuat launcher code/leaves/mapped/rd_cost_nominal_2019.do dari data/intermediate/raw_wave_2019.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/variable_year/N_G0_rd_cost_nominal_2019.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
* N_G0_rd_cost_nominal_2019: annual staged raw state -> rd_cost_nominal at source_year/source_row.
* Evidence: BPS SILASTIK 2017/2018/2019 IRDVCU labels; annual 2021 Q306 and 2022 Q306 R&D expense. COSTRD is third-party funding indicator, not money.
log using "$VYL/N_G0_rd_cost_nominal_2019.log", text replace name(vycell)
* Mulai rd_cost_nominal sebagai nilai kosong; vs_rd_cost_nominal mulai dari kode 3. Baris berikut menerapkan aturan sumber tahun 2019. // WFDOC-INJECTED
generate double rd_cost_nominal=.
generate byte vs_rd_cost_nominal=3
* Baca raw_irdvcu19 setelah spasi luar dan koma dihapus; teks kemudian diubah menjadi angka untuk rd_cost_nominal. // WFDOC-INJECTED
replace rd_cost_nominal=real(subinstr(strtrim(raw_irdvcu19),",","",.))*1
replace vs_rd_cost_nominal=5 if missing(real(subinstr(strtrim(raw_irdvcu19),",","",.))) & !inlist(upper(strtrim(raw_irdvcu19)),"","***",".","NA","N/A","NULL","-")
replace vs_rd_cost_nominal=cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0)) if !missing(rd_cost_nominal)
* Hitung berapa baris rd_cost_nominal yang terisi; hitungan berikut mencatat nol/status lalu post menulis ringkasan tanpa mengubah baris data. // WFDOC-INJECTED
quietly count if !missing(rd_cost_nominal)
local obs=r(N)
quietly count if rd_cost_nominal==0
local zeros=r(N)
quietly count if inlist(vs_rd_cost_nominal,5,6,8)
local bad=r(N)
quietly count if vs_rd_cost_nominal==4
local absent=r(N)
post cell (2019) ("rd_cost_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
* Simpan hanya source_year/source_row, rd_cost_nominal, status, dan kolom sumber yang diminta; isid lalu save satu hasil variabel/tahun, restore memulihkan data kerja. // WFDOC-INJECTED
preserve
keep source_year source_row rd_cost_nominal vs_rd_cost_nominal raw_irdvcu19
isid source_year source_row
save "$VYD/N_G0_rd_cost_nominal_2019.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_cost_nominal_2019"
log close vycell
