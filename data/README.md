**G0.5 v3 — 13 September 2026:** 33.049 observasi × **4.396 kolom**, 12 wave, dengan **10.395 perusahaan fiktif** dan **22.654 sambungan antar-wave**. `psid` terisi pada semua observasi; statusnya `synthetic_development`. Provinsi × sektor menjadi batas wajib, dengan sembilan variabel kontinu untuk cluster dan pencocokan satu-ke-satu.

GPT Pro dan pengembangan 43 pekerjaan downstream memakai G0.5 secara default. Finalisasi memilih G0 aktual lokal lalu menjalankan ulang kode yang sama. [Cara memilih mode](../docs/DATA-MODES.md), [work item tambahan G0.5](../work-items/G0.5/README.md). Ini tetap data turunan aktual dan tidak dijamin anonim; repo tetap privat. File aktual lama sudah dikeluarkan dari tree aktif setelah dicadangkan lokal, tetapi tetap ada dalam riwayat Git. Hasil agregat/receipt di rilis lama tetap bukti aktual bertanggal; tidak dihitung ulang sebagai G0.5.

**13 September 2026 — [dataset gabungan dan kode penyiapan terbaru](../releases/2026-09-13-data-foundation/README.md).** Master lokal sudah lulus: 33.049 baris × 4.593 kolom, berasal dari 12 wave lengkap. Seluruh 4.591 kolom lama tetap persis. Pada rilis sebelum G0.5, salinan cloud yang diizinkan pemilik tersedia: seluruh 33.049 baris × 4.376 kolom, setelah 217 kolom identitas/teks tertentu dikeluarkan, tanpa mengubah angka ekonomi. Kode memiliki 75.596 baris komentar di seluruh 6.306 do-file, progres setiap blok, dan 44 rencana modul. Seluruh 30 tabel sudah lulus perbandingan persis dan ekspor–baca ulang CSV; R&D 2017 lulus 11 langkah serta 12 pemeriksaan ekspor–baca ulang. Bukti pelaksanaan dan hasil agregat tersedia dalam rilis. Seluruh 44 modul dan identitas panel belum dinyatakan selesai. Catatan versi terdahulu di bawah dipertahankan sebagai sejarah.

**13 September 2026 — [hasil G0 dan rencana terbaru](../releases/2026-09-13-g0/README.md).** Buku 104 halaman, R&D 2017, grafik Python, LaTeX, kode Stata dan 44 rencana sudah tersedia. Dataset kandidat lokal: 33.049 × 4.591, dengan seluruh 3.824 kolom baseline dipertahankan; 374 proses koreksi dan 30 pasangan DTA/CSV lulus. Dataset perusahaan tidak diunggah. G0 belum selesai penuh: identitas panel, klasifikasi/harga, skala pemasok dan cakupan energi masih terbuka. Uji portabilitas dihentikan saat PK20; bukan paket replay yang telah disahkan. Catatan bertanggal 10 September di bawah dipertahankan sebagai sejarah versi. Grafik final menggunakan Python; Stata adalah penghasil data/CSV.

# Original data stays in a separately controlled local environment

**Downloadable Excel work files now live in [synthetic-development/](synthetic-development/README.md): 13 fictional source workbooks, one 3,793-column G0 schema fixture, four classification workbooks, and the latest aggregate G0 report.** These are for code/interface development. The synthetic G0 workbook is not an executed full-pipeline result. Its 1,200 records do not reproduce the 33,049 real source records.

Original source Excel files, full real Stata inputs and masters, TFP predictions and firm-level mismatch reports remain excluded. The earlier 13 September actual cloud projection had all 33,049 rows with 217 identifier/free-text columns removed and unchanged economic values. That package is now retired from the current tree. Its exact metadata and historical Git revision remain as provenance. G0.5 is the active development input. Historical fictional fixtures remain separately labelled.

## Locate and connect inputs

1. Read the chosen row's input/dependency contract and docs/CURRENT-STATE.md.
2. Locate the source in catalog/source-files.csv or the original Stata source registries under research/1014. Excluded inputs retain source paths/sizes; source-provided hashes are available in historical manifests. The publication catalogue does not pretend to have freshly hashed every excluded multi-GB dataset.
3. Copy local-inputs.example.json to ignored local-inputs.json and populate permitted local paths. This is documentation/configuration, not an automatic data downloader.
4. A data-run worker checks availability, input versions, schema, key, units and expected universe before any authorised Stata execution. Do not fabricate missing input files to make a run succeed.

## Current version boundary

Latest complete local G0: `G0_analysis_ready.dta`, 33,049 records × 3,793 columns, SHA256 c481693bcdcf6d96ce8690d5405bc26c781679b47eb3acf18320e2f459a839a4. The original economic candidate has 3,776 columns (SHA256 38d4a06b5a42321f2c292f2e57cf77f8b32dccfba3c6a13fce58c23e226e8e09); the complete file adds 17 identity/method fields. Current IDs are dummy; its original economic observations remain local. The downloadable 3,793-column Excel is a fictional schema fixture, not that original dataset.

G2/G3 and the September 9 flat snapshot used the earlier 3,496-column G0, SHA256 433e847336046c41f7fab51408fa57fe24e04a69005db0e8a3da097c15b8b9c3. An accepted prior run does not validate a later upstream candidate. Keep both versions locally and record the exact dependency for each run.

The flat September 9 snapshot starts from prepared annual DTA inputs. It requires 23 prepared/reference inputs and is sample-specific; it is not a fresh raw-Excel/full-BPS release. Original paths/hashes and input-name conventions are documented in the retained snapshot metadata.

## Safe reference content

Price indices, classification concordances, empty forms, source-layout/codebook workbooks and aggregate result workbooks can be retained. A metadata field named psid in a variable dictionary is not an observation; a table of psid/year/TFP values is microdata. The source screening distinguishes those cases. One TOAR comparison workbook contains a Detailed Mismatches sheet and is withheld as a whole; its layout codebook is included separately.

Original data remain excluded. The two explicit owner-authorized exceptions are the separately labelled fictional fixtures and the screened derived cloud release described above; private access alone does not authorize other dataset uploads. Never commit credentials, original dataset ZIPs, live application databases, raw chat exports or complete shared Home content. Do not reverse masked IDs or infer real linkage from row order.
