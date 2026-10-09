/*==========================================================================
  Line 10: "Indentifikasi daerah yg lebih clean mana yg carbon intensive"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  Output sheets:
    t10_rank_prov       provinces ranked by CO2 per VA, pooled 2010-2022
                        (rank 1 = cleanest), with the quadrant of each
    t10_quadrant_prov   the quadrant table: how many provinces, and which,
                        are large/small and cleaner/carbon intensive
    t10_rank_year_prov  CO2 per VA and rank per province in every year
                        (shows whether the ranking is stable)
    t10_rank_kabkot, t10_quadrant_kabkot, t10_rank_year_kabkot
                        same per district (only when district codes exist)

  Definitions:
    co2_per_va   total CO2 / total VA of the region (aggregate)
    ranked       1 = at least 50 clean firm-years pooled (10 per year in
                 t10_rank_year_*). Smaller regions stay in the table with
                 ranked = 0 and no rank, because a region with a handful of
                 firms can top any ranking by accident.
    intensity    "Cleaner" if co2_per_va is below the national CO2 per VA,
                 else "Carbon intensive"
    size         "Large" if the region's VA share is at or above the median
                 VA share of the ranked regions, else "Small"
    quadrant     size x intensity, e.g. "Large, carbon intensive"
  Also shown, to explain the ranking: co2_per_gj (how dirty each GJ is),
  co2_s1_per_gj_s1 (own fuel combustion only, without purchased electricity,
  whose grid factor is one national number), coal share of the energy mix,
  share of national VA and CO2.

  NOTE: VA is nominal and masked; the pooled ranking compares regions over the
        same years, so price levels largely cancel, but read ranks, not levels.
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

use "$B210_DATA/b210_si.dta", clear
local levels "prov"
count if kabkot != ""
if r(N) > 0 local levels "prov kabkot"
else display as error "No district (kabkot) codes in this data: kabkot ranking skipped."

foreach lev of local levels {
    * ---- A. pooled ranking ----
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms = 1
    collapse (sum) n_firms va co2_total gj_total co2_s1 gj_s1 mix_coal mix_total, by(`lev')
    * region name as text (province label, or the district code itself)
    capture decode `lev', generate(region)
    if _rc generate region = `lev'
    egen double va_all  = total(va)
    egen double co2_all = total(co2_total)
    generate national_co2_per_va = co2_all / va_all
    generate va_share_pct  = 100 * va / va_all
    generate co2_share_pct = 100 * co2_total / co2_all
    generate co2_per_va       = co2_total / va       if va > 0
    generate co2_per_gj       = co2_total / gj_total if gj_total > 0
    generate co2_s1_per_gj_s1 = co2_s1 / gj_s1       if gj_s1 > 0
    generate coal_mix_pct     = 100 * mix_coal / mix_total if mix_total > 0

    generate ranked = (n_firms >= 50 & !missing(co2_per_va))
    egen rank_co2_per_va = rank(co2_per_va) if ranked == 1, unique   // 1 = cleanest
    egen rank_co2_per_gj = rank(co2_per_gj) if ranked == 1, unique

    generate str16 intensity = cond(co2_per_va < national_co2_per_va, "Cleaner", "Carbon intensive") if ranked == 1
    summarize va_share_pct if ranked == 1, detail
    generate str5 size = cond(va_share_pct >= r(p50), "Large", "Small") if ranked == 1
    generate str30 quadrant = size + ", " + lower(intensity) if ranked == 1
    replace quadrant = "Not ranked (<50 firm-years)" if ranked == 0

    gsort -ranked rank_co2_per_va
    order region `lev' n_firms ranked rank_co2_per_va co2_per_va national_co2_per_va quadrant ///
          va_share_pct co2_share_pct co2_per_gj rank_co2_per_gj co2_s1_per_gj_s1 coal_mix_pct
    keep  region n_firms ranked rank_co2_per_va co2_per_va national_co2_per_va quadrant ///
          va_share_pct co2_share_pct co2_per_gj rank_co2_per_gj co2_s1_per_gj_s1 coal_mix_pct
    list region n_firms rank_co2_per_va co2_per_va quadrant if ranked == 1, clean noobs
    export excel using "$B210_XLSX", sheet("t10_rank_`lev'", replace) firstrow(variables)

    * ---- B. quadrant table ----
    * the regions in each quadrant, listed from cleanest to most intensive
    sort quadrant rank_co2_per_va region
    by quadrant: generate strL regions = region if _n == 1
    by quadrant: replace regions = regions[_n-1] + "; " + region if _n > 1
    by quadrant: egen n_regions     = count(n_firms)
    by quadrant: egen va_share_sum  = total(va_share_pct)
    by quadrant: egen co2_share_sum = total(co2_share_pct)
    by quadrant: keep if _n == _N
    keep  quadrant n_regions va_share_sum co2_share_sum regions
    rename (va_share_sum co2_share_sum) (va_share_pct co2_share_pct)
    list quadrant n_regions va_share_pct co2_share_pct, clean noobs
    export excel using "$B210_XLSX", sheet("t10_quadrant_`lev'", replace) firstrow(variables)

    * ---- C. ranking in every year ----
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms = 1
    collapse (sum) n_firms va co2_total, by(`lev' year)
    capture decode `lev', generate(region)
    if _rc generate region = `lev'
    generate co2_per_va = co2_total / va if va > 0
    generate ranked = (n_firms >= 10 & !missing(co2_per_va))
    bysort year: egen rank_co2_per_va = rank(co2_per_va) if ranked == 1, unique
    bysort year: egen n_ranked = total(ranked)
    sort `lev' year
    keep  region year n_firms ranked co2_per_va rank_co2_per_va n_ranked
    order region year n_firms ranked co2_per_va rank_co2_per_va n_ranked
    export excel using "$B210_XLSX", sheet("t10_rank_year_`lev'", replace) firstrow(variables)
}
