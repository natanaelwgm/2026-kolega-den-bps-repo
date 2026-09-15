* WFDOC: N11 compares primary predictions on the exact same fictional psid, sector, method and sample in adjacent calendar years.
* WFDOC: Keys include year_from/year_to. The pooled0/0 row pools record-pair intervals, not unique companies; missing2016 is never bridged.
* WFDOC: N_from/N_to describe endpoint prediction sets, while N_pairs requires both endpoints in the same sector. N_to_in_fit counts matched destination rows.
* WFDOC: Coefficients and pooled dynamic centering remain fixed across years. Suppress exact summaries at N_pairs<5; keep direction counts and fixed-bin aggregates.
tempname p h
postfile `p' str4 sector str8 method str8 sample_id str20 measure double N_from double N_to double N_pairs double N_to_in_fit double N_to_outside_fit double mean_from double mean_to double mean_change double sd_change double p1_change double p5_change double p25_change double p50_change double p75_change double p95_change double p99_change double N_negative double N_zero double N_positive double pearson_levels double spearman_levels double mean_index_ratio double numeric_released double year_from double year_to using "$G1_DEEP/intermediate/deep_paired_changes.dta", replace
postfile `h' str4 sector str8 method str8 sample_id str20 measure double bin_lower double bin_upper double N_bin double N_total double share double year_from double year_to using "$G1_DEEP/intermediate/deep_paired_histograms.dta", replace
use "$G1_DEEP/intermediate/primary_predictions.dta", clear
keep psid sector method sample_id source_year in_fit raw centered index
rename source_year year_to
foreach v in in_fit raw centered index {
    rename `v' `v'_to
}
tempfile dest
save `dest'
use "$G1_DEEP/intermediate/primary_predictions.dta", clear
keep psid sector method sample_id source_year in_fit raw centered index
rename source_year year_from
gen double year_to=year_from+1
foreach v in in_fit raw centered index {
    rename `v' `v'_from
}
* WFDOC: Inner join satu-ke-satu mempertahankan hanya psid×sektor×metode×sampel yang memiliki kedua endpoint; syarat berikut menolak bridge kalender melalui 2016.
merge 1:1 psid sector method sample_id year_to using `dest', keep(3) nogen
assert year_to==year_from+1 & !inlist(year_to,2016,2017)
save "$G1_DEEP/intermediate/paired_predictions.dta", replace
foreach sector in $D_SECTORS {
    foreach method in op lp acf wrdg {
        foreach sample in own common {
            foreach yt in 0 $D_PAIR_TO {
                local yf=`yt'-1
                if `yt'==0 local yf=0
                use "$G1_DEEP/intermediate/primary_predictions.dta", clear
                keep if method=="`method'" & sample_id=="`sample'"
                if "`sector'"!="ALL" keep if sector=="`sector'"
                local n1=0
                local n2=0
                * WFDOC: Baris pooled 0/0 menjumlahkan endpoint dari semua pasangan exact-calendar; satu firm-year dapat muncul pada dua interval dan denominator ini bukan jumlah perusahaan unik.
                if `yt'==0 {
                    foreach endpoint in $D_PAIR_TO {
                        count if source_year==`endpoint'-1
                        local n1=`n1'+r(N)
                        count if source_year==`endpoint'
                        local n2=`n2'+r(N)
                    }
                }
                else {
                    count if source_year==`yf'
                    local n1=r(N)
                    count if source_year==`yt'
                    local n2=r(N)
                }
                use "$G1_DEEP/intermediate/paired_predictions.dta", clear
                keep if method=="`method'" & sample_id=="`sample'"
                if "`sector'"!="ALL" keep if sector=="`sector'"
                if `yt'!=0 keep if year_to==`yt' & year_from==`yf'
                foreach measure in raw centered index {
                    preserve
                    keep if !missing(`measure'_from,`measure'_to)
                    count
                    local np=r(N)
                    count if in_fit_to==1
                    local nf=r(N)
                    * WFDOC: change dihitung pada skala measure yang dipilih; ratio hanya digunakan untuk index dan hitungan arah memakai perubahan yang sama pada pasangan terpilih.
                    gen double change=`measure'_to-`measure'_from
                    gen double ratio=index_to/index_from
                    deep_stats change
                    foreach s in mean sd p1 p5 p25 p50 p75 p95 p99 {
                        local d_`s'=${D_`s'}
                    }
                    count if change<0
                    local neg=r(N)
                    count if change==0
                    local zero=r(N)
                    count if change>0 & !missing(change)
                    local pos=r(N)
                    local m1 .
                    local m2 .
                    local pear .
                    local spear .
                    local mr .
                    * WFDOC: Mean, rasio dan korelasi tepat hanya dilepas saat N_pairs≥5; hitungan negatif/nol/positif dan bin tetap menjadi diagnostics agregat.
                    if `np'>=5 {
                        summarize `measure'_from, meanonly
                        local m1=r(mean)
                        summarize `measure'_to, meanonly
                        local m2=r(mean)
                        summarize ratio, meanonly
                        local mr=r(mean)
                        capture correlate `measure'_from `measure'_to
                        if !_rc local pear=r(rho)
                        capture spearman `measure'_from `measure'_to
                        if !_rc local spear=r(rho)
                    }
                    post `p' ("`sector'") ("`method'") ("`sample'") ("`measure'") (`n1') (`n2') (`np') (`nf') (`np'-`nf') (`m1') (`m2') (`d_mean') (`d_sd') (`d_p1') (`d_p5') (`d_p25') (`d_p50') (`d_p75') (`d_p95') (`d_p99') (`neg') (`zero') (`pos') (`pear') (`spear') (`mr') (`np'>=5) (`yf') (`yt')
                    if `np'>0 & "`measure'"=="centered" {
                        gen double bin_lower=floor(change/.25)*.25
                        collapse (count) N_bin=change, by(bin_lower)
                        forvalues j=1/`=_N' {
                            post `h' ("`sector'") ("`method'") ("`sample'") ("`measure'") (bin_lower[`j']) (bin_lower[`j']+.25) (N_bin[`j']) (`np') (N_bin[`j']/`np') (`yf') (`yt')
                        }
                    }
                    restore
                }
            }
        }
    }
}
postclose `p'
use "$G1_DEEP/intermediate/deep_paired_changes.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_paired_changes.csv", replace
postclose `h'
use "$G1_DEEP/intermediate/deep_paired_histograms.dta", clear
ds, has(type numeric)
format `r(varlist)' %24.17g
export delimited using "$G1_DEEP/outputs/deep_paired_histograms.csv", replace
