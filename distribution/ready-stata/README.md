# ZIP ringkas: data ready → analisis

Paket **SI-Ready-STATA.zip** berisi satu do-file utama, data ready pengembangan, kode 34 kelompok analisis, dan add-on Stata. Paket tidak membawa sejarah Git, pengolahan raw, hasil lama, Python, atau peluncur `.command`/`.cmd`.

## Pakai ZIP

1. Ekstrak ZIP dan buka **00_JALANKAN_SEMUA.do** di Stata Do-file Editor.
2. Sesuaikan **SI_ROOT** dengan folder hasil ekstraksi dan **READY_DATA** dengan berkas `.dta`. Jika memakai data bawaan, cukup ubah **SI_ROOT**.
3. Tekan **Do** untuk seluruh file. Perlu Stata SE/MP 17 atau lebih baru; tidak perlu Python untuk menjalankannya.

Mac: contoh **SI_ROOT** adalah `/Users/natanaelmassie/Downloads/SI-Ready-STATA`. Windows: gunakan misalnya `C:/SI-Ready-STATA`.

Hasil baru berada di `hasil/<tanggal-jam>/kode/<kelompok>/`. Folder `output` memuat Excel dan grafik deskriptif; `tables` memuat CSV; `figures` memuat grafik estimasi. Satu tabel dapat mendukung beberapa grafik. `hasil/<tanggal-jam>/STATUS.tsv` merangkum kelompok yang selesai, kekurangan data, atau gagal.

Pada data latihan ini, 21 kelompok deskriptif dan delapan estimasi sudah menghasilkan tabel. Lima kelompok masih memerlukan informasi pemerintah atau rincian produk/bahan baku. Angka memakai nilai tersamar dan hubungan perusahaan buatan, bukan temuan BPS. Penghitungan seluruh analisis dapat memerlukan 1–2 jam. Pengujian langsung dilakukan di Mac; Windows belum diuji langsung.

## Buat ZIP dari repo

Dari folder repo, jalankan satu perintah dengan Python 3.10 atau lebih baru. Pembuat ZIP hanya memakai pustaka bawaan Python dan tidak menjalankan analisis.

```sh
python3 scripts/export_ready_stata.py
```

Pada Windows, gunakan `py scripts/export_ready_stata.py`. Hasilnya **dist/SI-Ready-STATA.zip**, termasuk data ready yang sudah tersimpan di repo. Ekspor menolak menimpa ZIP lama; berikan `--output` lain untuk versi berikutnya.

Data lokal lain dapat dipilih saat membuat paket:

```sh
python3 scripts/export_ready_stata.py --ready-data "/lokasi/data_ready.dta" --output "dist/SI-Ready-STATA-lokal.zip"
```

Untuk paket tanpa data, gunakan `--without-data`. Data lokal yang dipilih hanya masuk ZIP lokal; pembuat paket tidak mengunggah apa pun.

Kode diambil langsung dari folder analisis repo. Ekspor meniadakan pembuatan PDF pada salinan paket; Excel, CSV, PNG, rumus, sampel, seed dan jumlah pengulangan tetap dipertahankan. Add-on menggunakan versi yang dipatok dalam `ado-manifest.json`, dengan asal paket dan penulis di `ado/SOURCE-PACKAGES.txt`. `code-manifest.json` di dalam ZIP mencatat versi sumber dan hash berkas.
