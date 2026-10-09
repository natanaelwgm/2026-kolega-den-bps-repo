/*==========================================================================
  Lines 4-6: "Siapa yg baru??" / "Siapa yg mati??" / "Siapa yg bertahan?"
  Data  : SI 2010-2022 (data/b20_si.dta), ALL rows (presence is not a
          measurement: a firm with clean == 0 still existed that year)

  Definitions, for a firm present in survey year Y (on firm_id x year):
    NEW (baru)        not present in the previous survey year
                      (of which RETURNING = was present in some earlier year)
    SURVIVOR          also present in the previous survey year
      (bertahan)      -> every firm in Y is either NEW or SURVIVOR
    EXIT (mati)       never present again in any later survey year
                      (Y = 2019 exits = gone from 2020 onward: the covid exits)
    TEMPORARY EXIT    absent in the next survey year but back later
  "Previous / next survey year": 2016 has no wave, so 2015 and 2017 are
  treated as consecutive.
  Window edges: NEW/SURVIVOR is not defined in 2010 (no earlier year) and
  EXIT is not defined in 2022 (no later year); those cells are left empty.

  Output: data/b20_flows.dta  firm_id year status exit_status (used by line 7)
  Output sheet:
    t04_flows_by_year   per year: n firms, n and % new (of which returning),
                        survivor, exit, temporary exit. "pool" = 2011-2021
                        firm-years added up

  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA: these counts only mean
  something on the real BPS data. In the development data no firm ever
  comes back after a gap, so "returning" and "temporary exit" are 0 (see 01b).
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B20_DATA/b20_si.dta", clear
keep firm_id year prev_year next_year
sort firm_id year

* year this firm was seen before / after this one (missing = never)
by firm_id: generate seen_before = year[_n-1]
by firm_id: generate seen_after  = year[_n+1]

* ---- new vs survivor --------------------------------------------------
generate status = .
replace  status = 1 if year > 2010 & seen_before != prev_year & missing(seen_before)
replace  status = 2 if year > 2010 & seen_before != prev_year & !missing(seen_before)
replace  status = 3 if year > 2010 & seen_before == prev_year
label define status 1 "New (first time seen)" 2 "New (returning after a gap)" 3 "Survivor (also in previous year)"
label values status status

* ---- exit -------------------------------------------------------------
generate exit_status = .
replace  exit_status = 1 if year < 2022 & missing(seen_after)
replace  exit_status = 2 if year < 2022 & !missing(seen_after) & seen_after != next_year
replace  exit_status = 3 if year < 2022 & seen_after == next_year
label define exit_status 1 "Exit (never seen again)" 2 "Temporary exit (back later)" 3 "Stays (in next year)"
label values exit_status exit_status

keep firm_id year status exit_status
compress
save "$B20_DATA/b20_flows.dta", replace

* ---- counts by year ---------------------------------------------------
generate n_firms   = 1
generate new       = inlist(status, 1, 2) if !missing(status)
generate returning = (status == 2)        if !missing(status)
generate survivor  = (status == 3)        if !missing(status)
generate exit      = (exit_status == 1)   if !missing(exit_status)
generate temp_exit = (exit_status == 2)   if !missing(exit_status)
foreach v in new returning survivor exit temp_exit {
    generate pct_`v' = `v'
}
expand 2, generate(copy)              // copy with year = 0 for "pool"
replace year = 0 if copy == 1
* the pool only uses 2011-2021, where both new and exit are defined
drop if copy == 1 & (missing(status) | missing(exit_status))
collapse (sum) n_firms new returning survivor exit temp_exit ///
         (mean) pct_new pct_returning pct_survivor pct_exit pct_temp_exit, by(year)
foreach v in new returning survivor exit temp_exit {
    replace pct_`v' = 100 * pct_`v'
    * not defined at the window edges
    replace `v' = . if missing(pct_`v')
}
generate period = cond(year == 0, "pool", string(year))
sort year
order period n_firms new pct_new returning survivor pct_survivor exit pct_exit temp_exit pct_temp_exit
drop year pct_returning
list, clean noobs
export excel using "$B20_XLSX", sheet("t04_flows_by_year", replace) firstrow(variables)
