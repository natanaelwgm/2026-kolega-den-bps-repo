/*==========================================================================
  R3-08  Which firms import more environmental goods (solar panels and the
         like)? This file checks whether the data can answer that, and
         writes a one-row table saying why it cannot (unavailable exhibit).
  Answers Deasy R3: "Tambahan: Siapa yang impor lebih banyak (EGs)
         environment goods list (termasuk solar panel, dll)"
  Output : tables/08_environmental_goods_imports_unavailable.csv (no figure)
  Development data — obscured values, fictional firm panel. Not BPS findings.
==========================================================================*/
version 17
args data_arg outdir_arg        // optional: 00_run.do passes the two paths
clear all
set more off
set varabbrev off
set linesize 120
set type double                 // new variables keep full precision

* ---- EDIT THESE TWO LINES IF YOUR FOLDERS ARE ELSEWHERE -------------------
global DATA   "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-0-data-preparation/analysis_ready_data.dta"
global OUTDIR "/Users/natanaelmassie/Downloads/2026-kolega-den-bps-repo/20260917-run/block-r3-energy-emissions-correlates"
* ---------------------------------------------------------------------------
if `"`data_arg'"'   != "" global DATA   `"`data_arg'"'
if `"`outdir_arg'"' != "" global OUTDIR `"`outdir_arg'"'
cd "$OUTDIR"
foreach d in figures tables logs {
    capture mkdir "`d'"
}
cap log close
log using "logs/08_environmental_goods_imports.log", replace text
timer clear 1
timer on 1
display _newline "=== [R3-08] STARTING: can this data say who imports environmental goods (solar panels etc.)? ==="

* No chart in this file, so the chart style block (scheme, font) is left out.
local devnote "Development data — obscured values, fictional firm panel. Not BPS findings."
local srcnote "Source: SI/IBS annual files 2010–2022 (masked), analysis_ready_data.dta."

*---------------------------------------------------------------------------
display "Step 1/4: look for any product-level import variable (names and labels)"
*---------------------------------------------------------------------------
* Answering Deasy needs imports broken down by PRODUCT (e.g. HS codes, the
* international customs product codes). We load one row only: enough to read
* every variable name and label. A hit below is only a CANDIDATE for a person
* to check. We do not search the single word "solar": in Indonesian it also
* means diesel fuel.
use in 1 using "$DATA", clear
local cand ""
foreach p in hs* *_hs* *btki* *commod* *komod* *prodcode* *product_code* ///
             *kode_barang* *egs* *envgood* *env_good* {
    capture ds `p'
    if !_rc local cand `cand' `r(varlist)'
}
foreach w in "hs code" "hs-code" "harmonized system" "harmonised system" "btki" ///
             "commodity" "komoditi" "product code" "kode barang" "kode produk" ///
             "environmental good" "photovoltaic" "solar panel" "solar cell" "tariff line" ///
             "kode hs" "panel surya" "tenaga surya" "barang lingkungan" {
    quietly lookfor `"`w'"'
    local cand `cand' `r(varlist)'
}
local cand : list uniq cand
local ncand : word count `cand'
display "   product-level candidates found: `ncand' `cand'"

* What the file DOES have on imports (names containing "import")
capture ds *import*
local impvars = cond(_rc, "", "`r(varlist)'")
display "   import variables in the file: `impvars'"

*---------------------------------------------------------------------------
display "Step 2/4: check that the file has one row per firm and year (no product lines)"
*---------------------------------------------------------------------------
* Product-level imports would come as several rows (lines) per firm-year.
use firm_id year import_value_nominal using "$DATA", clear
capture isid firm_id year
local one_row_per_firm_year = (_rc == 0)
display "   one row per firm-year: " cond(`one_row_per_firm_year', "yes", "NO - check for product lines")
quietly count
local n_rows = r(N)
quietly count if import_value_nominal > 0 & !missing(import_value_nominal)
local n_imp = r(N)
quietly levelsof year, local(yrs) separate(" ")   // survey years present

*---------------------------------------------------------------------------
display "Step 3/4: decide the status"
*---------------------------------------------------------------------------
if `ncand' == 0 & `one_row_per_firm_year' {
    local status "unavailable"
    display "   status: unavailable (no product-level import information)"
}
else {
    local status "check_candidates"
    display as error "   status: CHECK BY HAND - possible product-level import information: `cand'"
    if !`one_row_per_firm_year' display as error "   the file has more than one row per firm-year"
}

*---------------------------------------------------------------------------
display "Step 4/4: write the one-row table"
*---------------------------------------------------------------------------
* The answer text follows the status, so the table never says "not available"
* while a possible item-by-item import variable still waits for a person to check it.
if "`status'" == "unavailable" {
    local answer "Not available in this dataset. Each firm reports only one yearly total for the imported raw materials it used, with no list of what was bought, so solar panels and other environmental goods cannot be picked out."
}
else {
    local answer "NOT DECIDED - check by hand first: the data may hold item-by-item import information (see candidates_found and one_row_per_firm_year). Do not use this row until a person has looked."
}
clear
set obs 1
gen str12  exhibit  = "R3-08"
gen str20  status   = "`status'"
gen str200 deasy_request = "Tambahan: Siapa yang impor lebih banyak (EGs) environment goods list (termasuk solar panel, dll)"
gen str400 answer = "`answer'"
gen str400 what_is_missing = "a record of what each firm imported, item by item (customs product codes, e.g. the 6-digit HS code used worldwide to identify goods such as solar panels), with the amount paid, for each year"
gen str400 what_exists_instead = "one yearly total per firm of imported raw materials used (import_value_nominal; import_flag = 1 when above zero; r_ln_import_nominal = its log), with no product, country or date detail"
gen str600 why_total_cannot_stand_in = "the total mixes every imported item and cannot be split by product; the survey field map (downstream/contracts/variable_year_evidence.csv, checked against the 2010-2015 questionnaire layouts; later years use the same field code) names the source field RIMVCU = imported raw material used, so imported machines and equipment such as solar panels are probably not in it at all"
gen str600 what_would_be_needed = "(1) customs import records for each firm, item by item (product code, amount paid, date), that can be linked to the firms in this survey; (2) an agreed list of environmental goods with their product codes, e.g. the APEC list of 54 products (APEC = Asia-Pacific Economic Cooperation); (3) a table that translates product codes between versions (HS = the world customs code list, BTKI = Indonesia's version), because the codes change every few years"
gen str600 related_exhibits_not_an_answer = "NOT an answer to this question: R1 file 01_group_shares_support (share of firms importing each year) and R3 files 02 and 04 (do importers cut energy and CO2 more often?) use this same total only to mark importers of any raw material; they say nothing about environmental goods. The importer share jumps partway through the period, likely a change in how imports were recorded (see R1 file 01)."
gen str500 candidates_found = cond("`cand'" == "", "none", "`cand'")
gen str500 import_vars_in_file = "`impvars'"
gen byte   one_row_per_firm_year = `one_row_per_firm_year'
gen long   firm_years_in_file = `n_rows'
gen long   firm_years_with_imports = `n_imp'
gen str100 years_in_file = "`yrs'"
gen str120 note = "`devnote'"
gen str120 source = "`srcnote'"
compress
export delimited using "tables/08_environmental_goods_imports_unavailable.csv", replace quote
list exhibit status firm_years_in_file firm_years_with_imports one_row_per_firm_year, abbreviate(24) noobs

timer off 1
quietly timer list 1
local elapsed = strtrim(string(r(t1), "%9.1f"))
local what = cond("`status'" == "unavailable", "unavailable exhibit", "CHECK BY HAND: possible product-level import data")
display "FINISHED: table -> tables/08_environmental_goods_imports_unavailable.csv (`what') (elapsed `elapsed' s)"
quietly log close          // keeps FINISHED as the last output line of the log
