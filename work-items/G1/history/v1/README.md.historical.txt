# G1 — empat metode TFP pada G0.5

**G0.5 DEVELOPMENT — perturbed data; not final empirical findings.**

**Issue #9 masih terbuka. Empat estimasi pada G0.5 belum dapat dijalankan:** tidak ada identitas perusahaan lintas tahun yang terverifikasi, variabel riil dan deflator masih kosong, skala pengukuran serta padanan teknologi belum diterima, dan OP belum mempunyai risk set/exit yang diautentikasi. Paket ini menyerahkan audit numerik seluruh 33.049 observasi, implementasi empat metode dengan pengaman dan uji algoritme terpisah, serta bukti tepat tentang pekerjaan yang masih tertahan.

- Baca [laporan hasil](report.md) atau [versi HTML](report.html), lalu [acceptance](acceptance.json).
- Telusuri [DAG](dag/G1.svg), [19 proses](dag/registries/edges.csv), [24 keluarga exhibit](registries/exhibits.md), [metode](registries/method-contracts.md), [audit sumber](PREREQUISITE-AUDIT.md), dan [audit implementasi metode](METHOD-AUDIT.md).
- Periksa [receipt run](release/run-manifest.json), [pemeriksaan angka](release/qa/numeric-validation.json), [data grafik](release/outputs/), [SVG/PNG](release/figures/), dan [log Stata](release/logs/G1_execution.log).
- Batas mutu dan perbandingan konkret dengan G0 tersedia di [quality-review.md](quality-review.md). Tidak ada PDF baru.

## Menjalankan ulang

Dari akar checkout, dengan Python yang mempunyai pandas, pyarrow, NumPy dan Matplotlib, serta Stata/SE 17 atau lebih baru:

```sh
python3 work-items/G1/run.py --run-id my-new-run --publish
python3 work-items/G1/build_contracts.py
python3 work-items/G1/build_report.py
python3 harness/manage.py validate
```

`run-id` harus baru. Runner memeriksa SHA256 manifest input dan seluruh bukti admission yang dipatok sebelum memuat kolom terpilih melalui `harness.data_source.load_data`. Satu primary [stata/G1.do](stata/G1.do) menjalankan 19 edge. Penulisan DTA memakai format 118 karena format 119 pada exporter generik memerlukan Stata/MP; pemeriksaan independen membuktikan nilai tetap sama.

Semua data observasi dan run gagal disimpan di direktori saudara checkout, `<checkout>-g1-runs/<run-id>/`. Hanya agregat, grafik, log tanpa contoh baris perusahaan, dan receipt yang disalin ke `release/`. Jangan menambahkan DTA lokal ke Git. `analysis/G1_main_with_tfp.dta` dalam run adalah **turunan 36 kolom input terpilih plus status/eligibility**, dengan empat TFP seluruhnya missing. Ia membuktikan sambungan satu-ke-satu untuk status; belum memenuhi sambungan numerik TFP ke seluruh 4.379 kolom master.

## Uji metode terpisah

[Panduan metode](stata/methods/README.md) menjelaskan empat point estimator, rank/moment checks, OP selection, external bootstrap dan fixture buatan khusus. Fixture itu tidak berasal dari G0.5, panel fiktif PR #4, atau data aktual lama. Hasilnya hanya menguji program. Ia tidak menjadi input, grafik atau koefisien laporan G0.5.

## Perubahan sumber dan finalisasi

Kontrak produksi memakai nilai tambah riil Cobb–Douglas, polinomial derajat 3, dan teknologi dua digit yang diterima; derajat 2/start/optimizer menjadi sensitivitas yang dideklarasikan. Tidak ada deflator identitas, modal campuran, lag urutan baris atau OLS pengganti.

Sebelum menerima versi panel baru, selesaikan crosswalk lokal dan grain, unit/nilai ekonomi tahunan, deflator dan padanan teknologi, definisi proxy/timing, OP risk/exit, dan pemeriksaan G2 atas hash yang sama. Perbarui acceptance sumber dan runner secara eksplisit; mengubah flag bukan bukti. `--mode actual` saat ini menolak finalisasi yang belum diterima. Finalisasi kelak harus memilih input aktual lokal secara eksplisit, lalu menjalankan ulang badan analisis dan seluruh keluaran yang sama; tidak boleh mengganti label atau angka hasil development.

Nomor Word **1**, PIC kosong, teks permintaan dan kolom completion sumber dipertahankan. PR #4 dan PR #3 tetap terpisah; tidak ada hasil fiktif lama yang diklaim menyelesaikan issue ini.
