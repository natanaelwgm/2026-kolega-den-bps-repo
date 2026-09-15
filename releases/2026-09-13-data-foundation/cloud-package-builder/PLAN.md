# Paket data untuk GPT Pro

Sumber tunggal adalah dataset gabungan baru setelah benar-benar lulus pemeriksaan. Paket ini merupakan hasil turunan dari dataset tersebut. Data sumber dan dataset lama tidak menjadi masukan.

1. Periksa bukti kelulusan proses dan kecocokan hash dataset final.
2. Keluarkan kolom nama, alamat, kontak, kode identitas, lokasi rinci dan teks bebas yang belum diperiksa sesuai daftar kolom eksplisit. Jangan membulatkan atau mengacak angka ekonomi. Dataset lengkap lokal tetap tersimpan.
3. Simpan kolom yang dipertahankan ke berkas Parquet kecil; gabungkan seluruh bagian sebelum analisis. Setiap bagian hanya potongan penyimpanan, bukan wave analitis baru. Pertahankan tahun. Catat missing Stata yang memiliki huruf secara terpisah supaya informasi itu tidak hilang.
4. Baca ulang setiap bagian dan buktikan setiap nilainya sama dengan proyeksi dataset final. Catat kolom yang dikeluarkan, tipe asli, label, cakupan tahun dan kunci penggunaan. Jangan membuat identitas perusahaan lintas tahun baru.
5. Sediakan Python pembaca, kamus kolom, instruksi untuk GPT Pro dan ZIP yang dapat diunggah langsung. Kode Stata tetap sumber perhitungan penelitian; tersedianya paket bukan bukti Stata berlisensi tersedia di lingkungan GPT Pro.
6. Unggah hanya paket turunan yang diperiksa dan kode ke repo privat yang sudah digunakan. Verifikasi commit remote dan ukuran tiap berkas. Tidak ada data mentah, nilai identitas, kredensial atau log perusahaan dalam publikasi.

Syarat selesai: master lolos; paket turunan cocok pada semua nilai yang dipertahankan; daftar pengurangan kolom lengkap; loader bekerja; repo privat dan commit remote terverifikasi. Penghilangan kolom langsung tidak menjamin anonim: kombinasi angka, industri dan wilayah masih mungkin mengidentifikasi unit. Karena itu paket tetap privat. Semua syarat ilmiah sumber, satuan dan identitas yang belum selesai tetap berlaku.

## Prioritas dataset, 13 September 2026 pukul 13:40 WIB

Penyiapan data diterima setelah seluruh tahap sampai V085 lulus dan proses Stata untuk setiap tahap benar-benar berakhir. Bukti mencocokkan 12 wave dan master dengan hash hasil pembuatnya, skema 33.049 × 4.593, serta hasil pembandingan 4.591 kolom lama. Pembuatan ulang tabel kelengkapan masih berjalan setelah titik ini dan tidak mengubah master. Karena pemilik memprioritaskan dataset untuk GPT Pro, paket cloud boleh dibuat paralel dari bukti DATA_PREPARATION_ONLY yang dibekukan. Ini tidak menyatakan penghitungan tabel atau 44 modul sudah selesai. Status penghitungan tabel dicatat terpisah dan diteruskan sampai selesai.
