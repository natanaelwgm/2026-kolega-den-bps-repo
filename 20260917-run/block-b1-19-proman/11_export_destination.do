/*==========================================================================
  Line 11: "Export kemana"
  Data  : Proman roster 2021-2022, exported product rows
          (data/b19_pm_rows.dta)
  Output sheets:
    t11_coverage          % of exported rows / value with a named destination
    t11_destination       per destination country: exported value, % of total,
                          number of rows & firms, pool + by year
    t11_dest_by_sector    destination country x KBLI 2-digit (pool)
  Chart: fig11 (drawn in 12_figures.do)

  NOTES:
  - The roster names ONE (main) destination per product, so all of a
    product's exported value is given to that country.
  - Value shares use rows with a usable export share; rows with a
    destination but no share count in n_rows but add no value.
  - "LAINNYA", "EROPA BARAT LAINNYA" etc. are BPS residual regions, not
    countries. Some 2021 rows give only a country code ("CODE xxx").
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B19_DATA/b19_pm_rows.dta", clear
keep if exported == 1

* ---- coverage: destination reported or not ----
preserve
generate reported = (dest_name != "(not reported)")
generate one = 1
generate val_reported = val_export * reported
collapse (sum) rows = one rows_reported = reported share_unknown val_export val_reported, by(year)
generate pct_rows_reported  = 100 * rows_reported / rows
generate pct_value_reported = 100 * val_reported / val_export
rename share_unknown rows_share_unknown
list, clean noobs
export excel using "$B19_XLSX", sheet("t11_coverage", replace) firstrow(variables)
restore

* from here on: only rows with a reported destination
drop if dest_name == "(not reported)"
egen tag_firm = tag(firm_key year dest_name)      // counts each firm once per country
generate one = 1

* ---- by destination country, by year + pool ----
preserve
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) val_export n_rows = one n_firms = tag_firm, by(dest_name year)
bysort year: egen total = total(val_export)
generate share_pct = 100 * val_export / total
generate period = cond(year == 0, "pool", string(year))
gsort year -share_pct
order period dest_name share_pct val_export n_rows n_firms
drop year total
export excel using "$B19_XLSX", sheet("t11_destination", replace) firstrow(variables)
restore

* ---- destination x KBLI 2-digit sector (pool) ----
collapse (sum) val_export n_rows = one, by(kbli2 dest_name)
bysort kbli2: egen total = total(val_export)
generate share_in_sector_pct = 100 * val_export / total
gsort kbli2 -share_in_sector_pct
drop total
export excel using "$B19_XLSX", sheet("t11_dest_by_sector", replace) firstrow(variables)
