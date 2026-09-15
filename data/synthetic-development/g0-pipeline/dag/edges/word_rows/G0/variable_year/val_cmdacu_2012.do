* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_cmdacu_2012: annual staged raw state -> val_cmdacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 110; cmdacu12 | depreciation of mchn & eqp, 000 rp
log using "$VYL/N_G0_val_cmdacu_2012.log", text replace name(vycell)
generate double val_cmdacu=.
generate byte vs_val_cmdacu=3
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu12),",","",.))*1
replace vs_val_cmdacu=5 if missing(real(subinstr(strtrim(raw_cmdacu12),",","",.))) & !inlist(upper(strtrim(raw_cmdacu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_cmdacu=cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0)) if !missing(val_cmdacu)
quietly count if !missing(val_cmdacu)
local obs=r(N)
quietly count if val_cmdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_cmdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_cmdacu==4
local absent=r(N)
post cell (2012) ("val_cmdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_cmdacu vs_val_cmdacu raw_cmdacu12
isid source_year source_row
save "$VYD/N_G0_val_cmdacu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_cmdacu_2012"
log close vycell
