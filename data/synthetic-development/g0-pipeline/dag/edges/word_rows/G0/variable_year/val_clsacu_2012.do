* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_clsacu_2012: annual staged raw state -> val_clsacu at source_year/source_row.
* Evidence: legacy_layout_2010_2015.json: sheet 2012 row 101; clsacu12 | sale/reduce of land, 000 rp
log using "$VYL/N_G0_val_clsacu_2012.log", text replace name(vycell)
generate double val_clsacu=.
generate byte vs_val_clsacu=3
replace val_clsacu=real(subinstr(strtrim(raw_clsacu12),",","",.))*1
replace vs_val_clsacu=5 if missing(real(subinstr(strtrim(raw_clsacu12),",","",.))) & !inlist(upper(strtrim(raw_clsacu12)),"","***",".","NA","N/A","NULL","-")
replace vs_val_clsacu=cond(val_clsacu<0,2,cond(val_clsacu==0,1,0)) if !missing(val_clsacu)
quietly count if !missing(val_clsacu)
local obs=r(N)
quietly count if val_clsacu==0
local zeros=r(N)
quietly count if inlist(vs_val_clsacu,5,6,8)
local bad=r(N)
quietly count if vs_val_clsacu==4
local absent=r(N)
post cell (2012) ("val_clsacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_clsacu vs_val_clsacu raw_clsacu12
isid source_year source_row
save "$VYD/N_G0_val_clsacu_2012.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_clsacu_2012"
log close vycell
