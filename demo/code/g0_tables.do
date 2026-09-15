* Rumus berasal dari G0 yang diterbitkan. Rebinding hanya I/O, observasi,
* dan pencatatan. Modul ini perlu kontrak penuh, bukan Excel view yang ringkas.
if "$DR_G0_AVAILABLE"=="1" {
    do "$DR_RUN/code/g0_tables_generated.do"
}
else {
    noisily display "G0 TABLES | Kontrak G0 penuh tidak ada pada input ini. Lihat reports/g0-reuse.json."
    noisily display "Ringkasan, wave, coverage dan panel tetap tersedia. Pilih g05_full untuk tabel G0."
}
