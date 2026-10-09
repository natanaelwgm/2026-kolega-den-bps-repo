/*==========================================================================
  Line 2: "By province, java/non java, kabkot:"
  Data  : SI 2010-2022 (data/b210_si.dta), clean == 1
  One overview table per region level with the headline of lines 3-9,
  pool + by year:
    t02_overview_java     Java vs outside Java
    t02_overview_prov     per province
    t02_overview_kabkot   per district -- ONLY when block 0 has district codes
  Columns: n_firms, share of VA / energy (GJ) / CO2 (% of the period total),
           CO2 per VA, GJ per VA, CO2 per GJ (aggregate = sum / sum),
           % exporters, % FDI, coal and purchased-electricity share of the
           energy mix. Lines 3-9 give the detail of each column.

  NOTE: district_code is blank in block 0, so no kabkot table is written now.
        The same code writes it automatically once the district code is filled.
        VA is nominal and masked: read the shares and ranks, not the levels.
==========================================================================*/
if "$B210" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- which region levels can be done? ----
use "$B210_DATA/b210_si.dta", clear
local levels "java prov"
count if kabkot != ""
if r(N) > 0 local levels "java prov kabkot"
else display as error "No district (kabkot) codes in this data: kabkot table skipped."

foreach lev of local levels {
    use "$B210_DATA/b210_si.dta", clear
    keep if clean == 1 & !missing(`lev')
    generate n_firms = 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms va gj_total co2_total mix_coal mix_pln mix_nonpln mix_total ///
             (mean) pct_exporters = exporter pct_fdi = fdi, by(`lev' year)
    * shares of the period's national total
    foreach v in va gj_total co2_total {
        bysort year: egen double all = total(`v')
        generate share_`v' = 100 * `v' / all
        drop all
    }
    rename (share_va share_gj_total share_co2_total) (va_share_pct gj_share_pct co2_share_pct)
    generate co2_per_va = co2_total / va       if va > 0
    generate gj_per_va  = gj_total / va        if va > 0
    generate co2_per_gj = co2_total / gj_total if gj_total > 0
    replace  pct_exporters = 100 * pct_exporters
    replace  pct_fdi       = 100 * pct_fdi
    generate coal_mix_pct  = 100 * mix_coal / mix_total if mix_total > 0
    generate elec_mix_pct  = 100 * (mix_pln + mix_nonpln) / mix_total if mix_total > 0
    generate period = cond(year == 0, "pool", string(year))
    sort `lev' year
    keep  `lev' period n_firms va_share_pct gj_share_pct co2_share_pct co2_per_va gj_per_va ///
          co2_per_gj pct_exporters pct_fdi coal_mix_pct elec_mix_pct
    order `lev' period
    if "`lev'" == "java" list if period == "pool", clean noobs
    export excel using "$B210_XLSX", sheet("t02_overview_`lev'", replace) firstrow(variables)
}
