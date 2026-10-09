/*==========================================================================
  Line 11: "Impor dari mana"
  Data  : Bahan Baku roster 2021-2022, imported material rows
          (data/b18_bb_rows.dta)
  Output sheets:
    t11_coverage          % of imported value whose origin country is reported
    t11_origin            per origin country: imported value, % of total,
                          number of rows & firms, pool + by year
    t11_origin_by_sector  origin country x KBLI 2-digit (pool)
  Chart: fig11 (drawn in 12_figures.do)

  NOTE: in the sample data only a small part of the imported rows report an
  origin country -> check t11_coverage before reading the country shares.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_bb_rows.dta", clear
keep if imported == 1

* ---- coverage: origin country reported or not ----
preserve
generate reported = (origin_name != "(not reported)")
generate one = 1
generate val_reported = val_import * reported
collapse (sum) rows = one rows_reported = reported val_import val_reported, by(year)
generate pct_rows_reported  = 100 * rows_reported / rows
generate pct_value_reported = 100 * val_reported / val_import
list, clean noobs
export excel using "$B18_XLSX", sheet("t11_coverage", replace) firstrow(variables)
restore

* from here on: only rows with a reported origin country
drop if origin_name == "(not reported)"
egen tag_firm = tag(firm_key year origin_name)      // counts each firm once per country
generate one = 1

* ---- by origin country, by year + pool ----
preserve
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) val_import n_rows = one n_firms = tag_firm, by(origin_name year)
bysort year: egen total = total(val_import)
generate share_pct = 100 * val_import / total
generate period = cond(year == 0, "pool", string(year))
gsort year -share_pct
order period origin_name share_pct val_import n_rows n_firms
drop year total
export excel using "$B18_XLSX", sheet("t11_origin", replace) firstrow(variables)
restore

* ---- origin country x KBLI 2-digit sector (pool) ----
collapse (sum) val_import, by(kbli2 origin_name)
bysort kbli2: egen total = total(val_import)
generate share_in_sector_pct = 100 * val_import / total
gsort kbli2 -share_in_sector_pct
drop total
export excel using "$B18_XLSX", sheet("t11_origin_by_sector", replace) firstrow(variables)
