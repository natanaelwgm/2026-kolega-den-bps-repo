/*==========================================================================
  02  Clean the Proman (products) roster, all years
  Input : output/proman_std.dta (from 01: every item as text)
  Output: output/proman_rows.dta -- 1 row = 1 product x firm x year

  Codes (same rules as for the ready-to-use file in 05, see pm_code):
    kipb (upper case, "12345.0" -> "12345", leading zeros dropped),
    prov (2 digits), kab (2 digits of the district), kbli5 (5 digits)
  Numbers (pm_num): "1.234.567,89", "1,234,567", "12,5", "45%", "Rp", "***"
  Export rules (as block-b1-19):
    - a BLANK share means not exported (never coded 0); "NO" as destination
      also means not exported
    - exported = positive share OR a named foreign destination
    - export share scale per year: if at least 90% of the positive shares
      of a year are <= 1 the year is read as a fraction and multiplied by 100
      (PM_SHARE_SCALE in 00_run.do: auto | percent | fraction)
    - shares above 100 after that are set missing
    - exported value = production value x share / 100; missing when the
      product is exported but has no usable share (share_unknown)
    - "INDONESIA" is not a destination; a name is filled from rows with the
      same country code when only the code is given
    - rows without a positive production value are dropped
  Every change is counted per year in the cleaning report.
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
capture erase "$PM_OUT/proman_rows.dta"
capture confirm file "$PM_OUT/proman_std.dta"
if _rc {
    display as error "No Proman data (output/proman_std.dta): skipped."
    exit
}
pm_notes_start
use "$PM_OUT/proman_std.dta", clear
quietly levelsof year, local(years)

* ---- text: upper case, single spaces ------------------------------------------
foreach v in product unit dest_name dest_code kbki flag {
    quietly replace `v' = ustrregexra(ustrupper(ustrtrim(`v')), "\s+", " ")
}

* ---- codes ------------------------------------------------------------------
foreach c in kipb prov kab kbli5 {
    pm_code `c', generate(`c'_c) type(`c')
    if r(nbad)   > 0 pm_note proman . "`c': values without a digit, set blank" r(nbad)
    if r(nlong)  > 0 pm_note proman . "`c': longer than expected, cut" r(nlong)
    if r(nshort) > 0 pm_note proman . "`c': shorter than 5 digits, kept" r(nshort)
    drop `c'
    rename `c'_c `c'
}

* ---- numbers ------------------------------------------------------------------
foreach v in val_prod exp_pct volume {
    pm_num `v', generate(`v'_n)
    if r(nfail)     > 0 pm_note proman . "`v': text that is not a number, set missing" r(nfail)
    if r(nreformat) > 0 pm_note proman . "`v': thousands/decimal separators reinterpreted" r(nreformat)
    drop `v'
    rename `v'_n `v'
}
foreach v in val_prod exp_pct volume {
    foreach y of local years {
        quietly count if year == `y' & `v' < 0
        if r(N) > 0 pm_note proman `y' "`v': negative, set missing" r(N)
    }
    quietly replace `v' = . if `v' < 0
}

* ---- rows without a production value ------------------------------------------------
foreach y of local years {
    quietly count if year == `y' & (val_prod == 0 | missing(val_prod))
    if r(N) > 0 pm_note proman `y' "rows without a positive production value (dropped)" r(N)
    quietly count if year == `y' & (prov == "" | kbli5 == "")
    if r(N) > 0 pm_note proman `y' "rows without province or KBLI5 (kept; cannot merge on a cell)" r(N)
}
quietly drop if val_prod == 0 | missing(val_prod)

* ---- export share scale, per year ------------------------------------------------------
generate byte share_rescaled = 0
foreach y of local years {
    quietly count if year == `y' & exp_pct > 0 & !missing(exp_pct)
    local n_pos = r(N)
    quietly count if year == `y' & exp_pct > 0 & exp_pct <= 1
    local n_le1 = r(N)
    local frac 0
    if "$PM_SHARE_SCALE" == "fraction" local frac 1
    * auto: a year is in fractions when at least 90% of its positive shares
    * are <= 1 (a few stray values above 1 do not hide it); in a percent year
    * only a small share of exporters export 1% or less
    if "$PM_SHARE_SCALE" == "auto" & `n_pos' > 0 {
        if `n_le1' >= 0.9 * `n_pos' local frac 1
    }
    if `frac' {
        quietly replace exp_pct = 100 * exp_pct if year == `y'
        quietly replace share_rescaled = 1 if year == `y'
        pm_note proman `y' "export share read as a fraction (0-1) and multiplied by 100" `n_pos'
    }
    quietly count if year == `y' & exp_pct > 100 & !missing(exp_pct)
    if r(N) > 0 pm_note proman `y' "export share above 100, set missing" r(N)
}
quietly replace exp_pct = . if exp_pct > 100

* ---- destination country ------------------------------------------------------
quietly replace dest_code = ustrregexra(dest_code, "\.0+$", "")
foreach v in dest_name dest_code {
    quietly replace `v' = "" if ustrregexm(`v', "^[\*X\-\.]*$") | inlist(`v', "NA", "N/A", "NULL")
}
* "NO" (not exported) and "INDONESIA" are not foreign destinations
quietly replace dest_code = "" if inlist(dest_name, "NO", "TIDAK", "TIDAK ADA", "INDONESIA", "INDONESIA (DOMESTIK)", "DOMESTIK", "DALAM NEGERI")
quietly replace dest_name = "" if inlist(dest_name, "NO", "TIDAK", "TIDAK ADA", "INDONESIA", "INDONESIA (DOMESTIK)", "DOMESTIK", "DALAM NEGERI")
* only the code given -> the name used with the same code elsewhere
bysort dest_code (dest_name): replace dest_name = dest_name[_N] if dest_name == "" & dest_code != ""
quietly replace dest_name = "CODE " + dest_code if dest_name == "" & dest_code != ""

* ---- exported or not --------------------------------------------------
generate byte exported = (exp_pct > 0 & !missing(exp_pct)) | dest_name != ""
quietly replace exp_pct = 0 if exported == 0
generate byte share_unknown = (exported == 1 & missing(exp_pct))
quietly replace dest_name = "(NOT REPORTED)" if exported == 1 & dest_name == ""
generate double val_export = val_prod * exp_pct / 100
foreach y of local years {
    quietly count if year == `y' & share_unknown == 1
    if r(N) > 0 pm_note proman `y' "exported rows without a usable share (exported value unknown)" r(N)
}

* ---- destination region (block-b1-21b lists, plus English names) ------------------
* region: 1 EU (EU-27), 2 US, 3 China, 4 ASEAN, 5 Japan, 6 India, 7 Others
generate byte region = 7 if exported == 1
quietly {
replace region = 1 if inlist(dest_name, "AUSTRIA", "BELGIA", "BELGIUM", "BULGARIA", "KROASIA", "CROATIA", "SIPRUS", "CYPRUS", "CEKO")
replace region = 1 if inlist(dest_name, "REPUBLIK CEKO", "CZECH REPUBLIC", "CZECHIA", "DENMARK", "ESTONIA", "FINLANDIA", "FINLAND", "PERANCIS", "FRANCE")
replace region = 1 if inlist(dest_name, "JERMAN", "GERMANY", "YUNANI", "GREECE", "HONGARIA", "HUNGARY", "IRLANDIA", "IRELAND", "ITALIA")
replace region = 1 if inlist(dest_name, "ITALY", "LATVIA", "LITHUANIA", "LITUANIA", "LUKSEMBURG", "LUXEMBOURG", "MALTA", "BELANDA", "NETHERLANDS")
replace region = 1 if inlist(dest_name, "POLANDIA", "POLAND", "PORTUGAL", "ROMANIA", "RUMANIA", "SLOWAKIA", "SLOVAKIA", "SLOVENIA", "SPANYOL")
replace region = 1 if inlist(dest_name, "SPAIN", "SWEDIA", "SWEDEN")
replace region = 2 if inlist(dest_name, "AMERIKA SERIKAT", "AMERIKA", "UNITED STATES", "UNITED STATES OF AMERICA", "USA", "AS", "GUAM")
replace region = 2 if inlist(dest_name, "KEPULAUAN TERLUAR KECIL AMERIKA SERIKAT")
replace region = 3 if inlist(dest_name, "CHINA", "TIONGKOK", "CINA", "RRC", "REPUBLIK RAKYAT CHINA", "REPUBLIK RAKYAT TIONGKOK", "PEOPLES REPUBLIC OF CHINA")
replace region = 4 if inlist(dest_name, "SINGAPURA", "SINGAPORE", "MALAYSIA", "THAILAND", "THAILAN", "FILIPINA", "PHILIPPINES", "VIETNAM", "VIET NAM")
replace region = 4 if inlist(dest_name, "BRUNEI DARUSSALAM", "BRUNEI", "KAMBOJA", "CAMBODIA", "MYANMAR", "LAOS", "LAO PDR")
replace region = 5 if inlist(dest_name, "JEPANG", "JAPAN")
replace region = 6 if inlist(dest_name, "INDIA")
}
label define region 1 "EU" 2 "US" 3 "China" 4 "ASEAN" 5 "Japan" 6 "India" 7 "Others", replace
label values region region
* EU-27 + EFTA = "advanced / high environmental standard market" (UK not in it)
generate byte high_std = (region == 1) if exported == 1
quietly replace high_std = 1 if inlist(dest_name, "ISLANDIA", "ICELAND", "LIECHTENSTEIN", "NORWEGIA", "NORWAY", "SWISS", "SWITZERLAND", "SWISS (SWITZERLAND)")
display as text "Destinations placed in Others (check that none of them belongs to a region):"
tabulate dest_name if region == 7, sort

* ---- per-year summary ---------------------------------------------------------------
foreach y of local years {
    quietly count if year == `y'
    pm_note proman `y' "rows kept" r(N)
    quietly count if year == `y' & kipb != ""
    pm_note proman `y' "rows with Kipb" r(N)
    quietly count if year == `y' & kab != ""
    pm_note proman `y' "rows with district" r(N)
    quietly count if year == `y' & exported == 1
    pm_note proman `y' "exported product rows" r(N)
}

* ---- save ---------------------------------------------------------------
label variable kipb          "Kipb (firm ID), cleaned; blank when masked or missing"
label variable prov          "Province code (2 digits)"
label variable kab           "District code (2 digits within the province); blank when masked"
label variable kbli5         "Firm KBLI 5-digit as reported in the roster"
label variable kbki          "Product code (KBKI)"
label variable val_prod      "Production value of the product (as reported)"
label variable volume        "Quantity (units differ by product: see unit)"
label variable exp_pct       "Export share of the product's production value (%)"
label variable share_rescaled "1 = the year's shares were fractions, multiplied by 100"
label variable exported      "1 = product exported (positive share or a named destination)"
label variable share_unknown "1 = exported but no usable share, so exported value is missing"
label variable val_export    "Exported value = val_prod x exp_pct / 100"
label variable dest_name     "Main destination country"
label variable region        "Destination region"
label variable high_std      "1 = destination in EU-27 + EFTA"
label variable flag          "Roster flag as reported"
order year kipb prov kab kbli5 product kbki unit volume val_prod exp_pct exported share_unknown ///
      val_export dest_name dest_code region high_std flag share_rescaled source_file source_sheet source_row
compress
save "$PM_OUT/proman_rows.dta", replace
display as result "Proman rows: " _N " -> $PM_OUT/proman_rows.dta"
pm_notes_save 02
