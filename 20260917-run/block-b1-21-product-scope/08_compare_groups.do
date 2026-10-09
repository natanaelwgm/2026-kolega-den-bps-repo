/*==========================================================================
  Line 8: "Compare exporter vs non exporters, importers/non importers,
           domestic/fdi."
  Data  : Proman firm file (data/b21_pm_firm.dta) for lines 2, 3, 5, 6, 7
          Entry/exit file (data/b21_entry_exit.dta) for line 4
          SI 2017-2018 (data/b21_si.dta) for the product-innovation question
  The three splits:
    exporter  firm exports at least one product (roster)
    importer  at least half of the clean SI plants in the firm's cell
              (year x province x KBLI5) import raw materials
    fdi       at least half of the clean SI plants in the cell are FDI
  Roster firms whose cell has no SI plant have no importer / FDI status
  and drop out of those two comparisons (see t08_coverage).
  Output sheets:
    t08_coverage       roster firms with an SI importer / FDI status
    t08_by_exporter    lines 2, 3, 5 measures, exporters vs non-exporters
    t08_by_importer    lines 2, 3, 5, 6, 7 measures + % exporters
    t08_by_fdi         same, domestic vs FDI
    t08_entry_exit     line 4 (adding / dropping products 2021->2022) by
                       the firm's 2021 status, continuing firms only
    t08_si_prod_innov  extra evidence from SI (all plants, 2017-2018): % of
                       plants that introduced a new or improved product, by
                       exporter / importer / FDI
  NOTE: firm = cell (province x KBLI5) until Kipb is available.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- coverage of the SI status ----
use "$B21_DATA/b21_pm_firm.dta", clear
generate n_firms = 1
generate has_importer = !missing(importer)
generate has_fdi      = !missing(fdi)
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_with_importer = has_importer pct_with_fdi = has_fdi ///
         pct_exporter = exporter, by(year)
foreach v in pct_with_importer pct_with_fdi pct_exporter {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
drop year
order period
list, clean noobs
export excel using "$B21_XLSX", sheet("t08_coverage", replace) firstrow(variables)

* ---- lines 2, 3, 5, 6, 7 by group ----
use "$B21_DATA/b21_pm_firm.dta", clear
local PRODUCT "n_products ln_n_products hhi eff_n_products core_share"
local EXPORT  "exporter exp_intensity n_dest"
do "$B21/_sumstats.do" "`PRODUCT'"         "exporter" "t08_by_exporter"
do "$B21/_sumstats.do" "`PRODUCT' `EXPORT'" "importer" "t08_by_importer"
do "$B21/_sumstats.do" "`PRODUCT' `EXPORT'" "fdi"      "t08_by_fdi"

* ---- line 4 by 2021 status ----
tempfile stack
clear
save `stack', emptyok
foreach s in exporter importer fdi {
    use "$B21_DATA/b21_entry_exit.dta", clear
    keep if !missing(`s')
    generate n_firms = 1
    collapse (sum) n_firms (mean) pct_adding = any_added pct_dropping = any_dropped ///
             mean_n_added = n_added mean_n_dropped = n_dropped ///
             mean_share_val_new = share_val_new mean_share_val_dropped = share_val_dropped, by(`s')
    replace pct_adding   = 100 * pct_adding
    replace pct_dropping = 100 * pct_dropping
    decode `s', generate(group)
    generate split = "`s'"
    generate g = `s'
    drop `s'
    append using `stack'
    save `stack', replace
}
order split group
sort split g
drop g
list, clean noobs
export excel using "$B21_XLSX", sheet("t08_entry_exit", replace) firstrow(variables)

* ---- SI: product innovation (2017-2018) by group ----
clear
save `stack', emptyok replace
foreach s in exporter importer fdi {
    use "$B21_DATA/b21_si.dta", clear
    keep if clean == 1 & !missing(prod_innov) & !missing(`s')
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    collapse (sum) n_firms (mean) pct_prod_innov = prod_innov, by(`s' year)
    replace pct_prod_innov = 100 * pct_prod_innov
    decode `s', generate(group)
    generate split = "`s'"
    generate g = `s'
    drop `s'
    append using `stack'
    save `stack', replace
}
generate period = cond(year == 0, "pool", string(year))
sort split year g
order split group period
drop g year
list if period == "pool", clean noobs
export excel using "$B21_XLSX", sheet("t08_si_prod_innov", replace) firstrow(variables)
