* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_capital_nominal_2012: annual staged raw state -> capital_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 120; ctttcu12 | total purchases & construct, 000rp
log using "$VYL/N_G0_capital_nominal_2012.log", text replace name(vycell)
generate double capital_nominal=.
generate byte vs_capital_nominal=3
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu12),",","",.))*1
replace vs_capital_nominal=5 if missing(real(subinstr(strtrim(raw_ctttcu12),",","",.))) & !inlist(upper(strtrim(raw_ctttcu12)),"","***",".","NA","N/A","NULL","-")
replace vs_capital_nominal=cond(capital_nominal<0,2,cond(capital_nominal==0,1,0)) if !missing(capital_nominal)
quietly count if !missing(capital_nominal)
local obs=r(N)
quietly count if capital_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_nominal==4
local absent=r(N)
post cell (2012) ("capital_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row capital_nominal vs_capital_nominal raw_ctttcu12
isid source_year source_row
save "$VYD/N_G0_capital_nominal_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_nominal_2012"
log close vycell
