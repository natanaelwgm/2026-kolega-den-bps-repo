# G1 — estimasi fungsi produksi

**G0.5 DEVELOPMENT — perturbed data; fictional company panel; not final empirical findings.**

Empat metode yang diminta dijalankan pada semua tahun yang didukung oleh asumsi stok modal akhir tahun. Run ini menghasilkan **41 model utama yang berhasil**: 37 pada sampel masing-masing metode dan 4 pada sampel bersama empat metode, disertai 123 fit sensitivitas yang berhasil. Sebanyak **4,059/4,059 draw bootstrap** berhasil. Tabel berikut memisahkan metode dan sampel, sehingga jumlah sektor atau observasi tidak disamaratakan.

| Metode | Sampel | Sektor berhasil | Observasi fit |
| --- | --- | --- | --- |
| Ackerberg–Caves–Frazer | common | 1 | 128 |
| Ackerberg–Caves–Frazer | own | 12 | 5,041 |
| Levinsohn–Petrin | common | 1 | 128 |
| Levinsohn–Petrin | own | 12 | 5,041 |
| Olley–Pakes | common | 1 | 128 |
| Olley–Pakes | own | 1 | 128 |
| Wooldridge | common | 1 | 128 |
| Wooldridge | own | 12 | 5,041 |


Hasil tersambung ke turunan lengkap 33.049 observasi × 4.396 kolom input. Kegagalan dukungan atau optimizer tetap tercatat; hasil tidak diganti OLS atau nol. Penyelesaian perhitungan development dengan asumsi owner ini terpisah dari **spesifikasi riil utama issue #9**, yang tetap memerlukan data dan harga riil yang diterima.

Ini perkembangan atas audit v1 yang tersimpan di [arsip historis](history/v1/README.md). **ID perusahaan fiktif resmi G0.5 v3 sudah diterima untuk development:** seluruh 33.049 observasi memiliki `psid`, membentuk 10.395 perusahaan fiktif. Tidak ada duplikat perusahaan–tahun. Ketiadaan linkage perusahaan nyata berlaku pada finalisasi actual, bukan alasan menghentikan cabang development ini.

## Appendix teknis

[Appendix PDF](publication/G1-Appendix.pdf) menjelaskan setiap metode beserta sumber variabel, tahun, missingness, rumus, sampel, tabel koefisien dan standard error, distribusi serta sensitivitas. [Dua belas berkas agregat diagnostik](deep-release/outputs/) merangkum koefisien dan hasil yang sama. Setiap prediksi dibedakan dari observasi yang benar-benar masuk tahap estimasi dinamis; tidak ada estimasi terpisah per tahun yang diklaim. Acuan normalisasi adalah rata-rata residual pada seluruh observasi estimasi dalam sektor×metode×sampel, tetap sama di semua tahun.

| Tahun | Sumber | Prediksi OP | Prediksi LP | Prediksi ACF | Prediksi Wooldridge |
| --- | --- | --- | --- | --- | --- |
| 2010 | 2,334 | 0 | 0 | 0 | 0 |
| 2011 | 2,337 | 75 | 1,057 | 1,057 | 1,057 |
| 2012 | 2,359 | 76 | 1,085 | 1,085 | 1,085 |
| 2013 | 2,369 | 79 | 1,043 | 1,043 | 1,043 |
| 2014 | 2,452 | 92 | 1,017 | 1,017 | 1,017 |
| 2015 | 2,632 | 0 | 1,047 | 1,047 | 1,047 |
| 2017 | 3,357 | 0 | 0 | 0 | 0 |
| 2018 | 3,011 | 75 | 980 | 980 | 980 |
| 2019 | 3,007 | 82 | 1,081 | 1,081 | 1,081 |
| 2020 | 2,936 | 59 | 1,052 | 1,052 | 1,052 |
| 2021 | 3,078 | 51 | 997 | 997 | 997 |
| 2022 | 3,177 | 94 | 956 | 956 | 956 |


[Validasi diagnostik](deep-release/qa/deep-validation.json) mencatat status **PASS** dan cakupan pemeriksaan yang benar-benar dijalankan. Tabel regresi memakai standard error bootstrap seluruh proses; interval persentil 95 persen hanya ditampilkan ketika jumlah draw berhasil memenuhi ambang yang telah ditetapkan.

## Input, kalender dan cakupan

Run `v3-assumed-stock-all-years-02` memakai `g05-external-excel-panel-v3`, SHA256 manifest `060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260`. Adapter bersama memeriksa bagian data dan metadata sebelum ekspor. Kode, sumber, log, tabel, gambar dan intermediate mempunyai hash dalam [run manifest](release/run-manifest.json). Dataset asli dan G0 tidak diubah. Tidak ada data aktual lama atau fixture metode yang menjadi input hasil ini.

![Seluruh wave](release/figures/coverage_by_year.svg)

Ada 12 wave pada 2010–2015 dan 2017–2022. Seluruh 33.049 catatan merupakan denominator audit sumber, bukan ukuran populasi manufaktur nasional. Pemeriksaan kalender menemukan 20.579 pasangan t−1 dan 15.991 pasangan t−2. Sambungan 2015→2017 tetap berjarak dua tahun; tidak ada observasi atau lag 2016 yang dibuat. Matching fiktif mempertahankan provinsi × sektor sesuai generator. Kode sektor yang digunakan dalam estimasi merupakan awalan dua digit yang dilaporkan; padanan antarversi klasifikasi belum menjadi klaim terverifikasi.

Audit marginal menghasilkan 168 sel variabel×tahun dan 7,200 sel alur metode×tahun×kelompok×tahap. Positif, nol, negatif dan missing dipisahkan serta direkonsiliasi ke denominator. Flag konsep stok modal tidak otomatis mengesahkan unit pemasok atau harga.

![Domain sumber](release/figures/input_domains.svg)

## Spesifikasi yang benar-benar dijalankan

Cabang terdaftar [G05v3_nominal_assumedK_2010_2022](nominal-specification.json) memakai persamaan `y_it = β_L l_it + β_K k_it + ω_it + ε_it`. Outcome adalah log nilai tambah nominal positif; labor adalah log pekerja positif. Sesuai instruksi owner, kita **mengasumsikan stok modal yang dilaporkan merupakan stok akhir tahun pada seluruh tahun sumber**. Modal awal tahun t memakai stok positif pada akhir kalender t−1 di perusahaan fiktif yang sama. Flag dokumentasi asli dipertahankan sebagai bukti sumber, tanpa menjadi penghalang baru pada asumsi yang telah disetujui.

Kandidat tahun produksi adalah 2011–2015 dan 2018–2022. Estimasi dinamis memerlukan observasi produksi pada t dan t−1, sehingga kandidat akhir transisi adalah 2012–2015 dan 2019–2022. Tidak ada tahun 2009 atau 2016 yang dibuat. Kita mengestimasi koefisien dan fungsi kontrol yang konstan dalam sektor dengan semua transisi yang didukung; tidak ada efek tetap tahun tambahan. Harga nominal dan perubahan komposisi masih dapat memengaruhi perbandingan tahunan.

OP memakai tambahan modal positif sebagai **kandidat investasi yang diasumsikan secara terpisah**, bukan selisih dua stok. LP, ACF dan Wooldridge memakai `val_rtlvcu` positif sebagai kandidat bahan baku. Total pengeluaran tidak otomatis menggantikan bahan baku. Log tidak dihitung atas nol/negatif; nilai kosong tidak diisi. Sampel own memakai domain setiap metode; common memakai irisan domain keempat metode sebelum operator lag. Wrapper membentuk lag kalender tepat sekali.

**Tidak ada deflasi dalam cabang ini.** Konsistensi satuan positif per variabel dalam cell teknologi adalah konvensi development yang dipertahankan. Pergeseran satuan konstan tercermin pada level/intercept; salah satuan yang berubah antarperusahaan atau tahun tetap menjadi risiko. Residual memuat harga, error pengukuran dan gangguan sementara, sehingga tidak disebut ukuran efisiensi teknis riil yang terverifikasi. Label nominal menyertai tabel dan kolom hasil.

Median setiap log input/outcome dibekukan dalam domain cell untuk membantu kondisi numerik. Polinomial lengkap mempertahankan span saat koordinat digeser. Setelah estimasi, residual dihitung kembali dari log input asli; centering numerik tidak mengubah definisi residual.

## Empat metode dan aturan fit

- **OP:** first stage partially linear memakai modal/investasi; second stage memproyeksikan produktivitas dan seleksi. Risk interval fiktif dibuat untuk setiap perusahaan pada pasangan tahun sumber yang berurutan, termasuk assignment yang tidak tersambung; tidak ada interval melintasi 2016 atau setelah 2022. Hilangnya assignment adalah outcome simulasi, bukan bukti perusahaan nyata tutup. Universe risiko dipertahankan sebelum filter produksi; tidak ada fallback OP tanpa koreksi seleksi.
- **LP:** first stage partially linear memakai proxy bahan baku. Second stage nonlinear least squares memakai hukum produktivitas cubic sesuai implementasi yang dipatok. Output LP tidak dilabeli ulang sebagai ACF.
- **ACF:** first stage polinomial lengkap labor/modal/proxy; koefisien labor dan modal ditentukan melalui inovasi produktivitas dan moment dengan instrumen lag labor serta modal kini menurut kontrak timing. Rank instrumen dan Jacobian moment diperiksa terpisah.
- **Wooldridge:** dua persamaan diestimasi bersama melalui GMM. Implementasi memakai satu vektor koefisien fungsi proxy pada persamaan kini dan lag, dengan konstanta berbeda. Ini spesialisasi random walk dengan drift yang membatasi persistensi menjadi satu dalam pendekatan proxy, sebagaimana dijelaskan dalam kuliah penulis; bukan transisi produktivitas umum yang tidak dibatasi.

[Audit metode](METHOD-AUDIT.md), [kontrak persamaan](registries/method-contracts.md) dan [mode pengukuran/seleksi](stata/methods/MEASUREMENT-MODES.md) memberi rincian sumber. Referensi primer: [Olley–Pakes](https://www.nber.org/papers/w3977), [Levinsohn–Petrin](https://www.nber.org/papers/w7819), [ACF](https://www.econometricsociety.org/publications/econometrica/2015/11/01/identification-properties-recent-production-function-estimators), [Wooldridge](https://doi.org/10.1016/j.econlet.2009.04.026), dan [implementasi Stata Journal](https://www.stata-journal.com/article.html?article=st0537).

Primary memakai polinomial derajat 3 dan start OLS. Start labor rendah/tinggi dan polinomial derajat 2 merupakan tiga sensitivitas tetap; sensitivitas sukses tidak menggantikan primary gagal. OLS hanya titik awal numerik. Koefisien negatif atau jumlah elastisitas yang tidak nyaman tidak dipotong. Objective antarjenis estimator memiliki definisi berbeda sehingga tidak diurutkan seolah satu ukuran kecocokan.

## Dukungan sampel dan OP

![Dukungan nominal](publication/figures/sample_support.svg)

Setiap cell memerlukan minimal 100 observasi domain first stage, 50 transisi dan 50 perusahaan dinamis. OP tambahan memerlukan 100 observasi seleksi, 10 assignment yang hilang dan 10 yang berlanjut. Ambang dibekukan sebelum melihat koefisien. Seluruh 24 sektor sumber × empat metode × own/common × empat varian dicatat, termasuk skip. Tabel tidak menghapus sektor yang gagal.

Ledger berikut menunjukkan hasil nyata setiap metode dan sampel, termasuk alasan dukungan atau kegagalan optimizer. Maksimum universe seleksi OP per sektor adalah **589** observasi; maksimum disappearance yang teramati pada universe tersebut adalah **56**. Jumlah ini berasal dari seluruh interval kalender yang tersedia, bukan hanya satu tahun.

| method | sample_id | status | reason | N |
| --- | --- | --- | --- | --- |
| acf | common | fit_success | converged_fixed_specification | 1 |
| acf | common | skipped_support | dynamic_N_below_50 | 6 |
| acf | common | skipped_support | first_stage_N_below_100 | 17 |
| acf | own | fit_success | converged_fixed_specification | 12 |
| acf | own | skipped_support | dynamic_N_below_50 | 4 |
| acf | own | skipped_support | dynamic_firms_below_50 | 2 |
| acf | own | skipped_support | first_stage_N_below_100 | 6 |
| lp | common | fit_success | converged_fixed_specification | 1 |
| lp | common | skipped_support | dynamic_N_below_50 | 6 |
| lp | common | skipped_support | first_stage_N_below_100 | 17 |
| lp | own | fit_success | converged_fixed_specification | 12 |
| lp | own | skipped_support | dynamic_N_below_50 | 4 |
| lp | own | skipped_support | dynamic_firms_below_50 | 2 |
| lp | own | skipped_support | first_stage_N_below_100 | 6 |
| op | common | fit_success | converged_fixed_specification | 1 |
| op | common | skipped_support | dynamic_N_below_50 | 6 |
| op | common | skipped_support | first_stage_N_below_100 | 17 |
| op | own | fit_success | converged_fixed_specification | 1 |
| op | own | skipped_support | dynamic_N_below_50 | 6 |
| op | own | skipped_support | first_stage_N_below_100 | 17 |
| wrdg | common | fit_success | converged_fixed_specification | 1 |
| wrdg | common | skipped_support | dynamic_N_below_50 | 6 |
| wrdg | common | skipped_support | first_stage_N_below_100 | 17 |
| wrdg | own | fit_success | converged_fixed_specification | 12 |
| wrdg | own | skipped_support | dynamic_N_below_50 | 4 |
| wrdg | own | skipped_support | dynamic_firms_below_50 | 2 |
| wrdg | own | skipped_support | first_stage_N_below_100 | 6 |


Hasil own dan common dipertahankan terpisah. Filter positif LP/ACF/Wooldridge sama, tetapi persamaan dan asumsi metodenya berbeda. Kita tidak menggabungkan sektor atau menurunkan ambang setelah melihat hasil.

## Koefisien dan ketidakpastian

| Sektor dilaporkan | Metode | Sampel | N fit seluruh tahun | β tenaga kerja | β modal awal | Jumlah elastisitas |
| --- | --- | --- | --- | --- | --- | --- |
| 10 | op | own | 128 | 0.8942 | 0.0908 | 0.9851 |
| 10 | op | common | 128 | 0.8981 | 0.0908 | 0.9888 |
| 10 | lp | own | 1,814 | 0.5465 | 0.0867 | 0.6332 |
| 10 | lp | common | 128 | 0.6406 | 0.1295 | 0.7701 |
| 10 | acf | own | 1,814 | 1.1305 | 0.1440 | 1.2744 |
| 10 | acf | common | 128 | 1.1493 | 0.1464 | 1.2957 |
| 10 | wrdg | own | 1,814 | 0.5951 | 0.0895 | 0.6846 |
| 10 | wrdg | common | 128 | 0.6737 | 0.1208 | 0.7945 |
| 12 | lp | own | 299 | 0.1842 | 0.0435 | 0.2278 |
| 12 | acf | own | 299 | 1.4197 | 0.1735 | 1.5933 |
| 12 | wrdg | own | 299 | 0.1437 | 0.0411 | 0.1848 |
| 13 | lp | own | 616 | 0.3737 | 0.0276 | 0.4013 |
| 13 | acf | own | 616 | 1.0379 | 0.0976 | 1.1355 |
| 13 | wrdg | own | 616 | 0.4208 | 0.0239 | 0.4447 |
| 14 | lp | own | 459 | 0.5911 | -0.0033 | 0.5878 |
| 14 | acf | own | 459 | 1.1415 | 0.0674 | 1.2088 |
| 14 | wrdg | own | 459 | 0.8571 | -0.0075 | 0.8495 |
| 15 | lp | own | 124 | 0.5842 | 0.0555 | 0.6397 |
| 15 | acf | own | 124 | 1.1257 | 0.0512 | 1.1769 |
| 15 | wrdg | own | 124 | 0.5522 | 0.1038 | 0.6560 |
| 16 | lp | own | 199 | 0.4647 | 0.0509 | 0.5156 |
| 16 | acf | own | 199 | 1.0592 | 0.0741 | 1.1334 |
| 16 | wrdg | own | 199 | 0.5771 | 0.0652 | 0.6423 |
| 20 | lp | own | 159 | 0.4142 | 0.0806 | 0.4948 |
| 20 | acf | own | 159 | 1.1446 | 0.1126 | 1.2572 |
| 20 | wrdg | own | 159 | 0.4128 | 0.0968 | 0.5097 |
| 22 | lp | own | 285 | 0.3732 | -0.0209 | 0.3523 |
| 22 | acf | own | 285 | 1.0083 | 0.0628 | 1.0712 |
| 22 | wrdg | own | 285 | 0.3717 | 0.0347 | 0.4065 |
| 23 | lp | own | 475 | 0.4493 | 0.0279 | 0.4772 |
| 23 | acf | own | 475 | 1.1571 | 0.0927 | 1.2498 |
| 23 | wrdg | own | 475 | 0.5818 | 0.0017 | 0.5834 |
| 25 | lp | own | 160 | 0.5674 | 0.0348 | 0.6022 |
| 25 | acf | own | 160 | 1.3302 | 0.0113 | 1.3415 |
| 25 | wrdg | own | 160 | 0.7414 | 0.0007 | 0.7421 |
| 31 | lp | own | 341 | 0.6355 | 0.0183 | 0.6538 |
| 31 | acf | own | 341 | 1.2184 | 0.0260 | 1.2445 |
| 31 | wrdg | own | 341 | 0.8631 | 0.0072 | 0.8704 |
| 32 | lp | own | 110 | 0.6574 | 0.0123 | 0.6697 |
| 32 | acf | own | 110 | 0.9675 | 0.1075 | 1.0750 |
| 32 | wrdg | own | 110 | 0.7786 | -0.0169 | 0.7617 |

![Koefisien dan interval](publication/figures/coefficients.svg)

Koefisien pada tabel merupakan hasil spesifikasi utama yang telah ditetapkan. Koefisien negatif dan jumlah elastisitas yang jauh dari satu tetap dipertahankan; convergence dan rank numerik tidak membuktikan asumsi proxy, timing, harga atau teknologi benar. Bab metode dan tabel sensitivitas menjelaskan perbedaan yang didukung hasil ini.

Bootstrap mengambil ulang seluruh perusahaan fiktif sebagai klaster, memberi ID baru pada klaster duplikat, lalu mengulang first stage, transisi, instrumen dan fit. Perhitungan ulang OP menyertakan universe risiko yang diperlukan oleh persamaan seleksinya. Ada 99 draw per model primary; point estimate tidak dihitung sebagai draw. Kovarians memakai pembagi `B_success−1`; interval persentil 95% hanya diterima untuk eksplorasi jika sedikitnya 95 dari 99 draw berhasil. Jumlah model yang memenuhi ambang interval adalah 41 dari 41. Setiap kegagalan tetap masuk denominator draw yang diminta.

Lebar interval dan variasi koefisien antar-start harus dibaca dari hasil setiap sektor. Keberhasilan numerik sendiri tidak membuat interval presisi atau membuktikan optimum global. Inference ini bersyarat pada satu assignment fiktif dan konvensi nominal; ketidakpastian generator tidak di-bootstrap. **99 draw eksploratif tidak memenuhi kewajiban 999 draw untuk spesifikasi riil utama.** Seluruh draw, return code, koefisien, objective dan N tersedia pada [tabel bootstrap](release/outputs/bootstrap_draws/).

## Residual dan perbandingan

Residual sebelum dipusatkan adalah `r_it = ln(VA_nominal_it) − β_L ln(L_it) − β_K ln(K_begin_it)`. Versi centered mengurangi rata-rata residual pada seluruh sampel fit dinamis **sektor×metode×sampel**. Centering ini menormalkan level, bukan mengubah ranking dalam cell. Residual tidak disamakan dengan latent omega atau dengan ukuran kuantitas TFP riil.

![Distribusi](publication/figures/distribution.svg)

Histogram memakai bin 0,5 log poin dan mempertahankan seluruh ekor. Tabel kuantil membedakan raw/centered dan own/common, termasuk baris N=0 untuk keluaran tidak tersedia. Denominator histogram ini adalah observasi yang masuk estimasi dinamis, bukan seluruh prediksi yang lebih luas maupun seluruh 33.049 input. Prediksi di luar fit dianalisis secara terpisah pada tabel tahunan appendix.

Sampel bersama membatasi input sebelum mengambil lag dan mengestimasi ulang setiap metode. Karena itu, jumlah observasi dinamis yang sama tidak selalu berarti first stage atau koefisien sama dengan sampel masing-masing metode. Grafik berikut menunjukkan distribusi residual dari keempat estimasi sampel bersama pada catatan yang sama.

![Distribusi sampel bersama](publication/figures/deep_common_distribution.svg)

| Sampel | Metode A | Metode B | Observasi pasangan | Irisan empat metode | Spearman | Pearson residual dipusatkan |
| --- | --- | --- | --- | --- | --- | --- |
| own | op | lp | 128 | 128 | 0.966 | 0.970 |
| own | op | acf | 128 | 128 | 0.949 | 0.962 |
| own | op | wrdg | 128 | 128 | 0.974 | 0.977 |
| own | lp | acf | 5,041 | 128 | 0.845 | 0.841 |
| own | lp | wrdg | 5,041 | 128 | 0.997 | 0.996 |
| own | acf | wrdg | 5,041 | 128 | 0.866 | 0.860 |
| common | op | lp | 128 | 128 | 0.982 | 0.985 |
| common | op | acf | 128 | 128 | 0.941 | 0.956 |
| common | op | wrdg | 128 | 128 | 0.985 | 0.988 |
| common | lp | acf | 128 | 128 | 0.876 | 0.901 |
| common | lp | wrdg | 128 | 128 | 1.000 | 1.000 |
| common | acf | wrdg | 128 | 128 | 0.883 | 0.908 |


LP dan Wooldridge memberikan peringkat yang hampir sama pada 5,041 observasi bersama: korelasi Spearman 0.997. Korelasi LP–ACF adalah 0.845. Ini membandingkan urutan catatan, bukan membuktikan bahwa koefisien input, level residual atau produktivitas fisik sama. Pasangan yang melibatkan OP memakai irisan lebih kecil, yang tetap terlihat pada tabel.

![Rank](publication/figures/rank_comparison.svg)

Perbandingan pairwise memakai catatan asli yang sama untuk setiap pasangan; irisan empat metode dicatat sebagai scope terpisah dengan jumlah yang tersedia pada run ini. Korelasi pada N=0 tetap missing. CSV scatter berisi rata-rata bin peringkat dengan minimal lima catatan per bin; bin kecil tidak diterbitkan sebagai titik perusahaan. Jumlah catatan yang terwakili direkonsiliasi dengan tabel pairwise.

## Sambungan master dan bukti kualitas

`analysis/G1_main_with_tfp.dta` di direktori run eksternal menyimpan seluruh **4,396 kolom input dan 33,049 observasi**, ditambah kolom `dev_nominal_tfp_*`, centered, common, eligibility/prediction serta ID spesifikasi/normalisasi. Semua prediksi domain primary pada seluruh tahun yang didukung masuk kolom utama, disertai penanda terpisah apakah observasi masuk fit dinamis. Semua sensitivitas tetap ada pada sidecar panjang terpisah. Prediksi yang tidak tersedia tetap missing beserta alasan dukungan atau kegagalan; tidak diganti nol.

Pemeriksaan independen membandingkan **145,283,404 nilai sumber persis** dan urutan asli setelah merge. `obs_id`/tahun dipakai untuk attachment satu-ke-satu; `psid`/tahun dipakai untuk estimasi. Tidak ada interval risiko buatan yang ditambahkan ke master sumber. File perusahaan tetap lokal; repository memuat agregat, kode dan receipt.

Satu primary Stata menyediakan 19 tahap audit, tujuh tahap estimasi nominal, dan enam tahap diagnostik tambahan melalui mode diagnostics. [DAG](dag/G1.svg) mengikat node triage/decision, grain, kunci, unit, denominator dan keluaran. [24 keluarga exhibit](registries/exhibits.csv) tetap direkonsiliasi satu per satu. Dedicated Luna/max memasukkan komentar bahasa Indonesia; diff dan snapshot membuktikan bagian executable tetap sama. Uji metode empat cabang memakai fixture independen, sedangkan laporan ini hanya memakai hasil G0.5. [Quality review](quality-review.md) membandingkan kedalaman, angka, komentar, chart dan reproduksi dengan G0 secara konkret.

## Harga, pekerjaan tersisa dan finalisasi

Audit menemukan harga BPS yang dapat mendukung **pendekatan riil kasar development terpisah** pada 2010–2012: indeks output manufaktur, bahan baku end-use dan barang modal, base 2005=100. [Audit ekonomi v3](qa/v3-economic-prerequisites.md) mencatat 12 sel harga dan bukti visual enam halaman sumber. Penyiapan nonland memakai seluruh komponen raw yang konsisten; tidak mengurangi raw tanah dari total modal yang sudah dijitter.

Pendekatan itu tetap mempunyai keterbatasan deflasi VA dengan indeks output dan harga barang modal yang luas untuk aset heterogen. Audit dukungan awal menemukan tidak ada observasi investasi nonland positif tambahan di luar investasi canonical positif; temuan ini hanya menjelaskan audit persiapan 2010–2012 tersebut dan tidak menggantikan hasil OP semua tahun pada run sekarang. Spesifikasi dan preparation disimpan, tetapi tidak diklaim sebagai fit riil pada laporan ini.

Spesifikasi riil utama masih memerlukan definisi/unit dan harga yang diterima, padanan teknologi, dukungan investasi dan seleksi pada input riil, mask G2 dengan hash yang sama, serta inference yang dipersyaratkan. Hasil empat metode dan sampel bersama pada cabang development sekarang tersedia; hasil itu tidak menggantikan bukti yang harus dibangun ulang pada data riil. Finalisasi actual tetap belum diterima. Finalisasi harus memilih input actual lokal dengan linkage nyata dan menjalankan ulang kode serta keluaran terkait. Mengganti label hasil development tidak memenuhi syarat tersebut.
