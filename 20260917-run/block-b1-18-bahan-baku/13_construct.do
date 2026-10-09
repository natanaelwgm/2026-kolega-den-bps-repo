/*==========================================================================
  Line 13: "Construct:"
  Builds the firm-level construct variables used in lines 14-18 (and the
  product-scope part of line 19) from the Bahan Baku roster.

  Input : data/b18_bb_rows.dta  (1 row = 1 raw material x firm x year)
  Output: data/b18_bb_firm.dta  (1 row = 1 firm x year)

  Variables:
    val_local val_import val_total   domestic / imported / total value
    import_share      val_import / val_total                     (line 14)
    any_import        1 = imports at least one raw material
    n_items           number of distinct raw materials (KBKI)
    n_items_imp       number of distinct imported raw materials  (line 15)
    share_items_imp   n_items_imp / n_items                      (line 15)
    mix               1 all domestic, 2 mixed, 3 all imported    (line 16)
    n_origins         number of origin countries (reported only) (line 17)
    origin_hhi        HHI of imported value across countries     (line 17)
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}
use "$B18_DATA/b18_bb_rows.dta", clear

* ---- 1. origin concentration per firm ----
preserve
keep if imported == 1 & origin_name != "(not reported)"
collapse (sum) v = val_import, by(firm_key year origin_name)   // value per country
bysort firm_key year: egen v_total = total(v)
generate s2 = (v / v_total)^2                                  // squared share
collapse (sum) origin_hhi = s2 (count) n_origins = s2, by(firm_key year)
tempfile hhi
save `hhi'
restore

* ---- 2. number of distinct (imported) raw materials ----
* a raw material is identified by its KBKI code; if blank, by its name
generate item = kbki
replace  item = upper(strtrim(material)) if item == "" | item == "0000000000"
egen tag_item     = tag(firm_key year item)               // 1 per distinct material
egen tag_item_imp = tag(firm_key year item imported)
generate item_imp = tag_item_imp * imported               // 1 per distinct imported material

* ---- 3. collapse to firms ----
collapse (sum) val_local val_import val_total n_items = tag_item n_items_imp = item_imp ///
         (first) prov kbli5 kbli2 java key_type, by(firm_key year)
merge 1:1 firm_key year using `hhi', nogenerate
replace n_origins = 0 if missing(n_origins)

generate import_share    = val_import / val_total
generate any_import      = (val_import > 0)
generate share_items_imp = n_items_imp / n_items
label define any_import 0 "Non-importer" 1 "Importer"
label values any_import any_import

* ---- 4. domestic / import mix ----
generate mix = 1 if val_import == 0
replace  mix = 2 if val_import > 0 & val_local > 0
replace  mix = 3 if val_local == 0
label define mix 1 "All domestic" 2 "Mixed" 3 "All imported"
label values mix mix

label variable import_share    "Imported / total raw material value"
label variable n_items         "Number of distinct raw materials"
label variable n_items_imp     "Number of distinct imported raw materials"
label variable share_items_imp "Imported materials / all materials (count)"
label variable n_origins       "Number of origin countries (reported only)"
label variable origin_hhi      "HHI of imported value across origin countries (0-1)"
compress
save "$B18_DATA/b18_bb_firm.dta", replace
display as result "13 done: " _N " firm-years -> $B18_DATA/b18_bb_firm.dta"
