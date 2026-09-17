* Tujuan: Lengkapi lima variabel terakhir dan gabungan tahun 2022 dari proses yang terhenti.
* Input: Dua belas sumber tahunan; hasil sebelumnya wajib cocok dengan hash pada kontrak resume.
* Output: Sisa berkas variabel dan mapped_wave_2022.dta; seluruh hasil akan dibandingkan pada V060/V070.
* Gagal: Hentikan proses dan simpan kode error asli; jangan mengulang atau menerima hasil diam-diam.
* Siapkan lingkungan Stata yang sama dengan tahap wave lainnya. // WFDOC-INJECTED
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/code/init.do"
* Lanjutkan variabel waste solid 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_solid_flag_2022.do"
* Lanjutkan variabel waste liquid 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_liquid_flag_2022.do"
* Lanjutkan variabel waste hazardous 2022 yang belum dibuat pada proses sebelumnya. // WFDOC-INJECTED
do "code/leaves/mapped/waste_hazardous_flag_2022.do"
* Lanjutkan konversi bahan bakar gas alam ke MMBtu untuk 2022. // WFDOC-INJECTED
do "code/leaves/mapped/fuel_natgas_mmbtu_2022.do"
* Lanjutkan variabel kuantitas biomassa 2022. // WFDOC-INJECTED
do "code/leaves/mapped/fuel_biomass_kg_2022.do"
* Gabungkan seluruh hasil mapped 2022 menjadi wave tahunan setelah lima leaf tersisa selesai. // WFDOC-INJECTED
do "code/annual/merge_mapped_2022.do"
* Tampilkan penanda selesai yang dipakai runner untuk mengenali akhir tail. // WFDOC-INJECTED
display "WF_F030_TAIL_COMPLETION_PASS"
