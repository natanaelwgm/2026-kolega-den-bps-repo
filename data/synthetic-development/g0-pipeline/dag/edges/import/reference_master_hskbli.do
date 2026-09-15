import excel using "../reference-excel/master_hskbli.xlsx", sheet("Sheet1") firstrow allstring clear
assert _N==11555
save "dag/data/references/master_hskbli.dta", replace
display "REFERENCE_IMPORT_PASS master_hskbli"
