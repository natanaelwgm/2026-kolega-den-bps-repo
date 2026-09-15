* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_capital_additions_nominal_2015: annual staged raw state -> capital_additions_nominal at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2015 row 140; ctttcu15 | total purchases & construct, 000rp
log using "$VYL/N_G0_capital_additions_nominal_2015.log", text replace name(vycell)
generate double capital_additions_nominal=.
generate byte vs_capital_additions_nominal=4
quietly count if !missing(capital_additions_nominal)
local obs=r(N)
quietly count if capital_additions_nominal==0
local zeros=r(N)
quietly count if inlist(vs_capital_additions_nominal,5,6,8)
local bad=r(N)
quietly count if vs_capital_additions_nominal==4
local absent=r(N)
post cell (2015) ("capital_additions_nominal") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row capital_additions_nominal vs_capital_additions_nominal
isid source_year source_row
save "$VYD/N_G0_capital_additions_nominal_2015.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_capital_additions_nominal_2015"
log close vycell
