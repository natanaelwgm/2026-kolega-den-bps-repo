* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_energy_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:step-use" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1 1011 `=_rc' // WFLOG-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:step-use" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L2:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 2 1011 `=_rc' // WFLOG-INJECTED
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L2:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 2 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L3:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 3 1011 `=_rc' // WFLOG-INJECTED
generate double elec_nonpln_kwh=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L3:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 3 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L4:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 4 1011 `=_rc' // WFLOG-INJECTED
generate byte st_elec_nonpln_kwh=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L4:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 4 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L5:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 5 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L5:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 5 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L6:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 6 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L6:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 6 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L7:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 7 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2010 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L7:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 7 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L8:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 8 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L8:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 8 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L9:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 9 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L9:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 9 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L10:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 10 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2011 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L10:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 10 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L11:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 11 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L11:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 11 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L12:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 12 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L12:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 12 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L13:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 13 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2012 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L13:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 13 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L14:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 14 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L14:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 14 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L15:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 15 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L15:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 15 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L16:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 16 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2013 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L16:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 16 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L17:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 17 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L17:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 17 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L18:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 18 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L18:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 18 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L19:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 19 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2014 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L19:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 19 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L20:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 20 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L20:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 20 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L21:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 21 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L21:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 21 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L22:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 22 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2015 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L22:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 22 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L23:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 23 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L23:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 23 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L24:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 24 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L24:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 24 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L25:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 25 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2017 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L25:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 25 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L26:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 26 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L26:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 26 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L27:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 27 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L27:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 27 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L28:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 28 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2018 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L28:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 28 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L29:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 29 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L29:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 29 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L30:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 30 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L30:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 30 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L31:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 31 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2019 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L31:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 31 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L32:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 32 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L32:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 32 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L33:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 33 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L33:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 33 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L34:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 34 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2020 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L34:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 34 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L35:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 35 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L35:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 35 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L36:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 36 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L36:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 36 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L37:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 37 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2021 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L37:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 37 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L38:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 38 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L38:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 38 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L39:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 39 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L39:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 39 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L40:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 40 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_kwh=5 if source_year==2022 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L40:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 40 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L41:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 41 1011 `=_rc' // WFLOG-INJECTED
label values st_elec_nonpln_kwh G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L41:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 41 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L42:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 42 1011 `=_rc' // WFLOG-INJECTED
generate double elec_nonpln_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L42:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 42 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L43:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 43 1011 `=_rc' // WFLOG-INJECTED
generate byte st_elec_nonpln_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L43:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 43 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L44:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 44 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L44:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 44 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L45:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 45 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L45:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 45 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L46:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 46 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2010 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L46:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 46 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L47:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 47 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L47:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 47 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L48:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 48 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L48:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 48 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L49:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 49 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2011 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L49:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 49 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L50:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 50 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L50:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 50 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L51:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 51 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L51:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 51 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L52:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 52 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2012 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L52:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 52 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L53:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 53 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L53:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 53 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L54:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 54 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L54:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 54 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L55:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 55 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2013 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L55:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 55 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L56:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 56 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L56:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 56 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L57:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 57 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L57:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 57 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L58:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 58 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2014 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L58:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 58 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L59:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 59 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L59:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 59 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L60:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 60 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L60:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 60 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L61:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 61 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2015 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L61:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 61 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L62:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 62 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L62:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 62 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L63:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 63 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L63:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 63 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L64:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 64 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2017 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L64:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 64 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L65:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 65 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L65:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 65 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L66:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 66 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L66:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 66 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L67:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 67 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2018 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L67:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 67 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L68:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 68 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L68:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 68 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L69:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 69 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L69:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 69 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L70:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 70 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2019 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L70:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 70 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L71:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 71 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L71:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 71 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L72:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 72 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L72:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 72 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L73:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 73 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2020 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L73:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 73 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L74:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 74 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L74:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 74 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L75:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 75 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L75:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 75 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L76:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 76 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2021 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L76:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 76 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L77:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 77 1011 `=_rc' // WFLOG-INJECTED
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L77:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 77 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L78:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 78 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L78:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 78 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L79:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 79 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_nonpln_rp000=5 if source_year==2022 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L79:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 79 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L80:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 80 1011 `=_rc' // WFLOG-INJECTED
label values st_elec_nonpln_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L80:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 80 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L81:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 81 1011 `=_rc' // WFLOG-INJECTED
generate double elec_owngen_kwh=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L81:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 81 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L82:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 82 1011 `=_rc' // WFLOG-INJECTED
generate byte st_elec_owngen_kwh=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L82:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 82 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L83:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 83 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L83:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 83 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L84:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 84 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L84:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 84 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L85:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 85 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2010 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L85:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 85 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L86:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 86 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L86:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 86 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L87:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 87 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L87:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 87 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L88:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 88 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2011 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L88:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 88 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L89:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 89 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L89:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 89 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L90:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 90 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L90:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 90 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L91:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 91 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2012 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L91:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 91 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L92:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 92 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L92:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 92 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L93:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 93 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L93:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 93 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L94:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 94 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2013 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L94:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 94 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L95:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 95 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L95:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 95 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L96:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 96 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L96:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 96 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L97:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 97 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2014 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L97:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 97 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L98:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 98 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L98:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 98 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L99:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 99 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L99:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 99 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L100:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 100 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2015 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L100:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 100 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L101:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 101 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L101:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 101 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L102:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 102 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L102:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 102 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L103:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 103 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2017 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L103:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 103 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L104:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 104 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L104:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 104 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L105:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 105 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L105:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 105 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L106:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 106 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2018 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L106:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 106 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L107:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 107 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L107:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 107 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L108:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 108 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L108:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 108 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L109:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 109 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2019 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L109:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 109 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L110:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 110 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L110:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 110 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L111:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 111 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L111:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 111 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L112:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 112 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2020 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L112:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 112 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L113:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 113 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L113:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 113 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L114:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 114 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L114:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 114 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L115:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 115 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2021 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L115:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 115 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L116:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 116 1011 `=_rc' // WFLOG-INJECTED
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L116:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 116 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L117:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 117 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L117:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 117 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L118:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 118 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_owngen_kwh=5 if source_year==2022 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L118:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 118 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L119:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 119 1011 `=_rc' // WFLOG-INJECTED
label values st_elec_owngen_kwh G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L119:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 119 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L120:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 120 1011 `=_rc' // WFLOG-INJECTED
generate double elec_pln_kwh=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L120:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 120 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L121:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 121 1011 `=_rc' // WFLOG-INJECTED
generate byte st_elec_pln_kwh=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L121:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 121 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L122:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 122 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L122:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 122 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L123:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 123 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L123:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 123 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L124:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 124 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2010 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L124:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 124 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L125:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 125 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L125:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 125 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L126:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 126 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L126:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 126 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L127:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 127 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2011 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L127:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 127 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L128:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 128 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L128:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 128 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L129:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 129 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L129:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 129 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L130:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 130 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2012 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L130:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 130 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L131:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 131 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L131:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 131 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L132:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 132 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L132:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 132 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L133:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 133 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2013 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L133:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 133 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L134:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 134 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L134:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 134 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L135:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 135 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L135:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 135 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L136:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 136 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2014 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L136:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 136 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L137:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 137 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L137:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 137 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L138:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 138 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L138:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 138 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L139:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 139 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2015 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L139:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 139 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L140:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 140 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L140:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 140 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L141:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 141 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L141:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 141 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L142:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 142 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2017 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L142:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 142 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L143:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 143 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L143:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 143 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L144:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 144 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L144:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 144 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L145:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 145 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2018 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L145:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 145 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L146:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 146 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L146:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 146 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L147:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 147 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L147:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 147 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L148:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 148 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2019 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L148:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 148 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L149:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 149 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L149:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 149 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L150:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 150 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L150:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 150 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L151:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 151 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2020 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L151:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 151 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L152:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 152 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L152:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 152 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L153:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 153 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L153:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 153 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L154:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 154 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2021 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L154:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 154 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L155:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 155 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L155:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 155 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L156:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 156 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L156:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 156 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L157:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 157 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_kwh=5 if source_year==2022 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L157:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 157 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L158:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 158 1011 `=_rc' // WFLOG-INJECTED
label values st_elec_pln_kwh G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L158:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 158 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L159:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 159 1011 `=_rc' // WFLOG-INJECTED
generate double elec_pln_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L159:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 159 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L160:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 160 1011 `=_rc' // WFLOG-INJECTED
generate byte st_elec_pln_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L160:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 160 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L161:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 161 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L161:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 161 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L162:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 162 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L162:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 162 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L163:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 163 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2010 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L163:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 163 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L164:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 164 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L164:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 164 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L165:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 165 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L165:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 165 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L166:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 166 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2011 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L166:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 166 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L167:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 167 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L167:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 167 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L168:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 168 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L168:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 168 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L169:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 169 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2012 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L169:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 169 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L170:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 170 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L170:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 170 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L171:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 171 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L171:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 171 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L172:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 172 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2013 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L172:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 172 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L173:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 173 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L173:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 173 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L174:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 174 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L174:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 174 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L175:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 175 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2014 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L175:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 175 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L176:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 176 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L176:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 176 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L177:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 177 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L177:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 177 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L178:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 178 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2015 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L178:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 178 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L179:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 179 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L179:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 179 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L180:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 180 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L180:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 180 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L181:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 181 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2017 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L181:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 181 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L182:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 182 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L182:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 182 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L183:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 183 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L183:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 183 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L184:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 184 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2018 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L184:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 184 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L185:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 185 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L185:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 185 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L186:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 186 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L186:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 186 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L187:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 187 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2019 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L187:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 187 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L188:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 188 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L188:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 188 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L189:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 189 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L189:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 189 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L190:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 190 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2020 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L190:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 190 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L191:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 191 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L191:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 191 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L192:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 192 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L192:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 192 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L193:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 193 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2021 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L193:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 193 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L194:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 194 1011 `=_rc' // WFLOG-INJECTED
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L194:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 194 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L195:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 195 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L195:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 195 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L196:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 196 1011 `=_rc' // WFLOG-INJECTED
replace st_elec_pln_rp000=5 if source_year==2022 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L196:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 196 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L197:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 197 1011 `=_rc' // WFLOG-INJECTED
label values st_elec_pln_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L197:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 197 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L198:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 198 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_biodiesel_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L198:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 198 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L199:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 199 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_biodiesel_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L199:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 199 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L200:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 200 1011 `=_rc' // WFLOG-INJECTED
replace fuel_biodiesel_ltr=real(subinstr(strtrim(raw_esdliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L200:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 200 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L201:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 201 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_ltr=cond(missing(fuel_biodiesel_ltr),3,cond(fuel_biodiesel_ltr<0,2,cond(fuel_biodiesel_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L201:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 201 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L202:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 202 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_ltr=5 if source_year==2021 & missing(fuel_biodiesel_ltr) & !inlist(upper(strtrim(raw_esdliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L202:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 202 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L203:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 203 1011 `=_rc' // WFLOG-INJECTED
replace fuel_biodiesel_ltr=real(subinstr(strtrim(raw_esdliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L203:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 203 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L204:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 204 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_ltr=cond(missing(fuel_biodiesel_ltr),3,cond(fuel_biodiesel_ltr<0,2,cond(fuel_biodiesel_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L204:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 204 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L205:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 205 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_ltr=5 if source_year==2022 & missing(fuel_biodiesel_ltr) & !inlist(upper(strtrim(raw_esdliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L205:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 205 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L206:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 206 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_biodiesel_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L206:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 206 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L207:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 207 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_biodiesel_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L207:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 207 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L208:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 208 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_biodiesel_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L208:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 208 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L209:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 209 1011 `=_rc' // WFLOG-INJECTED
replace fuel_biodiesel_rp000=real(subinstr(strtrim(raw_esdvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L209:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 209 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L210:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 210 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_rp000=cond(missing(fuel_biodiesel_rp000),3,cond(fuel_biodiesel_rp000<0,2,cond(fuel_biodiesel_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L210:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 210 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L211:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 211 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_rp000=5 if source_year==2021 & missing(fuel_biodiesel_rp000) & !inlist(upper(strtrim(raw_esdvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L211:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 211 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L212:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 212 1011 `=_rc' // WFLOG-INJECTED
replace fuel_biodiesel_rp000=real(subinstr(strtrim(raw_esdvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L212:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 212 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L213:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 213 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_rp000=cond(missing(fuel_biodiesel_rp000),3,cond(fuel_biodiesel_rp000<0,2,cond(fuel_biodiesel_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L213:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 213 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L214:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 214 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_biodiesel_rp000=5 if source_year==2022 & missing(fuel_biodiesel_rp000) & !inlist(upper(strtrim(raw_esdvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L214:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 214 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L215:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 215 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_biodiesel_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L215:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 215 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L216:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 216 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_charcoal_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L216:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 216 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L217:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 217 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_charcoal_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L217:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 217 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L218:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 218 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L218:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 218 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L219:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 219 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L219:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 219 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L220:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 220 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=5 if source_year==2020 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L220:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 220 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L221:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 221 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L221:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 221 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L222:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 222 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L222:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 222 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L223:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 223 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=5 if source_year==2021 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L223:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 223 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L224:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 224 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L224:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 224 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L225:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 225 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L225:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 225 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L226:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 226 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_kg=5 if source_year==2022 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L226:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 226 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L227:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 227 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_charcoal_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L227:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 227 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L228:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 228 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_charcoal_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L228:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 228 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L229:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 229 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_charcoal_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L229:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 229 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L230:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 230 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L230:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 230 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L231:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 231 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L231:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 231 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L232:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 232 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=5 if source_year==2020 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L232:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 232 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L233:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 233 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L233:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 233 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L234:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 234 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L234:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 234 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L235:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 235 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=5 if source_year==2021 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L235:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 235 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L236:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 236 1011 `=_rc' // WFLOG-INJECTED
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L236:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 236 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L237:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 237 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L237:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 237 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L238:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 238 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_charcoal_rp000=5 if source_year==2022 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L238:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 238 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L239:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 239 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_charcoal_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L239:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 239 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L240:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 240 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_citygas_m3=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L240:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 240 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L241:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 241 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_citygas_m3=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L241:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 241 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L242:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 242 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L242:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 242 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L243:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 243 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L243:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 243 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L244:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 244 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2010 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L244:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 244 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L245:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 245 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L245:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 245 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L246:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 246 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L246:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 246 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L247:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 247 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2011 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L247:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 247 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L248:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 248 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L248:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 248 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L249:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 249 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L249:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 249 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L250:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 250 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2012 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L250:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 250 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L251:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 251 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L251:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 251 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L252:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 252 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L252:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 252 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L253:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 253 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2013 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L253:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 253 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L254:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 254 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L254:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 254 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L255:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 255 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L255:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 255 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L256:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 256 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2014 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L256:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 256 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L257:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 257 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L257:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 257 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L258:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 258 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L258:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 258 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L259:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 259 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2015 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L259:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 259 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L260:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 260 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L260:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 260 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L261:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 261 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L261:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 261 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L262:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 262 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2017 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L262:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 262 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L263:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 263 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L263:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 263 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L264:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 264 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L264:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 264 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L265:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 265 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2018 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L265:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 265 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L266:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 266 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L266:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 266 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L267:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 267 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L267:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 267 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L268:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 268 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_m3=5 if source_year==2019 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L268:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 268 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L269:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 269 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_citygas_m3 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L269:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 269 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L270:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 270 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_citygas_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L270:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 270 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L271:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 271 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_citygas_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L271:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 271 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L272:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 272 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L272:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 272 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L273:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 273 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L273:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 273 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L274:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 274 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2010 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L274:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 274 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L275:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 275 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L275:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 275 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L276:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 276 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L276:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 276 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L277:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 277 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2011 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L277:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 277 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L278:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 278 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L278:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 278 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L279:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 279 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L279:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 279 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L280:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 280 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2012 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L280:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 280 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L281:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 281 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L281:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 281 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L282:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 282 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L282:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 282 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L283:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 283 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2013 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L283:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 283 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L284:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 284 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L284:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 284 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L285:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 285 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L285:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 285 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L286:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 286 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2014 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L286:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 286 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L287:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 287 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L287:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 287 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L288:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 288 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L288:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 288 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L289:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 289 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2015 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L289:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 289 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L290:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 290 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L290:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 290 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L291:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 291 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L291:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 291 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L292:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 292 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2017 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L292:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 292 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L293:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 293 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L293:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 293 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L294:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 294 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L294:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 294 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L295:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 295 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2018 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L295:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 295 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L296:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 296 1011 `=_rc' // WFLOG-INJECTED
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L296:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 296 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L297:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 297 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L297:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 297 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L298:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 298 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_citygas_rp000=5 if source_year==2019 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L298:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 298 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L299:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 299 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_citygas_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L299:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 299 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L300:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 300 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coal_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L300:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 300 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L301:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 301 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coal_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L301:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 301 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L302:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 302 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L302:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 302 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L303:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 303 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L303:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 303 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L304:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 304 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2010 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L304:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 304 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L305:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 305 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L305:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 305 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L306:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 306 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L306:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 306 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L307:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 307 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2011 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L307:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 307 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L308:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 308 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L308:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 308 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L309:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 309 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L309:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 309 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L310:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 310 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2012 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L310:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 310 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L311:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 311 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L311:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 311 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L312:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 312 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L312:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 312 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L313:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 313 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2013 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L313:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 313 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L314:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 314 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L314:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 314 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L315:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 315 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L315:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 315 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L316:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 316 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2014 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L316:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 316 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L317:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 317 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L317:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 317 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L318:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 318 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L318:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 318 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L319:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 319 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2015 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L319:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 319 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L320:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 320 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L320:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 320 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L321:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 321 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L321:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 321 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L322:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 322 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2017 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L322:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 322 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L323:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 323 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L323:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 323 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L324:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 324 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L324:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 324 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L325:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 325 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2018 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L325:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 325 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L326:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 326 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L326:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 326 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L327:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 327 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L327:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 327 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L328:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 328 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2019 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L328:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 328 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L329:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 329 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L329:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 329 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L330:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 330 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L330:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 330 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L331:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 331 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2020 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L331:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 331 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L332:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 332 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L332:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 332 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L333:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 333 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L333:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 333 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L334:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 334 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2021 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L334:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 334 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L335:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 335 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L335:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 335 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L336:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 336 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L336:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 336 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L337:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 337 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_kg=5 if source_year==2022 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L337:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 337 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L338:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 338 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coal_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L338:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 338 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L339:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 339 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coal_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L339:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 339 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L340:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 340 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coal_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L340:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 340 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L341:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 341 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L341:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 341 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L342:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 342 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L342:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 342 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L343:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 343 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2010 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L343:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 343 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L344:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 344 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L344:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 344 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L345:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 345 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L345:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 345 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L346:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 346 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2011 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L346:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 346 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L347:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 347 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L347:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 347 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L348:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 348 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L348:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 348 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L349:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 349 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2012 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L349:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 349 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L350:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 350 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L350:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 350 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L351:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 351 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L351:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 351 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L352:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 352 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2013 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L352:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 352 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L353:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 353 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L353:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 353 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L354:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 354 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L354:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 354 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L355:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 355 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2014 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L355:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 355 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L356:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 356 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L356:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 356 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L357:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 357 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L357:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 357 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L358:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 358 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2015 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L358:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 358 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L359:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 359 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L359:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 359 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L360:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 360 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L360:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 360 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L361:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 361 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2017 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L361:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 361 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L362:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 362 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L362:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 362 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L363:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 363 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L363:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 363 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L364:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 364 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2018 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L364:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 364 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L365:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 365 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L365:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 365 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L366:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 366 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L366:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 366 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L367:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 367 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2019 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L367:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 367 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L368:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 368 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L368:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 368 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L369:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 369 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L369:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 369 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L370:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 370 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2020 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L370:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 370 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L371:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 371 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L371:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 371 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L372:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 372 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L372:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 372 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L373:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 373 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2021 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L373:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 373 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L374:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 374 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L374:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 374 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L375:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 375 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L375:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 375 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L376:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 376 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coal_rp000=5 if source_year==2022 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L376:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 376 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L377:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 377 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coal_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L377:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 377 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L378:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 378 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coalbriq_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L378:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 378 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L379:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 379 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coalbriq_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L379:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 379 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L380:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 380 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L380:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 380 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L381:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 381 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L381:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 381 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L382:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 382 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2012 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L382:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 382 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L383:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 383 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L383:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 383 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L384:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 384 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L384:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 384 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L385:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 385 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2013 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L385:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 385 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L386:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 386 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L386:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 386 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L387:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 387 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L387:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 387 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L388:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 388 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2014 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L388:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 388 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L389:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 389 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L389:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 389 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L390:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 390 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L390:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 390 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L391:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 391 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2017 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L391:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 391 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L392:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 392 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L392:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 392 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L393:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 393 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L393:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 393 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L394:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 394 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2018 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L394:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 394 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L395:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 395 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L395:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 395 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L396:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 396 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L396:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 396 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L397:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 397 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2019 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L397:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 397 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L398:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 398 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L398:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 398 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L399:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 399 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L399:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 399 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L400:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 400 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2020 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L400:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 400 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L401:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 401 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L401:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 401 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L402:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 402 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L402:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 402 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L403:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 403 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2021 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L403:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 403 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L404:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 404 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L404:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 404 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L405:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 405 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L405:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 405 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L406:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 406 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_kg=5 if source_year==2022 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L406:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 406 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L407:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 407 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coalbriq_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L407:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 407 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L408:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 408 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coalbriq_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L408:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 408 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L409:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 409 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coalbriq_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L409:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 409 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L410:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 410 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L410:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 410 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L411:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 411 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L411:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 411 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L412:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 412 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2012 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L412:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 412 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L413:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 413 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L413:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 413 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L414:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 414 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L414:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 414 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L415:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 415 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2013 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L415:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 415 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L416:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 416 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L416:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 416 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L417:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 417 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L417:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 417 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L418:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 418 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2014 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L418:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 418 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L419:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 419 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L419:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 419 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L420:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 420 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L420:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 420 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L421:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 421 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2017 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L421:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 421 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L422:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 422 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L422:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 422 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L423:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 423 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L423:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 423 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L424:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 424 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2018 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L424:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 424 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L425:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 425 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L425:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 425 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L426:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 426 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L426:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 426 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L427:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 427 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2019 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L427:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 427 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L428:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 428 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L428:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 428 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L429:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 429 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L429:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 429 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L430:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 430 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2020 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L430:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 430 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L431:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 431 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L431:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 431 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L432:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 432 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L432:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 432 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L433:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 433 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2021 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L433:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 433 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L434:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 434 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L434:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 434 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L435:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 435 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L435:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 435 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L436:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 436 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coalbriq_rp000=5 if source_year==2022 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L436:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 436 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L437:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 437 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coalbriq_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L437:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 437 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L438:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 438 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coke_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L438:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 438 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L439:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 439 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coke_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L439:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 439 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L440:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 440 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coke_kg=real(subinstr(strtrim(raw_eckkgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L440:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 440 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L441:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 441 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_kg=cond(missing(fuel_coke_kg),3,cond(fuel_coke_kg<0,2,cond(fuel_coke_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L441:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 441 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L442:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 442 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_kg=5 if source_year==2022 & missing(fuel_coke_kg) & !inlist(upper(strtrim(raw_eckkgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L442:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 442 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L443:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 443 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coke_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L443:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 443 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L444:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 444 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_coke_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L444:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 444 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L445:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 445 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_coke_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L445:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 445 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L446:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 446 1011 `=_rc' // WFLOG-INJECTED
replace fuel_coke_rp000=real(subinstr(strtrim(raw_eckvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L446:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 446 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L447:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 447 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_rp000=cond(missing(fuel_coke_rp000),3,cond(fuel_coke_rp000<0,2,cond(fuel_coke_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L447:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 447 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L448:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 448 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_coke_rp000=5 if source_year==2022 & missing(fuel_coke_rp000) & !inlist(upper(strtrim(raw_eckvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L448:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 448 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L449:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 449 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_coke_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L449:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 449 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L450:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 450 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_diesel_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L450:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 450 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L451:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 451 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_diesel_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L451:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 451 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L452:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 452 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L452:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 452 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L453:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 453 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L453:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 453 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L454:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 454 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2010 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L454:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 454 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L455:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 455 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L455:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 455 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L456:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 456 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L456:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 456 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L457:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 457 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2011 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L457:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 457 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L458:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 458 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L458:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 458 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L459:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 459 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L459:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 459 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L460:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 460 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2012 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L460:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 460 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L461:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 461 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L461:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 461 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L462:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 462 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L462:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 462 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L463:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 463 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2013 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L463:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 463 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L464:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 464 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L464:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 464 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L465:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 465 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L465:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 465 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L466:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 466 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2014 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L466:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 466 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L467:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 467 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L467:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 467 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L468:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 468 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L468:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 468 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L469:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 469 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2015 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L469:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 469 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L470:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 470 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L470:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 470 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L471:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 471 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L471:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 471 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L472:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 472 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2017 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L472:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 472 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L473:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 473 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L473:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 473 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L474:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 474 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L474:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 474 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L475:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 475 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2018 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L475:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 475 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L476:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 476 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L476:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 476 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L477:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 477 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L477:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 477 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L478:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 478 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2019 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L478:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 478 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L479:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 479 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L479:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 479 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L480:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 480 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L480:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 480 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L481:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 481 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2020 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L481:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 481 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L482:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 482 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L482:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 482 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L483:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 483 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L483:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 483 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L484:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 484 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2021 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L484:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 484 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L485:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 485 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L485:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 485 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L486:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 486 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L486:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 486 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L487:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 487 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_ltr=5 if source_year==2022 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L487:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 487 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L488:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 488 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_diesel_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L488:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 488 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L489:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 489 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_diesel_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L489:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 489 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L490:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 490 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_diesel_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L490:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 490 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L491:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 491 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L491:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 491 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L492:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 492 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L492:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 492 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L493:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 493 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2010 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L493:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 493 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L494:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 494 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L494:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 494 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L495:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 495 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L495:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 495 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L496:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 496 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2011 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L496:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 496 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L497:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 497 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L497:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 497 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L498:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 498 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L498:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 498 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L499:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 499 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2012 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L499:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 499 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L500:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 500 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L500:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 500 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L501:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 501 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L501:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 501 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L502:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 502 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2013 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L502:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 502 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L503:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 503 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L503:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 503 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L504:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 504 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L504:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 504 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L505:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 505 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2014 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L505:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 505 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L506:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 506 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L506:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 506 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L507:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 507 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L507:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 507 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L508:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 508 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2015 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L508:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 508 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L509:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 509 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L509:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 509 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L510:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 510 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L510:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 510 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L511:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 511 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2017 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L511:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 511 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L512:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 512 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L512:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 512 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L513:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 513 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L513:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 513 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L514:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 514 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2018 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L514:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 514 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L515:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 515 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L515:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 515 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L516:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 516 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L516:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 516 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L517:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 517 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2019 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L517:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 517 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L518:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 518 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L518:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 518 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L519:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 519 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L519:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 519 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L520:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 520 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2020 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L520:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 520 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L521:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 521 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L521:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 521 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L522:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 522 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L522:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 522 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L523:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 523 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2021 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L523:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 523 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L524:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 524 1011 `=_rc' // WFLOG-INJECTED
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L524:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 524 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L525:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 525 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L525:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 525 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L526:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 526 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_diesel_rp000=5 if source_year==2022 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L526:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 526 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L527:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 527 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_diesel_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L527:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 527 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L528:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 528 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_dieseloil_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L528:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 528 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L529:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 529 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_dieseloil_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L529:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 529 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L530:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 530 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L530:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 530 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L531:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 531 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L531:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 531 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L532:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 532 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=5 if source_year==2020 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L532:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 532 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L533:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 533 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L533:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 533 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L534:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 534 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L534:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 534 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L535:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 535 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=5 if source_year==2021 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L535:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 535 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L536:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 536 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L536:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 536 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L537:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 537 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L537:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 537 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L538:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 538 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_ltr=5 if source_year==2022 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L538:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 538 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L539:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 539 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_dieseloil_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L539:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 539 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L540:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 540 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_dieseloil_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L540:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 540 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L541:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 541 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_dieseloil_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L541:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 541 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L542:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 542 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L542:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 542 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L543:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 543 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L543:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 543 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L544:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 544 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=5 if source_year==2020 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L544:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 544 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L545:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 545 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L545:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 545 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L546:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 546 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L546:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 546 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L547:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 547 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=5 if source_year==2021 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L547:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 547 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L548:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 548 1011 `=_rc' // WFLOG-INJECTED
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L548:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 548 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L549:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 549 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L549:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 549 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L550:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 550 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_dieseloil_rp000=5 if source_year==2022 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L550:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 550 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L551:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 551 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_dieseloil_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L551:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 551 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L552:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 552 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_firewood_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L552:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 552 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L553:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 553 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_firewood_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L553:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 553 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L554:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 554 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_firewood_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L554:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 554 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L555:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 555 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_firewood_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L555:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 555 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L556:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 556 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_firewood_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L556:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 556 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L557:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 557 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_firewood_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L557:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 557 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L558:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 558 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_fueloil_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L558:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 558 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L559:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 559 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_fueloil_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L559:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 559 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L560:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 560 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L560:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 560 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L561:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 561 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L561:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 561 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L562:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 562 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=5 if source_year==2020 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L562:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 562 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L563:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 563 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L563:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 563 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L564:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 564 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L564:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 564 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L565:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 565 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=5 if source_year==2021 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L565:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 565 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L566:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 566 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L566:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 566 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L567:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 567 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L567:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 567 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L568:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 568 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_ltr=5 if source_year==2022 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L568:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 568 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L569:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 569 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_fueloil_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L569:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 569 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L570:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 570 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_fueloil_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L570:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 570 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L571:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 571 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_fueloil_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L571:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 571 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L572:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 572 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L572:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 572 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L573:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 573 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L573:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 573 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L574:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 574 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=5 if source_year==2020 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L574:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 574 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L575:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 575 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L575:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 575 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L576:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 576 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L576:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 576 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L577:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 577 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=5 if source_year==2021 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L577:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 577 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L578:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 578 1011 `=_rc' // WFLOG-INJECTED
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L578:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 578 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L579:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 579 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L579:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 579 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L580:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 580 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_fueloil_rp000=5 if source_year==2022 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L580:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 580 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L581:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 581 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_fueloil_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L581:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 581 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L582:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 582 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_kerosene_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L582:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 582 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L583:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 583 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_kerosene_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L583:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 583 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L584:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 584 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L584:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 584 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L585:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 585 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L585:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 585 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L586:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 586 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2010 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L586:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 586 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L587:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 587 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L587:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 587 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L588:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 588 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L588:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 588 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L589:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 589 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2011 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L589:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 589 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L590:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 590 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L590:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 590 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L591:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 591 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L591:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 591 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L592:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 592 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2012 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L592:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 592 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L593:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 593 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L593:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 593 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L594:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 594 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L594:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 594 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L595:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 595 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2013 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L595:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 595 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L596:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 596 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L596:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 596 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L597:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 597 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L597:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 597 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L598:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 598 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2014 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L598:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 598 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L599:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 599 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L599:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 599 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L600:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 600 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L600:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 600 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L601:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 601 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_ltr=5 if source_year==2015 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L601:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 601 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L602:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 602 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_kerosene_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L602:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 602 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L603:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 603 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_kerosene_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L603:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 603 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L604:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 604 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_kerosene_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L604:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 604 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L605:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 605 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L605:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 605 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L606:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 606 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L606:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 606 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L607:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 607 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2010 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L607:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 607 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L608:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 608 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L608:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 608 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L609:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 609 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L609:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 609 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L610:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 610 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2011 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L610:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 610 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L611:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 611 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L611:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 611 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L612:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 612 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L612:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 612 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L613:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 613 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2012 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L613:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 613 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L614:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 614 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L614:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 614 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L615:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 615 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L615:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 615 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L616:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 616 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2013 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L616:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 616 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L617:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 617 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L617:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 617 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L618:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 618 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L618:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 618 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L619:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 619 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2014 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L619:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 619 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L620:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 620 1011 `=_rc' // WFLOG-INJECTED
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L620:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 620 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L621:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 621 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L621:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 621 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L622:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 622 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_kerosene_rp000=5 if source_year==2015 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L622:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 622 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L623:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 623 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_kerosene_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L623:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 623 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L624:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 624 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_lpg_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L624:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 624 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L625:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 625 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_lpg_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L625:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 625 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L626:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 626 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L626:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 626 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L627:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 627 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L627:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 627 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L628:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 628 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2010 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L628:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 628 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L629:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 629 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L629:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 629 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L630:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 630 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L630:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 630 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L631:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 631 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2011 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L631:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 631 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L632:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 632 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L632:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 632 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L633:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 633 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L633:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 633 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L634:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 634 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2012 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L634:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 634 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L635:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 635 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L635:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 635 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L636:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 636 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L636:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 636 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L637:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 637 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2013 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L637:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 637 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L638:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 638 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L638:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 638 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L639:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 639 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L639:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 639 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L640:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 640 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2014 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L640:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 640 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L641:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 641 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L641:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 641 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L642:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 642 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L642:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 642 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L643:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 643 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2015 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L643:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 643 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L644:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 644 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L644:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 644 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L645:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 645 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L645:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 645 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L646:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 646 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2017 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L646:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 646 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L647:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 647 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L647:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 647 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L648:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 648 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L648:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 648 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L649:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 649 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2018 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L649:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 649 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L650:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 650 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L650:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 650 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L651:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 651 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L651:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 651 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L652:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 652 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2019 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L652:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 652 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L653:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 653 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L653:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 653 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L654:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 654 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L654:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 654 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L655:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 655 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2020 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L655:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 655 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L656:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 656 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L656:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 656 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L657:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 657 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L657:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 657 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L658:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 658 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2021 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L658:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 658 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L659:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 659 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L659:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 659 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L660:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 660 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L660:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 660 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L661:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 661 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_kg=5 if source_year==2022 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L661:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 661 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L662:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 662 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_lpg_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L662:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 662 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L663:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 663 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_lpg_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L663:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 663 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L664:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 664 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_lpg_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L664:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 664 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L665:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 665 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L665:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 665 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L666:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 666 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L666:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 666 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L667:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 667 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2010 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L667:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 667 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L668:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 668 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L668:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 668 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L669:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 669 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L669:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 669 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L670:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 670 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2011 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L670:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 670 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L671:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 671 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L671:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 671 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L672:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 672 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L672:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 672 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L673:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 673 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2012 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L673:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 673 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L674:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 674 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L674:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 674 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L675:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 675 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L675:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 675 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L676:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 676 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2013 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L676:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 676 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L677:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 677 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L677:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 677 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L678:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 678 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L678:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 678 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L679:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 679 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2014 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L679:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 679 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L680:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 680 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L680:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 680 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L681:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 681 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L681:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 681 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L682:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 682 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2015 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L682:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 682 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L683:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 683 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L683:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 683 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L684:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 684 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L684:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 684 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L685:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 685 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2017 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L685:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 685 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L686:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 686 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L686:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 686 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L687:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 687 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L687:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 687 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L688:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 688 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2018 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L688:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 688 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L689:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 689 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L689:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 689 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L690:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 690 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L690:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 690 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L691:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 691 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2019 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L691:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 691 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L692:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 692 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L692:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 692 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L693:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 693 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L693:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 693 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L694:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 694 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2020 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L694:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 694 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L695:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 695 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L695:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 695 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L696:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 696 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L696:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 696 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L697:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 697 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2021 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L697:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 697 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L698:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 698 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L698:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 698 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L699:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 699 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L699:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 699 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L700:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 700 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lpg_rp000=5 if source_year==2022 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L700:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 700 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L701:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 701 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_lpg_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L701:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 701 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L702:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 702 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_lubricant_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L702:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 702 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L703:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 703 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_lubricant_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L703:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 703 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L704:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 704 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L704:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 704 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L705:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 705 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L705:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 705 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L706:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 706 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2010 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L706:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 706 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L707:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 707 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L707:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 707 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L708:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 708 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L708:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 708 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L709:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 709 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2011 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L709:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 709 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L710:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 710 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L710:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 710 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L711:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 711 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L711:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 711 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L712:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 712 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2012 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L712:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 712 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L713:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 713 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L713:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 713 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L714:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 714 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L714:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 714 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L715:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 715 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2013 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L715:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 715 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L716:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 716 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L716:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 716 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L717:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 717 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L717:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 717 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L718:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 718 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2014 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L718:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 718 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L719:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 719 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L719:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 719 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L720:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 720 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L720:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 720 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L721:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 721 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2015 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L721:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 721 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L722:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 722 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L722:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 722 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L723:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 723 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L723:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 723 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L724:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 724 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2017 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L724:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 724 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L725:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 725 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L725:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 725 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L726:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 726 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L726:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 726 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L727:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 727 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2018 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L727:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 727 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L728:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 728 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L728:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 728 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L729:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 729 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L729:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 729 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L730:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 730 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2019 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L730:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 730 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L731:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 731 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L731:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 731 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L732:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 732 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L732:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 732 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L733:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 733 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2020 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L733:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 733 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L734:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 734 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L734:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 734 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L735:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 735 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L735:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 735 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L736:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 736 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2021 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L736:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 736 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L737:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 737 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L737:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 737 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L738:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 738 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L738:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 738 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L739:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 739 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_ltr=5 if source_year==2022 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L739:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 739 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L740:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 740 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_lubricant_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L740:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 740 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L741:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 741 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_lubricant_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L741:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 741 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L742:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 742 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_lubricant_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L742:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 742 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L743:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 743 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L743:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 743 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L744:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 744 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L744:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 744 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L745:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 745 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2010 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L745:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 745 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L746:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 746 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L746:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 746 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L747:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 747 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L747:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 747 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L748:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 748 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2011 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L748:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 748 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L749:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 749 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L749:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 749 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L750:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 750 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L750:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 750 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L751:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 751 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2012 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L751:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 751 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L752:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 752 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L752:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 752 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L753:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 753 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L753:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 753 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L754:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 754 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2013 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L754:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 754 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L755:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 755 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L755:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 755 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L756:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 756 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L756:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 756 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L757:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 757 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2014 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L757:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 757 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L758:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 758 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L758:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 758 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L759:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 759 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L759:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 759 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L760:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 760 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2015 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L760:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 760 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L761:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 761 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L761:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 761 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L762:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 762 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L762:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 762 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L763:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 763 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2017 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L763:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 763 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L764:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 764 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L764:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 764 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L765:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 765 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L765:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 765 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L766:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 766 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2018 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L766:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 766 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L767:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 767 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L767:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 767 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L768:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 768 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L768:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 768 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L769:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 769 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2019 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L769:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 769 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L770:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 770 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L770:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 770 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L771:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 771 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L771:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 771 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L772:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 772 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2020 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L772:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 772 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L773:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 773 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L773:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 773 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L774:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 774 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L774:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 774 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L775:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 775 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2021 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L775:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 775 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L776:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 776 1011 `=_rc' // WFLOG-INJECTED
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L776:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 776 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L777:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 777 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L777:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 777 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L778:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 778 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_lubricant_rp000=5 if source_year==2022 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L778:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 778 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L779:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 779 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_lubricant_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L779:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 779 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L780:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 780 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_natgas_kg=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L780:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 780 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L781:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 781 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_natgas_kg=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L781:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 781 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L782:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 782 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L782:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 782 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L783:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 783 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L783:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 783 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L784:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 784 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=5 if source_year==2020 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L784:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 784 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L785:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 785 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L785:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 785 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L786:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 786 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L786:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 786 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L787:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 787 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=5 if source_year==2021 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L787:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 787 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L788:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 788 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L788:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 788 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L789:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 789 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L789:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 789 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L790:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 790 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_kg=5 if source_year==2022 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L790:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 790 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L791:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 791 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_natgas_kg G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L791:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 791 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L792:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 792 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_natgas_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L792:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 792 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L793:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 793 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_natgas_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L793:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 793 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L794:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 794 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L794:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 794 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L795:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 795 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L795:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 795 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L796:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 796 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=5 if source_year==2020 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L796:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 796 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L797:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 797 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L797:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 797 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L798:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 798 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L798:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 798 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L799:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 799 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=5 if source_year==2021 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L799:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 799 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L800:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 800 1011 `=_rc' // WFLOG-INJECTED
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L800:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 800 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L801:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 801 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L801:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 801 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L802:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 802 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_natgas_rp000=5 if source_year==2022 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L802:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 802 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L803:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 803 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_natgas_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L803:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 803 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L804:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 804 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_other_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L804:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 804 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L805:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 805 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_other_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L805:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 805 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L806:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 806 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L806:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 806 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L807:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 807 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L807:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 807 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L808:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 808 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2010 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L808:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 808 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L809:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 809 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L809:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 809 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L810:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 810 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L810:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 810 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L811:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 811 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2011 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L811:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 811 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L812:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 812 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L812:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 812 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L813:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 813 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L813:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 813 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L814:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 814 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2012 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L814:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 814 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L815:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 815 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L815:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 815 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L816:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 816 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L816:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 816 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L817:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 817 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2013 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L817:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 817 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L818:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 818 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L818:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 818 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L819:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 819 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L819:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 819 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L820:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 820 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2014 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L820:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 820 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L821:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 821 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L821:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 821 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L822:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 822 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L822:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 822 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L823:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 823 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2015 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L823:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 823 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L824:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 824 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L824:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 824 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L825:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 825 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L825:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 825 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L826:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 826 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2017 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L826:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 826 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L827:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 827 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L827:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 827 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L828:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 828 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L828:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 828 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L829:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 829 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2018 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L829:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 829 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L830:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 830 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L830:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 830 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L831:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 831 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L831:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 831 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L832:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 832 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2019 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L832:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 832 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L833:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 833 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L833:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 833 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L834:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 834 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L834:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 834 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L835:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 835 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2020 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L835:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 835 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L836:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 836 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L836:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 836 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L837:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 837 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L837:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 837 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L838:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 838 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2021 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L838:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 838 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L839:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 839 1011 `=_rc' // WFLOG-INJECTED
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L839:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 839 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L840:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 840 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L840:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 840 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L841:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 841 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_other_rp000=5 if source_year==2022 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L841:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 841 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L842:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 842 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_other_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L842:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 842 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L843:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 843 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_othergas_m3=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L843:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 843 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L844:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 844 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_othergas_m3=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L844:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 844 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L845:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 845 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L845:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 845 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L846:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 846 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L846:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 846 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L847:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 847 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2012 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L847:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 847 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L848:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 848 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L848:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 848 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L849:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 849 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L849:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 849 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L850:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 850 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2013 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L850:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 850 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L851:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 851 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L851:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 851 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L852:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 852 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L852:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 852 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L853:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 853 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2014 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L853:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 853 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L854:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 854 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L854:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 854 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L855:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 855 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L855:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 855 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L856:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 856 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2017 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L856:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 856 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L857:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 857 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L857:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 857 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L858:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 858 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L858:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 858 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L859:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 859 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2018 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L859:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 859 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L860:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 860 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L860:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 860 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L861:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 861 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L861:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 861 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L862:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 862 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_m3=5 if source_year==2019 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L862:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 862 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L863:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 863 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_othergas_m3 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L863:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 863 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L864:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 864 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_othergas_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L864:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 864 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L865:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 865 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_othergas_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L865:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 865 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L866:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 866 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L866:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 866 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L867:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 867 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L867:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 867 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L868:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 868 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2012 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L868:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 868 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L869:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 869 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L869:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 869 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L870:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 870 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L870:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 870 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L871:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 871 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2013 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L871:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 871 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L872:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 872 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L872:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 872 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L873:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 873 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L873:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 873 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L874:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 874 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2014 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L874:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 874 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L875:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 875 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L875:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 875 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L876:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 876 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L876:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 876 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L877:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 877 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2017 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L877:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 877 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L878:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 878 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L878:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 878 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L879:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 879 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L879:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 879 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L880:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 880 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2018 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L880:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 880 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L881:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 881 1011 `=_rc' // WFLOG-INJECTED
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L881:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 881 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L882:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 882 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L882:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 882 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L883:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 883 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_othergas_rp000=5 if source_year==2019 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L883:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 883 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L884:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 884 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_othergas_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L884:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 884 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L885:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 885 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_petrol_ltr=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L885:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 885 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L886:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 886 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_petrol_ltr=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L886:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 886 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L887:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 887 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L887:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 887 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L888:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 888 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L888:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 888 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L889:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 889 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2010 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L889:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 889 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L890:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 890 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L890:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 890 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L891:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 891 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L891:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 891 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L892:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 892 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2011 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L892:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 892 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L893:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 893 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L893:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 893 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L894:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 894 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L894:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 894 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L895:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 895 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2012 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L895:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 895 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L896:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 896 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L896:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 896 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L897:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 897 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L897:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 897 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L898:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 898 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2013 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L898:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 898 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L899:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 899 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L899:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 899 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L900:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 900 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L900:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 900 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L901:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 901 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2014 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L901:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 901 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L902:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 902 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L902:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 902 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L903:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 903 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L903:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 903 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L904:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 904 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2015 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L904:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 904 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L905:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 905 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L905:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 905 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L906:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 906 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L906:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 906 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L907:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 907 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2017 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L907:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 907 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L908:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 908 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L908:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 908 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L909:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 909 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L909:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 909 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L910:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 910 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2018 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L910:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 910 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L911:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 911 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L911:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 911 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L912:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 912 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L912:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 912 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L913:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 913 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2019 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L913:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 913 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L914:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 914 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L914:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 914 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L915:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 915 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L915:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 915 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L916:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 916 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2020 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L916:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 916 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L917:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 917 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L917:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 917 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L918:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 918 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L918:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 918 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L919:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 919 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2021 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L919:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 919 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L920:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 920 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L920:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 920 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L921:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 921 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L921:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 921 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L922:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 922 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_ltr=5 if source_year==2022 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L922:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 922 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L923:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 923 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_petrol_ltr G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L923:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 923 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L924:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 924 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_petrol_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L924:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 924 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L925:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 925 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_petrol_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L925:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 925 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L926:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 926 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L926:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 926 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L927:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 927 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L927:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 927 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L928:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 928 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2010 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L928:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 928 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L929:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 929 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L929:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 929 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L930:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 930 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L930:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 930 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L931:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 931 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2011 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L931:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 931 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L932:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 932 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L932:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 932 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L933:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 933 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L933:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 933 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L934:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 934 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2012 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L934:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 934 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L935:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 935 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L935:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 935 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L936:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 936 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L936:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 936 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L937:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 937 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2013 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L937:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 937 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L938:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 938 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L938:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 938 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L939:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 939 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L939:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 939 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L940:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 940 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2014 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L940:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 940 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L941:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 941 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L941:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 941 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L942:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 942 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L942:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 942 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L943:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 943 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2015 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L943:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 943 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L944:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 944 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L944:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 944 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L945:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 945 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L945:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 945 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L946:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 946 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2017 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L946:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 946 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L947:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 947 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L947:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 947 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L948:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 948 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L948:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 948 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L949:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 949 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2018 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L949:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 949 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L950:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 950 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L950:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 950 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L951:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 951 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L951:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 951 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L952:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 952 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2019 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L952:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 952 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L953:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 953 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L953:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 953 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L954:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 954 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L954:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 954 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L955:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 955 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2020 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L955:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 955 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L956:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 956 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L956:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 956 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L957:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 957 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L957:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 957 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L958:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 958 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2021 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L958:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 958 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L959:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 959 1011 `=_rc' // WFLOG-INJECTED
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L959:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 959 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L960:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 960 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L960:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 960 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L961:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 961 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_petrol_rp000=5 if source_year==2022 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L961:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 961 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L962:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 962 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_petrol_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L962:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 962 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L963:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 963 1011 `=_rc' // WFLOG-INJECTED
generate double fuel_total_reported_rp000=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L963:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 963 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L964:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 964 1011 `=_rc' // WFLOG-INJECTED
generate byte st_fuel_total_reported_rp000=4
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L964:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 964 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L965:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 965 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu10),",","",.)) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L965:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 965 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L966:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 966 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2010
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L966:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 966 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L967:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 967 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2010 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu10)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L967:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 967 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L968:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 968 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu11),",","",.)) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L968:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 968 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L969:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 969 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2011
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L969:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 969 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L970:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 970 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2011 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu11)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L970:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 970 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L971:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 971 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu12),",","",.)) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L971:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 971 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L972:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 972 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2012
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L972:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 972 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L973:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 973 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2012 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu12)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L973:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 973 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L974:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 974 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu13),",","",.)) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L974:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 974 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L975:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 975 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2013
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L975:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 975 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L976:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 976 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2013 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu13)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L976:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 976 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L977:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 977 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu14),",","",.)) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L977:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 977 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L978:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 978 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L978:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 978 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L979:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 979 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2014 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu14)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L979:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 979 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L980:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 980 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu),",","",.)) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L980:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 980 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L981:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 981 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2015
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L981:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 981 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L982:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 982 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2015 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L982:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 982 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L983:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 983 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu17),",","",.)) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L983:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 983 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L984:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 984 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2017
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L984:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 984 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L985:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 985 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2017 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu17)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L985:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 985 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L986:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 986 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu18),",","",.)) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L986:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 986 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L987:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 987 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2018
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L987:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 987 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L988:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 988 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2018 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu18)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L988:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 988 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L989:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 989 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu19),",","",.)) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L989:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 989 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L990:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 990 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2019
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L990:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 990 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L991:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 991 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2019 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu19)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L991:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 991 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L992:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 992 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu20),",","",.)) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L992:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 992 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L993:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 993 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2020
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L993:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 993 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L994:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 994 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2020 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu20)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L994:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 994 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L995:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 995 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu21),",","",.)) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L995:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 995 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L996:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 996 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2021
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L996:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 996 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L997:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 997 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2021 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu21)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L997:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 997 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L998:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 998 1011 `=_rc' // WFLOG-INJECTED
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu22),",","",.)) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L998:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 998 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L999:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 999 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2022
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L999:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 999 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1000:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1000 1011 `=_rc' // WFLOG-INJECTED
replace st_fuel_total_reported_rp000=5 if source_year==2022 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu22)),"","***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1000:step-replace" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1000 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1001:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1001 1011 `=_rc' // WFLOG-INJECTED
label values st_fuel_total_reported_rp000 G0_source_state
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1001:step-label" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1001 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1002:step-keep" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1002 1011 `=_rc' // WFLOG-INJECTED
keep source_year source_row elec_nonpln_kwh elec_nonpln_rp000 elec_owngen_kwh elec_pln_kwh elec_pln_rp000 fuel_biodiesel_ltr fuel_biodiesel_rp000 fuel_charcoal_kg fuel_charcoal_rp000 fuel_citygas_m3 fuel_citygas_rp000 fuel_coal_kg fuel_coal_rp000 fuel_coalbriq_kg fuel_coalbriq_rp000 fuel_coke_kg fuel_coke_rp000 fuel_diesel_ltr fuel_diesel_rp000 fuel_dieseloil_ltr fuel_dieseloil_rp000 fuel_firewood_kg fuel_firewood_rp000 fuel_fueloil_ltr fuel_fueloil_rp000 fuel_kerosene_ltr fuel_kerosene_rp000 fuel_lpg_kg fuel_lpg_rp000 fuel_lubricant_ltr fuel_lubricant_rp000 fuel_natgas_kg fuel_natgas_rp000 fuel_other_rp000 fuel_othergas_m3 fuel_othergas_rp000 fuel_petrol_ltr fuel_petrol_rp000 fuel_total_reported_rp000 st_*
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1002:step-keep" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1002 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1003:step-isid" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1003 1011 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1003:step-isid" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1003 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1004:step-save" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1004 1011 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_energy_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1004:step-save" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1004 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1005:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1005 1011 `=_rc' // WFLOG-INJECTED
generate byte legacy_unit_contract=source_year<=2014
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1005:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1005 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1006:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1006 1011 `=_rc' // WFLOG-INJECTED
generate str64 unit_status=cond(legacy_unit_contract,"legacy_2010_2014_mapping","post2014_unit_mapping_requires_validation")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1006:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1006 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1007:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1007 1011 `=_rc' // WFLOG-INJECTED
generate double grid_factor_s1=cond(source_year==2010,.000599,cond(source_year==2011,.000690,cond(source_year==2012,.000782,cond(source_year==2013,.000873,.000914))))
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1007:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1007 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1008:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1008 1011 `=_rc' // WFLOG-INJECTED
generate double grid_factor_s2=.000867
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1008:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1008 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1009:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1009 1011 `=_rc' // WFLOG-INJECTED
generate str48 factor_status=cond(source_year<=2014,"LUDI_annual_factor","assumption_carry_2014_factor")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1009:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1009 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1010:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1010 1011 `=_rc' // WFLOG-INJECTED
generate str64 factor_contract="LUDI_E010_E011_E012_E016; static_PLN_sensitivity"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1010:step-generate" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1010 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1011:step-save" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1011 1011 `=_rc' // WFLOG-INJECTED
save "$G0D/G0_energy_fields.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1011:step-save" "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "statement" 1011 1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_07_validate_energy_units_factors.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
