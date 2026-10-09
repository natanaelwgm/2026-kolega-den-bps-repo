/*==========================================================================
  Lines 2-6: "Hitung share total emissions dari:"
             "Top 1% firms" / "Top 5% firms" / "Top 10% firms" / "Top 20% firms"
  Data  : SI 2010-2022 (data/b203_si.dta), clean == 1
  Method: within each year, plants with CO2 > 0 are ranked from largest to
          smallest emitter. The top p% = the first ceil(n x p / 100) plants.
          Share = CO2 of the top p% / CO2 of all plants with CO2 > 0, in %.
          Pool = the yearly top groups added up over all years.
  Output sheets:
    t02_06_top_shares   n plants, size of each top group and its % of total
                        CO2, pool + by year (clean sample)
    t02_06_all_records  the same without the outlier filter (clean 0 and 1),
                        to show how much the 30 outlier records change it
  Output data:
    data/b203_ranked.dta  every clean plant-year with its emission rank and
                          top-group flags (used by lines 7 and 10)

  NOTE: the unit is the plant-year (firm links in the development data are
  fictional). CO2 = scope 1 (diesel, petrol, coal, LPG) + scope 2.
==========================================================================*/
if "$B203" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- the ranking, saved for lines 7 and 10 ----
use "$B203_DATA/b203_si.dta", clear
keep if clean == 1
generate emitter = (co2_total > 0 & !missing(co2_total))
* largest emitter first; plants with no CO2 come after the emitters
gsort year -emitter -co2_total
by year: generate rank = _n if emitter == 1
bysort year: egen n_emitters = total(emitter)
foreach p in 1 5 10 20 {
    generate top`p' = (rank <= ceil(n_emitters * `p' / 100)) if emitter == 1
    replace  top`p' = 0 if emitter == 0
}
label variable rank       "Emission rank within the year (1 = largest emitter)"
label variable n_emitters "Plants with CO2 > 0 in the year"
label variable top1       "1 = in the top 1% of emitters of the year"
save "$B203_DATA/b203_ranked.dta", replace

* ---- shares: clean sample, then all records ----
foreach sample in clean all {
    use "$B203_DATA/b203_si.dta", clear
    if "`sample'" == "clean" keep if clean == 1
    keep if co2_total > 0 & !missing(co2_total)
    gsort year -co2_total
    by year: generate rank = _n
    by year: generate n = _N
    generate n_plants = 1
    foreach p in 1 5 10 20 {
        generate n_top`p'   = (rank <= ceil(n * `p' / 100))
        generate co2_top`p' = co2_total * n_top`p'
    }
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_plants n_top1 n_top5 n_top10 n_top20 co2_total ///
             co2_top1 co2_top5 co2_top10 co2_top20, by(year)
    foreach p in 1 5 10 20 {
        generate share_top`p' = 100 * co2_top`p' / co2_total
    }
    generate period = cond(year == 0, "pool", string(year))
    order period n_plants n_top1 n_top5 n_top10 n_top20 share_top1 share_top5 share_top10 share_top20 co2_total
    keep  period n_plants n_top1 n_top5 n_top10 n_top20 share_top1 share_top5 share_top10 share_top20 co2_total
    if "`sample'" == "clean" {
        list period n_plants n_top1 share_top1 share_top5 share_top10 share_top20, clean noobs
        export excel using "$B203_XLSX", sheet("t02_06_top_shares", replace) firstrow(variables)
    }
    else export excel using "$B203_XLSX", sheet("t02_06_all_records", replace) firstrow(variables)
}
