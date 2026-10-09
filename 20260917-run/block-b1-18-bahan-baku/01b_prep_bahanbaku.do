/*==========================================================================
  Line 1 (part b)  Prepare the Bahan Baku (raw materials) roster, 2021 & 2022
  Input : $ROSTER/Bahanbaku2021_sampel.xlsx, Bahanbaku2022_sampel.xlsx
  Output: data/b18_bb_rows.dta -- 1 row = 1 raw material x firm x year
          (the firm-level file is built in 13_construct.do)

  ABOUT THE FIRM ID (Kipb):
    In the sample files Kipb is masked ("***"), so rows cannot be grouped
    by firm. For now a "firm" is a CELL = year x province x 5-digit KBLI
    (firm_key). In the real BPS data Kipb is present, so firm_key = Kipb
    automatically and every table becomes a true firm-level table.
    Check variable key_type: "kipb" or "cell".

  If the column names/order differ in the real files, edit the "rename"
  lines only.
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* ---- 2021 -------------------------------------------------------------
* Columns: A Kipb, B Prop, C Kabu, D Komoditi, E Kodesat, F Satuan,
*          G Volok21, H Nilok21, I Plok, J Volim21, K Nilim21, L Pimp,
*          M Kodekbki, N Deskbki, O Desing, P Kodeneg, Q Desneg, R Desnegla,
*          S Kbli5, T Flg21
import excel using "$ROSTER/Bahanbaku2021_sampel.xlsx", cellrange(A2) allstring clear
rename (A B D F G H J K M P Q S) ///
       (kipb prov_s material unit vol_local val_local vol_import val_import kbki origin_code origin_name kbli5)
generate year = 2021
keep year kipb prov_s kbli5 material unit kbki vol_local val_local vol_import val_import origin_code origin_name
tempfile bb21
save `bb21'

* ---- 2022 -------------------------------------------------------------
* Columns: A Kipb, B Prop, C Bahan Baku, D satuan, E satuan_desk,
*          F Banyaknya BB Lokal, G Nilai BB Lokal, H Banyaknya BB Impor,
*          I Nilai BB Impor, J Total nilai, K Kodekbki, L Desind,
*          M Negara utama (code), N Negara utama (name), O Lainnya,
*          P Tahun, Q Kbli522, R Kab
import excel using "$ROSTER/Bahanbaku2022_sampel.xlsx", cellrange(A2) allstring clear
rename (A B C D F G H I K M N Q) ///
       (kipb prov_s material unit vol_local val_local vol_import val_import kbki origin_code origin_name kbli5)
generate year = 2022
keep year kipb prov_s kbli5 material unit kbki vol_local val_local vol_import val_import origin_code origin_name
append using `bb21'

* ---- clean ------------------------------------------------------------
destring vol_local val_local vol_import val_import, replace force
replace val_local  = 0 if missing(val_local)
replace val_import = 0 if missing(val_import)
generate val_total = val_local + val_import
count if val_total <= 0
display as result "Rows with no value (dropped): " r(N)
drop if val_total <= 0

generate prov  = real(prov_s)
generate kbli2 = real(substr(kbli5, 1, 2))
generate java  = inlist(prov, 31, 32, 33, 34, 35, 36) if !missing(prov)
generate imported = (val_import > 0)

* origin country: 2022 often has only the code -> fill the name from the same code
replace origin_name = strtrim(upper(origin_name))
replace origin_code = strtrim(origin_code)
bysort origin_code (origin_name): replace origin_name = origin_name[_N] if origin_name == "" & origin_code != ""
replace origin_name = "CODE " + origin_code if origin_name == "" & origin_code != ""
replace origin_name = "(not reported)" if origin_name == "" & imported == 1
replace origin_name = "" if imported == 0

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

order year firm_key key_type prov kbli5 kbli2 material kbki val_local val_import val_total imported origin_name
compress
save "$B18_DATA/b18_bb_rows.dta", replace
display as result "Bahan Baku roster: " _N " rows -> $B18_DATA/b18_bb_rows.dta"
