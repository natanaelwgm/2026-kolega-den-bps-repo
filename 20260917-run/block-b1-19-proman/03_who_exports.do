/*==========================================================================
  Line 3: "siapa yg export?, dan exportnya berapa banyak compared to
           kebutuhan keseluruhan produksi"
  Data  : SI 2010-2022 (data/b19_si.dta), clean == 1
          + Proman roster 2021-2022 (data/b19_pm_firm.dta)
  Output sheets:
    t03_si_by_year   by year: firms asked, % exporters, number of exporters
                     with a reported export share, median & mean export
                     share (exporters only), output-weighted export share
    t03_pm_by_year   roster: % firms exporting, exported / total production
                     value, median & mean firm export share (exporters only)
  Chart: fig03 (drawn in 12_figures.do)

  NOTE (SI):
  - "Firms asked" = firms where the export question can be evaluated.
    Firms never asked are not counted as non-exporters.
  - 2022: the SI form only asks about direct exports (no "no" answers), so
    the exporter rate is missing. For 2022 use the roster (t03_pm_by_year).
  - The export share is reported by few exporters (none in 2015, 2017,
    2022; fewer than 30 in 2013). Check n_share before reading a median.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- SI 2010-2022 ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1
generate n_asked = !missing(exporter)
* output-weighted share: exported output / total output, exporters with a share
generate out_export = output * exp_share / 100 if output > 0
generate out_with_share = output if !missing(out_export)

expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_asked n_exporter = exporter out_export out_with_share ///
         (count) n_share = exp_share ///
         (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(year)
generate pct_exporter = 100 * n_exporter / n_asked
replace  pct_exporter = . if n_asked == 0
generate wtd_exp_share = 100 * out_export / out_with_share
generate period = cond(year == 0, "pool", string(year))
order period n_asked n_exporter pct_exporter n_share med_exp_share mean_exp_share wtd_exp_share
keep  period n_asked n_exporter pct_exporter n_share med_exp_share mean_exp_share wtd_exp_share
list, clean noobs
export excel using "$B19_XLSX", sheet("t03_si_by_year", replace) firstrow(variables)

* ---- Proman roster 2021-2022 ----
use "$B19_DATA/b19_pm_firm.dta", clear
generate n_firms = 1
generate n_share_unknown = (n_unknown > 0)
generate val_prod_known = val_prod if !missing(val_export)
* firm export share among exporters only
generate exp_share_x = exp_share if any_export == 1
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms any_export n_share_unknown val_export val_prod_known ///
         (p50) med_exp_share = exp_share_x (mean) mean_exp_share = exp_share_x, by(year)
generate pct_firms_export = 100 * any_export / n_firms
generate agg_export_share = 100 * val_export / val_prod_known
generate period = cond(year == 0, "pool", string(year))
order period n_firms any_export pct_firms_export agg_export_share med_exp_share mean_exp_share n_share_unknown
drop year val_prod_known
list, clean noobs
export excel using "$B19_XLSX", sheet("t03_pm_by_year", replace) firstrow(variables)
