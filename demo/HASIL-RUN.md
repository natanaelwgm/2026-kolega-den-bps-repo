# Siap demo

Run noisy melalui klik Do di Stata GUI: 15 September 2026, 20:06:58–20:14:21 WIB (sekitar 7 menit 23 detik pada kondisi mesin saat uji). Results otomatis maju, tahap dan detail pekerjaan terlihat, output Python diteruskan langsung, heartbeat sekitar 3 detik. Uji pengulangan dalam sesi Stata yang sama lulus. Panel akhir menunjukkan TAHAP SELESAI, DEMO_DONE, end of do-file, lalu prompt.

- 33.049 observasi, seluruh baris dan nilai sumber pada kolom output dipertahankan.
- 41 estimasi utama sukses: OP 2; LP, ACF, Wooldridge masing-masing 13. Ini menghitung sel sektor × metode × own/common sample.
- 151 sel tidak memenuhi dukungan sampel; tidak disembunyikan atau dipaksakan.
- Rekonstruksi residual own dan common dari data dan koefisien lulus.
- 23 grafik SVG; workbook G0 dan G1; DTA akhir; CSV dukungan, koefisien, distribusi, perbandingan.
- Default: nominal development, panel linkage fiktif, tanpa bootstrap. Bukan TFP riil final.
- Compact master mempertahankan semua baris dan input analisis; seluruh 4.396 kolom sumber tetap di cache asli, opsi RUN_FULL_MASTER=1 jika ruang cukup.

Klik dua kali Run.command. Pilihan tahap ada di 00_MASTER.do. Path, pola nama file, dan kolom per tahun ada di 01_INPUTS.do.

[Halaman hasil](runs/20260915-200658-g05_full-0e9c16/DEMO.html) · [Bukti final](runs/20260915-200658-g05_full-0e9c16/DEMO_COMPLETE.json) · [Hasil Excel G1](runs/20260915-200658-g05_full-0e9c16/g1/outputs/G1_results.xlsx)

Paket master baru ini lokal. Tidak mengubah status merge/push PR riset yang telah selesai sebelumnya. Tidak ada task lain yang dikirimi pesan.
