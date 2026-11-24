/*==========================================================================
  04  The merge key, year by year, and one row per firm x year
  Input : output/proman_rows.dta, output/bahanbaku_rows.dta, $PM_MAIN
  Output: output/key_by_year.dta / .csv -- the key of each year and why
          output/roster_firm_year.dta   -- 1 row = 1 roster_key x year

  KEY OF A YEAR (PM_KEY = auto). A key part is "available" in a year when at
  least PM_MIN_FILL of the rows have it:
    kipb      Kipb in the ready-to-use file AND in every roster of that year
    cell_kab  otherwise: district (kab) in the ready-to-use file and in every
              roster of that year -> cell = province x district x KBLI5
    cell      otherwise: cell = province x KBLI5
  PM_KEY = kipb | cell_kab | cell forces one key for every year.
  roster_key = "K:" Kipb, "D:" prov_kab_kbli5 or "C:" prov_kbli5. Rows that
  lack a part of their year's key are dropped and counted.

  Variables per roster_key x year: see README ("What the merged file adds").
  With a cell key every value is the cell's total over its roster rows.
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
foreach f in roster_firm_year.dta key_by_year.dta key_by_year.csv {
    capture erase "$PM_OUT/`f'"
}
pm_notes_start
local thr = $PM_MIN_FILL

* ---- which rosters exist -------------------------------------------------------
local rosters ""
foreach r in proman bahanbaku {
    capture confirm file "$PM_OUT/`r'_rows.dta"
    if !_rc local rosters `rosters' `r'
}
if "`rosters'" == "" {
    display as error "No cleaned roster (run 02 and 03 first)."
    exit 601
}

* ---- availability per year: rosters ------------------------------------------------
tempfile avail
local first 1
foreach r of local rosters {
    use year kipb kab using "$PM_OUT/`r'_rows.dta", clear
    generate byte has_kipb = kipb != ""
    generate byte has_kab  = kab != ""
    collapse (count) `r'_rows = has_kipb (mean) `r'_kipb = has_kipb `r'_kab = has_kab, by(year)
    if `first' == 0 merge 1:1 year using `avail', nogenerate
    save `avail', replace
    local first 0
}

* ---- availability per year: the ready-to-use file --------------------------------------
quietly describe using "$PM_MAIN", varlist
local mvars `r(varlist)'
local need $PM_MAIN_YEAR
local ok : list need in mvars
if !`ok' {
    display as error "Year variable $PM_MAIN_YEAR not found in $PM_MAIN (set PM_MAIN_YEAR in 00_run.do)."
    exit 111
}
local keep $PM_MAIN_YEAR
foreach g in PM_KIPB PM_MAIN_PROV PM_MAIN_KAB PM_MAIN_KBLI {
    local v ${`g'}
    local has : list v in mvars
    if `has' local keep `keep' `v'
    else display as text "  ready-to-use file has no variable `v' (`g')"
}
use `keep' using "$PM_MAIN", clear
pm_mainkeys
rename $PM_MAIN_YEAR __yr
generate int year = __yr
drop __yr
generate byte m_kipb = __kipb != ""
generate byte m_kab  = __kab != ""
generate byte m_cell = __prov != "" & __kbli != ""
collapse (count) main_rows = m_kipb (mean) main_kipb = m_kipb main_kab = m_kab main_cell = m_cell, by(year)
merge 1:1 year using `avail', nogenerate

* ---- the key of each year -----------------------------------------------------------------
generate str8 key_type = ""
generate str80 key_reason = ""
foreach r in proman bahanbaku {
    capture confirm variable `r'_rows
    if _rc {
        generate `r'_rows = 0
        generate `r'_kipb = .
        generate `r'_kab  = .
    }
    replace `r'_rows = 0 if missing(`r'_rows)
}
generate byte ok_kipb = main_kipb >= `thr' & !missing(main_kipb) ///
    & (proman_rows == 0 | proman_kipb >= `thr') & (bahanbaku_rows == 0 | bahanbaku_kipb >= `thr')
generate byte ok_kab = main_kab >= `thr' & !missing(main_kab) ///
    & (proman_rows == 0 | proman_kab >= `thr') & (bahanbaku_rows == 0 | bahanbaku_kab >= `thr')
if "$PM_KEY" == "auto" {
    replace key_type = "kipb"     if ok_kipb
    replace key_type = "cell_kab" if !ok_kipb & ok_kab
    replace key_type = "cell"     if !ok_kipb & !ok_kab
    replace key_reason = "Kipb in the ready-to-use file and the rosters" if key_type == "kipb"
    replace key_reason = "no Kipb on one side; district on both sides"   if key_type == "cell_kab"
    replace key_reason = "no Kipb and no district on both sides"        if key_type == "cell"
}
else {
    replace key_type = "$PM_KEY"
    replace key_reason = "forced by PM_KEY"
    quietly count if ("$PM_KEY" == "kipb" & !ok_kipb) | ("$PM_KEY" == "cell_kab" & !ok_kab)
    if r(N) > 0 display as error "PM_KEY = $PM_KEY although its parts are missing in `r(N)' year(s): see key_by_year.csv"
}
* years without any roster row keep the key for the record but merge nothing
drop ok_kipb ok_kab
order year key_type key_reason main_rows main_kipb main_kab main_cell
format main_kipb main_kab main_cell *_kipb *_kab %5.3f
sort year
list year key_type main_rows proman_rows bahanbaku_rows main_kipb proman_kipb bahanbaku_kipb main_kab, clean noobs abbreviate(14)
save "$PM_OUT/key_by_year.dta", replace
export delimited using "$PM_OUT/key_by_year.csv", replace
tempfile keys
keep year key_type
save `keys'

* ---- the key on every roster row ----------------------------------------------------------
capture program drop pm_rowkey
program define pm_rowkey
    args rname keys
    merge m:1 year using `keys', keep(master match) nogenerate
    generate str100 roster_key = ""
    quietly replace roster_key = "K:" + kipb                              if key_type == "kipb"     & kipb != ""
    quietly replace roster_key = "D:" + prov + "_" + kab + "_" + kbli5    if key_type == "cell_kab" & prov != "" & kab != "" & kbli5 != ""
    quietly replace roster_key = "C:" + prov + "_" + kbli5                if key_type == "cell"     & prov != "" & kbli5 != ""
    quietly levelsof year, local(ys)
    foreach y of local ys {
        quietly count if year == `y' & roster_key == ""
        if r(N) > 0 pm_note `rname' `y' "rows without the parts of the year's key (dropped)" r(N)
    }
    quietly drop if roster_key == ""
end

* ---- Proman ---------------------------------------------------------------
local have_pm : list posof "proman" in rosters
if `have_pm' {
    use "$PM_OUT/proman_rows.dta", clear
    pm_rowkey proman `keys'
    bysort roster_key year: egen double tot = total(val_prod)
    generate double sh  = val_prod / tot
    generate double sh2 = sh^2
    bysort roster_key year kbki: generate byte tag_kbki = (_n == 1 & kbki != "")
    generate dest_real = dest_name if exported == 1 & dest_name != "(NOT REPORTED)"
    bysort roster_key year dest_real: generate byte tag_dest = (_n == 1 & dest_real != "")
    generate double w = cond(missing(val_export), val_prod, val_export) if exported == 1
    gsort roster_key year -w
    by roster_key year: generate main_dest = dest_name[1] if exported[1] == 1
    by roster_key year: generate byte main_region = region[1] if exported[1] == 1
    generate double val_export_hs = val_export if high_std == 1
    collapse (count) pm_n_products = val_prod ///
             (sum) pm_n_kbki = tag_kbki pm_val_prod = val_prod pm_n_exported = exported ///
                   n_unknown = share_unknown pm_val_export = val_export pm_n_dest = tag_dest ///
                   pm_hhi = sh2 val_export_hs ///
             (max) pm_core_share = sh ///
             (firstnm) pm_main_dest = main_dest pm_main_region = main_region ///
                       kipb prov kab kbli5 key_type, by(roster_key year)
    generate byte pm_exporter = (pm_n_exported > 0)
    replace  pm_val_export = . if n_unknown > 0
    generate double pm_export_share   = 100 * pm_val_export / pm_val_prod
    generate double pm_high_std_share = 100 * val_export_hs / pm_val_export if pm_exporter == 1 & pm_val_export > 0 & !missing(pm_val_export)
    replace  pm_core_share = 100 * pm_core_share
    drop n_unknown val_export_hs
    generate byte in_proman = 1
    tempfile pm
    save `pm'
}

* ---- Bahan Baku -------------------------------------------------------------
local have_bb : list posof "bahanbaku" in rosters
if `have_bb' {
    use "$PM_OUT/bahanbaku_rows.dta", clear
    pm_rowkey bahanbaku `keys'
    generate origin_real = origin_name if imported == 1 & origin_name != "(NOT REPORTED)"
    bysort roster_key year origin_real: generate byte tag_orig = (_n == 1 & origin_real != "")
    generate double vimp_sort = cond(missing(val_import), -1, val_import)
    gsort roster_key year -vimp_sort
    by roster_key year: generate main_origin = origin_name[1] if imported[1] == 1
    generate double val_total_known = val_total if only_total == 0
    collapse (count) bb_n_materials = val_total ///
             (sum) bb_val_local = val_local bb_val_import = val_import bb_val_total = val_total ///
                   val_total_known bb_n_imported = imported bb_n_origin = tag_orig n_only_total = only_total ///
             (firstnm) bb_main_origin = main_origin kipb prov kab kbli5 key_type, by(roster_key year)
    generate byte bb_importer = (bb_n_imported > 0)
    * import share only from rows whose local/imported split is known
    generate double bb_import_share = 100 * bb_val_import / val_total_known if val_total_known > 0
    label variable n_only_total "Bahan Baku: rows with only a total value (split unknown)"
    rename n_only_total bb_n_only_total
    drop val_total_known
    generate byte in_bahanbaku = 1
    tempfile bb
    save `bb'
}

* ---- both rosters on one row ------------------------------------------------
if `have_pm' & `have_bb' {
    use `bb', clear
    merge 1:1 roster_key year using `pm', update nogenerate
}
else if `have_pm' use `pm', clear
else use `bb', clear
foreach r in proman bahanbaku {
    capture confirm variable in_`r'
    if _rc generate byte in_`r' = 0
    replace in_`r' = 0 if missing(in_`r')
}

capture label define region 1 "EU" 2 "US" 3 "China" 4 "ASEAN" 5 "Japan" 6 "India" 7 "Others", replace
capture label values pm_main_region region
label variable roster_key "Merge key: K: Kipb / D: prov_kab_kbli5 / C: prov_kbli5"
label variable key_type   "kipb = firm values; cell_kab / cell = all firms of the cell together"
label variable in_proman    "1 = key appears in the Proman roster"
label variable in_bahanbaku "1 = key appears in the Bahan Baku roster"
foreach v in pm_n_products pm_n_kbki pm_val_prod pm_core_share pm_hhi pm_exporter pm_n_exported ///
             pm_val_export pm_export_share pm_n_dest pm_main_dest pm_main_region pm_high_std_share {
    capture confirm variable `v'
    if _rc continue
    local l ""
    if "`v'" == "pm_n_products"     local l "Proman: product rows"
    if "`v'" == "pm_n_kbki"         local l "Proman: distinct product codes (KBKI)"
    if "`v'" == "pm_val_prod"       local l "Proman: production value (as reported)"
    if "`v'" == "pm_core_share"     local l "Proman: largest product, % of production value"
    if "`v'" == "pm_hhi"            local l "Proman: product concentration (sum of squared value shares)"
    if "`v'" == "pm_exporter"       local l "Proman: 1 = any product exported"
    if "`v'" == "pm_n_exported"     local l "Proman: exported product rows"
    if "`v'" == "pm_val_export"     local l "Proman: exported value (missing if a share is unknown)"
    if "`v'" == "pm_export_share"   local l "Proman: exported / production value (%)"
    if "`v'" == "pm_n_dest"         local l "Proman: distinct destination countries (lower bound)"
    if "`v'" == "pm_main_dest"      local l "Proman: destination with the largest exported value"
    if "`v'" == "pm_main_region"    local l "Proman: region of the main destination"
    if "`v'" == "pm_high_std_share" local l "Proman: exports to EU-27 + EFTA, % of exported value"
    label variable `v' "`l'"
}
foreach v in bb_n_materials bb_val_local bb_val_import bb_val_total bb_n_imported bb_importer ///
             bb_import_share bb_n_origin bb_main_origin {
    capture confirm variable `v'
    if _rc continue
    local l ""
    if "`v'" == "bb_n_materials"  local l "Bahan Baku: material rows"
    if "`v'" == "bb_val_local"    local l "Bahan Baku: value of local materials (as reported)"
    if "`v'" == "bb_val_import"   local l "Bahan Baku: value of imported materials (as reported)"
    if "`v'" == "bb_val_total"    local l "Bahan Baku: total material value"
    if "`v'" == "bb_n_imported"   local l "Bahan Baku: imported material rows"
    if "`v'" == "bb_importer"     local l "Bahan Baku: 1 = any material imported"
    if "`v'" == "bb_import_share" local l "Bahan Baku: imported / material value with a known split (%)"
    if "`v'" == "bb_n_origin"     local l "Bahan Baku: distinct origin countries"
    if "`v'" == "bb_main_origin"  local l "Bahan Baku: origin with the largest imported value"
    label variable `v' "`l'"
}
order roster_key year key_type kipb prov kab kbli5 in_proman in_bahanbaku
sort year roster_key
compress
save "$PM_OUT/roster_firm_year.dta", replace
display as result "Roster firm-years: " _N " -> $PM_OUT/roster_firm_year.dta"
pm_notes_save 04
