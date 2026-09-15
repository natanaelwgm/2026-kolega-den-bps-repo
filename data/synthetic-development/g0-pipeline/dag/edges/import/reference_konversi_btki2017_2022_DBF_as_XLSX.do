import excel using "../reference-excel/konversi_btki2017_2022_DBF_as_XLSX.xlsx", sheet("Sheet1") firstrow allstring clear
assert _N==10847
save "dag/data/references/konversi_btki2017_2022_DBF_as_XLSX.dta", replace
display "REFERENCE_IMPORT_PASS konversi_btki2017_2022_DBF_as_XLSX"
