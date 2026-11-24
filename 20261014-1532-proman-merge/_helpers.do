/*==========================================================================
  _helpers.do -- programs used by 01-06 (loaded by 00_run.do)

    pm_normhead   normalise one column header (see _column_map.do)
    pm_headscore  find the header row: the row whose cells match most known headers
    pm_readfile   read one roster file (xlsx / xls / csv / dta) as text,
                  choosing the sheet with the best header row
    pm_mapcols    give the columns their item names from the header row
    pm_num        text -> number, robust to "1.234.567,89", "1,234,567",
                  "12,5", "45%", "Rp", "***", "-", blanks
    pm_code       text -> clean code (kipb / prov / kab / kbli5)
    pm_notes_start, pm_note, pm_notes_save
                  collect "what happened" counts for output/cleaning_report.csv
==========================================================================*/
version 17
set varabbrev off

* ---------------------------------------------------------------------------
capture program drop pm_normhead
program define pm_normhead, rclass
    args h yy
    local n = ustrregexra(lower(`"`h'"'), "[^a-z0-9]", "")
    * a trailing 4-digit year 2010-2022 (e.g. kbli2015, nilai2021)
    if ustrregexm("`n'", "^(.+?)20(1[0-9]|2[0-2])$") {
        local n = ustrregexs(1)
    }
    * or the file's own 2-digit year (Nilpro22, Volok21, Kbli522)
    else if "`yy'" != "" & strlen("`n'") > 2 {
        if substr("`n'", -2, 2) == "`yy'" local n = substr("`n'", 1, strlen("`n'") - 2)
    }
    return local n "`n'"
end

* ---------------------------------------------------------------------------
* pm_headscore R yy maxrow : data in memory = raw cells as text
capture program drop pm_headscore
program define pm_headscore, rclass
    args R yy maxrow
    local allx ""
    local allc ""
    foreach k of global `R'_CONCEPTS {
        local allx `allx' ${`R'_x_`k'}
        local allc `allc' ${`R'_c_`k'}
    }
    local best 0
    local bestrow 0
    local last = min(`maxrow', _N)
    forvalues row = 1/`last' {
        local sc 0
        foreach v of varlist _all {
            capture confirm string variable `v'
            if _rc continue
            local h = substr(`v'[`row'], 1, 200)
            if `"`h'"' == "" continue
            pm_normhead `"`h'"' "`yy'"
            local n "`r(n)'"
            if "`n'" == "" continue
            local hit : list n in allx
            if !`hit' {
                foreach c of local allc {
                    if strpos("`n'", "`c'") {
                        local hit 1
                        continue, break
                    }
                }
            }
            local sc = `sc' + `hit'
        }
        if `sc' > `best' {
            local best `sc'
            local bestrow `row'
        }
    }
    return scalar score = `best'
    return scalar row   = `bestrow'
end

* ---------------------------------------------------------------------------
* pm_readfile path ext R yy : leaves every cell as text, returns r(sheet)
* r(hrow) r(score). The header row is NOT applied yet (see pm_mapcols).
capture program drop pm_readfile
program define pm_readfile, rclass
    args path ext R yy
    if inlist("`ext'", "xlsx", "xls") {
        quietly import excel using `"`path'"', describe
        local nsh = r(N_worksheet)
        forvalues s = 1/`nsh' {
            local sh`s' `"`r(worksheet_`s')'"'
        }
        local best -1
        local bestsheet ""
        forvalues s = 1/`nsh' {
            capture quietly import excel using `"`path'"', sheet(`"`sh`s''"') cellrange(A1:CZ30) allstring clear
            if _rc capture quietly import excel using `"`path'"', sheet(`"`sh`s''"') allstring clear
            if _rc continue
            if _N == 0 continue
            pm_headscore `R' "`yy'" 30
            if r(score) > `best' {
                local best = r(score)
                local bestsheet `"`sh`s''"'
            }
        }
        if `"`bestsheet'"' == "" {
            display as error "  cannot read any sheet of `path'"
            exit 459
        }
        quietly import excel using `"`path'"', sheet(`"`bestsheet'"') allstring clear
        return local sheet `"`bestsheet'"'
    }
    else if "`ext'" == "csv" {
        quietly import delimited using `"`path'"', varnames(nonames) stringcols(_all) clear
        if c(k) == 1 quietly import delimited using `"`path'"', varnames(nonames) stringcols(_all) delimiters(";") clear
        if c(k) == 1 quietly import delimited using `"`path'"', varnames(nonames) stringcols(_all) delimiters(tab) clear
        return local sheet "csv"
    }
    else if "`ext'" == "dta" {
        use `"`path'"', clear
        foreach v of varlist _all {
            capture confirm string variable `v'
            if _rc quietly tostring `v', replace force format(%20.0g)
        }
        * the variable names become the first row, like a spreadsheet header
        quietly set obs `=_N + 1'
        generate long __o = _n
        quietly replace __o = 0 in l
        sort __o
        drop __o
        foreach v of varlist _all {
            quietly replace `v' = "`v'" in 1
        }
        return local sheet "dta"
    }
    else {
        display as error "  unknown file type: `ext'"
        exit 198
    }
    pm_headscore `R' "`yy'" 30
    return scalar hrow  = r(row)
    return scalar score = r(score)
end

* ---------------------------------------------------------------------------
* pm_mapcols R yy hrow : rename columns to item names, drop the rest and the
* rows above and including the header. Returns r(mapping) r(missing) r(headers).
capture program drop pm_mapcols
program define pm_mapcols, rclass
    args R yy hrow
    local vars ""
    local heads ""
    foreach v of varlist _all {
        capture confirm string variable `v'
        if _rc quietly tostring `v', replace force
        local h = substr(`v'[`hrow'], 1, 200)
        pm_normhead `"`h'"' "`yy'"
        local n_`v' "`r(n)'"
        local h_`v' = ustrregexra(`"`h'"', "[;=]", " ")
        local vars `vars' `v'
        if "`r(n)'" != "" local heads `heads' `r(n)'
    }
    foreach k of global `R'_CONCEPTS {
        local got_`k' ""
    }
    local used ""
    * phase 1: exact names, item by item
    foreach k of global `R'_CONCEPTS {
        foreach cand of global `R'_x_`k' {
            if "`got_`k''" != "" continue, break
            foreach v of local vars {
                local isused : list v in used
                if !`isused' & "`n_`v''" == "`cand'" {
                    local got_`k' `v'
                    local used `used' `v'
                    continue, break
                }
            }
        }
    }
    * phase 2: "contains" patterns for the items still empty
    foreach k of global `R'_CONCEPTS {
        if "`got_`k''" != "" continue
        foreach pat of global `R'_c_`k' {
            if "`got_`k''" != "" continue, break
            foreach v of local vars {
                local isused : list v in used
                if !`isused' & "`n_`v''" != "" & strpos("`n_`v''", "`pat'") {
                    local got_`k' `v'
                    local used `used' `v'
                    continue, break
                }
            }
        }
    }
    * rename, keep only the items
    local mapping ""
    local missing ""
    foreach k of global `R'_CONCEPTS {
        if "`got_`k''" != "" {
            local hh `"`h_`got_`k'''"'
            local mapping `"`mapping'`k'=`hh'; "'
            rename `got_`k'' __c_`k'
        }
        else local missing `missing' `k'
    }
    capture describe __c_*, varlist
    if _rc {
        display as error "  no column could be matched to any item"
        exit 459
    }
    keep __c_*
    quietly drop in 1/`hrow'
    rename __c_* *
    foreach k of local missing {
        quietly generate str1 `k' = ""
    }
    return local mapping `"`mapping'"'
    return local missing "`missing'"
    return local headers "`heads'"
end

* ---------------------------------------------------------------------------
* pm_num textvar, generate(newvar) : robust text -> number.
* r(nfail) = non-empty cells that are still not a number;
* r(nreformat) = cells whose separators were reinterpreted.
capture program drop pm_num
program define pm_num, rclass
    syntax varname(string), GENerate(name)
    tempvar s ld lc fl
    quietly {
        generate `s' = ustrupper(ustrtrim(`varlist'))
        replace `s' = ustrregexra(`s', "[\s ]", "")
        replace `s' = subinstr(`s', "RP.", "", .)
        replace `s' = subinstr(`s', "RP", "", .)
        replace `s' = subinstr(`s', "%", "", .)
        replace `s' = "" if ustrregexm(`s', "^[\*xX\-\.]*$")
        replace `s' = "" if inlist(`s', "NA", "N/A", "#N/A", "NULL", "NAN", "NONE", "#VALUE!", "#DIV/0!")
        generate long `ld' = strrpos(`s', ".")
        generate long `lc' = strrpos(`s', ",")
        generate byte `fl' = 0
        replace `fl' = 1 if `ld' > 0 & `lc' > `ld'                                         // 1.234,56
        replace `fl' = 2 if `lc' > 0 & `ld' > `lc'                                         // 1,234.56
        replace `fl' = 3 if `ld' == 0 & `lc' > 0 & ustrregexm(`s', "^-?[0-9]{1,3}(,[0-9]{3})+$") // 1,234,567
        replace `fl' = 4 if `ld' == 0 & `lc' > 0 & `fl' == 0                               // 12,5
        replace `fl' = 5 if `lc' == 0 & ustrregexm(`s', "^-?[0-9]{1,3}(\.[0-9]{3}){2,}$")   // 1.234.567
        replace `s' = subinstr(subinstr(`s', ".", "", .), ",", ".", .) if `fl' == 1
        replace `s' = subinstr(`s', ",", "", .)                         if inlist(`fl', 2, 3)
        replace `s' = subinstr(`s', ",", ".", .)                        if `fl' == 4
        replace `s' = subinstr(`s', ".", "", .)                         if `fl' == 5
        generate double `generate' = real(`s')
        count if `s' != "" & missing(`generate')
        local nfail = r(N)
        count if inlist(`fl', 1, 3, 4, 5)
        local nref = r(N)
    }
    return scalar nfail = `nfail'
    return scalar nreformat = `nref'
end

* ---------------------------------------------------------------------------
* pm_code textvar, generate(newvar) type(kipb|prov|kab|kbli5)
* The SAME rules are applied to the rosters and to the ready-to-use file, so
* the keys match even if one side stored them as numbers.
*   kipb : upper case, no spaces, "12345.0" -> "12345", leading zeros of an
*          all-digit ID dropped, scientific notation expanded
*   prov : 2 digits ("3" -> "03"; "3301" -> "33")
*   kab  : 2 digits of the district ("3301" -> "01"; "1" -> "01")
*   kbli5: first 5 digits ("10101.0" -> "10101")
* masked or empty values ("***", "-", ".", "NA") become "".
* r(nbad) = values without any digit (e.g. a province NAME), set to ""
* r(nlong), r(nshort) = codes longer / shorter than expected
capture program drop pm_code
program define pm_code, rclass
    syntax varname(string), GENerate(name) TYPE(string)
    tempvar s
    local nbad 0
    local nlong 0
    local nshort 0
    quietly {
        generate `s' = ustrupper(ustrtrim(`varlist'))
        replace `s' = ustrregexra(`s', "[\s ]", "")
        replace `s' = string(real(`s'), "%20.0f") if ustrregexm(`s', "^[0-9.]+E\+?[0-9]+$") & real(`s') < .
        replace `s' = ustrregexra(`s', "\.0+$", "")
        replace `s' = "" if ustrregexm(`s', "^[\*xX\-\.]*$")
        replace `s' = "" if inlist(`s', "NA", "N/A", "NULL", "NAN", "NONE")
        if "`type'" == "kipb" {
            replace `s' = ustrregexra(`s', "^0+", "") if ustrregexm(`s', "^[0-9]+$")
        }
        else {
            count if `s' != "" & !ustrregexm(`s', "[0-9]")
            local nbad = r(N)
            replace `s' = ustrregexra(`s', "[^0-9]", "")
            if inlist("`type'", "prov", "kab") {
                replace `s' = "0" + `s' if strlen(`s') == 1
                count if strlen(`s') > 2
                local nlong = r(N)
                if "`type'" == "prov" replace `s' = substr(`s', 1, 2) if strlen(`s') > 2
                if "`type'" == "kab"  replace `s' = substr(`s', -2, 2) if strlen(`s') > 2
            }
            if "`type'" == "kbli5" {
                count if strlen(`s') > 0 & strlen(`s') < 5
                local nshort = r(N)
                count if strlen(`s') > 5
                local nlong = r(N)
                replace `s' = substr(`s', 1, 5) if strlen(`s') > 5
            }
        }
        generate `generate' = `s'
    }
    return scalar nbad   = `nbad'
    return scalar nlong  = `nlong'
    return scalar nshort = `nshort'
end

* ---------------------------------------------------------------------------
* notes: one row per (roster, year, item) count; saved per step and gathered
* into output/cleaning_report.csv by 06_checks.do
capture program drop pm_notes_start
program define pm_notes_start
    capture frame drop pmnotes
    frame create pmnotes str10 roster int year str120 item double n
end

capture program drop pm_note
program define pm_note
    args roster year item n
    * evaluate the count first (callers may pass r(N); later commands reset r())
    if "`n'" != "" local n = `n'
    capture frame pmnotes: describe
    if _rc pm_notes_start
    if "`year'" == "" local year .
    if "`n'" == "" local n .
    frame post pmnotes ("`roster'") (`year') (`"`item'"') (`n')
    display as text "  [`roster' `year'] `item': " as result `n'
end

capture program drop pm_notes_save
program define pm_notes_save
    args step
    capture frame pmnotes: describe
    if _rc exit
    frame pmnotes: generate str4 step = "`step'"
    frame pmnotes: quietly save "$PM_OUT/_notes_`step'.dta", replace
    frame drop pmnotes
end

* ---------------------------------------------------------------------------
* pm_mainkeys : the ready-to-use file is in memory. Creates the key parts
* __kipb __prov __kab __kbli (text, blank if the variable does not exist)
* with the SAME rules as the rosters (pm_code).
capture program drop pm_mainkeys
program define pm_mainkeys
    foreach p in kipb prov kab kbli {
        local src ""
        if "`p'" == "kipb" local src "$PM_KIPB"
        if "`p'" == "prov" local src "$PM_MAIN_PROV"
        if "`p'" == "kab"  local src "$PM_MAIN_KAB"
        if "`p'" == "kbli" local src "$PM_MAIN_KBLI"
        local typ = cond("`p'" == "kbli", "kbli5", "`p'")
        capture confirm variable `src', exact
        if _rc | "`src'" == "" {
            quietly generate str1 __`p' = ""
            continue
        }
        tempvar t
        capture confirm string variable `src'
        if _rc quietly generate `t' = string(`src', "%20.0f") if !missing(`src')
        else   quietly generate `t' = `src'
        pm_code `t', generate(__`p') type(`typ')
        drop `t'
    }
end
