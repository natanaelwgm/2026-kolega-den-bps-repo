* Caller runs from repository root. Loading defines commands; it fits nothing.
* WFDOC: Entrypoint ini mengatur pencarian ado di repo lalu memuat definisi g1_prodest_point, g1_fit, dan g1_bootstrap.
* WFDOC: Jalankan dari root repository; file ini tidak membaca panel, melakukan estimasi, atau membuat tabel hasil.
* WFDOC: Pemanggilan berhenti bila salah satu berkas program yang dirujuk tidak tersedia atau gagal dimuat.
adopath ++ "work-items/G1/stata/methods"
run "work-items/G1/stata/methods/g1_prodest_point.ado"
run "work-items/G1/stata/methods/g1_fit.ado"
run "work-items/G1/stata/methods/g1_bootstrap.ado"
