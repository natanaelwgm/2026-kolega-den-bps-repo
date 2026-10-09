/*==========================================================================
  Line 4: "karakteristik firms yang rely on import:"
  This line is the heading for lines 5-10, which each have their own file.
  This file gives the one-table overview: who are the firms that rely on
  imports, compared with those that do not.

  "Reliance" groups (SI, raw materials):
    0 Non-importer
    1 Low reliance   imports < 50% of raw materials
    2 High reliance  imports >= 50% of raw materials
  (change the 0.5 cut-off below if needed)

  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Output sheet:
    t04_profile   by reliance group x period (pool + by year):
                  n firms, % FDI, % exporter, % large, % Java,
                  median VA per worker, median workers
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer)

generate reliance = 0 if importer == 0
replace  reliance = 1 if importer == 1 & imp_share_mat <  0.5
replace  reliance = 2 if importer == 1 & imp_share_mat >= 0.5 & !missing(imp_share_mat)
label define reliance 0 "Non-importer" 1 "Low reliance (<50%)" 2 "High reliance (>=50%)"
label values reliance reliance
* importers with no usable raw-material value have no reliance group
count if importer == 1 & missing(reliance)
display as result "Importers without a raw-material value (no reliance group): " r(N)
drop if missing(reliance)

generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi pct_exporter = exporter pct_large = large pct_java = java ///
         (p50) med_va_pw = va_pw med_workers = workers, by(reliance year)
foreach v in pct_fdi pct_exporter pct_large pct_java {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
sort reliance year
order reliance period n_firms pct_fdi pct_exporter pct_large pct_java med_va_pw med_workers
drop year
list if period == "pool", clean noobs
export excel using "$B18_XLSX", sheet("t04_profile", replace) firstrow(variables)
