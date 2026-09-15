* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_capital_additions_nominal_2011: annual staged raw state -> capital_additions_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2011 row 125; ctttcu11 | total purchases & construct, 000rp
log using "$VYL/N_G0_capital_additions_nominal_2011.log", text replace name(vycell)
generate double capital_additions_nominal=.
generate byte vs_capital_additions_nominal=3
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu11),",","",.))*1
replace vs_capital_additions_nominal=5 if missing(real(subinstr(strtrim(raw_ctttcu11),",","",.))) & !inlist(upper(strtrim(raw_ctttcu11)),"","***",".","NA","N/A","NULL","-")
replace vs_capital_additions_nominal=cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0)) if !missing(capital_additions_nominal)
quietly count if !missing(capital_additions_nominal)
local obs=r(N)
quietly count if capital_additions_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_additions_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_additions_nominal==4
local absent=r(N)
post cell (2011) ("capital_additions_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row capital_additions_nominal vs_capital_additions_nominal raw_ctttcu11
isid source_year source_row
save "$VYD/N_G0_capital_additions_nominal_2011.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_additions_nominal_2011"
log close vycell
