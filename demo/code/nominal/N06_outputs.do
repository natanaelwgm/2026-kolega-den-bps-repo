version 17.0
* WFDOC: Merangkum residual nominal-development primary seluruh observasi dynamic, distribusi, histogram, korelasi, dan rank bins dari N04; bukan TFP real/final.
* WFDOC: Input N04_predictions, N03_frozen, S01_input; join obs_id-tahun. CSV agregat dan DTA attachment mempertahankan baris sumber.
* WFDOC: Own/common dan pairwise/four_method tetap terpisah; histogram mempertahankan tail, rank bins kecil disuppress.
* WFDOC: Keluaran ini mendeskripsikan residual nominal DEVELOPMENT dari primary fit pooled sepanjang tahun tersedia; bukan TFP riil atau hasil final.
* WFDOC: Distribusi memuat semua ekor; korelasi pairwise memakai irisan dua metode, sedangkan four_method memakai irisan keempat metode.
if "$G1_RUN"=="" exit 198
use "$G1_RUN/nominal/fit_results.dta", clear
levelsof sector, local(sectors)
local sectors ALL `sectors'
tempfile primary pairwide
* WFDOC: Dataset primary untuk distribusi hanya mengambil in_fit; attachment di bagian akhir sengaja membaca seluruh primary prediction agar baris domain di luar fit tetap dapat diaudit.
use "$G1_RUN/nominal/N04_predictions.dta", clear
keep if variant=="primary" & in_fit==1
assert !missing(obs_id)
isid obs_id source_year method sample_id
save `primary'

tempname distribution histogram pairs scatter
* WFDOC: Raw/centered statistics menyimpan N, mean, SD, min, p1/p5/p25/p50/p75/p95/p99, max per grup/sektor/metode.
postfile `distribution' str3 sector str8 method str8 sample_id str8 measure double N double mean double sd double min double p1 double p5 double p25 double p50 double p75 double p95 double p99 double max using "$G1_RUN/nominal/distribution_quantiles.dta", replace
postfile `histogram' str3 sector str8 method str8 sample_id str8 measure double bin_lower double bin_upper double N_bin double N_total double share using "$G1_RUN/nominal/histogram_bins.dta", replace
foreach sector of local sectors {
    foreach method in op lp acf wrdg {
        foreach sample in own common {
* WFDOC: Pivot memasangkan record obs_id-tahun-sector-sample yang sama; korelasi missing jika dukungan/variasi kurang.
            use `primary', clear
            keep if method=="`method'" & sample_id=="`sample'"
            if "`sector'"!="ALL" keep if sector=="`sector'"
            foreach measure in raw centered {
                local value raw_log_residual
                if "`measure'"=="centered" local value normalized_log_residual
                * WFDOC: summarize, detail dan histogram memakai seluruh nilai finite dalam group yang sama; tidak ada trimming, dan n menjadi penyebut statistik maupun share bin.
                quietly summarize `value', detail
                local n=r(N)
                post `distribution' ("`sector'") ("`method'") ("`sample'") ("`measure'") (`n') (r(mean)) (r(sd)) (r(min)) (r(p1)) (r(p5)) (r(p25)) (r(p50)) (r(p75)) (r(p95)) (r(p99)) (r(max))
                if `n'>0 {
                    preserve
* WFDOC: Bin histogram lebar 0,5; share=N_bin/N_total dan tails_trimmed=0 mempertahankan ekor.
                    gen double bin_lower=floor(`value'/.5)*.5
                    quietly collapse (count) N_bin=`value', by(bin_lower)
                    forvalues row=1/`=_N' {
                        post `histogram' ("`sector'") ("`method'") ("`sample'") ("`measure'") (bin_lower[`row']) (bin_lower[`row']+.5) (N_bin[`row']) (`n') (N_bin[`row']/`n')
                    }
                    restore
                }
            }
        }
    }
}
postclose `distribution'
postclose `histogram'
use "$G1_RUN/nominal/distribution_quantiles.dta", clear
gen str100 data_label="G0.5 DEVELOPMENT - nominal VA residuals; all pooled dynamic observations"
export delimited using "$G1_RUN/outputs/nominal_distribution_quantiles.csv", replace
use "$G1_RUN/nominal/histogram_bins.dta", clear
gen double bin_width=.5
gen byte tails_trimmed=0
gen str100 data_label="G0.5 DEVELOPMENT - nominal residual histogram; all finite tails retained"
export delimited using "$G1_RUN/outputs/nominal_histogram_bins.csv", replace

* WFDOC: Perbandingan memakai primary in_fit=1 sepanjang kalender; common residual tetap terpisah dari own-domain.
* WFDOC: Reshape memakai obs_id×source_year×sector×sample_id sehingga metode dibandingkan pada baris sumber yang sama; mask pairwise dan four_method tetap dua cakupan berbeda.
use `primary', clear
keep obs_id source_year sector sample_id method raw_log_residual normalized_log_residual
rename (raw_log_residual normalized_log_residual) (r c)
if _N>0 reshape wide r c, i(obs_id source_year sector sample_id) j(method) string
else drop method r c
foreach method in op lp acf wrdg {
    foreach prefix in r c {
        capture confirm variable `prefix'`method'
        if _rc gen double `prefix'`method'=.
    }
}
gen byte four_method=!missing(cop,clp,cacf,cwrdg)
save `pairwide'
postfile `pairs' str3 sector str8 sample_id str8 method_a str8 method_b str12 comparison_scope double N_pairwise double N_four_method double N_compared double pearson_raw double pearson_centered double rho_spearman double scatter_N_released str48 status using "$G1_RUN/nominal/pairwise_comparisons.dta", replace
postfile `scatter' str3 sector str8 sample_id str8 method_a str8 method_b str12 comparison_scope byte rank_bin double N_bin double mean_x double mean_y double mean_rank_x double mean_rank_y using "$G1_RUN/nominal/rank_scatter_bins.dta", replace
* WFDOC: Pairwise dan four_method berbeda; Pearson raw/centered serta Spearman centered dihitung terpisah.
local methods "op lp acf wrdg"
foreach sector of local sectors {
    foreach sample in own common {
        forvalues a=1/3 {
            local first : word `a' of `methods'
            local next=`a'+1
            forvalues b=`next'/4 {
                local second : word `b' of `methods'
                foreach scope in pairwise four_method {
                    use `pairwide', clear
                    keep if sample_id=="`sample'"
                    if "`sector'"!="ALL" keep if sector=="`sector'"
                    quietly count if !missing(c`first',c`second')
                    local npair=r(N)
                    quietly count if four_method
                    local nfour=r(N)
                    keep if !missing(c`first',c`second')
                    if "`scope'"=="four_method" keep if four_method
                    local n=_N
                    local pearson_raw=.
                    local pearson_centered=.
                    local rho_spearman=.
                    local released=0
                    local status "unavailable_no_shared_predictions"
                    if `n'>0 local status "insufficient_N_or_variation"
                    if `n'>1 {
                        tempname C
                        capture quietly correlate r`first' r`second'
                        if _rc==0 {
                            matrix `C'=r(C)
                            local pearson_raw=`C'[1,2]
                        }
                        capture quietly correlate c`first' c`second'
                        if _rc==0 {
                            matrix `C'=r(C)
                            local pearson_centered=`C'[1,2]
                        }
                        egen double rx=rank(c`first')
                        egen double ry=rank(c`second')
                        capture quietly correlate rx ry
                        if _rc==0 {
                            matrix `C'=r(C)
                            local rho_spearman=`C'[1,2]
                        }
                        if !missing(`rho_spearman') local status "compared_shared_original_records"
                        * WFDOC: Scatter hanya rata-rata bin peringkat, minimum lima catatan per bin; singleton tidak diterbitkan sebagai titik.
                        gen byte rank_bin=ceil(20*rx/(`n'+1))
                        replace rx=rx/(`n'+1)
                        replace ry=ry/(`n'+1)
                        quietly collapse (count) N_bin=c`first' (mean) mean_x=c`first' mean_y=c`second' mean_rank_x=rx mean_rank_y=ry, by(rank_bin)
                        keep if N_bin>=5
                        quietly summarize N_bin, meanonly
                        local released=cond(r(N)>0,r(sum),0)
                        if _N>0 {
                            forvalues row=1/`=_N' {
                                post `scatter' ("`sector'") ("`sample'") ("`first'") ("`second'") ("`scope'") (rank_bin[`row']) (N_bin[`row']) (mean_x[`row']) (mean_y[`row']) (mean_rank_x[`row']) (mean_rank_y[`row'])
                            }
                        }
                    }
                    post `pairs' ("`sector'") ("`sample'") ("`first'") ("`second'") ("`scope'") (`npair') (`nfour') (`n') (`pearson_raw') (`pearson_centered') (`rho_spearman') (`released') ("`status'")
                }
            }
        }
    }
}
postclose `pairs'
postclose `scatter'
use "$G1_RUN/nominal/pairwise_comparisons.dta", clear
gen str100 data_label="G0.5 DEVELOPMENT - shared original records; pairwise and four-method scopes kept distinct"
export delimited using "$G1_RUN/outputs/nominal_pairwise_comparisons.csv", replace
use "$G1_RUN/nominal/rank_scatter_bins.dta", clear
gen byte minimum_bin_N=5
gen byte declared_rank_bins=20
gen str100 data_label="G0.5 DEVELOPMENT - aggregate rank bins; bins with fewer than five records suppressed"
export delimited using "$G1_RUN/outputs/nominal_rank_scatter_bins.csv", replace

* WFDOC: Attach every primary prediction with eligible current inputs, including observations outside dynamic estimation.
* WFDOC: Sidecar attachment mempertahankan semua primary prediction yang tersedia, bukan hanya in_fit; flag pred dan in_fit memisahkan ketersediaan residual dari keikutsertaan estimasi.
use "$G1_RUN/nominal/N04_predictions.dta", clear
keep if variant=="primary"
keep obs_id source_year method sample_id raw_log_residual normalized_log_residual in_fit
rename (raw_log_residual normalized_log_residual in_fit) (r c f)
gen str16 model=method+"_"+sample_id
drop method sample_id
if _N>0 reshape wide r c f, i(obs_id source_year) j(model) string
else drop model r c f
foreach method in op lp acf wrdg {
    foreach sample in own common {
        foreach prefix in r c f {
            capture confirm variable `prefix'`method'_`sample'
            if _rc gen double `prefix'`method'_`sample'=.
        }
        if "`sample'"=="own" {
            rename r`method'_`sample' dev_nominal_tfp_`method'
            rename c`method'_`sample' dev_nominal_c_`method'
            rename f`method'_`sample' dev_nominal_in_fit_`method'
        }
        else {
            rename r`method'_`sample' dev_nominal_common_tfp_`method'
            rename c`method'_`sample' dev_nominal_common_c_`method'
            rename f`method'_`sample' dev_nominal_common_in_fit_`method'
        }
    }
}
tempfile attachment eligibility
save `attachment'
use "$G1_RUN/nominal/N03_frozen.dta", clear
keep if !nom_interval_only
keep obs_id source_year nom_dynamic_op nom_dynamic_lp nom_dynamic_acf nom_dynamic_wrdg nom_dynamic_common nom_domain_op nom_domain_lp nom_domain_acf nom_domain_wrdg nom_domain_common nom_k_assumed nom_k_documented nom_i_assumed nom_i_documented
foreach method in op lp acf wrdg common {
    rename nom_dynamic_`method' dev_nominal_eligible_`method'
    rename nom_domain_`method' dev_nominal_domain_`method'
}
foreach field in k_assumed k_documented i_assumed i_documented {
    rename nom_`field' dev_nominal_`field'
}
save `eligibility'
use "$G1_RUN/S01_input.dta", clear
* WFDOC: Audit attachment memakai semua source rows sebagai denominator dan menghitung residual primary nonmissing per metode.
local source_N=_N
isid obs_id source_year
gen long n06_source_order=_n
* WFDOC: Eligibility/prediction di-merge satu-ke-satu; using-only ditolak dan coverage/row count diperiksa.
* WFDOC: Eligibility, pre-lag domain dan flag asumsi digabung satu-ke-satu ke seluruh master; missing hanya diubah menjadi nol pada indikator keluaran, bukan pada nilai sumber.
merge 1:1 obs_id source_year using `eligibility', assert(master match) nogen
merge 1:1 obs_id source_year using `attachment', assert(master match) nogen
foreach method in op lp acf wrdg {
    replace dev_nominal_eligible_`method'=0 if missing(dev_nominal_eligible_`method')
    replace dev_nominal_domain_`method'=0 if missing(dev_nominal_domain_`method')
    replace dev_nominal_in_fit_`method'=0 if missing(dev_nominal_in_fit_`method')
    replace dev_nominal_common_in_fit_`method'=0 if missing(dev_nominal_common_in_fit_`method')
    gen byte dev_nominal_pred_`method'=!missing(dev_nominal_tfp_`method')
    gen byte dev_nominal_common_pred_`method'=!missing(dev_nominal_common_tfp_`method')
    assert dev_nominal_domain_`method'==1 if dev_nominal_pred_`method'
    assert dev_nominal_eligible_`method'==1 & dev_nominal_pred_`method'==1 if dev_nominal_in_fit_`method'
    assert dev_nominal_eligible_common==1 & dev_nominal_common_pred_`method'==1 if dev_nominal_common_in_fit_`method'
    assert dev_nominal_pred_`method'==0 if inlist(source_year,2010,2017)
    label variable dev_nominal_in_fit_`method' "Membership in the accepted pooled dynamic estimation sample"
    label variable dev_nominal_common_in_fit_`method' "Membership in accepted common-sample pooled dynamic estimation"
    label variable dev_nominal_tfp_`method' "DEVELOPMENT own primary uncentered nominal log residual; not real TFP"
    label variable dev_nominal_c_`method' "DEVELOPMENT own residual minus sector-method pooled dynamic mean"
    label variable dev_nominal_eligible_`method' "Declared exact-calendar dynamic domain; before cell-support/fit gates"
}
replace dev_nominal_eligible_common=0 if missing(dev_nominal_eligible_common)
replace dev_nominal_domain_common=0 if missing(dev_nominal_domain_common)
gen str40 dev_nominal_spec="G05v3_nominal_assumedK_2010_2022"
gen str160 dev_nominal_normalization="Uncentered nominal residual using pooled sector slopes; centered by sector-method pooled dynamic mean"
gen str24 dev_nominal_reference_scope="pooled_dynamic"
gen double dev_nominal_reference_year=.
gen str120 dev_nominal_assumption="Reported stocks assumed year-end; reported additions separate investment candidate; documentary flags retained"
gen str24 dev_nominal_measurement_mode="nominal_development"
gen byte dev_nominal_real_verified=0
gen byte dev_nominal_development_only=1
assert _N==`source_N'
assert _N==$G1_EXPECTED_ROWS
sort n06_source_order
drop n06_source_order
label data "G0.5 DEVELOPMENT selected source plus nominal primary residuals; not real TFP"
save "$G1_RUN/nominal/N06_selected_attached.dta", replace
di "G1_N06_FINISHED: all source rows retained; aggregate comparisons include empty obligations"
