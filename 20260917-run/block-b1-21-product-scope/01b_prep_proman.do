/*==========================================================================
  Line 1 (part b)  Prepare the Proman (production) roster, 2021 & 2022
  Input : $ROSTER/Proman2021_sampel.xlsx, Proman2022_sampel.xlsx
          data/b21_si.dta (from 01a) for importer / FDI status
  Output: data/b21_pm_rows.dta -- 1 row = 1 product line x firm x year
          data/b21_pm_firm.dta -- 1 row = 1 firm x year, with
            n_products    number of distinct products            (line 2)
            hhi           product HHI of production value, 0-1   (line 3)
            core_share    largest product's share of value       (line 5)
            exp_intensity exported value / production value, %   (line 6)
            n_dest        number of export destinations          (line 7)
            exporter importer fdi   the three splits of line 8

  WHAT IS A PRODUCT: the 10-digit KBKI code; if the code is blank, the
    product name (upper case). Rows of the same product are added up.

  ABOUT THE FIRM ID (Kipb):
    In the sample files Kipb is masked ("***"). For now a "firm" is a CELL
    = province x 5-digit KBLI of the firm (firm_key, key_type = "cell").
    Unlike b1-18, the year is NOT part of firm_key, so the same cell can be
    followed from 2021 to 2022 (line 4, product entry/exit). A cell is a
    weak stand-in for a firm: it mixes all plants of that province and
    KBLI5, and plants enter or leave it. In the real BPS data Kipb is
    present and firm_key = Kipb automatically (key_type = "kipb").

  EXPORTS: 2021 export share = Prprex, destination = Namaneg ("NO" = not
    exported); 2022 export share = Ekspor, destination = Negara. A blank
    export share means not exported. Only ONE (main) destination per
    product line is recorded (the "other countries" column is empty).

  IMPORTER / FDI (line 8) come from the SI panel, merged on the cell
    year x province x KBLI5. RULE: a roster firm is an importer (FDI) if at
    least half of the clean SI plants in its cell import (are FDI).
    Roster firms with no SI plant in their cell get a missing status.
    SI has no Kipb, so this stays a cell merge even on the real data
    (unless BPS supplies a Kipb-PSID crosswalk).
  EXPORTER (line 8) comes from the roster itself: the firm exports at
    least one product. (The SI export flag is missing in 2022.)

  If the column names differ in the real files, edit the "rename" lines.
==========================================================================*/
if "$B21" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 2021 -------------------------------------------------------------
* Kipb Prop Komoditi Kodkbki Kbli Nilai Prprex Namaneg Kodeneg
import excel using "$ROSTER/Proman2021_sampel.xlsx", firstrow allstring clear
rename (Kipb Prop Komoditi Kodkbki Kbli Nilai Prprex Namaneg Kodeneg) ///
       (kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code)
generate year = 2021
keep year kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code
tempfile pm21
save `pm21'

* ---- 2022 -------------------------------------------------------------
* Kip Prop Komoditi Kodekbki Kbli522 Nilpro22 Ekspor Negara Kodeneg
import excel using "$ROSTER/Proman2022_sampel.xlsx", firstrow allstring clear
rename (Kip Prop Komoditi Kodekbki Kbli522 Nilpro22 Ekspor Negara Kodeneg) ///
       (kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code)
generate year = 2022
keep year kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code
append using `pm21'

* ---- clean ------------------------------------------------------------
destring val_prod exp_share, replace force
count if val_prod <= 0 | missing(val_prod)
display as result "Rows with no production value (dropped): " r(N)
drop if val_prod <= 0 | missing(val_prod)

replace prov_s = strtrim(prov_s)
replace kbli5  = strtrim(kbli5)
generate prov  = real(prov_s)
generate kbli2 = real(substr(kbli5, 1, 2))

* product = KBKI code, or the name when the code is blank
replace kbki = strtrim(kbki)
generate item = kbki
replace  item = "NAME " + upper(strtrim(product)) if item == "" | item == "0000000000"

* destination country: "NO" (2021) = not exported
replace dest_name = strtrim(upper(dest_name))
replace dest_code = strtrim(dest_code)
replace dest_name = "" if dest_name == "NO"
* export share: blank = not exported; values above 100 are capped
replace exp_share = 0   if missing(exp_share)
replace exp_share = 100 if exp_share > 100
generate exported = (exp_share > 0)
count if exported == 0 & dest_name != ""
display as result "Rows with a destination but no export share (kept as not exported): " r(N)
generate val_export = val_prod * exp_share / 100

* country name: fill from rows with the same code, else "CODE xxx"
bysort dest_code (dest_name): replace dest_name = dest_name[_N] if dest_name == "" & dest_code != "" & exported == 1
replace dest_name = "CODE " + dest_code if dest_name == "" & dest_code != "" & exported == 1
replace dest_name = "(not reported)" if dest_name == "" & exported == 1
replace dest_name = "" if exported == 0

* ---- firm_key: Kipb if available, otherwise the cell (no year) --------
count if kipb != "***" & kipb != ""
if r(N) > 0 {
    generate firm_key = kipb
    generate key_type = "kipb"
}
else {
    generate firm_key = prov_s + "_" + kbli5
    generate key_type = "cell"
    display as error "Kipb is masked -> firm_key = cell (province x KBLI5)"
}

order year firm_key key_type prov_s prov kbli5 kbli2 item kbki product val_prod exp_share exported val_export dest_name
label variable item       "Product: KBKI code, or the name when the code is blank"
label variable exp_share  "Export share of the product line, % (0 = not exported)"
label variable val_export "Exported value = val_prod x exp_share / 100"
label variable dest_name  "Main export destination"
compress
save "$B21_DATA/b21_pm_rows.dta", replace
display as result "Proman rows: " _N " -> $B21_DATA/b21_pm_rows.dta"

* ======================================================================
* Firm-level file
* ======================================================================

* ---- number of destinations per firm (reported destinations only) ----
use "$B21_DATA/b21_pm_rows.dta", clear
keep if exported == 1 & dest_name != "(not reported)"
egen tag_dest = tag(firm_key year dest_name)
collapse (sum) n_dest = tag_dest, by(firm_key year)
tempfile dest
save `dest'

* ---- products per firm: value by product, then shares ----
use "$B21_DATA/b21_pm_rows.dta", clear
collapse (sum) val_prod val_export (max) exported (first) prov_s prov kbli5 kbli2 key_type, ///
         by(firm_key year item)
bysort firm_key year: egen val_total = total(val_prod)
generate share = val_prod / val_total
generate s2 = share^2
* province and KBLI5 are the same on every row of a firm (they define the cell)
collapse (count) n_products = share (sum) hhi = s2 val_prod val_export ///
         n_prod_exported = exported (max) core_share = share exporter = exported ///
         (first) prov_s prov kbli5 kbli2 key_type, by(firm_key year)
merge 1:1 firm_key year using `dest', nogenerate
replace n_dest = 0 if missing(n_dest)

generate eff_n_products = 1 / hhi
generate exp_intensity  = 100 * val_export / val_prod
generate pct_prod_exported = 100 * n_prod_exported / n_products
generate ln_n_products  = ln(n_products)
generate ln_val_prod    = ln(val_prod)
label define exporter 0 "Non-exporter" 1 "Exporter"
label values exporter exporter

* ---- importer / FDI from SI, merged on the cell ----
preserve
use "$B21_DATA/b21_si.dta", clear
keep if clean == 1 & inlist(year, 2021, 2022)
generate n_si = 1
collapse (sum) n_si (mean) pct_importer = importer pct_fdi = fdi, by(year prov_s kbli5)
tempfile sicell
save `sicell'
restore
merge m:1 year prov_s kbli5 using `sicell', keep(master match)
tabulate year _merge
drop _merge
replace n_si = 0 if missing(n_si)
generate importer = (pct_importer >= 0.5) if !missing(pct_importer)
generate fdi      = (pct_fdi >= 0.5)      if !missing(pct_fdi)
label define importer 0 "Non-importer" 1 "Importer"
label values importer importer
label define fdi 0 "Domestic" 1 "FDI"
label values fdi fdi

label variable n_products        "Number of distinct products"
label variable hhi               "Product HHI of production value (0-1)"
label variable eff_n_products    "1 / HHI (effective number of products)"
label variable core_share        "Largest product's share of production value"
label variable exp_intensity     "Exported / production value, %"
label variable pct_prod_exported "% of the firm's products that are exported"
label variable n_dest            "Number of export destinations (reported)"
label variable exporter          "1 = exports at least one product (roster)"
label variable n_si              "Clean SI plants in the cell (year x prov x KBLI5)"
label variable pct_importer      "Share of SI plants in the cell that import"
label variable pct_fdi           "Share of SI plants in the cell that are FDI"
label variable importer          "1 = at least half of the cell's SI plants import"
label variable fdi               "1 = at least half of the cell's SI plants are FDI"
order firm_key year key_type prov_s kbli5 kbli2 n_products eff_n_products hhi core_share ///
      exporter exp_intensity pct_prod_exported n_dest importer fdi
compress
save "$B21_DATA/b21_pm_firm.dta", replace
display as result "Proman by firm: " _N " firm-years -> $B21_DATA/b21_pm_firm.dta"
