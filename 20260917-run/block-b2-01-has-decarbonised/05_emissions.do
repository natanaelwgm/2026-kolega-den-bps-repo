/*==========================================================================
  Line 5: "Scope 1, 2 and total emissions"
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t05_total      all manufacturing, by year: scope 1, scope 2 and total CO2
                   (tonnes), scope 2 share, index 2010 = 100, ln, and the
                   variants below for comparison
    t05_by_kbli2   the same per KBLI 2-digit sector, plus the sector's % of
                   all manufacturing CO2 in that year

  Headline: scope 1 = the 4 fuels asked in every year (diesel, petrol, coal,
  LPG; 2017 coal corrected); scope 2 = purchased electricity x block 0's grid
  factor (held at the 2014 value after 2014); total = scope 1 + scope 2.
  Variants (never mixed into the headline):
    co2_s1_nine   block 0's nine fuels
    co2_s1_wide   nine fuels + diesel oil, fuel oil, natural gas (asked
                  from 2020 only)
    co2_s2_src    scope 2 on the sourced annual grid factor
  NOTE: sums over firms move with coverage; energy reporting changes between
  2015 and 2017 (questionnaire change). There is no 2016 survey.
==========================================================================*/
if "$B201" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B201_DATA/b201_si.dta", clear
keep if clean == 1
generate n_firms = 1
egen co2_total_nine = rowtotal(co2_s1_nine co2_s2), missing
egen co2_total_wide = rowtotal(co2_s1_wide co2_s2), missing
expand 2, generate(copy)              // copy of every row as sector 0 = all manufacturing
replace kbli2 = 0 if copy == 1
collapse (sum) n_firms co2_s1 co2_s2 co2_total co2_s1_nine co2_s1_wide co2_s2_src ///
         co2_total_nine co2_total_wide, by(kbli2 year)

generate s2_share = co2_s2 / co2_total
foreach v in co2_s1 co2_s2 co2_total {
    egen base = total(cond(year == 2010, `v', .)), by(kbli2)
    generate idx_`v' = 100 * `v' / base if base > 0
    generate ln_`v'  = ln(`v') if `v' > 0
    drop base
}
egen all = total(cond(kbli2 == 0, co2_total, .)), by(year)
generate pct_of_all_co2 = 100 * co2_total / all
drop all
sort kbli2 year
order kbli2 year n_firms co2_s1 co2_s2 co2_total s2_share ///
      idx_co2_s1 idx_co2_s2 idx_co2_total ln_co2_s1 ln_co2_s2 ln_co2_total ///
      co2_s1_nine co2_s1_wide co2_s2_src co2_total_nine co2_total_wide

preserve
keep if kbli2 == 0
drop kbli2 pct_of_all_co2
list year co2_s1 co2_s2 co2_total co2_total_nine co2_total_wide, clean noobs
export excel using "$B201_XLSX", sheet("t05_total", replace) firstrow(variables)
restore
keep if kbli2 > 0
export excel using "$B201_XLSX", sheet("t05_by_kbli2", replace) firstrow(variables)
