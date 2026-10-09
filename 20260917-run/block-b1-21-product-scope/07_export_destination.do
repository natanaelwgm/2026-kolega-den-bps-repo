/*==========================================================================
  Line 7: "Export destination."
  Data  : Proman roster rows 2021-2022 (data/b21_pm_rows.dta)
          one (main) destination country per exported product line
  Export value of a line = production value x export share / 100.
  Output sheets:
    t07_coverage     exported lines and % with a reported destination
    t07_dest         export value and % of export value by destination,
                     pool + by year (only lines with a reported destination)
    t07_n_dest       firm level, exporters only: number of destinations
    t07_dest_kbli2   top 3 destinations of each KBLI 2-digit sector, pooled
  NOTE: only the MAIN destination of each product line is recorded, so a
        firm's number of destinations is a lower bound. The destination
        structure itself is analysed in block B1-21b.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. coverage ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if exported == 1
generate n_exported_lines = 1
generate reported = (dest_name != "(not reported)")
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_exported_lines (mean) pct_dest_reported = reported, by(year)
replace pct_dest_reported = 100 * pct_dest_reported
generate period = cond(year == 0, "pool", string(year))
keep period n_exported_lines pct_dest_reported
order period
list, clean noobs
export excel using "$B21_XLSX", sheet("t07_coverage", replace) firstrow(variables)

* ---- B. destinations ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if exported == 1 & dest_name != "(not reported)"
generate n_lines = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_lines val_export, by(dest_name year)
bysort year: egen total = total(val_export)
generate share_pct = 100 * val_export / total
generate period = cond(year == 0, "pool", string(year))
gsort year -val_export
keep period dest_name n_lines val_export share_pct
order period dest_name
list if period == "pool" in 1/10, clean noobs
export excel using "$B21_XLSX", sheet("t07_dest", replace) firstrow(variables)

* ---- C. number of destinations per exporting firm ----
use "$B21_DATA/b21_pm_firm.dta", clear
keep if exporter == 1
do "$B21/_sumstats.do" "n_dest" "" "t07_n_dest"

* ---- D. main destinations by sector (pooled) ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if exported == 1 & dest_name != "(not reported)"
collapse (sum) val_export, by(kbli2 dest_name)
bysort kbli2: egen total = total(val_export)
generate share_pct = 100 * val_export / total
gsort kbli2 -val_export
by kbli2: generate rank = _n
keep if rank <= 3
keep kbli2 rank dest_name share_pct val_export
export excel using "$B21_XLSX", sheet("t07_dest_kbli2", replace) firstrow(variables)
