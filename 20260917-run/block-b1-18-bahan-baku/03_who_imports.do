/*==========================================================================
  Line 3: "siapa yg impor?, dan impornya berapa banyak compared to
           kebutuhan keseluruhan bahan baku"
  Data  : SI 2010-2022 (data/b18_si.dta) + Bahan Baku roster 2021-2022
  Output sheets:
    t03_si_by_year   by year: number of firms, % importers,
                     total imports / total raw materials (aggregate),
                     median & mean import share among importers
    t03_bb_by_year   roster version: % firms importing, imports / total raw materials
  Chart: fig03 (drawn in 12_figures.do)

  NOTE: the importer rate jumps from ~17-26% (2010-2015) to ~36-56% (2017+).
  The same jump appears in energy reporting -> most likely a questionnaire
  change, not firms suddenly starting to import. Do not read it as a trend.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- SI 2010-2022 ----
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1
generate n_firms = 1
* aggregate: imports are summed only over firms with a positive denominator
generate imports_m = imports if materials > 0 & !missing(materials)
generate imports_i = imports if inputs > 0 & !missing(inputs)

expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms n_importer = importer imports_m materials imports_i inputs ///
         (mean) mean_share_mat = imp_share_mat mean_share_int = imp_share_int ///
         (p50) med_share_mat = imp_share_mat med_share_int = imp_share_int, by(year)

generate pct_importer = 100 * n_importer / n_firms
* total imports of all firms divided by total raw materials of all firms
generate agg_imp_over_mat = imports_m / materials
generate agg_imp_over_int = imports_i / inputs
generate period = cond(year == 0, "pool", string(year))
order period n_firms n_importer pct_importer agg_imp_over_mat agg_imp_over_int ///
      med_share_mat mean_share_mat med_share_int mean_share_int
keep  period n_firms n_importer pct_importer agg_imp_over_mat agg_imp_over_int ///
      med_share_mat mean_share_mat med_share_int mean_share_int
list period n_firms pct_importer agg_imp_over_mat med_share_mat, clean noobs
export excel using "$B18_XLSX", sheet("t03_si_by_year", replace) firstrow(variables)

* ---- Bahan Baku roster 2021-2022 ----
use "$B18_DATA/b18_bb_rows.dta", clear
collapse (sum) val_import val_total, by(firm_key year)      // material rows -> firms
generate any_import = (val_import > 0)
generate n_firms = 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms any_import val_import val_total, by(year)
generate pct_firms_import = 100 * any_import / n_firms
generate agg_import_share = val_import / val_total
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_import pct_firms_import agg_import_share
drop year
list, clean noobs
export excel using "$B18_XLSX", sheet("t03_bb_by_year", replace) firstrow(variables)
