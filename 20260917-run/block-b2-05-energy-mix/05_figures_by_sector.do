/*==========================================================================
  Line 5: "Grafik by sectors"
  This line is also the block's figures file, so it runs LAST in 00_run.do.
  Part A builds the by-sector tables (KBLI 2-digit). Part B draws every chart
  FROM the Excel sheets, so a chart always matches its table, and writes the
  exact plotted points of each chart to a sheet figNN_data.

  Data  : data/b205_mix.dta (02), b205_class.dta (03), b205_pairs.dta (04)
  Output sheets (part A):
    t05_mix_by_kbli2     mean firm share (%) of each source, per sector,
                         pool + by year
    t05_class_by_kbli2   % of firms per class, per sector, pool + by year
    t05_switch_by_kbli2  high-carbon firms: % switched out / locked next wave,
                         per sector (pooled wave pairs)
  Charts (output/):
    fig02_energy_mix_by_year.png   mean firm energy mix, by year (line 2)
    fig03_class_by_year.png        % of firms per class, by year (line 3)
    fig04_switch_rate.png          switch-out and move-in rates per wave pair (line 4)
    fig05_mix_by_sector.png        energy mix per sector, pooled
    fig05_class_by_sector.png      classes per sector, pooled
    fig05_switch_by_sector.png     switch-out rate per sector, pooled
  NOTE: pooled sector charts mix the pre- and post-2020 forms (the 2020 form
  added diesel oil, fuel oil and natural gas). The yearly rows are in the tables.
  NOTE: fig04 and fig05_switch use firm_id links, which are FICTIONAL in the
  development data.
==========================================================================*/
if "$B205" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* KBLI 2-digit names for the sector tables and charts. Kept in a local because
* "use ..., clear" drops label definitions; "label define kbli2 `kbli2lab'"
* is repeated after each collapse below.
local kbli2lab `"10 "10 Food" 11 "11 Beverages" 12 "12 Tobacco" 13 "13 Textiles" 14 "14 Apparel" 15 "15 Leather" 16 "16 Wood" 17 "17 Paper" 18 "18 Printing" 19 "19 Coke, refined petroleum" 20 "20 Chemicals" 21 "21 Pharmaceuticals" 22 "22 Rubber, plastics" 23 "23 Non-metallic minerals" 24 "24 Basic metals" 25 "25 Metal products" 26 "26 Electronics" 27 "27 Electrical equipment" 28 "28 Machinery" 29 "29 Motor vehicles" 30 "30 Other transport" 31 "31 Furniture" 32 "32 Other manufacturing" 33 "33 Repair, installation""'

* ======================= A. tables by sector ==============================

* ---- energy mix per sector ----
use "$B205_DATA/b205_mix.dta", clear
keep if has_energy == 1 & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio sh_elec, by(kbli2 year)
label define kbli2 `kbli2lab', replace
label values kbli2 kbli2
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms
drop year
export excel using "$B205_XLSX", sheet("t05_mix_by_kbli2", replace) firstrow(variables)

* ---- classes per sector ----
use "$B205_DATA/b205_class.dta", clear
keep if !missing(kbli2)
generate n_firms = 1
generate is_coal = (class == 1)
generate is_oil  = (class == 2)
generate is_gas  = (class == 3)
generate is_elec = (class == 4)
generate is_bio  = (class == 5)
generate is_mix  = (class == 6)
generate is_high = high_carbon
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_coal = is_coal pct_oil = is_oil pct_gas = is_gas ///
         pct_elec = is_elec pct_biofuel = is_bio pct_mixed = is_mix pct_high_carbon = is_high, by(kbli2 year)
foreach v in pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed pct_high_carbon {
    replace `v' = 100 * `v'
}
label define kbli2 `kbli2lab', replace
label values kbli2 kbli2
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms
drop year
export excel using "$B205_XLSX", sheet("t05_class_by_kbli2", replace) firstrow(variables)

* ---- switching out of high-carbon per sector (pooled wave pairs) ----
use "$B205_DATA/b205_pairs.dta", clear
keep if high_carbon == 1 & !missing(kbli2)
generate n_high = 1
generate switched_out = (high_next == 0)
generate locked       = (high_next == 1)
collapse (sum) n_high (mean) pct_switched_out = switched_out pct_locked = locked, by(kbli2)
replace pct_switched_out = 100 * pct_switched_out
replace pct_locked       = 100 * pct_locked
label define kbli2 `kbli2lab', replace
label values kbli2 kbli2
export excel using "$B205_XLSX", sheet("t05_switch_by_kbli2", replace) firstrow(variables)

* ======================= B. charts from the sheets ========================

* ---- fig02: energy mix by year (line 2) ----
import excel using "$B205_XLSX", sheet("t02_mix_mean") firstrow clear
drop if period == "pool"
keep period sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio
export excel using "$B205_XLSX", sheet("fig02_data", replace) firstrow(variables)
graph bar (asis) sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio, over(period) stack ///
    ytitle("Mean share of the firm's energy (%)") ///
    legend(order(1 "Coal" 2 "Oil (diesel, petrol, fuel oil)" 3 "Gas / LPG" ///
                 4 "Electricity PLN" 5 "Electricity non-PLN" 6 "Biodiesel") rows(2) size(small)) ///
    title("Firm energy mix by year") ///
    note("Own generation and biomass are not in the mix (see 02). No survey in 2016." ///
         "Diesel oil, fuel oil and natural gas are asked from 2020 only.", size(vsmall)) ///
    graphregion(color(white))
graph export "$B205_OUT/fig02_energy_mix_by_year.png", replace width(2000)

* ---- fig03: classes by year (line 3) ----
import excel using "$B205_XLSX", sheet("t03_class_by_year") firstrow clear
drop if period == "pool"
generate k = ""
replace k = "coal"    if class == "Coal-intensive"
replace k = "oil"     if class == "Oil-intensive"
replace k = "gas"     if class == "Gas-intensive"
replace k = "elec"    if class == "Electricity-intensive"
replace k = "biofuel" if class == "Biofuel-intensive"
replace k = "mixed"   if class == "Mixed"
keep period k pct_firms
reshape wide pct_firms, i(period) j(k) string
rename pct_firms* pct_*
foreach v in pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed {
    capture generate `v' = 0
    replace `v' = 0 if missing(`v')
}
order period pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed
export excel using "$B205_XLSX", sheet("fig03_data", replace) firstrow(variables)
graph bar (asis) pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed, over(period) stack ///
    ytitle("% of firms") ///
    legend(order(1 "Coal-intensive" 2 "Oil-intensive" 3 "Gas-intensive" ///
                 4 "Electricity-intensive" 5 "Biofuel-intensive" 6 "Mixed") rows(2) size(small)) ///
    title("Firms by main energy source (>= 50% of GJ)") ///
    note("No survey in 2016. The 2020 form adds diesel oil, fuel oil and natural gas.", size(vsmall)) ///
    graphregion(color(white))
graph export "$B205_OUT/fig03_class_by_year.png", replace width(2000)

* ---- fig04: switching out of high-carbon, per wave pair (line 4) ----
import excel using "$B205_XLSX", sheet("t04_switch_rate") firstrow clear
drop if pair == "pool"
keep pair pct_switched_out pct_locked pct_moved_in
export excel using "$B205_XLSX", sheet("fig04_data", replace) firstrow(variables)
graph bar (asis) pct_switched_out pct_moved_in, over(pair, label(angle(45) labsize(small))) ///
    ytitle("% of firms") ///
    legend(order(1 "High-carbon firms that switch out next wave" ///
                 2 "Other firms that move into high-carbon") rows(2) size(small)) ///
    title("Switching out of coal/oil, wave to wave") ///
    note("High-carbon = coal- or oil-intensive. Firm links are FICTIONAL in the development data." ///
         "2015-2017 spans the missing 2016 survey; 2019-2020 crosses the new 2020 fuel list.", size(vsmall)) ///
    graphregion(color(white))
graph export "$B205_OUT/fig04_switch_rate.png", replace width(2000)

* ---- fig05a: energy mix by sector, pooled (line 5) ----
import excel using "$B205_XLSX", sheet("t05_mix_by_kbli2") firstrow clear
keep if period == "pool"
keep kbli2 sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio n_firms
export excel using "$B205_XLSX", sheet("fig05_mix_data", replace) firstrow(variables)
graph hbar (asis) sh_coal sh_oil sh_gas sh_pln sh_nonpln sh_bio, ///
    over(kbli2, label(labsize(vsmall))) stack ///
    ytitle("Mean share of the firm's energy (%)") ///
    legend(order(1 "Coal" 2 "Oil" 3 "Gas / LPG" 4 "Electricity PLN" ///
                 5 "Electricity non-PLN" 6 "Biodiesel") rows(2) size(vsmall)) ///
    title("Energy mix by sector, pooled 2010-2022", size(medium)) ///
    graphregion(color(white) margin(l+2 r+4)) ysize(7) xsize(10)
graph export "$B205_OUT/fig05_mix_by_sector.png", replace width(2000)

* ---- fig05b: classes by sector, pooled ----
import excel using "$B205_XLSX", sheet("t05_class_by_kbli2") firstrow clear
keep if period == "pool"
keep kbli2 pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed pct_high_carbon n_firms
export excel using "$B205_XLSX", sheet("fig05_class_data", replace) firstrow(variables)
graph hbar (asis) pct_coal pct_oil pct_gas pct_elec pct_biofuel pct_mixed, ///
    over(kbli2, label(labsize(vsmall))) stack ///
    ytitle("% of firms") ///
    legend(order(1 "Coal-intensive" 2 "Oil-intensive" 3 "Gas-intensive" ///
                 4 "Electricity-intensive" 5 "Biofuel-intensive" 6 "Mixed") rows(2) size(vsmall)) ///
    title("Main energy source by sector, pooled 2010-2022", size(medium)) ///
    graphregion(color(white) margin(l+2 r+4)) ysize(7) xsize(10)
graph export "$B205_OUT/fig05_class_by_sector.png", replace width(2000)

* ---- fig05c: switching out of high-carbon by sector ----
import excel using "$B205_XLSX", sheet("t05_switch_by_kbli2") firstrow clear
keep kbli2 pct_switched_out pct_locked n_high
export excel using "$B205_XLSX", sheet("fig05_switch_data", replace) firstrow(variables)
graph hbar (asis) pct_switched_out, over(kbli2, sort(1) descending label(labsize(vsmall))) ///
    ytitle("% of high-carbon firms that are not high-carbon next wave") ///
    title("Switching out of coal/oil by sector, pooled wave pairs", size(medium)) ///
    note("High-carbon = coal- or oil-intensive. Firm links are FICTIONAL in the development data.", size(vsmall)) ///
    graphregion(color(white) margin(l+2 r+4)) ysize(7) xsize(10)
graph export "$B205_OUT/fig05_switch_by_sector.png", replace width(2000)
graph drop _all
