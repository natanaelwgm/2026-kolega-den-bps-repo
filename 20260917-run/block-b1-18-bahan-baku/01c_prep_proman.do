/*==========================================================================
  Line 1 (part c)  Prepare the Proman (production) roster, 2021 & 2022
                   -- used for "product scope" in line 19
  Input : $ROSTER/Proman2021_sampel.xlsx, Proman2022_sampel.xlsx
  Output: data/b18_pm_firm.dta -- 1 row = 1 firm x year
          n_products = number of distinct products (KBKI) produced

  firm_key follows the same rule as 01b: Kipb if available, otherwise the
  cell (year x province x the firm's KBLI5).
==========================================================================*/
if "$B18" == "" {
    display as error "Run 00_run.do first (it sets the paths)."
    exit 198
}

* 2021: Kipb Prop Komoditi Kodkbki Kbli Nilai
import excel using "$ROSTER/Proman2021_sampel.xlsx", firstrow allstring clear
rename (Kipb Prop Komoditi Kodkbki Kbli Nilai) (kipb prov_s product kbki kbli5 val_prod)
generate year = 2021
keep year kipb prov_s product kbki kbli5 val_prod
tempfile pm21
save `pm21'

* 2022: Kip Prop Komoditi Kodekbki Kbli522 Nilpro22
import excel using "$ROSTER/Proman2022_sampel.xlsx", firstrow allstring clear
rename (Kip Prop Komoditi Kodekbki Kbli522 Nilpro22) (kipb prov_s product kbki kbli5 val_prod)
generate year = 2022
keep year kipb prov_s product kbki kbli5 val_prod
append using `pm21'

destring val_prod, replace force

count if kipb != "***" & kipb != ""
if r(N) > 0 generate firm_key = kipb
else        generate firm_key = string(year) + "_" + prov_s + "_" + kbli5

* products are counted by KBKI code; if blank, by product name
generate item = kbki
replace  item = upper(strtrim(product)) if item == ""
egen tag_item = tag(firm_key year item)
collapse (sum) n_products = tag_item val_prod, by(firm_key year)
label variable n_products "Number of distinct products (product scope)"
compress
save "$B18_DATA/b18_pm_firm.dta", replace
display as result "Proman by firm: " _N " rows -> $B18_DATA/b18_pm_firm.dta"
