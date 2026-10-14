/*==========================================================================
  01  Intake: find, read and map every roster file
  Input : every .xlsx / .xls / .csv / .dta in "Data Roster Produksi/" and its
          sub-folders (one level)
  Output: output/proman_std.dta, output/bahanbaku_std.dta
              all files of a roster stacked, every item as TEXT, plus
              year, source_file, source_sheet, source_row
          output/intake_report.csv -- 1 row = 1 file: roster, sheet, header
              row, rows read, years, item=header used, items not found, and
              all normalised headers of the file

  How a file is read (nothing depends on column order or letter case):
    1. roster from the file name (_column_map.do: PM_FILE_BB, PM_FILE_PROMAN);
       files that are neither are skipped and listed
    2. year from the file name (2021 / Proman21) or from a year column
    3. every sheet is tried; the sheet whose header row matches most known
       headers is used; the header row may be below title rows
    4. columns get their item names from _column_map.do
  The run STOPS (with the list of headers seen) if a required item is not
  found or a file has no year: fix _column_map.do and run again.
==========================================================================*/
if "$PM" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
foreach f in proman_std bahanbaku_std {
    capture erase "$PM_OUT/`f'.dta"
}
local notes : dir "$PM_OUT" files "_notes_*.dta"
foreach f of local notes {
    capture erase "$PM_OUT/`f'"
}
pm_notes_start

capture frame drop pmintake
frame create pmintake str10 roster str244 file str80 sheet int header_row int match_score ///
    long rows int year_min int year_max int file_year double kipb_fill_pct double kab_fill_pct ///
    str2000 mapping str500 not_found str2000 headers

tempfile PMstack BBstack
local n_PM 0
local n_BB 0

* ---- every file in the folder and its sub-folders ----------------------------
local dirs `""$PM_RAW""'
local subs : dir "$PM_RAW" dirs "*"
foreach d of local subs {
    local dirs `"`dirs' "$PM_RAW/`d'""'
}
foreach dir of local dirs {
    local files : dir "`dir'" files "*"
    foreach f of local files {
        * hidden files and Excel lock files (~$...) are not data
        if inlist(substr(`"`f'"', 1, 1), ".", "~") continue
        local ext = lower(substr("`f'", strrpos("`f'", ".") + 1, .))
        if !inlist("`ext'", "xlsx", "xls", "csv", "dta") continue
        local base = substr("`f'", 1, strrpos("`f'", ".") - 1)
        local nf = ustrregexra(lower("`base'"), "[^a-z0-9]", "")

        * ---- which roster? ----
        local R ""
        foreach w of global PM_FILE_BB {
            if strpos("`nf'", "`w'") local R "BB"
        }
        if "`R'" == "" {
            foreach w of global PM_FILE_PROMAN {
                if strpos("`nf'", "`w'") local R "PM"
            }
        }
        if "`R'" == "" {
            display as text "  skipped (name is neither Proman nor Bahan Baku): `f'"
            continue
        }
        local rname = cond("`R'" == "PM", "proman", "bahanbaku")

        * ---- year from the file name ----
        local fyear ""
        if ustrregexm("`nf'", "20(1[0-9]|2[0-2])") local fyear = 2000 + real(ustrregexs(1))
        else if ustrregexm("`nf'", "(proman|bahanbaku|bahan|produksi|produk|bb)([0-9]{2})") local fyear = 2000 + real(ustrregexs(2))
        local yy = cond("`fyear'" != "", substr("`fyear'", 3, 2), "")

        display _newline as result "== `rname' | `f' | year from name: `fyear'"

        * ---- read, find the header row, map the columns ----
        pm_readfile `"`dir'/`f'"' "`ext'" `R' "`yy'"
        local sheet `"`r(sheet)'"'
        local hrow = r(hrow)
        local score = r(score)
        if `score' < 3 {
            display as error "  no header row found in `f' (best row matches `score' known headers)."
            display as error "  Check the file, or add its headers to _column_map.do."
            exit 459
        }
        display as text "  sheet: `sheet' | header row: `hrow' | known headers in it: `score'"
        pm_mapcols `R' "`yy'" `hrow'
        local mapping `"`r(mapping)'"'
        local missing "`r(missing)'"
        local headers "`r(headers)'"
        display as text "  mapped: `mapping'"
        if "`missing'" != "" display as text "  not found: `missing'"

        * required items
        local req_missing ""
        foreach k of global `R'_REQUIRED {
            local isin : list k in missing
            if `isin' local req_missing `req_missing' `k'
        }
        if "`R'" == "BB" {
            local nv 0
            foreach k in val_local val_import val_total {
                local isin : list k in missing
                if !`isin' local ++nv
            }
            if `nv' == 0 local req_missing `req_missing' val_local/val_import/val_total
        }
        if "`req_missing'" != "" {
            display as error "  REQUIRED item(s) not found in `f': `req_missing'"
            display as error "  Headers in this file (normalised): `headers'"
            display as error "  Add the right header to the x_ list of that item in _column_map.do, then run again."
            exit 459
        }

        * ---- drop empty rows ----
        local items ""
        foreach k of global `R'_CONCEPTS {
            quietly replace `k' = ustrtrim(`k')
            local items `items' `k'
        }
        generate long source_row = _n + `hrow'
        tempvar empty
        egen `empty' = rownonmiss(`items'), strok
        quietly drop if `empty' == 0
        drop `empty'

        * ---- year: column first, file name otherwise ----
        quietly generate int yr = real(ustrregexra(year, "[^0-9]", ""))
        quietly replace yr = 2000 + yr if yr < 100
        if "`fyear'" != "" {
            quietly count if !missing(yr) & yr != `fyear'
            if r(N) > 0 pm_note `rname' `fyear' "year column differs from the year in the file name (column used): `f'" r(N)
            quietly replace yr = `fyear' if missing(yr)
        }
        quietly count if missing(yr)
        if r(N) > 0 {
            display as error "  `r(N)' rows of `f' have no year (no year in the file name, no usable year column)."
            display as error "  Rename the file with its year (e.g. Proman2015.xlsx) or check the year column."
            exit 459
        }
        drop year
        rename yr year

        * ---- fill rates of the merge-key parts ----
        quietly count
        local nrows = r(N)
        quietly count if !inlist(ustrtrim(kipb), "", "***", "*", "**", ".", "-")
        local kipb_fill = 100 * r(N) / max(`nrows', 1)
        quietly count if !inlist(ustrtrim(kab), "", "***", "*", "**", ".", "-")
        local kab_fill = 100 * r(N) / max(`nrows', 1)
        quietly summarize year
        local ymin = r(min)
        local ymax = r(max)
        display as text "  rows: `nrows' | years `ymin'-`ymax' | Kipb filled: " %5.1f `kipb_fill' "% | district filled: " %5.1f `kab_fill' "%"

        generate str244 source_file = substr(`"`dir'/`f'"', strlen("$PM_RAW") + 2, .)
        generate str80 source_sheet = `"`sheet'"'
        order year source_file source_sheet source_row
        if `n_`R'' > 0 quietly append using ``R'stack', force
        quietly save ``R'stack', replace
        local ++n_`R'

        local fy = cond("`fyear'" == "", ".", "`fyear'")
        frame post pmintake ("`rname'") (substr(`"`dir'/`f'"', strlen("$PM_RAW") + 2, .)) (`"`sheet'"') (`hrow') (`score') ///
            (`nrows') (`ymin') (`ymax') (`fy') (`kipb_fill') (`kab_fill') ///
            (substr(`"`mapping'"', 1, 2000)) ("`missing'") (substr("`headers'", 1, 2000))
    }
}

* ---- save ------------------------------------------------------------------
if `n_PM' + `n_BB' == 0 {
    display as error "No Proman or Bahan Baku file found in $PM_RAW"
    exit 601
}
foreach R in PM BB {
    local rname = cond("`R'" == "PM", "proman", "bahanbaku")
    if `n_`R'' == 0 {
        display as error "No `rname' file found: the merge continues without it."
        continue
    }
    use ``R'stack', clear
    * the same row twice (e.g. a file saved as .xlsx AND .csv) is reported, not dropped
    local cc ${`R'_CONCEPTS}
    local yw year
    local cc : list cc - yw
    quietly duplicates tag year `cc', generate(__dup)
    quietly levelsof year, local(ys)
    foreach y of local ys {
        quietly count if year == `y'
        pm_note `rname' `y' "rows read" r(N)
        quietly levelsof source_file if year == `y', local(fl)
        local nfl : word count `fl'
        pm_note `rname' `y' "files" `nfl'
        quietly count if year == `y' & __dup > 0
        if r(N) > 0 pm_note `rname' `y' "rows that appear more than once, identical (kept; check for a duplicated file)" r(N)
    }
    drop __dup
    compress
    save "$PM_OUT/`rname'_std.dta", replace
    display as result "`rname': " _N " rows from `n_`R'' file(s) -> $PM_OUT/`rname'_std.dta"
}

frame pmintake {
    sort roster file
    export delimited using "$PM_OUT/intake_report.csv", replace
    list roster file sheet header_row rows year_min year_max kipb_fill_pct kab_fill_pct, clean noobs abbreviate(14)
}
frame drop pmintake
pm_notes_save 01
