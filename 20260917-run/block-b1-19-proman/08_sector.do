/*==========================================================================
  Line 8: "sector"
  Data  : SI 2010-2021 (data/b19_si.dta), clean == 1
          + Proman roster 2021-2022 (data/b19_pm_firm.dta)
  Output sheets:
    t08_sector_mix   which sectors (KBLI 2-digit) exporters vs non-exporters
                     are in: % of firms per sector, pool + by year
    t08_by_kbli2     exporter rate and export share per KBLI 2-digit,
                     pool + by year
    t08_by_kbli5     same per KBLI 5-digit, pooled only
    t08_pm_by_kbli2  roster: % firms exporting and exported / production
                     value per KBLI 2-digit, 2021, 2022 and pool
  Chart: fig08 (drawn in 12_figures.do)

  NOTE: the SI export flag is missing in 2022 (see 01a); the roster
  table covers 2022. Export shares in the SI tables are among exporters
  with a reported share; check n_share (small in many sectors).
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- A. sector composition of exporters vs non-exporters ----
use "$B19_DATA/b19_si.dta", clear
keep if clean == 1 & !missing(exporter) & !missing(kbli2)
generate n_firms = 1
expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
replace year = 0 if copy == 1
collapse (sum) n_firms, by(exporter year kbli2)
bysort exporter year: egen total = total(n_firms)
generate pct_of_group = 100 * n_firms / total
generate period = cond(year == 0, "pool", string(year))
sort exporter year kbli2
order exporter period kbli2 n_firms pct_of_group
drop year total
export excel using "$B19_XLSX", sheet("t08_sector_mix", replace) firstrow(variables)

* ---- B. exporter rate and export share per sector ----
* loop: once for KBLI 2-digit (pool + by year), once for KBLI 5-digit (pool only)
foreach s in kbli2 kbli5 {
    use "$B19_DATA/b19_si.dta", clear
    keep if clean == 1 & !missing(`s') & !missing(exporter)
    generate n_firms = 1
    expand 2, generate(copy)
    replace year = 0 if copy == 1
    if "`s'" == "kbli5" keep if year == 0
    collapse (sum) n_firms (mean) pct_exporter = exporter (count) n_share = exp_share ///
             (p50) med_exp_share = exp_share (mean) mean_exp_share = exp_share, by(`s' year)
    replace pct_exporter = 100 * pct_exporter
    generate period = cond(year == 0, "pool", string(year))
    sort `s' year
    order `s' period n_firms pct_exporter n_share med_exp_share mean_exp_share
    drop year
    export excel using "$B19_XLSX", sheet("t08_by_`s'", replace) firstrow(variables)
}

* ---- C. roster: export share of production per sector ----
use "$B19_DATA/b19_pm_firm.dta", clear
generate n_firms = 1
generate val_prod_known = val_prod if !missing(val_export)
expand 2, generate(copy)
replace year = 0 if copy == 1
collapse (sum) n_firms any_export val_export val_prod_known, by(kbli2 year)
generate pct_firms_export = 100 * any_export / n_firms
generate agg_export_share = 100 * val_export / val_prod_known
generate period = cond(year == 0, "pool", string(year))
sort kbli2 year
order kbli2 period n_firms any_export pct_firms_export agg_export_share val_export val_prod_known
drop year
export excel using "$B19_XLSX", sheet("t08_pm_by_kbli2", replace) firstrow(variables)
