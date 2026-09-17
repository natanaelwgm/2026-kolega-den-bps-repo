* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_classification_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
generate str64 district_code=""
replace district_code=strtrim(raw_dkabup10) if source_year==2010
replace district_code=strtrim(raw_dkabup11) if source_year==2011
replace district_code=strtrim(raw_dkabup12) if source_year==2012
replace district_code=strtrim(raw_dkabup13___3) if source_year==2013
replace district_code=strtrim(raw_dkabup14) if source_year==2014
replace district_code=strtrim(raw_kodekab) if source_year==2015
replace district_code=strtrim(raw_dkabup17) if source_year==2017
replace district_code=strtrim(raw_dkabup18) if source_year==2018
replace district_code=strtrim(raw_dkabup19) if source_year==2019
replace district_code=strtrim(raw_dkabup20) if source_year==2020
replace district_code=strtrim(raw_dkabup21) if source_year==2021
replace district_code=strtrim(raw_dkabup22) if source_year==2022
replace district_code="" if inlist(upper(district_code),"***",".","NA","N/A","NULL","-")
generate str64 industry_code=""
replace industry_code=strtrim(raw_disic510) if source_year==2010
replace industry_code=strtrim(raw_disic511) if source_year==2011
replace industry_code=strtrim(raw_disic512) if source_year==2012
replace industry_code=strtrim(raw_disic513) if source_year==2013
replace industry_code=strtrim(raw_disic514) if source_year==2014
replace industry_code=strtrim(raw_disic5) if source_year==2015
replace industry_code=strtrim(raw_disic517) if source_year==2017
replace industry_code=strtrim(raw_disic518) if source_year==2018
replace industry_code=strtrim(raw_disic519) if source_year==2019
replace industry_code=strtrim(raw_disic520) if source_year==2020
replace industry_code=strtrim(raw_disic521) if source_year==2021
replace industry_code=strtrim(raw_disic522) if source_year==2022
replace industry_code="" if inlist(upper(industry_code),"***",".","NA","N/A","NULL","-")
generate str64 province_code=""
replace province_code=strtrim(raw_dprovi10) if source_year==2010
replace province_code=strtrim(raw_dprovi11) if source_year==2011
replace province_code=strtrim(raw_dprovi12) if source_year==2012
replace province_code=strtrim(raw_dprovi13___2) if source_year==2013
replace province_code=strtrim(raw_dprovi14) if source_year==2014
replace province_code=strtrim(raw_dprovi) if source_year==2015
replace province_code=strtrim(raw_dprovi17) if source_year==2017
replace province_code=strtrim(raw_dprovi18) if source_year==2018
replace province_code=strtrim(raw_dprovi19) if source_year==2019
replace province_code=strtrim(raw_dprovi20) if source_year==2020
replace province_code=strtrim(raw_dprovi21) if source_year==2021
replace province_code=strtrim(raw_dprovi22) if source_year==2022
replace province_code="" if inlist(upper(province_code),"***",".","NA","N/A","NULL","-")
keep source_year source_row district_code industry_code province_code
isid source_year source_row
save "$G0D/G0_classification_fields.dta", replace
generate str64 classification_status="reported_wave_codes_revision_bridge_pending"
save "$G0D/G0_classification_fields.dta", replace
