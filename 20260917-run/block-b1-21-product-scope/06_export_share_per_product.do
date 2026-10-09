/*==========================================================================
  Line 6: "Export share per product"
  Data  : Proman roster rows 2021-2022 (data/b21_pm_rows.dta)
          exp_share = % of the product line's production that is exported
          (2021 Prprex, 2022 Ekspor; blank = not exported, >100 capped)
  Output sheets:
    t06_exported     % of product lines exported and % of production value
                     exported, pool + by year
    t06_share_stats  stats of exp_share AMONG EXPORTED PRODUCT LINES only
                     (with all lines included the median is 0)
    t06_share_bins   exported product lines by export share: <10, 10-25,
                     25-50, 50-75, 75-<100, 100%
    t06_firm         firm level, exporters only: exported / production
                     value (%) and % of the firm's products exported
    t06_top_products top 20 products (KBKI) by export value, pooled, with
                     their export share
  NOTE: lines that name a destination but have no export share are
        counted as not exported (01b prints how many: 59 in the sample).
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. how much is exported ----
use "$B21_DATA/b21_pm_rows.dta", clear
generate n_lines = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_lines val_prod val_export (mean) pct_lines_exported = exported, by(year)
replace pct_lines_exported = 100 * pct_lines_exported
generate pct_value_exported = 100 * val_export / val_prod
generate period = cond(year == 0, "pool", string(year))
keep period n_lines pct_lines_exported pct_value_exported
order period
list, clean noobs
export excel using "$B21_XLSX", sheet("t06_exported", replace) firstrow(variables)

* ---- B. distribution among exported product lines ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if exported == 1
do "$B21/_sumstats.do" "exp_share" "" "t06_share_stats"

generate share_bin = 1 if exp_share < 10
replace  share_bin = 2 if exp_share >= 10 & exp_share < 25
replace  share_bin = 3 if exp_share >= 25 & exp_share < 50
replace  share_bin = 4 if exp_share >= 50 & exp_share < 75
replace  share_bin = 5 if exp_share >= 75 & exp_share < 100
replace  share_bin = 6 if exp_share == 100
label define share_bin 1 "<10%" 2 "10-25%" 3 "25-50%" 4 "50-75%" 5 "75-<100%" 6 "100%"
label values share_bin share_bin
generate n_lines = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_lines, by(share_bin year)
bysort year: egen total = total(n_lines)
generate pct_lines = 100 * n_lines / total
generate period = cond(year == 0, "pool", string(year))
sort year share_bin
keep period share_bin n_lines pct_lines
order period share_bin
export excel using "$B21_XLSX", sheet("t06_share_bins", replace) firstrow(variables)

* ---- C. firm level, exporters only ----
use "$B21_DATA/b21_pm_firm.dta", clear
keep if exporter == 1
do "$B21/_sumstats.do" "exp_intensity pct_prod_exported" "" "t06_firm"

* ---- D. top exported products ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if substr(item, 1, 5) != "NAME "
collapse (sum) val_prod val_export (mean) pct_lines_exported = exported ///
         (first) product, by(item)
generate export_share = 100 * val_export / val_prod
replace  pct_lines_exported = 100 * pct_lines_exported
egen total_export = total(val_export)
generate pct_of_all_exports = 100 * val_export / total_export
gsort -val_export
keep in 1/20
rename (item product) (kbki example_name)
keep kbki example_name val_export export_share pct_lines_exported pct_of_all_exports
order kbki example_name val_export export_share pct_lines_exported pct_of_all_exports
list kbki example_name export_share pct_of_all_exports, clean noobs
export excel using "$B21_XLSX", sheet("t06_top_products", replace) firstrow(variables)
