*! G1 guarded value-added production-function point fit. Indonesian commentary pass pending.
* WFDOC: Wrapper ini mengestimasi satu metode produksi nilai tambah per pemanggilan pada panel perusahaan-tahun yang sudah dimuat.
* WFDOC: Kontrak mendefinisikan output sebagai log nilai tambah, labor sebagai log pekerja, capital sebagai log stok modal, dan proxy sebagai log investasi OP atau input antara metode lain; sintaks Stata hanya memastikan semuanya numerik.
* WFDOC: eligible() adalah domain sebelum lag. Wrapper membentuk domain dari flag itu dan kelengkapan output/labor/capital/proxy, lalu dynamic_t hanya bila domain_t dan domain pada tahun kalender t-1 sama-sama satu.
* WFDOC: measurementmode(real) adalah default. nominal_development hanya memberi label pada kandidat nominal untuk panel sintetik; kode tidak mengubah atau mendeflasi angka dan tidak menyatakan input itu riil.
* WFDOC: Keluaran utama ialah beta labor/capital dengan e(sample) pada transisi dinamis dan metadata mode. Point fit tidak menyediakan covariance; residual nilai tambah nominal pada mode pengembangan bukan TFP riil atau ukuran efisiensi teknis.
program define g1_fit, eclass sortpreserve
    version 17.0
    syntax, METHOD(string) ID(varname numeric) TIME(varname numeric) ///
        OUTPUT(varname numeric) LABOR(varname numeric) CAPITAL(varname numeric) ///
        PROXY(varname numeric) ELIGIBLE(varname numeric) ///
        PANELVERIFIED(integer) INPUTSVERIFIED(integer) ///
        [RISK(varname numeric) EXIT(varname numeric) SELECTIONVERIFIED(integer 0) ///
        POLY(integer 3) START(string) OPTIMIZER(string) ///
        MEASUREMENTMODE(string) SYNTHETICPANEL(integer 0) PANELSTATUS(varname string) ///
        SELECTIONMODE(string)]
    ereturn clear
    if !inlist("`method'","op","lp","acf","wrdg") exit 198
* WFDOC: selectionmode default authenticated; synthetic_disappearance hanya sah bersama nominal_development dan syntheticpanel(1), sehingga kehilangan assignment fiktif tidak disebut penutupan perusahaan aktual.
    if "`measurementmode'"=="" local measurementmode "real"
    if "`selectionmode'"=="" local selectionmode "authenticated"
    if !inlist("`measurementmode'","real","nominal_development") exit 198
    if !inlist("`selectionmode'","authenticated","synthetic_disappearance") exit 198
    if !inlist(`syntheticpanel',0,1) exit 198
    local input_label : data label
    local input_mode : char _dta[deasy_data_mode]
* WFDOC: syntheticpanel(1) mewajibkan panelstatus() bernilai synthetic_development pada setiap baris sumber dan risk; label DEASY G0 ACTUAL atau metadata data_mode actual menghentikan jalur fiktif.
    if `syntheticpanel'==1 {
        if "`panelstatus'"=="" {
            di as error "G1_BLOCKED_SYNTHETIC_PANEL: explicit source status variable required"
            exit 459
        }
        quietly count if `panelstatus'!="synthetic_development"
        if r(N)>0 {
            di as error "G1_BLOCKED_SYNTHETIC_PANEL: every source/risk row must have official synthetic_development status"
            exit 459
        }
        if "`input_label'"=="DEASY G0 ACTUAL" | "`input_mode'"=="actual" {
            di as error "G1_BLOCKED_ACTUAL_MODE: fictional-panel options cannot be used with actual input"
            exit 459
        }
    }
* WFDOC: Mode nominal hanya dapat dipakai di jalur panel sintetik yang dinyatakan eksplisit; ia tidak mengizinkan nominal aktual disamarkan sebagai nilai riil.
    if "`measurementmode'"=="nominal_development" & `syntheticpanel'!=1 {
        di as error "G1_BLOCKED_NOMINAL_MODE: explicit syntheticpanel(1) and source status required"
        exit 459
    }
* WFDOC: selectionmode(synthetic_disappearance) dibatasi ke kandidat nominal pada panel sintetik; indikator keluarnya assignment tetap bukan bukti penutupan perusahaan aktual.
    if "`selectionmode'"=="synthetic_disappearance" & ("`measurementmode'"!="nominal_development" | `syntheticpanel'!=1) {
        di as error "G1_BLOCKED_SELECTION_MODE: simulated disappearance is limited to authorized nominal development"
        exit 459
    }
* WFDOC: panelverified(1) harus didukung kontrak identitas perusahaan-kalender yang diterima; pada mode nominal inputsverified(1) berarti kontrak kandidat nominal, bukan sertifikasi input riil.
    if `panelverified'!=1 {
        di as error "G1_BLOCKED_PANEL: accepted mode-specific company/calendar identity contract required"
        exit 459
    }
    if `inputsverified'!=1 {
        if "`measurementmode'"=="nominal_development" di as error "G1_BLOCKED_INPUTS: accepted declared nominal-candidate input contract required; no real-input certification"
        else di as error "G1_BLOCKED_INPUTS: accepted real VA, labor, capital stock and proxy definitions required"
        exit 459
    }
* WFDOC: Daftar metode dibatasi ke OP, LP, ACF, dan Wooldridge; degree 2/3 serta start dan optimizer berikut mengikuti pilihan yang sudah dipatok.
    if !inlist(`poly',2,3) exit 198
    if "`start'"=="" local start "ols"
    if !inlist("`start'","ols","low_l","high_l") exit 198
    if "`optimizer'"=="" {
        if "`method'"=="wrdg" local optimizer "gn"
        else local optimizer "nm"
    }
    if "`method'"=="wrdg" & "`optimizer'"!="gn" exit 198
    if "`method'"!="wrdg" & !inlist("`optimizer'","nm","dfp") exit 198
    if "`method'"=="op" & (`selectionverified'!=1 | "`risk'"=="" | "`exit'"=="") {
        if "`selectionmode'"=="synthetic_disappearance" di as error "G1_BLOCKED_SELECTION: accepted generator-risk/disappearance universe required for nominal OP development"
        else di as error "G1_BLOCKED_SELECTION: authenticated full risk/exit universe required for OP"
        exit 459
    }
* WFDOC: Kunci harus berupa ID perusahaan dan tahun aktual yang terisi, tahun bulat, dan unik per perusahaan-tahun; xtset delta(1) membuat operator L. mengikuti kalender dengan gap yang dipertahankan.
    assert !missing(`id',`time')
    assert `time'==floor(`time')
    isid `id' `time'
    assert inlist(`eligible',0,1)
    xtset `id' `time', delta(1)
    tempvar domain dynamic
* WFDOC: domain adalah eligible pra-lag ditambah output/labor/capital/proxy yang lengkap; dynamic menambahkan syarat domain pada t-1 kalender. Tahun yang hilang seperti 2016 tidak boleh dijembatani.
    gen byte `domain'=`eligible'==1 & !missing(`output',`labor',`capital',`proxy')
    gen byte `dynamic'=`domain'==1 & L.`domain'==1
    local n_source=_N
    quietly count if `domain'
    local n_domain=r(N)
    quietly count if `dynamic'
* WFDOC: Jika tidak ada transisi satu tahun dengan medan lengkap, proses berhenti dengan kode kalender; N_source, N_domain, dan N_dynamic menjaga penyebut sampel tetap terpisah.
    if r(N)<1 {
        di as error "G1_BLOCKED_CALENDAR: no complete real-calendar transition"
        exit 2001
    }
    local n_dynamic=r(N)
* WFDOC: Salinan sementara memakai nama pendek agar cocok dengan batas nama variabel adapter, lalu restore memulihkan data pemanggil. Untuk OP, kolom risk dan exit ikut dipertahankan dari seluruh sumber.
    preserve
    * Canonical short names avoid the pinned package's generated-name limits.
    tempvar cy cl ck cp ci ct ce cd
    clonevar `cy'=`output'
    clonevar `cl'=`labor'
    clonevar `ck'=`capital'
    clonevar `cp'=`proxy'
    clonevar `ci'=`id'
    clonevar `ct'=`time'
    clonevar `ce'=`domain'
    clonevar `cd'=`dynamic'
    if "`method'"=="op" {
        tempvar cr cx
        clonevar `cr'=`risk'
        clonevar `cx'=`exit'
        keep `cy' `cl' `ck' `cp' `ci' `ct' `ce' `cd' `cr' `cx'
        rename (`cr' `cx') (g1risk g1exit)
    }
    else keep `cy' `cl' `ck' `cp' `ci' `ct' `ce' `cd'
    rename (`cy' `cl' `ck' `cp' `ci' `ct' `ce' `cd') (g1y g1l g1k g1p g1id g1t g1eligible g1dynamic)
    xtset g1id g1t, delta(1)
    gen double g1one=1
    gen double g1zero=0
    gen double g1lagl=L.g1l
    * Polynomial exponents uniquely enumerate total degrees 1..d.
    local basis ""
    local lagbasis ""
* WFDOC: Basis B_d(k,p) memuat semua k^a*p^b dengan 1<=a+b<=poly satu kali; lag setiap monomial memakai tahun kalender t-1.
    forvalues deg=1/`poly' {
        forvalues a=0/`deg' {
            local b=`deg'-`a'
            gen double g1b`a'`b'=g1k^`a'*g1p^`b'
            gen double g1q`a'`b'=L.g1b`a'`b'
            local basis `basis' g1b`a'`b'
            local lagbasis `lagbasis' g1q`a'`b'
        }
    }
    local n_selection=0
    local selection_exits=0
    local selection_rank=.
    local selection_ll=.
    local opprob ""
* WFDOC: Model selection OP dipasang pada risk universe, bukan hanya sampel produksi; baris eligible di sini dipakai setelah probabilitas selection tersedia.
    if "`method'"=="op" {
        assert inlist(g1risk,0,1) | missing(g1risk)
        assert inlist(g1exit,0,1) if g1risk==1
        egen int g1missingrisk=rowmiss(`lagbasis')
        quietly count if g1risk==1 & g1missingrisk==0
        local expected_selection=r(N)
        quietly summarize g1exit if g1risk==1 & g1missingrisk==0
        if r(min)!=0 | r(max)!=1 {
            di as error "G1_BLOCKED_SELECTION: accepted selection outcomes 0 and 1 both required; no uncorrected fallback"
            exit 459
        }
* WFDOC: exit_t berarti penutupan terautentikasi pada interval (t-1,t] atau disappearance generator pada jalur nominal sintetik; kode tidak menurunkan exit dari ketiadaan baris.
        capture noisily logit g1exit `lagbasis' if g1risk==1 & g1missingrisk==0, iterate(10000)
        if _rc exit 459
        local n_selection=e(N)
        local selection_rank=e(rank)
        local selection_ll=e(ll)
        local expected_rank: word count `lagbasis'
        local expected_rank=`expected_rank'+1
        if e(converged)!=1 | e(rank)!=`expected_rank' | e(N)!=`expected_selection' {
            di as error "G1_BLOCKED_SELECTION: failed, rank-deficient, or perfectly predicted selection fit"
            exit 459
        }
        quietly count if e(sample) & g1exit==1
        local selection_exits=r(N)
* WFDOC: Probabilitas logit dibuat untuk semua baris risk dengan basis lag lengkap; transisi produksi OP harus berupa continuer dengan probabilitas terisi.
        predict double g1pr if g1risk==1 & g1missingrisk==0, pr
        * Outcome 1 is authenticated closure or explicitly synthetic disappearance; current production requires outcome 0.
        assert g1risk==1 & g1exit==0 & !missing(g1pr) if g1dynamic
        local opprob "attrition opprob(g1pr)"
    }
    * Rank checks are computed from actual matrices on the declared sample.
* WFDOC: OP/LP memakai labor ditambah B_d(k,p) pada tahap pertama; ACF memakai semua monomial unik l,k,p. Rank diuji dari matriks pada domain yang dinyatakan.
    local firstbasis "g1l `basis'"
    if "`method'"=="acf" {
        local firstbasis ""
        forvalues deg=1/`poly' {
            forvalues a=0/`deg' {
                local rem=`deg'-`a'
                forvalues b=0/`rem' {
                    local c=`rem'-`b'
                    gen double g1a`a'`b'`c'=g1l^`a'*g1k^`b'*g1p^`c'
                    local firstbasis `firstbasis' g1a`a'`b'`c'
                }
            }
        }
    }
    mkmat `firstbasis' g1one if g1eligible, matrix(G1_FIRST_X)
    mata: st_numscalar("G1_FIRST_RANK",rank(st_matrix("G1_FIRST_X")))
    if scalar(G1_FIRST_RANK)!=colsof(G1_FIRST_X) {
        di as error "G1_BLOCKED_RANK: rank-deficient first-stage polynomial; no coefficient rescue"
        exit 459
    }
    local first_rank=scalar(G1_FIRST_RANK)
    local transition_rank=.
    local transition_columns=.
    local transition_condition=.
    local gmm_ptol=.
    local gmm_vtol=.
* WFDOC: Wooldridge memakai GN pada kompatibilitas Stata efektif yang dibatasi sumber prodest; nilai tolerance parser direkam, tetapi tolerance Newton tidak diklaim berlaku.
    if "`method'"=="wrdg" {
        version 14: _parse_gmm_optim_opts, technique(gn) conv_maxiter(10000)
        local gmm_ptol=`s(conv_ptol)'
        local gmm_vtol=`s(conv_vtol)'
    }
    local instrument_rank=.
    local instrument_columns=.
    local jacobian_rank=.
    local z_condition=.
* WFDOC: Instrumen ACF yang diperiksa adalah Z=[lag(l), k] pada transisi dinamis; rank dan kondisi matriks dilaporkan, tetapi tidak membuktikan asumsi timing.
    if "`method'"=="acf" {
        mkmat g1lagl g1k if g1dynamic, matrix(G1_Z)
        mata: st_numscalar("G1_Z_RANK",rank(st_matrix("G1_Z"))); st_numscalar("G1_Z_COND",cond(st_matrix("G1_Z")))
        local instrument_rank=scalar(G1_Z_RANK)
        local instrument_columns=colsof(G1_Z)
        local z_condition=scalar(G1_Z_COND)
        if `instrument_rank'!=`instrument_columns' exit 459
    }
* WFDOC: Sistem Wooldridge memakai theta polinomial yang sama di dua persamaan; instrumen primer Z1=[1,l_t,B_d(k_t,p_t)] dan Z2=[1,k_t,l_(t-1),B_d(k_(t-1),p_(t-1))].
* WFDOC: Rank kedua blok instrumen dan Jacobian momen gabungan harus penuh; defisiensi tidak diperbaiki dengan menghapus koefisien atau menambah instrumen.
    if "`method'"=="wrdg" {
        mkmat g1one g1l `basis' if g1dynamic, matrix(G1_Z1)
        mkmat g1one g1k g1lagl `lagbasis' if g1dynamic, matrix(G1_Z2)
        mkmat g1l g1k g1one g1zero `basis' if g1dynamic, matrix(G1_X1)
        mkmat g1l g1k g1one g1one `lagbasis' if g1dynamic, matrix(G1_X2)
        mata: st_numscalar("G1_Z1_RANK",rank(st_matrix("G1_Z1"))); st_numscalar("G1_Z2_RANK",rank(st_matrix("G1_Z2")))
        mata: st_matrix("G1_WRDG_D",(st_matrix("G1_Z1")'*st_matrix("G1_X1") \ st_matrix("G1_Z2")'*st_matrix("G1_X2"))/rows(st_matrix("G1_Z1")))
        mata: st_numscalar("G1_D_RANK",rank(st_matrix("G1_WRDG_D"))); st_numscalar("G1_Z_COND",max((cond(st_matrix("G1_Z1")),cond(st_matrix("G1_Z2")))))
        local instrument_rank=scalar(G1_Z1_RANK)+scalar(G1_Z2_RANK)
        local instrument_columns=colsof(G1_Z1)+colsof(G1_Z2)
        local jacobian_rank=scalar(G1_D_RANK)
        local z_condition=scalar(G1_Z_COND)
        if `instrument_rank'!=`instrument_columns' | `jacobian_rank'!=colsof(G1_X1) {
            di as error "G1_BLOCKED_RANK: deficient instruments or shared-theta moment Jacobian"
            exit 459
        }
    }
* WFDOC: Start OLS pada domain eligible menetapkan beta awal; low_l dan high_l memakai pasangan tetap (.3,.7) dan (.7,.3), bukan aturan memilih hasil yang disukai.
    quietly regress g1y g1l g1k if g1eligible
    local initial_l=_b[g1l]
    local initial_k=_b[g1k]
    if "`start'"=="low_l" {
        local initial_l=.3
        local initial_k=.7
    }
    if "`start'"=="high_l" {
        local initial_l=.7
        local initial_k=.3
    }
    local method_option "method(`method')"
    if "`method'"=="acf" local method_option "method(lp) acf"
    if "`method'"=="wrdg" local method_option "method(wrdg) gmm"
    local initial "(`initial_l',`initial_k')"
    if "`method'"=="wrdg" local initial "`initial_l',`initial_k'"
    matrix G1_POINT_DIAG=J(1,6,.)
    matrix G1_POINT_MOMENTS=J(1,1,.)
    matrix G1_POINT_JACOBIAN=J(1,1,.)
* WFDOC: Point adapter menerima domain produksi pra-lag; kelengkapan lag kalender membentuk sampel estimator. OP memakai probabilitas yang sudah dipasang di atas pada seluruh risk universe.
    capture noisily g1_prodest_point g1y if g1eligible, free(g1l) state(g1k) proxy(g1p) ///
        id(g1id) t(g1t) valueadded `method_option' `opprob' reps(1) poly(`poly') ///
        init(`initial') optimizer(`optimizer') maxiter(10000) tolerance(.00001) evaluator(d0)
* WFDOC: Kode gagal adapter diteruskan. N estimator harus cocok dengan jumlah transisi rencana; beta/objective hilang, nonkonvergensi, rank transisi, atau Jacobian ACF yang kurang membuat hasil ditolak.
    local rc=_rc
    if `rc' exit `rc'
    assert "`e(model)'"=="valueadded"
    local beta_l=_b[g1l]
    local beta_k=_b[g1k]
    local converged=G1_POINT_DIAG[1,1]
    local objective=G1_POINT_DIAG[1,2]
    local iterations=G1_POINT_DIAG[1,3]
    local actual_n=G1_POINT_DIAG[1,4]
    if `actual_n'!=`n_dynamic' {
        di as error "G1_SAMPLE_MISMATCH: predicted transition contract differs from actual estimator N"
        exit 459
    }
    if `converged'!=1 | missing(`beta_l',`beta_k',`objective') {
        di as error "G1_NUMERICAL_FAILURE: no publishable converged coefficient vector"
        exit 430
    }
    if "`method'"!="wrdg" {
        local transition_columns=G1_TRANSITION_DIAG[1,2]
        local transition_rank=G1_TRANSITION_DIAG[1,3]
        local transition_condition=G1_TRANSITION_DIAG[1,4]
        if `transition_rank'!=`transition_columns' {
            di as error "G1_BLOCKED_RANK: optimized transition/selection polynomial deficient"
            exit 459
        }
    }
    if "`method'"=="acf" {
        mata: st_numscalar("G1_D_RANK",rank(st_matrix("G1_POINT_JACOBIAN")))
        local jacobian_rank=scalar(G1_D_RANK)
        if `jacobian_rank'!=2 {
            di as error "G1_BLOCKED_IDENTIFICATION: ACF local moment Jacobian deficient"
            exit 459
        }
    }
    tempname b
    matrix `b'=(`beta_l',`beta_k')
    matrix colnames `b'=labor capital
    restore
* WFDOC: Hasil ditempelkan kembali ke data asli dengan e(sample)=dynamic; e() menyimpan N sumber/domain/selection dan diagnostik, tetapi covariance_available=0.
    ereturn post `b', esample(`dynamic') obs(`n_dynamic')
    ereturn local cmd "g1_fit"
    ereturn local method "`method'"
    ereturn local model "valueadded"
* WFDOC: Metadata membedakan mode riil dari nominal_development. Mode nominal mencatat input nominal kandidat, real_input_verified=0, development_only=1, dan measure_type structural_log_nominal_VA_residual.
    ereturn local measurement_mode "`measurementmode'"
    ereturn local selection_mode "`selectionmode'"
    ereturn scalar real_input_verified=("`measurementmode'"=="real")
    ereturn scalar development_only=("`measurementmode'"=="nominal_development" | `syntheticpanel'==1 | "`input_mode'"=="development" | "`input_label'"=="DEASY G0.5 DEVELOPMENT")
    ereturn scalar synthetic_panel_authorized=`syntheticpanel'
    ereturn scalar selection_mode_applied=("`method'"=="op")
    ereturn local panel_identity_contract "accepted_external_identity_contract"
    if `syntheticpanel'==1 ereturn local panel_identity_contract "official_synthetic_development"
    ereturn local input_acceptance_scope "accepted_real_input_contract"
    ereturn local measure_type "structural_log_VA_residual"
    if "`measurementmode'"=="nominal_development" {
        ereturn local input_acceptance_scope "accepted_declared_nominal_candidate_contract"
        ereturn local measure_type "structural_log_nominal_VA_residual"
    }
    ereturn local optimizer "`optimizer'"
    ereturn local start "`start'"
    ereturn local selection_timing "authenticated closure between t-1 and t; full risk universe fitted before production filter"
    if "`selectionmode'"=="synthetic_disappearance" ereturn local selection_timing "synthetic assignment disappearance between consecutive calendar waves t-1 and t; not observed company closure"
    ereturn scalar N_source=`n_source'
    ereturn scalar N_domain=`n_domain'
    ereturn scalar N_selection=`n_selection'
    ereturn scalar selection_exits=`selection_exits'
    ereturn scalar selection_rank=`selection_rank'
    ereturn scalar selection_ll=`selection_ll'
    ereturn scalar converged=`converged'
    ereturn scalar objective=`objective'
    ereturn scalar iterations=`iterations'
    ereturn scalar first_stage_rank=`first_rank'
    ereturn scalar transition_rank=`transition_rank'
    ereturn scalar transition_columns=`transition_columns'
    ereturn scalar transition_condition=`transition_condition'
    ereturn scalar gmm_parameter_tolerance=`gmm_ptol'
    ereturn scalar gmm_value_tolerance=`gmm_vtol'
    ereturn scalar gmm_nr_tolerance_applied=0
    ereturn scalar instrument_rank=`instrument_rank'
    ereturn scalar instrument_columns=`instrument_columns'
    ereturn scalar instrument_condition=`z_condition'
    ereturn scalar moment_jacobian_rank=`jacobian_rank'
    ereturn scalar initial_l=`initial_l'
    ereturn scalar initial_k=`initial_k'
    ereturn scalar poly=`poly'
    ereturn scalar markov_poly=3
    ereturn scalar stata_version=c(stata_version)
    ereturn scalar gmm_compatibility=min(max(10,c(stata_version)),14)
    ereturn scalar covariance_available=0
    if "`method'"=="acf" ereturn matrix moments=G1_POINT_MOMENTS
end
