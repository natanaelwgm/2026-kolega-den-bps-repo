* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
* N_G0_val_codacu_2017: annual staged raw state -> val_codacu at source_year/source_row.
* Evidence: Existing G0 source map; semantic verification not implied by a parsed value.
log using "$VYL/N_G0_val_codacu_2017.log", text replace name(vycell)
generate double val_codacu=.
generate byte vs_val_codacu=3
replace val_codacu=real(subinstr(strtrim(raw_codacu17),",","",.))*1
replace vs_val_codacu=5 if missing(real(subinstr(strtrim(raw_codacu17),",","",.))) & !inlist(upper(strtrim(raw_codacu17)),"","***",".","NA","N/A","NULL","-")
replace vs_val_codacu=cond(val_codacu<0,2,cond(val_codacu==0,1,0)) if !missing(val_codacu)
quietly count if !missing(val_codacu)
local obs=r(N)
quietly count if val_codacu==0
local zeros=r(N)
quietly count if inlist(vs_val_codacu,5,6,8)
local bad=r(N)
quietly count if vs_val_codacu==4
local absent=r(N)
post cell (2017) ("val_codacu") (_N) (`obs') (`zeros') (`bad') (`absent')
preserve
keep source_year source_row val_codacu vs_val_codacu raw_codacu17
isid source_year source_row
save "$VYD/N_G0_val_codacu_2017.dta", replace
restore
display "VARIABLE_YEAR_PASS N_G0_val_codacu_2017"
log close vycell
