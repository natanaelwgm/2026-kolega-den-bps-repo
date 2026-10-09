/*==========================================================================
  Line 4: "Buat transition matrix 2010-22 dan cek siapa yg successfully
           switch keluar dari high carbon fuel dan siapa yg ttp carbon-locked."
  Data  : data/b205_class.dta (from 03), linked over years by firm_id
  Output: data/b205_pairs.dta        1 row = firm x wave and its class next wave
          data/b205_firm_status.dta  1 row = firm, class in first and last wave
  Output sheets:
    t04_matrix          class this wave (rows) x class next wave (columns), row %,
                        pool + per wave pair (2015 -> 2017 counts as one step)
    t04_switch_rate     among high-carbon firms: % switched out vs % locked
                        next wave; and % of other firms moving INTO high-carbon
    t04_matrix_long     class in the firm's first wave x class in its last wave
                        (the 2010-22 matrix; firms seen in >= 2 waves)
    t04_who_switches    switched out vs carbon-locked (first -> last wave):
                        who are they, measured in their first wave

  Definitions:
    high-carbon      = coal-intensive or oil-intensive (line 3)
    switched out     = high-carbon in the first wave, not in the last wave
    carbon-locked    = high-carbon in the first wave AND in the last wave
  Only firms with energy > 0 have a class; a wave without energy is skipped,
  so a "next wave" pair needs the firm classified in two consecutive waves.

  WARNING: firm_id links across years are FICTIONAL in the development data
  (block 0: panel_id_synthetic = 1). The code runs, but the switching numbers
  only mean something on the real BPS data.
  NOTE: 2019 -> 2020 crosses the new 2020 fuel list (diesel oil, fuel oil,
  natural gas added). Read that pair with care.
  NOTE: "electricity-intensive" is not zero-carbon: Indonesian grid power is
  mostly coal-fired. Here it counts as "out of high-carbon fuel" because the
  firm no longer burns the fuel itself.
==========================================================================*/
if "$B205" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- wave pairs: this wave and the next one ------------------------------
use "$B205_DATA/b205_class.dta", clear
keep if !missing(firm_id)
sort firm_id year
by firm_id: generate next_year  = year[_n + 1]
by firm_id: generate class_next = class[_n + 1]
* the next wave is year + 1, except 2015 -> 2017 (there is no 2016)
generate step = (next_year == year + 1) | (year == 2015 & next_year == 2017)
keep if step == 1
label values class_next class
generate high_next = inlist(class_next, 1, 2)
generate pair = string(year) + "-" + string(next_year)
count
display as result "Firm wave pairs with a class in both waves: " r(N)
save "$B205_DATA/b205_pairs.dta", replace

* ---- A. transition matrix, pool + per wave pair --------------------------
generate n = 1
expand 2, generate(copy)              // copy of every row as "pool"
replace pair = "pool" if copy == 1
collapse (sum) n, by(pair class class_next)
bysort pair class: egen n_from = total(n)
generate pct = 100 * n / n_from
drop n
reshape wide pct, i(pair class n_from) j(class_next)
* a missing cell means no firm made that move -> 0
foreach k in 1 2 3 4 5 6 {
    capture generate pct`k' = 0
    replace pct`k' = 0 if missing(pct`k')
}
rename (pct1 pct2 pct3 pct4 pct5 pct6) (to_coal to_oil to_gas to_elec to_biofuel to_mixed)
generate pool = (pair == "pool")
sort pool pair class
rename class from_class
order pair from_class n_from to_coal to_oil to_gas to_elec to_biofuel to_mixed
drop pool
list if pair == "pool", clean noobs
export excel using "$B205_XLSX", sheet("t04_matrix", replace) firstrow(variables)

* ---- B. switch-out rate, pool + per wave pair ----------------------------
use "$B205_DATA/b205_pairs.dta", clear
generate switched_out = (high_carbon == 1 & high_next == 0) if high_carbon == 1
generate locked       = (high_carbon == 1 & high_next == 1) if high_carbon == 1
generate moved_in     = (high_next == 1) if high_carbon == 0
generate n_pairs = 1
expand 2, generate(copy)
replace pair = "pool" if copy == 1
collapse (sum) n_pairs n_high = high_carbon ///
         (mean) pct_switched_out = switched_out pct_locked = locked pct_moved_in = moved_in, by(pair)
foreach v in pct_switched_out pct_locked pct_moved_in {
    replace `v' = 100 * `v'
}
label variable pct_moved_in "% of NOT high-carbon firms that are high-carbon next wave"
generate pool = (pair == "pool")
sort pool pair
drop pool
list, clean noobs
export excel using "$B205_XLSX", sheet("t04_switch_rate", replace) firstrow(variables)

* ---- C. first wave x last wave per firm (the 2010-22 matrix) -------------
use "$B205_DATA/b205_class.dta", clear
keep if !missing(firm_id)
sort firm_id year
by firm_id: generate n_waves = _N
keep if n_waves >= 2
by firm_id: generate first_year  = year[1]
by firm_id: generate last_year   = year[_N]
by firm_id: generate class_last  = class[_N]
by firm_id: keep if _n == 1               // keep the first wave: its class and characteristics
rename class class_first
label values class_last class
generate high_first = inlist(class_first, 1, 2)
generate high_last  = inlist(class_last, 1, 2)
generate status = .
replace  status = 1 if high_first == 1 & high_last == 0
replace  status = 2 if high_first == 1 & high_last == 1
replace  status = 3 if high_first == 0 & high_last == 1
replace  status = 4 if high_first == 0 & high_last == 0
label define status 1 "Switched out" 2 "Carbon-locked" 3 "Moved into high-carbon" 4 "Never high-carbon"
label values status status
tabulate status
save "$B205_DATA/b205_firm_status.dta", replace

generate n = 1
collapse (sum) n, by(class_first class_last)
bysort class_first: egen n_from = total(n)
generate pct = 100 * n / n_from
drop n
reshape wide pct, i(class_first n_from) j(class_last)
foreach k in 1 2 3 4 5 6 {
    capture generate pct`k' = 0
    replace pct`k' = 0 if missing(pct`k')
}
rename (pct1 pct2 pct3 pct4 pct5 pct6) (to_coal to_oil to_gas to_elec to_biofuel to_mixed)
order class_first n_from
list, clean noobs
export excel using "$B205_XLSX", sheet("t04_matrix_long", replace) firstrow(variables)

* ---- D. who switched out and who stayed locked ---------------------------
* firms that were high-carbon in their first wave; characteristics of that wave
use "$B205_DATA/b205_firm_status.dta", clear
keep if inlist(status, 1, 2)
generate n_firms = 1
generate start_coal = (class_first == 1)
generate years_seen = last_year - first_year
collapse (sum) n_firms (mean) pct_start_coal = start_coal pct_large = large pct_fdi = fdi ///
         pct_exporter = exporter pct_importer = importer pct_java = java pct_owngen = owngen ///
         sh_elec_first = sh_elec mean_years_seen = years_seen ///
         (p50) med_workers = workers med_va_pw = va_pw, by(status)
foreach v in pct_start_coal pct_large pct_fdi pct_exporter pct_importer pct_java pct_owngen {
    replace `v' = 100 * `v'
}
list status n_firms pct_start_coal pct_large pct_fdi pct_exporter pct_java, clean noobs
export excel using "$B205_XLSX", sheet("t04_who_switches", replace) firstrow(variables)
