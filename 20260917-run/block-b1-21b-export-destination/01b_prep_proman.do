/*==========================================================================
  Line 1 (part b)  "Export destination structure:"
                   Prepare the Proman (production) roster, 2021 & 2022,
                   and map each destination country to a region
  Input : $ROSTER/Proman2021_sampel.xlsx, Proman2022_sampel.xlsx
  Output: data/b21b_pm_rows.dta -- 1 row = 1 product x firm x year
          sheet t01_country_map -- every destination name in the data, its
                                   region and EU+EFTA flag, number of rows

  Main variables created:
    val_prod      production value of the product (nominal, masked)
    exp_share     % of the product exported (0-100; values > 100 set missing)
    dest_country  main destination country (blank = not exported / not given)
    exported      1 = product is exported (destination named or share > 0)
    exp_value     export value = val_prod x exp_share / 100
    region        EU, US, China, ASEAN, Japan, India, Others
    high_std      1 = EU-27 + EFTA (Iceland, Liechtenstein, Norway,
                  Switzerland) = "advanced / high environmental standard
                  market"; 0 = any other destination

  ABOUT THE DESTINATION: Proman gives ONE main destination country per
    product (Namaneg/Negara). A product sold to several countries shows
    only the main one, so a firm's number of destinations is a lower bound.
    2021 marks non-exporters with "NO". "INDONESIA" as destination is
    treated as not exported.

  ABOUT THE FIRM ID (Kipb): masked ("***") in the sample files, so a
    "firm" is a CELL = year x province x 5-digit KBLI of the firm (firm_key).
    With the real BPS data firm_key = Kipb automatically (key_type).

  TO CHANGE THE REGION OF A COUNTRY: edit the "replace region" lines below.
  If the column names/order differ in the real files, edit the "rename"
  lines only.
==========================================================================*/
if "$B21B" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 2021 -------------------------------------------------------------
* Kipb Prop Komoditi Kodkbki Kbli (firm KBLI) Nilai Prprex (% exported)
* Namaneg (destination name) Kodeneg (destination code) Flg21
import excel using "$ROSTER/Proman2021_sampel.xlsx", firstrow allstring clear
rename (Kipb Prop Komoditi Kodkbki Kbli Nilai Prprex Namaneg Kodeneg Flg21) ///
       (kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code flag)
generate year = 2021
keep year kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code flag
tempfile pm21
save `pm21'

* ---- 2022 -------------------------------------------------------------
* Kip Prop Komoditi Kodekbki Kbli522 Nilpro22 Ekspor (% exported)
* Negara (destination name) Kodeneg (destination code) Flagpr22
import excel using "$ROSTER/Proman2022_sampel.xlsx", firstrow allstring clear
rename (Kip Prop Komoditi Kodekbki Kbli522 Nilpro22 Ekspor Negara Kodeneg Flagpr22) ///
       (kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code flag)
generate year = 2022
keep year kipb prov_s product kbki kbli5 val_prod exp_share dest_name dest_code flag
append using `pm21'

* ---- values -------------------------------------------------------------
destring val_prod exp_share, replace force
count if exp_share > 100 & !missing(exp_share)
display as result "Export shares above 100% (set missing): " r(N)
replace exp_share = . if exp_share > 100 | exp_share < 0

* ---- destination country --------------------------------------------------
replace dest_name = strtrim(upper(dest_name))
replace dest_code = strtrim(dest_code)
replace dest_name = "" if dest_name == "NO"          // 2021: "NO" = not exported
* some rows have only the code -> take the name used with the same code elsewhere
bysort dest_code (dest_name): replace dest_name = dest_name[_N] if dest_name == "" & dest_code != ""
replace dest_name = "CODE " + dest_code if dest_name == "" & dest_code != ""
generate dest_country = dest_name
replace  dest_country = "" if dest_country == "INDONESIA"   // not an export

generate exported  = (dest_country != "") | (exp_share > 0 & !missing(exp_share))
generate exp_value = val_prod * exp_share / 100 if exp_share > 0 & !missing(exp_share)
replace  exp_value = 0 if exported == 1 & exp_share == 0

* ---- country -> region ------------------------------------------------------
* region: 1 EU (EU-27), 2 US, 3 China, 4 ASEAN, 5 Japan, 6 India, 7 Others
* (inlist takes at most 9 names, so long lists are split over several lines)
generate region = 7 if dest_country != ""
replace region = 1 if inlist(dest_country, "AUSTRIA", "BELGIA", "BULGARIA", "KROASIA", "SIPRUS", "CEKO", "REPUBLIK CEKO", "DENMARK", "ESTONIA")
replace region = 1 if inlist(dest_country, "FINLANDIA", "PERANCIS", "JERMAN", "YUNANI", "HONGARIA", "IRLANDIA", "ITALIA", "LATVIA")
replace region = 1 if inlist(dest_country, "LITHUANIA", "LITUANIA", "LUKSEMBURG", "MALTA", "BELANDA", "POLANDIA", "PORTUGAL")
replace region = 1 if inlist(dest_country, "ROMANIA", "RUMANIA", "SLOWAKIA", "SLOVAKIA", "SLOVENIA", "SPANYOL", "SWEDIA", "SWEDEN")
replace region = 2 if inlist(dest_country, "AMERIKA SERIKAT", "GUAM", "KEPULAUAN TERLUAR KECIL AMERIKA SERIKAT")   // US incl. its territories
replace region = 3 if inlist(dest_country, "CHINA", "TIONGKOK")      // Hong Kong and Taiwan stay in Others
replace region = 4 if inlist(dest_country, "SINGAPURA", "MALAYSIA", "THAILAND", "FILIPINA", "VIETNAM")
replace region = 4 if inlist(dest_country, "BRUNEI DARUSSALAM", "KAMBOJA", "MYANMAR", "LAOS")
replace region = 5 if inlist(dest_country, "JEPANG")
replace region = 6 if inlist(dest_country, "INDIA")
label define region 1 "EU" 2 "US" 3 "China" 4 "ASEAN" 5 "Japan" 6 "India" 7 "Others"
label values region region

* ---- EU + EFTA = "advanced / high environmental standard market" -------------
* EU-27 (region 1) plus the 4 EFTA countries. The UK (INGGRIS) is not in it.
generate high_std = (region == 1) if dest_country != ""
replace  high_std = 1 if inlist(dest_country, "ISLANDIA", "LIECHTENSTEIN", "NORWEGIA", "SWISS", "SWITZERLAND")
label define high_std 0 "Other markets" 1 "EU+EFTA"
label values high_std high_std

* names that could not be placed in a region (aggregates such as "EROPA BARAT
* LAINNYA" and codes without a name) are in Others; they are listed here
display as text "Destinations in Others (check this list):"
tab dest_country if region == 7, sort

* ---- identifiers ------------------------------------------------------------
generate prov  = real(prov_s)
generate kbli2 = real(substr(kbli5, 1, 2))
generate java  = inlist(prov, 31, 32, 33, 34, 35, 36) if !missing(prov)

* firm_key: Kipb if available, otherwise the cell
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

* ---- the country map, for checking (sheet t01_country_map) --------------------
preserve
keep if dest_country != ""
generate n_rows = 1
collapse (sum) n_rows exp_value, by(dest_country region high_std)
gsort region -n_rows
order region dest_country high_std n_rows exp_value
export excel using "$B21B_XLSX", sheet("t01_country_map", replace) firstrow(variables)
restore

* ---- save ----------------------------------------------------------------
label variable exp_share    "% of the product exported (0-100)"
label variable dest_country "Main destination country"
label variable exported     "1 = product exported"
label variable exp_value    "Export value = val_prod x exp_share/100 (nominal)"
label variable region       "Destination region"
label variable high_std     "1 = destination in EU-27 + EFTA"
order year firm_key key_type prov kbli5 kbli2 product kbki val_prod exp_share exported exp_value dest_country region high_std
compress
save "$B21B_DATA/b21b_pm_rows.dta", replace
display as result "Proman roster: " _N " rows -> $B21B_DATA/b21b_pm_rows.dta"
