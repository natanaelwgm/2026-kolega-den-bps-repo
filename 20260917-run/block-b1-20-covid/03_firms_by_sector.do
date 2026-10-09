/*==========================================================================
  Line 3: "Number of firms by sectors"
  Data  : SI 2010-2022 (data/b20_si.dta), ALL rows (a count of firms, so the
          energy-outlier flag is not applied; clean == 0 firms still existed)
  Output sheets:
    t03_by_sector_year   n firms per KBLI 2-digit x year, and the sector's
                         share of the year's firms (%). period "pool" = all
                         firm-years 2010-2022 added up
    t03_covid_change     per KBLI 2-digit: average firms per year in
                         2017-19, firms in 2020, average per year in 2021-22,
                         and the % change vs 2017-19
  NOTE: this is the number of firms in the survey (cross-sections), no firm
        links. A change can be a sample change, not firms closing.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. firms per sector and year ----
use "$B20_DATA/b20_si.dta", clear
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(kbli2 year)
bysort year: egen year_total = total(n_firms)
generate pct_of_year = 100 * n_firms / year_total
drop year_total
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms pct_of_year
drop year
export excel using "$B20_XLSX", sheet("t03_by_sector_year", replace) firstrow(variables)

* ---- B. covid change per sector ----
use "$B20_DATA/b20_si.dta", clear
keep if !missing(period)
generate n_firms = 1
collapse (sum) n_firms, by(kbli2 period)
reshape wide n_firms, i(kbli2) j(period)
* a sector with no firm in a period has 0 firms there
foreach p in 1 2 3 {
    replace n_firms`p' = 0 if missing(n_firms`p')
}
generate firms_pre_avg   = n_firms1 / 3       // 2017, 2018, 2019
generate firms_2020      = n_firms2
generate firms_rec_avg   = n_firms3 / 2       // 2021, 2022
generate pct_chg_2020    = 100 * (firms_2020 / firms_pre_avg - 1)    if firms_pre_avg > 0
generate pct_chg_rec     = 100 * (firms_rec_avg / firms_pre_avg - 1) if firms_pre_avg > 0
drop n_firms1 n_firms2 n_firms3
* add a total row (kbli2 = 0 = all sectors)
set obs `=_N + 1'
replace kbli2 = 0 in L
foreach v in firms_pre_avg firms_2020 firms_rec_avg {
    quietly summarize `v'
    replace `v' = r(sum) in L
}
replace pct_chg_2020 = 100 * (firms_2020 / firms_pre_avg - 1)    in L
replace pct_chg_rec  = 100 * (firms_rec_avg / firms_pre_avg - 1) in L
label define kbli2_all 0 "All sectors"
label values kbli2 kbli2_all
sort kbli2
list, clean noobs
export excel using "$B20_XLSX", sheet("t03_covid_change", replace) firstrow(variables)
