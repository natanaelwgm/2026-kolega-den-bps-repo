/*==========================================================================
  Line 7: "Bandingkan share mereka thd output, VA, employment dan export."
  Data  : data/b203_ranked.dta (from 02-06): clean == 1, plants ranked by CO2
          within each year
  Output sheets:
    t07_other_shares   % of the year's total CO2, output, value added,
                       workers, exporters and export value held by the top
                       1/5/10/20% of emitters, pool + by year
    t07_exporter_rate  % exporters within each emitter band, pool + by year
  Denominator: ALL clean plants of the year, including plants with no CO2
  (they are never in a top group). CO2 is therefore the same as in
  t02_06_top_shares.

  NOTE (export): block 0 has no export value column.
    - "Exporters (count)": share of the year's exporters (export_flag == 1)
      that are top emitters. 2022 is missing: the 2022 form asks only about
      direct exports, so the flag is set missing in 01a.
    - "Export value (est.)": export share x output, only where the reported
      export share is valid: about 6% of records, none in 2015, 2017, 2022.
      Read it as indicative only.
  Output and value added are nominal; shares within a year are not affected.
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. share of each total held by the top emitters ----
tempfile stack
local i 0
foreach m in co2_total output va workers exporter export_val {
    local ++i
    use "$B203_DATA/b203_ranked.dta", clear
    keep if !missing(`m')
    foreach p in 1 5 10 20 {
        generate top`p'_m = `m' * top`p'
    }
    generate n_obs = 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_obs total = `m' top1_m top5_m top10_m top20_m, by(year)
    foreach p in 1 5 10 20 {
        generate share_top`p' = 100 * top`p'_m / total
    }
    generate m_order = `i'
    generate variable = "`m'"
    if `i' > 1 append using `stack'
    save `stack', replace
}
generate measure = ""
replace measure = "CO2"                 if variable == "co2_total"
replace measure = "Output"              if variable == "output"
replace measure = "Value added"         if variable == "va"
replace measure = "Workers"             if variable == "workers"
replace measure = "Exporters (count)"   if variable == "exporter"
replace measure = "Export value (est.)" if variable == "export_val"
generate period = cond(year == 0, "pool", string(year))
sort m_order year
order measure variable period n_obs share_top1 share_top5 share_top10 share_top20 total
keep  measure variable period n_obs share_top1 share_top5 share_top10 share_top20 total
label variable n_obs "Plants with this measure observed"
label variable total "Year total of the measure (count for Exporters)"
list measure period share_top1 share_top5 share_top10 share_top20 if period == "pool" | period == "2022", clean noobs
export excel using "$B203_XLSX", sheet("t07_other_shares", replace) firstrow(variables)

* ---- B. exporter rate within each emitter band ----
use "$B203_DATA/b203_ranked.dta", clear
keep if !missing(exporter)
generate band = 5
replace  band = 4 if top20 == 1
replace  band = 3 if top10 == 1
replace  band = 2 if top5 == 1
replace  band = 1 if top1 == 1
replace  band = 6 if emitter == 0
label define band 1 "Top 1%" 2 "Top 1-5%" 3 "Top 5-10%" 4 "Top 10-20%" ///
                  5 "Bottom 80%" 6 "No CO2 reported"
label values band band
generate n_plants = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_plants (mean) pct_exporter = exporter, by(band year)
replace pct_exporter = 100 * pct_exporter
generate period = cond(year == 0, "pool", string(year))
sort band year
order band period n_plants pct_exporter
drop year
list if period == "pool", clean noobs
export excel using "$B203_XLSX", sheet("t07_exporter_rate", replace) firstrow(variables)
