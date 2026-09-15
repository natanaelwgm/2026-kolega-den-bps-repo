* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_raw_fields_preserved.dta // WFDOC-INJECTED
* Output: dag/data/word_data/G0/G0_energy_fields.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
use "$G0D/G0_raw_fields_preserved.dta", clear
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
generate double elec_nonpln_kwh=.
generate byte st_elec_nonpln_kwh=4
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu10),",","",.)) if source_year==2010
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2010
replace st_elec_nonpln_kwh=5 if source_year==2010 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu10)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu11),",","",.)) if source_year==2011
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2011
replace st_elec_nonpln_kwh=5 if source_year==2011 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu11)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu12),",","",.)) if source_year==2012
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2012
replace st_elec_nonpln_kwh=5 if source_year==2012 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu12)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu13),",","",.)) if source_year==2013
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2013
replace st_elec_nonpln_kwh=5 if source_year==2013 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu13)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu14),",","",.)) if source_year==2014
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2014
replace st_elec_nonpln_kwh=5 if source_year==2014 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu14)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu),",","",.)) if source_year==2015
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2015
replace st_elec_nonpln_kwh=5 if source_year==2015 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu17),",","",.)) if source_year==2017
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2017
replace st_elec_nonpln_kwh=5 if source_year==2017 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu17)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu18),",","",.)) if source_year==2018
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2018
replace st_elec_nonpln_kwh=5 if source_year==2018 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu18)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu19),",","",.)) if source_year==2019
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2019
replace st_elec_nonpln_kwh=5 if source_year==2019 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu19)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu20),",","",.)) if source_year==2020
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2020
replace st_elec_nonpln_kwh=5 if source_year==2020 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu20)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu21),",","",.)) if source_year==2021
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2021
replace st_elec_nonpln_kwh=5 if source_year==2021 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu21)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_kwh=real(subinstr(strtrim(raw_enpkhu22),",","",.)) if source_year==2022
replace st_elec_nonpln_kwh=cond(missing(elec_nonpln_kwh),3,cond(elec_nonpln_kwh<0,2,cond(elec_nonpln_kwh==0,1,0))) if source_year==2022
replace st_elec_nonpln_kwh=5 if source_year==2022 & missing(elec_nonpln_kwh) & !inlist(upper(strtrim(raw_enpkhu22)),"","***",".","NA","N/A","NULL","-")
label values st_elec_nonpln_kwh G0_source_state
generate double elec_nonpln_rp000=.
generate byte st_elec_nonpln_rp000=4
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu10),",","",.)) if source_year==2010
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2010
replace st_elec_nonpln_rp000=5 if source_year==2010 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu10)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu11),",","",.)) if source_year==2011
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2011
replace st_elec_nonpln_rp000=5 if source_year==2011 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu11)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu12),",","",.)) if source_year==2012
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2012
replace st_elec_nonpln_rp000=5 if source_year==2012 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu12)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu13),",","",.)) if source_year==2013
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2013
replace st_elec_nonpln_rp000=5 if source_year==2013 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu13)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu14),",","",.)) if source_year==2014
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2014
replace st_elec_nonpln_rp000=5 if source_year==2014 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu14)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu),",","",.)) if source_year==2015
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2015
replace st_elec_nonpln_rp000=5 if source_year==2015 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu17),",","",.)) if source_year==2017
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2017
replace st_elec_nonpln_rp000=5 if source_year==2017 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu17)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu18),",","",.)) if source_year==2018
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2018
replace st_elec_nonpln_rp000=5 if source_year==2018 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu18)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu19),",","",.)) if source_year==2019
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2019
replace st_elec_nonpln_rp000=5 if source_year==2019 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu19)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu20),",","",.)) if source_year==2020
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2020
replace st_elec_nonpln_rp000=5 if source_year==2020 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu20)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu21),",","",.)) if source_year==2021
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2021
replace st_elec_nonpln_rp000=5 if source_year==2021 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu21)),"","***",".","NA","N/A","NULL","-")
replace elec_nonpln_rp000=real(subinstr(strtrim(raw_enpvcu22),",","",.)) if source_year==2022
replace st_elec_nonpln_rp000=cond(missing(elec_nonpln_rp000),3,cond(elec_nonpln_rp000<0,2,cond(elec_nonpln_rp000==0,1,0))) if source_year==2022
replace st_elec_nonpln_rp000=5 if source_year==2022 & missing(elec_nonpln_rp000) & !inlist(upper(strtrim(raw_enpvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_elec_nonpln_rp000 G0_source_state
generate double elec_owngen_kwh=.
generate byte st_elec_owngen_kwh=4
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu10),",","",.)) if source_year==2010
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2010
replace st_elec_owngen_kwh=5 if source_year==2010 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu10)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu11),",","",.)) if source_year==2011
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2011
replace st_elec_owngen_kwh=5 if source_year==2011 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu11)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu12),",","",.)) if source_year==2012
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2012
replace st_elec_owngen_kwh=5 if source_year==2012 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu12)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu13),",","",.)) if source_year==2013
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2013
replace st_elec_owngen_kwh=5 if source_year==2013 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu13)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu14),",","",.)) if source_year==2014
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2014
replace st_elec_owngen_kwh=5 if source_year==2014 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu14)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu),",","",.)) if source_year==2015
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2015
replace st_elec_owngen_kwh=5 if source_year==2015 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu17),",","",.)) if source_year==2017
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2017
replace st_elec_owngen_kwh=5 if source_year==2017 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu17)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu18),",","",.)) if source_year==2018
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2018
replace st_elec_owngen_kwh=5 if source_year==2018 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu18)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu19),",","",.)) if source_year==2019
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2019
replace st_elec_owngen_kwh=5 if source_year==2019 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu19)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu20),",","",.)) if source_year==2020
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2020
replace st_elec_owngen_kwh=5 if source_year==2020 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu20)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu21),",","",.)) if source_year==2021
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2021
replace st_elec_owngen_kwh=5 if source_year==2021 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu21)),"","***",".","NA","N/A","NULL","-")
replace elec_owngen_kwh=real(subinstr(strtrim(raw_esgkhu22),",","",.)) if source_year==2022
replace st_elec_owngen_kwh=cond(missing(elec_owngen_kwh),3,cond(elec_owngen_kwh<0,2,cond(elec_owngen_kwh==0,1,0))) if source_year==2022
replace st_elec_owngen_kwh=5 if source_year==2022 & missing(elec_owngen_kwh) & !inlist(upper(strtrim(raw_esgkhu22)),"","***",".","NA","N/A","NULL","-")
label values st_elec_owngen_kwh G0_source_state
generate double elec_pln_kwh=.
generate byte st_elec_pln_kwh=4
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu10),",","",.)) if source_year==2010
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2010
replace st_elec_pln_kwh=5 if source_year==2010 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu10)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu11),",","",.)) if source_year==2011
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2011
replace st_elec_pln_kwh=5 if source_year==2011 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu11)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu12),",","",.)) if source_year==2012
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2012
replace st_elec_pln_kwh=5 if source_year==2012 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu12)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu13),",","",.)) if source_year==2013
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2013
replace st_elec_pln_kwh=5 if source_year==2013 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu13)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu14),",","",.)) if source_year==2014
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2014
replace st_elec_pln_kwh=5 if source_year==2014 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu14)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu),",","",.)) if source_year==2015
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2015
replace st_elec_pln_kwh=5 if source_year==2015 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu17),",","",.)) if source_year==2017
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2017
replace st_elec_pln_kwh=5 if source_year==2017 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu17)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu18),",","",.)) if source_year==2018
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2018
replace st_elec_pln_kwh=5 if source_year==2018 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu18)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu19),",","",.)) if source_year==2019
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2019
replace st_elec_pln_kwh=5 if source_year==2019 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu19)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu20),",","",.)) if source_year==2020
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2020
replace st_elec_pln_kwh=5 if source_year==2020 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu20)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu21),",","",.)) if source_year==2021
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2021
replace st_elec_pln_kwh=5 if source_year==2021 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu21)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_kwh=real(subinstr(strtrim(raw_eplkhu22),",","",.)) if source_year==2022
replace st_elec_pln_kwh=cond(missing(elec_pln_kwh),3,cond(elec_pln_kwh<0,2,cond(elec_pln_kwh==0,1,0))) if source_year==2022
replace st_elec_pln_kwh=5 if source_year==2022 & missing(elec_pln_kwh) & !inlist(upper(strtrim(raw_eplkhu22)),"","***",".","NA","N/A","NULL","-")
label values st_elec_pln_kwh G0_source_state
generate double elec_pln_rp000=.
generate byte st_elec_pln_rp000=4
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu10),",","",.)) if source_year==2010
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2010
replace st_elec_pln_rp000=5 if source_year==2010 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu10)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu11),",","",.)) if source_year==2011
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2011
replace st_elec_pln_rp000=5 if source_year==2011 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu11)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu12),",","",.)) if source_year==2012
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2012
replace st_elec_pln_rp000=5 if source_year==2012 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu12)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu13),",","",.)) if source_year==2013
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2013
replace st_elec_pln_rp000=5 if source_year==2013 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu13)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu14),",","",.)) if source_year==2014
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2014
replace st_elec_pln_rp000=5 if source_year==2014 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu14)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu),",","",.)) if source_year==2015
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2015
replace st_elec_pln_rp000=5 if source_year==2015 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu17),",","",.)) if source_year==2017
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2017
replace st_elec_pln_rp000=5 if source_year==2017 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu17)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu18),",","",.)) if source_year==2018
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2018
replace st_elec_pln_rp000=5 if source_year==2018 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu18)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu19),",","",.)) if source_year==2019
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2019
replace st_elec_pln_rp000=5 if source_year==2019 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu19)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu20),",","",.)) if source_year==2020
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2020
replace st_elec_pln_rp000=5 if source_year==2020 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu20)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu21),",","",.)) if source_year==2021
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2021
replace st_elec_pln_rp000=5 if source_year==2021 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu21)),"","***",".","NA","N/A","NULL","-")
replace elec_pln_rp000=real(subinstr(strtrim(raw_eplvcu22),",","",.)) if source_year==2022
replace st_elec_pln_rp000=cond(missing(elec_pln_rp000),3,cond(elec_pln_rp000<0,2,cond(elec_pln_rp000==0,1,0))) if source_year==2022
replace st_elec_pln_rp000=5 if source_year==2022 & missing(elec_pln_rp000) & !inlist(upper(strtrim(raw_eplvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_elec_pln_rp000 G0_source_state
generate double fuel_biodiesel_ltr=.
generate byte st_fuel_biodiesel_ltr=4
replace fuel_biodiesel_ltr=real(subinstr(strtrim(raw_esdliu21),",","",.)) if source_year==2021
replace st_fuel_biodiesel_ltr=cond(missing(fuel_biodiesel_ltr),3,cond(fuel_biodiesel_ltr<0,2,cond(fuel_biodiesel_ltr==0,1,0))) if source_year==2021
replace st_fuel_biodiesel_ltr=5 if source_year==2021 & missing(fuel_biodiesel_ltr) & !inlist(upper(strtrim(raw_esdliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_biodiesel_ltr=real(subinstr(strtrim(raw_esdliu22),",","",.)) if source_year==2022
replace st_fuel_biodiesel_ltr=cond(missing(fuel_biodiesel_ltr),3,cond(fuel_biodiesel_ltr<0,2,cond(fuel_biodiesel_ltr==0,1,0))) if source_year==2022
replace st_fuel_biodiesel_ltr=5 if source_year==2022 & missing(fuel_biodiesel_ltr) & !inlist(upper(strtrim(raw_esdliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_biodiesel_ltr G0_source_state
generate double fuel_biodiesel_rp000=.
generate byte st_fuel_biodiesel_rp000=4
replace fuel_biodiesel_rp000=real(subinstr(strtrim(raw_esdvcu21),",","",.)) if source_year==2021
replace st_fuel_biodiesel_rp000=cond(missing(fuel_biodiesel_rp000),3,cond(fuel_biodiesel_rp000<0,2,cond(fuel_biodiesel_rp000==0,1,0))) if source_year==2021
replace st_fuel_biodiesel_rp000=5 if source_year==2021 & missing(fuel_biodiesel_rp000) & !inlist(upper(strtrim(raw_esdvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_biodiesel_rp000=real(subinstr(strtrim(raw_esdvcu22),",","",.)) if source_year==2022
replace st_fuel_biodiesel_rp000=cond(missing(fuel_biodiesel_rp000),3,cond(fuel_biodiesel_rp000<0,2,cond(fuel_biodiesel_rp000==0,1,0))) if source_year==2022
replace st_fuel_biodiesel_rp000=5 if source_year==2022 & missing(fuel_biodiesel_rp000) & !inlist(upper(strtrim(raw_esdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_biodiesel_rp000 G0_source_state
generate double fuel_charcoal_kg=.
generate byte st_fuel_charcoal_kg=4
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu20),",","",.)) if source_year==2020
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2020
replace st_fuel_charcoal_kg=5 if source_year==2020 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu21),",","",.)) if source_year==2021
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2021
replace st_fuel_charcoal_kg=5 if source_year==2021 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_charcoal_kg=real(subinstr(strtrim(raw_ecakgu22),",","",.)) if source_year==2022
replace st_fuel_charcoal_kg=cond(missing(fuel_charcoal_kg),3,cond(fuel_charcoal_kg<0,2,cond(fuel_charcoal_kg==0,1,0))) if source_year==2022
replace st_fuel_charcoal_kg=5 if source_year==2022 & missing(fuel_charcoal_kg) & !inlist(upper(strtrim(raw_ecakgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_charcoal_kg G0_source_state
generate double fuel_charcoal_rp000=.
generate byte st_fuel_charcoal_rp000=4
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu20),",","",.)) if source_year==2020
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2020
replace st_fuel_charcoal_rp000=5 if source_year==2020 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu21),",","",.)) if source_year==2021
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2021
replace st_fuel_charcoal_rp000=5 if source_year==2021 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_charcoal_rp000=real(subinstr(strtrim(raw_ecavcu22),",","",.)) if source_year==2022
replace st_fuel_charcoal_rp000=cond(missing(fuel_charcoal_rp000),3,cond(fuel_charcoal_rp000<0,2,cond(fuel_charcoal_rp000==0,1,0))) if source_year==2022
replace st_fuel_charcoal_rp000=5 if source_year==2022 & missing(fuel_charcoal_rp000) & !inlist(upper(strtrim(raw_ecavcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_charcoal_rp000 G0_source_state
generate double fuel_citygas_m3=.
generate byte st_fuel_citygas_m3=4
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u10),",","",.)) if source_year==2010
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2010
replace st_fuel_citygas_m3=5 if source_year==2010 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u10)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u11),",","",.)) if source_year==2011
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2011
replace st_fuel_citygas_m3=5 if source_year==2011 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u11)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u12),",","",.)) if source_year==2012
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2012
replace st_fuel_citygas_m3=5 if source_year==2012 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u12)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u13),",","",.)) if source_year==2013
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2013
replace st_fuel_citygas_m3=5 if source_year==2013 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u13)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u14),",","",.)) if source_year==2014
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2014
replace st_fuel_citygas_m3=5 if source_year==2014 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u14)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u),",","",.)) if source_year==2015
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2015
replace st_fuel_citygas_m3=5 if source_year==2015 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u17),",","",.)) if source_year==2017
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2017
replace st_fuel_citygas_m3=5 if source_year==2017 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u17)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u18),",","",.)) if source_year==2018
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2018
replace st_fuel_citygas_m3=5 if source_year==2018 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u18)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_m3=real(subinstr(strtrim(raw_egam3u19),",","",.)) if source_year==2019
replace st_fuel_citygas_m3=cond(missing(fuel_citygas_m3),3,cond(fuel_citygas_m3<0,2,cond(fuel_citygas_m3==0,1,0))) if source_year==2019
replace st_fuel_citygas_m3=5 if source_year==2019 & missing(fuel_citygas_m3) & !inlist(upper(strtrim(raw_egam3u19)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_citygas_m3 G0_source_state
generate double fuel_citygas_rp000=.
generate byte st_fuel_citygas_rp000=4
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu10),",","",.)) if source_year==2010
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2010
replace st_fuel_citygas_rp000=5 if source_year==2010 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu11),",","",.)) if source_year==2011
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2011
replace st_fuel_citygas_rp000=5 if source_year==2011 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu12),",","",.)) if source_year==2012
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2012
replace st_fuel_citygas_rp000=5 if source_year==2012 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu13),",","",.)) if source_year==2013
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2013
replace st_fuel_citygas_rp000=5 if source_year==2013 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu14),",","",.)) if source_year==2014
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2014
replace st_fuel_citygas_rp000=5 if source_year==2014 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu),",","",.)) if source_year==2015
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2015
replace st_fuel_citygas_rp000=5 if source_year==2015 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu17),",","",.)) if source_year==2017
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2017
replace st_fuel_citygas_rp000=5 if source_year==2017 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu18),",","",.)) if source_year==2018
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2018
replace st_fuel_citygas_rp000=5 if source_year==2018 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_citygas_rp000=real(subinstr(strtrim(raw_egavcu19),",","",.)) if source_year==2019
replace st_fuel_citygas_rp000=cond(missing(fuel_citygas_rp000),3,cond(fuel_citygas_rp000<0,2,cond(fuel_citygas_rp000==0,1,0))) if source_year==2019
replace st_fuel_citygas_rp000=5 if source_year==2019 & missing(fuel_citygas_rp000) & !inlist(upper(strtrim(raw_egavcu19)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_citygas_rp000 G0_source_state
generate double fuel_coal_kg=.
generate byte st_fuel_coal_kg=4
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu10),",","",.)) if source_year==2010
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2010
replace st_fuel_coal_kg=5 if source_year==2010 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu11),",","",.)) if source_year==2011
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2011
replace st_fuel_coal_kg=5 if source_year==2011 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu12),",","",.)) if source_year==2012
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2012
replace st_fuel_coal_kg=5 if source_year==2012 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu13),",","",.)) if source_year==2013
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2013
replace st_fuel_coal_kg=5 if source_year==2013 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu14),",","",.)) if source_year==2014
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2014
replace st_fuel_coal_kg=5 if source_year==2014 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu),",","",.)) if source_year==2015
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2015
replace st_fuel_coal_kg=5 if source_year==2015 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu17),",","",.)) if source_year==2017
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2017
replace st_fuel_coal_kg=5 if source_year==2017 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu18),",","",.)) if source_year==2018
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2018
replace st_fuel_coal_kg=5 if source_year==2018 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu19),",","",.)) if source_year==2019
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2019
replace st_fuel_coal_kg=5 if source_year==2019 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu20),",","",.)) if source_year==2020
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2020
replace st_fuel_coal_kg=5 if source_year==2020 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu21),",","",.)) if source_year==2021
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2021
replace st_fuel_coal_kg=5 if source_year==2021 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_kg=real(subinstr(strtrim(raw_eclkgu22),",","",.)) if source_year==2022
replace st_fuel_coal_kg=cond(missing(fuel_coal_kg),3,cond(fuel_coal_kg<0,2,cond(fuel_coal_kg==0,1,0))) if source_year==2022
replace st_fuel_coal_kg=5 if source_year==2022 & missing(fuel_coal_kg) & !inlist(upper(strtrim(raw_eclkgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coal_kg G0_source_state
generate double fuel_coal_rp000=.
generate byte st_fuel_coal_rp000=4
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu10),",","",.)) if source_year==2010
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2010
replace st_fuel_coal_rp000=5 if source_year==2010 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu11),",","",.)) if source_year==2011
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2011
replace st_fuel_coal_rp000=5 if source_year==2011 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu12),",","",.)) if source_year==2012
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2012
replace st_fuel_coal_rp000=5 if source_year==2012 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu13),",","",.)) if source_year==2013
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2013
replace st_fuel_coal_rp000=5 if source_year==2013 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu14),",","",.)) if source_year==2014
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2014
replace st_fuel_coal_rp000=5 if source_year==2014 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu),",","",.)) if source_year==2015
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2015
replace st_fuel_coal_rp000=5 if source_year==2015 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu17),",","",.)) if source_year==2017
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2017
replace st_fuel_coal_rp000=5 if source_year==2017 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu18),",","",.)) if source_year==2018
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2018
replace st_fuel_coal_rp000=5 if source_year==2018 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu19),",","",.)) if source_year==2019
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2019
replace st_fuel_coal_rp000=5 if source_year==2019 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu20),",","",.)) if source_year==2020
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2020
replace st_fuel_coal_rp000=5 if source_year==2020 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu21),",","",.)) if source_year==2021
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2021
replace st_fuel_coal_rp000=5 if source_year==2021 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_coal_rp000=real(subinstr(strtrim(raw_eclvcu22),",","",.)) if source_year==2022
replace st_fuel_coal_rp000=cond(missing(fuel_coal_rp000),3,cond(fuel_coal_rp000<0,2,cond(fuel_coal_rp000==0,1,0))) if source_year==2022
replace st_fuel_coal_rp000=5 if source_year==2022 & missing(fuel_coal_rp000) & !inlist(upper(strtrim(raw_eclvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coal_rp000 G0_source_state
generate double fuel_coalbriq_kg=.
generate byte st_fuel_coalbriq_kg=4
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu12),",","",.)) if source_year==2012
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2012
replace st_fuel_coalbriq_kg=5 if source_year==2012 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu13),",","",.)) if source_year==2013
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2013
replace st_fuel_coalbriq_kg=5 if source_year==2013 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu14),",","",.)) if source_year==2014
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2014
replace st_fuel_coalbriq_kg=5 if source_year==2014 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu17),",","",.)) if source_year==2017
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2017
replace st_fuel_coalbriq_kg=5 if source_year==2017 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu18),",","",.)) if source_year==2018
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2018
replace st_fuel_coalbriq_kg=5 if source_year==2018 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu19),",","",.)) if source_year==2019
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2019
replace st_fuel_coalbriq_kg=5 if source_year==2019 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu20),",","",.)) if source_year==2020
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2020
replace st_fuel_coalbriq_kg=5 if source_year==2020 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu21),",","",.)) if source_year==2021
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2021
replace st_fuel_coalbriq_kg=5 if source_year==2021 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_kg=real(subinstr(strtrim(raw_ecbkgu22),",","",.)) if source_year==2022
replace st_fuel_coalbriq_kg=cond(missing(fuel_coalbriq_kg),3,cond(fuel_coalbriq_kg<0,2,cond(fuel_coalbriq_kg==0,1,0))) if source_year==2022
replace st_fuel_coalbriq_kg=5 if source_year==2022 & missing(fuel_coalbriq_kg) & !inlist(upper(strtrim(raw_ecbkgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coalbriq_kg G0_source_state
generate double fuel_coalbriq_rp000=.
generate byte st_fuel_coalbriq_rp000=4
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu12),",","",.)) if source_year==2012
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2012
replace st_fuel_coalbriq_rp000=5 if source_year==2012 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu13),",","",.)) if source_year==2013
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2013
replace st_fuel_coalbriq_rp000=5 if source_year==2013 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu14),",","",.)) if source_year==2014
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2014
replace st_fuel_coalbriq_rp000=5 if source_year==2014 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu17),",","",.)) if source_year==2017
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2017
replace st_fuel_coalbriq_rp000=5 if source_year==2017 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu18),",","",.)) if source_year==2018
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2018
replace st_fuel_coalbriq_rp000=5 if source_year==2018 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu19),",","",.)) if source_year==2019
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2019
replace st_fuel_coalbriq_rp000=5 if source_year==2019 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu20),",","",.)) if source_year==2020
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2020
replace st_fuel_coalbriq_rp000=5 if source_year==2020 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu21),",","",.)) if source_year==2021
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2021
replace st_fuel_coalbriq_rp000=5 if source_year==2021 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_coalbriq_rp000=real(subinstr(strtrim(raw_ecbvcu22),",","",.)) if source_year==2022
replace st_fuel_coalbriq_rp000=cond(missing(fuel_coalbriq_rp000),3,cond(fuel_coalbriq_rp000<0,2,cond(fuel_coalbriq_rp000==0,1,0))) if source_year==2022
replace st_fuel_coalbriq_rp000=5 if source_year==2022 & missing(fuel_coalbriq_rp000) & !inlist(upper(strtrim(raw_ecbvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coalbriq_rp000 G0_source_state
generate double fuel_coke_kg=.
generate byte st_fuel_coke_kg=4
replace fuel_coke_kg=real(subinstr(strtrim(raw_eckkgu22),",","",.)) if source_year==2022
replace st_fuel_coke_kg=cond(missing(fuel_coke_kg),3,cond(fuel_coke_kg<0,2,cond(fuel_coke_kg==0,1,0))) if source_year==2022
replace st_fuel_coke_kg=5 if source_year==2022 & missing(fuel_coke_kg) & !inlist(upper(strtrim(raw_eckkgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coke_kg G0_source_state
generate double fuel_coke_rp000=.
generate byte st_fuel_coke_rp000=4
replace fuel_coke_rp000=real(subinstr(strtrim(raw_eckvcu22),",","",.)) if source_year==2022
replace st_fuel_coke_rp000=cond(missing(fuel_coke_rp000),3,cond(fuel_coke_rp000<0,2,cond(fuel_coke_rp000==0,1,0))) if source_year==2022
replace st_fuel_coke_rp000=5 if source_year==2022 & missing(fuel_coke_rp000) & !inlist(upper(strtrim(raw_eckvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_coke_rp000 G0_source_state
generate double fuel_diesel_ltr=.
generate byte st_fuel_diesel_ltr=4
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu10),",","",.)) if source_year==2010
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2010
replace st_fuel_diesel_ltr=5 if source_year==2010 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu11),",","",.)) if source_year==2011
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2011
replace st_fuel_diesel_ltr=5 if source_year==2011 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu12),",","",.)) if source_year==2012
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2012
replace st_fuel_diesel_ltr=5 if source_year==2012 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu13),",","",.)) if source_year==2013
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2013
replace st_fuel_diesel_ltr=5 if source_year==2013 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu14),",","",.)) if source_year==2014
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2014
replace st_fuel_diesel_ltr=5 if source_year==2014 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu),",","",.)) if source_year==2015
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2015
replace st_fuel_diesel_ltr=5 if source_year==2015 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu17),",","",.)) if source_year==2017
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2017
replace st_fuel_diesel_ltr=5 if source_year==2017 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu18),",","",.)) if source_year==2018
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2018
replace st_fuel_diesel_ltr=5 if source_year==2018 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu19),",","",.)) if source_year==2019
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2019
replace st_fuel_diesel_ltr=5 if source_year==2019 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu20),",","",.)) if source_year==2020
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2020
replace st_fuel_diesel_ltr=5 if source_year==2020 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu21),",","",.)) if source_year==2021
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2021
replace st_fuel_diesel_ltr=5 if source_year==2021 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_ltr=real(subinstr(strtrim(raw_esoliu22),",","",.)) if source_year==2022
replace st_fuel_diesel_ltr=cond(missing(fuel_diesel_ltr),3,cond(fuel_diesel_ltr<0,2,cond(fuel_diesel_ltr==0,1,0))) if source_year==2022
replace st_fuel_diesel_ltr=5 if source_year==2022 & missing(fuel_diesel_ltr) & !inlist(upper(strtrim(raw_esoliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_diesel_ltr G0_source_state
generate double fuel_diesel_rp000=.
generate byte st_fuel_diesel_rp000=4
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu10),",","",.)) if source_year==2010
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2010
replace st_fuel_diesel_rp000=5 if source_year==2010 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu11),",","",.)) if source_year==2011
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2011
replace st_fuel_diesel_rp000=5 if source_year==2011 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu12),",","",.)) if source_year==2012
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2012
replace st_fuel_diesel_rp000=5 if source_year==2012 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu13),",","",.)) if source_year==2013
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2013
replace st_fuel_diesel_rp000=5 if source_year==2013 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu14),",","",.)) if source_year==2014
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2014
replace st_fuel_diesel_rp000=5 if source_year==2014 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu),",","",.)) if source_year==2015
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2015
replace st_fuel_diesel_rp000=5 if source_year==2015 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu17),",","",.)) if source_year==2017
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2017
replace st_fuel_diesel_rp000=5 if source_year==2017 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu18),",","",.)) if source_year==2018
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2018
replace st_fuel_diesel_rp000=5 if source_year==2018 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu19),",","",.)) if source_year==2019
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2019
replace st_fuel_diesel_rp000=5 if source_year==2019 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu20),",","",.)) if source_year==2020
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2020
replace st_fuel_diesel_rp000=5 if source_year==2020 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu21),",","",.)) if source_year==2021
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2021
replace st_fuel_diesel_rp000=5 if source_year==2021 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_diesel_rp000=real(subinstr(strtrim(raw_esovcu22),",","",.)) if source_year==2022
replace st_fuel_diesel_rp000=cond(missing(fuel_diesel_rp000),3,cond(fuel_diesel_rp000<0,2,cond(fuel_diesel_rp000==0,1,0))) if source_year==2022
replace st_fuel_diesel_rp000=5 if source_year==2022 & missing(fuel_diesel_rp000) & !inlist(upper(strtrim(raw_esovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_diesel_rp000 G0_source_state
generate double fuel_dieseloil_ltr=.
generate byte st_fuel_dieseloil_ltr=4
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu20),",","",.)) if source_year==2020
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2020
replace st_fuel_dieseloil_ltr=5 if source_year==2020 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu21),",","",.)) if source_year==2021
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2021
replace st_fuel_dieseloil_ltr=5 if source_year==2021 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_dieseloil_ltr=real(subinstr(strtrim(raw_ediliu22),",","",.)) if source_year==2022
replace st_fuel_dieseloil_ltr=cond(missing(fuel_dieseloil_ltr),3,cond(fuel_dieseloil_ltr<0,2,cond(fuel_dieseloil_ltr==0,1,0))) if source_year==2022
replace st_fuel_dieseloil_ltr=5 if source_year==2022 & missing(fuel_dieseloil_ltr) & !inlist(upper(strtrim(raw_ediliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_dieseloil_ltr G0_source_state
generate double fuel_dieseloil_rp000=.
generate byte st_fuel_dieseloil_rp000=4
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu20),",","",.)) if source_year==2020
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2020
replace st_fuel_dieseloil_rp000=5 if source_year==2020 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu21),",","",.)) if source_year==2021
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2021
replace st_fuel_dieseloil_rp000=5 if source_year==2021 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_dieseloil_rp000=real(subinstr(strtrim(raw_edivcu22),",","",.)) if source_year==2022
replace st_fuel_dieseloil_rp000=cond(missing(fuel_dieseloil_rp000),3,cond(fuel_dieseloil_rp000<0,2,cond(fuel_dieseloil_rp000==0,1,0))) if source_year==2022
replace st_fuel_dieseloil_rp000=5 if source_year==2022 & missing(fuel_dieseloil_rp000) & !inlist(upper(strtrim(raw_edivcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_dieseloil_rp000 G0_source_state
generate double fuel_firewood_kg=.
generate byte st_fuel_firewood_kg=4
label values st_fuel_firewood_kg G0_source_state
generate double fuel_firewood_rp000=.
generate byte st_fuel_firewood_rp000=4
label values st_fuel_firewood_rp000 G0_source_state
generate double fuel_fueloil_ltr=.
generate byte st_fuel_fueloil_ltr=4
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu20),",","",.)) if source_year==2020
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2020
replace st_fuel_fueloil_ltr=5 if source_year==2020 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu21),",","",.)) if source_year==2021
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2021
replace st_fuel_fueloil_ltr=5 if source_year==2021 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_fueloil_ltr=real(subinstr(strtrim(raw_efoliu22),",","",.)) if source_year==2022
replace st_fuel_fueloil_ltr=cond(missing(fuel_fueloil_ltr),3,cond(fuel_fueloil_ltr<0,2,cond(fuel_fueloil_ltr==0,1,0))) if source_year==2022
replace st_fuel_fueloil_ltr=5 if source_year==2022 & missing(fuel_fueloil_ltr) & !inlist(upper(strtrim(raw_efoliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_fueloil_ltr G0_source_state
generate double fuel_fueloil_rp000=.
generate byte st_fuel_fueloil_rp000=4
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu20),",","",.)) if source_year==2020
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2020
replace st_fuel_fueloil_rp000=5 if source_year==2020 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu21),",","",.)) if source_year==2021
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2021
replace st_fuel_fueloil_rp000=5 if source_year==2021 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_fueloil_rp000=real(subinstr(strtrim(raw_efovcu22),",","",.)) if source_year==2022
replace st_fuel_fueloil_rp000=cond(missing(fuel_fueloil_rp000),3,cond(fuel_fueloil_rp000<0,2,cond(fuel_fueloil_rp000==0,1,0))) if source_year==2022
replace st_fuel_fueloil_rp000=5 if source_year==2022 & missing(fuel_fueloil_rp000) & !inlist(upper(strtrim(raw_efovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_fueloil_rp000 G0_source_state
generate double fuel_kerosene_ltr=.
generate byte st_fuel_kerosene_ltr=4
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu10),",","",.)) if source_year==2010
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2010
replace st_fuel_kerosene_ltr=5 if source_year==2010 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu11),",","",.)) if source_year==2011
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2011
replace st_fuel_kerosene_ltr=5 if source_year==2011 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu12),",","",.)) if source_year==2012
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2012
replace st_fuel_kerosene_ltr=5 if source_year==2012 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu13),",","",.)) if source_year==2013
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2013
replace st_fuel_kerosene_ltr=5 if source_year==2013 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu14),",","",.)) if source_year==2014
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2014
replace st_fuel_kerosene_ltr=5 if source_year==2014 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_ltr=real(subinstr(strtrim(raw_eoiliu),",","",.)) if source_year==2015
replace st_fuel_kerosene_ltr=cond(missing(fuel_kerosene_ltr),3,cond(fuel_kerosene_ltr<0,2,cond(fuel_kerosene_ltr==0,1,0))) if source_year==2015
replace st_fuel_kerosene_ltr=5 if source_year==2015 & missing(fuel_kerosene_ltr) & !inlist(upper(strtrim(raw_eoiliu)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_kerosene_ltr G0_source_state
generate double fuel_kerosene_rp000=.
generate byte st_fuel_kerosene_rp000=4
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu10),",","",.)) if source_year==2010
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2010
replace st_fuel_kerosene_rp000=5 if source_year==2010 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu11),",","",.)) if source_year==2011
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2011
replace st_fuel_kerosene_rp000=5 if source_year==2011 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu12),",","",.)) if source_year==2012
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2012
replace st_fuel_kerosene_rp000=5 if source_year==2012 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu13),",","",.)) if source_year==2013
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2013
replace st_fuel_kerosene_rp000=5 if source_year==2013 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu14),",","",.)) if source_year==2014
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2014
replace st_fuel_kerosene_rp000=5 if source_year==2014 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_kerosene_rp000=real(subinstr(strtrim(raw_eoivcu),",","",.)) if source_year==2015
replace st_fuel_kerosene_rp000=cond(missing(fuel_kerosene_rp000),3,cond(fuel_kerosene_rp000<0,2,cond(fuel_kerosene_rp000==0,1,0))) if source_year==2015
replace st_fuel_kerosene_rp000=5 if source_year==2015 & missing(fuel_kerosene_rp000) & !inlist(upper(strtrim(raw_eoivcu)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_kerosene_rp000 G0_source_state
generate double fuel_lpg_kg=.
generate byte st_fuel_lpg_kg=4
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu10),",","",.)) if source_year==2010
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2010
replace st_fuel_lpg_kg=5 if source_year==2010 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu11),",","",.)) if source_year==2011
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2011
replace st_fuel_lpg_kg=5 if source_year==2011 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu12),",","",.)) if source_year==2012
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2012
replace st_fuel_lpg_kg=5 if source_year==2012 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu13),",","",.)) if source_year==2013
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2013
replace st_fuel_lpg_kg=5 if source_year==2013 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu14),",","",.)) if source_year==2014
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2014
replace st_fuel_lpg_kg=5 if source_year==2014 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu),",","",.)) if source_year==2015
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2015
replace st_fuel_lpg_kg=5 if source_year==2015 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu17),",","",.)) if source_year==2017
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2017
replace st_fuel_lpg_kg=5 if source_year==2017 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu18),",","",.)) if source_year==2018
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2018
replace st_fuel_lpg_kg=5 if source_year==2018 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu19),",","",.)) if source_year==2019
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2019
replace st_fuel_lpg_kg=5 if source_year==2019 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu20),",","",.)) if source_year==2020
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2020
replace st_fuel_lpg_kg=5 if source_year==2020 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu21),",","",.)) if source_year==2021
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2021
replace st_fuel_lpg_kg=5 if source_year==2021 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_kg=real(subinstr(strtrim(raw_elpkgu22),",","",.)) if source_year==2022
replace st_fuel_lpg_kg=cond(missing(fuel_lpg_kg),3,cond(fuel_lpg_kg<0,2,cond(fuel_lpg_kg==0,1,0))) if source_year==2022
replace st_fuel_lpg_kg=5 if source_year==2022 & missing(fuel_lpg_kg) & !inlist(upper(strtrim(raw_elpkgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_lpg_kg G0_source_state
generate double fuel_lpg_rp000=.
generate byte st_fuel_lpg_rp000=4
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu10),",","",.)) if source_year==2010
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2010
replace st_fuel_lpg_rp000=5 if source_year==2010 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu11),",","",.)) if source_year==2011
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2011
replace st_fuel_lpg_rp000=5 if source_year==2011 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu12),",","",.)) if source_year==2012
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2012
replace st_fuel_lpg_rp000=5 if source_year==2012 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu13),",","",.)) if source_year==2013
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2013
replace st_fuel_lpg_rp000=5 if source_year==2013 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu14),",","",.)) if source_year==2014
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2014
replace st_fuel_lpg_rp000=5 if source_year==2014 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu),",","",.)) if source_year==2015
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2015
replace st_fuel_lpg_rp000=5 if source_year==2015 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu17),",","",.)) if source_year==2017
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2017
replace st_fuel_lpg_rp000=5 if source_year==2017 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu18),",","",.)) if source_year==2018
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2018
replace st_fuel_lpg_rp000=5 if source_year==2018 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu19),",","",.)) if source_year==2019
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2019
replace st_fuel_lpg_rp000=5 if source_year==2019 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu20),",","",.)) if source_year==2020
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2020
replace st_fuel_lpg_rp000=5 if source_year==2020 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu21),",","",.)) if source_year==2021
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2021
replace st_fuel_lpg_rp000=5 if source_year==2021 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_lpg_rp000=real(subinstr(strtrim(raw_elpvcu22),",","",.)) if source_year==2022
replace st_fuel_lpg_rp000=cond(missing(fuel_lpg_rp000),3,cond(fuel_lpg_rp000<0,2,cond(fuel_lpg_rp000==0,1,0))) if source_year==2022
replace st_fuel_lpg_rp000=5 if source_year==2022 & missing(fuel_lpg_rp000) & !inlist(upper(strtrim(raw_elpvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_lpg_rp000 G0_source_state
generate double fuel_lubricant_ltr=.
generate byte st_fuel_lubricant_ltr=4
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu10),",","",.)) if source_year==2010
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2010
replace st_fuel_lubricant_ltr=5 if source_year==2010 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu11),",","",.)) if source_year==2011
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2011
replace st_fuel_lubricant_ltr=5 if source_year==2011 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu12),",","",.)) if source_year==2012
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2012
replace st_fuel_lubricant_ltr=5 if source_year==2012 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu13),",","",.)) if source_year==2013
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2013
replace st_fuel_lubricant_ltr=5 if source_year==2013 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu14),",","",.)) if source_year==2014
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2014
replace st_fuel_lubricant_ltr=5 if source_year==2014 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu),",","",.)) if source_year==2015
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2015
replace st_fuel_lubricant_ltr=5 if source_year==2015 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu17),",","",.)) if source_year==2017
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2017
replace st_fuel_lubricant_ltr=5 if source_year==2017 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu18),",","",.)) if source_year==2018
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2018
replace st_fuel_lubricant_ltr=5 if source_year==2018 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu19),",","",.)) if source_year==2019
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2019
replace st_fuel_lubricant_ltr=5 if source_year==2019 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu20),",","",.)) if source_year==2020
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2020
replace st_fuel_lubricant_ltr=5 if source_year==2020 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu21),",","",.)) if source_year==2021
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2021
replace st_fuel_lubricant_ltr=5 if source_year==2021 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_ltr=real(subinstr(strtrim(raw_eluliu22),",","",.)) if source_year==2022
replace st_fuel_lubricant_ltr=cond(missing(fuel_lubricant_ltr),3,cond(fuel_lubricant_ltr<0,2,cond(fuel_lubricant_ltr==0,1,0))) if source_year==2022
replace st_fuel_lubricant_ltr=5 if source_year==2022 & missing(fuel_lubricant_ltr) & !inlist(upper(strtrim(raw_eluliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_lubricant_ltr G0_source_state
generate double fuel_lubricant_rp000=.
generate byte st_fuel_lubricant_rp000=4
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu10),",","",.)) if source_year==2010
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2010
replace st_fuel_lubricant_rp000=5 if source_year==2010 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu11),",","",.)) if source_year==2011
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2011
replace st_fuel_lubricant_rp000=5 if source_year==2011 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu12),",","",.)) if source_year==2012
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2012
replace st_fuel_lubricant_rp000=5 if source_year==2012 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu13),",","",.)) if source_year==2013
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2013
replace st_fuel_lubricant_rp000=5 if source_year==2013 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu14),",","",.)) if source_year==2014
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2014
replace st_fuel_lubricant_rp000=5 if source_year==2014 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu),",","",.)) if source_year==2015
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2015
replace st_fuel_lubricant_rp000=5 if source_year==2015 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu17),",","",.)) if source_year==2017
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2017
replace st_fuel_lubricant_rp000=5 if source_year==2017 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu18),",","",.)) if source_year==2018
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2018
replace st_fuel_lubricant_rp000=5 if source_year==2018 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu19),",","",.)) if source_year==2019
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2019
replace st_fuel_lubricant_rp000=5 if source_year==2019 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu20),",","",.)) if source_year==2020
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2020
replace st_fuel_lubricant_rp000=5 if source_year==2020 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu21),",","",.)) if source_year==2021
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2021
replace st_fuel_lubricant_rp000=5 if source_year==2021 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_lubricant_rp000=real(subinstr(strtrim(raw_eluvcu22),",","",.)) if source_year==2022
replace st_fuel_lubricant_rp000=cond(missing(fuel_lubricant_rp000),3,cond(fuel_lubricant_rp000<0,2,cond(fuel_lubricant_rp000==0,1,0))) if source_year==2022
replace st_fuel_lubricant_rp000=5 if source_year==2022 & missing(fuel_lubricant_rp000) & !inlist(upper(strtrim(raw_eluvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_lubricant_rp000 G0_source_state
generate double fuel_natgas_kg=.
generate byte st_fuel_natgas_kg=4
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu20),",","",.)) if source_year==2020
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2020
replace st_fuel_natgas_kg=5 if source_year==2020 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu21),",","",.)) if source_year==2021
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2021
replace st_fuel_natgas_kg=5 if source_year==2021 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_natgas_kg=real(subinstr(strtrim(raw_engkgu22),",","",.)) if source_year==2022
replace st_fuel_natgas_kg=cond(missing(fuel_natgas_kg),3,cond(fuel_natgas_kg<0,2,cond(fuel_natgas_kg==0,1,0))) if source_year==2022
replace st_fuel_natgas_kg=5 if source_year==2022 & missing(fuel_natgas_kg) & !inlist(upper(strtrim(raw_engkgu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_natgas_kg G0_source_state
generate double fuel_natgas_rp000=.
generate byte st_fuel_natgas_rp000=4
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu20),",","",.)) if source_year==2020
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2020
replace st_fuel_natgas_rp000=5 if source_year==2020 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu21),",","",.)) if source_year==2021
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2021
replace st_fuel_natgas_rp000=5 if source_year==2021 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_natgas_rp000=real(subinstr(strtrim(raw_engvcu22),",","",.)) if source_year==2022
replace st_fuel_natgas_rp000=cond(missing(fuel_natgas_rp000),3,cond(fuel_natgas_rp000<0,2,cond(fuel_natgas_rp000==0,1,0))) if source_year==2022
replace st_fuel_natgas_rp000=5 if source_year==2022 & missing(fuel_natgas_rp000) & !inlist(upper(strtrim(raw_engvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_natgas_rp000 G0_source_state
generate double fuel_other_rp000=.
generate byte st_fuel_other_rp000=4
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu10),",","",.)) if source_year==2010
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2010
replace st_fuel_other_rp000=5 if source_year==2010 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu11),",","",.)) if source_year==2011
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2011
replace st_fuel_other_rp000=5 if source_year==2011 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu12),",","",.)) if source_year==2012
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2012
replace st_fuel_other_rp000=5 if source_year==2012 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu13),",","",.)) if source_year==2013
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2013
replace st_fuel_other_rp000=5 if source_year==2013 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu14),",","",.)) if source_year==2014
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2014
replace st_fuel_other_rp000=5 if source_year==2014 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu),",","",.)) if source_year==2015
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2015
replace st_fuel_other_rp000=5 if source_year==2015 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu17),",","",.)) if source_year==2017
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2017
replace st_fuel_other_rp000=5 if source_year==2017 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu18),",","",.)) if source_year==2018
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2018
replace st_fuel_other_rp000=5 if source_year==2018 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu19),",","",.)) if source_year==2019
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2019
replace st_fuel_other_rp000=5 if source_year==2019 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu20),",","",.)) if source_year==2020
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2020
replace st_fuel_other_rp000=5 if source_year==2020 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu21),",","",.)) if source_year==2021
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2021
replace st_fuel_other_rp000=5 if source_year==2021 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_other_rp000=real(subinstr(strtrim(raw_encvcu22),",","",.)) if source_year==2022
replace st_fuel_other_rp000=cond(missing(fuel_other_rp000),3,cond(fuel_other_rp000<0,2,cond(fuel_other_rp000==0,1,0))) if source_year==2022
replace st_fuel_other_rp000=5 if source_year==2022 & missing(fuel_other_rp000) & !inlist(upper(strtrim(raw_encvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_other_rp000 G0_source_state
generate double fuel_othergas_m3=.
generate byte st_fuel_othergas_m3=4
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u12),",","",.)) if source_year==2012
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2012
replace st_fuel_othergas_m3=5 if source_year==2012 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u12)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u13),",","",.)) if source_year==2013
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2013
replace st_fuel_othergas_m3=5 if source_year==2013 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u13)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u14),",","",.)) if source_year==2014
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2014
replace st_fuel_othergas_m3=5 if source_year==2014 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u14)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u17),",","",.)) if source_year==2017
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2017
replace st_fuel_othergas_m3=5 if source_year==2017 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u17)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u18),",","",.)) if source_year==2018
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2018
replace st_fuel_othergas_m3=5 if source_year==2018 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u18)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_m3=real(subinstr(strtrim(raw_egom3u19),",","",.)) if source_year==2019
replace st_fuel_othergas_m3=cond(missing(fuel_othergas_m3),3,cond(fuel_othergas_m3<0,2,cond(fuel_othergas_m3==0,1,0))) if source_year==2019
replace st_fuel_othergas_m3=5 if source_year==2019 & missing(fuel_othergas_m3) & !inlist(upper(strtrim(raw_egom3u19)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_othergas_m3 G0_source_state
generate double fuel_othergas_rp000=.
generate byte st_fuel_othergas_rp000=4
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu12),",","",.)) if source_year==2012
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2012
replace st_fuel_othergas_rp000=5 if source_year==2012 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu13),",","",.)) if source_year==2013
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2013
replace st_fuel_othergas_rp000=5 if source_year==2013 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu14),",","",.)) if source_year==2014
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2014
replace st_fuel_othergas_rp000=5 if source_year==2014 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu17),",","",.)) if source_year==2017
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2017
replace st_fuel_othergas_rp000=5 if source_year==2017 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu18),",","",.)) if source_year==2018
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2018
replace st_fuel_othergas_rp000=5 if source_year==2018 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_othergas_rp000=real(subinstr(strtrim(raw_egovcu19),",","",.)) if source_year==2019
replace st_fuel_othergas_rp000=cond(missing(fuel_othergas_rp000),3,cond(fuel_othergas_rp000<0,2,cond(fuel_othergas_rp000==0,1,0))) if source_year==2019
replace st_fuel_othergas_rp000=5 if source_year==2019 & missing(fuel_othergas_rp000) & !inlist(upper(strtrim(raw_egovcu19)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_othergas_rp000 G0_source_state
generate double fuel_petrol_ltr=.
generate byte st_fuel_petrol_ltr=4
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu10),",","",.)) if source_year==2010
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2010
replace st_fuel_petrol_ltr=5 if source_year==2010 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu11),",","",.)) if source_year==2011
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2011
replace st_fuel_petrol_ltr=5 if source_year==2011 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu12),",","",.)) if source_year==2012
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2012
replace st_fuel_petrol_ltr=5 if source_year==2012 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu13),",","",.)) if source_year==2013
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2013
replace st_fuel_petrol_ltr=5 if source_year==2013 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu14),",","",.)) if source_year==2014
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2014
replace st_fuel_petrol_ltr=5 if source_year==2014 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu),",","",.)) if source_year==2015
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2015
replace st_fuel_petrol_ltr=5 if source_year==2015 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu17),",","",.)) if source_year==2017
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2017
replace st_fuel_petrol_ltr=5 if source_year==2017 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu18),",","",.)) if source_year==2018
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2018
replace st_fuel_petrol_ltr=5 if source_year==2018 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu19),",","",.)) if source_year==2019
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2019
replace st_fuel_petrol_ltr=5 if source_year==2019 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu20),",","",.)) if source_year==2020
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2020
replace st_fuel_petrol_ltr=5 if source_year==2020 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu21),",","",.)) if source_year==2021
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2021
replace st_fuel_petrol_ltr=5 if source_year==2021 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_ltr=real(subinstr(strtrim(raw_epeliu22),",","",.)) if source_year==2022
replace st_fuel_petrol_ltr=cond(missing(fuel_petrol_ltr),3,cond(fuel_petrol_ltr<0,2,cond(fuel_petrol_ltr==0,1,0))) if source_year==2022
replace st_fuel_petrol_ltr=5 if source_year==2022 & missing(fuel_petrol_ltr) & !inlist(upper(strtrim(raw_epeliu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_petrol_ltr G0_source_state
generate double fuel_petrol_rp000=.
generate byte st_fuel_petrol_rp000=4
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu10),",","",.)) if source_year==2010
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2010
replace st_fuel_petrol_rp000=5 if source_year==2010 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu11),",","",.)) if source_year==2011
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2011
replace st_fuel_petrol_rp000=5 if source_year==2011 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu12),",","",.)) if source_year==2012
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2012
replace st_fuel_petrol_rp000=5 if source_year==2012 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu13),",","",.)) if source_year==2013
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2013
replace st_fuel_petrol_rp000=5 if source_year==2013 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu14),",","",.)) if source_year==2014
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2014
replace st_fuel_petrol_rp000=5 if source_year==2014 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu),",","",.)) if source_year==2015
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2015
replace st_fuel_petrol_rp000=5 if source_year==2015 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu17),",","",.)) if source_year==2017
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2017
replace st_fuel_petrol_rp000=5 if source_year==2017 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu18),",","",.)) if source_year==2018
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2018
replace st_fuel_petrol_rp000=5 if source_year==2018 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu19),",","",.)) if source_year==2019
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2019
replace st_fuel_petrol_rp000=5 if source_year==2019 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu20),",","",.)) if source_year==2020
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2020
replace st_fuel_petrol_rp000=5 if source_year==2020 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu21),",","",.)) if source_year==2021
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2021
replace st_fuel_petrol_rp000=5 if source_year==2021 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_petrol_rp000=real(subinstr(strtrim(raw_epevcu22),",","",.)) if source_year==2022
replace st_fuel_petrol_rp000=cond(missing(fuel_petrol_rp000),3,cond(fuel_petrol_rp000<0,2,cond(fuel_petrol_rp000==0,1,0))) if source_year==2022
replace st_fuel_petrol_rp000=5 if source_year==2022 & missing(fuel_petrol_rp000) & !inlist(upper(strtrim(raw_epevcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_petrol_rp000 G0_source_state
generate double fuel_total_reported_rp000=.
generate byte st_fuel_total_reported_rp000=4
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu10),",","",.)) if source_year==2010
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2010
replace st_fuel_total_reported_rp000=5 if source_year==2010 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu10)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu11),",","",.)) if source_year==2011
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2011
replace st_fuel_total_reported_rp000=5 if source_year==2011 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu11)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu12),",","",.)) if source_year==2012
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2012
replace st_fuel_total_reported_rp000=5 if source_year==2012 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu12)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu13),",","",.)) if source_year==2013
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2013
replace st_fuel_total_reported_rp000=5 if source_year==2013 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu13)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu14),",","",.)) if source_year==2014
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2014
replace st_fuel_total_reported_rp000=5 if source_year==2014 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu14)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu),",","",.)) if source_year==2015
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2015
replace st_fuel_total_reported_rp000=5 if source_year==2015 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu17),",","",.)) if source_year==2017
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2017
replace st_fuel_total_reported_rp000=5 if source_year==2017 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu17)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu18),",","",.)) if source_year==2018
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2018
replace st_fuel_total_reported_rp000=5 if source_year==2018 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu18)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu19),",","",.)) if source_year==2019
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2019
replace st_fuel_total_reported_rp000=5 if source_year==2019 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu19)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu20),",","",.)) if source_year==2020
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2020
replace st_fuel_total_reported_rp000=5 if source_year==2020 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu20)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu21),",","",.)) if source_year==2021
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2021
replace st_fuel_total_reported_rp000=5 if source_year==2021 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu21)),"","***",".","NA","N/A","NULL","-")
replace fuel_total_reported_rp000=real(subinstr(strtrim(raw_efuvcu22),",","",.)) if source_year==2022
replace st_fuel_total_reported_rp000=cond(missing(fuel_total_reported_rp000),3,cond(fuel_total_reported_rp000<0,2,cond(fuel_total_reported_rp000==0,1,0))) if source_year==2022
replace st_fuel_total_reported_rp000=5 if source_year==2022 & missing(fuel_total_reported_rp000) & !inlist(upper(strtrim(raw_efuvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_fuel_total_reported_rp000 G0_source_state
keep source_year source_row elec_nonpln_kwh elec_nonpln_rp000 elec_owngen_kwh elec_pln_kwh elec_pln_rp000 fuel_biodiesel_ltr fuel_biodiesel_rp000 fuel_charcoal_kg fuel_charcoal_rp000 fuel_citygas_m3 fuel_citygas_rp000 fuel_coal_kg fuel_coal_rp000 fuel_coalbriq_kg fuel_coalbriq_rp000 fuel_coke_kg fuel_coke_rp000 fuel_diesel_ltr fuel_diesel_rp000 fuel_dieseloil_ltr fuel_dieseloil_rp000 fuel_firewood_kg fuel_firewood_rp000 fuel_fueloil_ltr fuel_fueloil_rp000 fuel_kerosene_ltr fuel_kerosene_rp000 fuel_lpg_kg fuel_lpg_rp000 fuel_lubricant_ltr fuel_lubricant_rp000 fuel_natgas_kg fuel_natgas_rp000 fuel_other_rp000 fuel_othergas_m3 fuel_othergas_rp000 fuel_petrol_ltr fuel_petrol_rp000 fuel_total_reported_rp000 st_*
isid source_year source_row
save "$G0D/G0_energy_fields.dta", replace
generate byte legacy_unit_contract=source_year<=2014
generate str64 unit_status=cond(legacy_unit_contract,"legacy_2010_2014_mapping","post2014_unit_mapping_requires_validation")
generate double grid_factor_s1=cond(source_year==2010,.000599,cond(source_year==2011,.000690,cond(source_year==2012,.000782,cond(source_year==2013,.000873,.000914))))
generate double grid_factor_s2=.000867
generate str48 factor_status=cond(source_year<=2014,"LUDI_annual_factor","assumption_carry_2014_factor")
generate str64 factor_contract="LUDI_E010_E011_E012_E016; static_PLN_sensitivity"
save "$G0D/G0_energy_fields.dta", replace
