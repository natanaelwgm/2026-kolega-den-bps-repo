import excel using "../reference-excel/konversi_btki2017_kbli2015.xlsx", sheet("Sheet1") firstrow allstring clear
assert _N==10829
save "dag/data/references/konversi_btki2017_kbli2015.dta", replace
display "REFERENCE_IMPORT_PASS konversi_btki2017_kbli2015"
