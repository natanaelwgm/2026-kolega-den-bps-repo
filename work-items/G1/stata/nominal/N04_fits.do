version 17.0
* WFDOC: Fit nominal-development memakai N03_frozen, psid fiktif, dan nilai tanpa deflasi; tidak mengklaim input real atau TFP empiris.
* WFDOC: Unit cell ialah sektor×metode×own/common; fit produksi mencakup seluruh transisi kalender yang lengkap, dan keluaran residu bukan TFP riil.
* WFDOC: CSV menyimpan primary, sensitivitas, skip, kegagalan, dan return code per cell/variant; microdata tetap di folder run.
* WFDOC: Runner nominal DEVELOPMENT ini memakai N03_frozen dan kontrak nominal-specification.json; tidak menghasilkan klaim TFP riil.
* WFDOC: Satu cell adalah sektor dua digit x metode x domain own/common; empat spesifikasi tetap dicatat tanpa memilih hasil terbaik.
* WFDOC: Seluruh file mikro dan DTA hanya disimpan di direktori run eksternal. CSV keluaran berisi diagnostik agregat per cell.
if "$G1_RUN"=="" exit 198
run "work-items/G1/stata/methods/load.do"
use "$G1_RUN/nominal/N03_frozen.dta", clear
assert psid_status=="synthetic_development"
assert inrange(source_year,2010,2022) & source_year!=2016
isid psid source_year
levelsof nom_sector if !nom_interval_only, local(sectors)

* Frozen G05v3_nominal_assumedK_2010_2022 thresholds; do not adapt to fit outcomes.
* WFDOC: Cutoff beku: domain≥100, transisi≥50, firma≥50; OP juga risk≥100, disappearance≥10, continuer≥10.
local min_domain=100
local min_dynamic=50
local min_firms=50
local min_selection=100
local min_disappearance=10
local min_continuer=10
local spec_id "G05v3_nominal_assumedK_2010_2022"

* Preserve the source obs_id storage type when creating the empty prediction sidecar.
preserve
keep obs_id psid source_year nom_sector
keep if 0
rename nom_sector sector
gen str8 method=""
gen str8 sample_id=""
gen str12 variant=""
gen byte poly=.
gen str8 start=""
gen byte in_fit=.
* WFDOC: Raw residual=ln(VA_nom)−βL ln(L)−βK ln(K awal); centered mengurangi mean seluruh observasi dynamic pada cell dan indeks=exp(residual centered).
gen double raw_log_residual=.
gen double residual_reference_mean=.
gen str24 reference_scope="pooled_dynamic"
gen double reference_year=.
gen double fit_year_min=.
gen double fit_year_max=.
gen double N_fit_years=.
gen double normalized_log_residual=.
gen double normalized_residual_index=.
gen double labor=.
gen double capital=.
gen str40 specification_id="`spec_id'"
gen str24 measurement_mode="nominal_development"
gen str100 data_label="G0.5 DEVELOPMENT - nominal VA compatibility; not real TFP"
label data "G0.5 DEVELOPMENT nominal residual sidecar; original obs_id only"
save "$G1_RUN/nominal/N04_predictions.dta", replace
restore

tempname results
* WFDOC: Result row mencatat tiap cell/variant beserta status, rc, N, beta, rank, objective, dan diagnostics.
postfile `results' str2 sector str8 method str8 sample_id str12 variant str8 start byte poly ///
    str20 status str64 reason int rc ///
    double N_source double N_full_source double N_domain double N_dynamic double N_firms double N_selection double N_disappearance double N_continuer double fit_year_min double fit_year_max double N_fit_years double center_y double center_l double center_k double center_p double labor double capital double returns_to_scale double residual_reference_mean double converged double objective double iterations double first_stage_rank double selection_rank double selection_ll double selection_exits double transition_rank double transition_columns double transition_condition double instrument_rank double instrument_columns double instrument_condition double moment_jacobian_rank double initial_l double initial_k double gmm_parameter_tolerance double gmm_value_tolerance double gmm_nr_tolerance_applied double stata_version double gmm_compatibility ///
    using "$G1_RUN/nominal/fit_results.dta", replace

* WFDOC: Grid empat metode pada own dan irisan OP∩LP; OP memakai nom_i, metode lain nom_m, N domain/dynamic dipisah.
foreach sector of local sectors {
    foreach method in op lp acf wrdg {
        foreach sample in own common {
            use "$G1_RUN/nominal/N03_frozen.dta", clear
            keep if nom_sector=="`sector'"
            xtset psid source_year, delta(1)
            local domain "nom_domain_`method'"
            if "`sample'"=="common" local domain "nom_domain_common"
            local proxy "nom_m"
            if "`method'"=="op" local proxy "nom_i"
            * WFDOC: Setelah dibatasi ke sektor dan cell sample, n04_dynamic hanya mengakui domain lengkap pada t dan t−1 kalender; n04_firm kemudian menghitung firm sintetis unik untuk cutoff dukungan.
            gen byte n04_dynamic=(`domain'==1 & L.`domain'==1)
            assert !inlist(source_year,2010,2011,2016,2017,2018) if n04_dynamic
            egen byte n04_firm=tag(psid) if n04_dynamic
            gen byte n04_selection=nom_risk==1 & !missing(L.nom_k,L.nom_i)
            quietly count if !nom_interval_only
            local N_source=r(N)
            local N_full_source=_N
            quietly count if `domain'==1
            local N_domain=r(N)
            quietly count if n04_dynamic
            local N_dynamic=r(N)
            local fit_year_min=.
            local fit_year_max=.
            local N_fit_years=0
            if `N_dynamic'>0 {
                quietly summarize source_year if n04_dynamic, meanonly
                local fit_year_min=r(min)
                local fit_year_max=r(max)
                quietly levelsof source_year if n04_dynamic, local(fit_years)
                local N_fit_years: word count `fit_years'
            }
            quietly count if n04_firm==1
            local N_firms=r(N)
            quietly count if n04_selection
            local N_selection=r(N)
            quietly count if n04_selection & nom_disappearance==1
            local N_disappearance=r(N)
            quietly count if n04_selection & nom_disappearance==0
            local N_continuer=r(N)
            * WFDOC: support_reason mencatat gate pertama yang gagal dalam urutan tetap; semua variant tetap dicatat sehingga skip karena dukungan tidak tertukar dengan fit failure.
            local support_reason ""
            if `N_domain'<`min_domain' local support_reason "first_stage_N_below_100"
            else if `N_dynamic'<`min_dynamic' local support_reason "dynamic_N_below_50"
            else if `N_firms'<`min_firms' local support_reason "dynamic_firms_below_50"
            else if "`method'"=="op" & `N_selection'<`min_selection' local support_reason "OP_selection_N_below_100"
            else if "`method'"=="op" & `N_disappearance'<`min_disappearance' local support_reason "OP_disappearances_below_10"
            else if "`method'"=="op" & `N_continuer'<`min_continuer' local support_reason "OP_continuers_below_10"

            * WFDOC: Median dibekukan pada domain positif cell ini, kemudian diterapkan juga pada koordinat baris risk di luar domain produksi.
            local raw_y nom_y
            local raw_l nom_l
            local raw_k nom_k
            local raw_p `proxy'
            * WFDOC: Median domain positif hanya dipakai untuk menstabilkan koordinat numerik estimator; residu dan normalizer sesudah fit dihitung kembali dari log nominal asli.
            foreach coordinate in y l k p {
                quietly summarize `raw_`coordinate'' if `domain'==1, detail
                local center_`coordinate'=r(p50)
                gen double n04_`coordinate'=`raw_`coordinate''-`center_`coordinate''
            }
            tempfile cell_source
            quietly save `cell_source'
* WFDOC: Primary degree3/start OLS; low_l/high_l start tetap (.3,.7)/(.7,.3); poly2 degree2, tanpa memilih hasil terbaik.
            foreach variant in primary low_l high_l poly2 {
                quietly use `cell_source', clear
                local poly=3
                local start "ols"
                if inlist("`variant'","low_l","high_l") local start "`variant'"
                if "`variant'"=="poly2" local poly=2
                local status "skipped_support"
                local reason "`support_reason'"
                local rc=459
                local labor=.
                local capital=.
                local returns_to_scale=.
                local residual_reference_mean=.
                foreach diagnostic in converged objective iterations first_stage_rank selection_rank selection_ll selection_exits transition_rank transition_columns transition_condition instrument_rank instrument_columns instrument_condition moment_jacobian_rank initial_l initial_k gmm_parameter_tolerance gmm_value_tolerance gmm_nr_tolerance_applied stata_version gmm_compatibility {
                    local `diagnostic'=.
                }
* WFDOC: Progress CELL mengikat sector/method/sample/variant dan N transisi; support skip dibedakan dari fit failure.
                display "G1_N04 CELL | sector=`sector' method=`method' sample=`sample' variant=`variant' N_dynamic=`N_dynamic'"
                if "`support_reason'"=="" {
                    local selection_options ""
                    if "`method'"=="op" local selection_options "risk(nom_risk) exit(nom_disappearance) selectionverified(1) selectionmode(synthetic_disappearance)"
                    * WFDOC: Risk/exit hanya diteruskan pada OP; selectionmode synthetic_disappearance menandai event panel fiktif development dan tidak menyebut penutupan perusahaan aktual.
                    * WFDOC: Wrapper membentuk lag kalender sekali. Flag input menerima kontrak kandidat nominal; tidak menyatakan input riil terverifikasi.
* WFDOC: Wrapper memakai log nominal yang dikurangi median domain; mode synthetic eksplisit dan e(sample) harus cocok dengan lag kalender.
                    * WFDOC: g1_fit menetapkan momen dan instrumen sesuai metode; WRDG mengikat theta yang sama pada dua persamaan. Runner meneruskan opsi dan mencatat rank/Jacobian.
                    capture noisily g1_fit, method(`method') id(psid) time(source_year) ///
                        output(n04_y) labor(n04_l) capital(n04_k) proxy(n04_p) ///
                        eligible(`domain') panelverified(1) inputsverified(1) ///
                        measurementmode(nominal_development) syntheticpanel(1) panelstatus(psid_status) ///
                        poly(`poly') start(`start') `selection_options'
                    local rc=_rc
                    local status "fit_failed"
                    local reason "estimator_rc_`rc'"
                    if `rc'==0 {
                        capture noisily assert e(N)==`N_dynamic' & e(real_input_verified)==0 & e(development_only)==1 & "`e(measurement_mode)'"=="nominal_development"
                        local rc=_rc
                        if `rc'==0 {
                            capture noisily assert e(sample)==n04_dynamic
                            local rc=_rc
                        }
                        if `rc'!=0 local reason "postfit_contract_rc_`rc'"
                    }
                    if `rc'==0 {
                        local status "fit_success"
                        local reason "converged_fixed_specification"
                        local labor=_b[labor]
                        local capital=_b[capital]
                        local returns_to_scale=`labor'+`capital'
                        foreach diagnostic in converged objective iterations first_stage_rank selection_rank selection_ll selection_exits transition_rank transition_columns transition_condition instrument_rank instrument_columns instrument_condition moment_jacobian_rank initial_l initial_k gmm_parameter_tolerance gmm_value_tolerance gmm_nr_tolerance_applied stata_version gmm_compatibility {
                            local `diagnostic'=e(`diagnostic')
                        }
                        * WFDOC: Residu dihitung dari log nominal asli, bukan log yang dipusatkan; tidak memakai predict omega atau menganggap intercept teridentifikasi.
                        * WFDOC: e(sample) menandai baris yang benar-benar masuk dynamic fit; sidecar tetap dibuat untuk seluruh baris domain current-year sehingga prediction di luar fit tidak hilang.
                        gen byte in_fit=e(sample)
                        gen double raw_log_residual=nom_y-`labor'*nom_l-`capital'*nom_k if `domain'==1
                        quietly summarize raw_log_residual if in_fit, meanonly
                        local residual_reference_mean=r(mean)
                        gen double residual_reference_mean=`residual_reference_mean'
                        gen double normalized_log_residual=raw_log_residual-residual_reference_mean
                        gen double normalized_residual_index=exp(normalized_log_residual)
                        preserve
                        keep if `domain'==1 & !nom_interval_only
                        assert !missing(obs_id)
                        keep obs_id psid source_year nom_sector in_fit raw_log_residual residual_reference_mean normalized_log_residual normalized_residual_index
                        rename nom_sector sector
                        gen str8 method="`method'"
                        gen str8 sample_id="`sample'"
                        gen str12 variant="`variant'"
                        gen byte poly=`poly'
                        gen str8 start="`start'"
                        gen double labor=`labor'
                        gen double capital=`capital'
                        gen str40 specification_id="`spec_id'"
                        gen str24 measurement_mode="nominal_development"
                        gen str24 reference_scope="pooled_dynamic"
                        gen double reference_year=.
                        gen double fit_year_min=`fit_year_min'
                        gen double fit_year_max=`fit_year_max'
                        gen double N_fit_years=`N_fit_years'
                        gen str100 data_label="G0.5 DEVELOPMENT - nominal VA compatibility; not real TFP"
                        append using "$G1_RUN/nominal/N04_predictions.dta"
                        isid sector method sample_id variant obs_id
                        save "$G1_RUN/nominal/N04_predictions.dta", replace
                        restore
                    }
                }
                * WFDOC: Satu baris untuk setiap percobaan atau skip, termasuk sensitivitas; keberhasilan sensitivitas tidak menggantikan primary gagal.
                post `results' ("`sector'") ("`method'") ("`sample'") ("`variant'") ("`start'") (`poly') ///
                    ("`status'") ("`reason'") (`rc') ///
                    (`N_source') (`N_full_source') (`N_domain') (`N_dynamic') (`N_firms') (`N_selection') (`N_disappearance') (`N_continuer') (`fit_year_min') (`fit_year_max') (`N_fit_years') (`center_y') (`center_l') (`center_k') (`center_p') (`labor') (`capital') (`returns_to_scale') (`residual_reference_mean') (`converged') (`objective') (`iterations') (`first_stage_rank') (`selection_rank') (`selection_ll') (`selection_exits') (`transition_rank') (`transition_columns') (`transition_condition') (`instrument_rank') (`instrument_columns') (`instrument_condition') (`moment_jacobian_rank') (`initial_l') (`initial_k') (`gmm_parameter_tolerance') (`gmm_value_tolerance') (`gmm_nr_tolerance_applied') (`stata_version') (`gmm_compatibility')
            }
        }
    }
}
postclose `results'
* WFDOC: Ringkasan fit_results mempertahankan sel success, failure dan support skip beserta tahun fit, rank serta normalizer pooled; tidak ada variant yang dipilih berdasarkan hasil.
use "$G1_RUN/nominal/fit_results.dta", clear
isid sector method sample_id variant
gen byte attempted=status!="skipped_support"
gen double beta_L=labor
gen double beta_K=capital
gen double N=N_dynamic if status=="fit_success"
gen double center_proxy=center_p
gen str40 specification_id="`spec_id'"
gen str64 input_manifest_sha256="060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260"
gen str24 measurement_mode="nominal_development"
gen byte real_input_verified=0
gen byte development_only=1
gen byte point_covariance_available=0
gen str28 selection_mode="not_applied"
replace selection_mode="synthetic_disappearance" if method=="op"
gen str100 data_label="G0.5 DEVELOPMENT - nominal VA compatibility; not real TFP"
gen str100 normalization="Uncentered residual minus mean over all fitted dynamic observations in this cell"
gen str24 reference_scope="pooled_dynamic"
gen double reference_year=.
gen str100 time_structure="Sector-pooled constant slopes and proxy/control law; no additional year fixed effects"
label data "G0.5 DEVELOPMENT nominal fit diagnostics; all fixed attempts and skips"
save "$G1_RUN/nominal/fit_results.dta", replace
* WFDOC: CSV membawa spec/hash, mode, N, beta, convergence, rank, rc, skip, dan sensitivitas; covariance point fit tidak tersedia.
export delimited using "$G1_RUN/outputs/nominal_optimizer_diagnostics.csv", replace
export delimited using "$G1_RUN/outputs/nominal_coefficients.csv", replace
count if status=="fit_success"
di "G1_N04_FINISHED: fixed-specification success rows=" r(N) "; failures/skips retained; nominal development only"
