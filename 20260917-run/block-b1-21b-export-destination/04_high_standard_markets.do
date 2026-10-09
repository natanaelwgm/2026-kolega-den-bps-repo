/*==========================================================================
  Line 4: "Compare characteristics firms exporting ke advanced/high
           environmental standard market vs to other market à untuk
           mengetahuin foreign climate pressure."
  Data  : Proman roster 2021-2022 (data/b21b_pm_rows.dta) for the market
          groups; SI 2021-2022 (data/b21b_si.dta), clean == 1, for the
          firm characteristics
  High-standard market = EU-27 + EFTA (Iceland, Liechtenstein, Norway,
  Switzerland), decided 9 Oct 2026. Everything else = other markets.

  Groups (exporting firms with a named destination):
    hs_market  1 "EU+EFTA"        exports at least one product to EU+EFTA
               0 "Other only"     exports, but none to EU+EFTA
    mkt3       EU+EFTA only / both / other only (shows the overlap)
    hs_share   % of the firm's export value going to EU+EFTA

  MERGE RULE (roster -> SI): the roster has no usable firm id (Kipb masked),
  so the group is set per CELL = year x province x KBLI5. Every SI firm
  (clean == 1) in a cell that exports gets that cell's group; SI firms in
  cells with no exports are left out. Cells mix exporters and
  non-exporters, so t04_si_char_exp repeats the comparison for SI firms
  that report exporting themselves (2021 only: the 2022 SI export flag is
  missing). With the real data, merge on Kipb instead.

  Output sheets:
    t04_groups        number of exporting firms per group, mean hs_share
    t04_roster_char   roster side: products, production & export value,
                      export intensity, destinations, by hs_market
    t04_si_match      cells per group and how many SI firms they hold
    t04_si_char       SI characteristics (size, productivity, TFP, energy,
                      CO2), level and ln, by hs_market, pool + by year
    t04_si_char_exp   the same, SI exporters only (2021)
    t04_si_shares     % FDI, importer, large, Java, SI exporter, by hs_market
  Chart: fig04 (drawn in 05_figures.do)

  NOTE: Proman gives ONE main destination per product, so "exports to
  EU+EFTA" means EU+EFTA is the main destination of at least one product.
  Values are nominal and masked.
==========================================================================*/
if "$B21B" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
* ---- roster side: one row per firm x year ----
use "$B21B_DATA/b21b_pm_rows.dta", clear
label define hs_market 0 "Other only" 1 "EU+EFTA"
label define mkt3 1 "EU+EFTA only" 2 "Both" 3 "Other only"
generate one = 1
generate with_dest = (dest_country != "")
generate v_hs = exp_value * high_std
collapse (sum) n_products = one val_prod exp_value v_hs n_exp_products = with_dest ///
         (max) any_hs = high_std (min) min_hs = high_std, by(firm_key year)
keep if n_exp_products > 0                  // exporting firms with a destination
generate hs_market = any_hs
generate mkt3 = cond(min_hs == 1, 1, cond(any_hs == 1, 2, 3))
label values hs_market hs_market
label values mkt3 mkt3
generate hs_share      = 100 * v_hs / exp_value if exp_value > 0
generate exp_intensity = 100 * exp_value / val_prod if val_prod > 0
generate ln_val_prod   = ln(val_prod)  if val_prod > 0
generate ln_exp_value  = ln(exp_value) if exp_value > 0
merge 1:1 firm_key year using "$B21B_DATA/b21b_firm_conc.dta", keepusing(n_dest) keep(master match) nogenerate
label variable hs_share      "% of export value to EU+EFTA"
label variable exp_intensity "Export value / production value (%)"

* groups
preserve
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) mean_hs_share = hs_share, by(mkt3 year)
bysort year: egen total = total(n_firms)
generate pct_firms = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort year mkt3
order mkt3 period n_firms pct_firms mean_hs_share
drop year total
list if period == "pool", clean noobs
export excel using "$B21B_XLSX", sheet("t04_groups", replace) firstrow(variables)
restore

do "$B21B/_sumstats.do" "n_products val_prod ln_val_prod exp_value ln_exp_value exp_intensity n_dest hs_share" "hs_market" "t04_roster_char"

* ---- the cell groups, for the merge with SI ----
use "$B21B_DATA/b21b_pm_rows.dta", clear
keep if dest_country != ""
collapse (max) hs_market = high_std, by(year prov kbli5)
label define hs_market 0 "Other only" 1 "EU+EFTA", replace
label values hs_market hs_market
save "$B21B_DATA/b21b_cells.dta", replace

* ---- SI firms in those cells ----
use "$B21B_DATA/b21b_si.dta", clear
keep if inlist(year, 2021, 2022) & clean == 1
merge m:1 year prov kbli5 using "$B21B_DATA/b21b_cells.dta"
* _merge: 1 = SI firm in a cell without exports, 2 = cell with no SI firm, 3 = matched
preserve
keep if _merge != 1                         // exporting cells and their SI firms
generate si_firm = (_merge == 3)
bysort year prov kbli5: egen n_si = total(si_firm)
egen tag_cell = tag(year prov kbli5)
generate cell_with_si = tag_cell * (n_si > 0)
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_cells = tag_cell n_cells_with_si = cell_with_si n_si_firms = si_firm, by(hs_market year)
generate pct_cells_with_si = 100 * n_cells_with_si / n_cells
generate period = cond(year == 0, "pool", string(year))
sort year hs_market
order hs_market period n_cells n_cells_with_si pct_cells_with_si n_si_firms
drop year
list, clean noobs
export excel using "$B21B_XLSX", sheet("t04_si_match", replace) firstrow(variables)
restore

keep if _merge == 3
drop _merge
save "$B21B_DATA/b21b_si_matched.dta", replace

local chars "workers ln_workers output ln_output va ln_va va_pw ln_va_pw cap_pw ln_cap_pw tfp_lp tfp_acf tfp_wrdg tfp_op export_share co2_total ln_co2_total gj_total ln_gj_total co2_per_va ln_co2_per_va gj_per_va ln_gj_per_va"
do "$B21B/_sumstats.do" "`chars'" "hs_market" "t04_si_char"

* yes/no characteristics: % of SI firms
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms (mean) pct_fdi = fdi pct_importer = importer pct_large = large ///
         pct_java = java pct_si_exporter = exporter, by(hs_market year)
foreach v in pct_fdi pct_importer pct_large pct_java pct_si_exporter {
    replace `v' = 100 * `v'
}
generate period = cond(year == 0, "pool", string(year))
sort year hs_market
order hs_market period n_firms
drop year
list, clean noobs
export excel using "$B21B_XLSX", sheet("t04_si_shares", replace) firstrow(variables)

* SI firms that are exporters themselves (2021 only)
use "$B21B_DATA/b21b_si_matched.dta", clear
keep if exporter == 1
do "$B21B/_sumstats.do" "`chars'" "hs_market" "t04_si_char_exp"
