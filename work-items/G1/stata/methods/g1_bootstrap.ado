*! External full-source plant bootstrap. No firm records are exported.
* WFDOC: Program ini menjalankan point fit lalu bootstrap klaster perusahaan secara eksternal untuk OP, LP, ACF, atau Wooldridge.
* WFDOC: Satu baris masukan adalah perusahaan-tahun; id harus ID perusahaan terverifikasi. Definisi satuan dan mode pengukuran diwarisi dari kontrak pemanggil dan tidak dapat diperiksa dari angka saja.
* WFDOC: Hasilnya ringkasan koefisien dan diagnostik per draw serta kovarians/interval dari draw yang berhasil; file sumber berisi hasil bootstrap, bukan baris mikro perusahaan.
* WFDOC: Pada nominal_development, panelstatus synthetic_development dan ID resmi paket development boleh dipakai secara eksplisit; syarat ini tidak mengesahkan linkage aktual dan mode real tetap memerlukan ID terverifikasi.
program define g1_bootstrap, rclass
    version 17.0
    syntax, ID(varname numeric) SAVING(string) [DRAWS(integer 999) SEED(integer 90132026) *]
    * WFDOC: draws menghitung replikasi acak saja, terpisah dari point fit; nilai di bawah dua ditolak karena kovarians sampel memerlukan lebih dari satu keberhasilan.
    if `draws'<2 exit 198
    * The first call is the point estimate, never counted as a random draw.
    * WFDOC: Point fit awal disimpan sebagai pembanding, tetapi bukan salah satu draw bootstrap dan tidak masuk penyebut kovarians.
    g1_fit, id(`id') `options'
    local point_l=_b[labor]
    local point_k=_b[capital]
    tempfile source drawsdata
    * WFDOC: Salin seluruh panel sumber yang diterima, termasuk catatan risk/exit di luar domain produksi OP, sebelum pengambilan klaster.
    quietly save `source'
    tempname results covariance
    postfile `results' int draw int rc byte success double labor double capital double objective double N double N_selection using `drawsdata', replace
    set seed `seed'
    * WFDOC: Setiap putaran mengambil ulang perusahaan sebagai klaster dari salinan penuh, memberi ID baru untuk duplikasi perusahaan, lalu mengulang filter transisi dan seluruh tahapan metode.
    forvalues draw=1/`draws' {
        preserve
        quietly use `source', clear
        tempvar boot_id
        * WFDOC: Pengambilan dilakukan pada tingkat id perusahaan; idcluster memisahkan salinan perusahaan yang terambil berulang agar lag tidak melintasi klaster duplikat.
        quietly bsample, cluster(`id') idcluster(`boot_id')
        capture noisily g1_fit, id(`boot_id') `options'
        local rc=_rc
        local success=0
        local bl=.
        local bk=.
        local q=.
        local n=.
        local ns=.
        if `rc'==0 {
            local success=e(converged)==1
            local bl=_b[labor]
            local bk=_b[capital]
            local q=e(objective)
            local n=e(N)
            local ns=e(N_selection)
        }
        * WFDOC: Simpan setiap draw termasuk kode gagal; baris memuat beta labor/capital, objective, N transisi dan N selection OP bila tersedia.
        post `results' (`draw') (`rc') (`success') (`bl') (`bk') (`q') (`n') (`ns')
        restore
    }
    postclose `results'
    preserve
    * WFDOC: Bentuk tabel hasil satu baris per draw; kolom tambahan mengikat setiap baris ke point fit, jumlah draw yang diminta, seed, dan cakupan input.
    use `drawsdata', clear
    quietly count if success==1
    local successful=r(N)
    gen double point_labor=`point_l'
    gen double point_capital=`point_k'
    gen int requested_draws=`draws'
    gen long bootstrap_seed=`seed'
    gen str60 scope="Full-process cluster bootstrap; source mode inherited from accepted input"
    save "`saving'.dta", replace
    export delimited using "`saving'.csv", replace
    matrix `covariance'=J(2,2,.)
    local lo_l=.
    local hi_l=.
    local lo_k=.
    local hi_k=.
    * WFDOC: Kovarians dan persentil 2.5/97.5 dihitung hanya dari draw sukses. correlate covariance memakai penyebut B_sukses-1; hasil sengaja kosong bila keberhasilan kurang dari dua.
    if `successful'>1 {
        quietly correlate labor capital if success==1, covariance
        matrix `covariance'=r(C)
        quietly centile labor if success==1, centile(2.5 97.5)
        local lo_l=r(c_1)
        local hi_l=r(c_2)
        quietly centile capital if success==1, centile(2.5 97.5)
        local lo_k=r(c_1)
        local hi_k=r(c_2)
    }
    restore
    return matrix covariance=`covariance'
    return scalar requested=`draws'
    return scalar successful=`successful'
    return scalar covariance_denominator=`successful'-1
    return scalar point_labor=`point_l'
    return scalar point_capital=`point_k'
    return scalar ci_labor_lo=`lo_l'
    return scalar ci_labor_hi=`hi_l'
    return scalar ci_capital_lo=`lo_k'
    return scalar ci_capital_hi=`hi_k'
    * WFDOC: Penanda ini hanya benar bila 999 dari 999 draw sukses; penerimaan interval penelitian tetap mengikuti ambang minimal 95 persen pada kontrak dan memerlukan bukti run terpisah.
    return scalar full_999_draws=`draws'==999 & `successful'==999
end
