* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_classification_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:step-use" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 1 49 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:step-use" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 1 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L2:step-label" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 2 49 `=_rc' // WFLOG-INJECTED
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L2:step-label" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 2 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L3:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 3 49 `=_rc' // WFLOG-INJECTED
generate str64 district_code=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L3:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 3 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L4:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 4 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup10) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L4:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 4 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L5:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 5 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup11) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L5:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 5 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L6:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 6 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup12) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L6:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 6 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L7:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 7 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup13___3) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L7:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 7 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L8:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 8 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup14) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L8:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 8 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L9:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 9 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_kodekab) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L9:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 9 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L10:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 10 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup17) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L10:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 10 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L11:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 11 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup18) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L11:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 11 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L12:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 12 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup19) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L12:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 12 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L13:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 13 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup20) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L13:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 13 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L14:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 14 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup21) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L14:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 14 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L15:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 15 49 `=_rc' // WFLOG-INJECTED
replace district_code=strtrim(raw_dkabup22) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L15:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 15 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L16:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 16 49 `=_rc' // WFLOG-INJECTED
replace district_code="" if inlist(upper(district_code),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L16:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 16 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L17:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 17 49 `=_rc' // WFLOG-INJECTED
generate str64 industry_code=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L17:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 17 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L18:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 18 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic510) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L18:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 18 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L19:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 19 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic511) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L19:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 19 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L20:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 20 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic512) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L20:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 20 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L21:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 21 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic513) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L21:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 21 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L22:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 22 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic514) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L22:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 22 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L23:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 23 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic5) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L23:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 23 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L24:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 24 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic517) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L24:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 24 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L25:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 25 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic518) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L25:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 25 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L26:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 26 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic519) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L26:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 26 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L27:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 27 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic520) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L27:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 27 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L28:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 28 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic521) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L28:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 28 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L29:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 29 49 `=_rc' // WFLOG-INJECTED
replace industry_code=strtrim(raw_disic522) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L29:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 29 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L30:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 30 49 `=_rc' // WFLOG-INJECTED
replace industry_code="" if inlist(upper(industry_code),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L30:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 30 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L31:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 31 49 `=_rc' // WFLOG-INJECTED
generate str64 province_code=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L31:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 31 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L32:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 32 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi10) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L32:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 32 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L33:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 33 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi11) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L33:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 33 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L34:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 34 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi12) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L34:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 34 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L35:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 35 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi13___2) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L35:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 35 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L36:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 36 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi14) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L36:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 36 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L37:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 37 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L37:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 37 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L38:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 38 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi17) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L38:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 38 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L39:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 39 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi18) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L39:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 39 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L40:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 40 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi19) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L40:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 40 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L41:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 41 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi20) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L41:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 41 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L42:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 42 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi21) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L42:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 42 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L43:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 43 49 `=_rc' // WFLOG-INJECTED
replace province_code=strtrim(raw_dprovi22) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L43:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 43 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L44:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 44 49 `=_rc' // WFLOG-INJECTED
replace province_code="" if inlist(upper(province_code),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L44:step-replace" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 44 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L45:step-keep" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 45 49 `=_rc' // WFLOG-INJECTED
keep source_year source_row district_code industry_code province_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L45:step-keep" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 45 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L46:step-isid" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 46 49 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L46:step-isid" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 46 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L47:step-save" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 47 49 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_classification_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L47:step-save" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 47 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L48:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 48 49 `=_rc' // WFLOG-INJECTED
generate str64 classification_status="reported_wave_codes_revision_bridge_pending"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L48:step-generate" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 48 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L49:step-save" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 49 49 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_classification_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L49:step-save" "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "statement" 49 49 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_05_map_geography_industry.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
