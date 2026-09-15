**Input development terbaru: [G0.5](../../data/g0-5-development/README.md), 33.049 × 4.379.** Paket aktual yang dulu berada di `cloud-data/data/` sudah dicadangkan lokal dan dikeluarkan dari tree aktif; [receipt](cloud-data/retirement.json) mengikatnya ke revisi historis. Hasil/30 tabel aktual di bawah tetap bukti rilis G0 terdahulu. G0.5 tidak menjalankan ulang tabel tersebut. [Mode data dan finalisasi](../../docs/DATA-MODES.md).

# Dataset gabungan dan kode penyiapan

**Rilis aktual sebelum G0.5 — bukti historis yang dipertahankan.** Master lengkap lokal memuat 33.049 baris × 4.593 kolom dari 12 wave. Salinan cloud sebelumnya memuat seluruh baris dan 4.376 kolom setelah 217 kolom identitas/teks tertentu dikeluarkan. Semua angka ekonomi yang dipertahankan tetap persis.

Mulai dari [panduan membuka data](cloud-data/README.md). Pembaca Python menggabungkan semua bagian menjadi satu dataset sebelum analisis. [Kamus kolom](cloud-data/dictionary.csv) memuat label, tipe dan status ketersediaan kolom.

[Seluruh kode Stata](stata-preparation/README.md) menyertakan komentar, progres setiap blok, serta [44 rencana](stata-preparation/row-plans/). Menjalankan ulang penyiapan memerlukan sumber lokal dan Stata berlisensi; sumber asli tidak diunggah. Jalur lokal dalam kode dan daftar sumber adalah catatan lokasi pelaksanaan di Mac pemilik, bukan paket yang sudah dibuktikan portabel di mesin lain.

[Bukti pembaca](verification/actual-loader-check.json) mencatat pemeriksaan seluruh bagian dan metadata, jumlah baris/kolom, cakupan tahun, dan tidak adanya kolom yang dikecualikan. [Bukti penyiapan data](verification/master-acceptance.json) mengikat hasil dengan proses Stata yang telah selesai dan lulus. Seluruh 30 tabel kini sudah lulus perbandingan persis dan ekspor–baca ulang CSV. R&D 2017 selesai menjalankan 11 langkah dan 12 pemeriksaan ekspor–baca ulang. [Bukti pelaksanaan](execution-evidence/runtime/core-execution-chain.json) menyimpan urutan 17 tahap yang lulus melalui kelanjutan terdokumentasi; ini bukan klaim satu kali proses dari kosong tanpa berhenti. [Hasil CSV](results/) tersedia untuk menggambar di Python/R.

Data tersedia tidak berarti seluruh 44 modul sudah selesai. Identitas perusahaan lintas tahun, beberapa hubungan klasifikasi/harga, serta sebagian satuan sumber masih memerlukan bukti. Jangan membuat identitas panel dari urutan baris. Paket tetap privat; penghilangan identitas langsung bukan jaminan anonim.

Komentar Luna/max kini terpasang di seluruh **6.306 do-file**: **75.596 baris komentar**, termasuk **50.376 catatan langkah**. Pemeriksaan lengkap membuktikan semua perintah perhitungan dan log tetap persis sama. [Bukti pemeriksaan komentar](execution-evidence/comment-review/root-review.json) menghubungkan versi kode dengan hasil Stata yang sudah lulus. Penambahan komentar bukan pelaksanaan ulang seluruh analisis.

[Peluncur ulang](replay-support/) mencadangkan hasil lama, menjalankan 17 tahap berurutan, lalu merapikan log yang sudah selesai. Diperiksa dengan 31 pengujian kecil; belum dibuktikan melalui satu kali pelaksanaan ulang penuh pada seluruh data nyata. Peluncur pada Mac pemilik memakai lokasi sumber dan riwayat lokal yang dipatok. Untuk mesin lain, sumber asli dan riwayat yang diperlukan harus disediakan terlebih dahulu.
