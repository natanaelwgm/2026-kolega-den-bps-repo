# Cara memasang persiapan rerun

Helper ini belum memindahkan hasil penelitian. Yang dijalankan dalam pengembangan hanya 24 uji folder sementara berisi byte buatan dan inventory metadata pada foundation yang masih aktif. Gunakan setelah review root selesai dan seluruh pekerjaan yang memakai master lama berhenti.

Semua perintah di bawah memanggil `work/G0-cloud-package/replay_preparation.py` dengan Python sistem. Tidak ada library tambahan.

1. `prepare --foundation <folder-foundation> --manifest-sha256 <seal-yang-direview> --archive <sibling-baru> --dry-run` menghasilkan inventory tanpa perubahan. Status `running` tetap terlihat; dry-run bukan izin eksekusi.
2. Perintah yang sama tanpa `--dry-run` mengambil shared lock, membuktikan final receipt/master/12 wave, mencadangkan seluruhnya lalu memindahkan keluaran generated yang terdaftar ke objek gzip terverifikasi. Input, kode, registry, plan, provenance dan receipt JSON tetap di tempat. Hanya status `READY_FOR_FULL_RERUN` membolehkan pemanggil melanjutkan. Status `ARCHIVED_BUT_SPACE_INSUFFICIENT` memiliki exit code 2 dan katalog pemulihan yang tetap berlaku.
3. Pemanggil membaca urutan dari `registry/stages.json`, lalu menjalankan runner unchanged dengan `--from-stage <ID> --through <ID>` untuk setiap tahap, mulai T000 dan berakhir H090. Sebelum tiap panggilan, tunggu detik UTC baru jika folder `runtime/run-YYYYMMDDTHHMMSSZ` telah ada. Pemanggil wajib membuktikan receipt tahap **baru untuk panggilan tersebut**, passed/exited, dan seal sama; receipt lama berstatus passed saja tidak cukup.
4. Setelah setiap proses selesai, panggil `compact-stage --foundation <folder> --receipt runtime/run-<waktu>/<ID>/receipt.json --manifest-sha256 <seal> --archive <sibling-baru-untuk-tahap>`. Helper menolak semua Stata aktif, memegang shared lock, dan memeriksa hash relay lengkap. Seluruh teks log tersimpan dalam gzip, identik byte demi byte setelah didekompresi. Root log dan attempt log yang identik menggunakan satu objek; metadata receipt tetap hot. Tidak ada monitor yang menghapus log saat tahap lain hidup.
5. `restore --archive <folder-arsip> --logical-path data/analysis/G0_analysis_ready.dta` mengembalikan satu berkas asli hanya jika target belum ada. Gunakan path lain dari `ledger.json` untuk 12 wave atau log tertentu. Tidak menimpa hasil baru dan tidak mengklaim hasil lama sebagai hasil rerun baru.

Untuk hanya membuang duplikat root tanpa mengompresi attempt log, tersedia `dedupe-log --foundation <folder> --receipt <receipt-relatif> --ledger <json-di-luar-foundation>`. Operasi ini juga hanya antartahap. Pemanggil normal sebaiknya memakai `compact-stage` agar log lengkap sekaligus hemat ruang.

`ledger.json` mencatat logical path, SHA-256 plain bytes, jumlah byte, objek gzip dan status hot/cold. Arsip bersifat lokal dan dapat memuat data perusahaan; jangan dimasukkan ke Git/cloud package. Metadata receipt yang masih hot boleh merujuk path log yang sekarang cold; katalog adalah petunjuk restorasinya, bukan penggantian receipt asli.

Batas tetap: foundation 10 GiB, free space 12 GiB. Persiapan mensyaratkan footprint hot kurang dari 10 GiB dan ruang bebas sekurangnya 12 GiB + 10 GiB + dua kali ukuran log batch selesai terbesar yang benar-benar teramati. Dua salinan log dapat ditulis runner setelah PID keluar. Peak absolut lama tetap metadata diagnostik; ia bukan tambahan pertumbuhan. Ini batas penerimaan konservatif, bukan jaminan rerun selesai. Keputusan akhir tetap memakai pemeriksaan aktual runner. Pemindahan pada volume yang sama tidak dianggap menambah ruang; hanya penghematan hasil kompresi terverifikasi yang tercermin dalam pengukuran akhir.

Arsip juga boleh memuat salinan `/private/tmp` yang tepat: `batch_relay.source_path` harus sama persis dengan `/private/tmp/` ditambah basename entry `.log`, ukurannya dan SHA harus cocok dengan relay, dan gzip harus lulus dekompresi penuh sebelum file asli dilepas. Path eksternal tersebut dicatat sebagai `external_private_tmp/<basename>` dalam ledger dan dapat direstorasi dengan perintah yang sama. Alias `/tmp`, symlink, nama yang tidak tercatat, dan file lain tidak disentuh. PID historis yang dipakai ulang oleh proses lain tidak menyebabkan penolakan; shared lock, tidak adanya Stata aktif, dan receipt exited adalah batas operasinya. Tidak ada pembersihan glob, perubahan sumber, perubahan perhitungan, atau peluncuran Stata oleh helper.

## Launcher luar

Salin dua file Python berdampingan ke `outputs/replay-support/`: `replay_preparation.py` dan `run_reviewed_preparation.py`. Keduanya hanya memakai standard library. Python milik pipeline tetap dipilih oleh `foundation/run_preparation.command`, yang dipanggil unchanged. Source XLSX/DTA, Stata berlisensi, runtime Python, foundation dan shared-lock parent tetap harus tersedia di Mac yang sama.

Contoh (ganti hash dengan seal akhir yang direview root):

```sh
python3 '/path/outputs/replay-support/run_reviewed_preparation.py' \
  --foundation '/path/work/G0-wave-foundation-v2' \
  --archive '/path/work/G0-wave-replay-20260913-previous' \
  --manifest-sha256 '<CURRENT_CORE_MANIFEST_SHA256>' \
  --helper-sha256 '<REPLAY_PREPARATION_PY_SHA256>' \
  --run
```

Tanpa `--run`, hanya inventory metadata; tidak ada arsip atau Stata. Folder arsip harus sibling baru dari foundation. Log tiap tahap menggunakan sibling `...-stage-T000`, dan seterusnya. `launcher-receipt.json` dalam arsip utama mencatat semua 17 receipt baru beserta hash dan waktu. Bila langkah baru gagal, arsip lama tidak diganti menjadi hasil baru.

Jika seal current berbeda dari eksekusi terakhir hanya karena komentar/metadata yang telah direview, current static review harus membawa descriptor `storage_replay_continuity`. Verifier menuntut exact old/current manifest, final receipt, wave manifest, complete old-to-new delta, `input_files` identik, dan byte non-WFDOC identik untuk setiap do-file berubah. Itu hanya izin menyimpan keluaran lama sebelum rerun T000; bukan klaim bahwa kode baru sudah dijalankan.
