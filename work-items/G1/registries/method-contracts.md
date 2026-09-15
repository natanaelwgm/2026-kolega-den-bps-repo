# Kontrak empat metode G1

G0.5 DEVELOPMENT — perturbed data; not final empirical findings

Dokumen ini menetapkan empat estimator yang berbeda. Kontrak bukan bukti bahwa estimator sudah berjalan atau bahwa input empirisnya valid. Simbol: y=ln(nilai tambah riil), l=ln(pekerja), k=ln(stok modal riil), p=ln(proksi yang sesuai). Fungsi produksi utama: y=βL l+βK k+ω+ε.

## OP

**first stage.** Regress y on l and [1,B_d(k,p_OP)]; beta_L is the partially linear first-stage coefficient; phi_hat=fitted_y-beta_L*l.

**second stage.** For candidate beta_K, omega=phi_hat-beta_K*k. Regress omega on [1,omega_lag,omega_lag^2,omega_lag^3] and, for the required selection branch, the full cubic terms of authenticated predicted exit probability and its interactions with lagged omega. Minimize sum[(y-beta_L*l)-beta_K*k-g_hat]^2 on exact-calendar supported transitions.

**selection.** Required selection probability is estimated from independently authenticated risk/exit data, using the declared lagged B_d(k,p_OP) on the observed risk set. Selection outcome must not be inferred from the last row of the estimator-filtered sample. Unknown closure/risk status is excluded with a reason. If the selection model cannot be estimated, do not silently switch to an uncorrected OP result. Fit and resample the selection model on the authenticated risk/exit universe before imposing positive-investment coefficient-estimation eligibility. Keep selection-sample and production-sample receipts distinct; risk/exit records outside the coefficient sample must remain available.

Investasi menjadi proksi informasi produktivitas yang diketahui pabrik. Tenaga kerja ditaksir pada tahap pertama, modal pada tahap kedua. Koreksi seleksi wajib memakai risiko/keluar yang dibuktikan dari sumber tersendiri. Baris terakhir survei bukan bukti tutup. Sampel seleksi dipertahankan lebih luas daripada sampel investasi positif.

## LP

**first stage.** Regress y on l and [1,B_d(k,p_other)]; retain beta_L and phi_hat=fitted_y-beta_L*l.

**second stage.** Use omega=phi_hat-beta_K*k and cubic Markov projection in lagged omega; minimize sum[(y-beta_L*l)-beta_K*k-g_hat]^2. No attrition correction in the primary LP branch. This is the pinned package’s two-stage nonlinear least-squares implementation, not a claim to estimate an unspecified GMM system.

Input antara menggantikan investasi sebagai proksi. Tahap pertama memisahkan koefisien tenaga kerja dari fungsi proksi; tahap kedua mencari koefisien modal dengan proses produktivitas Markov. Versi sumber yang dipatok memakai kuadrat residu pada tahap kedua. Angka pengeluaran positif belum membuktikan kuantitas, harga riil, atau asumsi monotonisitas.

## ACF

**first stage.** Regress y on the complete degree-d polynomial in l,k,p_other (with only one copy of each monomial); fitted value is phi_hat.

**second stage.** For beta=(beta_L,beta_K), omega=phi_hat-beta_L*l-beta_K*k; project omega on [1,omega_lag,omega_lag^2,omega_lag^3]; innovation xi is the residual. Minimize (Z'xi)' W (Z'xi), Z=[lag(l),k], W=invsym(Z'Z)/N, as in the pinned source. No extra overidentification instruments.

**timing.** k is predetermined and l is selected before the current innovation in the maintained ACF timing; lag(l) and current k must satisfy their moments. The data alone do not verify this assumption.

Tahap pertama memasukkan polinomial lengkap tenaga kerja, modal, dan proksi tanpa mengidentifikasi koefisien tenaga kerja secara terpisah. Tahap kedua memilih kedua koefisien dari momen inovasi produktivitas. Instrumen adalah tenaga kerja t−1 dan modal t; itu menuntut asumsi waktu keputusan, bukan sekadar data tidak hilang.

## Wooldridge

**selection.** Use explicit method(wrdg) gmm; the package’s default without gmm is a stacked linear IV branch and is not silently substituted for the requested system.

**equation1.** r1=y-beta_L*l-beta_K*k-a0-c_t'theta, c_t=B_d(k_t,p_t).

**equation2.** r2=y-beta_L*l-beta_K*k-a0-e0-c_(t-1)'theta. The installed source shares theta between equations; this restriction is documented and must be retained if this exact version is used.

**instruments.** Z1=[1,l_t,c_t]; Z2=[1,k_t,l_(t-1),c_(t-1)]. No optional overidentification expansion. Require full estimable rank and disclose columns removed for exact collinearity.

**weighting.** Pinned two-step Stata gmm behavior with winitial(unadjusted, independent), method(wrdg) gmm, optimizer gn, maxiter 10000; save effective tolerances and convergence diagnostics.

Dua persamaan diestimasi bersama dengan GMM. Persamaan kini dan lag memiliki instrumen berbeda, dan versi sumber ini membatasi koefisien proksi agar sama di kedua persamaan. Istilah sistem bersama tidak berarti satu langkah pembobotan: spesifikasi memakai pembobotan GMM dua tahap. Cabang IV linear bawaan bukan pengganti sistem yang diminta.

## Aturan bersama

Operational screen: at least 50 distinct real plants, 250 eligible dynamic records and six observed calendar waves per technology-method cell, plus full required design/instrument rank. These thresholds are practical precision screens, not a proof of identification.

Lags are exact t-1 or t-2 calendar lags; do not treat 2015 as the one-year lag of 2017. No conditioning on future long-lived plants to select the main sample.

B_d(k,p) contains all monomials k^a p^b with 1<=a+b<=d; an intercept is included by regression. d=3 primary, d=2 sensitivity. ACF uses all monomials in l,k,p of total degree 1..d. Do not duplicate linear labor columns.

Primary: no extra control() variables, within verified two-digit technology pools; this maintains an explicit common proxy/Markov specification across supplied years. Calendar composition is displayed. A year-control extension is not in the required execution grid and requires a separately frozen timing/normalization specification before fitting.

r_it=y_it-beta_L*l_it-beta_K*k_it is the common four-method log value-added production residual. It contains latent productivity plus transitory measurement/output error under the maintained model, and is labelled accordingly. Retain raw and separately centered versions; do not call it directly observed technical efficiency.

A separately named proxy-based omega may be exported only where its first-stage definition is supported. For OP/LP phi is already net of beta_L*l, so omega_proxy=phi-beta_K*k; for ACF omega_proxy=phi-beta_L*l-beta_K*k. The source predict,omega path requires saved first-stage residuals and cannot be assumed available for Wooldridge, whose branch rejects fsresiduals. No fake four-method latent-omega attachment.

Polinomial tahap pertama derajat 3 adalah utama; derajat 2 adalah sensitivitas. Proses Markov OP/LP/ACF tetap kubik dalam implementasi yang dipatok. Tahan semua sel gagal dan laporkan peringkat matriks, momen, tujuan optimisasi, titik awal dan konvergensi. Konvergensi bukan pembuktian identifikasi.

Inferensi yang terdaftar: 999 pengambilan ulang klaster perusahaan atas seluruh proses, di luar estimasi asli, seed 20260913. Minimal 950 berhasil. Kovarians menggunakan pembagi B_berhasil−1. Aturan999 ini berlaku pada primary real. Cabang nominal DEVELOPMENT memakai99 draw dengan minimal95 sukses, bersyarat pada ID fiktif resmi; hasilnya bukan inferensi populasi.

Sumber kontrak: [rencana G1](../../../releases/2026-09-13-data-foundation/stata-preparation/row-plans/G1.json) dan [kontrak sumber yang dipatok](pinned_method_contract.json). Definisi ini mempertahankan spesifikasi warisan; lihat bukti penerimaan implementasi terpisah sebelum pemakaian empiris.
