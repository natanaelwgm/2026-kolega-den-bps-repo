* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_csdacu_2017: annual staged raw state -> val_csdacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_csdacu_2017.log", text replace name(vycell)
generate double val_csdacu=.
generate byte vs_val_csdacu=3
replace val_csdacu=real(subinstr(strtrim(raw_csdacu17),",","",.))*1
replace vs_val_csdacu=5 if missing(real(subinstr(strtrim(raw_csdacu17),",","",.))) & !inlist(upper(strtrim(raw_csdacu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_csdacu=cond(val_csdacu<0,2,cond(val_csdacu==0,1,0)) if !missing(val_csdacu)
quietly count if !missing(val_csdacu)
local obs=r(N)
quietly count if val_csdacu==0
local zeros=r(N)
quietly count if inlist(vs_val_csdacu,5,6,8)
local bad=r(N)
quietly count if vs_val_csdacu==4
local absent=r(N)
post cell (2017) ("val_csdacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_csdacu vs_val_csdacu raw_csdacu17
isid source_year source_row
save "$VYD/N_G0_val_csdacu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_csdacu_2017"
log close vycell
