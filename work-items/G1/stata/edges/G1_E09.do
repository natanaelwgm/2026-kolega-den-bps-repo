* WFDOC: Common support adalah irisan empat g1_eligible per record; hasil ini tetap terpisah dari domain metode sendiri.
* WFDOC: Attrition mencatat retained per gate, metode, tahun, dan prefix; N_source menjadi denominator dan grup kosong dilewati.
* WFDOC: Common=1 hanya jika OP, LP, ACF, WRDG sama-sama eligible pada record yang sama.
gen byte g1_common = g1_eligible_op & g1_eligible_lp & g1_eligible_acf & g1_eligible_wrdg
tempname flow
postfile `flow' str8 method str20 code_prefix double source_year str32 stage double N_source N_retained using "$G1_RUN/attrition.dta", replace
levelsof source_year, local(years)
levelsof g1_code_prefix, local(codes)
foreach m in op lp acf wrdg {
    foreach y of local years {
        foreach c in ALL `codes' {
            local filter "source_year==`y'"
            if "`c'"!="ALL" local filter `"`filter' & g1_code_prefix=="`c'""'
            quietly count if `filter'
            local n=r(N)
            if `n'==0 continue
            post `flow' ("`m'") ("`c'") (`y') ("01_source") (`n') (`n')
            local j=1
            foreach flag in g1_nominal_`m' g1_concept_`m' g1_real_`m' g1_eligible_`m' g1_common {
                local ++j
                quietly count if (`filter') & `flag'==1
                post `flow' ("`m'") ("`c'") (`y') ("0`j'_`flag'") (`n') (r(N))
            }
        }
    }
}
* WFDOC: loss_from_previous=retained sebelumnya−retained kini; retained_percent=100×retained/N_source.
postclose `flow'
save "$G1_RUN/S09_samples.dta", replace
preserve
use "$G1_RUN/attrition.dta", clear
sort method code_prefix source_year stage
by method code_prefix source_year: gen double loss_from_previous = N_retained[_n-1]-N_retained if _n>1
assert loss_from_previous>=0 if !missing(loss_from_previous)
gen double retained_percent = 100*N_retained/N_source
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/tfp_sample_attrition.csv", replace
restore
