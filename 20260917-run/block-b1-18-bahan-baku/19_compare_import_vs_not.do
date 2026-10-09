/*==========================================================================
  Line 19: "compare import/not import berdasarkan productivity, product
            scope, export participation, energy/carbon performance"
  Data  : SI 2010-2022 (productivity, exports, energy/carbon)
          Bahan Baku + Proman rosters 2021-2022 (product scope)
  Output sheets:
    t19_productivity    TFP, VA per worker, output per worker (level & ln)
    t19_export          % exporters, export share
    t19_energy_carbon   CO2 & energy (levels, per VA, per worker, ln)
    t19_product_scope   number of products: importers vs non-importers (roster)
    t19_premium         importer vs non-importer gap from a regression
                        y = importer + year dummies + KBLI2 dummies
  Chart: fig19 (drawn in 12_figures.do)
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_si.dta", clear
keep if clean == 1

* ---- importer vs non-importer stats, pool + by year ----
local PROD "tfp_op tfp_lp tfp_acf tfp_wrdg va_pw out_pw ln_va_pw ln_out_pw"
local EXP  "exporter export_share"
local ENV  "co2_total gj_total co2_s1 co2_s2 co2_per_va gj_per_va co2_pw gj_pw ln_co2_total ln_gj_total ln_co2_per_va ln_gj_per_va"
do "$B18/_sumstats.do" "`PROD'" "importer" "t19_productivity"
do "$B18/_sumstats.do" "`EXP'"  "importer" "t19_export"
do "$B18/_sumstats.do" "`ENV'"  "importer" "t19_energy_carbon"

* ---- importer premium (simple regression) ----
* coefficient on importer = average gap between importers and non-importers,
* comparing firms in the same year and sector.
* for ln variables: coefficient x 100 = roughly the gap in %.
tempname res
tempfile premium
postfile `res' str20 variable double coef se pvalue n using `premium'
foreach y in tfp_op tfp_lp tfp_acf tfp_wrdg ln_va_pw ln_out_pw exporter ln_co2_total ln_gj_total ln_co2_per_va ln_gj_per_va {
    quietly count if !missing(`y') & !missing(importer)
    if r(N) > 30 {
        quietly regress `y' importer i.year i.kbli2, vce(robust)
        local p = 2 * ttail(e(df_r), abs(_b[importer] / _se[importer]))
        post `res' ("`y'") (_b[importer]) (_se[importer]) (`p') (e(N))
    }
}
postclose `res'
use `premium', clear
list, clean noobs
export excel using "$B18_XLSX", sheet("t19_premium", replace) firstrow(variables)

* ---- product scope (Bahan Baku roster x Proman roster, 2021-2022) ----
* merged on firm_key (Kipb in the real data; cell in the sample data)
use "$B18_DATA/b18_bb_firm.dta", clear
merge 1:1 firm_key year using "$B18_DATA/b18_pm_firm.dta", keep(match) nogenerate
display as result "Firms in both the Bahan Baku and the Proman roster: " _N
generate ln_n_products = ln(n_products) if n_products > 0
do "$B18/_sumstats.do" "n_products ln_n_products" "any_import" "t19_product_scope"
