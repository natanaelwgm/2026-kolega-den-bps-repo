/*==========================================================================
  Line 1 (part b): "What happened during covid:"
  Firm panel: one row per firm_id, with the survey years it is present in.
  Lines 4-7 and 9-16 use these links.
  Input : data/b20_si.dta (ALL rows: a firm flagged clean == 0 still existed
          that year, so presence is counted on every record)
  Output: data/b20_firm.dta  -- 1 row = 1 firm_id
            in2010 ... in2022   1 = firm present in that survey year
            first_year last_year n_years
            n_missing          survey years missing between first and last
                               (> 0 = the firm disappeared and came back)
  Output sheet:
    t01_firm_panel   firms by number of years present, and how many of them
                     have a gap (missing in a year between first and last)

  FIRM LINKS ARE FICTIONAL IN THE DEVELOPMENT DATA. Block 0 simulated the
  firm_id links: every firm is present in an unbroken run of survey years,
  so no firm ever has a gap (n_missing = 0 for all). That is why "disappear
  temporarily then return" (line 12) is empty in the development data. It is
  a property of the simulated links, not a finding. On the real BPS data the
  same code counts real gaps.
  NOTE: 2016 has no wave, so 2015 -> 2017 is NOT counted as a gap.
==========================================================================*/
if "$B20" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B20_DATA/b20_si.dta", clear
keep firm_id year
isid firm_id year                     // 1 row per firm per year, or stop

* ---- presence in each survey year -------------------------------------
foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
    generate in`y' = (year == `y')
}
generate first_year = year
generate last_year  = year
generate n_years    = 1
collapse (max) in2010-in2022 last_year (min) first_year (sum) n_years, by(firm_id)

* survey years between first and last (2016 is not a survey year)
generate span = last_year - first_year + 1
replace  span = span - 1 if first_year <= 2015 & last_year >= 2017
generate n_missing = span - n_years
drop span
label variable n_missing "Survey years missing between first and last year present"
compress
save "$B20_DATA/b20_firm.dta", replace

count
display as result "Firms (firm_id): " r(N)
count if n_missing > 0
display as result "Firms with a gap (gone, then back): " r(N)

* ---- table: years present and gaps ------------------------------------
generate n_firms = 1
generate with_gap = (n_missing > 0)
collapse (sum) n_firms with_gap, by(n_years)
egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
drop total
order n_years n_firms pct_firms with_gap
list, clean noobs
export excel using "$B20_XLSX", sheet("t01_firm_panel", replace) firstrow(variables)
