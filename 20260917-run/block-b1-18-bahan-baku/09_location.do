/*==========================================================================
  Line 9: "Lokasi"
  Data  : SI 2010-2022 (data/b18_si.dta), clean == 1
  Output sheets:
    t09_java_share   % of importers vs non-importers located in Java,
                     pool + by year
    t09_by_java      importer rate and import share, Java vs outside Java,
                     pool + by year
    t09_by_province  importer rate and import share per province,
                     pool + by year

  NOT YET COVERED: district (kabupaten), sub-district (kecamatan) and
  industrial-estate membership are not in the block 0 data. Add them here
  when available (copy the loop below with the new variable).
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are importers located in Java? ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1 & !missing(importer) & !missing(java)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_java = java, by(importer year)
replace pct_java = 100 * pct_java
generate period = cond(year == 0, "pool", string(year))
sort importer year
order importer period n_firms pct_java
drop year
list if period == "pool", clean noobs
export excel using "$B18_XLSX", sheet("t09_java_share", replace) firstrow(variables)

* ---- B. importer rate and import share by location ----
* loop: once for Java / outside Java, once for province
foreach loc in java prov {
    use "$B18_DATA/b18_si.dta", clear
    keep if clean == 1 & !missing(`loc')
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_firms (mean) pct_importer = importer ///
             (p50) med_share_mat = imp_share_mat (mean) mean_share_mat = imp_share_mat, by(`loc' year)
    replace pct_importer = 100 * pct_importer
    generate period = cond(year == 0, "pool", string(year))
    sort `loc' year
    order `loc' period n_firms pct_importer med_share_mat mean_share_mat
    drop year
    local sheet = cond("`loc'" == "java", "t09_by_java", "t09_by_province")
    export excel using "$B18_XLSX", sheet("`sheet'", replace) firstrow(variables)
}
