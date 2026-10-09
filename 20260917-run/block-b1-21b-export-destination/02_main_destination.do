/*==========================================================================
  Line 2: "Tujuan utama ekspor by firms/sektor: EU, US, China, ASEAN, Japan,
           India, others?"
  Data  : Proman roster 2021-2022 (data/b21b_pm_rows.dta), exported products
  Output sheets:
    t02_coverage          per year: products, exported products, % with a
                          destination, export value, % of it with a destination
    t02_region_share      per region: % of export value and % of exported
                          products, number of firms, pool + by year
    t02_firm_main_region  exporting firms by their MAIN region (the region with
                          the largest export value), % of firms, pool + by year
    t02_firm_any_region   % of exporting firms that export to each region
                          (a firm can be in several), pool + by year
    t02_region_by_kbli2   region shares of export value within each KBLI
                          2-digit sector, pool + by year
  Chart: fig02 (drawn in 05_figures.do)

  NOTE: "firm" = cell (year x province x KBLI5) while Kipb is masked.
  Value shares use exported products with a destination AND a valid export
  share; product shares count every exported product with a destination.
  One main destination per product. In "pool", n_firms counts firm-years.
==========================================================================*/
if "$B21B" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- coverage ----
use "$B21B_DATA/b21b_pm_rows.dta", clear
generate one = 1
generate with_dest = (dest_country != "") if exported == 1
generate val_with_dest = exp_value * (dest_country != "")
egen tag_exp_firm = tag(firm_key year) if exported == 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_products = one n_exported = exported n_with_dest = with_dest ///
         n_exp_firms = tag_exp_firm exp_value val_with_dest, by(year)
generate pct_exported_with_dest = 100 * n_with_dest / n_exported
generate pct_value_with_dest    = 100 * val_with_dest / exp_value
generate period = cond(year == 0, "pool", string(year))
order period
drop year
list, clean noobs
export excel using "$B21B_XLSX", sheet("t02_coverage", replace) firstrow(variables)

* from here on: exported products with a named destination
use "$B21B_DATA/b21b_pm_rows.dta", clear
keep if dest_country != ""
generate one = 1
tempfile dest
save `dest'

* ---- region shares, pool + by year ----
egen tag_firm = tag(firm_key year region)     // counts each firm once per region
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_products = one n_firms = tag_firm exp_value, by(region year)
bysort year: egen total_value = total(exp_value)
bysort year: egen total_products = total(n_products)
generate share_value_pct    = 100 * exp_value / total_value
generate share_products_pct = 100 * n_products / total_products
generate period = cond(year == 0, "pool", string(year))
sort year region
order region period share_value_pct share_products_pct exp_value n_products n_firms
drop year total_*
list if period == "pool", clean noobs
export excel using "$B21B_XLSX", sheet("t02_region_share", replace) firstrow(variables)

* ---- firms: main region (largest export value; ties -> most products) ----
use `dest', clear
collapse (sum) exp_value n_products = one, by(firm_key year region)
gsort firm_key year -exp_value -n_products
by firm_key year: keep if _n == 1
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms, by(region year)
rename region main_region
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year main_region
order main_region period n_firms pct_firms
drop year total
export excel using "$B21B_XLSX", sheet("t02_firm_main_region", replace) firstrow(variables)

* ---- firms: exports to region at all ----
use `dest', clear
keep firm_key year region
duplicates drop                                // 1 row = firm x region
generate one = 1
egen tag_firm = tag(firm_key year)             // 1 per exporting firm
expand 2, generate(copy)
replace year = 0 if copy == 1
bysort year: egen n_exp_firms = total(tag_firm)  // exporting firms with a destination
collapse (sum) n_firms = one (first) n_exp_firms, by(region year)
generate pct_of_exp_firms = 100 * n_firms / n_exp_firms
generate period = cond(year == 0, "pool", string(year))
sort year region
order region period n_firms n_exp_firms pct_of_exp_firms
drop year
export excel using "$B21B_XLSX", sheet("t02_firm_any_region", replace) firstrow(variables)

* ---- by sector (KBLI 2-digit of the firm) ----
use `dest', clear
egen tag_firm = tag(firm_key year region)
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) exp_value n_products = one n_firms = tag_firm, by(kbli2 region year)
bysort kbli2 year: egen sector_value = total(exp_value)
generate share_in_sector_pct = 100 * exp_value / sector_value
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year region
order kbli2 region period share_in_sector_pct exp_value n_products n_firms
drop year sector_value
export excel using "$B21B_XLSX", sheet("t02_region_by_kbli2", replace) firstrow(variables)
