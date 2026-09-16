# Clean data handoff: G0 actual + G0.5/G1 development

Muara pekerjaan ini adalah dua dataset Stata dengan struktur yang konsisten,
kamus variabel, cakupan per tahun, bukti asal, dan DAG yang benar-benar dipanggil
oleh satu master. Ini membangun dari hasil G0/G1 yang sudah ada, bukan menjalankan
ulang raw-to-G0 atau mengestimasi ulang G1.

- **`data/panel_development.dta`**: untuk mengembangkan dan menguji analisis panel;
  perturbed values, ID fiktif, serta hasil nominal G1 yang sudah ada.
- **`data/analysis_actual.dta`**: nilai G0 asli pada tingkat observasi–tahun;
  ID perusahaan lintas tahun belum terverifikasi dan dibiarkan kosong.
- **`SCHEMA.md`**: bentuk data akhir dan arti kolom.
- **`reports/readiness.csv`**: batas penggunaan tiap jenis analisis.
- **`COMPLETE.json`**: versi sumber, hash kode, hasil pemeriksaan, dan file final.

Mulai dari `01_OPEN_DEVELOPMENT.do` atau `02_OPEN_ACTUAL.do` dalam folder hasil.
Kedua dataset memuat seluruh 33.049 observasi, dengan 12 tahun kalender; tidak
mengubah tahun yang hilang menjadi panel berurutan. Ketika input aktual dengan
linkage dan metadata yang terverifikasi tersedia, kontrak perlu diperbarui dan
validasi diulang. Jangan mengganti label hasil development menjadi empirical.

## Build ulang

Di repo, salin `downstream/local_paths.example.do` menjadi
`downstream/local_paths.do`, lalu isi empat path sumber/output/Python.
Dari Stata, jalankan seluruh `downstream/00_MASTER.do` dengan argumen root repo,
atau gunakan launcher Downloads `00-BUILD-ANALYSIS-READY.do` pada mesin owner.
Setiap run punya folder baru; dua master lama tidak diubah.

Urutannya: pin sumber → proyeksi field → kunci/identitas dan dimensi →
penyelarasan schema → simpan dan `cf` sumber → cocokkan seluruh sidecar G1 N06 →
validasi mandiri dan paket. `dag/DAG.md` dan registry memberi hubungan proses
ke state dataset yang dibentuk. File anak sengaja memerlukan konfigurasi dari
master; bila dijalankan sendiri tanpa setup, ia berhenti dengan pesan setup.

Keberhasilan struktural tidak berarti seluruh analisis empiris siap. District
masih kosong, ID actual belum terhubung, klasifikasi lintas tahun belum diterima,
dan variabel real/deflator belum dapat dipakai untuk klaim TFP riil.

## Contoh penggunaan development

```stata
use ".../data/panel_development.dta", clear
isid firm_id year
xtset firm_id year
describe workers gross_output_nominal value_added_nominal province_code
```

`examples/01_example_development.do` menerima path dataset sebagai argumen dan
menunjukkan lag kalender yang benar, termasuk pemeriksaan bahwa 2017 tidak
memakai 2015 sebagai lag satu tahun. Ini contoh penggunaan; tidak mengubah
hasil estimasi yang disimpan.

Di folder hasil owner, `00_MASTER.do` adalah launcher ke repo yang sudah
terkonfigurasi dan membentuk run baru. `code/00_MASTER_SOURCE.do` adalah salinan
controller untuk audit; launcher itulah yang dipakai untuk build ulang.
