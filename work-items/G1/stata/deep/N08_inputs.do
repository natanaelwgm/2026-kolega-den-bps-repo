* WFDOC: N08 menghitung domain dan distribusi input per tahun sumber pada S01, memakai k_begin/k_concept yang sudah dibentuk N01.
* WFDOC: Kunci keluaran: source_year×input untuk deep_input_domains dan source_year×input×scale untuk distribusi; N_source memakai seluruh baris tahun itu.
* WFDOC: Berkas keluaran ialah deep_input_domains.csv dan deep_input_distributions.csv; sumber memuat 2010–2015 dan 2017–2022 tanpa mengisi 2016.
* WFDOC: Unit uang tetap unit nominal sumber, pekerja tetap jumlah; positive/log_positive adalah dukungan log, bukan deflasi, verifikasi unit, atau penerimaan fit.
* WFDOC: Missing, nol, negatif, positif, gagal-konsep dan log-usable dilaporkan berbeda; kegagalan merge/assert menghentikan edge sebelum CSV akhir.
tempname dom dst
postfile `dom' double source_year str12 input double N_source double N_missing double N_zero double N_negative double N_positive double N_concept_fail double N_log_usable double production_year_supported str80 construction_scope using "$G1_DEEP/intermediate/deep_input_domains.dta", replace
postfile `dst' double source_year str12 input str20 scale double N double mean double sd double min double p1 double p5 double p25 double p50 double p75 double p95 double p99 double max double iqr double fence_lo15 double fence_hi15 double fence_lo3 double fence_hi3 double N_below15 double N_above15 double N_below3 double N_above3 double numeric_released using "$G1_DEEP/intermediate/deep_input_distributions.dta", replace
* WFDOC: Ambil hanya kunci observasi-tahun dan dua field modal awal; merge berikut menguji satu-ke-satu tanpa menarik kolom master lain.
use "$G1_BASE/nominal/N01_source.dta", clear
keep obs_id source_year nom_k_begin nom_k_concept nom_i_concept nom_k_documented nom_i_documented
tempfile begin
save `begin'
use "$G1_BASE/S01_input.dta", clear
* WFDOC: assert(1 3) mengizinkan baris S01-only atau matched dan menolak baris N01-only; kunci tetap harus unik pada kedua sisi.
merge 1:1 obs_id source_year using `begin', assert(1 3) nogen
gen double d_y=value_added_nominal
gen double d_l=workers
gen double d_k_end=capital_stock_nominal
gen double d_k_begin=nom_k_begin
gen double d_i=capital_additions_nominal
gen double d_m=val_rtlvcu
* WFDOC: source_year0 pools all source rows. Concept failures use the maintained assumptions; documentary flags remain unchanged in source/intermediate data.
* WFDOC: source_year=0 adalah pool seluruh source rows; tahun lain memakai exact source_year, sehingga 2016 tetap kosong dan tidak ada baris sintetis di antara 2015 dan 2017.
foreach year in $D_YEARS {
    local yr "source_year==`year'"
    if `year'==0 local yr "1"
    foreach input in y l k_end k_begin i m {
        local v d_`input'
        count if (`yr')
        local ns=r(N)
        foreach state in missing zero negative positive {
            local test "missing(`v')"
            if "`state'"=="zero" local test "`v'==0"
            if "`state'"=="negative" local test "`v'<0"
            if "`state'"=="positive" local test "`v'>0 & !missing(`v')"
            count if (`yr') & `test'
            local n_`state'=r(N)
        }
        * WFDOC: nom_k_concept menandai adanya lag kalender dan nom_i_concept mengikuti asumsi candidate; concept_fail sengaja dipisahkan dari missing, nol dan negatif.
        local flag "1"
        local nf .
        if "`input'"=="k_end" local flag "1"
        if "`input'"=="k_begin" local flag "nom_k_concept==1"
        if "`input'"=="i" local flag "nom_i_concept==1"
        if inlist("`input'","k_end","k_begin","i") {
            count if (`yr') & !(`flag')
            local nf=r(N)
        }
        * WFDOC: N_log_usable hanya menghitung nilai positif yang lolos concept gate; tiga scale menjaga perbedaan native, positive dan log_positive terlihat tanpa deflasi.
        count if (`yr') & `v'>0 & !missing(`v') & (`flag')
        local nl=r(N)
        local scope "source_field_all_years"
        if "`input'"=="k_end" local scope "assumed_year_end_stock_all_source_years"
        if "`input'"=="i" local scope "assumed_reported_additions_investment_candidate"
        if "`input'"=="k_begin" local scope "exact_calendar_lag_of_assumed_year_end_stock"
        post `dom' (`year') ("`input'") (`ns') (`n_missing') (`n_zero') (`n_negative') (`n_positive') (`nf') (`nl') (cond(`year'==0,.,inrange(`year',2011,2015) | inrange(`year',2018,2022))) ("`scope'")
        * WFDOC: native menjaga nilai sumber; positive mengeluarkan nonpositif; log_positive mengambil ln hanya setelah syarat positif.
        foreach scale in native positive log_positive {
            tempvar value
            gen double `value'=`v' if (`yr')
            if inlist("`scale'","positive","log_positive") replace `value'=. if `value'<=0
            if "`scale'"=="log_positive" replace `value'=ln(`value')
            deep_stats `value'
            post `dst' (`year') ("`input'") ("`scale'") $D_POST
            drop `value'
        }
    }
}
* WFDOC: CSV domain/distribusi memuat hitungan sumber dan statistik terbuka saat N≥5; k_begin di luar jendela konstruksi tetap eksplisit.
postclose `dom'
use "$G1_DEEP/intermediate/deep_input_domains.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_input_domains.csv", replace
postclose `dst'
use "$G1_DEEP/intermediate/deep_input_distributions.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_input_distributions.csv", replace
