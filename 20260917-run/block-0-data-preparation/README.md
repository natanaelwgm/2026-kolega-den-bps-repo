# Block 0 — Data preparation: OBSCURED analysis-ready data

**Mulai dari [`analysis_ready_data.dta`](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/download/20260917-block-0-data-preparation/analysis_ready_data.dta)** jika ingin membaca data, mengembangkan analisis,
atau bekerja bersama coauthor. File ini menyatukan fitur G0, panel G0.5, hasil G1,
label yang terbaca, dan definisi variabel lengkap.

**Rekomendasi dalam README ini bersifat opsional dan tidak mengikat.** Ini bukan
rencana analisis wajib, pilihan model final, atau satu sampel yang harus dipakai.
Coauthor boleh memilih file, variabel, sampel, dan metode lain sesuai pertanyaan
riset, sambil mencatat pilihan dan alasannya. Keterangan tentang isi data tetap
berlaku apa pun pilihan analisisnya.

## Isi block ini

- `analysis_ready_data.dta`: dataset final **OBSCURED**, lengkap dengan hasil G1 dan 516 label/notes.
- `README.md` dan `METADATA.json`: panduan analisis opsional dan metadata dataset.
- `metadata/`: dictionary, codebook, do-file label/notes dan hasil validasi.
- `intermediate/`: input sebelum G1 yang hanya disimpan lokal; tidak diunggah pada rilis ini.
- `masking-reports/`: aturan perubahan angka, identitas fiktif dan pemeriksaan terkait.
- `provenance/upstream/`: dokumentasi sumber sebelum file final diberi nama paket ini.
- `LINEAGE.json` dan `PACKAGE.json`: rantai versi, hash dan bukti penyalinan.
- `00_OPEN_DATA.do`: pembuka data; jalankan setelah working directory Stata diarahkan ke folder block ini.

**Nama file dibuat ringkas sesuai permintaan; seluruh angka di file ini tetap versi
OBSCURED.** Penggantian nama tidak menjadikannya data aktual. Bytes DTA identik
dengan final G1 obscured yang telah diverifikasi.

## Unduh satu dataset final

Rilis ini menyediakan **satu DTA final**, yaitu [`analysis_ready_data.dta`](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/download/20260917-block-0-data-preparation/analysis_ready_data.dta).
README, metadata dan kode berada di `main`; DTA disimpan sebagai aset
[rilis privat GitHub](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/tag/20260917-block-0-data-preparation), sesuai kebijakan penyimpanan repo.
Clone saja belum mengunduh DTA. Setelah clone, jalankan dari root repo:

```sh
gh release download 20260917-block-0-data-preparation \
  --repo natanaelwgm/2026-kolega-den-bps-repo \
  --pattern analysis_ready_data.dta \
  --dir 20260917-run/block-0-data-preparation
shasum -a 256 20260917-run/block-0-data-preparation/analysis_ready_data.dta
```

Gunakan akun GitHub yang memiliki akses repo ini. SHA256 yang diharapkan:
`975f7d2a4087ea5ee95ba1f59acbfe52f68cb25eea1a9f21ba23e64d3bba0c7c`.
Jika file sudah ada, periksa hash-nya; tidak perlu mengunduh ulang.
Selanjutnya buka `00_OPEN_DATA.do` dari folder block ini di Stata.
`RELEASE.json` mencatat satu aset beserta ukuran, hash dan alamat unduhnya.

## File mana untuk apa?

| File | Peran yang disarankan | Baris x variabel | Ada hasil G1? |
|---|---|---:|---|
| [`analysis_ready_data.dta`](https://github.com/natanaelwgm/2026-kolega-den-bps-repo/releases/download/20260917-block-0-data-preparation/analysis_ready_data.dta) | recommended starting dataset | 33,049 x 516 | Ya |
| `intermediate/G05_obscured_panel.dta` (lokal saja) | optional pre-G1 input | 33,049 x 516 | Belum; sebelum estimasi |

File G0.5 adalah intermediate lokal untuk mencoba estimasi baru; file ini tidak disertakan dalam rilis GitHub ini. Jika hanya ingin
menganalisis keluaran yang sudah tersedia, master final biasanya cukup; seluruh
fitur yang diperlukan untuk membacanya sudah berada dalam satu file.

Data aktual milik owner dan bahan pemulihan tidak disertakan di paket ini.
Untuk penelitian dengan angka aktual, gunakan cabang actual yang dikelola
terpisah dan evaluasi kembali kesiapan linkage, satuan, deflator, serta estimasi
G1. Rekomendasi ini tidak menyatakan cabang actual sudah menjadi panel dengan TFP.

## Apa isi dan cakupannya?

- **33,049 baris, 516 variabel, 10,463 ID perusahaan fiktif**.
- Satu baris = satu ID perusahaan fiktif pada satu tahun observasi. Format panjang,
  panel tidak seimbang. Kunci unik: `obs_id`; pasangan panel: `firm_id year`.
- Tahun tersedia: **2010, 2011, 2012, 2013, 2014, 2015, 2017, 2018, 2019, 2020, 2021, 2022**. Tahun 2016 tidak tersedia dan tidak diisi otomatis.
- 5,469 ID muncul pada lebih dari satu tahun;
  604 muncul pada seluruh tahun yang tersedia.
- Kode provinsi terisi pada 33,049 baris;
  kode kabupaten pada 0 baris;
  kode industri pada 33,049 baris.
  Kolom kabupaten yang kosong tidak dapat dipakai untuk menghasilkan analisis kabupaten.

Keluarga isi utama: tenaga kerja; output dan nilai tambah nominal; input, modal,
perdagangan dan kepemilikan; energi/emisi; R&D/inovasi/lingkungan; status sumber,
kelayakan dan missingness; identitas panel; residual dan indikator sampel G1.

## Saran titik awal, boleh diubah

| Kebutuhan | File awal | Saran | Konteks untuk menafsirkan |
|---|---|---|---|
| Mulai membaca data, membuat tabel, atau mengembangkan kode | `analysis_ready_data.dta` | Mulai dari master G1 berlabel agar fitur G0, panel G0.5, hasil G1 dan status sumber berada dalam satu file. | Angka sudah diobscure; tabel mendeskripsikan versi development ini, bukan besaran aktual/populasi. |
| Eksplorasi produktivitas dan perbandingan metode | `analysis_ready_data.dta` | Pilih metode dan sampel sesuai pertanyaan. Untuk meniru ringkasan estimasi, pertimbangkan in_fit metode tersebut; untuk hasil pada sampel bersama, lihat keluarga dev_nominal_common_*. | Residual nominal pada panel fiktif; pred adalah flag tersedianya residual. TFP missing bukan nol. Own dan common merupakan sampel berbeda; tidak ada satu filter wajib. |
| Eksplorasi energi, emisi dan intensitas | `analysis_ready_data.dta` | Mulai dengan cakupan komponen per tahun, lalu pilih subtotal atau subset lengkap sesuai tujuan. | Cakupan sembilan bahan bakar dan listrik dibeli; complete berarti lengkap untuk subset itu. CO2 bukan CO2e; own generation tidak ditambahkan dua kali. Unit/faktor tetap mengikuti evidence tahun. |
| Eksplorasi per tahun, provinsi atau industri | `analysis_ready_data.dta` | Tabel tahunan/provinsi/industri dapat menjadi titik awal pemeriksaan pola pada data development. | Ketersediaan kode dihitung dalam metadata. Kolom kosong tidak memberi informasi wilayah. Kode industri lintas vintage belum dijembatani; agregat sampel tidak otomatis estimasi populasi. |
| Menguji kode panel, lag, atau transisi | `analysis_ready_data.dta` | Gunakan firm_id dan year untuk pengujian struktur panel. Pertahankan jarak kalender asli ketika membuat lag. | ID konsisten dalam rilis ini, namun keterkaitan perusahaan bersifat fiktif. Tidak semua perusahaan muncul tiap tahun; 2016 tidak tersedia. Identitas tidak dijamin tetap pada rebuild dengan input baru. |
| Mencoba estimasi G1 atau spesifikasi lain dari input sebelum G1 | `intermediate/G05_obscured_panel.dta` | Intermediate ini hanya tersedia lokal. Jika membangunnya ulang, gunakan G0.5 obscured sebagai input awal dan simpan output percobaan secara terpisah. | Ini input sebelum G1, bukan alternatif hasil G1 final. Placeholder hasil G1 di file ini tidak boleh dibaca sebagai estimasi. Tidak diperlukan untuk sekadar membaca master final. |

Tidak ada filter yang diterapkan oleh README atau metadata ini. Tidak perlu
membuang seluruh baris hanya karena satu metode TFP atau satu fitur belum tersedia.
Pilih denominator dan sampel sesuai masing-masing pertanyaan.

## Cakupan hasil G1 saat ini

| Metode | Residual own tersedia | Baris fit dinamis own | Residual common tersedia |
|---|---:|---:|---:|
| OP — Olley-Pakes | 672 | 127 | 665 |
| LP — Levinsohn-Petrin | 10,284 | 4,955 | 665 |
| ACF — Ackerberg-Caves-Frazer | 10,284 | 4,955 | 665 |
| WRDG — Wooldridge | 10,284 | 4,955 | 665 |

`dev_nominal_tfp_*` adalah residual log nominal yang belum dicenter;
`dev_nominal_c_*` mengurangi rerata sampel fit per sektor/metode.
`dev_nominal_pred_*` adalah **flag tersedianya residual**, bukan predicted output.
`dev_nominal_in_fit_*` mencatat keikutsertaan dalam estimasi. Keluarga
`dev_nominal_common_*` berasal dari model pada domain bersama, bukan sekadar
salinan own setelah difilter. Angka tabel adalah jumlah baris, bukan jumlah perusahaan.

## Cara membuka dan membaca definisi

Dari folder data ini, jalankan di Stata:

```stata
use "analysis_ready_data.dta", clear
isid firm_id year
xtset firm_id year
browse
notes workers
notes dev_nominal_tfp_lp
```

Contoh eksplorasi opsional, bukan aturan sampel universal:

```stata
tabulate year, missing
summarize workers value_added_nominal
summarize dev_nominal_tfp_lp if dev_nominal_in_fit_lp == 1
```

Klik variabel di Data Browser untuk melihat **Label** dan **Notes**.
[Dictionary CSV](metadata/variable_dictionary.csv) memuat label, definisi, satuan,
rumus yang tersedia, sumber, serta perlakuan obscuring untuk seluruh variabel.
[Codebook](metadata/CODEBOOK.md) menyediakan versi yang bisa dibaca sebagai dokumen.
[METADATA.json](METADATA.json) memuat katalog file, hash, grain, kunci, cakupan,
dan saran analisis dalam format yang dapat dibaca program.

## Cara menafsirkan versi ini

Urutan data: **G0 → G0.25 obscuring → G0.5 panel fiktif → G1 estimasi ulang →
label/notes → panduan ini**. Angka input yang terlihat adalah angka yang dipakai
G1. Tidak ada obscuring tambahan setelah estimasi.

Angka primer diubah dengan target +/-20–30%, dengan pengecualian pembulatan count
dan batas persentase; variabel turunan dihitung kembali. Status sumber dan kategori
tertentu dipertahankan, sehingga flag ambang dari sumber tidak harus sama dengan
flag yang dihitung ulang dari angka obscured. Missing, nol, dan tidak tersedia
merupakan keadaan yang berbeda.

ID perusahaan konsisten dalam versi ini tetapi fiktif; belum membuktikan hubungan
perusahaan aktual lintas tahun atau kesinambungan ID pada rebuild mendatang.
TFP adalah residual **nominal development**, belum TFP input riil. Pengukuran
energi/emisi mencakup subset yang didokumentasikan; satuan dan klasifikasi lintas
tahun mengikuti bukti sumber masing-masing. Label baru tidak mengubah status tersebut.

Gunakan versi ini sebagai titik awal pengembangan, eksplorasi dan reproduksi
hasil development. Keputusan untuk interpretasi empiris aktual mengikuti data
aktual dan bukti yang relevan bagi analisis tersebut. Kategori yang dipertahankan
berarti obscuring bukan jaminan anonimitas penuh.

## Versi dan reproduksi

- ID rilis data: `kolega-g025-g05-g1-975f7d2a4087`.
- SHA256 DTA final: `975f7d2a4087ea5ee95ba1f59acbfe52f68cb25eea1a9f21ba23e64d3bba0c7c`.
- Bukti metadata tanpa perubahan angka: [VALIDATION.json](metadata/VALIDATION.json).
- Dasar dokumentasi dibuat oleh edge **E067** setelah DTA final tervalidasi; cakupan publikasi diperjelas menjadi satu DTA final pada 17 September 2026.
- Rekomendasi tidak mengubah nilai, filter, hasil estimasi atau indikator kesiapan.
