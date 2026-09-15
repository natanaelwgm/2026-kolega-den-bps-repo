* WFDOC: Mengaudit kandidat output, pekerja, modal, proxy dan harga per variabel-tahun; log dibuat hanya untuk angka positif, nominal tidak disebut real.
* WFDOC: S04_domains.dta menyimpan gate/log; CSV domain/status di outputs/ memakai N_source sebagai denominator dan berlabel development.
local vars gross_output_nominal value_added_nominal workers capital_stock_nominal capital_additions_nominal intermediate_inputs_nominal val_rtlvcu deflator_output deflator_inputs deflator_capital gross_output_real value_added_real capital_real intermediate_inputs_real
* WFDOC: N_missing+N_zero+N_negative+N_positive=N_source; persentil/min/max merangkum dukungan, bukan filter.
tempname cells
postfile `cells' str32 variable double source_year double N_source double N_missing double N_zero double N_negative double N_positive double p1 double p50 double p99 double min double max using "$G1_RUN/domain_cells.dta", replace
levelsof source_year, local(years)
foreach v of local vars {
    foreach y of local years {
        quietly count if source_year==`y'
        local n=r(N)
        quietly count if source_year==`y' & missing(`v')
        local miss=r(N)
        quietly count if source_year==`y' & `v'==0
        local zero=r(N)
        quietly count if source_year==`y' & `v'<0
        local neg=r(N)
        quietly count if source_year==`y' & `v'>0 & !missing(`v')
        local pos=r(N)
        quietly summarize `v' if source_year==`y', detail
        post `cells' ("`v'") (`y') (`n') (`miss') (`zero') (`neg') (`pos') (r(p1)) (r(p50)) (r(p99)) (r(min)) (r(max))
    }
}
postclose `cells'
* WFDOC: Basis real menambah VA/K real, bridge WPI, stok terverifikasi, dan measurement gate pada syarat nilai positif.
gen byte g1_nominal_base = value_added_nominal>0 & workers>0 & capital_stock_nominal>0 & !missing(value_added_nominal,workers,capital_stock_nominal)
gen byte g1_stock_concept = capital_stock_verified==1
gen byte g1_real_base = value_added_real>0 & capital_real>0 & workers>0 & !missing(value_added_real,capital_real,workers) & wpi_company_bridge_verified==1 & g1_stock_concept & g1_measurement_admitted
gen double g1_ln_y = ln(value_added_real) if value_added_real>0 & !missing(value_added_real)
gen double g1_ln_l = ln(workers) if workers>0 & !missing(workers)
gen double g1_ln_k = ln(capital_real) if capital_real>0 & !missing(capital_real)
save "$G1_RUN/S04_domains.dta", replace
preserve
use "$G1_RUN/domain_cells.dta", clear
assert N_source == N_missing + N_zero + N_negative + N_positive
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/variable_domains.csv", replace
restore
tempfile states
preserve
clear
save `states', emptyok replace
restore
* WFDOC: Frekuensi vs_ mempertahankan state per variabel-tahun; status unknown tidak disamakan dengan nol.
foreach v in gross_output_nominal value_added_nominal workers capital_stock_nominal capital_additions_nominal intermediate_inputs_nominal val_rtlvcu {
    preserve
    contract source_year vs_`v', freq(N_state)
    rename vs_`v' source_state
    gen str32 variable = "`v'"
    append using `states'
    save `states', replace
    restore
}
preserve
use `states', clear
bysort variable source_year: egen double N_source = total(N_state)
gen str100 data_label = "G0.5 DEVELOPMENT - perturbed data; not final empirical findings"
export delimited using "$G1_RUN/outputs/source_status.csv", replace
restore
