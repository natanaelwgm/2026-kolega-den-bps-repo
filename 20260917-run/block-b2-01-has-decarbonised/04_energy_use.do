/*==========================================================================
  Line 4: "Total energy use"
  Data  : SI 2010-2022 (data/b201_si.dta), clean == 1
  Output sheets:
    t04_total      all manufacturing, by year: total energy (GJ) = scope 1
                   fuels (gj_s1) + purchased electricity (gj_s2); index
                   2010 = 100; ln; and two wider fuel variants for comparison
    t04_by_kbli2   the same per KBLI 2-digit sector, plus the sector's % of
                   all manufacturing energy in that year

  Headline: gj_s1 = the 4 fuels asked in every year (diesel, petrol, coal,
  LPG), 2017 coal corrected. Own-generated electricity is not added (its fuel
  is already counted).
  Variants (columns gj_s1_nine, gj_s1_wide, gj_total_wide):
    gj_s1_nine  block 0's nine fuels (adds kerosene, gas, briquettes, coke)
    gj_s1_wide  nine fuels + diesel oil, fuel oil, natural gas, which the
                questionnaire only asks from 2020. The gap between headline
                and wide in 2020-2022 is mostly natural gas.
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
generate n_energy = (gj_total > 0 & !missing(gj_total))   // firms reporting any energy
egen gj_total_wide = rowtotal(gj_s1_wide gj_s2), missing
expand 2, generate(copy)              // copy of every row as sector 0 = all manufacturing
replace kbli2 = 0 if copy == 1
collapse (sum) n_firms n_energy gj_s1 gj_s2 gj_total gj_s1_nine gj_s1_wide gj_total_wide, by(kbli2 year)

generate pct_firms_energy = 100 * n_energy / n_firms
generate s2_share = gj_s2 / gj_total
foreach v in gj_s1 gj_s2 gj_total {
    egen base = total(cond(year == 2010, `v', .)), by(kbli2)
    generate idx_`v' = 100 * `v' / base if base > 0
    generate ln_`v'  = ln(`v') if `v' > 0
    drop base
}
egen all = total(cond(kbli2 == 0, gj_total, .)), by(year)
generate pct_of_all_gj = 100 * gj_total / all
drop all
sort kbli2 year
order kbli2 year n_firms n_energy pct_firms_energy gj_s1 gj_s2 gj_total s2_share ///
      idx_gj_s1 idx_gj_s2 idx_gj_total ln_gj_s1 ln_gj_s2 ln_gj_total ///
      gj_s1_nine gj_s1_wide gj_total_wide

preserve
keep if kbli2 == 0
drop kbli2 pct_of_all_gj
list year n_firms gj_s1 gj_s2 gj_total gj_total_wide, clean noobs
export excel using "$B201_XLSX", sheet("t04_total", replace) firstrow(variables)
restore
keep if kbli2 > 0
export excel using "$B201_XLSX", sheet("t04_by_kbli2", replace) firstrow(variables)
