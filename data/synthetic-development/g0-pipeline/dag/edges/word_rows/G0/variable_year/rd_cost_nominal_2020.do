* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_rd_cost_nominal_2020: annual staged raw state -> rd_cost_nominal at source_year/source_row.
* Evidence: BPS SILASTIK 2017/2018/2019 IRDVCU labels; annual 2021 Q306 and 2022 Q306 R&D expense. COSTRD is third-party funding indicator, not money.
log using "$VYL/N_G0_rd_cost_nominal_2020.log", text replace name(vycell)
generate double rd_cost_nominal=.
generate byte vs_rd_cost_nominal=3
replace rd_cost_nominal=real(subinstr(strtrim(raw_irdvcu20),",","",.))*1
replace vs_rd_cost_nominal=5 if missing(real(subinstr(strtrim(raw_irdvcu20),",","",.))) & !inlist(upper(strtrim(raw_irdvcu20)),"","***",".","NA","N/A","NULL","-")
replace vs_rd_cost_nominal=cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0)) if !missing(rd_cost_nominal)
quietly count if !missing(rd_cost_nominal)
local obs=r(N)
quietly count if rd_cost_nominal==0
local zeros=r(N)
quietly count if inlist(vs_rd_cost_nominal,5,6,8)
local bad=r(N)
quietly count if vs_rd_cost_nominal==4
local absent=r(N)
post cell (2020) ("rd_cost_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row rd_cost_nominal vs_rd_cost_nominal raw_irdvcu20
isid source_year source_row
save "$VYD/N_G0_rd_cost_nominal_2020.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_rd_cost_nominal_2020"
log close vycell
