/*==========================================================================
  Line 9: "Untuk setiap group, hitung share thd: firms, employment, VA,
           output, energy, emissions."
  Data  : data/b207_groups.dta, clean == 1, classified firms only (groups 1-7)
  Output sheets:
    t09_shares   per group x period (pool + by year): the totals and each
                 group's share (%) of firms, workers, VA, output, energy (GJ)
                 and emissions (tCO2)

  Denominator: all CLASSIFIED clean firms in that period (groups 1-7), so the
  7 shares of each column add up to 100 within a period. A firm with a
  missing value adds 0 to that column's total.
  NOTE: 2020 and 2022 cannot be classified (see 02-08), so they have no rows
        and "pool" means the other 10 years. VA and output are nominal.
==========================================================================*/
if "$B207" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B207_DATA/b207_groups.dta", clear
keep if clean == 1 & group7 != 99
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms workers va output gj_total co2_total, by(group7 year)

foreach v in n_firms workers va output gj_total co2_total {
    bysort year: egen total = total(`v')
    generate sh_`v' = 100 * `v' / total
    drop total
}
rename sh_n_firms sh_firms
generate period = cond(year == 0, "pool", string(year))
sort year group7
order group7 period n_firms workers va output gj_total co2_total ///
      sh_firms sh_workers sh_va sh_output sh_gj_total sh_co2_total
drop year
list group7 sh_* if period == "pool", clean noobs
export excel using "$B207_XLSX", sheet("t09_shares", replace) firstrow(variables)
