/*==========================================================================
  Line 10: "Question: Apakah Indonesia sebenernya hanya perlu menarget
            relatively small number of highly polluting plants?"
  Data  : data/b203_ranked.dta (from 02-06) + the sheets of lines 2-9
  Output sheets:
    t10_plants_needed  how many plants (and what % of emitting plants)
                       together hold 50%, 75% and 90% of the year's CO2,
                       by year
    t10_evidence       one row per period: what the top 1% and top 10% of
                       emitters hold of CO2, output, VA and workers, plus
                       the Gini (collected from t02_06, t07 and t09)

  How to read it: if a few hundred plants hold most of the CO2 but a much
  smaller share of output, VA and jobs, targeting them covers most emissions
  at a limited cost to the economy. Caveats: development data (masked
  values, fictional firm links); the unit is the plant-year.
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. plants needed for 50 / 75 / 90% of CO2 ----
use "$B203_DATA/b203_ranked.dta", clear
keep if emitter == 1
* rank is 1 = largest emitter (from 02-06)
sort year rank
by year: egen total = total(co2_total)
by year: generate cum_share = 100 * sum(co2_total) / total
foreach s in 50 75 90 {
    by year: egen n_for_`s' = min(cond(cum_share >= `s', rank, .))
}
collapse (first) n_emitters n_for_50 n_for_75 n_for_90, by(year)
foreach s in 50 75 90 {
    generate pct_for_`s' = 100 * n_for_`s' / n_emitters
}
generate period = string(year)
order period n_emitters n_for_50 pct_for_50 n_for_75 pct_for_75 n_for_90 pct_for_90
keep  period n_emitters n_for_50 pct_for_50 n_for_75 pct_for_75 n_for_90 pct_for_90
label variable n_for_50  "Fewest plants that together hold 50% of the year's CO2"
label variable pct_for_50 "Same, as % of plants with CO2 > 0"
list, clean noobs
export excel using "$B203_XLSX", sheet("t10_plants_needed", replace) firstrow(variables)

* ---- B. the evidence in one table ----
* top 1% / top 10%: size and CO2 share (lines 2-6)
import excel using "$B203_XLSX", sheet("t02_06_top_shares") firstrow clear
keep period n_plants n_top1 n_top10 share_top1 share_top10
rename (share_top1 share_top10) (co2_top1 co2_top10)
tempfile ev
save `ev'

* their share of output, VA and workers (line 7)
foreach m in output va workers {
    import excel using "$B203_XLSX", sheet("t07_other_shares") firstrow clear
    keep if variable == "`m'"
    rename (share_top1 share_top10) (`m'_top1 `m'_top10)
    keep period `m'_top1 `m'_top10
    merge 1:1 period using `ev', nogenerate
    save `ev', replace
}

* Gini (line 9)
import excel using "$B203_XLSX", sheet("t09_gini") firstrow clear
keep period gini
merge 1:1 period using `ev', nogenerate

generate sort_year = cond(period == "pool", 0, real(period))
sort sort_year
order period n_plants n_top1 co2_top1 output_top1 va_top1 workers_top1 ///
      n_top10 co2_top10 output_top10 va_top10 workers_top10 gini
drop sort_year
list period n_top1 co2_top1 output_top1 va_top1 workers_top1 gini, clean noobs
export excel using "$B203_XLSX", sheet("t10_evidence", replace) firstrow(variables)
