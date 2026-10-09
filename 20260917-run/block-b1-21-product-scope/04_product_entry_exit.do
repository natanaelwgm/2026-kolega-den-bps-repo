/*==========================================================================
  Line 4: "Product entry and exit"
  Data  : Proman roster rows (data/b21_pm_rows.dta), 2021 -> 2022
  A product of a firm is
     kept     produced in 2021 and in 2022
     added    (entry) produced in 2022 but not in 2021
     dropped  (exit)  produced in 2021 but not in 2022
  Only products with a KBKI code are used (a product name can be spelled
  differently in the two years, which would look like entry/exit).
  Only firms present in both years ("continuing firms") are compared;
  continuing firms whose products all lack a KBKI code drop out, so
  t04_entry_exit has fewer firms than the "both years" row of t04_coverage.
  Output sheets:
    t04_coverage     firms in 2021 only, 2022 only, both years
    t04_entry_exit   continuing firms: mean products 2021/2022, mean added /
                     dropped, % firms adding / dropping, value share of new
                     and dropped products
    t04_status       % of continuing firms: no change / added only /
                     dropped only / added and dropped
  Dataset: data/b21_entry_exit.dta (1 row = 1 continuing firm), used in line 8

  !! KIPB CAVEAT: Kipb is masked, so firm_key is a CELL (province x KBLI5).
     A cell is a weak stand-in for a firm: its product set also changes when
     plants enter or leave the cell or the sample, so entry/exit here mixes
     firm-level product switching with sample turnover. This table only
     becomes a real product entry/exit table with the real Kipb.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 1. which firms are in which year ----
use "$B21_DATA/b21_pm_firm.dta", clear
keep firm_key year
generate here = 1
reshape wide here, i(firm_key) j(year)
generate presence = 1 if here2021 == 1 & missing(here2022)
replace  presence = 2 if missing(here2021) & here2022 == 1
replace  presence = 3 if here2021 == 1 & here2022 == 1
label define presence 1 "2021 only (firm exit)" 2 "2022 only (firm entry)" 3 "Both years (continuing)"
label values presence presence
generate n_firms = 1
collapse (sum) n_firms, by(presence)
egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
drop total
list, clean noobs
export excel using "$B21_XLSX", sheet("t04_coverage", replace) firstrow(variables)

* ---- 2. product x firm, value in each year ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if substr(item, 1, 5) != "NAME "
collapse (sum) val_prod, by(firm_key item year)
reshape wide val_prod, i(firm_key item) j(year)
* continuing firms only
bysort firm_key: egen any21 = max(!missing(val_prod2021))
bysort firm_key: egen any22 = max(!missing(val_prod2022))
keep if any21 == 1 & any22 == 1

generate in21    = !missing(val_prod2021)
generate in22    = !missing(val_prod2022)
generate kept    = in21 & in22
generate added   = !in21 & in22
generate dropped = in21 & !in22
generate val_added   = val_prod2022 * added
generate val_dropped = val_prod2021 * dropped
collapse (sum) n_2021 = in21 n_2022 = in22 n_kept = kept n_added = added ///
         n_dropped = dropped val_2021 = val_prod2021 val_2022 = val_prod2022 ///
         val_added val_dropped, by(firm_key)
generate share_val_new     = 100 * val_added / val_2022     // % of 2022 value from new products
generate share_val_dropped = 100 * val_dropped / val_2021   // % of 2021 value in dropped products
generate any_added   = (n_added > 0)
generate any_dropped = (n_dropped > 0)
generate status = 1 if n_added == 0 & n_dropped == 0
replace  status = 2 if n_added > 0  & n_dropped == 0
replace  status = 3 if n_added == 0 & n_dropped > 0
replace  status = 4 if n_added > 0  & n_dropped > 0
label define status 1 "No change" 2 "Added only" 3 "Dropped only" 4 "Added and dropped"
label values status status

* 2021 status of the firm, for line 8
generate year = 2021
merge 1:1 firm_key year using "$B21_DATA/b21_pm_firm.dta", keepusing(exporter importer fdi kbli2) ///
      keep(master match) nogenerate
drop year
label variable n_added  "Products added 2021->2022 (entry)"
label variable n_dropped "Products dropped 2021->2022 (exit)"
label variable share_val_new "% of 2022 production value from added products"
label variable share_val_dropped "% of 2021 production value in dropped products"
label variable exporter "Exporter in 2021 (roster)"
label variable importer "Importer in 2021 (SI cell)"
label variable fdi      "FDI in 2021 (SI cell)"
compress
save "$B21_DATA/b21_entry_exit.dta", replace

* ---- 3. summary table ----
generate n_firms = 1
collapse (sum) n_firms (mean) mean_n_2021 = n_2021 mean_n_2022 = n_2022 ///
         mean_n_added = n_added mean_n_dropped = n_dropped ///
         pct_adding = any_added pct_dropping = any_dropped ///
         mean_share_val_new = share_val_new mean_share_val_dropped = share_val_dropped ///
         (sum) tot_kept = n_kept tot_added = n_added tot_dropped = n_dropped
replace pct_adding   = 100 * pct_adding
replace pct_dropping = 100 * pct_dropping
generate period = "2021->2022"
order period
list, clean noobs
export excel using "$B21_XLSX", sheet("t04_entry_exit", replace) firstrow(variables)

* ---- 4. firms by entry/exit status ----
use "$B21_DATA/b21_entry_exit.dta", clear
generate n_firms = 1
collapse (sum) n_firms, by(status)
egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
drop total
list, clean noobs
export excel using "$B21_XLSX", sheet("t04_status", replace) firstrow(variables)
