/*==========================================================================
  03  Clean the Bahan Baku (raw materials) roster, all years
  Input : output/bahanbaku_std.dta (from 01: every item as text)
  Output: output/bahanbaku_rows.dta -- 1 row = 1 raw material x firm x year

  Codes and numbers: same programs as 02 (pm_code, pm_num).
  Value rules (as block-b1-18):
    - local and imported value; a missing one counts as 0 when the other is
      reported
    - if neither is reported but a total is, the total is kept and the
      import share stays unknown (imported = missing)
    - if a total is reported AND local + imported is known, local + imported
      is used; rows where they differ by more than 1% are counted
    - rows with no positive value at all are dropped
    - imported = imported value > 0
    - origin country: name filled from rows with the same code when only
      the code is given; "INDONESIA" is not an import origin
  Every change is counted per year in the cleaning report.
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
capture erase "$PM_OUT/bahanbaku_rows.dta"
capture confirm file "$PM_OUT/bahanbaku_std.dta"
if _rc {
    display as error "No Bahan Baku data (output/bahanbaku_std.dta): skipped."
    exit
}
pm_notes_start
use "$PM_OUT/bahanbaku_std.dta", clear
quietly levelsof year, local(years)

* ---- text: upper case, single spaces ------------------------------------------
foreach v in material unit origin_name origin_code kbki flag {
    quietly replace `v' = ustrregexra(ustrupper(ustrtrim(`v')), "\s+", " ")
}

* ---- codes ------------------------------------------------------------------
foreach c in kipb prov kab kbli5 {
    pm_code `c', generate(`c'_c) type(`c')
    if r(nbad)   > 0 pm_note bahanbaku . "`c': values without a digit, set blank" r(nbad)
    if r(nlong)  > 0 pm_note bahanbaku . "`c': longer than expected, cut" r(nlong)
    if r(nshort) > 0 pm_note bahanbaku . "`c': shorter than 5 digits, kept" r(nshort)
    drop `c'
    rename `c'_c `c'
}

* ---- numbers ------------------------------------------------------------------
foreach v in vol_local val_local vol_import val_import val_total {
    pm_num `v', generate(`v'_n)
    if r(nfail)     > 0 pm_note bahanbaku . "`v': text that is not a number, set missing" r(nfail)
    if r(nreformat) > 0 pm_note bahanbaku . "`v': thousands/decimal separators reinterpreted" r(nreformat)
    drop `v'
    rename `v'_n `v'
}
foreach v in vol_local val_local vol_import val_import val_total {
    foreach y of local years {
        quietly count if year == `y' & `v' < 0
        if r(N) > 0 pm_note bahanbaku `y' "`v': negative, set missing" r(N)
    }
    quietly replace `v' = . if `v' < 0
}

* ---- values ---------------------------------------------------------------
generate double sum_li = cond(missing(val_local) & missing(val_import), ., ///
                              cond(missing(val_local), 0, val_local) + cond(missing(val_import), 0, val_import))
foreach y of local years {
    quietly count if year == `y' & !missing(val_total) & sum_li > 0 & !missing(sum_li) & abs(val_total - sum_li) > 0.01 * val_total
    if r(N) > 0 pm_note bahanbaku `y' "reported total differs from local + imported by more than 1% (local + imported used)" r(N)
    quietly count if year == `y' & missing(sum_li) & val_total > 0 & !missing(val_total)
    if r(N) > 0 pm_note bahanbaku `y' "only a total value reported (import share unknown)" r(N)
}
generate byte only_total = missing(sum_li) & val_total > 0 & !missing(val_total)
quietly replace val_local  = 0 if missing(val_local)  & !missing(sum_li)
quietly replace val_import = 0 if missing(val_import) & !missing(sum_li)
quietly replace val_total  = sum_li if !missing(sum_li)
drop sum_li
foreach y of local years {
    quietly count if year == `y' & !(val_total > 0 & !missing(val_total))
    if r(N) > 0 pm_note bahanbaku `y' "rows with no positive value (dropped)" r(N)
    quietly count if year == `y' & (prov == "" | kbli5 == "")
    if r(N) > 0 pm_note bahanbaku `y' "rows without province or KBLI5 (kept; cannot merge on a cell)" r(N)
}
quietly drop if !(val_total > 0 & !missing(val_total))
generate byte imported = (val_import > 0) if only_total == 0

* ---- origin country ---------------------------------------------------
quietly replace origin_code = ustrregexra(origin_code, "\.0+$", "")
foreach v in origin_name origin_code {
    quietly replace `v' = "" if ustrregexm(`v', "^[\*X\-\.]*$") | inlist(`v', "NA", "N/A", "NULL")
}
quietly replace origin_code = "" if inlist(origin_name, "INDONESIA", "DALAM NEGERI", "DOMESTIK")
quietly replace origin_name = "" if inlist(origin_name, "INDONESIA", "DALAM NEGERI", "DOMESTIK")
bysort origin_code (origin_name): replace origin_name = origin_name[_N] if origin_name == "" & origin_code != ""
quietly replace origin_name = "CODE " + origin_code if origin_name == "" & origin_code != ""
quietly replace origin_name = "(NOT REPORTED)" if origin_name == "" & imported == 1
quietly replace origin_name = "" if imported == 0

* ---- per-year summary ---------------------------------------------------------------
foreach y of local years {
    quietly count if year == `y'
    pm_note bahanbaku `y' "rows kept" r(N)
    quietly count if year == `y' & kipb != ""
    pm_note bahanbaku `y' "rows with Kipb" r(N)
    quietly count if year == `y' & kab != ""
    pm_note bahanbaku `y' "rows with district" r(N)
    quietly count if year == `y' & imported == 1
    pm_note bahanbaku `y' "imported material rows" r(N)
}

* ---- save ---------------------------------------------------------------
label variable kipb        "Kipb (firm ID), cleaned; blank when masked or missing"
label variable prov        "Province code (2 digits)"
label variable kab         "District code (2 digits within the province); blank when masked"
label variable kbli5       "Firm KBLI 5-digit as reported in the roster"
label variable kbki        "Material code (KBKI)"
label variable val_local   "Value of domestically sourced material (as reported)"
label variable val_import  "Value of imported material (as reported)"
label variable val_total   "Local + imported value (or the reported total if only that is given)"
label variable only_total  "1 = only a total value was reported (import share unknown)"
label variable imported    "1 = material partly or fully imported; missing if unknown"
label variable origin_name "Main country of the import"
label variable flag        "Roster flag as reported"
order year kipb prov kab kbli5 material kbki unit vol_local val_local vol_import val_import ///
      val_total only_total imported origin_name origin_code flag source_file source_sheet source_row
compress
save "$PM_OUT/bahanbaku_rows.dta", replace
display as result "Bahan Baku rows: " _N " -> $PM_OUT/bahanbaku_rows.dta"
pm_notes_save 03
