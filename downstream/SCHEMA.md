# Dataset yang akan dipakai downstream

Satu baris mewakili satu observasi sumber dalam satu tahun. Pada file development,
observasi juga mempunyai ID perusahaan fiktif yang konsisten dalam panel. Pada
file actual, belum ada ID perusahaan lintas tahun yang terverifikasi.

| Kolom utama | Makna dan penggunaan |
|---|---|
| `obs_id` | Kunci observasi unik. Namespace actual dan development berbeda; jangan merge kedua mode memakai urutan baris. |
| `firm_id` | ID panel development; kosong pada actual. `xtset firm_id year` hanya pada development. |
| `year` | Tahun kalender 2010–2015 dan 2017–2022; tidak membuat baris 2016. |
| `province_code`, `district_code` | Kode wilayah sumber sebagai string; district kosong dan tidak diganti dengan kode dummy. |
| `industry_code`, `industry2_reported` | Kode industri tahun sumber; dua digit adalah potongan kode, bukan hasil concordance lintas versi. |
| `workers`, `production_workers` | Jumlah tenaga kerja kandidat dan tenaga kerja produksi beserta status sumber. |
| `gross_output_nominal`, `value_added_nominal` | Output/value added nominal sesuai konstruksi sumber. Tidak otomatis menjadi nilai riil. |
| `va_signed_nominal`, `va_signed_per_worker` | Konstruksi bertanda yang sudah diperbaiki di G0; nilai negatif tidak otomatis dibuang. |
| `intermediate_inputs_nominal` | Input antara; selalu baca `inputs_definition_status`. |
| `capital_stock_nominal`, `capital_additions_nominal` | Stock dan additions dipisahkan. Flag verified lama mengacu pada konsep kuesioner; bukan penerimaan penuh unit/nilai riil. |
| `export_share_pct`, `import_value_nominal`, `foreign_ownership_pct` | Intensitas internasionalisasi; status biner dan missingness tersedia terpisah. |
| `fuel_*`, `elec_*`, `gj_*`, `co2_*` | Besaran/biaya sumber dan konstruksi energi/emisi yang diwariskan, dengan cakupan dan status faktor/unit. Tidak semua field adalah nilai fisik yang sudah diterima. |
| `r_*`, `qs_*`, `qn_*`, `vs_*`, `st_*` | Konstruksi perbaikan dan penanda keadaan sumber; definisi lengkap ikut kamus variable-year. |
| `dev_nominal_tfp_op/lp/acf/wrdg` | Residual nominal G1 development, bukan TFP riil. Mask sample/domain dan hasil common-sample tetap disimpan. |
| `dataset_mode`, `panel_id_synthetic`, `panel_empirical_ready` | Mencegah data development dianggap data panel perusahaan nyata. |

Kedua file memiliki nama kolom yang sama. Lima puluh empat field hasil G1
bernilai missing pada actual; tidak ada pencampuran nilai development ke actual.
Variabel kunci dan flag baru diberi label Stata. Seluruh field sumber yang
terpilih dipertahankan nilainya dan diperiksa memakai `cf` native Stata.

## Kontrak untuk pemakaian

- Dataset utama tidak melakukan drop observasi, imputasi nol, winsorization baru,
  deflasi, estimasi ulang, ataupun pengisian kabupaten/identitas yang hilang.
- Kunci real sebenarnya belum bisa dinyatakan sebagai perusahaan–tahun. Jangan
  membuat ID perusahaan dari `source_row`, industri atau provinsi.
- Gunakan `L.` pada tahun kalender setelah `xtset`; 2015 bukan lag tahunan 2017.
- Tahun dan provinsi dapat dipakai sebagai dimensi pengelompokan. Penggabungan
  industri antar-tahun tetap membutuhkan concordance yang diterima.
- Ukuran nominal, unit fisik, tahun, kelengkapan komponen, dan definisi populasi
  harus cocok dengan analisis. Keberadaan kolom tidak berarti seluruh syarat itu
  sudah lulus. Variabel dollar/Rp/quantity tidak boleh dicampur berdasarkan nama.
- Filter model dikerjakan di cabang analisis dan harus menghitung baris yang
  keluar. Dataset utama mempertahankan semua 33.049 observasi.
- Dictionary utama ada di `metadata/dictionary_actual.csv` dan
  `metadata/dictionary_development.csv`. `metadata/variable_dictionary.csv`
  memberi keluarga variabel; `metadata/variable_year_evidence.csv` menahan
  status unit/konsep per tahun dari G0. Bukti tersebut harus dibaca bersama
  `reports/coverage_actual.csv` / `coverage_development.csv`.
- `metadata/full_source_catalogue.csv` mengindeks semua 4.593 field G0 dan 4.450
  field master G1. Kolom audit/raw yang tidak diproyeksikan tetap ada di master
  sumber yang dirujuk oleh `COMPLETE.json`; tidak hilang atau disalin ulang.

## Yang masih diperlukan untuk panel empiris final

1. Crosswalk ID perusahaan/establishment antar-tahun yang dibuktikan oleh sumber.
2. Kode kabupaten dan concordance wilayah jika analisis membutuhkan kabupaten.
3. Concordance industri lintas kuesioner/revisi klasifikasi.
4. Penerimaan konsep dan unit variable-year; deflator output/input/capital serta
   pengukuran capital yang sesuai untuk TFP riil.
5. Data 2016 jika estimand memerlukan tahun tersebut; jangan mengisi secara diam-diam.
6. Keputusan sampel, treatment, faktor emisi dan model pada masing-masing rencana.

Kelengkapan 44 rencana penelitian (termasuk G0) dinilai terpisah dalam
`metadata/downstream_plans.csv` dan `downstream_dependencies.json`. Daftar field
pada suatu node dapat menggambarkan hasil atau intermediate; pencocokan nama
secara mekanis dalam `downstream_fields.csv` bukan bukti kesiapan analisis.
