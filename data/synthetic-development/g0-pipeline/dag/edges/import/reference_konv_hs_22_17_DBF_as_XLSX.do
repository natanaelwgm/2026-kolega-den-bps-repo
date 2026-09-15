import excel using "../reference-excel/konv_hs_22_17_DBF_as_XLSX.xlsx", sheet("Sheet1") firstrow allstring clear
assert _N==11555
save "dag/data/references/konv_hs_22_17_DBF_as_XLSX.dta", replace
display "REFERENCE_IMPORT_PASS konv_hs_22_17_DBF_as_XLSX"
