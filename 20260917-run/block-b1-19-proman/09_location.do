/*==========================================================================
  Line 9: "Lokasi"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
          + Proman roster 2021-2022 (data/b19_pm_firm.dta)
  Output sheets:
    t09_java_share   % of exporters vs non-exporters located in Java,
                     pool + by year
    t09_by_java      exporter rate and export share, Java vs outside Java,
                     pool + by year
    t09_by_province  exporter rate and export share per province,
                     pool + by year
    t09_pm_by_java   roster: % firms exporting and exported / production
                     value, Java vs outside Java, 2021, 2022 and pool
    t09_pm_by_prov   same per province

  NOT YET COVERED: district (kabupaten), sub-district (kecamatan) and
  industrial-estate membership are not in the block 0 data (and Kab is
  masked in the roster). Add them here when available.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. are exporters located in Java? ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exporter) & !missing(java)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_java = java, by(exporter year)
replace pct_java = 100 * pct_java
generate period = cond(year == 0, "pool", string(year))
sort exporter year
order exporter period n_firms pct_java
drop year
list if period == "pool", clean noobs
export excel using "$B19_XLSX", sheet("t09_java_share", replace) firstrow(variables)

* ---- B. exporter rate and export share by location ----
* loop: once for Java / outside Java, once for province
foreach loc in java prov {
    use "$B19_DATA/b19_si.dta", clear
    keep if clean == 1 & !missing(`loc') & !missing(exporter)
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_firms (mean) pct_exporter = exporter (count) n_share = exp_share ///
             (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(`loc' year)
    replace pct_exporter = 100 * pct_exporter
    generate period = cond(year == 0, "pool", string(year))
    sort `loc' year
    order `loc' period n_firms pct_exporter n_share med_exp_share mean_exp_share
    drop year
    local sheet = cond("`loc'" == "java", "t09_by_java", "t09_by_province")
    export excel using "$B19_XLSX", sheet("`sheet'", replace) firstrow(variables)
}

* ---- C. roster: export share of production by location ----
foreach loc in java prov {
    use "$B19_DATA/b19_pm_firm.dta", clear
    keep if !missing(`loc')
    generate n_firms = 1
    generate val_prod_known = val_prod if !missing(val_export)
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_firms any_export val_export val_prod_known, by(`loc' year)
    generate pct_firms_export = 100 * any_export / n_firms
    generate agg_export_share = 100 * val_export / val_prod_known
    generate period = cond(year == 0, "pool", string(year))
    sort `loc' year
    order `loc' period n_firms any_export pct_firms_export agg_export_share
    drop year
    export excel using "$B19_XLSX", sheet("t09_pm_by_`loc'", replace) firstrow(variables)
}
