* Ringkasan awal semua nilai yang teramati: signed value added dipertahankan.
* Tidak melakukan trimming, winsorization, deflasi, atau pengisian data baru.
capture log close SUMMARIES
log using "$DR_RUN/logs/summaries.log", name(SUMMARIES) text replace
use "$DR_INPUT", clear
local candidates workers gross_output_nominal value_added_nominal intermediate_inputs_nominal val_rtlvcu val_efuvcu elec_pln_kwh val_zpdvcu val_zndvcu production_workers capital_stock_nominal capital_additions_nominal import_value_nominal r_elec_purchased_kwh r_gj_electricity total_gj_s1 r_co2_scope1_s1 r_co2_scope2_s1 r_co2_total_s1 rd_cost_nominal rd_workers
local candidates `candidates' $DR_EXTRA_FIELDS
local candidates : list uniq candidates
tempname p
postfile `p' str32 variable int source_year long rows long n long missing_rows long zero long negative double mean double sd double min double p25 double p50 double p75 double max using "$DR_RUN/intermediate/summaries.dta", replace
foreach v of local candidates {
    capture confirm numeric variable `v'
    if _rc continue
    noisily display as result "RINGKASAN | `v' | mean, median, kuartil dan missing per tahun"
    foreach y of global DR_YEARS {
        quietly count if source_year==`y'
        local rows=r(N)
        quietly count if source_year==`y' & `v'==0
        local zero=r(N)
        quietly count if source_year==`y' & `v'<0 & !missing(`v')
        local negative=r(N)
        quietly summarize `v' if source_year==`y', detail
        local n=r(N)
        post `p' ("`v'") (`y') (`rows') (`n') (`rows'-`n') (`zero') (`negative') (r(mean)) (r(sd)) (r(min)) (r(p25)) (r(p50)) (r(p75)) (r(max))
    }
}
postclose `p'
use "$DR_RUN/intermediate/summaries.dta", clear
isid variable source_year
assert n+missing_rows==rows
assert zero+negative<=n
assert min<=p25 & p25<=p50 & p50<=p75 & p75<=max if n>0
format mean sd min p25 p50 p75 max %24.17g
export delimited using "$DR_RUN/tables/descriptive_statistics.csv", datafmt replace
log close SUMMARIES
