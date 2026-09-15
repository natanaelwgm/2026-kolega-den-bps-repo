# Demo Deasy–Imed: G0 → G0.5 → G1

Untuk demo dengan panel Stata terlihat, buka **00_MASTER.do** di Stata Do-file Editor dan klik **Do**. Results otomatis maju ke depan. **Run.command** adalah alternatif batch dari Terminal. Default sudah menunjuk data development lokal; tidak perlu mengganti path untuk demo di Mac ini.

## Pilihan di bagian atas 00_MASTER.do

| Global | Pilihan |
|---|---|
| `RUN_TO` | `g0`: persiapan/pemeriksaan data aktual yang sudah tersedia; `g05`: pemeriksaan/panel development; `g1`: lanjut estimasi nominal development |
| `RUN_INPUT` | `g05_full`: master lokal yang diverifikasi terhadap sumber; `custom`: Excel/DTA tahunan melalui 01_INPUTS.do; `excel_demo`: contoh Excel ringkas (belum tentu punya input modal G1) |
| `RUN_ID_POLICY` | `auto`: gunakan ID lengkap; `supplied`: wajib ID sumber; `synthetic`: buat linkage fiktif untuk demo development |
| `RUN_FULL_MASTER` | `0`: semua baris + kolom analisis G1; `1`: semua kolom master asal + hasil G1, perlu ruang disk tambahan |
| `RUN_G1_SENSITIVITY` | `0`: spesifikasi utama; `1`: tambahan starting values dan polynomial degree 2 |
| `RUN_G1_BOOTSTRAP` | `0`: tanpa standard errors bootstrap; `1`: 99 pengulangan per sel, jauh lebih lama |
| `RUN_WAVES` | `0`: tidak menggandakan master menjadi banyak file tahunan; `1`: simpan file per tahun, perlu ruang disk tambahan |

`g0` memakai data aktual yang sudah tersedia, bukan menjalankan ulang seluruh 17 skrip pembangunan data mentah lama. `g05` dapat memakai data development yang sudah tersedia atau membentuk ID panel fiktif dari input custom. Tahap G1 ini menggunakan metode nominal-development yang telah diterima; bukan estimasi TFP riil terverifikasi.

## Mengganti input tahunan

1. Set `RUN_INPUT "custom"`.
2. Edit `01_INPUTS.do`: cukup isi `INPUT_FOLDER` dan `INPUT_FILE_PATTERN` (mis. `survey_{year}.xlsx`) jika penamaannya seragam, atau isi path setiap tahun. Atur daftar tahun; format; sheet/baris header; nama kolom bersama; kemudian path `FILE_2010`, `FILE_2011`, dst. Perbedaan antar tahun bisa diatur dengan `FORMAT_2011`, `HEADER_2011`, `MAP_WORKERS_2011`, dll.
3. Excel menggunakan teks header asli atau `@A`/`@BC`; DTA memakai nama variabel. Angka dengan koma perlu `INPUT_NUMBER_STYLE` yang sesuai.
4. G1 membutuhkan nilai tambah, tenaga kerja, stok modal, penambahan modal, material, provinsi, sektor lima digit, tahun, dan ID development. Kolom modal menggunakan `INPUT_EXTRA_FIELDS` / `EXTRA1_<tahun>` / `EXTRA2_<tahun>`.
5. Untuk membuat panel demo dari file custom: `RUN_DATA_MODE "development"`, `RUN_ID_POLICY "synthetic"`. ID sumber tetap disimpan; linkage fiktif hanya untuk development.

Adapter memeriksa file/sheet/header, mapping, format angka, key, cakupan kolom, dan identitas. Hasil pemeriksaan dictionary/cakupan ada di tabel dan workbook G0. Adapter tidak menebak bahwa dua nama kolom berarti konsep ekonomi yang sama: petakan berdasarkan dictionary sumber. Kontrak G1 saat ini mencakup 2010–2015 dan 2017–2022; tahun lain ditolak dengan pesan jelas. Lag modal adalah tepat satu tahun kalender, tidak melompati 2016.

## Hasil dan bukti selesai

Buka `LATEST.html` untuk halaman run terbaru. Grafik G0 terlihat ketika G1 berjalan; grafik G1 muncul setelah estimasi dan attachment selesai. Setiap run memiliki folder baru; sumber tidak ditimpa.

- `DEMO.html`: halaman hasil dan tautan data/tabel.
- `DEMO_COMPLETE.json`: hanya dibuat setelah pemeriksaan final lulus.
- `run.json`, `STATUS.md`: receipt tahapan G0.
- `g1/analysis/G1_main_with_tfp.dta`: data hasil G1, seluruh baris sumber dipertahankan.
- `g1/outputs/G1_results.xlsx`: workbook koefisien, dukungan sampel, distribusi, dan perbandingan metode.
- `g1/outputs/nominal_coefficients.csv`: koefisien, keberhasilan, kegagalan, dan sel yang tidak cukup sampel.
- `g1/outputs/nominal_sample_support.csv`: kelayakan sampel per metode/sektor.
- `g1/provenance.json`: input, hash, jumlah baris, mode output.
- `g1/logs/G1_execution.log`: log estimasi native Stata.

Tidak semua baris atau sektor harus punya residual: syarat input positif, lag kalender, dukungan sampel, dan keberhasilan estimasi tetap berlaku. Bootstrap default mati; jangan mempresentasikan point estimates sebagai hasil dengan confidence interval. Sel yang gagal/kurang dukungan tetap dilaporkan.

## Jika gagal

Terminal menampilkan `FAILED`, bukan sukses hanya karena proses Stata berakhir. Baca log yang ditunjuk. Hasil tahapan sebelumnya tetap ada. Sesudah memperbaiki konfigurasi, jalankan lagi untuk membuat run baru. Jangan menjalankan dua demo bersamaan pada Mac ini. Data/cache lokal bukan bagian paket publik.

## Progres yang terlihat di Stata

Default `RUN_VERBOSE 1`: kode dan output native Stata ditampilkan. Setiap tahap punya banner bernomor dan keterangan pekerjaan. Coverage menampilkan tahun; ringkasan menampilkan variabel; tabel G0 menampilkan nomor modul; G1 menampilkan sektor/metode/sampel serta hasil setiap sel.

Pekerjaan Python berjalan satu per satu dan output barunya diteruskan langsung ke Results. Saat membuat Excel/grafik, terlihat nama sheet/grafik dan `MASIH BERJALAN` setiap sekitar 3 detik. Ini adalah progres proses yang sedang berjalan, bukan pemutaran log run lama. Tombol Break menghentikan helper aktif pada saat polling. Hasil lengkap hanya dinyatakan ketika `DEMO_DONE` muncul dan receipt final lulus.
