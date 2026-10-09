/*==========================================================================
  Line 8: "by sector, sixe, fdi, exporter, importer, province"
  Data  : SI 2010-2022 (data/b206_si.dta), clean == 1
  Lines 3, 5 and 6 repeated for each split, pool + by year:
    pct_owngen     % own-generators among firms asked          (line 3)
    med_own_kwh    median own-generated kWh, own-generators    (line 5)
    med_share      median own share of electricity, own-gen.   (line 6)
  Output sheets:
    t08_by_kbli2     sector, KBLI 2-digit
    t08_by_size      medium (<=100 workers) vs large (>100)
    t08_by_fdi       domestic vs FDI (>= 10% foreign); 2020 missing
    t08_by_exporter  non-exporter vs exporter; 2022 missing
    t08_by_importer  non-importer vs importer
    t08_by_province  province code (Java vs outside Java: see t09a_by_java)
  NOTE: lines 4 (capacity) and 7 (generator fuel) are not in block 0, so they
  have no split here. Small provinces have few firms per year: use the pool.
==========================================================================*/
if "$B206" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
foreach g in kbli2 large fdi exporter importer prov {
    use "$B206_DATA/b206_si.dta", clear
    keep if clean == 1 & !missing(`g') & !missing(has_owngen)
    generate n_firms   = 1
    generate kwh_gen   = own_kwh      if has_owngen == 1
    generate share_gen = owngen_share if has_owngen == 1
    expand 2, generate(copy)              // copy of every row with year = 0 for "pool"
    replace year = 0 if copy == 1
    collapse (sum) n_firms n_owngen = has_owngen (mean) pct_owngen = has_owngen ///
             (p50) med_own_kwh = kwh_gen med_share = share_gen, by(`g' year)
    replace pct_owngen = 100 * pct_owngen
    generate period = cond(year == 0, "pool", string(year))
    sort `g' year
    order `g' period n_firms n_owngen pct_owngen med_own_kwh med_share
    drop year
    list if period == "pool", clean noobs
    local sheet "t08_by_`g'"
    if "`g'" == "large" local sheet "t08_by_size"
    if "`g'" == "prov"  local sheet "t08_by_province"
    export excel using "$B206_XLSX", sheet("`sheet'", replace) firstrow(variables)
}
