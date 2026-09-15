# Perbaikan G0: setiap analisis membaca hasil penyiapan data yang sama

Status: SIAP DIIMPLEMENTASIKAN — rencana gabungan, kedua rincian proses, dan audit pembacaan diperiksa root pada 13 September 2026. Pemeriksaan kode terarah tetap dilakukan sebelum eksekusi Stata. Permintaan pemilik pada 13 September 2026 mengizinkan revisi rencana, perbaikan kode dan pengujian. Instruksi penghentian G0 sebelumnya digantikan hanya untuk perbaikan ini. Tidak ada estimasi baru atau desain ulang PDF dalam pekerjaan ini.

## 1. Hasil yang harus dicapai

Setiap berkas variabel–tahun menjadi masukan nyata untuk penggabungan, bukan sekadar salinan hasil. Penyiapan data menghasilkan 12 berkas `data/waves/wave_YYYY.dta`. Kedua belas wave lalu digabung menjadi satu `data/analysis/G0_analysis_ready.dta`. Semua tabel, perhitungan analisis dan grafik tentang perusahaan membaca dataset gabungan final tersebut atau hasil turunannya yang tercatat. Tidak ada pembacaan langsung ke berkas mentah tahunan atau kandidat G0 lama oleh analisis.

Sumber tetap 12 Excel yang telah diperiksa: 2010–2015 dan 2017–2022. Kunci yang tersedia adalah `source_year, source_row`; tidak diganti menjadi PSID buatan. Seluruh kolom mentah dan status dipertahankan. Penyiapan skema dapat diuji tanpa mengklaim identitas perusahaan lintas tahun sudah disahkan.

## 2. Urutan dan masukan yang diperbolehkan

| Tahap | Masukan | Proses dan keluaran | Syarat untuk lanjut |
|---|---|---|---|
| A. Bekukan versi input | Excel, kamus, kode dan hasil per variabel yang sudah terverifikasi | Daftar path, ukuran, hash, kunci dan tahun; bedakan sumber, hasil tersimpan dan pembanding | Semua file yang dipakai cocok dengan versi yang dinyatakan |
| B. Hasil per variabel | Masukan sumber yang dinyatakan dalam tiap proses; hasil tersimpan boleh dipakai bila hash dan kontraknya cocok | 233 variabel × 12 tahun, serta nilai kerja tambahan dan kolom mentah yang diperlukan | Tiap berkas mempunyai satu tahun, kunci unik, kolom yang dinyatakan; sumber mentah tetap tersimpan |
| C. Susun tahunan antara | Berkas kunci tahunan dan hasil variabel–tahun terpisah | `intermediate/annual_YYYY.dta`, melalui `merge 1:1` nyata; kemudian gabungan tahun bila diperlukan oleh perhitungan persiapan | Semua pasangan cocok; tidak ada observasi atau kolom yang hilang/berlipat; konflik nama ditolak atau diputuskan eksplisit |
| D. Lengkapi dan koreksi | Tahunan antara; kontrak definisi; referensi harga/faktor yang diperlukan | Hitung ulang kebutuhan G0 dan koreksi yang sudah ada dari sumber tersebut. Kandidat G0 lama tidak menjadi input perhitungan | Hasil yang seharusnya tetap sama cocok; perbedaan yang tidak dijelaskan menghentikan proses |
| E. Terbitkan wave siap | Hasil penyiapan dan koreksi tahap D | 12 `data/waves/wave_YYYY.dta`, skema bersama, kamus kolom, bukti kelulusan dan daftar keluaran | Seluruh 33.049 catatan, 12 tahun dan kolom yang diperlukan utuh; angka pembanding cocok; tidak ada 2016 atau PSID buatan |
| F. Terbitkan dataset gabungan final | Hanya 12 wave siap | `data/analysis/G0_analysis_ready.dta`: gabungan lengkap 33.049 baris × 4.593 kolom. Semua penyiapan/label selesai sebelum disahkan | Satu dataset mandiri untuk dibagikan ke tim; tidak membutuhkan merge dengan file perusahaan lain |
| G. Analisis dan tabel | Dataset gabungan final atau turunannya; referensi/metadata yang dinyatakan | 30 tabel agregat, cabang R&D 2017, angka tampilan atlas/diagnosis | Tidak ada analisis yang membaca langsung wave tahunan atau file perusahaan lain; angka dibandingkan dengan publikasi sebelumnya |
| H. Grafik dan penyerahan | CSV terverifikasi tahap G | Python dan LaTeX tetap memakai hasil tersertifikasi; data-lineage diperbarui | Semua input grafik ditelusuri. Tidak menjalankan ulang Stata untuk ekspor gambar. Perubahan tampilan bukan scope ini |

Tahunan antara pada C belum disebut wave siap. Ini mencegah mencampur pengolahan data mentah dengan masukan final untuk analisis. Tidak ada panah balik dari tabel/analisis ke penyiapan data.

## 3. Bedakan data perusahaan, referensi, dan pemeriksaan

- **Data perusahaan:** setiap angka/jawaban per catatan yang dipakai analisis wajib berasal dari dataset gabungan final. Nilai mentah boleh dipertahankan untuk provenance; modul R&D membaca nama standar dan statusnya untuk keputusan analitis.
- **Referensi harga/faktor/klasifikasi:** diproses dan dicatat sebelum batas wave. Analisis menerima artefak referensi yang sudah diterbitkan beserta wave, bukan membuka kembali workbook pemasok. Keberadaan referensi tidak dianggap sebagai pengesahan padanan perusahaan.
- **Keterangan sumber dan hasil pemeriksaan:** laporan yang menjelaskan asal file membaca daftar sumber/receipt hasil penyiapan. Metadata tidak disamarkan sebagai observasi perusahaan.
- **Data lama sebagai pembanding:** hanya kode pemeriksaan yang boleh membacanya. Nilainya tidak boleh dimasukkan kembali ke perhitungan analisis.
- **Data uji buatan:** tetap terpisah dari data perusahaan dan diberi label.

## 4. Perubahan yang sudah diketahui perlu dilakukan

1. Ganti penyimpanan tahunan dari dataset yang kebetulan terbuka menjadi penggabungan berkas variabel–tahun yang eksplisit.
2. Hilangkan ketergantungan numerik pada kandidat G0 lama: bangun kembali kebutuhan penyiapan dari tahunan antara, lalu terbitkan wave siap.
3. R&D 2017 membaca `rd_indicator_raw`, `val_costrd`, statusnya, serta dua kategori literal yang disiapkan sebelum wave terbit: `rd17_own_token_class` dan `rd17_external_token_class` (str6). Wave final mempunyai 4.593 kolom: 4.591 kolom terdahulu tetap persis, ditambah dua kolom tersebut. Aturan pertanyaan, kosong/skip, penyebut dan hasil tetap diperiksa terhadap hasil terdahulu.
4. Pindahkan tabel G0 dan sumber angka grafik ke wave/gabungan wave yang sudah lulus. Pastikan pembacaan reference/metadata diberi peran yang jelas.
5. Catat semua pembacaan lain yang ditemukan audit sebelum mengubah kode. Tidak menganggap dua perbaikan pertama menutup semua jalur.

## 5. Bukti selesai yang wajib ada

- Daftar setiap proses aktif, input, output, dan perannya; tidak mencampur arsip atau copy portable lama.
- Semua tahun benar-benar dirakit dari berkas variabel yang dinyatakan; input kunci ganda, tahun salah dan kolom hilang ditolak oleh pemeriksaan yang relevan.
- Semua kolom dasar yang dijanjikan tetap ada; nilai, tipe dan kunci diperiksa. Perbedaan urutan kolom hanya boleh bila kontrak secara eksplisit mengaturnya dan pembaca tidak bergantung urutan.
- Wave siap dibangun tanpa memakai dataset final lama sebagai input numerik.
- Seluruh 30 CSV pembanding yang relevan cocok tepat pada nilai yang dipertahankan; hasil R&D 2017 dan persentase tampilannya cocok.
- Daftar pembacaan downstream tidak mengandung sumber perusahaan di luar wave/hasil turunannya. Perubahan sumber atau kegagalan persiapan menghentikan analisis sebelum angka baru diterbitkan.
- Semua grafik yang telah terbit mempunyai sumber CSV dan jalur ke wave atau metadata penyiapan yang dinyatakan. Keberadaan PDF lama tidak dihitung sebagai keberhasilan jalur baru.
- Status seluruh 44 rencana menerima aturan input yang sama. Ini pembaruan kontrak; tidak mengklaim 44 modul sudah diimplementasikan.

## 6. Batas pelaksanaan

Satu proses Stata pada satu waktu, memakai shared lock yang sudah ada. Target maksimum tambahan 8 GiB; batas keras 10 GiB, dengan minimum 12 GiB ruang tersisa. Sumber asli, hasil lama, PDF dan freeze sebelumnya tidak ditimpa. Hanya proses milik tugas ini yang boleh dihentikan. Tidak ada putaran ekspor PNG Stata atau pengujian portabilitas lama.

Penyiapan, audit/review kode, dan penyesuaian R&D dipisah kepada tiga agen. Root menyatukan rencana, memeriksa syarat selesai, mengemas hasil dan memperbarui jalur baca. Jangan menjalankan Stata sebelum rincian rencana disatukan dan status rencana ditandai siap oleh root.

## 7. Keputusan akhir sebelum implementasi

- Audit menemukan 13 kelompok perubahan, dengan 60 lokasi pembacaan yang perlu dipetakan; ini bukan 60 pelanggaran yang semuanya berjalan. Daftar lengkap berada di `audit/company-read-boundary-audit.json`. Input mentah sah di penyiapan sebelum wave, tetapi dilarang sebagai input hitungan perusahaan sesudah wave.
- Ringkasan kelengkapan X04 dan jumlah status X06 benar-benar dihitung ulang dari wave baru. Tidak boleh menyalin CSV angka lama. Perbandingan X04 memakai proyeksi 4.591 kolom terdahulu; bila dua kolom kategori baru ditampilkan, 24 kombinasi kolom–tahun tambahan dilaporkan terpisah, bukan dianggap selisih angka lama.
- Koreksi yang membentuk data (370 proses hingga C140) selesai sebelum wave siap diterbitkan. Empat proses ringkasan/ekspor C150, C160, C170 dan C180 berjalan sekali setelahnya.
- Flag harga lama yang diperlukan C130 dihitung kembali dengan rumus lama di hulu. Baik C010 maupun C140 tidak boleh memuat baseline final historis sebagai input konstruksi.
- Persiapan boleh menyatukan tahunan antara untuk perhitungan yang memerlukannya, kemudian memecah hasil menjadi wave siap. Larangan input berlaku pada analisis sesudah batas wave siap; audit tidak boleh keliru melarang pengolahan mentah di hulu.
- Perintah gambar dan ekspor grafik dikeluarkan dari eksekusi ini. Pembuatan angka/bin histogram yang diperlukan tabel tetap dijalankan.

Rincian yang mengikat: `plans/foundation.md`, `plans/rd2017.md`, kontrak kolom R&D, serta audit pembacaan. Pembekuan ini mengizinkan implementasi; kode dan registri input final masih harus diperiksa sebelum proses Stata dimulai.

## 8. Koreksi pemilik: satu dataset gabungan sebagai pintu masuk analisis

Instruksi terbaru pemilik pada 13 September 2026 memperketat batas input. **Wave tahunan tetap disimpan untuk ditelusuri, tetapi bukan lagi pintu masuk langsung bagi analisis.** Hanya proses penggabung boleh membaca dua belas wave tersebut. Semua analisis, termasuk R&D 2017 dan statistik satu tahun, membaca `data/analysis/G0_analysis_ready.dta` atau hasil turunannya. R&D memilih tahun 2017 setelah membuka dataset gabungan.

Urutan final: sumber → berkas variabel–tahun → tahunan antara → penyiapan lengkap/koreksi → wave siap → append menjadi dataset gabungan final → analisis → CSV → grafik/tabel. Semua cleaning, pelabelan, dan penyiapan nilai yang diperlukan selesai sebelum dataset gabungan final disahkan. Tidak ada perubahan rumus ilmiah dalam revisi ini.

Registri memuat tepat satu node `consolidated_ready`, dengan 12 `wave_ready` sebagai leluhur. Tidak boleh ada panah analisis yang memintas dataset gabungan menuju wave. File gabungan mandiri, kamus kolom, cakupan tahun, serta batas penggunaannya disiapkan untuk penyerahan kepada tim. File perusahaan tidak diunggah ke GitHub. Kunci tahun/baris sumber tetap dibedakan dari identitas pabrik lintas tahun.

Bagian ini menggantikan setiap kalimat lama dalam subrencana yang mengizinkan analisis langsung dari wave. Semua batas ilmiah dan pembandingan angka tetap berlaku.

Amendment pemeriksaan kode: kategori R&D strict-blank menerima nilai canonical missing dengan status 3 atau 5 agar fixture TAB L14 tetap mengikuti parser literal lama. Semua nilai/status pada proyeksi 4.591 kolom dipertahankan; ini perbaikan guard, bukan pengubahan jawaban.

## 9. Setiap langkah terlihat, setiap blok dijelaskan

Instruksi pemilik pada 13 September berlaku untuk seluruh do-file aktif, termasuk anak file yang dihasilkan otomatis. Ada dua hal berbeda yang wajib tersedia:

1. **Komentar kode yang tidak dijalankan.** Di awal file, komentar `*` menjelaskan tujuan, masukan, hasil, dan hal yang perlu diperiksa jika gagal. Di dalam file, komentar menjelaskan maksud setiap blok dan subblok dengan bahasa Indonesia sederhana. Nama kolom dan file tetap tepat; penjelasan tidak boleh mengarang arti ekonomi atau mengubah rumus. Penanda bagian mengikuti susunan file → blok → subblok. Komentar yang hanya mengulang perintah tanpa menjelaskan maksudnya belum cukup.
2. **Pesan yang terlihat saat proses berjalan.** Setiap file, blok, subblok, iterasi, dan langkah terdalam mencetak STARTING dan FINISHED, posisi `(x/X)`, persentase, durasi, serta nama/lokasi langkah. Urutan yang keluar lebih awal ditandai demikian; kegagalan menyebut lokasi dan kode kesalahan. Pesan tampil langsung dan tersimpan dalam log yang sama.

Durasi memakai jam dan tanggal Stata dengan ketelitian **satu detik** pada setiap tingkat. Langkah yang sangat cepat dapat tampil 0 detik; ini bukan klaim bahwa waktunya benar-benar nol. Jam yang mundur menghasilkan kesalahan pencatatan dan menggagalkan pengesahan run. Cara ini tetap bekerja setelah `clear all` dan tidak mengambil alih timer milik analisis.

Penambahan komentar dan pesan tidak boleh mengubah data, rumus, hasil `r()`/`e()`, kode kesalahan, asosiasi `if/else`, atau perilaku `continue`, `break`, dan `exit`. Baris kode asli dapat dipulihkan persis dari berkas hasil penambahan. Komentar dan pencatatan tidak diberi peran sebagai input numerik dalam grafik ketergantungan.

Sebelum data perusahaan diproses, satu uji kecil dengan data buatan wajib membuktikan: langkah bercabang dan berulang tercatat pada tingkat yang benar; pesan benar-benar dieksekusi; hasil statistik serta kode kesalahan tetap sama; `clear all` tidak memutus pencatatan; kegagalan dan keluar awal tidak disebut berhasil; log yang diteruskan ke layar sama dengan log akhir. Uji ini diperiksa terpisah dari penulisnya.

## 10. Syarat sebelum mengatakan penyiapan data siap

Sediakan satu peluncur yang dapat dijalankan pemilik sendiri. Peluncur menyebut masukan yang diperlukan, menjalankan urutan yang sama dengan urutan teruji, menampilkan progres langsung, dan berhenti dengan lokasi kesalahan bila suatu syarat gagal. Ia tidak memerlukan perintah manual tersembunyi atau analisis tambahan untuk menghasilkan dataset final.

Status **penyiapan data siap** hanya boleh diberikan setelah peluncur, penyiapan perusahaan sebenarnya, dua belas wave, dataset gabungan, pembandingan angka, cabang R&D 2017, dan pemeriksaan semua jalur baca lulus. Sertakan kamus kolom dan petunjuk singkat untuk tim. Keterbatasan identitas perusahaan lintas tahun serta syarat ilmiah modul lain tetap dijelaskan; keberhasilan penyiapan ini tidak berarti seluruh 44 modul penelitian selesai.
