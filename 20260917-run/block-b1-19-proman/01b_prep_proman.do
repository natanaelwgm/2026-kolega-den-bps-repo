/*==========================================================================
  Line 1 (part b)  Prepare the Proman (production) roster, 2021 & 2022
  Input : $ROSTER/Proman2021_sampel.xlsx, Proman2022_sampel.xlsx
  Output: data/b19_pm_rows.dta -- 1 row = 1 product x firm x year
          data/b19_pm_firm.dta -- 1 row = 1 firm x year

  EXPORTS IN THE ROSTER:
    export share (% of the product's own production value that is exported):
      2021 column Prprex, 2022 column Ekspor
    destination country: 2021 Namaneg (+ code Kodeneg), 2022 Negara (+ Kodeneg)
    - A BLANK export share means the product is not exported (it is never
      coded 0). 2021 also marks non-exporters with Namaneg == "NO".
    - A product is exported if it has a positive share OR a named foreign
      destination. Shares outside 0-100 are set missing (4 rows in 2021).
    - Exported value = production value x share / 100. It is missing when a
      product names a destination but has no usable share (share_unknown = 1).
    - "INDONESIA" as a destination is not an export destination -> blanked.

  ABOUT THE FIRM ID (Kipb):
    In the sample files Kipb is masked ("***"), so rows cannot be grouped
    by firm. For now a "firm" is a CELL = year x province x 5-digit KBLI
    (firm_key). In the real BPS data Kipb is present, so firm_key = Kipb
    automatically and every table becomes a true firm-level table.
    Check variable key_type: "kipb" or "cell".

  If the column names differ in the real files, edit the "rename" lines only.
==========================================================================*/
if "$B19" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 2021 -------------------------------------------------------------
* Columns: No Kipb Prop Kab Komoditi Kodkbki Deskbki Desing Kbli5kom Kodesat
*          Satuan Volume Nilai Hps Prprex Namaneg Kodeneg Kbli Flg21 Kneglain
import excel using "$ROSTER/Proman2021_sampel.xlsx", firstrow allstring clear
rename (Kipb Prop Komoditi Kodkbki Kbli Nilai Prprex Namaneg Kodeneg) ///
       (kipb prov_s product kbki kbli5 val_prod exp_pct dest_name dest_code)
generate year = 2021
keep year kipb prov_s product kbki kbli5 val_prod exp_pct dest_name dest_code
tempfile pm21
save `pm21'

* ---- 2022 -------------------------------------------------------------
* Columns: No Kip Prop Kab Komoditi Kodesat Satuan Volpro22 Nilpro22 Kodekbki
*          KBKIDESK Ekspor Kodeneg Negara Neglain Kbli522 Flagpr22
import excel using "$ROSTER/Proman2022_sampel.xlsx", firstrow allstring clear
rename (Kip Prop Komoditi Kodekbki Kbli522 Nilpro22 Ekspor Negara Kodeneg) ///
       (kipb prov_s product kbki kbli5 val_prod exp_pct dest_name dest_code)
generate year = 2022
keep year kipb prov_s product kbki kbli5 val_prod exp_pct dest_name dest_code
append using `pm21'

* ---- clean values -----------------------------------------------------
destring val_prod exp_pct, replace force
count if val_prod <= 0 | missing(val_prod)
display as result "Rows with no production value (dropped): " r(N)
drop if val_prod <= 0 | missing(val_prod)
count if exp_pct < 0 | exp_pct > 100 & !missing(exp_pct)
display as result "Export shares outside 0-100 (set missing): " r(N)
replace exp_pct = . if exp_pct < 0 | exp_pct > 100

* ---- destination country ----------------------------------------------
replace dest_name = strtrim(upper(dest_name))
replace dest_code = strtrim(dest_code)
* "NO" (2021) = not exported; "INDONESIA" is not a foreign destination
replace dest_code = "" if inlist(dest_name, "NO", "INDONESIA", "*", "***", ".")
replace dest_name = "" if inlist(dest_name, "NO", "INDONESIA", "*", "***", ".")
* some rows have only the code -> fill the name from rows with the same code
bysort dest_code (dest_name): replace dest_name = dest_name[_N] if dest_name == "" & dest_code != ""
replace dest_name = "CODE " + dest_code if dest_name == "" & dest_code != ""

* ---- exported or not --------------------------------------------------
generate exported = (exp_pct > 0 & !missing(exp_pct)) | dest_name != ""
replace  exp_pct = 0 if exported == 0
generate share_unknown = (exported == 1 & missing(exp_pct))
replace  dest_name = "(not reported)" if exported == 1 & dest_name == ""
generate val_export   = val_prod * exp_pct / 100
generate val_domestic = val_prod - val_export
count if share_unknown == 1
display as result "Exported rows with no usable share (value unknown): " r(N)

generate prov  = real(prov_s)
generate kbli2 = real(substr(kbli5, 1, 2))
generate java  = inlist(prov, 31, 32, 33, 34, 35, 36) if !missing(prov)
label define java 0 "Outside Java" 1 "Java"
label values java java

* ---- firm_key: Kipb if available, otherwise the cell ------------------
count if kipb != "***" & kipb != ""
if r(N) > 0 {
    generate firm_key = kipb
    generate key_type = "kipb"
}
else {
    generate firm_key = string(year) + "_" + prov_s + "_" + kbli5
    generate key_type = "cell"
    display as error "Kipb is masked -> firm_key = cell (year x province x KBLI5)"
}

label variable exp_pct       "Export share of the product's production value (%)"
label variable exported      "1 = product exported (positive share or a named destination)"
label variable share_unknown "1 = exported but no usable share, so exported value is missing"
order year firm_key key_type prov java kbli5 kbli2 product kbki val_prod exp_pct exported ///
      val_export val_domestic share_unknown dest_name dest_code
compress
save "$B19_DATA/b19_pm_rows.dta", replace
display as result "Proman rows: " _N " -> $B19_DATA/b19_pm_rows.dta"

* ---- firm level (firm_key x year) --------------------------------------
generate one = 1
collapse (sum) val_prod val_export n_products = one n_exported = exported ///
         n_unknown = share_unknown (firstnm) prov java kbli5 kbli2 key_type, by(firm_key year)
generate any_export = (n_exported > 0)
label define any_export 0 "Domestic only" 1 "Exporter"
label values any_export any_export
label values java java
* firm export share; missing if any exported product has no usable share
generate exp_share = 100 * val_export / val_prod if n_unknown == 0
replace  val_export = . if n_unknown > 0
generate val_domestic = val_prod - val_export

* orientation (line 2). Change the 50 cut-off here if needed.
generate orient = 0 if any_export == 0
replace  orient = 1 if any_export == 1 & exp_share <  50
replace  orient = 2 if any_export == 1 & exp_share >= 50 & !missing(exp_share)
label define orient 0 "Domestic only" 1 "Mainly domestic (exports <50%)" 2 "Export-oriented (>=50%)"
label values orient orient

label variable n_products "Number of product rows"
label variable exp_share  "Exported / production value (%), missing if a share is unknown"
order year firm_key key_type prov java kbli5 kbli2 any_export orient exp_share val_prod val_export val_domestic
compress
save "$B19_DATA/b19_pm_firm.dta", replace
display as result "Proman by firm: " _N " -> $B19_DATA/b19_pm_firm.dta"
