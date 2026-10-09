/*==========================================================================
  Line 8: "Cross tab dengan export/import/FDI, size, sector dan
           carbon/energy productivity"
  Data  : SI (data/b208_si.dta), clean == 1
  A. Lines 3-7 by each split, pool + by year. One sheet per split:
       t08_by_exporter  t08_by_importer  t08_by_fdi  t08_by_large (size)
       t08_by_kbli2     t08_by_q_cprod   (quintile of VA / tCO2)
                        t08_by_q_eprod   (quintile of VA / GJ)
     Columns: pct_* = % yes among firms that answered, n_* = firms that
     answered; med_rnd_va = median R&D expense / VA among spenders.
     pct_* covers only the years the question is asked (see file 02), so
     the pooled row of each measure is a different set of years.
  B. The other way round: carbon / energy productivity by capability.
       t08_prod_by_cap  median VA/tCO2, VA/GJ, tCO2/VA and mean ln VA/tCO2,
                        ln VA/GJ for firms with vs without each capability,
                        pool + by year

  NOTE: 2022 exporter and 2020 FDI are missing (see 01a), so waste (2022
  only) has no exporter split and 2020 drops out of the FDI split.
  Productivity quintiles are within each year (values are nominal).
  These are associations: an R&D firm may also be larger, an exporter, etc.
==========================================================================*/
if "$B208" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. capability rates by every split ----
* one sheet per split: t08_by_<split>
foreach s in exporter importer fdi large kbli2 q_cprod q_eprod {
    use "$B208_DATA/b208_si.dta", clear
    keep if clean == 1 & !missing(`s')
    generate rnd_va_spenders = rnd_va if rnd_cost_pos == 1
    generate n_firms = 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms ///
             (mean) pct_rnd = rnd pct_rnd_ext = rnd_ext pct_rnd_cost_pos = rnd_cost_pos ///
                    pct_innov = innov pct_amdal = amdal pct_env_doc = env_doc ///
                    pct_waste_treat = waste_treat pct_waste_any = waste_any ///
             (count) n_rnd = rnd n_innov = innov n_env_doc = env_doc n_waste_any = waste_any ///
             (p50) med_rnd_va = rnd_va_spenders, by(`s' year)
    foreach v in pct_rnd pct_rnd_ext pct_rnd_cost_pos pct_innov pct_amdal pct_env_doc ///
                 pct_waste_treat pct_waste_any {
        replace `v' = 100 * `v'
    }
    generate period = cond(year == 0, "pool", string(year))
    sort `s' year
    order `s' period n_firms
    drop year
    export excel using "$B208_XLSX", sheet("t08_by_`s'", replace) firstrow(variables)
    display as result "  -> sheet t08_by_`s'"
}

* ---- B. carbon / energy productivity by capability ----
tempfile stack
local first 1
foreach c in rnd rnd_cost_pos innov amdal env_doc waste_treat waste_any {
    use "$B208_DATA/b208_si.dta", clear
    keep if clean == 1 & !missing(`c')
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_firms (p50) med_va_per_co2 = va_per_co2 med_va_per_gj = va_per_gj ///
             med_co2_per_va = co2_per_va (mean) mean_ln_va_per_co2 = ln_va_per_co2 ///
             mean_ln_va_per_gj = ln_va_per_gj, by(`c' year)
    generate str14 capability = "`c'"
    rename `c' has_capability
    if `first' == 0 append using `stack'
    save `stack', replace
    local first 0
}
label values has_capability yesno
generate period = cond(year == 0, "pool", string(year))
generate cap_order = 0
local i 0
foreach c in rnd rnd_cost_pos innov amdal env_doc waste_treat waste_any {
    local ++i
    replace cap_order = `i' if capability == "`c'"
}
sort cap_order year has_capability
order capability has_capability period n_firms
drop year cap_order
list if period == "pool", clean noobs
export excel using "$B208_XLSX", sheet("t08_prod_by_cap", replace) firstrow(variables)
