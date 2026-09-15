# Input grafik dari generasi G0 yang baru

Folder ini menyediakan binding dan loader konfigurasi, tanpa menggambar atau mengubah PDF. `bind_inputs.py --master-receipt <foundation/runtime/latest.json>` hanya berhasil setelah proses G0 keluar sukses dan semua 30 tabel cocok dengan kontrak. Status menyebut modul tampilan yang masih belum tersedia; tidak memakai hasil lama sebagai pengganti.

`CurrentInputs(binding).table(name)` memberikan pasangan CSV/DTA agregat yang dipatok. `.exhibit("G0-X04")` mengembalikan tabel induk terverifikasi; persen tampilannya tetap harus berasal dari `.module("display-x04")`. Atlas memerlukan `.module("display-atlas")`, diagnosis X24 memerlukan `.module("current-evidence")`, dan tiga halaman R&D memakai `.module("rd2017")`. Modul yang belum memiliki receipt generasi sekarang ditolak.

Adapter ini dipakai oleh source gate pada pemanggilan presentasi berikutnya. Kode dan PDF rilis lama tetap utuh; folder ini tidak mengklaim telah menggambar ulang 104 halaman. Hanya agregat yang boleh diteruskan ke renderer. Dataset master dicocokkan hash-nya sebagai asal generasi, tidak dimuat ke Python untuk statistik atau grafik.
