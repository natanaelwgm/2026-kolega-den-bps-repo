* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.
use "$G0D/G0_raw_fields_preserved.dta", clear
label define G0_source_state 0 "positive" 1 "zero" 2 "negative" 3 "observation_missing" 4 "source_absent" 5 "parse_failure", replace
generate double amdal_raw=.
generate byte st_amdal_raw=4
replace amdal_raw=real(subinstr(strtrim(raw_amdal20),",","",.)) if source_year==2020
replace st_amdal_raw=cond(missing(amdal_raw),3,cond(amdal_raw<0,2,cond(amdal_raw==0,1,0))) if source_year==2020
replace st_amdal_raw=5 if source_year==2020 & missing(amdal_raw) & !inlist(upper(strtrim(raw_amdal20)),"","***",".","NA","N/A","NULL","-")
replace amdal_raw=real(subinstr(strtrim(raw_amdal21),",","",.)) if source_year==2021
replace st_amdal_raw=cond(missing(amdal_raw),3,cond(amdal_raw<0,2,cond(amdal_raw==0,1,0))) if source_year==2021
replace st_amdal_raw=5 if source_year==2021 & missing(amdal_raw) & !inlist(upper(strtrim(raw_amdal21)),"","***",".","NA","N/A","NULL","-")
replace amdal_raw=real(subinstr(strtrim(raw_amdal22),",","",.)) if source_year==2022
replace st_amdal_raw=cond(missing(amdal_raw),3,cond(amdal_raw<0,2,cond(amdal_raw==0,1,0))) if source_year==2022
replace st_amdal_raw=5 if source_year==2022 & missing(amdal_raw) & !inlist(upper(strtrim(raw_amdal22)),"","***",".","NA","N/A","NULL","-")
label values st_amdal_raw G0_source_state
generate double b3wste_raw=.
generate byte st_b3wste_raw=4
replace b3wste_raw=real(subinstr(strtrim(raw_b3wste22),",","",.)) if source_year==2022
replace st_b3wste_raw=cond(missing(b3wste_raw),3,cond(b3wste_raw<0,2,cond(b3wste_raw==0,1,0))) if source_year==2022
replace st_b3wste_raw=5 if source_year==2022 & missing(b3wste_raw) & !inlist(upper(strtrim(raw_b3wste22)),"","***",".","NA","N/A","NULL","-")
label values st_b3wste_raw G0_source_state
generate double capital_additions_nominal=.
generate byte st_capital_additions_nominal=4
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu10),",","",.)) if source_year==2010
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2010
replace st_capital_additions_nominal=5 if source_year==2010 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu10)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu11),",","",.)) if source_year==2011
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2011
replace st_capital_additions_nominal=5 if source_year==2011 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu11)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu12),",","",.)) if source_year==2012
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2012
replace st_capital_additions_nominal=5 if source_year==2012 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu12)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu13),",","",.)) if source_year==2013
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2013
replace st_capital_additions_nominal=5 if source_year==2013 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu13)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu14),",","",.)) if source_year==2014
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2014
replace st_capital_additions_nominal=5 if source_year==2014 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu14)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu17),",","",.)) if source_year==2017
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2017
replace st_capital_additions_nominal=5 if source_year==2017 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu17)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu18),",","",.)) if source_year==2018
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2018
replace st_capital_additions_nominal=5 if source_year==2018 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu18)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu19),",","",.)) if source_year==2019
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2019
replace st_capital_additions_nominal=5 if source_year==2019 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu19)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu20),",","",.)) if source_year==2020
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2020
replace st_capital_additions_nominal=5 if source_year==2020 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu20)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu21),",","",.)) if source_year==2021
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2021
replace st_capital_additions_nominal=5 if source_year==2021 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu21)),"","***",".","NA","N/A","NULL","-")
replace capital_additions_nominal=real(subinstr(strtrim(raw_ctttcu22),",","",.)) if source_year==2022
replace st_capital_additions_nominal=cond(missing(capital_additions_nominal),3,cond(capital_additions_nominal<0,2,cond(capital_additions_nominal==0,1,0))) if source_year==2022
replace st_capital_additions_nominal=5 if source_year==2022 & missing(capital_additions_nominal) & !inlist(upper(strtrim(raw_ctttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_capital_additions_nominal G0_source_state
generate double capital_nominal=.
generate byte st_capital_nominal=4
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu10),",","",.)) if source_year==2010
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2010
replace st_capital_nominal=5 if source_year==2010 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu10)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu11),",","",.)) if source_year==2011
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2011
replace st_capital_nominal=5 if source_year==2011 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu11)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu12),",","",.)) if source_year==2012
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2012
replace st_capital_nominal=5 if source_year==2012 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu12)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu13),",","",.)) if source_year==2013
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2013
replace st_capital_nominal=5 if source_year==2013 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu13)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu14),",","",.)) if source_year==2014
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2014
replace st_capital_nominal=5 if source_year==2014 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu14)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2015
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2015
replace st_capital_nominal=5 if source_year==2015 & missing(capital_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu17),",","",.)) if source_year==2017
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2017
replace st_capital_nominal=5 if source_year==2017 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu17)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu18),",","",.)) if source_year==2018
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2018
replace st_capital_nominal=5 if source_year==2018 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu18)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu19),",","",.)) if source_year==2019
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2019
replace st_capital_nominal=5 if source_year==2019 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu19)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu20),",","",.)) if source_year==2020
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2020
replace st_capital_nominal=5 if source_year==2020 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu20)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu21),",","",.)) if source_year==2021
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2021
replace st_capital_nominal=5 if source_year==2021 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu21)),"","***",".","NA","N/A","NULL","-")
replace capital_nominal=real(subinstr(strtrim(raw_ctttcu22),",","",.)) if source_year==2022
replace st_capital_nominal=cond(missing(capital_nominal),3,cond(capital_nominal<0,2,cond(capital_nominal==0,1,0))) if source_year==2022
replace st_capital_nominal=5 if source_year==2022 & missing(capital_nominal) & !inlist(upper(strtrim(raw_ctttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_capital_nominal G0_source_state
generate double capital_stock_nominal=.
generate byte st_capital_stock_nominal=4
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2010
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2010
replace st_capital_stock_nominal=5 if source_year==2010 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2011
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2011
replace st_capital_stock_nominal=5 if source_year==2011 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2012
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2012
replace st_capital_stock_nominal=5 if source_year==2012 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2013
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2013
replace st_capital_stock_nominal=5 if source_year==2013 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2014
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2014
replace st_capital_stock_nominal=5 if source_year==2014 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2015
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2015
replace st_capital_stock_nominal=5 if source_year==2015 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2017
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2017
replace st_capital_stock_nominal=5 if source_year==2017 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2018
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2018
replace st_capital_stock_nominal=5 if source_year==2018 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2019
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2019
replace st_capital_stock_nominal=5 if source_year==2019 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2020
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2020
replace st_capital_stock_nominal=5 if source_year==2020 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2021
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2021
replace st_capital_stock_nominal=5 if source_year==2021 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
replace capital_stock_nominal=real(subinstr(strtrim(raw_v1115),",","",.)) if source_year==2022
replace st_capital_stock_nominal=cond(missing(capital_stock_nominal),3,cond(capital_stock_nominal<0,2,cond(capital_stock_nominal==0,1,0))) if source_year==2022
replace st_capital_stock_nominal=5 if source_year==2022 & missing(capital_stock_nominal) & !inlist(upper(strtrim(raw_v1115)),"","***",".","NA","N/A","NULL","-")
label values st_capital_stock_nominal G0_source_state
generate double export_binary_raw=.
generate byte st_export_binary_raw=4
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor10),",","",.)) if source_year==2010
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2010
replace st_export_binary_raw=5 if source_year==2010 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor10)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor11),",","",.)) if source_year==2011
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2011
replace st_export_binary_raw=5 if source_year==2011 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor11)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor12),",","",.)) if source_year==2012
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2012
replace st_export_binary_raw=5 if source_year==2012 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor12)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor13),",","",.)) if source_year==2013
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2013
replace st_export_binary_raw=5 if source_year==2013 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor13)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor14),",","",.)) if source_year==2014
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2014
replace st_export_binary_raw=5 if source_year==2014 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor14)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor),",","",.)) if source_year==2015
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2015
replace st_export_binary_raw=5 if source_year==2015 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor17),",","",.)) if source_year==2017
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2017
replace st_export_binary_raw=5 if source_year==2017 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor17)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor18),",","",.)) if source_year==2018
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2018
replace st_export_binary_raw=5 if source_year==2018 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor18)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor19),",","",.)) if source_year==2019
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2019
replace st_export_binary_raw=5 if source_year==2019 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor19)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor20),",","",.)) if source_year==2020
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2020
replace st_export_binary_raw=5 if source_year==2020 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor20)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor21),",","",.)) if source_year==2021
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2021
replace st_export_binary_raw=5 if source_year==2021 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor21)),"","***",".","NA","N/A","NULL","-")
replace export_binary_raw=real(subinstr(strtrim(raw_ekspor22),",","",.)) if source_year==2022
replace st_export_binary_raw=cond(missing(export_binary_raw),3,cond(export_binary_raw<0,2,cond(export_binary_raw==0,1,0))) if source_year==2022
replace st_export_binary_raw=5 if source_year==2022 & missing(export_binary_raw) & !inlist(upper(strtrim(raw_ekspor22)),"","***",".","NA","N/A","NULL","-")
label values st_export_binary_raw G0_source_state
generate double export_share_pct=.
generate byte st_export_share_pct=4
replace export_share_pct=real(subinstr(strtrim(raw_prprex10),",","",.)) if source_year==2010
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2010
replace st_export_share_pct=5 if source_year==2010 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex10)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex11),",","",.)) if source_year==2011
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2011
replace st_export_share_pct=5 if source_year==2011 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex11)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex12),",","",.)) if source_year==2012
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2012
replace st_export_share_pct=5 if source_year==2012 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex12)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex13),",","",.)) if source_year==2013
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2013
replace st_export_share_pct=5 if source_year==2013 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex13)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex14),",","",.)) if source_year==2014
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2014
replace st_export_share_pct=5 if source_year==2014 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex14)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex18),",","",.)) if source_year==2018
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2018
replace st_export_share_pct=5 if source_year==2018 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex18)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex19),",","",.)) if source_year==2019
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2019
replace st_export_share_pct=5 if source_year==2019 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex19)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex20),",","",.)) if source_year==2020
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2020
replace st_export_share_pct=5 if source_year==2020 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex20)),"","***",".","NA","N/A","NULL","-")
replace export_share_pct=real(subinstr(strtrim(raw_prprex21),",","",.)) if source_year==2021
replace st_export_share_pct=cond(missing(export_share_pct),3,cond(export_share_pct<0,2,cond(export_share_pct==0,1,0))) if source_year==2021
replace st_export_share_pct=5 if source_year==2021 & missing(export_share_pct) & !inlist(upper(strtrim(raw_prprex21)),"","***",".","NA","N/A","NULL","-")
label values st_export_share_pct G0_source_state
generate double foreign_ownership_pct=.
generate byte st_foreign_ownership_pct=4
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing10),",","",.)) if source_year==2010
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2010
replace st_foreign_ownership_pct=5 if source_year==2010 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing10)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing11),",","",.)) if source_year==2011
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2011
replace st_foreign_ownership_pct=5 if source_year==2011 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing11)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing12),",","",.)) if source_year==2012
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2012
replace st_foreign_ownership_pct=5 if source_year==2012 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing12)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing13),",","",.)) if source_year==2013
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2013
replace st_foreign_ownership_pct=5 if source_year==2013 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing13)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing14),",","",.)) if source_year==2014
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2014
replace st_foreign_ownership_pct=5 if source_year==2014 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing14)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing),",","",.)) if source_year==2015
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2015
replace st_foreign_ownership_pct=5 if source_year==2015 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing17),",","",.)) if source_year==2017
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2017
replace st_foreign_ownership_pct=5 if source_year==2017 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing17)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing18),",","",.)) if source_year==2018
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2018
replace st_foreign_ownership_pct=5 if source_year==2018 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing18)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing19),",","",.)) if source_year==2019
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2019
replace st_foreign_ownership_pct=5 if source_year==2019 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing19)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing20),",","",.)) if source_year==2020
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2020
replace st_foreign_ownership_pct=5 if source_year==2020 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing20)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing21),",","",.)) if source_year==2021
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2021
replace st_foreign_ownership_pct=5 if source_year==2021 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing21)),"","***",".","NA","N/A","NULL","-")
replace foreign_ownership_pct=real(subinstr(strtrim(raw_dasing22),",","",.)) if source_year==2022
replace st_foreign_ownership_pct=cond(missing(foreign_ownership_pct),3,cond(foreign_ownership_pct<0,2,cond(foreign_ownership_pct==0,1,0))) if source_year==2022
replace st_foreign_ownership_pct=5 if source_year==2022 & missing(foreign_ownership_pct) & !inlist(upper(strtrim(raw_dasing22)),"","***",".","NA","N/A","NULL","-")
label values st_foreign_ownership_pct G0_source_state
generate double gross_output_nominal=.
generate byte st_gross_output_nominal=4
replace gross_output_nominal=real(subinstr(strtrim(raw_output10),",","",.)) if source_year==2010
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2010
replace st_gross_output_nominal=5 if source_year==2010 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output10)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output11),",","",.)) if source_year==2011
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2011
replace st_gross_output_nominal=5 if source_year==2011 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output11)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output12),",","",.)) if source_year==2012
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2012
replace st_gross_output_nominal=5 if source_year==2012 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output12)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output13),",","",.)) if source_year==2013
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2013
replace st_gross_output_nominal=5 if source_year==2013 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output13)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output14),",","",.)) if source_year==2014
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2014
replace st_gross_output_nominal=5 if source_year==2014 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output14)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output15),",","",.)) if source_year==2015
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2015
replace st_gross_output_nominal=5 if source_year==2015 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output15)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output17),",","",.)) if source_year==2017
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2017
replace st_gross_output_nominal=5 if source_year==2017 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output17)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output18),",","",.)) if source_year==2018
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2018
replace st_gross_output_nominal=5 if source_year==2018 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output18)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output19),",","",.)) if source_year==2019
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2019
replace st_gross_output_nominal=5 if source_year==2019 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output19)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output20),",","",.)) if source_year==2020
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2020
replace st_gross_output_nominal=5 if source_year==2020 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output20)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output21),",","",.)) if source_year==2021
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2021
replace st_gross_output_nominal=5 if source_year==2021 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output21)),"","***",".","NA","N/A","NULL","-")
replace gross_output_nominal=real(subinstr(strtrim(raw_output22),",","",.)) if source_year==2022
replace st_gross_output_nominal=cond(missing(gross_output_nominal),3,cond(gross_output_nominal<0,2,cond(gross_output_nominal==0,1,0))) if source_year==2022
replace st_gross_output_nominal=5 if source_year==2022 & missing(gross_output_nominal) & !inlist(upper(strtrim(raw_output22)),"","***",".","NA","N/A","NULL","-")
label values st_gross_output_nominal G0_source_state
generate double import_value_nominal=.
generate byte st_import_value_nominal=4
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu10),",","",.)) if source_year==2010
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2010
replace st_import_value_nominal=5 if source_year==2010 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu10)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu11),",","",.)) if source_year==2011
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2011
replace st_import_value_nominal=5 if source_year==2011 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu11)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu12),",","",.)) if source_year==2012
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2012
replace st_import_value_nominal=5 if source_year==2012 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu12)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu13),",","",.)) if source_year==2013
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2013
replace st_import_value_nominal=5 if source_year==2013 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu13)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu14),",","",.)) if source_year==2014
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2014
replace st_import_value_nominal=5 if source_year==2014 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu14)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu),",","",.)) if source_year==2015
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2015
replace st_import_value_nominal=5 if source_year==2015 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu17),",","",.)) if source_year==2017
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2017
replace st_import_value_nominal=5 if source_year==2017 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu17)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu18),",","",.)) if source_year==2018
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2018
replace st_import_value_nominal=5 if source_year==2018 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu18)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu19),",","",.)) if source_year==2019
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2019
replace st_import_value_nominal=5 if source_year==2019 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu19)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu20),",","",.)) if source_year==2020
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2020
replace st_import_value_nominal=5 if source_year==2020 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu20)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu21),",","",.)) if source_year==2021
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2021
replace st_import_value_nominal=5 if source_year==2021 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu21)),"","***",".","NA","N/A","NULL","-")
replace import_value_nominal=real(subinstr(strtrim(raw_rimvcu22),",","",.)) if source_year==2022
replace st_import_value_nominal=cond(missing(import_value_nominal),3,cond(import_value_nominal<0,2,cond(import_value_nominal==0,1,0))) if source_year==2022
replace st_import_value_nominal=5 if source_year==2022 & missing(import_value_nominal) & !inlist(upper(strtrim(raw_rimvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_import_value_nominal G0_source_state
generate double innovation_marketing_raw=.
generate byte st_innovation_marketing_raw=4
replace innovation_marketing_raw=real(subinstr(strtrim(raw_inomkt17),",","",.)) if source_year==2017
replace st_innovation_marketing_raw=cond(missing(innovation_marketing_raw),3,cond(innovation_marketing_raw<0,2,cond(innovation_marketing_raw==0,1,0))) if source_year==2017
replace st_innovation_marketing_raw=5 if source_year==2017 & missing(innovation_marketing_raw) & !inlist(upper(strtrim(raw_inomkt17)),"","***",".","NA","N/A","NULL","-")
replace innovation_marketing_raw=real(subinstr(strtrim(raw_inomkt18),",","",.)) if source_year==2018
replace st_innovation_marketing_raw=cond(missing(innovation_marketing_raw),3,cond(innovation_marketing_raw<0,2,cond(innovation_marketing_raw==0,1,0))) if source_year==2018
replace st_innovation_marketing_raw=5 if source_year==2018 & missing(innovation_marketing_raw) & !inlist(upper(strtrim(raw_inomkt18)),"","***",".","NA","N/A","NULL","-")
label values st_innovation_marketing_raw G0_source_state
generate double innovation_org_raw=.
generate byte st_innovation_org_raw=4
replace innovation_org_raw=real(subinstr(strtrim(raw_inoorg17),",","",.)) if source_year==2017
replace st_innovation_org_raw=cond(missing(innovation_org_raw),3,cond(innovation_org_raw<0,2,cond(innovation_org_raw==0,1,0))) if source_year==2017
replace st_innovation_org_raw=5 if source_year==2017 & missing(innovation_org_raw) & !inlist(upper(strtrim(raw_inoorg17)),"","***",".","NA","N/A","NULL","-")
replace innovation_org_raw=real(subinstr(strtrim(raw_inoorg18),",","",.)) if source_year==2018
replace st_innovation_org_raw=cond(missing(innovation_org_raw),3,cond(innovation_org_raw<0,2,cond(innovation_org_raw==0,1,0))) if source_year==2018
replace st_innovation_org_raw=5 if source_year==2018 & missing(innovation_org_raw) & !inlist(upper(strtrim(raw_inoorg18)),"","***",".","NA","N/A","NULL","-")
label values st_innovation_org_raw G0_source_state
generate double innovation_process_raw=.
generate byte st_innovation_process_raw=4
replace innovation_process_raw=real(subinstr(strtrim(raw_inopcs17),",","",.)) if source_year==2017
replace st_innovation_process_raw=cond(missing(innovation_process_raw),3,cond(innovation_process_raw<0,2,cond(innovation_process_raw==0,1,0))) if source_year==2017
replace st_innovation_process_raw=5 if source_year==2017 & missing(innovation_process_raw) & !inlist(upper(strtrim(raw_inopcs17)),"","***",".","NA","N/A","NULL","-")
replace innovation_process_raw=real(subinstr(strtrim(raw_inopcs18),",","",.)) if source_year==2018
replace st_innovation_process_raw=cond(missing(innovation_process_raw),3,cond(innovation_process_raw<0,2,cond(innovation_process_raw==0,1,0))) if source_year==2018
replace st_innovation_process_raw=5 if source_year==2018 & missing(innovation_process_raw) & !inlist(upper(strtrim(raw_inopcs18)),"","***",".","NA","N/A","NULL","-")
label values st_innovation_process_raw G0_source_state
generate double innovation_product_raw=.
generate byte st_innovation_product_raw=4
replace innovation_product_raw=real(subinstr(strtrim(raw_inoprd17),",","",.)) if source_year==2017
replace st_innovation_product_raw=cond(missing(innovation_product_raw),3,cond(innovation_product_raw<0,2,cond(innovation_product_raw==0,1,0))) if source_year==2017
replace st_innovation_product_raw=5 if source_year==2017 & missing(innovation_product_raw) & !inlist(upper(strtrim(raw_inoprd17)),"","***",".","NA","N/A","NULL","-")
replace innovation_product_raw=real(subinstr(strtrim(raw_inoprd18),",","",.)) if source_year==2018
replace st_innovation_product_raw=cond(missing(innovation_product_raw),3,cond(innovation_product_raw<0,2,cond(innovation_product_raw==0,1,0))) if source_year==2018
replace st_innovation_product_raw=5 if source_year==2018 & missing(innovation_product_raw) & !inlist(upper(strtrim(raw_inoprd18)),"","***",".","NA","N/A","NULL","-")
label values st_innovation_product_raw G0_source_state
generate double innovation_raw=.
generate byte st_innovation_raw=4
replace innovation_raw=real(subinstr(strtrim(raw_inov20),",","",.)) if source_year==2020
replace st_innovation_raw=cond(missing(innovation_raw),3,cond(innovation_raw<0,2,cond(innovation_raw==0,1,0))) if source_year==2020
replace st_innovation_raw=5 if source_year==2020 & missing(innovation_raw) & !inlist(upper(strtrim(raw_inov20)),"","***",".","NA","N/A","NULL","-")
replace innovation_raw=real(subinstr(strtrim(raw_inov21),",","",.)) if source_year==2021
replace st_innovation_raw=cond(missing(innovation_raw),3,cond(innovation_raw<0,2,cond(innovation_raw==0,1,0))) if source_year==2021
replace st_innovation_raw=5 if source_year==2021 & missing(innovation_raw) & !inlist(upper(strtrim(raw_inov21)),"","***",".","NA","N/A","NULL","-")
replace innovation_raw=real(subinstr(strtrim(raw_inov22),",","",.)) if source_year==2022
replace st_innovation_raw=cond(missing(innovation_raw),3,cond(innovation_raw<0,2,cond(innovation_raw==0,1,0))) if source_year==2022
replace st_innovation_raw=5 if source_year==2022 & missing(innovation_raw) & !inlist(upper(strtrim(raw_inov22)),"","***",".","NA","N/A","NULL","-")
label values st_innovation_raw G0_source_state
generate double inspli_raw=.
generate byte st_inspli_raw=4
replace inspli_raw=real(subinstr(strtrim(raw_inspli20),",","",.)) if source_year==2020
replace st_inspli_raw=cond(missing(inspli_raw),3,cond(inspli_raw<0,2,cond(inspli_raw==0,1,0))) if source_year==2020
replace st_inspli_raw=5 if source_year==2020 & missing(inspli_raw) & !inlist(upper(strtrim(raw_inspli20)),"","***",".","NA","N/A","NULL","-")
replace inspli_raw=real(subinstr(strtrim(raw_inspli21),",","",.)) if source_year==2021
replace st_inspli_raw=cond(missing(inspli_raw),3,cond(inspli_raw<0,2,cond(inspli_raw==0,1,0))) if source_year==2021
replace st_inspli_raw=5 if source_year==2021 & missing(inspli_raw) & !inlist(upper(strtrim(raw_inspli21)),"","***",".","NA","N/A","NULL","-")
replace inspli_raw=real(subinstr(strtrim(raw_inspli22),",","",.)) if source_year==2022
replace st_inspli_raw=cond(missing(inspli_raw),3,cond(inspli_raw<0,2,cond(inspli_raw==0,1,0))) if source_year==2022
replace st_inspli_raw=5 if source_year==2022 & missing(inspli_raw) & !inlist(upper(strtrim(raw_inspli22)),"","***",".","NA","N/A","NULL","-")
label values st_inspli_raw G0_source_state
generate double intermediate_inputs_nominal=.
generate byte st_intermediate_inputs_nominal=4
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput10),",","",.)) if source_year==2010
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2010
replace st_intermediate_inputs_nominal=5 if source_year==2010 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput10)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput11),",","",.)) if source_year==2011
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2011
replace st_intermediate_inputs_nominal=5 if source_year==2011 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput11)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput12),",","",.)) if source_year==2012
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2012
replace st_intermediate_inputs_nominal=5 if source_year==2012 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput12)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput13),",","",.)) if source_year==2013
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2013
replace st_intermediate_inputs_nominal=5 if source_year==2013 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput13)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput14),",","",.)) if source_year==2014
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2014
replace st_intermediate_inputs_nominal=5 if source_year==2014 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput14)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput15),",","",.)) if source_year==2015
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2015
replace st_intermediate_inputs_nominal=5 if source_year==2015 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput15)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput17),",","",.)) if source_year==2017
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2017
replace st_intermediate_inputs_nominal=5 if source_year==2017 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput17)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput18),",","",.)) if source_year==2018
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2018
replace st_intermediate_inputs_nominal=5 if source_year==2018 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput18)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput19),",","",.)) if source_year==2019
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2019
replace st_intermediate_inputs_nominal=5 if source_year==2019 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput19)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput20),",","",.)) if source_year==2020
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2020
replace st_intermediate_inputs_nominal=5 if source_year==2020 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput20)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput21),",","",.)) if source_year==2021
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2021
replace st_intermediate_inputs_nominal=5 if source_year==2021 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput21)),"","***",".","NA","N/A","NULL","-")
replace intermediate_inputs_nominal=real(subinstr(strtrim(raw_iinput22),",","",.)) if source_year==2022
replace st_intermediate_inputs_nominal=cond(missing(intermediate_inputs_nominal),3,cond(intermediate_inputs_nominal<0,2,cond(intermediate_inputs_nominal==0,1,0))) if source_year==2022
replace st_intermediate_inputs_nominal=5 if source_year==2022 & missing(intermediate_inputs_nominal) & !inlist(upper(strtrim(raw_iinput22)),"","***",".","NA","N/A","NULL","-")
label values st_intermediate_inputs_nominal G0_source_state
generate double liwste_raw=.
generate byte st_liwste_raw=4
replace liwste_raw=real(subinstr(strtrim(raw_liwste22),",","",.)) if source_year==2022
replace st_liwste_raw=cond(missing(liwste_raw),3,cond(liwste_raw<0,2,cond(liwste_raw==0,1,0))) if source_year==2022
replace st_liwste_raw=5 if source_year==2022 & missing(liwste_raw) & !inlist(upper(strtrim(raw_liwste22)),"","***",".","NA","N/A","NULL","-")
label values st_liwste_raw G0_source_state
generate double pplihi_raw=.
generate byte st_pplihi_raw=4
replace pplihi_raw=real(subinstr(strtrim(raw_pplihi20),",","",.)) if source_year==2020
replace st_pplihi_raw=cond(missing(pplihi_raw),3,cond(pplihi_raw<0,2,cond(pplihi_raw==0,1,0))) if source_year==2020
replace st_pplihi_raw=5 if source_year==2020 & missing(pplihi_raw) & !inlist(upper(strtrim(raw_pplihi20)),"","***",".","NA","N/A","NULL","-")
replace pplihi_raw=real(subinstr(strtrim(raw_pplihi21),",","",.)) if source_year==2021
replace st_pplihi_raw=cond(missing(pplihi_raw),3,cond(pplihi_raw<0,2,cond(pplihi_raw==0,1,0))) if source_year==2021
replace st_pplihi_raw=5 if source_year==2021 & missing(pplihi_raw) & !inlist(upper(strtrim(raw_pplihi21)),"","***",".","NA","N/A","NULL","-")
replace pplihi_raw=real(subinstr(strtrim(raw_pplihi22),",","",.)) if source_year==2022
replace st_pplihi_raw=cond(missing(pplihi_raw),3,cond(pplihi_raw<0,2,cond(pplihi_raw==0,1,0))) if source_year==2022
replace st_pplihi_raw=5 if source_year==2022 & missing(pplihi_raw) & !inlist(upper(strtrim(raw_pplihi22)),"","***",".","NA","N/A","NULL","-")
label values st_pplihi_raw G0_source_state
generate double production_workers=.
generate byte st_production_workers=4
replace production_workers=real(subinstr(strtrim(raw_lprnou10),",","",.)) if source_year==2010
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2010
replace st_production_workers=5 if source_year==2010 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou10)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou11),",","",.)) if source_year==2011
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2011
replace st_production_workers=5 if source_year==2011 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou11)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou12),",","",.)) if source_year==2012
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2012
replace st_production_workers=5 if source_year==2012 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou12)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou13),",","",.)) if source_year==2013
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2013
replace st_production_workers=5 if source_year==2013 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou13)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou14),",","",.)) if source_year==2014
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2014
replace st_production_workers=5 if source_year==2014 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou14)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou),",","",.)) if source_year==2015
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2015
replace st_production_workers=5 if source_year==2015 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou17),",","",.)) if source_year==2017
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2017
replace st_production_workers=5 if source_year==2017 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou17)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou18),",","",.)) if source_year==2018
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2018
replace st_production_workers=5 if source_year==2018 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou18)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou19),",","",.)) if source_year==2019
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2019
replace st_production_workers=5 if source_year==2019 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou19)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou20),",","",.)) if source_year==2020
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2020
replace st_production_workers=5 if source_year==2020 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou20)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou21),",","",.)) if source_year==2021
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2021
replace st_production_workers=5 if source_year==2021 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou21)),"","***",".","NA","N/A","NULL","-")
replace production_workers=real(subinstr(strtrim(raw_lprnou22),",","",.)) if source_year==2022
replace st_production_workers=cond(missing(production_workers),3,cond(production_workers<0,2,cond(production_workers==0,1,0))) if source_year==2022
replace st_production_workers=5 if source_year==2022 & missing(production_workers) & !inlist(upper(strtrim(raw_lprnou22)),"","***",".","NA","N/A","NULL","-")
label values st_production_workers G0_source_state
generate double rd_cost_nominal=.
generate byte st_rd_cost_nominal=4
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd17),",","",.)) if source_year==2017
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2017
replace st_rd_cost_nominal=5 if source_year==2017 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd17)),"","***",".","NA","N/A","NULL","-")
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd18),",","",.)) if source_year==2018
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2018
replace st_rd_cost_nominal=5 if source_year==2018 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd18)),"","***",".","NA","N/A","NULL","-")
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd19),",","",.)) if source_year==2019
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2019
replace st_rd_cost_nominal=5 if source_year==2019 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd19)),"","***",".","NA","N/A","NULL","-")
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd20),",","",.)) if source_year==2020
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2020
replace st_rd_cost_nominal=5 if source_year==2020 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd20)),"","***",".","NA","N/A","NULL","-")
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd21),",","",.)) if source_year==2021
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2021
replace st_rd_cost_nominal=5 if source_year==2021 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd21)),"","***",".","NA","N/A","NULL","-")
replace rd_cost_nominal=real(subinstr(strtrim(raw_costrd22),",","",.)) if source_year==2022
replace st_rd_cost_nominal=cond(missing(rd_cost_nominal),3,cond(rd_cost_nominal<0,2,cond(rd_cost_nominal==0,1,0))) if source_year==2022
replace st_rd_cost_nominal=5 if source_year==2022 & missing(rd_cost_nominal) & !inlist(upper(strtrim(raw_costrd22)),"","***",".","NA","N/A","NULL","-")
label values st_rd_cost_nominal G0_source_state
generate double rd_indicator_raw=.
generate byte st_rd_indicator_raw=4
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd17),",","",.)) if source_year==2017
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2017
replace st_rd_indicator_raw=5 if source_year==2017 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd17)),"","***",".","NA","N/A","NULL","-")
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd18),",","",.)) if source_year==2018
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2018
replace st_rd_indicator_raw=5 if source_year==2018 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd18)),"","***",".","NA","N/A","NULL","-")
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd19),",","",.)) if source_year==2019
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2019
replace st_rd_indicator_raw=5 if source_year==2019 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd19)),"","***",".","NA","N/A","NULL","-")
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd20),",","",.)) if source_year==2020
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2020
replace st_rd_indicator_raw=5 if source_year==2020 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd20)),"","***",".","NA","N/A","NULL","-")
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd21),",","",.)) if source_year==2021
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2021
replace st_rd_indicator_raw=5 if source_year==2021 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd21)),"","***",".","NA","N/A","NULL","-")
replace rd_indicator_raw=real(subinstr(strtrim(raw_rnd22),",","",.)) if source_year==2022
replace st_rd_indicator_raw=cond(missing(rd_indicator_raw),3,cond(rd_indicator_raw<0,2,cond(rd_indicator_raw==0,1,0))) if source_year==2022
replace st_rd_indicator_raw=5 if source_year==2022 & missing(rd_indicator_raw) & !inlist(upper(strtrim(raw_rnd22)),"","***",".","NA","N/A","NULL","-")
label values st_rd_indicator_raw G0_source_state
generate double rd_workers=.
generate byte st_rd_workers=4
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd17),",","",.)) if source_year==2017
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2017
replace st_rd_workers=5 if source_year==2017 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd17)),"","***",".","NA","N/A","NULL","-")
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd18),",","",.)) if source_year==2018
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2018
replace st_rd_workers=5 if source_year==2018 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd18)),"","***",".","NA","N/A","NULL","-")
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd19),",","",.)) if source_year==2019
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2019
replace st_rd_workers=5 if source_year==2019 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd19)),"","***",".","NA","N/A","NULL","-")
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd20),",","",.)) if source_year==2020
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2020
replace st_rd_workers=5 if source_year==2020 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd20)),"","***",".","NA","N/A","NULL","-")
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd21),",","",.)) if source_year==2021
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2021
replace st_rd_workers=5 if source_year==2021 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd21)),"","***",".","NA","N/A","NULL","-")
replace rd_workers=real(subinstr(strtrim(raw_ltlrnd22),",","",.)) if source_year==2022
replace st_rd_workers=cond(missing(rd_workers),3,cond(rd_workers<0,2,cond(rd_workers==0,1,0))) if source_year==2022
replace st_rd_workers=5 if source_year==2022 & missing(rd_workers) & !inlist(upper(strtrim(raw_ltlrnd22)),"","***",".","NA","N/A","NULL","-")
label values st_rd_workers G0_source_state
generate double sowste_raw=.
generate byte st_sowste_raw=4
replace sowste_raw=real(subinstr(strtrim(raw_sowste22),",","",.)) if source_year==2022
replace st_sowste_raw=cond(missing(sowste_raw),3,cond(sowste_raw<0,2,cond(sowste_raw==0,1,0))) if source_year==2022
replace st_sowste_raw=5 if source_year==2022 & missing(sowste_raw) & !inlist(upper(strtrim(raw_sowste22)),"","***",".","NA","N/A","NULL","-")
label values st_sowste_raw G0_source_state
generate double spplhi_raw=.
generate byte st_spplhi_raw=4
replace spplhi_raw=real(subinstr(strtrim(raw_spplhi20),",","",.)) if source_year==2020
replace st_spplhi_raw=cond(missing(spplhi_raw),3,cond(spplhi_raw<0,2,cond(spplhi_raw==0,1,0))) if source_year==2020
replace st_spplhi_raw=5 if source_year==2020 & missing(spplhi_raw) & !inlist(upper(strtrim(raw_spplhi20)),"","***",".","NA","N/A","NULL","-")
replace spplhi_raw=real(subinstr(strtrim(raw_spplhi21),",","",.)) if source_year==2021
replace st_spplhi_raw=cond(missing(spplhi_raw),3,cond(spplhi_raw<0,2,cond(spplhi_raw==0,1,0))) if source_year==2021
replace st_spplhi_raw=5 if source_year==2021 & missing(spplhi_raw) & !inlist(upper(strtrim(raw_spplhi21)),"","***",".","NA","N/A","NULL","-")
replace spplhi_raw=real(subinstr(strtrim(raw_spplhi22),",","",.)) if source_year==2022
replace st_spplhi_raw=cond(missing(spplhi_raw),3,cond(spplhi_raw<0,2,cond(spplhi_raw==0,1,0))) if source_year==2022
replace st_spplhi_raw=5 if source_year==2022 & missing(spplhi_raw) & !inlist(upper(strtrim(raw_spplhi22)),"","***",".","NA","N/A","NULL","-")
label values st_spplhi_raw G0_source_state
generate double val_cbdacu=.
generate byte st_val_cbdacu=4
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu10),",","",.)) if source_year==2010
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2010
replace st_val_cbdacu=5 if source_year==2010 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu11),",","",.)) if source_year==2011
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2011
replace st_val_cbdacu=5 if source_year==2011 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu12),",","",.)) if source_year==2012
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2012
replace st_val_cbdacu=5 if source_year==2012 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu13),",","",.)) if source_year==2013
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2013
replace st_val_cbdacu=5 if source_year==2013 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu14),",","",.)) if source_year==2014
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2014
replace st_val_cbdacu=5 if source_year==2014 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu17),",","",.)) if source_year==2017
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2017
replace st_val_cbdacu=5 if source_year==2017 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu18),",","",.)) if source_year==2018
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2018
replace st_val_cbdacu=5 if source_year==2018 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cbdacu=real(subinstr(strtrim(raw_cbdacu19),",","",.)) if source_year==2019
replace st_val_cbdacu=cond(missing(val_cbdacu),3,cond(val_cbdacu<0,2,cond(val_cbdacu==0,1,0))) if source_year==2019
replace st_val_cbdacu=5 if source_year==2019 & missing(val_cbdacu) & !inlist(upper(strtrim(raw_cbdacu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_cbdacu G0_source_state
generate double val_cbfpcu=.
generate byte st_val_cbfpcu=4
replace val_cbfpcu=real(subinstr(strtrim(raw_cbfpcu20),",","",.)) if source_year==2020
replace st_val_cbfpcu=cond(missing(val_cbfpcu),3,cond(val_cbfpcu<0,2,cond(val_cbfpcu==0,1,0))) if source_year==2020
replace st_val_cbfpcu=5 if source_year==2020 & missing(val_cbfpcu) & !inlist(upper(strtrim(raw_cbfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cbfpcu=real(subinstr(strtrim(raw_cbfpcu21),",","",.)) if source_year==2021
replace st_val_cbfpcu=cond(missing(val_cbfpcu),3,cond(val_cbfpcu<0,2,cond(val_cbfpcu==0,1,0))) if source_year==2021
replace st_val_cbfpcu=5 if source_year==2021 & missing(val_cbfpcu) & !inlist(upper(strtrim(raw_cbfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cbfpcu=real(subinstr(strtrim(raw_cbfpcu22),",","",.)) if source_year==2022
replace st_val_cbfpcu=cond(missing(val_cbfpcu),3,cond(val_cbfpcu<0,2,cond(val_cbfpcu==0,1,0))) if source_year==2022
replace st_val_cbfpcu=5 if source_year==2022 & missing(val_cbfpcu) & !inlist(upper(strtrim(raw_cbfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cbfpcu G0_source_state
generate double val_cbsacu=.
generate byte st_val_cbsacu=4
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu10),",","",.)) if source_year==2010
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2010
replace st_val_cbsacu=5 if source_year==2010 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu11),",","",.)) if source_year==2011
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2011
replace st_val_cbsacu=5 if source_year==2011 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu12),",","",.)) if source_year==2012
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2012
replace st_val_cbsacu=5 if source_year==2012 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu13),",","",.)) if source_year==2013
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2013
replace st_val_cbsacu=5 if source_year==2013 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu14),",","",.)) if source_year==2014
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2014
replace st_val_cbsacu=5 if source_year==2014 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu),",","",.)) if source_year==2015
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2015
replace st_val_cbsacu=5 if source_year==2015 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu17),",","",.)) if source_year==2017
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2017
replace st_val_cbsacu=5 if source_year==2017 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu18),",","",.)) if source_year==2018
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2018
replace st_val_cbsacu=5 if source_year==2018 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu19),",","",.)) if source_year==2019
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2019
replace st_val_cbsacu=5 if source_year==2019 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu19)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu20),",","",.)) if source_year==2020
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2020
replace st_val_cbsacu=5 if source_year==2020 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu20)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu21),",","",.)) if source_year==2021
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2021
replace st_val_cbsacu=5 if source_year==2021 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu21)),"","***",".","NA","N/A","NULL","-")
replace val_cbsacu=real(subinstr(strtrim(raw_cbsacu22),",","",.)) if source_year==2022
replace st_val_cbsacu=cond(missing(val_cbsacu),3,cond(val_cbsacu<0,2,cond(val_cbsacu==0,1,0))) if source_year==2022
replace st_val_cbsacu=5 if source_year==2022 & missing(val_cbsacu) & !inlist(upper(strtrim(raw_cbsacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cbsacu G0_source_state
generate double val_cbttcu=.
generate byte st_val_cbttcu=4
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu10),",","",.)) if source_year==2010
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2010
replace st_val_cbttcu=5 if source_year==2010 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu10)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu11),",","",.)) if source_year==2011
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2011
replace st_val_cbttcu=5 if source_year==2011 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu11)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu12),",","",.)) if source_year==2012
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2012
replace st_val_cbttcu=5 if source_year==2012 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu12)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu13),",","",.)) if source_year==2013
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2013
replace st_val_cbttcu=5 if source_year==2013 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu13)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu14),",","",.)) if source_year==2014
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2014
replace st_val_cbttcu=5 if source_year==2014 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu14)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu),",","",.)) if source_year==2015
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2015
replace st_val_cbttcu=5 if source_year==2015 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu17),",","",.)) if source_year==2017
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2017
replace st_val_cbttcu=5 if source_year==2017 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu18),",","",.)) if source_year==2018
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2018
replace st_val_cbttcu=5 if source_year==2018 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu19),",","",.)) if source_year==2019
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2019
replace st_val_cbttcu=5 if source_year==2019 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu20),",","",.)) if source_year==2020
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2020
replace st_val_cbttcu=5 if source_year==2020 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu21),",","",.)) if source_year==2021
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2021
replace st_val_cbttcu=5 if source_year==2021 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cbttcu=real(subinstr(strtrim(raw_cbttcu22),",","",.)) if source_year==2022
replace st_val_cbttcu=cond(missing(val_cbttcu),3,cond(val_cbttcu<0,2,cond(val_cbttcu==0,1,0))) if source_year==2022
replace st_val_cbttcu=5 if source_year==2022 & missing(val_cbttcu) & !inlist(upper(strtrim(raw_cbttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cbttcu G0_source_state
generate double val_cldacu=.
generate byte st_val_cldacu=4
replace val_cldacu=real(subinstr(strtrim(raw_cldacu10),",","",.)) if source_year==2010
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2010
replace st_val_cldacu=5 if source_year==2010 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cldacu=real(subinstr(strtrim(raw_cldacu11),",","",.)) if source_year==2011
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2011
replace st_val_cldacu=5 if source_year==2011 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cldacu=real(subinstr(strtrim(raw_cldacu12),",","",.)) if source_year==2012
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2012
replace st_val_cldacu=5 if source_year==2012 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cldacu=real(subinstr(strtrim(raw_cldacu13),",","",.)) if source_year==2013
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2013
replace st_val_cldacu=5 if source_year==2013 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cldacu=real(subinstr(strtrim(raw_cldacu14),",","",.)) if source_year==2014
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2014
replace st_val_cldacu=5 if source_year==2014 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cldacu=real(subinstr(strtrim(raw_cldacu17),",","",.)) if source_year==2017
replace st_val_cldacu=cond(missing(val_cldacu),3,cond(val_cldacu<0,2,cond(val_cldacu==0,1,0))) if source_year==2017
replace st_val_cldacu=5 if source_year==2017 & missing(val_cldacu) & !inlist(upper(strtrim(raw_cldacu17)),"","***",".","NA","N/A","NULL","-")
label values st_val_cldacu G0_source_state
generate double val_clfpcu=.
generate byte st_val_clfpcu=4
replace val_clfpcu=real(subinstr(strtrim(raw_clfpcu20),",","",.)) if source_year==2020
replace st_val_clfpcu=cond(missing(val_clfpcu),3,cond(val_clfpcu<0,2,cond(val_clfpcu==0,1,0))) if source_year==2020
replace st_val_clfpcu=5 if source_year==2020 & missing(val_clfpcu) & !inlist(upper(strtrim(raw_clfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_clfpcu=real(subinstr(strtrim(raw_clfpcu21),",","",.)) if source_year==2021
replace st_val_clfpcu=cond(missing(val_clfpcu),3,cond(val_clfpcu<0,2,cond(val_clfpcu==0,1,0))) if source_year==2021
replace st_val_clfpcu=5 if source_year==2021 & missing(val_clfpcu) & !inlist(upper(strtrim(raw_clfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_clfpcu=real(subinstr(strtrim(raw_clfpcu22),",","",.)) if source_year==2022
replace st_val_clfpcu=cond(missing(val_clfpcu),3,cond(val_clfpcu<0,2,cond(val_clfpcu==0,1,0))) if source_year==2022
replace st_val_clfpcu=5 if source_year==2022 & missing(val_clfpcu) & !inlist(upper(strtrim(raw_clfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_clfpcu G0_source_state
generate double val_clsacu=.
generate byte st_val_clsacu=4
replace val_clsacu=real(subinstr(strtrim(raw_clsacu10),",","",.)) if source_year==2010
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2010
replace st_val_clsacu=5 if source_year==2010 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu10)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu11),",","",.)) if source_year==2011
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2011
replace st_val_clsacu=5 if source_year==2011 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu11)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu12),",","",.)) if source_year==2012
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2012
replace st_val_clsacu=5 if source_year==2012 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu12)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu13),",","",.)) if source_year==2013
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2013
replace st_val_clsacu=5 if source_year==2013 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu13)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu14),",","",.)) if source_year==2014
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2014
replace st_val_clsacu=5 if source_year==2014 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu14)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu),",","",.)) if source_year==2015
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2015
replace st_val_clsacu=5 if source_year==2015 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu17),",","",.)) if source_year==2017
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2017
replace st_val_clsacu=5 if source_year==2017 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu17)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu18),",","",.)) if source_year==2018
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2018
replace st_val_clsacu=5 if source_year==2018 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu18)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu19),",","",.)) if source_year==2019
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2019
replace st_val_clsacu=5 if source_year==2019 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu19)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu20),",","",.)) if source_year==2020
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2020
replace st_val_clsacu=5 if source_year==2020 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu20)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu21),",","",.)) if source_year==2021
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2021
replace st_val_clsacu=5 if source_year==2021 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu21)),"","***",".","NA","N/A","NULL","-")
replace val_clsacu=real(subinstr(strtrim(raw_clsacu22),",","",.)) if source_year==2022
replace st_val_clsacu=cond(missing(val_clsacu),3,cond(val_clsacu<0,2,cond(val_clsacu==0,1,0))) if source_year==2022
replace st_val_clsacu=5 if source_year==2022 & missing(val_clsacu) & !inlist(upper(strtrim(raw_clsacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_clsacu G0_source_state
generate double val_clttcu=.
generate byte st_val_clttcu=4
replace val_clttcu=real(subinstr(strtrim(raw_clttcu10),",","",.)) if source_year==2010
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2010
replace st_val_clttcu=5 if source_year==2010 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu10)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu11),",","",.)) if source_year==2011
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2011
replace st_val_clttcu=5 if source_year==2011 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu11)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu12),",","",.)) if source_year==2012
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2012
replace st_val_clttcu=5 if source_year==2012 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu12)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu13),",","",.)) if source_year==2013
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2013
replace st_val_clttcu=5 if source_year==2013 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu13)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu14),",","",.)) if source_year==2014
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2014
replace st_val_clttcu=5 if source_year==2014 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu14)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu),",","",.)) if source_year==2015
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2015
replace st_val_clttcu=5 if source_year==2015 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu17),",","",.)) if source_year==2017
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2017
replace st_val_clttcu=5 if source_year==2017 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu18),",","",.)) if source_year==2018
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2018
replace st_val_clttcu=5 if source_year==2018 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu19),",","",.)) if source_year==2019
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2019
replace st_val_clttcu=5 if source_year==2019 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu20),",","",.)) if source_year==2020
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2020
replace st_val_clttcu=5 if source_year==2020 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu21),",","",.)) if source_year==2021
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2021
replace st_val_clttcu=5 if source_year==2021 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_clttcu=real(subinstr(strtrim(raw_clttcu22),",","",.)) if source_year==2022
replace st_val_clttcu=cond(missing(val_clttcu),3,cond(val_clttcu<0,2,cond(val_clttcu==0,1,0))) if source_year==2022
replace st_val_clttcu=5 if source_year==2022 & missing(val_clttcu) & !inlist(upper(strtrim(raw_clttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_clttcu G0_source_state
generate double val_cmdacu=.
generate byte st_val_cmdacu=4
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu10),",","",.)) if source_year==2010
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2010
replace st_val_cmdacu=5 if source_year==2010 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu11),",","",.)) if source_year==2011
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2011
replace st_val_cmdacu=5 if source_year==2011 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu12),",","",.)) if source_year==2012
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2012
replace st_val_cmdacu=5 if source_year==2012 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu13),",","",.)) if source_year==2013
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2013
replace st_val_cmdacu=5 if source_year==2013 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu14),",","",.)) if source_year==2014
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2014
replace st_val_cmdacu=5 if source_year==2014 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu17),",","",.)) if source_year==2017
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2017
replace st_val_cmdacu=5 if source_year==2017 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu18),",","",.)) if source_year==2018
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2018
replace st_val_cmdacu=5 if source_year==2018 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cmdacu=real(subinstr(strtrim(raw_cmdacu19),",","",.)) if source_year==2019
replace st_val_cmdacu=cond(missing(val_cmdacu),3,cond(val_cmdacu<0,2,cond(val_cmdacu==0,1,0))) if source_year==2019
replace st_val_cmdacu=5 if source_year==2019 & missing(val_cmdacu) & !inlist(upper(strtrim(raw_cmdacu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_cmdacu G0_source_state
generate double val_cmfpcu=.
generate byte st_val_cmfpcu=4
replace val_cmfpcu=real(subinstr(strtrim(raw_cmfpcu20),",","",.)) if source_year==2020
replace st_val_cmfpcu=cond(missing(val_cmfpcu),3,cond(val_cmfpcu<0,2,cond(val_cmfpcu==0,1,0))) if source_year==2020
replace st_val_cmfpcu=5 if source_year==2020 & missing(val_cmfpcu) & !inlist(upper(strtrim(raw_cmfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cmfpcu=real(subinstr(strtrim(raw_cmfpcu21),",","",.)) if source_year==2021
replace st_val_cmfpcu=cond(missing(val_cmfpcu),3,cond(val_cmfpcu<0,2,cond(val_cmfpcu==0,1,0))) if source_year==2021
replace st_val_cmfpcu=5 if source_year==2021 & missing(val_cmfpcu) & !inlist(upper(strtrim(raw_cmfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cmfpcu=real(subinstr(strtrim(raw_cmfpcu22),",","",.)) if source_year==2022
replace st_val_cmfpcu=cond(missing(val_cmfpcu),3,cond(val_cmfpcu<0,2,cond(val_cmfpcu==0,1,0))) if source_year==2022
replace st_val_cmfpcu=5 if source_year==2022 & missing(val_cmfpcu) & !inlist(upper(strtrim(raw_cmfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cmfpcu G0_source_state
generate double val_cmsacu=.
generate byte st_val_cmsacu=4
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu10),",","",.)) if source_year==2010
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2010
replace st_val_cmsacu=5 if source_year==2010 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu11),",","",.)) if source_year==2011
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2011
replace st_val_cmsacu=5 if source_year==2011 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu12),",","",.)) if source_year==2012
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2012
replace st_val_cmsacu=5 if source_year==2012 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu13),",","",.)) if source_year==2013
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2013
replace st_val_cmsacu=5 if source_year==2013 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu14),",","",.)) if source_year==2014
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2014
replace st_val_cmsacu=5 if source_year==2014 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu),",","",.)) if source_year==2015
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2015
replace st_val_cmsacu=5 if source_year==2015 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu17),",","",.)) if source_year==2017
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2017
replace st_val_cmsacu=5 if source_year==2017 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu18),",","",.)) if source_year==2018
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2018
replace st_val_cmsacu=5 if source_year==2018 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu19),",","",.)) if source_year==2019
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2019
replace st_val_cmsacu=5 if source_year==2019 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu19)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu20),",","",.)) if source_year==2020
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2020
replace st_val_cmsacu=5 if source_year==2020 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu20)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu21),",","",.)) if source_year==2021
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2021
replace st_val_cmsacu=5 if source_year==2021 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu21)),"","***",".","NA","N/A","NULL","-")
replace val_cmsacu=real(subinstr(strtrim(raw_cmsacu22),",","",.)) if source_year==2022
replace st_val_cmsacu=cond(missing(val_cmsacu),3,cond(val_cmsacu<0,2,cond(val_cmsacu==0,1,0))) if source_year==2022
replace st_val_cmsacu=5 if source_year==2022 & missing(val_cmsacu) & !inlist(upper(strtrim(raw_cmsacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cmsacu G0_source_state
generate double val_cmttcu=.
generate byte st_val_cmttcu=4
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu10),",","",.)) if source_year==2010
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2010
replace st_val_cmttcu=5 if source_year==2010 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu10)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu11),",","",.)) if source_year==2011
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2011
replace st_val_cmttcu=5 if source_year==2011 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu11)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu12),",","",.)) if source_year==2012
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2012
replace st_val_cmttcu=5 if source_year==2012 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu12)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu13),",","",.)) if source_year==2013
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2013
replace st_val_cmttcu=5 if source_year==2013 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu13)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu14),",","",.)) if source_year==2014
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2014
replace st_val_cmttcu=5 if source_year==2014 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu14)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu),",","",.)) if source_year==2015
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2015
replace st_val_cmttcu=5 if source_year==2015 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu17),",","",.)) if source_year==2017
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2017
replace st_val_cmttcu=5 if source_year==2017 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu18),",","",.)) if source_year==2018
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2018
replace st_val_cmttcu=5 if source_year==2018 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu19),",","",.)) if source_year==2019
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2019
replace st_val_cmttcu=5 if source_year==2019 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu20),",","",.)) if source_year==2020
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2020
replace st_val_cmttcu=5 if source_year==2020 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu21),",","",.)) if source_year==2021
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2021
replace st_val_cmttcu=5 if source_year==2021 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cmttcu=real(subinstr(strtrim(raw_cmttcu22),",","",.)) if source_year==2022
replace st_val_cmttcu=cond(missing(val_cmttcu),3,cond(val_cmttcu<0,2,cond(val_cmttcu==0,1,0))) if source_year==2022
replace st_val_cmttcu=5 if source_year==2022 & missing(val_cmttcu) & !inlist(upper(strtrim(raw_cmttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cmttcu G0_source_state
generate double val_codacu=.
generate byte st_val_codacu=4
replace val_codacu=real(subinstr(strtrim(raw_codacu10),",","",.)) if source_year==2010
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2010
replace st_val_codacu=5 if source_year==2010 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu10)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu11),",","",.)) if source_year==2011
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2011
replace st_val_codacu=5 if source_year==2011 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu11)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu12),",","",.)) if source_year==2012
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2012
replace st_val_codacu=5 if source_year==2012 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu12)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu13),",","",.)) if source_year==2013
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2013
replace st_val_codacu=5 if source_year==2013 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu13)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu14),",","",.)) if source_year==2014
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2014
replace st_val_codacu=5 if source_year==2014 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu14)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu17),",","",.)) if source_year==2017
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2017
replace st_val_codacu=5 if source_year==2017 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu17)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu18),",","",.)) if source_year==2018
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2018
replace st_val_codacu=5 if source_year==2018 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu18)),"","***",".","NA","N/A","NULL","-")
replace val_codacu=real(subinstr(strtrim(raw_codacu19),",","",.)) if source_year==2019
replace st_val_codacu=cond(missing(val_codacu),3,cond(val_codacu<0,2,cond(val_codacu==0,1,0))) if source_year==2019
replace st_val_codacu=5 if source_year==2019 & missing(val_codacu) & !inlist(upper(strtrim(raw_codacu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_codacu G0_source_state
generate double val_cofpcu=.
generate byte st_val_cofpcu=4
replace val_cofpcu=real(subinstr(strtrim(raw_cofpcu20),",","",.)) if source_year==2020
replace st_val_cofpcu=cond(missing(val_cofpcu),3,cond(val_cofpcu<0,2,cond(val_cofpcu==0,1,0))) if source_year==2020
replace st_val_cofpcu=5 if source_year==2020 & missing(val_cofpcu) & !inlist(upper(strtrim(raw_cofpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cofpcu=real(subinstr(strtrim(raw_cofpcu21),",","",.)) if source_year==2021
replace st_val_cofpcu=cond(missing(val_cofpcu),3,cond(val_cofpcu<0,2,cond(val_cofpcu==0,1,0))) if source_year==2021
replace st_val_cofpcu=5 if source_year==2021 & missing(val_cofpcu) & !inlist(upper(strtrim(raw_cofpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cofpcu=real(subinstr(strtrim(raw_cofpcu22),",","",.)) if source_year==2022
replace st_val_cofpcu=cond(missing(val_cofpcu),3,cond(val_cofpcu<0,2,cond(val_cofpcu==0,1,0))) if source_year==2022
replace st_val_cofpcu=5 if source_year==2022 & missing(val_cofpcu) & !inlist(upper(strtrim(raw_cofpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cofpcu G0_source_state
generate double val_cosacu=.
generate byte st_val_cosacu=4
replace val_cosacu=real(subinstr(strtrim(raw_cosacu10),",","",.)) if source_year==2010
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2010
replace st_val_cosacu=5 if source_year==2010 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu11),",","",.)) if source_year==2011
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2011
replace st_val_cosacu=5 if source_year==2011 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu12),",","",.)) if source_year==2012
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2012
replace st_val_cosacu=5 if source_year==2012 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu13),",","",.)) if source_year==2013
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2013
replace st_val_cosacu=5 if source_year==2013 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu14),",","",.)) if source_year==2014
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2014
replace st_val_cosacu=5 if source_year==2014 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu),",","",.)) if source_year==2015
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2015
replace st_val_cosacu=5 if source_year==2015 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu17),",","",.)) if source_year==2017
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2017
replace st_val_cosacu=5 if source_year==2017 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu18),",","",.)) if source_year==2018
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2018
replace st_val_cosacu=5 if source_year==2018 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu19),",","",.)) if source_year==2019
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2019
replace st_val_cosacu=5 if source_year==2019 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu19)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu20),",","",.)) if source_year==2020
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2020
replace st_val_cosacu=5 if source_year==2020 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu20)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu21),",","",.)) if source_year==2021
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2021
replace st_val_cosacu=5 if source_year==2021 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu21)),"","***",".","NA","N/A","NULL","-")
replace val_cosacu=real(subinstr(strtrim(raw_cosacu22),",","",.)) if source_year==2022
replace st_val_cosacu=cond(missing(val_cosacu),3,cond(val_cosacu<0,2,cond(val_cosacu==0,1,0))) if source_year==2022
replace st_val_cosacu=5 if source_year==2022 & missing(val_cosacu) & !inlist(upper(strtrim(raw_cosacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cosacu G0_source_state
generate double val_costrd=.
generate byte st_val_costrd=4
replace val_costrd=real(subinstr(strtrim(raw_costrd17),",","",.)) if source_year==2017
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2017
replace st_val_costrd=5 if source_year==2017 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd17)),"","***",".","NA","N/A","NULL","-")
replace val_costrd=real(subinstr(strtrim(raw_costrd18),",","",.)) if source_year==2018
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2018
replace st_val_costrd=5 if source_year==2018 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd18)),"","***",".","NA","N/A","NULL","-")
replace val_costrd=real(subinstr(strtrim(raw_costrd19),",","",.)) if source_year==2019
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2019
replace st_val_costrd=5 if source_year==2019 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd19)),"","***",".","NA","N/A","NULL","-")
replace val_costrd=real(subinstr(strtrim(raw_costrd20),",","",.)) if source_year==2020
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2020
replace st_val_costrd=5 if source_year==2020 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd20)),"","***",".","NA","N/A","NULL","-")
replace val_costrd=real(subinstr(strtrim(raw_costrd21),",","",.)) if source_year==2021
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2021
replace st_val_costrd=5 if source_year==2021 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd21)),"","***",".","NA","N/A","NULL","-")
replace val_costrd=real(subinstr(strtrim(raw_costrd22),",","",.)) if source_year==2022
replace st_val_costrd=cond(missing(val_costrd),3,cond(val_costrd<0,2,cond(val_costrd==0,1,0))) if source_year==2022
replace st_val_costrd=5 if source_year==2022 & missing(val_costrd) & !inlist(upper(strtrim(raw_costrd22)),"","***",".","NA","N/A","NULL","-")
label values st_val_costrd G0_source_state
generate double val_cottcu=.
generate byte st_val_cottcu=4
replace val_cottcu=real(subinstr(strtrim(raw_cottcu10),",","",.)) if source_year==2010
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2010
replace st_val_cottcu=5 if source_year==2010 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu10)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu11),",","",.)) if source_year==2011
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2011
replace st_val_cottcu=5 if source_year==2011 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu11)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu12),",","",.)) if source_year==2012
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2012
replace st_val_cottcu=5 if source_year==2012 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu12)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu13),",","",.)) if source_year==2013
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2013
replace st_val_cottcu=5 if source_year==2013 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu13)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu14),",","",.)) if source_year==2014
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2014
replace st_val_cottcu=5 if source_year==2014 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu14)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu),",","",.)) if source_year==2015
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2015
replace st_val_cottcu=5 if source_year==2015 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu17),",","",.)) if source_year==2017
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2017
replace st_val_cottcu=5 if source_year==2017 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu17)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu18),",","",.)) if source_year==2018
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2018
replace st_val_cottcu=5 if source_year==2018 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu18)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu19),",","",.)) if source_year==2019
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2019
replace st_val_cottcu=5 if source_year==2019 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu19)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu20),",","",.)) if source_year==2020
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2020
replace st_val_cottcu=5 if source_year==2020 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu21),",","",.)) if source_year==2021
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2021
replace st_val_cottcu=5 if source_year==2021 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cottcu=real(subinstr(strtrim(raw_cottcu22),",","",.)) if source_year==2022
replace st_val_cottcu=cond(missing(val_cottcu),3,cond(val_cottcu<0,2,cond(val_cottcu==0,1,0))) if source_year==2022
replace st_val_cottcu=5 if source_year==2022 & missing(val_cottcu) & !inlist(upper(strtrim(raw_cottcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cottcu G0_source_state
generate double val_csdacu=.
generate byte st_val_csdacu=4
replace val_csdacu=real(subinstr(strtrim(raw_csdacu17),",","",.)) if source_year==2017
replace st_val_csdacu=cond(missing(val_csdacu),3,cond(val_csdacu<0,2,cond(val_csdacu==0,1,0))) if source_year==2017
replace st_val_csdacu=5 if source_year==2017 & missing(val_csdacu) & !inlist(upper(strtrim(raw_csdacu17)),"","***",".","NA","N/A","NULL","-")
label values st_val_csdacu G0_source_state
generate double val_csfpcu=.
generate byte st_val_csfpcu=4
replace val_csfpcu=real(subinstr(strtrim(raw_csfpcu20),",","",.)) if source_year==2020
replace st_val_csfpcu=cond(missing(val_csfpcu),3,cond(val_csfpcu<0,2,cond(val_csfpcu==0,1,0))) if source_year==2020
replace st_val_csfpcu=5 if source_year==2020 & missing(val_csfpcu) & !inlist(upper(strtrim(raw_csfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_csfpcu=real(subinstr(strtrim(raw_csfpcu21),",","",.)) if source_year==2021
replace st_val_csfpcu=cond(missing(val_csfpcu),3,cond(val_csfpcu<0,2,cond(val_csfpcu==0,1,0))) if source_year==2021
replace st_val_csfpcu=5 if source_year==2021 & missing(val_csfpcu) & !inlist(upper(strtrim(raw_csfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_csfpcu=real(subinstr(strtrim(raw_csfpcu22),",","",.)) if source_year==2022
replace st_val_csfpcu=cond(missing(val_csfpcu),3,cond(val_csfpcu<0,2,cond(val_csfpcu==0,1,0))) if source_year==2022
replace st_val_csfpcu=5 if source_year==2022 & missing(val_csfpcu) & !inlist(upper(strtrim(raw_csfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_csfpcu G0_source_state
generate double val_cssacu=.
generate byte st_val_cssacu=4
replace val_cssacu=real(subinstr(strtrim(raw_cssacu17),",","",.)) if source_year==2017
replace st_val_cssacu=cond(missing(val_cssacu),3,cond(val_cssacu<0,2,cond(val_cssacu==0,1,0))) if source_year==2017
replace st_val_cssacu=5 if source_year==2017 & missing(val_cssacu) & !inlist(upper(strtrim(raw_cssacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cssacu=real(subinstr(strtrim(raw_cssacu18),",","",.)) if source_year==2018
replace st_val_cssacu=cond(missing(val_cssacu),3,cond(val_cssacu<0,2,cond(val_cssacu==0,1,0))) if source_year==2018
replace st_val_cssacu=5 if source_year==2018 & missing(val_cssacu) & !inlist(upper(strtrim(raw_cssacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cssacu=real(subinstr(strtrim(raw_cssacu19),",","",.)) if source_year==2019
replace st_val_cssacu=cond(missing(val_cssacu),3,cond(val_cssacu<0,2,cond(val_cssacu==0,1,0))) if source_year==2019
replace st_val_cssacu=5 if source_year==2019 & missing(val_cssacu) & !inlist(upper(strtrim(raw_cssacu19)),"","***",".","NA","N/A","NULL","-")
replace val_cssacu=real(subinstr(strtrim(raw_cssacu20),",","",.)) if source_year==2020
replace st_val_cssacu=cond(missing(val_cssacu),3,cond(val_cssacu<0,2,cond(val_cssacu==0,1,0))) if source_year==2020
replace st_val_cssacu=5 if source_year==2020 & missing(val_cssacu) & !inlist(upper(strtrim(raw_cssacu20)),"","***",".","NA","N/A","NULL","-")
replace val_cssacu=real(subinstr(strtrim(raw_cssacu21),",","",.)) if source_year==2021
replace st_val_cssacu=cond(missing(val_cssacu),3,cond(val_cssacu<0,2,cond(val_cssacu==0,1,0))) if source_year==2021
replace st_val_cssacu=5 if source_year==2021 & missing(val_cssacu) & !inlist(upper(strtrim(raw_cssacu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_cssacu G0_source_state
generate double val_csttcu=.
generate byte st_val_csttcu=4
replace val_csttcu=real(subinstr(strtrim(raw_csttcu17),",","",.)) if source_year==2017
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2017
replace st_val_csttcu=5 if source_year==2017 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_csttcu=real(subinstr(strtrim(raw_csttcu18),",","",.)) if source_year==2018
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2018
replace st_val_csttcu=5 if source_year==2018 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_csttcu=real(subinstr(strtrim(raw_csttcu19),",","",.)) if source_year==2019
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2019
replace st_val_csttcu=5 if source_year==2019 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_csttcu=real(subinstr(strtrim(raw_csttcu20),",","",.)) if source_year==2020
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2020
replace st_val_csttcu=5 if source_year==2020 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_csttcu=real(subinstr(strtrim(raw_csttcu21),",","",.)) if source_year==2021
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2021
replace st_val_csttcu=5 if source_year==2021 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_csttcu=real(subinstr(strtrim(raw_csttcu22),",","",.)) if source_year==2022
replace st_val_csttcu=cond(missing(val_csttcu),3,cond(val_csttcu<0,2,cond(val_csttcu==0,1,0))) if source_year==2022
replace st_val_csttcu=5 if source_year==2022 & missing(val_csttcu) & !inlist(upper(strtrim(raw_csttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_csttcu G0_source_state
generate double val_ctdacu=.
generate byte st_val_ctdacu=4
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu10),",","",.)) if source_year==2010
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2010
replace st_val_ctdacu=5 if source_year==2010 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu10)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu11),",","",.)) if source_year==2011
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2011
replace st_val_ctdacu=5 if source_year==2011 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu11)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu12),",","",.)) if source_year==2012
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2012
replace st_val_ctdacu=5 if source_year==2012 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu12)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu13),",","",.)) if source_year==2013
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2013
replace st_val_ctdacu=5 if source_year==2013 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu13)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu14),",","",.)) if source_year==2014
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2014
replace st_val_ctdacu=5 if source_year==2014 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu14)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu17),",","",.)) if source_year==2017
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2017
replace st_val_ctdacu=5 if source_year==2017 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu17)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu18),",","",.)) if source_year==2018
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2018
replace st_val_ctdacu=5 if source_year==2018 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu18)),"","***",".","NA","N/A","NULL","-")
replace val_ctdacu=real(subinstr(strtrim(raw_ctdacu19),",","",.)) if source_year==2019
replace st_val_ctdacu=cond(missing(val_ctdacu),3,cond(val_ctdacu<0,2,cond(val_ctdacu==0,1,0))) if source_year==2019
replace st_val_ctdacu=5 if source_year==2019 & missing(val_ctdacu) & !inlist(upper(strtrim(raw_ctdacu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_ctdacu G0_source_state
generate double val_ctfpcu=.
generate byte st_val_ctfpcu=4
replace val_ctfpcu=real(subinstr(strtrim(raw_ctfpcu20),",","",.)) if source_year==2020
replace st_val_ctfpcu=cond(missing(val_ctfpcu),3,cond(val_ctfpcu<0,2,cond(val_ctfpcu==0,1,0))) if source_year==2020
replace st_val_ctfpcu=5 if source_year==2020 & missing(val_ctfpcu) & !inlist(upper(strtrim(raw_ctfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ctfpcu=real(subinstr(strtrim(raw_ctfpcu21),",","",.)) if source_year==2021
replace st_val_ctfpcu=cond(missing(val_ctfpcu),3,cond(val_ctfpcu<0,2,cond(val_ctfpcu==0,1,0))) if source_year==2021
replace st_val_ctfpcu=5 if source_year==2021 & missing(val_ctfpcu) & !inlist(upper(strtrim(raw_ctfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ctfpcu=real(subinstr(strtrim(raw_ctfpcu22),",","",.)) if source_year==2022
replace st_val_ctfpcu=cond(missing(val_ctfpcu),3,cond(val_ctfpcu<0,2,cond(val_ctfpcu==0,1,0))) if source_year==2022
replace st_val_ctfpcu=5 if source_year==2022 & missing(val_ctfpcu) & !inlist(upper(strtrim(raw_ctfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ctfpcu G0_source_state
generate double val_ctsacu=.
generate byte st_val_ctsacu=4
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu10),",","",.)) if source_year==2010
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2010
replace st_val_ctsacu=5 if source_year==2010 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu10)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu11),",","",.)) if source_year==2011
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2011
replace st_val_ctsacu=5 if source_year==2011 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu11)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu12),",","",.)) if source_year==2012
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2012
replace st_val_ctsacu=5 if source_year==2012 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu12)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu13),",","",.)) if source_year==2013
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2013
replace st_val_ctsacu=5 if source_year==2013 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu13)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu14),",","",.)) if source_year==2014
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2014
replace st_val_ctsacu=5 if source_year==2014 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu14)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu),",","",.)) if source_year==2015
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2015
replace st_val_ctsacu=5 if source_year==2015 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu17),",","",.)) if source_year==2017
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2017
replace st_val_ctsacu=5 if source_year==2017 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu17)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu18),",","",.)) if source_year==2018
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2018
replace st_val_ctsacu=5 if source_year==2018 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu18)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu19),",","",.)) if source_year==2019
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2019
replace st_val_ctsacu=5 if source_year==2019 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu19)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu20),",","",.)) if source_year==2020
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2020
replace st_val_ctsacu=5 if source_year==2020 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu20)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu21),",","",.)) if source_year==2021
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2021
replace st_val_ctsacu=5 if source_year==2021 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu21)),"","***",".","NA","N/A","NULL","-")
replace val_ctsacu=real(subinstr(strtrim(raw_ctsacu22),",","",.)) if source_year==2022
replace st_val_ctsacu=cond(missing(val_ctsacu),3,cond(val_ctsacu<0,2,cond(val_ctsacu==0,1,0))) if source_year==2022
replace st_val_ctsacu=5 if source_year==2022 & missing(val_ctsacu) & !inlist(upper(strtrim(raw_ctsacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ctsacu G0_source_state
generate double val_cttcu=.
generate byte st_val_cttcu=4
replace val_cttcu=real(subinstr(strtrim(raw_cttcu),",","",.)) if source_year==2015
replace st_val_cttcu=cond(missing(val_cttcu),3,cond(val_cttcu<0,2,cond(val_cttcu==0,1,0))) if source_year==2015
replace st_val_cttcu=5 if source_year==2015 & missing(val_cttcu) & !inlist(upper(strtrim(raw_cttcu)),"","***",".","NA","N/A","NULL","-")
label values st_val_cttcu G0_source_state
generate double val_ctttcu=.
generate byte st_val_ctttcu=4
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu10),",","",.)) if source_year==2010
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2010
replace st_val_ctttcu=5 if source_year==2010 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu10)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu11),",","",.)) if source_year==2011
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2011
replace st_val_ctttcu=5 if source_year==2011 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu11)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu12),",","",.)) if source_year==2012
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2012
replace st_val_ctttcu=5 if source_year==2012 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu12)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu13),",","",.)) if source_year==2013
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2013
replace st_val_ctttcu=5 if source_year==2013 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu13)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu14),",","",.)) if source_year==2014
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2014
replace st_val_ctttcu=5 if source_year==2014 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu14)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu17),",","",.)) if source_year==2017
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2017
replace st_val_ctttcu=5 if source_year==2017 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu18),",","",.)) if source_year==2018
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2018
replace st_val_ctttcu=5 if source_year==2018 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu19),",","",.)) if source_year==2019
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2019
replace st_val_ctttcu=5 if source_year==2019 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu20),",","",.)) if source_year==2020
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2020
replace st_val_ctttcu=5 if source_year==2020 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu21),",","",.)) if source_year==2021
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2021
replace st_val_ctttcu=5 if source_year==2021 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ctttcu=real(subinstr(strtrim(raw_ctttcu22),",","",.)) if source_year==2022
replace st_val_ctttcu=cond(missing(val_ctttcu),3,cond(val_ctttcu<0,2,cond(val_ctttcu==0,1,0))) if source_year==2022
replace st_val_ctttcu=5 if source_year==2022 & missing(val_ctttcu) & !inlist(upper(strtrim(raw_ctttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ctttcu G0_source_state
generate double val_cvdacu=.
generate byte st_val_cvdacu=4
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu10),",","",.)) if source_year==2010
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2010
replace st_val_cvdacu=5 if source_year==2010 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu11),",","",.)) if source_year==2011
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2011
replace st_val_cvdacu=5 if source_year==2011 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu12),",","",.)) if source_year==2012
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2012
replace st_val_cvdacu=5 if source_year==2012 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu13),",","",.)) if source_year==2013
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2013
replace st_val_cvdacu=5 if source_year==2013 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu14),",","",.)) if source_year==2014
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2014
replace st_val_cvdacu=5 if source_year==2014 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu17),",","",.)) if source_year==2017
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2017
replace st_val_cvdacu=5 if source_year==2017 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu18),",","",.)) if source_year==2018
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2018
replace st_val_cvdacu=5 if source_year==2018 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cvdacu=real(subinstr(strtrim(raw_cvdacu19),",","",.)) if source_year==2019
replace st_val_cvdacu=cond(missing(val_cvdacu),3,cond(val_cvdacu<0,2,cond(val_cvdacu==0,1,0))) if source_year==2019
replace st_val_cvdacu=5 if source_year==2019 & missing(val_cvdacu) & !inlist(upper(strtrim(raw_cvdacu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_cvdacu G0_source_state
generate double val_cvfpcu=.
generate byte st_val_cvfpcu=4
replace val_cvfpcu=real(subinstr(strtrim(raw_cvfpcu20),",","",.)) if source_year==2020
replace st_val_cvfpcu=cond(missing(val_cvfpcu),3,cond(val_cvfpcu<0,2,cond(val_cvfpcu==0,1,0))) if source_year==2020
replace st_val_cvfpcu=5 if source_year==2020 & missing(val_cvfpcu) & !inlist(upper(strtrim(raw_cvfpcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cvfpcu=real(subinstr(strtrim(raw_cvfpcu21),",","",.)) if source_year==2021
replace st_val_cvfpcu=cond(missing(val_cvfpcu),3,cond(val_cvfpcu<0,2,cond(val_cvfpcu==0,1,0))) if source_year==2021
replace st_val_cvfpcu=5 if source_year==2021 & missing(val_cvfpcu) & !inlist(upper(strtrim(raw_cvfpcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cvfpcu=real(subinstr(strtrim(raw_cvfpcu22),",","",.)) if source_year==2022
replace st_val_cvfpcu=cond(missing(val_cvfpcu),3,cond(val_cvfpcu<0,2,cond(val_cvfpcu==0,1,0))) if source_year==2022
replace st_val_cvfpcu=5 if source_year==2022 & missing(val_cvfpcu) & !inlist(upper(strtrim(raw_cvfpcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cvfpcu G0_source_state
generate double val_cvsacu=.
generate byte st_val_cvsacu=4
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu10),",","",.)) if source_year==2010
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2010
replace st_val_cvsacu=5 if source_year==2010 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu10)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu11),",","",.)) if source_year==2011
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2011
replace st_val_cvsacu=5 if source_year==2011 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu11)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu12),",","",.)) if source_year==2012
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2012
replace st_val_cvsacu=5 if source_year==2012 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu12)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu13),",","",.)) if source_year==2013
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2013
replace st_val_cvsacu=5 if source_year==2013 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu13)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu14),",","",.)) if source_year==2014
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2014
replace st_val_cvsacu=5 if source_year==2014 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu14)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu),",","",.)) if source_year==2015
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2015
replace st_val_cvsacu=5 if source_year==2015 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu17),",","",.)) if source_year==2017
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2017
replace st_val_cvsacu=5 if source_year==2017 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu17)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu18),",","",.)) if source_year==2018
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2018
replace st_val_cvsacu=5 if source_year==2018 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu18)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu19),",","",.)) if source_year==2019
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2019
replace st_val_cvsacu=5 if source_year==2019 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu19)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu20),",","",.)) if source_year==2020
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2020
replace st_val_cvsacu=5 if source_year==2020 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu20)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu21),",","",.)) if source_year==2021
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2021
replace st_val_cvsacu=5 if source_year==2021 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu21)),"","***",".","NA","N/A","NULL","-")
replace val_cvsacu=real(subinstr(strtrim(raw_cvsacu22),",","",.)) if source_year==2022
replace st_val_cvsacu=cond(missing(val_cvsacu),3,cond(val_cvsacu<0,2,cond(val_cvsacu==0,1,0))) if source_year==2022
replace st_val_cvsacu=5 if source_year==2022 & missing(val_cvsacu) & !inlist(upper(strtrim(raw_cvsacu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cvsacu G0_source_state
generate double val_cvttcu=.
generate byte st_val_cvttcu=4
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu10),",","",.)) if source_year==2010
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2010
replace st_val_cvttcu=5 if source_year==2010 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu10)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu11),",","",.)) if source_year==2011
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2011
replace st_val_cvttcu=5 if source_year==2011 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu11)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu12),",","",.)) if source_year==2012
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2012
replace st_val_cvttcu=5 if source_year==2012 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu12)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu13),",","",.)) if source_year==2013
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2013
replace st_val_cvttcu=5 if source_year==2013 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu13)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu14),",","",.)) if source_year==2014
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2014
replace st_val_cvttcu=5 if source_year==2014 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu14)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu),",","",.)) if source_year==2015
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2015
replace st_val_cvttcu=5 if source_year==2015 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu17),",","",.)) if source_year==2017
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2017
replace st_val_cvttcu=5 if source_year==2017 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu17)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu18),",","",.)) if source_year==2018
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2018
replace st_val_cvttcu=5 if source_year==2018 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu18)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu19),",","",.)) if source_year==2019
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2019
replace st_val_cvttcu=5 if source_year==2019 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu19)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu20),",","",.)) if source_year==2020
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2020
replace st_val_cvttcu=5 if source_year==2020 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu20)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu21),",","",.)) if source_year==2021
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2021
replace st_val_cvttcu=5 if source_year==2021 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu21)),"","***",".","NA","N/A","NULL","-")
replace val_cvttcu=real(subinstr(strtrim(raw_cvttcu22),",","",.)) if source_year==2022
replace st_val_cvttcu=cond(missing(val_cvttcu),3,cond(val_cvttcu<0,2,cond(val_cvttcu==0,1,0))) if source_year==2022
replace st_val_cvttcu=5 if source_year==2022 & missing(val_cvttcu) & !inlist(upper(strtrim(raw_cvttcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_cvttcu G0_source_state
generate double val_devvcu=.
generate byte st_val_devvcu=4
replace val_devvcu=real(subinstr(strtrim(raw_devvcu17),",","",.)) if source_year==2017
replace st_val_devvcu=cond(missing(val_devvcu),3,cond(val_devvcu<0,2,cond(val_devvcu==0,1,0))) if source_year==2017
replace st_val_devvcu=5 if source_year==2017 & missing(val_devvcu) & !inlist(upper(strtrim(raw_devvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_devvcu=real(subinstr(strtrim(raw_devvcu18),",","",.)) if source_year==2018
replace st_val_devvcu=cond(missing(val_devvcu),3,cond(val_devvcu<0,2,cond(val_devvcu==0,1,0))) if source_year==2018
replace st_val_devvcu=5 if source_year==2018 & missing(val_devvcu) & !inlist(upper(strtrim(raw_devvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_devvcu=real(subinstr(strtrim(raw_devvcu19),",","",.)) if source_year==2019
replace st_val_devvcu=cond(missing(val_devvcu),3,cond(val_devvcu<0,2,cond(val_devvcu==0,1,0))) if source_year==2019
replace st_val_devvcu=5 if source_year==2019 & missing(val_devvcu) & !inlist(upper(strtrim(raw_devvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_devvcu G0_source_state
generate double val_ecavce=.
generate byte st_val_ecavce=4
replace val_ecavce=real(subinstr(strtrim(raw_ecavce20),",","",.)) if source_year==2020
replace st_val_ecavce=cond(missing(val_ecavce),3,cond(val_ecavce<0,2,cond(val_ecavce==0,1,0))) if source_year==2020
replace st_val_ecavce=5 if source_year==2020 & missing(val_ecavce) & !inlist(upper(strtrim(raw_ecavce20)),"","***",".","NA","N/A","NULL","-")
replace val_ecavce=real(subinstr(strtrim(raw_ecavce21),",","",.)) if source_year==2021
replace st_val_ecavce=cond(missing(val_ecavce),3,cond(val_ecavce<0,2,cond(val_ecavce==0,1,0))) if source_year==2021
replace st_val_ecavce=5 if source_year==2021 & missing(val_ecavce) & !inlist(upper(strtrim(raw_ecavce21)),"","***",".","NA","N/A","NULL","-")
replace val_ecavce=real(subinstr(strtrim(raw_ecavce22),",","",.)) if source_year==2022
replace st_val_ecavce=cond(missing(val_ecavce),3,cond(val_ecavce<0,2,cond(val_ecavce==0,1,0))) if source_year==2022
replace st_val_ecavce=5 if source_year==2022 & missing(val_ecavce) & !inlist(upper(strtrim(raw_ecavce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ecavce G0_source_state
generate double val_ecavcu=.
generate byte st_val_ecavcu=4
replace val_ecavcu=real(subinstr(strtrim(raw_ecavcu20),",","",.)) if source_year==2020
replace st_val_ecavcu=cond(missing(val_ecavcu),3,cond(val_ecavcu<0,2,cond(val_ecavcu==0,1,0))) if source_year==2020
replace st_val_ecavcu=5 if source_year==2020 & missing(val_ecavcu) & !inlist(upper(strtrim(raw_ecavcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ecavcu=real(subinstr(strtrim(raw_ecavcu21),",","",.)) if source_year==2021
replace st_val_ecavcu=cond(missing(val_ecavcu),3,cond(val_ecavcu<0,2,cond(val_ecavcu==0,1,0))) if source_year==2021
replace st_val_ecavcu=5 if source_year==2021 & missing(val_ecavcu) & !inlist(upper(strtrim(raw_ecavcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ecavcu=real(subinstr(strtrim(raw_ecavcu22),",","",.)) if source_year==2022
replace st_val_ecavcu=cond(missing(val_ecavcu),3,cond(val_ecavcu<0,2,cond(val_ecavcu==0,1,0))) if source_year==2022
replace st_val_ecavcu=5 if source_year==2022 & missing(val_ecavcu) & !inlist(upper(strtrim(raw_ecavcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ecavcu G0_source_state
generate double val_ecbvce=.
generate byte st_val_ecbvce=4
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce12),",","",.)) if source_year==2012
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2012
replace st_val_ecbvce=5 if source_year==2012 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce12)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce13),",","",.)) if source_year==2013
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2013
replace st_val_ecbvce=5 if source_year==2013 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce13)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce14),",","",.)) if source_year==2014
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2014
replace st_val_ecbvce=5 if source_year==2014 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce14)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce17),",","",.)) if source_year==2017
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2017
replace st_val_ecbvce=5 if source_year==2017 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce17)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce19),",","",.)) if source_year==2019
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2019
replace st_val_ecbvce=5 if source_year==2019 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce19)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce20),",","",.)) if source_year==2020
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2020
replace st_val_ecbvce=5 if source_year==2020 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce20)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce21),",","",.)) if source_year==2021
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2021
replace st_val_ecbvce=5 if source_year==2021 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce21)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvce=real(subinstr(strtrim(raw_ecbvce),",","",.)) if source_year==2022
replace st_val_ecbvce=cond(missing(val_ecbvce),3,cond(val_ecbvce<0,2,cond(val_ecbvce==0,1,0))) if source_year==2022
replace st_val_ecbvce=5 if source_year==2022 & missing(val_ecbvce) & !inlist(upper(strtrim(raw_ecbvce)),"","***",".","NA","N/A","NULL","-")
label values st_val_ecbvce G0_source_state
generate double val_ecbvcu=.
generate byte st_val_ecbvcu=4
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu12),",","",.)) if source_year==2012
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2012
replace st_val_ecbvcu=5 if source_year==2012 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu13),",","",.)) if source_year==2013
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2013
replace st_val_ecbvcu=5 if source_year==2013 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu14),",","",.)) if source_year==2014
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2014
replace st_val_ecbvcu=5 if source_year==2014 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu17),",","",.)) if source_year==2017
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2017
replace st_val_ecbvcu=5 if source_year==2017 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu18),",","",.)) if source_year==2018
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2018
replace st_val_ecbvcu=5 if source_year==2018 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu19),",","",.)) if source_year==2019
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2019
replace st_val_ecbvcu=5 if source_year==2019 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu20),",","",.)) if source_year==2020
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2020
replace st_val_ecbvcu=5 if source_year==2020 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu21),",","",.)) if source_year==2021
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2021
replace st_val_ecbvcu=5 if source_year==2021 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ecbvcu=real(subinstr(strtrim(raw_ecbvcu22),",","",.)) if source_year==2022
replace st_val_ecbvcu=cond(missing(val_ecbvcu),3,cond(val_ecbvcu<0,2,cond(val_ecbvcu==0,1,0))) if source_year==2022
replace st_val_ecbvcu=5 if source_year==2022 & missing(val_ecbvcu) & !inlist(upper(strtrim(raw_ecbvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ecbvcu G0_source_state
generate double val_eckvce=.
generate byte st_val_eckvce=4
replace val_eckvce=real(subinstr(strtrim(raw_eckvce22),",","",.)) if source_year==2022
replace st_val_eckvce=cond(missing(val_eckvce),3,cond(val_eckvce<0,2,cond(val_eckvce==0,1,0))) if source_year==2022
replace st_val_eckvce=5 if source_year==2022 & missing(val_eckvce) & !inlist(upper(strtrim(raw_eckvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eckvce G0_source_state
generate double val_eckvcu=.
generate byte st_val_eckvcu=4
replace val_eckvcu=real(subinstr(strtrim(raw_eckvcu22),",","",.)) if source_year==2022
replace st_val_eckvcu=cond(missing(val_eckvcu),3,cond(val_eckvcu<0,2,cond(val_eckvcu==0,1,0))) if source_year==2022
replace st_val_eckvcu=5 if source_year==2022 & missing(val_eckvcu) & !inlist(upper(strtrim(raw_eckvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eckvcu G0_source_state
generate double val_eclvce=.
generate byte st_val_eclvce=4
replace val_eclvce=real(subinstr(strtrim(raw_eclvce10),",","",.)) if source_year==2010
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2010
replace st_val_eclvce=5 if source_year==2010 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce10)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce11),",","",.)) if source_year==2011
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2011
replace st_val_eclvce=5 if source_year==2011 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce11)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce12),",","",.)) if source_year==2012
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2012
replace st_val_eclvce=5 if source_year==2012 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce12)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce13),",","",.)) if source_year==2013
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2013
replace st_val_eclvce=5 if source_year==2013 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce13)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce14),",","",.)) if source_year==2014
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2014
replace st_val_eclvce=5 if source_year==2014 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce14)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce),",","",.)) if source_year==2015
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2015
replace st_val_eclvce=5 if source_year==2015 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce17),",","",.)) if source_year==2017
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2017
replace st_val_eclvce=5 if source_year==2017 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce17)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce18),",","",.)) if source_year==2018
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2018
replace st_val_eclvce=5 if source_year==2018 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce18)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce19),",","",.)) if source_year==2019
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2019
replace st_val_eclvce=5 if source_year==2019 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce19)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce20),",","",.)) if source_year==2020
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2020
replace st_val_eclvce=5 if source_year==2020 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce20)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce21),",","",.)) if source_year==2021
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2021
replace st_val_eclvce=5 if source_year==2021 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce21)),"","***",".","NA","N/A","NULL","-")
replace val_eclvce=real(subinstr(strtrim(raw_eclvce22),",","",.)) if source_year==2022
replace st_val_eclvce=cond(missing(val_eclvce),3,cond(val_eclvce<0,2,cond(val_eclvce==0,1,0))) if source_year==2022
replace st_val_eclvce=5 if source_year==2022 & missing(val_eclvce) & !inlist(upper(strtrim(raw_eclvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eclvce G0_source_state
generate double val_eclvcu=.
generate byte st_val_eclvcu=4
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu10),",","",.)) if source_year==2010
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2010
replace st_val_eclvcu=5 if source_year==2010 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu11),",","",.)) if source_year==2011
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2011
replace st_val_eclvcu=5 if source_year==2011 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu12),",","",.)) if source_year==2012
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2012
replace st_val_eclvcu=5 if source_year==2012 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu13),",","",.)) if source_year==2013
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2013
replace st_val_eclvcu=5 if source_year==2013 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu14),",","",.)) if source_year==2014
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2014
replace st_val_eclvcu=5 if source_year==2014 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu),",","",.)) if source_year==2015
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2015
replace st_val_eclvcu=5 if source_year==2015 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu17),",","",.)) if source_year==2017
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2017
replace st_val_eclvcu=5 if source_year==2017 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu18),",","",.)) if source_year==2018
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2018
replace st_val_eclvcu=5 if source_year==2018 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu19),",","",.)) if source_year==2019
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2019
replace st_val_eclvcu=5 if source_year==2019 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu20),",","",.)) if source_year==2020
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2020
replace st_val_eclvcu=5 if source_year==2020 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu21),",","",.)) if source_year==2021
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2021
replace st_val_eclvcu=5 if source_year==2021 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_eclvcu=real(subinstr(strtrim(raw_eclvcu22),",","",.)) if source_year==2022
replace st_val_eclvcu=cond(missing(val_eclvcu),3,cond(val_eclvcu<0,2,cond(val_eclvcu==0,1,0))) if source_year==2022
replace st_val_eclvcu=5 if source_year==2022 & missing(val_eclvcu) & !inlist(upper(strtrim(raw_eclvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eclvcu G0_source_state
generate double val_edivce=.
generate byte st_val_edivce=4
replace val_edivce=real(subinstr(strtrim(raw_edivce20),",","",.)) if source_year==2020
replace st_val_edivce=cond(missing(val_edivce),3,cond(val_edivce<0,2,cond(val_edivce==0,1,0))) if source_year==2020
replace st_val_edivce=5 if source_year==2020 & missing(val_edivce) & !inlist(upper(strtrim(raw_edivce20)),"","***",".","NA","N/A","NULL","-")
replace val_edivce=real(subinstr(strtrim(raw_edivce21),",","",.)) if source_year==2021
replace st_val_edivce=cond(missing(val_edivce),3,cond(val_edivce<0,2,cond(val_edivce==0,1,0))) if source_year==2021
replace st_val_edivce=5 if source_year==2021 & missing(val_edivce) & !inlist(upper(strtrim(raw_edivce21)),"","***",".","NA","N/A","NULL","-")
replace val_edivce=real(subinstr(strtrim(raw_edivce22),",","",.)) if source_year==2022
replace st_val_edivce=cond(missing(val_edivce),3,cond(val_edivce<0,2,cond(val_edivce==0,1,0))) if source_year==2022
replace st_val_edivce=5 if source_year==2022 & missing(val_edivce) & !inlist(upper(strtrim(raw_edivce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_edivce G0_source_state
generate double val_edivcu=.
generate byte st_val_edivcu=4
replace val_edivcu=real(subinstr(strtrim(raw_edivcu20),",","",.)) if source_year==2020
replace st_val_edivcu=cond(missing(val_edivcu),3,cond(val_edivcu<0,2,cond(val_edivcu==0,1,0))) if source_year==2020
replace st_val_edivcu=5 if source_year==2020 & missing(val_edivcu) & !inlist(upper(strtrim(raw_edivcu20)),"","***",".","NA","N/A","NULL","-")
replace val_edivcu=real(subinstr(strtrim(raw_edivcu21),",","",.)) if source_year==2021
replace st_val_edivcu=cond(missing(val_edivcu),3,cond(val_edivcu<0,2,cond(val_edivcu==0,1,0))) if source_year==2021
replace st_val_edivcu=5 if source_year==2021 & missing(val_edivcu) & !inlist(upper(strtrim(raw_edivcu21)),"","***",".","NA","N/A","NULL","-")
replace val_edivcu=real(subinstr(strtrim(raw_edivcu22),",","",.)) if source_year==2022
replace st_val_edivcu=cond(missing(val_edivcu),3,cond(val_edivcu<0,2,cond(val_edivcu==0,1,0))) if source_year==2022
replace st_val_edivcu=5 if source_year==2022 & missing(val_edivcu) & !inlist(upper(strtrim(raw_edivcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_edivcu G0_source_state
generate double val_efovce=.
generate byte st_val_efovce=4
replace val_efovce=real(subinstr(strtrim(raw_efovce20),",","",.)) if source_year==2020
replace st_val_efovce=cond(missing(val_efovce),3,cond(val_efovce<0,2,cond(val_efovce==0,1,0))) if source_year==2020
replace st_val_efovce=5 if source_year==2020 & missing(val_efovce) & !inlist(upper(strtrim(raw_efovce20)),"","***",".","NA","N/A","NULL","-")
replace val_efovce=real(subinstr(strtrim(raw_efovce21),",","",.)) if source_year==2021
replace st_val_efovce=cond(missing(val_efovce),3,cond(val_efovce<0,2,cond(val_efovce==0,1,0))) if source_year==2021
replace st_val_efovce=5 if source_year==2021 & missing(val_efovce) & !inlist(upper(strtrim(raw_efovce21)),"","***",".","NA","N/A","NULL","-")
replace val_efovce=real(subinstr(strtrim(raw_efovce22),",","",.)) if source_year==2022
replace st_val_efovce=cond(missing(val_efovce),3,cond(val_efovce<0,2,cond(val_efovce==0,1,0))) if source_year==2022
replace st_val_efovce=5 if source_year==2022 & missing(val_efovce) & !inlist(upper(strtrim(raw_efovce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_efovce G0_source_state
generate double val_efovcu=.
generate byte st_val_efovcu=4
replace val_efovcu=real(subinstr(strtrim(raw_efovcu20),",","",.)) if source_year==2020
replace st_val_efovcu=cond(missing(val_efovcu),3,cond(val_efovcu<0,2,cond(val_efovcu==0,1,0))) if source_year==2020
replace st_val_efovcu=5 if source_year==2020 & missing(val_efovcu) & !inlist(upper(strtrim(raw_efovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_efovcu=real(subinstr(strtrim(raw_efovcu21),",","",.)) if source_year==2021
replace st_val_efovcu=cond(missing(val_efovcu),3,cond(val_efovcu<0,2,cond(val_efovcu==0,1,0))) if source_year==2021
replace st_val_efovcu=5 if source_year==2021 & missing(val_efovcu) & !inlist(upper(strtrim(raw_efovcu21)),"","***",".","NA","N/A","NULL","-")
replace val_efovcu=real(subinstr(strtrim(raw_efovcu22),",","",.)) if source_year==2022
replace st_val_efovcu=cond(missing(val_efovcu),3,cond(val_efovcu<0,2,cond(val_efovcu==0,1,0))) if source_year==2022
replace st_val_efovcu=5 if source_year==2022 & missing(val_efovcu) & !inlist(upper(strtrim(raw_efovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_efovcu G0_source_state
generate double val_efuvce=.
generate byte st_val_efuvce=4
replace val_efuvce=real(subinstr(strtrim(raw_efuvce10),",","",.)) if source_year==2010
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2010
replace st_val_efuvce=5 if source_year==2010 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce10)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce11),",","",.)) if source_year==2011
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2011
replace st_val_efuvce=5 if source_year==2011 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce11)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce12),",","",.)) if source_year==2012
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2012
replace st_val_efuvce=5 if source_year==2012 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce12)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce13),",","",.)) if source_year==2013
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2013
replace st_val_efuvce=5 if source_year==2013 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce13)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce14),",","",.)) if source_year==2014
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2014
replace st_val_efuvce=5 if source_year==2014 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce14)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce),",","",.)) if source_year==2015
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2015
replace st_val_efuvce=5 if source_year==2015 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce17),",","",.)) if source_year==2017
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2017
replace st_val_efuvce=5 if source_year==2017 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce17)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce18),",","",.)) if source_year==2018
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2018
replace st_val_efuvce=5 if source_year==2018 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce18)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce19),",","",.)) if source_year==2019
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2019
replace st_val_efuvce=5 if source_year==2019 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce19)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce20),",","",.)) if source_year==2020
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2020
replace st_val_efuvce=5 if source_year==2020 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce20)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce21),",","",.)) if source_year==2021
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2021
replace st_val_efuvce=5 if source_year==2021 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce21)),"","***",".","NA","N/A","NULL","-")
replace val_efuvce=real(subinstr(strtrim(raw_efuvce22),",","",.)) if source_year==2022
replace st_val_efuvce=cond(missing(val_efuvce),3,cond(val_efuvce<0,2,cond(val_efuvce==0,1,0))) if source_year==2022
replace st_val_efuvce=5 if source_year==2022 & missing(val_efuvce) & !inlist(upper(strtrim(raw_efuvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_efuvce G0_source_state
generate double val_efuvcu=.
generate byte st_val_efuvcu=4
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu10),",","",.)) if source_year==2010
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2010
replace st_val_efuvcu=5 if source_year==2010 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu11),",","",.)) if source_year==2011
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2011
replace st_val_efuvcu=5 if source_year==2011 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu12),",","",.)) if source_year==2012
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2012
replace st_val_efuvcu=5 if source_year==2012 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu13),",","",.)) if source_year==2013
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2013
replace st_val_efuvcu=5 if source_year==2013 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu14),",","",.)) if source_year==2014
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2014
replace st_val_efuvcu=5 if source_year==2014 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu),",","",.)) if source_year==2015
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2015
replace st_val_efuvcu=5 if source_year==2015 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu17),",","",.)) if source_year==2017
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2017
replace st_val_efuvcu=5 if source_year==2017 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu18),",","",.)) if source_year==2018
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2018
replace st_val_efuvcu=5 if source_year==2018 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu19),",","",.)) if source_year==2019
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2019
replace st_val_efuvcu=5 if source_year==2019 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu20),",","",.)) if source_year==2020
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2020
replace st_val_efuvcu=5 if source_year==2020 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu21),",","",.)) if source_year==2021
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2021
replace st_val_efuvcu=5 if source_year==2021 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_efuvcu=real(subinstr(strtrim(raw_efuvcu22),",","",.)) if source_year==2022
replace st_val_efuvcu=cond(missing(val_efuvcu),3,cond(val_efuvcu<0,2,cond(val_efuvcu==0,1,0))) if source_year==2022
replace st_val_efuvcu=5 if source_year==2022 & missing(val_efuvcu) & !inlist(upper(strtrim(raw_efuvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_efuvcu G0_source_state
generate double val_egavce=.
generate byte st_val_egavce=4
replace val_egavce=real(subinstr(strtrim(raw_egavce10),",","",.)) if source_year==2010
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2010
replace st_val_egavce=5 if source_year==2010 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce10)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce11),",","",.)) if source_year==2011
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2011
replace st_val_egavce=5 if source_year==2011 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce11)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce12),",","",.)) if source_year==2012
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2012
replace st_val_egavce=5 if source_year==2012 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce12)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce13),",","",.)) if source_year==2013
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2013
replace st_val_egavce=5 if source_year==2013 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce13)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce14),",","",.)) if source_year==2014
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2014
replace st_val_egavce=5 if source_year==2014 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce14)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce),",","",.)) if source_year==2015
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2015
replace st_val_egavce=5 if source_year==2015 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce17),",","",.)) if source_year==2017
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2017
replace st_val_egavce=5 if source_year==2017 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce17)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce18),",","",.)) if source_year==2018
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2018
replace st_val_egavce=5 if source_year==2018 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce18)),"","***",".","NA","N/A","NULL","-")
replace val_egavce=real(subinstr(strtrim(raw_egavce19),",","",.)) if source_year==2019
replace st_val_egavce=cond(missing(val_egavce),3,cond(val_egavce<0,2,cond(val_egavce==0,1,0))) if source_year==2019
replace st_val_egavce=5 if source_year==2019 & missing(val_egavce) & !inlist(upper(strtrim(raw_egavce19)),"","***",".","NA","N/A","NULL","-")
label values st_val_egavce G0_source_state
generate double val_egavcu=.
generate byte st_val_egavcu=4
replace val_egavcu=real(subinstr(strtrim(raw_egavcu10),",","",.)) if source_year==2010
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2010
replace st_val_egavcu=5 if source_year==2010 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu10)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu11),",","",.)) if source_year==2011
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2011
replace st_val_egavcu=5 if source_year==2011 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu11)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu12),",","",.)) if source_year==2012
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2012
replace st_val_egavcu=5 if source_year==2012 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu12)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu13),",","",.)) if source_year==2013
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2013
replace st_val_egavcu=5 if source_year==2013 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu13)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu14),",","",.)) if source_year==2014
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2014
replace st_val_egavcu=5 if source_year==2014 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu14)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu),",","",.)) if source_year==2015
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2015
replace st_val_egavcu=5 if source_year==2015 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu17),",","",.)) if source_year==2017
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2017
replace st_val_egavcu=5 if source_year==2017 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu17)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu18),",","",.)) if source_year==2018
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2018
replace st_val_egavcu=5 if source_year==2018 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu18)),"","***",".","NA","N/A","NULL","-")
replace val_egavcu=real(subinstr(strtrim(raw_egavcu19),",","",.)) if source_year==2019
replace st_val_egavcu=cond(missing(val_egavcu),3,cond(val_egavcu<0,2,cond(val_egavcu==0,1,0))) if source_year==2019
replace st_val_egavcu=5 if source_year==2019 & missing(val_egavcu) & !inlist(upper(strtrim(raw_egavcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_egavcu G0_source_state
generate double val_egovce=.
generate byte st_val_egovce=4
replace val_egovce=real(subinstr(strtrim(raw_egovce12),",","",.)) if source_year==2012
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2012
replace st_val_egovce=5 if source_year==2012 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce12)),"","***",".","NA","N/A","NULL","-")
replace val_egovce=real(subinstr(strtrim(raw_egovce13),",","",.)) if source_year==2013
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2013
replace st_val_egovce=5 if source_year==2013 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce13)),"","***",".","NA","N/A","NULL","-")
replace val_egovce=real(subinstr(strtrim(raw_egovce14),",","",.)) if source_year==2014
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2014
replace st_val_egovce=5 if source_year==2014 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce14)),"","***",".","NA","N/A","NULL","-")
replace val_egovce=real(subinstr(strtrim(raw_egovce17),",","",.)) if source_year==2017
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2017
replace st_val_egovce=5 if source_year==2017 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce17)),"","***",".","NA","N/A","NULL","-")
replace val_egovce=real(subinstr(strtrim(raw_egovce18),",","",.)) if source_year==2018
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2018
replace st_val_egovce=5 if source_year==2018 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce18)),"","***",".","NA","N/A","NULL","-")
replace val_egovce=real(subinstr(strtrim(raw_egovce19),",","",.)) if source_year==2019
replace st_val_egovce=cond(missing(val_egovce),3,cond(val_egovce<0,2,cond(val_egovce==0,1,0))) if source_year==2019
replace st_val_egovce=5 if source_year==2019 & missing(val_egovce) & !inlist(upper(strtrim(raw_egovce19)),"","***",".","NA","N/A","NULL","-")
label values st_val_egovce G0_source_state
generate double val_egovcu=.
generate byte st_val_egovcu=4
replace val_egovcu=real(subinstr(strtrim(raw_egovcu12),",","",.)) if source_year==2012
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2012
replace st_val_egovcu=5 if source_year==2012 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu12)),"","***",".","NA","N/A","NULL","-")
replace val_egovcu=real(subinstr(strtrim(raw_egovcu13),",","",.)) if source_year==2013
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2013
replace st_val_egovcu=5 if source_year==2013 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu13)),"","***",".","NA","N/A","NULL","-")
replace val_egovcu=real(subinstr(strtrim(raw_egovcu14),",","",.)) if source_year==2014
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2014
replace st_val_egovcu=5 if source_year==2014 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu14)),"","***",".","NA","N/A","NULL","-")
replace val_egovcu=real(subinstr(strtrim(raw_egovcu17),",","",.)) if source_year==2017
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2017
replace st_val_egovcu=5 if source_year==2017 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu17)),"","***",".","NA","N/A","NULL","-")
replace val_egovcu=real(subinstr(strtrim(raw_egovcu18),",","",.)) if source_year==2018
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2018
replace st_val_egovcu=5 if source_year==2018 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu18)),"","***",".","NA","N/A","NULL","-")
replace val_egovcu=real(subinstr(strtrim(raw_egovcu19),",","",.)) if source_year==2019
replace st_val_egovcu=cond(missing(val_egovcu),3,cond(val_egovcu<0,2,cond(val_egovcu==0,1,0))) if source_year==2019
replace st_val_egovcu=5 if source_year==2019 & missing(val_egovcu) & !inlist(upper(strtrim(raw_egovcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_egovcu G0_source_state
generate double val_elpvce=.
generate byte st_val_elpvce=4
replace val_elpvce=real(subinstr(strtrim(raw_elpvce10),",","",.)) if source_year==2010
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2010
replace st_val_elpvce=5 if source_year==2010 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce10)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce11),",","",.)) if source_year==2011
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2011
replace st_val_elpvce=5 if source_year==2011 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce11)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce12),",","",.)) if source_year==2012
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2012
replace st_val_elpvce=5 if source_year==2012 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce12)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce13),",","",.)) if source_year==2013
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2013
replace st_val_elpvce=5 if source_year==2013 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce13)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce14),",","",.)) if source_year==2014
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2014
replace st_val_elpvce=5 if source_year==2014 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce14)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce),",","",.)) if source_year==2015
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2015
replace st_val_elpvce=5 if source_year==2015 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce17),",","",.)) if source_year==2017
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2017
replace st_val_elpvce=5 if source_year==2017 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce17)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce19),",","",.)) if source_year==2019
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2019
replace st_val_elpvce=5 if source_year==2019 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce19)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce20),",","",.)) if source_year==2020
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2020
replace st_val_elpvce=5 if source_year==2020 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce20)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce21),",","",.)) if source_year==2021
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2021
replace st_val_elpvce=5 if source_year==2021 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce21)),"","***",".","NA","N/A","NULL","-")
replace val_elpvce=real(subinstr(strtrim(raw_elpvce22),",","",.)) if source_year==2022
replace st_val_elpvce=cond(missing(val_elpvce),3,cond(val_elpvce<0,2,cond(val_elpvce==0,1,0))) if source_year==2022
replace st_val_elpvce=5 if source_year==2022 & missing(val_elpvce) & !inlist(upper(strtrim(raw_elpvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_elpvce G0_source_state
generate double val_elpvcu=.
generate byte st_val_elpvcu=4
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu10),",","",.)) if source_year==2010
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2010
replace st_val_elpvcu=5 if source_year==2010 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu11),",","",.)) if source_year==2011
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2011
replace st_val_elpvcu=5 if source_year==2011 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu12),",","",.)) if source_year==2012
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2012
replace st_val_elpvcu=5 if source_year==2012 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu13),",","",.)) if source_year==2013
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2013
replace st_val_elpvcu=5 if source_year==2013 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu14),",","",.)) if source_year==2014
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2014
replace st_val_elpvcu=5 if source_year==2014 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu),",","",.)) if source_year==2015
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2015
replace st_val_elpvcu=5 if source_year==2015 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu17),",","",.)) if source_year==2017
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2017
replace st_val_elpvcu=5 if source_year==2017 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu18),",","",.)) if source_year==2018
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2018
replace st_val_elpvcu=5 if source_year==2018 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu19),",","",.)) if source_year==2019
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2019
replace st_val_elpvcu=5 if source_year==2019 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu20),",","",.)) if source_year==2020
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2020
replace st_val_elpvcu=5 if source_year==2020 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu21),",","",.)) if source_year==2021
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2021
replace st_val_elpvcu=5 if source_year==2021 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_elpvcu=real(subinstr(strtrim(raw_elpvcu22),",","",.)) if source_year==2022
replace st_val_elpvcu=cond(missing(val_elpvcu),3,cond(val_elpvcu<0,2,cond(val_elpvcu==0,1,0))) if source_year==2022
replace st_val_elpvcu=5 if source_year==2022 & missing(val_elpvcu) & !inlist(upper(strtrim(raw_elpvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_elpvcu G0_source_state
generate double val_eluvce=.
generate byte st_val_eluvce=4
replace val_eluvce=real(subinstr(strtrim(raw_eluvce10),",","",.)) if source_year==2010
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2010
replace st_val_eluvce=5 if source_year==2010 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce10)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce11),",","",.)) if source_year==2011
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2011
replace st_val_eluvce=5 if source_year==2011 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce11)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce12),",","",.)) if source_year==2012
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2012
replace st_val_eluvce=5 if source_year==2012 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce12)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce13),",","",.)) if source_year==2013
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2013
replace st_val_eluvce=5 if source_year==2013 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce13)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce14),",","",.)) if source_year==2014
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2014
replace st_val_eluvce=5 if source_year==2014 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce14)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce),",","",.)) if source_year==2015
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2015
replace st_val_eluvce=5 if source_year==2015 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce17),",","",.)) if source_year==2017
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2017
replace st_val_eluvce=5 if source_year==2017 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce17)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce18),",","",.)) if source_year==2018
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2018
replace st_val_eluvce=5 if source_year==2018 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce18)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce19),",","",.)) if source_year==2019
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2019
replace st_val_eluvce=5 if source_year==2019 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce19)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce20),",","",.)) if source_year==2020
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2020
replace st_val_eluvce=5 if source_year==2020 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce20)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce21),",","",.)) if source_year==2021
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2021
replace st_val_eluvce=5 if source_year==2021 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce21)),"","***",".","NA","N/A","NULL","-")
replace val_eluvce=real(subinstr(strtrim(raw_eluvce22),",","",.)) if source_year==2022
replace st_val_eluvce=cond(missing(val_eluvce),3,cond(val_eluvce<0,2,cond(val_eluvce==0,1,0))) if source_year==2022
replace st_val_eluvce=5 if source_year==2022 & missing(val_eluvce) & !inlist(upper(strtrim(raw_eluvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eluvce G0_source_state
generate double val_eluvcu=.
generate byte st_val_eluvcu=4
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu10),",","",.)) if source_year==2010
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2010
replace st_val_eluvcu=5 if source_year==2010 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu11),",","",.)) if source_year==2011
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2011
replace st_val_eluvcu=5 if source_year==2011 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu12),",","",.)) if source_year==2012
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2012
replace st_val_eluvcu=5 if source_year==2012 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu13),",","",.)) if source_year==2013
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2013
replace st_val_eluvcu=5 if source_year==2013 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu14),",","",.)) if source_year==2014
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2014
replace st_val_eluvcu=5 if source_year==2014 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu),",","",.)) if source_year==2015
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2015
replace st_val_eluvcu=5 if source_year==2015 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu17),",","",.)) if source_year==2017
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2017
replace st_val_eluvcu=5 if source_year==2017 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu18),",","",.)) if source_year==2018
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2018
replace st_val_eluvcu=5 if source_year==2018 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu19),",","",.)) if source_year==2019
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2019
replace st_val_eluvcu=5 if source_year==2019 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu20),",","",.)) if source_year==2020
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2020
replace st_val_eluvcu=5 if source_year==2020 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu21),",","",.)) if source_year==2021
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2021
replace st_val_eluvcu=5 if source_year==2021 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_eluvcu=real(subinstr(strtrim(raw_eluvcu22),",","",.)) if source_year==2022
replace st_val_eluvcu=cond(missing(val_eluvcu),3,cond(val_eluvcu<0,2,cond(val_eluvcu==0,1,0))) if source_year==2022
replace st_val_eluvcu=5 if source_year==2022 & missing(val_eluvcu) & !inlist(upper(strtrim(raw_eluvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eluvcu G0_source_state
generate double val_encvce=.
generate byte st_val_encvce=4
replace val_encvce=real(subinstr(strtrim(raw_encvce10),",","",.)) if source_year==2010
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2010
replace st_val_encvce=5 if source_year==2010 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce10)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce11),",","",.)) if source_year==2011
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2011
replace st_val_encvce=5 if source_year==2011 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce11)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce12),",","",.)) if source_year==2012
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2012
replace st_val_encvce=5 if source_year==2012 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce12)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce13),",","",.)) if source_year==2013
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2013
replace st_val_encvce=5 if source_year==2013 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce13)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce14),",","",.)) if source_year==2014
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2014
replace st_val_encvce=5 if source_year==2014 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce14)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce),",","",.)) if source_year==2015
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2015
replace st_val_encvce=5 if source_year==2015 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce17),",","",.)) if source_year==2017
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2017
replace st_val_encvce=5 if source_year==2017 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce17)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce19),",","",.)) if source_year==2019
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2019
replace st_val_encvce=5 if source_year==2019 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce19)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce20),",","",.)) if source_year==2020
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2020
replace st_val_encvce=5 if source_year==2020 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce20)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce21),",","",.)) if source_year==2021
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2021
replace st_val_encvce=5 if source_year==2021 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce21)),"","***",".","NA","N/A","NULL","-")
replace val_encvce=real(subinstr(strtrim(raw_encvce22),",","",.)) if source_year==2022
replace st_val_encvce=cond(missing(val_encvce),3,cond(val_encvce<0,2,cond(val_encvce==0,1,0))) if source_year==2022
replace st_val_encvce=5 if source_year==2022 & missing(val_encvce) & !inlist(upper(strtrim(raw_encvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_encvce G0_source_state
generate double val_encvcu=.
generate byte st_val_encvcu=4
replace val_encvcu=real(subinstr(strtrim(raw_encvcu10),",","",.)) if source_year==2010
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2010
replace st_val_encvcu=5 if source_year==2010 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu11),",","",.)) if source_year==2011
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2011
replace st_val_encvcu=5 if source_year==2011 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu12),",","",.)) if source_year==2012
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2012
replace st_val_encvcu=5 if source_year==2012 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu13),",","",.)) if source_year==2013
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2013
replace st_val_encvcu=5 if source_year==2013 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu14),",","",.)) if source_year==2014
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2014
replace st_val_encvcu=5 if source_year==2014 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu),",","",.)) if source_year==2015
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2015
replace st_val_encvcu=5 if source_year==2015 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu17),",","",.)) if source_year==2017
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2017
replace st_val_encvcu=5 if source_year==2017 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu18),",","",.)) if source_year==2018
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2018
replace st_val_encvcu=5 if source_year==2018 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu19),",","",.)) if source_year==2019
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2019
replace st_val_encvcu=5 if source_year==2019 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu20),",","",.)) if source_year==2020
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2020
replace st_val_encvcu=5 if source_year==2020 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu21),",","",.)) if source_year==2021
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2021
replace st_val_encvcu=5 if source_year==2021 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_encvcu=real(subinstr(strtrim(raw_encvcu22),",","",.)) if source_year==2022
replace st_val_encvcu=cond(missing(val_encvcu),3,cond(val_encvcu<0,2,cond(val_encvcu==0,1,0))) if source_year==2022
replace st_val_encvcu=5 if source_year==2022 & missing(val_encvcu) & !inlist(upper(strtrim(raw_encvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_encvcu G0_source_state
generate double val_engvce=.
generate byte st_val_engvce=4
replace val_engvce=real(subinstr(strtrim(raw_engvce20),",","",.)) if source_year==2020
replace st_val_engvce=cond(missing(val_engvce),3,cond(val_engvce<0,2,cond(val_engvce==0,1,0))) if source_year==2020
replace st_val_engvce=5 if source_year==2020 & missing(val_engvce) & !inlist(upper(strtrim(raw_engvce20)),"","***",".","NA","N/A","NULL","-")
replace val_engvce=real(subinstr(strtrim(raw_engvce21),",","",.)) if source_year==2021
replace st_val_engvce=cond(missing(val_engvce),3,cond(val_engvce<0,2,cond(val_engvce==0,1,0))) if source_year==2021
replace st_val_engvce=5 if source_year==2021 & missing(val_engvce) & !inlist(upper(strtrim(raw_engvce21)),"","***",".","NA","N/A","NULL","-")
replace val_engvce=real(subinstr(strtrim(raw_engvce22),",","",.)) if source_year==2022
replace st_val_engvce=cond(missing(val_engvce),3,cond(val_engvce<0,2,cond(val_engvce==0,1,0))) if source_year==2022
replace st_val_engvce=5 if source_year==2022 & missing(val_engvce) & !inlist(upper(strtrim(raw_engvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_engvce G0_source_state
generate double val_engvcu=.
generate byte st_val_engvcu=4
replace val_engvcu=real(subinstr(strtrim(raw_engvcu20),",","",.)) if source_year==2020
replace st_val_engvcu=cond(missing(val_engvcu),3,cond(val_engvcu<0,2,cond(val_engvcu==0,1,0))) if source_year==2020
replace st_val_engvcu=5 if source_year==2020 & missing(val_engvcu) & !inlist(upper(strtrim(raw_engvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_engvcu=real(subinstr(strtrim(raw_engvcu21),",","",.)) if source_year==2021
replace st_val_engvcu=cond(missing(val_engvcu),3,cond(val_engvcu<0,2,cond(val_engvcu==0,1,0))) if source_year==2021
replace st_val_engvcu=5 if source_year==2021 & missing(val_engvcu) & !inlist(upper(strtrim(raw_engvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_engvcu=real(subinstr(strtrim(raw_engvcu22),",","",.)) if source_year==2022
replace st_val_engvcu=cond(missing(val_engvcu),3,cond(val_engvcu<0,2,cond(val_engvcu==0,1,0))) if source_year==2022
replace st_val_engvcu=5 if source_year==2022 & missing(val_engvcu) & !inlist(upper(strtrim(raw_engvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_engvcu G0_source_state
generate double val_enpvcu=.
generate byte st_val_enpvcu=4
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu10),",","",.)) if source_year==2010
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2010
replace st_val_enpvcu=5 if source_year==2010 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu11),",","",.)) if source_year==2011
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2011
replace st_val_enpvcu=5 if source_year==2011 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu12),",","",.)) if source_year==2012
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2012
replace st_val_enpvcu=5 if source_year==2012 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu13),",","",.)) if source_year==2013
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2013
replace st_val_enpvcu=5 if source_year==2013 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu14),",","",.)) if source_year==2014
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2014
replace st_val_enpvcu=5 if source_year==2014 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu),",","",.)) if source_year==2015
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2015
replace st_val_enpvcu=5 if source_year==2015 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu17),",","",.)) if source_year==2017
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2017
replace st_val_enpvcu=5 if source_year==2017 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu18),",","",.)) if source_year==2018
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2018
replace st_val_enpvcu=5 if source_year==2018 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu19),",","",.)) if source_year==2019
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2019
replace st_val_enpvcu=5 if source_year==2019 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu20),",","",.)) if source_year==2020
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2020
replace st_val_enpvcu=5 if source_year==2020 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu21),",","",.)) if source_year==2021
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2021
replace st_val_enpvcu=5 if source_year==2021 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_enpvcu=real(subinstr(strtrim(raw_enpvcu22),",","",.)) if source_year==2022
replace st_val_enpvcu=cond(missing(val_enpvcu),3,cond(val_enpvcu<0,2,cond(val_enpvcu==0,1,0))) if source_year==2022
replace st_val_enpvcu=5 if source_year==2022 & missing(val_enpvcu) & !inlist(upper(strtrim(raw_enpvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_enpvcu G0_source_state
generate double val_eoivce=.
generate byte st_val_eoivce=4
replace val_eoivce=real(subinstr(strtrim(raw_eoivce10),",","",.)) if source_year==2010
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2010
replace st_val_eoivce=5 if source_year==2010 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce10)),"","***",".","NA","N/A","NULL","-")
replace val_eoivce=real(subinstr(strtrim(raw_eoivce11),",","",.)) if source_year==2011
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2011
replace st_val_eoivce=5 if source_year==2011 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce11)),"","***",".","NA","N/A","NULL","-")
replace val_eoivce=real(subinstr(strtrim(raw_eoivce12),",","",.)) if source_year==2012
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2012
replace st_val_eoivce=5 if source_year==2012 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce12)),"","***",".","NA","N/A","NULL","-")
replace val_eoivce=real(subinstr(strtrim(raw_eoivce13),",","",.)) if source_year==2013
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2013
replace st_val_eoivce=5 if source_year==2013 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce13)),"","***",".","NA","N/A","NULL","-")
replace val_eoivce=real(subinstr(strtrim(raw_eoivce14),",","",.)) if source_year==2014
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2014
replace st_val_eoivce=5 if source_year==2014 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce14)),"","***",".","NA","N/A","NULL","-")
replace val_eoivce=real(subinstr(strtrim(raw_eoivce),",","",.)) if source_year==2015
replace st_val_eoivce=cond(missing(val_eoivce),3,cond(val_eoivce<0,2,cond(val_eoivce==0,1,0))) if source_year==2015
replace st_val_eoivce=5 if source_year==2015 & missing(val_eoivce) & !inlist(upper(strtrim(raw_eoivce)),"","***",".","NA","N/A","NULL","-")
label values st_val_eoivce G0_source_state
generate double val_eoivcu=.
generate byte st_val_eoivcu=4
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu10),",","",.)) if source_year==2010
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2010
replace st_val_eoivcu=5 if source_year==2010 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu10)),"","***",".","NA","N/A","NULL","-")
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu11),",","",.)) if source_year==2011
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2011
replace st_val_eoivcu=5 if source_year==2011 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu11)),"","***",".","NA","N/A","NULL","-")
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu12),",","",.)) if source_year==2012
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2012
replace st_val_eoivcu=5 if source_year==2012 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu12)),"","***",".","NA","N/A","NULL","-")
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu13),",","",.)) if source_year==2013
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2013
replace st_val_eoivcu=5 if source_year==2013 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu13)),"","***",".","NA","N/A","NULL","-")
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu14),",","",.)) if source_year==2014
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2014
replace st_val_eoivcu=5 if source_year==2014 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu14)),"","***",".","NA","N/A","NULL","-")
replace val_eoivcu=real(subinstr(strtrim(raw_eoivcu),",","",.)) if source_year==2015
replace st_val_eoivcu=cond(missing(val_eoivcu),3,cond(val_eoivcu<0,2,cond(val_eoivcu==0,1,0))) if source_year==2015
replace st_val_eoivcu=5 if source_year==2015 & missing(val_eoivcu) & !inlist(upper(strtrim(raw_eoivcu)),"","***",".","NA","N/A","NULL","-")
label values st_val_eoivcu G0_source_state
generate double val_epevce=.
generate byte st_val_epevce=4
replace val_epevce=real(subinstr(strtrim(raw_epevce10),",","",.)) if source_year==2010
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2010
replace st_val_epevce=5 if source_year==2010 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce10)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce11),",","",.)) if source_year==2011
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2011
replace st_val_epevce=5 if source_year==2011 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce11)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce12),",","",.)) if source_year==2012
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2012
replace st_val_epevce=5 if source_year==2012 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce12)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce13),",","",.)) if source_year==2013
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2013
replace st_val_epevce=5 if source_year==2013 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce13)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce14),",","",.)) if source_year==2014
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2014
replace st_val_epevce=5 if source_year==2014 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce14)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce),",","",.)) if source_year==2015
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2015
replace st_val_epevce=5 if source_year==2015 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce17),",","",.)) if source_year==2017
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2017
replace st_val_epevce=5 if source_year==2017 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce17)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce18),",","",.)) if source_year==2018
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2018
replace st_val_epevce=5 if source_year==2018 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce18)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce19),",","",.)) if source_year==2019
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2019
replace st_val_epevce=5 if source_year==2019 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce19)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce20),",","",.)) if source_year==2020
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2020
replace st_val_epevce=5 if source_year==2020 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce20)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce21),",","",.)) if source_year==2021
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2021
replace st_val_epevce=5 if source_year==2021 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce21)),"","***",".","NA","N/A","NULL","-")
replace val_epevce=real(subinstr(strtrim(raw_epevce22),",","",.)) if source_year==2022
replace st_val_epevce=cond(missing(val_epevce),3,cond(val_epevce<0,2,cond(val_epevce==0,1,0))) if source_year==2022
replace st_val_epevce=5 if source_year==2022 & missing(val_epevce) & !inlist(upper(strtrim(raw_epevce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_epevce G0_source_state
generate double val_epevcu=.
generate byte st_val_epevcu=4
replace val_epevcu=real(subinstr(strtrim(raw_epevcu10),",","",.)) if source_year==2010
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2010
replace st_val_epevcu=5 if source_year==2010 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu10)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu11),",","",.)) if source_year==2011
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2011
replace st_val_epevcu=5 if source_year==2011 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu11)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu12),",","",.)) if source_year==2012
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2012
replace st_val_epevcu=5 if source_year==2012 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu12)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu13),",","",.)) if source_year==2013
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2013
replace st_val_epevcu=5 if source_year==2013 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu13)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu14),",","",.)) if source_year==2014
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2014
replace st_val_epevcu=5 if source_year==2014 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu14)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu),",","",.)) if source_year==2015
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2015
replace st_val_epevcu=5 if source_year==2015 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu17),",","",.)) if source_year==2017
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2017
replace st_val_epevcu=5 if source_year==2017 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu17)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu18),",","",.)) if source_year==2018
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2018
replace st_val_epevcu=5 if source_year==2018 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu18)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu19),",","",.)) if source_year==2019
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2019
replace st_val_epevcu=5 if source_year==2019 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu19)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu20),",","",.)) if source_year==2020
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2020
replace st_val_epevcu=5 if source_year==2020 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu20)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu21),",","",.)) if source_year==2021
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2021
replace st_val_epevcu=5 if source_year==2021 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu21)),"","***",".","NA","N/A","NULL","-")
replace val_epevcu=real(subinstr(strtrim(raw_epevcu22),",","",.)) if source_year==2022
replace st_val_epevcu=cond(missing(val_epevcu),3,cond(val_epevcu<0,2,cond(val_epevcu==0,1,0))) if source_year==2022
replace st_val_epevcu=5 if source_year==2022 & missing(val_epevcu) & !inlist(upper(strtrim(raw_epevcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_epevcu G0_source_state
generate double val_eplvcu=.
generate byte st_val_eplvcu=4
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu10),",","",.)) if source_year==2010
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2010
replace st_val_eplvcu=5 if source_year==2010 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu11),",","",.)) if source_year==2011
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2011
replace st_val_eplvcu=5 if source_year==2011 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu12),",","",.)) if source_year==2012
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2012
replace st_val_eplvcu=5 if source_year==2012 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu13),",","",.)) if source_year==2013
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2013
replace st_val_eplvcu=5 if source_year==2013 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu14),",","",.)) if source_year==2014
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2014
replace st_val_eplvcu=5 if source_year==2014 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu),",","",.)) if source_year==2015
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2015
replace st_val_eplvcu=5 if source_year==2015 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu17),",","",.)) if source_year==2017
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2017
replace st_val_eplvcu=5 if source_year==2017 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu18),",","",.)) if source_year==2018
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2018
replace st_val_eplvcu=5 if source_year==2018 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu19),",","",.)) if source_year==2019
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2019
replace st_val_eplvcu=5 if source_year==2019 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu20),",","",.)) if source_year==2020
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2020
replace st_val_eplvcu=5 if source_year==2020 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu21),",","",.)) if source_year==2021
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2021
replace st_val_eplvcu=5 if source_year==2021 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_eplvcu=real(subinstr(strtrim(raw_eplvcu22),",","",.)) if source_year==2022
replace st_val_eplvcu=cond(missing(val_eplvcu),3,cond(val_eplvcu<0,2,cond(val_eplvcu==0,1,0))) if source_year==2022
replace st_val_eplvcu=5 if source_year==2022 & missing(val_eplvcu) & !inlist(upper(strtrim(raw_eplvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_eplvcu G0_source_state
generate double val_esdvce=.
generate byte st_val_esdvce=4
replace val_esdvce=real(subinstr(strtrim(raw_esdvce21),",","",.)) if source_year==2021
replace st_val_esdvce=cond(missing(val_esdvce),3,cond(val_esdvce<0,2,cond(val_esdvce==0,1,0))) if source_year==2021
replace st_val_esdvce=5 if source_year==2021 & missing(val_esdvce) & !inlist(upper(strtrim(raw_esdvce21)),"","***",".","NA","N/A","NULL","-")
replace val_esdvce=real(subinstr(strtrim(raw_esdvce22),",","",.)) if source_year==2022
replace st_val_esdvce=cond(missing(val_esdvce),3,cond(val_esdvce<0,2,cond(val_esdvce==0,1,0))) if source_year==2022
replace st_val_esdvce=5 if source_year==2022 & missing(val_esdvce) & !inlist(upper(strtrim(raw_esdvce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_esdvce G0_source_state
generate double val_esdvcu=.
generate byte st_val_esdvcu=4
replace val_esdvcu=real(subinstr(strtrim(raw_esdvcu21),",","",.)) if source_year==2021
replace st_val_esdvcu=cond(missing(val_esdvcu),3,cond(val_esdvcu<0,2,cond(val_esdvcu==0,1,0))) if source_year==2021
replace st_val_esdvcu=5 if source_year==2021 & missing(val_esdvcu) & !inlist(upper(strtrim(raw_esdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_esdvcu=real(subinstr(strtrim(raw_esdvcu22),",","",.)) if source_year==2022
replace st_val_esdvcu=cond(missing(val_esdvcu),3,cond(val_esdvcu<0,2,cond(val_esdvcu==0,1,0))) if source_year==2022
replace st_val_esdvcu=5 if source_year==2022 & missing(val_esdvcu) & !inlist(upper(strtrim(raw_esdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_esdvcu G0_source_state
generate double val_esovce=.
generate byte st_val_esovce=4
replace val_esovce=real(subinstr(strtrim(raw_esovce10),",","",.)) if source_year==2010
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2010
replace st_val_esovce=5 if source_year==2010 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce10)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce11),",","",.)) if source_year==2011
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2011
replace st_val_esovce=5 if source_year==2011 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce11)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce12),",","",.)) if source_year==2012
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2012
replace st_val_esovce=5 if source_year==2012 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce12)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce13),",","",.)) if source_year==2013
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2013
replace st_val_esovce=5 if source_year==2013 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce13)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce14),",","",.)) if source_year==2014
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2014
replace st_val_esovce=5 if source_year==2014 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce14)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce),",","",.)) if source_year==2015
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2015
replace st_val_esovce=5 if source_year==2015 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce17),",","",.)) if source_year==2017
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2017
replace st_val_esovce=5 if source_year==2017 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce17)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce18),",","",.)) if source_year==2018
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2018
replace st_val_esovce=5 if source_year==2018 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce18)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce19),",","",.)) if source_year==2019
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2019
replace st_val_esovce=5 if source_year==2019 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce19)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce20),",","",.)) if source_year==2020
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2020
replace st_val_esovce=5 if source_year==2020 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce20)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce21),",","",.)) if source_year==2021
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2021
replace st_val_esovce=5 if source_year==2021 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce21)),"","***",".","NA","N/A","NULL","-")
replace val_esovce=real(subinstr(strtrim(raw_esovce22),",","",.)) if source_year==2022
replace st_val_esovce=cond(missing(val_esovce),3,cond(val_esovce<0,2,cond(val_esovce==0,1,0))) if source_year==2022
replace st_val_esovce=5 if source_year==2022 & missing(val_esovce) & !inlist(upper(strtrim(raw_esovce22)),"","***",".","NA","N/A","NULL","-")
label values st_val_esovce G0_source_state
generate double val_esovcu=.
generate byte st_val_esovcu=4
replace val_esovcu=real(subinstr(strtrim(raw_esovcu10),",","",.)) if source_year==2010
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2010
replace st_val_esovcu=5 if source_year==2010 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu10)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu11),",","",.)) if source_year==2011
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2011
replace st_val_esovcu=5 if source_year==2011 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu11)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu12),",","",.)) if source_year==2012
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2012
replace st_val_esovcu=5 if source_year==2012 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu12)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu13),",","",.)) if source_year==2013
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2013
replace st_val_esovcu=5 if source_year==2013 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu13)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu14),",","",.)) if source_year==2014
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2014
replace st_val_esovcu=5 if source_year==2014 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu14)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu),",","",.)) if source_year==2015
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2015
replace st_val_esovcu=5 if source_year==2015 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu17),",","",.)) if source_year==2017
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2017
replace st_val_esovcu=5 if source_year==2017 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu17)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu18),",","",.)) if source_year==2018
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2018
replace st_val_esovcu=5 if source_year==2018 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu18)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu19),",","",.)) if source_year==2019
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2019
replace st_val_esovcu=5 if source_year==2019 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu19)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu20),",","",.)) if source_year==2020
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2020
replace st_val_esovcu=5 if source_year==2020 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu21),",","",.)) if source_year==2021
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2021
replace st_val_esovcu=5 if source_year==2021 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu21)),"","***",".","NA","N/A","NULL","-")
replace val_esovcu=real(subinstr(strtrim(raw_esovcu22),",","",.)) if source_year==2022
replace st_val_esovcu=cond(missing(val_esovcu),3,cond(val_esovcu<0,2,cond(val_esovcu==0,1,0))) if source_year==2022
replace st_val_esovcu=5 if source_year==2022 & missing(val_esovcu) & !inlist(upper(strtrim(raw_esovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_esovcu G0_source_state
generate double val_ibrvcu=.
generate byte st_val_ibrvcu=4
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu10),",","",.)) if source_year==2010
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2010
replace st_val_ibrvcu=5 if source_year==2010 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu11),",","",.)) if source_year==2011
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2011
replace st_val_ibrvcu=5 if source_year==2011 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu12),",","",.)) if source_year==2012
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2012
replace st_val_ibrvcu=5 if source_year==2012 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu13),",","",.)) if source_year==2013
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2013
replace st_val_ibrvcu=5 if source_year==2013 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu14),",","",.)) if source_year==2014
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2014
replace st_val_ibrvcu=5 if source_year==2014 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu),",","",.)) if source_year==2015
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2015
replace st_val_ibrvcu=5 if source_year==2015 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu17),",","",.)) if source_year==2017
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2017
replace st_val_ibrvcu=5 if source_year==2017 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu18),",","",.)) if source_year==2018
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2018
replace st_val_ibrvcu=5 if source_year==2018 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu19),",","",.)) if source_year==2019
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2019
replace st_val_ibrvcu=5 if source_year==2019 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu20),",","",.)) if source_year==2020
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2020
replace st_val_ibrvcu=5 if source_year==2020 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu21),",","",.)) if source_year==2021
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2021
replace st_val_ibrvcu=5 if source_year==2021 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ibrvcu=real(subinstr(strtrim(raw_ibrvcu22),",","",.)) if source_year==2022
replace st_val_ibrvcu=cond(missing(val_ibrvcu),3,cond(val_ibrvcu<0,2,cond(val_ibrvcu==0,1,0))) if source_year==2022
replace st_val_ibrvcu=5 if source_year==2022 & missing(val_ibrvcu) & !inlist(upper(strtrim(raw_ibrvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ibrvcu G0_source_state
generate double val_icovcu=.
generate byte st_val_icovcu=4
replace val_icovcu=real(subinstr(strtrim(raw_icovcu10),",","",.)) if source_year==2010
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2010
replace st_val_icovcu=5 if source_year==2010 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu10)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu11),",","",.)) if source_year==2011
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2011
replace st_val_icovcu=5 if source_year==2011 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu11)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu12),",","",.)) if source_year==2012
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2012
replace st_val_icovcu=5 if source_year==2012 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu12)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu13),",","",.)) if source_year==2013
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2013
replace st_val_icovcu=5 if source_year==2013 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu13)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu14),",","",.)) if source_year==2014
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2014
replace st_val_icovcu=5 if source_year==2014 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu14)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu),",","",.)) if source_year==2015
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2015
replace st_val_icovcu=5 if source_year==2015 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu17),",","",.)) if source_year==2017
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2017
replace st_val_icovcu=5 if source_year==2017 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu17)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu18),",","",.)) if source_year==2018
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2018
replace st_val_icovcu=5 if source_year==2018 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu18)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu19),",","",.)) if source_year==2019
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2019
replace st_val_icovcu=5 if source_year==2019 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu19)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu20),",","",.)) if source_year==2020
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2020
replace st_val_icovcu=5 if source_year==2020 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu21),",","",.)) if source_year==2021
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2021
replace st_val_icovcu=5 if source_year==2021 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu21)),"","***",".","NA","N/A","NULL","-")
replace val_icovcu=real(subinstr(strtrim(raw_icovcu22),",","",.)) if source_year==2022
replace st_val_icovcu=cond(missing(val_icovcu),3,cond(val_icovcu<0,2,cond(val_icovcu==0,1,0))) if source_year==2022
replace st_val_icovcu=5 if source_year==2022 & missing(val_icovcu) & !inlist(upper(strtrim(raw_icovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_icovcu G0_source_state
generate double val_idevcu=.
generate byte st_val_idevcu=4
replace val_idevcu=real(subinstr(strtrim(raw_idevcu17),",","",.)) if source_year==2017
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2017
replace st_val_idevcu=5 if source_year==2017 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu17)),"","***",".","NA","N/A","NULL","-")
replace val_idevcu=real(subinstr(strtrim(raw_idevcu18),",","",.)) if source_year==2018
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2018
replace st_val_idevcu=5 if source_year==2018 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu18)),"","***",".","NA","N/A","NULL","-")
replace val_idevcu=real(subinstr(strtrim(raw_idevcu19),",","",.)) if source_year==2019
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2019
replace st_val_idevcu=5 if source_year==2019 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu19)),"","***",".","NA","N/A","NULL","-")
replace val_idevcu=real(subinstr(strtrim(raw_idevcu20),",","",.)) if source_year==2020
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2020
replace st_val_idevcu=5 if source_year==2020 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu20)),"","***",".","NA","N/A","NULL","-")
replace val_idevcu=real(subinstr(strtrim(raw_idevcu21),",","",.)) if source_year==2021
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2021
replace st_val_idevcu=5 if source_year==2021 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu21)),"","***",".","NA","N/A","NULL","-")
replace val_idevcu=real(subinstr(strtrim(raw_idevcu22),",","",.)) if source_year==2022
replace st_val_idevcu=cond(missing(val_idevcu),3,cond(val_idevcu<0,2,cond(val_idevcu==0,1,0))) if source_year==2022
replace st_val_idevcu=5 if source_year==2022 & missing(val_idevcu) & !inlist(upper(strtrim(raw_idevcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_idevcu G0_source_state
generate double val_iinput=.
generate byte st_val_iinput=4
replace val_iinput=real(subinstr(strtrim(raw_iinput10),",","",.)) if source_year==2010
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2010
replace st_val_iinput=5 if source_year==2010 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput10)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput11),",","",.)) if source_year==2011
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2011
replace st_val_iinput=5 if source_year==2011 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput11)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput12),",","",.)) if source_year==2012
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2012
replace st_val_iinput=5 if source_year==2012 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput12)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput13),",","",.)) if source_year==2013
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2013
replace st_val_iinput=5 if source_year==2013 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput13)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput14),",","",.)) if source_year==2014
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2014
replace st_val_iinput=5 if source_year==2014 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput14)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput17),",","",.)) if source_year==2017
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2017
replace st_val_iinput=5 if source_year==2017 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput17)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput18),",","",.)) if source_year==2018
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2018
replace st_val_iinput=5 if source_year==2018 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput18)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput19),",","",.)) if source_year==2019
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2019
replace st_val_iinput=5 if source_year==2019 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput19)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput20),",","",.)) if source_year==2020
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2020
replace st_val_iinput=5 if source_year==2020 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput20)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput21),",","",.)) if source_year==2021
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2021
replace st_val_iinput=5 if source_year==2021 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput21)),"","***",".","NA","N/A","NULL","-")
replace val_iinput=real(subinstr(strtrim(raw_iinput22),",","",.)) if source_year==2022
replace st_val_iinput=cond(missing(val_iinput),3,cond(val_iinput<0,2,cond(val_iinput==0,1,0))) if source_year==2022
replace st_val_iinput=5 if source_year==2022 & missing(val_iinput) & !inlist(upper(strtrim(raw_iinput22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iinput G0_source_state
generate double val_iinvcu=.
generate byte st_val_iinvcu=4
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu10),",","",.)) if source_year==2010
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2010
replace st_val_iinvcu=5 if source_year==2010 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu11),",","",.)) if source_year==2011
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2011
replace st_val_iinvcu=5 if source_year==2011 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu12),",","",.)) if source_year==2012
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2012
replace st_val_iinvcu=5 if source_year==2012 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu13),",","",.)) if source_year==2013
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2013
replace st_val_iinvcu=5 if source_year==2013 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu14),",","",.)) if source_year==2014
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2014
replace st_val_iinvcu=5 if source_year==2014 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu),",","",.)) if source_year==2015
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2015
replace st_val_iinvcu=5 if source_year==2015 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu17),",","",.)) if source_year==2017
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2017
replace st_val_iinvcu=5 if source_year==2017 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu18),",","",.)) if source_year==2018
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2018
replace st_val_iinvcu=5 if source_year==2018 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu19),",","",.)) if source_year==2019
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2019
replace st_val_iinvcu=5 if source_year==2019 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu20),",","",.)) if source_year==2020
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2020
replace st_val_iinvcu=5 if source_year==2020 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu21),",","",.)) if source_year==2021
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2021
replace st_val_iinvcu=5 if source_year==2021 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_iinvcu=real(subinstr(strtrim(raw_iinvcu22),",","",.)) if source_year==2022
replace st_val_iinvcu=cond(missing(val_iinvcu),3,cond(val_iinvcu<0,2,cond(val_iinvcu==0,1,0))) if source_year==2022
replace st_val_iinvcu=5 if source_year==2022 & missing(val_iinvcu) & !inlist(upper(strtrim(raw_iinvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iinvcu G0_source_state
generate double val_iisfov=.
generate byte st_val_iisfov=4
replace val_iisfov=real(subinstr(strtrim(raw_iisfov18),",","",.)) if source_year==2018
replace st_val_iisfov=cond(missing(val_iisfov),3,cond(val_iisfov<0,2,cond(val_iisfov==0,1,0))) if source_year==2018
replace st_val_iisfov=5 if source_year==2018 & missing(val_iisfov) & !inlist(upper(strtrim(raw_iisfov18)),"","***",".","NA","N/A","NULL","-")
replace val_iisfov=real(subinstr(strtrim(raw_iisfov19),",","",.)) if source_year==2019
replace st_val_iisfov=cond(missing(val_iisfov),3,cond(val_iisfov<0,2,cond(val_iisfov==0,1,0))) if source_year==2019
replace st_val_iisfov=5 if source_year==2019 & missing(val_iisfov) & !inlist(upper(strtrim(raw_iisfov19)),"","***",".","NA","N/A","NULL","-")
replace val_iisfov=real(subinstr(strtrim(raw_iisfov20),",","",.)) if source_year==2020
replace st_val_iisfov=cond(missing(val_iisfov),3,cond(val_iisfov<0,2,cond(val_iisfov==0,1,0))) if source_year==2020
replace st_val_iisfov=5 if source_year==2020 & missing(val_iisfov) & !inlist(upper(strtrim(raw_iisfov20)),"","***",".","NA","N/A","NULL","-")
replace val_iisfov=real(subinstr(strtrim(raw_iisfov21),",","",.)) if source_year==2021
replace st_val_iisfov=cond(missing(val_iisfov),3,cond(val_iisfov<0,2,cond(val_iisfov==0,1,0))) if source_year==2021
replace st_val_iisfov=5 if source_year==2021 & missing(val_iisfov) & !inlist(upper(strtrim(raw_iisfov21)),"","***",".","NA","N/A","NULL","-")
replace val_iisfov=real(subinstr(strtrim(raw_iisfov22),",","",.)) if source_year==2022
replace st_val_iisfov=cond(missing(val_iisfov),3,cond(val_iisfov<0,2,cond(val_iisfov==0,1,0))) if source_year==2022
replace st_val_iisfov=5 if source_year==2022 & missing(val_iisfov) & !inlist(upper(strtrim(raw_iisfov22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iisfov G0_source_state
generate double val_iislov=.
generate byte st_val_iislov=4
replace val_iislov=real(subinstr(strtrim(raw_iislov18),",","",.)) if source_year==2018
replace st_val_iislov=cond(missing(val_iislov),3,cond(val_iislov<0,2,cond(val_iislov==0,1,0))) if source_year==2018
replace st_val_iislov=5 if source_year==2018 & missing(val_iislov) & !inlist(upper(strtrim(raw_iislov18)),"","***",".","NA","N/A","NULL","-")
replace val_iislov=real(subinstr(strtrim(raw_iislov19),",","",.)) if source_year==2019
replace st_val_iislov=cond(missing(val_iislov),3,cond(val_iislov<0,2,cond(val_iislov==0,1,0))) if source_year==2019
replace st_val_iislov=5 if source_year==2019 & missing(val_iislov) & !inlist(upper(strtrim(raw_iislov19)),"","***",".","NA","N/A","NULL","-")
replace val_iislov=real(subinstr(strtrim(raw_iislov20),",","",.)) if source_year==2020
replace st_val_iislov=cond(missing(val_iislov),3,cond(val_iislov<0,2,cond(val_iislov==0,1,0))) if source_year==2020
replace st_val_iislov=5 if source_year==2020 & missing(val_iislov) & !inlist(upper(strtrim(raw_iislov20)),"","***",".","NA","N/A","NULL","-")
replace val_iislov=real(subinstr(strtrim(raw_iislov21),",","",.)) if source_year==2021
replace st_val_iislov=cond(missing(val_iislov),3,cond(val_iislov<0,2,cond(val_iislov==0,1,0))) if source_year==2021
replace st_val_iislov=5 if source_year==2021 & missing(val_iislov) & !inlist(upper(strtrim(raw_iislov21)),"","***",".","NA","N/A","NULL","-")
replace val_iislov=real(subinstr(strtrim(raw_iislov22),",","",.)) if source_year==2022
replace st_val_iislov=cond(missing(val_iislov),3,cond(val_iislov<0,2,cond(val_iislov==0,1,0))) if source_year==2022
replace st_val_iislov=5 if source_year==2022 & missing(val_iislov) & !inlist(upper(strtrim(raw_iislov22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iislov G0_source_state
generate double val_iisvcu=.
generate byte st_val_iisvcu=4
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu10),",","",.)) if source_year==2010
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2010
replace st_val_iisvcu=5 if source_year==2010 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu11),",","",.)) if source_year==2011
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2011
replace st_val_iisvcu=5 if source_year==2011 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu12),",","",.)) if source_year==2012
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2012
replace st_val_iisvcu=5 if source_year==2012 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu13),",","",.)) if source_year==2013
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2013
replace st_val_iisvcu=5 if source_year==2013 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu14),",","",.)) if source_year==2014
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2014
replace st_val_iisvcu=5 if source_year==2014 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu),",","",.)) if source_year==2015
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2015
replace st_val_iisvcu=5 if source_year==2015 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu17),",","",.)) if source_year==2017
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2017
replace st_val_iisvcu=5 if source_year==2017 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu18),",","",.)) if source_year==2018
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2018
replace st_val_iisvcu=5 if source_year==2018 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_iisvcu=real(subinstr(strtrim(raw_iisvcu19),",","",.)) if source_year==2019
replace st_val_iisvcu=cond(missing(val_iisvcu),3,cond(val_iisvcu<0,2,cond(val_iisvcu==0,1,0))) if source_year==2019
replace st_val_iisvcu=5 if source_year==2019 & missing(val_iisvcu) & !inlist(upper(strtrim(raw_iisvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_iisvcu G0_source_state
generate double val_ikivcu=.
generate byte st_val_ikivcu=4
replace val_ikivcu=real(subinstr(strtrim(raw_ikivcu17),",","",.)) if source_year==2017
replace st_val_ikivcu=cond(missing(val_ikivcu),3,cond(val_ikivcu<0,2,cond(val_ikivcu==0,1,0))) if source_year==2017
replace st_val_ikivcu=5 if source_year==2017 & missing(val_ikivcu) & !inlist(upper(strtrim(raw_ikivcu17)),"","***",".","NA","N/A","NULL","-")
replace val_ikivcu=real(subinstr(strtrim(raw_ikivcu18),",","",.)) if source_year==2018
replace st_val_ikivcu=cond(missing(val_ikivcu),3,cond(val_ikivcu<0,2,cond(val_ikivcu==0,1,0))) if source_year==2018
replace st_val_ikivcu=5 if source_year==2018 & missing(val_ikivcu) & !inlist(upper(strtrim(raw_ikivcu18)),"","***",".","NA","N/A","NULL","-")
replace val_ikivcu=real(subinstr(strtrim(raw_ikivcu19),",","",.)) if source_year==2019
replace st_val_ikivcu=cond(missing(val_ikivcu),3,cond(val_ikivcu<0,2,cond(val_ikivcu==0,1,0))) if source_year==2019
replace st_val_ikivcu=5 if source_year==2019 & missing(val_ikivcu) & !inlist(upper(strtrim(raw_ikivcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_ikivcu G0_source_state
generate double val_iklvcu=.
generate byte st_val_iklvcu=4
replace val_iklvcu=real(subinstr(strtrim(raw_iklvcu19),",","",.)) if source_year==2019
replace st_val_iklvcu=cond(missing(val_iklvcu),3,cond(val_iklvcu<0,2,cond(val_iklvcu==0,1,0))) if source_year==2019
replace st_val_iklvcu=5 if source_year==2019 & missing(val_iklvcu) & !inlist(upper(strtrim(raw_iklvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_iklvcu=real(subinstr(strtrim(raw_iklvcu20),",","",.)) if source_year==2020
replace st_val_iklvcu=cond(missing(val_iklvcu),3,cond(val_iklvcu<0,2,cond(val_iklvcu==0,1,0))) if source_year==2020
replace st_val_iklvcu=5 if source_year==2020 & missing(val_iklvcu) & !inlist(upper(strtrim(raw_iklvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_iklvcu=real(subinstr(strtrim(raw_iklvcu21),",","",.)) if source_year==2021
replace st_val_iklvcu=cond(missing(val_iklvcu),3,cond(val_iklvcu<0,2,cond(val_iklvcu==0,1,0))) if source_year==2021
replace st_val_iklvcu=5 if source_year==2021 & missing(val_iklvcu) & !inlist(upper(strtrim(raw_iklvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_iklvcu=real(subinstr(strtrim(raw_iklvcu22),",","",.)) if source_year==2022
replace st_val_iklvcu=cond(missing(val_iklvcu),3,cond(val_iklvcu<0,2,cond(val_iklvcu==0,1,0))) if source_year==2022
replace st_val_iklvcu=5 if source_year==2022 & missing(val_iklvcu) & !inlist(upper(strtrim(raw_iklvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iklvcu G0_source_state
generate double val_ikovcu=.
generate byte st_val_ikovcu=4
replace val_ikovcu=real(subinstr(strtrim(raw_ikovcu19),",","",.)) if source_year==2019
replace st_val_ikovcu=cond(missing(val_ikovcu),3,cond(val_ikovcu<0,2,cond(val_ikovcu==0,1,0))) if source_year==2019
replace st_val_ikovcu=5 if source_year==2019 & missing(val_ikovcu) & !inlist(upper(strtrim(raw_ikovcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ikovcu=real(subinstr(strtrim(raw_ikovcu20),",","",.)) if source_year==2020
replace st_val_ikovcu=cond(missing(val_ikovcu),3,cond(val_ikovcu<0,2,cond(val_ikovcu==0,1,0))) if source_year==2020
replace st_val_ikovcu=5 if source_year==2020 & missing(val_ikovcu) & !inlist(upper(strtrim(raw_ikovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ikovcu=real(subinstr(strtrim(raw_ikovcu21),",","",.)) if source_year==2021
replace st_val_ikovcu=cond(missing(val_ikovcu),3,cond(val_ikovcu<0,2,cond(val_ikovcu==0,1,0))) if source_year==2021
replace st_val_ikovcu=5 if source_year==2021 & missing(val_ikovcu) & !inlist(upper(strtrim(raw_ikovcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ikovcu=real(subinstr(strtrim(raw_ikovcu22),",","",.)) if source_year==2022
replace st_val_ikovcu=cond(missing(val_ikovcu),3,cond(val_ikovcu<0,2,cond(val_ikovcu==0,1,0))) if source_year==2022
replace st_val_ikovcu=5 if source_year==2022 & missing(val_ikovcu) & !inlist(upper(strtrim(raw_ikovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ikovcu G0_source_state
generate double val_ilrvcu=.
generate byte st_val_ilrvcu=4
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu10),",","",.)) if source_year==2010
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2010
replace st_val_ilrvcu=5 if source_year==2010 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu11),",","",.)) if source_year==2011
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2011
replace st_val_ilrvcu=5 if source_year==2011 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu12),",","",.)) if source_year==2012
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2012
replace st_val_ilrvcu=5 if source_year==2012 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu13),",","",.)) if source_year==2013
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2013
replace st_val_ilrvcu=5 if source_year==2013 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu14),",","",.)) if source_year==2014
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2014
replace st_val_ilrvcu=5 if source_year==2014 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu),",","",.)) if source_year==2015
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2015
replace st_val_ilrvcu=5 if source_year==2015 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu17),",","",.)) if source_year==2017
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2017
replace st_val_ilrvcu=5 if source_year==2017 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu18),",","",.)) if source_year==2018
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2018
replace st_val_ilrvcu=5 if source_year==2018 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu19),",","",.)) if source_year==2019
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2019
replace st_val_ilrvcu=5 if source_year==2019 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu20),",","",.)) if source_year==2020
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2020
replace st_val_ilrvcu=5 if source_year==2020 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu21),",","",.)) if source_year==2021
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2021
replace st_val_ilrvcu=5 if source_year==2021 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ilrvcu=real(subinstr(strtrim(raw_ilrvcu22),",","",.)) if source_year==2022
replace st_val_ilrvcu=cond(missing(val_ilrvcu),3,cond(val_ilrvcu<0,2,cond(val_ilrvcu==0,1,0))) if source_year==2022
replace st_val_ilrvcu=5 if source_year==2022 & missing(val_ilrvcu) & !inlist(upper(strtrim(raw_ilrvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ilrvcu G0_source_state
generate double val_insvcu=.
generate byte st_val_insvcu=4
replace val_insvcu=real(subinstr(strtrim(raw_insvcu17),",","",.)) if source_year==2017
replace st_val_insvcu=cond(missing(val_insvcu),3,cond(val_insvcu<0,2,cond(val_insvcu==0,1,0))) if source_year==2017
replace st_val_insvcu=5 if source_year==2017 & missing(val_insvcu) & !inlist(upper(strtrim(raw_insvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_insvcu=real(subinstr(strtrim(raw_insvcu18),",","",.)) if source_year==2018
replace st_val_insvcu=cond(missing(val_insvcu),3,cond(val_insvcu<0,2,cond(val_insvcu==0,1,0))) if source_year==2018
replace st_val_insvcu=5 if source_year==2018 & missing(val_insvcu) & !inlist(upper(strtrim(raw_insvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_insvcu=real(subinstr(strtrim(raw_insvcu19),",","",.)) if source_year==2019
replace st_val_insvcu=cond(missing(val_insvcu),3,cond(val_insvcu<0,2,cond(val_insvcu==0,1,0))) if source_year==2019
replace st_val_insvcu=5 if source_year==2019 & missing(val_insvcu) & !inlist(upper(strtrim(raw_insvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_insvcu G0_source_state
generate double val_intvcu=.
generate byte st_val_intvcu=4
replace val_intvcu=real(subinstr(strtrim(raw_intvcu17),",","",.)) if source_year==2017
replace st_val_intvcu=cond(missing(val_intvcu),3,cond(val_intvcu<0,2,cond(val_intvcu==0,1,0))) if source_year==2017
replace st_val_intvcu=5 if source_year==2017 & missing(val_intvcu) & !inlist(upper(strtrim(raw_intvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_intvcu=real(subinstr(strtrim(raw_intvcu18),",","",.)) if source_year==2018
replace st_val_intvcu=cond(missing(val_intvcu),3,cond(val_intvcu<0,2,cond(val_intvcu==0,1,0))) if source_year==2018
replace st_val_intvcu=5 if source_year==2018 & missing(val_intvcu) & !inlist(upper(strtrim(raw_intvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_intvcu=real(subinstr(strtrim(raw_intvcu19),",","",.)) if source_year==2019
replace st_val_intvcu=cond(missing(val_intvcu),3,cond(val_intvcu<0,2,cond(val_intvcu==0,1,0))) if source_year==2019
replace st_val_intvcu=5 if source_year==2019 & missing(val_intvcu) & !inlist(upper(strtrim(raw_intvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_intvcu G0_source_state
generate double val_iotvcu=.
generate byte st_val_iotvcu=4
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu10),",","",.)) if source_year==2010
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2010
replace st_val_iotvcu=5 if source_year==2010 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu11),",","",.)) if source_year==2011
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2011
replace st_val_iotvcu=5 if source_year==2011 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu12),",","",.)) if source_year==2012
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2012
replace st_val_iotvcu=5 if source_year==2012 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu13),",","",.)) if source_year==2013
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2013
replace st_val_iotvcu=5 if source_year==2013 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu14),",","",.)) if source_year==2014
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2014
replace st_val_iotvcu=5 if source_year==2014 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu),",","",.)) if source_year==2015
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2015
replace st_val_iotvcu=5 if source_year==2015 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu17),",","",.)) if source_year==2017
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2017
replace st_val_iotvcu=5 if source_year==2017 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu18),",","",.)) if source_year==2018
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2018
replace st_val_iotvcu=5 if source_year==2018 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu19),",","",.)) if source_year==2019
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2019
replace st_val_iotvcu=5 if source_year==2019 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu20),",","",.)) if source_year==2020
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2020
replace st_val_iotvcu=5 if source_year==2020 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu21),",","",.)) if source_year==2021
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2021
replace st_val_iotvcu=5 if source_year==2021 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_iotvcu=real(subinstr(strtrim(raw_iotvcu22),",","",.)) if source_year==2022
replace st_val_iotvcu=cond(missing(val_iotvcu),3,cond(val_iotvcu<0,2,cond(val_iotvcu==0,1,0))) if source_year==2022
replace st_val_iotvcu=5 if source_year==2022 & missing(val_iotvcu) & !inlist(upper(strtrim(raw_iotvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iotvcu G0_source_state
generate double val_ipkvcu=.
generate byte st_val_ipkvcu=4
replace val_ipkvcu=real(subinstr(strtrim(raw_ipkvcu20),",","",.)) if source_year==2020
replace st_val_ipkvcu=cond(missing(val_ipkvcu),3,cond(val_ipkvcu<0,2,cond(val_ipkvcu==0,1,0))) if source_year==2020
replace st_val_ipkvcu=5 if source_year==2020 & missing(val_ipkvcu) & !inlist(upper(strtrim(raw_ipkvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ipkvcu=real(subinstr(strtrim(raw_ipkvcu21),",","",.)) if source_year==2021
replace st_val_ipkvcu=cond(missing(val_ipkvcu),3,cond(val_ipkvcu<0,2,cond(val_ipkvcu==0,1,0))) if source_year==2021
replace st_val_ipkvcu=5 if source_year==2021 & missing(val_ipkvcu) & !inlist(upper(strtrim(raw_ipkvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ipkvcu=real(subinstr(strtrim(raw_ipkvcu22),",","",.)) if source_year==2022
replace st_val_ipkvcu=cond(missing(val_ipkvcu),3,cond(val_ipkvcu<0,2,cond(val_ipkvcu==0,1,0))) if source_year==2022
replace st_val_ipkvcu=5 if source_year==2022 & missing(val_ipkvcu) & !inlist(upper(strtrim(raw_ipkvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ipkvcu G0_source_state
generate double val_iprvcu=.
generate byte st_val_iprvcu=4
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu17),",","",.)) if source_year==2017
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2017
replace st_val_iprvcu=5 if source_year==2017 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu18),",","",.)) if source_year==2018
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2018
replace st_val_iprvcu=5 if source_year==2018 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu19),",","",.)) if source_year==2019
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2019
replace st_val_iprvcu=5 if source_year==2019 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu20),",","",.)) if source_year==2020
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2020
replace st_val_iprvcu=5 if source_year==2020 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu21),",","",.)) if source_year==2021
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2021
replace st_val_iprvcu=5 if source_year==2021 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_iprvcu=real(subinstr(strtrim(raw_iprvcu22),",","",.)) if source_year==2022
replace st_val_iprvcu=cond(missing(val_iprvcu),3,cond(val_iprvcu<0,2,cond(val_iprvcu==0,1,0))) if source_year==2022
replace st_val_iprvcu=5 if source_year==2022 & missing(val_iprvcu) & !inlist(upper(strtrim(raw_iprvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iprvcu G0_source_state
generate double val_irdvcu=.
generate byte st_val_irdvcu=4
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu17),",","",.)) if source_year==2017
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2017
replace st_val_irdvcu=5 if source_year==2017 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu18),",","",.)) if source_year==2018
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2018
replace st_val_irdvcu=5 if source_year==2018 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu19),",","",.)) if source_year==2019
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2019
replace st_val_irdvcu=5 if source_year==2019 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu20),",","",.)) if source_year==2020
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2020
replace st_val_irdvcu=5 if source_year==2020 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu21),",","",.)) if source_year==2021
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2021
replace st_val_irdvcu=5 if source_year==2021 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_irdvcu=real(subinstr(strtrim(raw_irdvcu22),",","",.)) if source_year==2022
replace st_val_irdvcu=cond(missing(val_irdvcu),3,cond(val_irdvcu<0,2,cond(val_irdvcu==0,1,0))) if source_year==2022
replace st_val_irdvcu=5 if source_year==2022 & missing(val_irdvcu) & !inlist(upper(strtrim(raw_irdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_irdvcu G0_source_state
generate double val_irevcu=.
generate byte st_val_irevcu=4
replace val_irevcu=real(subinstr(strtrim(raw_irevcu),",","",.)) if source_year==2015
replace st_val_irevcu=cond(missing(val_irevcu),3,cond(val_irevcu<0,2,cond(val_irevcu==0,1,0))) if source_year==2015
replace st_val_irevcu=5 if source_year==2015 & missing(val_irevcu) & !inlist(upper(strtrim(raw_irevcu)),"","***",".","NA","N/A","NULL","-")
label values st_val_irevcu G0_source_state
generate double val_irrvcu=.
generate byte st_val_irrvcu=4
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu10),",","",.)) if source_year==2010
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2010
replace st_val_irrvcu=5 if source_year==2010 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu11),",","",.)) if source_year==2011
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2011
replace st_val_irrvcu=5 if source_year==2011 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu12),",","",.)) if source_year==2012
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2012
replace st_val_irrvcu=5 if source_year==2012 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu13),",","",.)) if source_year==2013
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2013
replace st_val_irrvcu=5 if source_year==2013 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu14),",","",.)) if source_year==2014
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2014
replace st_val_irrvcu=5 if source_year==2014 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu17),",","",.)) if source_year==2017
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2017
replace st_val_irrvcu=5 if source_year==2017 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu18),",","",.)) if source_year==2018
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2018
replace st_val_irrvcu=5 if source_year==2018 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_irrvcu=real(subinstr(strtrim(raw_irrvcu19),",","",.)) if source_year==2019
replace st_val_irrvcu=cond(missing(val_irrvcu),3,cond(val_irrvcu<0,2,cond(val_irrvcu==0,1,0))) if source_year==2019
replace st_val_irrvcu=5 if source_year==2019 & missing(val_irrvcu) & !inlist(upper(strtrim(raw_irrvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_irrvcu G0_source_state
generate double val_itxvcu=.
generate byte st_val_itxvcu=4
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu10),",","",.)) if source_year==2010
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2010
replace st_val_itxvcu=5 if source_year==2010 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu11),",","",.)) if source_year==2011
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2011
replace st_val_itxvcu=5 if source_year==2011 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu12),",","",.)) if source_year==2012
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2012
replace st_val_itxvcu=5 if source_year==2012 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu13),",","",.)) if source_year==2013
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2013
replace st_val_itxvcu=5 if source_year==2013 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu14),",","",.)) if source_year==2014
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2014
replace st_val_itxvcu=5 if source_year==2014 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu),",","",.)) if source_year==2015
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2015
replace st_val_itxvcu=5 if source_year==2015 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu17),",","",.)) if source_year==2017
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2017
replace st_val_itxvcu=5 if source_year==2017 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu18),",","",.)) if source_year==2018
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2018
replace st_val_itxvcu=5 if source_year==2018 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu19),",","",.)) if source_year==2019
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2019
replace st_val_itxvcu=5 if source_year==2019 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu20),",","",.)) if source_year==2020
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2020
replace st_val_itxvcu=5 if source_year==2020 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu21),",","",.)) if source_year==2021
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2021
replace st_val_itxvcu=5 if source_year==2021 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_itxvcu=real(subinstr(strtrim(raw_itxvcu22),",","",.)) if source_year==2022
replace st_val_itxvcu=cond(missing(val_itxvcu),3,cond(val_itxvcu<0,2,cond(val_itxvcu==0,1,0))) if source_year==2022
replace st_val_itxvcu=5 if source_year==2022 & missing(val_itxvcu) & !inlist(upper(strtrim(raw_itxvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_itxvcu G0_source_state
generate double val_iuwvcu=.
generate byte st_val_iuwvcu=4
replace val_iuwvcu=real(subinstr(strtrim(raw_iuwvcu20),",","",.)) if source_year==2020
replace st_val_iuwvcu=cond(missing(val_iuwvcu),3,cond(val_iuwvcu<0,2,cond(val_iuwvcu==0,1,0))) if source_year==2020
replace st_val_iuwvcu=5 if source_year==2020 & missing(val_iuwvcu) & !inlist(upper(strtrim(raw_iuwvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_iuwvcu=real(subinstr(strtrim(raw_iuwvcu21),",","",.)) if source_year==2021
replace st_val_iuwvcu=cond(missing(val_iuwvcu),3,cond(val_iuwvcu<0,2,cond(val_iuwvcu==0,1,0))) if source_year==2021
replace st_val_iuwvcu=5 if source_year==2021 & missing(val_iuwvcu) & !inlist(upper(strtrim(raw_iuwvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_iuwvcu=real(subinstr(strtrim(raw_iuwvcu22),",","",.)) if source_year==2022
replace st_val_iuwvcu=cond(missing(val_iuwvcu),3,cond(val_iuwvcu<0,2,cond(val_iuwvcu==0,1,0))) if source_year==2022
replace st_val_iuwvcu=5 if source_year==2022 & missing(val_iuwvcu) & !inlist(upper(strtrim(raw_iuwvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_iuwvcu G0_source_state
generate double val_nopvcu=.
generate byte st_val_nopvcu=4
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu17),",","",.)) if source_year==2017
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2017
replace st_val_nopvcu=5 if source_year==2017 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu18),",","",.)) if source_year==2018
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2018
replace st_val_nopvcu=5 if source_year==2018 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu19),",","",.)) if source_year==2019
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2019
replace st_val_nopvcu=5 if source_year==2019 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu20),",","",.)) if source_year==2020
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2020
replace st_val_nopvcu=5 if source_year==2020 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu21),",","",.)) if source_year==2021
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2021
replace st_val_nopvcu=5 if source_year==2021 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_nopvcu=real(subinstr(strtrim(raw_nopvcu22),",","",.)) if source_year==2022
replace st_val_nopvcu=cond(missing(val_nopvcu),3,cond(val_nopvcu<0,2,cond(val_nopvcu==0,1,0))) if source_year==2022
replace st_val_nopvcu=5 if source_year==2022 & missing(val_nopvcu) & !inlist(upper(strtrim(raw_nopvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_nopvcu G0_source_state
generate double val_othvcu=.
generate byte st_val_othvcu=4
replace val_othvcu=real(subinstr(strtrim(raw_othvcu19),",","",.)) if source_year==2019
replace st_val_othvcu=cond(missing(val_othvcu),3,cond(val_othvcu<0,2,cond(val_othvcu==0,1,0))) if source_year==2019
replace st_val_othvcu=5 if source_year==2019 & missing(val_othvcu) & !inlist(upper(strtrim(raw_othvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_othvcu G0_source_state
generate double val_output=.
generate byte st_val_output=4
replace val_output=real(subinstr(strtrim(raw_output10),",","",.)) if source_year==2010
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2010
replace st_val_output=5 if source_year==2010 & missing(val_output) & !inlist(upper(strtrim(raw_output10)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output11),",","",.)) if source_year==2011
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2011
replace st_val_output=5 if source_year==2011 & missing(val_output) & !inlist(upper(strtrim(raw_output11)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output12),",","",.)) if source_year==2012
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2012
replace st_val_output=5 if source_year==2012 & missing(val_output) & !inlist(upper(strtrim(raw_output12)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output13),",","",.)) if source_year==2013
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2013
replace st_val_output=5 if source_year==2013 & missing(val_output) & !inlist(upper(strtrim(raw_output13)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output14),",","",.)) if source_year==2014
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2014
replace st_val_output=5 if source_year==2014 & missing(val_output) & !inlist(upper(strtrim(raw_output14)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output17),",","",.)) if source_year==2017
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2017
replace st_val_output=5 if source_year==2017 & missing(val_output) & !inlist(upper(strtrim(raw_output17)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output18),",","",.)) if source_year==2018
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2018
replace st_val_output=5 if source_year==2018 & missing(val_output) & !inlist(upper(strtrim(raw_output18)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output19),",","",.)) if source_year==2019
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2019
replace st_val_output=5 if source_year==2019 & missing(val_output) & !inlist(upper(strtrim(raw_output19)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output20),",","",.)) if source_year==2020
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2020
replace st_val_output=5 if source_year==2020 & missing(val_output) & !inlist(upper(strtrim(raw_output20)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output21),",","",.)) if source_year==2021
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2021
replace st_val_output=5 if source_year==2021 & missing(val_output) & !inlist(upper(strtrim(raw_output21)),"","***",".","NA","N/A","NULL","-")
replace val_output=real(subinstr(strtrim(raw_output22),",","",.)) if source_year==2022
replace st_val_output=cond(missing(val_output),3,cond(val_output<0,2,cond(val_output==0,1,0))) if source_year==2022
replace st_val_output=5 if source_year==2022 & missing(val_output) & !inlist(upper(strtrim(raw_output22)),"","***",".","NA","N/A","NULL","-")
label values st_val_output G0_source_state
generate double val_rdnvcu=.
generate byte st_val_rdnvcu=4
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu10),",","",.)) if source_year==2010
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2010
replace st_val_rdnvcu=5 if source_year==2010 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu11),",","",.)) if source_year==2011
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2011
replace st_val_rdnvcu=5 if source_year==2011 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu12),",","",.)) if source_year==2012
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2012
replace st_val_rdnvcu=5 if source_year==2012 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu13),",","",.)) if source_year==2013
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2013
replace st_val_rdnvcu=5 if source_year==2013 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu14),",","",.)) if source_year==2014
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2014
replace st_val_rdnvcu=5 if source_year==2014 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu),",","",.)) if source_year==2015
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2015
replace st_val_rdnvcu=5 if source_year==2015 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu17),",","",.)) if source_year==2017
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2017
replace st_val_rdnvcu=5 if source_year==2017 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu18),",","",.)) if source_year==2018
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2018
replace st_val_rdnvcu=5 if source_year==2018 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu19),",","",.)) if source_year==2019
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2019
replace st_val_rdnvcu=5 if source_year==2019 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu20),",","",.)) if source_year==2020
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2020
replace st_val_rdnvcu=5 if source_year==2020 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu21),",","",.)) if source_year==2021
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2021
replace st_val_rdnvcu=5 if source_year==2021 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_rdnvcu=real(subinstr(strtrim(raw_rdnvcu22),",","",.)) if source_year==2022
replace st_val_rdnvcu=cond(missing(val_rdnvcu),3,cond(val_rdnvcu<0,2,cond(val_rdnvcu==0,1,0))) if source_year==2022
replace st_val_rdnvcu=5 if source_year==2022 & missing(val_rdnvcu) & !inlist(upper(strtrim(raw_rdnvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_rdnvcu G0_source_state
generate double val_renvcu=.
generate byte st_val_renvcu=4
replace val_renvcu=real(subinstr(strtrim(raw_renvcu17),",","",.)) if source_year==2017
replace st_val_renvcu=cond(missing(val_renvcu),3,cond(val_renvcu<0,2,cond(val_renvcu==0,1,0))) if source_year==2017
replace st_val_renvcu=5 if source_year==2017 & missing(val_renvcu) & !inlist(upper(strtrim(raw_renvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_renvcu=real(subinstr(strtrim(raw_renvcu18),",","",.)) if source_year==2018
replace st_val_renvcu=cond(missing(val_renvcu),3,cond(val_renvcu<0,2,cond(val_renvcu==0,1,0))) if source_year==2018
replace st_val_renvcu=5 if source_year==2018 & missing(val_renvcu) & !inlist(upper(strtrim(raw_renvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_renvcu=real(subinstr(strtrim(raw_renvcu19),",","",.)) if source_year==2019
replace st_val_renvcu=cond(missing(val_renvcu),3,cond(val_renvcu<0,2,cond(val_renvcu==0,1,0))) if source_year==2019
replace st_val_renvcu=5 if source_year==2019 & missing(val_renvcu) & !inlist(upper(strtrim(raw_renvcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_renvcu G0_source_state
generate double val_rimvcu=.
generate byte st_val_rimvcu=4
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu10),",","",.)) if source_year==2010
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2010
replace st_val_rimvcu=5 if source_year==2010 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu11),",","",.)) if source_year==2011
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2011
replace st_val_rimvcu=5 if source_year==2011 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu12),",","",.)) if source_year==2012
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2012
replace st_val_rimvcu=5 if source_year==2012 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu13),",","",.)) if source_year==2013
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2013
replace st_val_rimvcu=5 if source_year==2013 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu14),",","",.)) if source_year==2014
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2014
replace st_val_rimvcu=5 if source_year==2014 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu),",","",.)) if source_year==2015
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2015
replace st_val_rimvcu=5 if source_year==2015 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu17),",","",.)) if source_year==2017
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2017
replace st_val_rimvcu=5 if source_year==2017 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu18),",","",.)) if source_year==2018
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2018
replace st_val_rimvcu=5 if source_year==2018 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu19),",","",.)) if source_year==2019
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2019
replace st_val_rimvcu=5 if source_year==2019 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu20),",","",.)) if source_year==2020
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2020
replace st_val_rimvcu=5 if source_year==2020 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu21),",","",.)) if source_year==2021
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2021
replace st_val_rimvcu=5 if source_year==2021 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_rimvcu=real(subinstr(strtrim(raw_rimvcu22),",","",.)) if source_year==2022
replace st_val_rimvcu=cond(missing(val_rimvcu),3,cond(val_rimvcu<0,2,cond(val_rimvcu==0,1,0))) if source_year==2022
replace st_val_rimvcu=5 if source_year==2022 & missing(val_rimvcu) & !inlist(upper(strtrim(raw_rimvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_rimvcu G0_source_state
generate double val_rtlvcu=.
generate byte st_val_rtlvcu=4
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu10),",","",.)) if source_year==2010
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2010
replace st_val_rtlvcu=5 if source_year==2010 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu11),",","",.)) if source_year==2011
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2011
replace st_val_rtlvcu=5 if source_year==2011 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu12),",","",.)) if source_year==2012
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2012
replace st_val_rtlvcu=5 if source_year==2012 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu13),",","",.)) if source_year==2013
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2013
replace st_val_rtlvcu=5 if source_year==2013 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu14),",","",.)) if source_year==2014
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2014
replace st_val_rtlvcu=5 if source_year==2014 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu),",","",.)) if source_year==2015
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2015
replace st_val_rtlvcu=5 if source_year==2015 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu17),",","",.)) if source_year==2017
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2017
replace st_val_rtlvcu=5 if source_year==2017 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu18),",","",.)) if source_year==2018
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2018
replace st_val_rtlvcu=5 if source_year==2018 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu19),",","",.)) if source_year==2019
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2019
replace st_val_rtlvcu=5 if source_year==2019 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu20),",","",.)) if source_year==2020
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2020
replace st_val_rtlvcu=5 if source_year==2020 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu21),",","",.)) if source_year==2021
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2021
replace st_val_rtlvcu=5 if source_year==2021 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_rtlvcu=real(subinstr(strtrim(raw_rtlvcu22),",","",.)) if source_year==2022
replace st_val_rtlvcu=cond(missing(val_rtlvcu),3,cond(val_rtlvcu<0,2,cond(val_rtlvcu==0,1,0))) if source_year==2022
replace st_val_rtlvcu=5 if source_year==2022 & missing(val_rtlvcu) & !inlist(upper(strtrim(raw_rtlvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_rtlvcu G0_source_state
generate double val_sfbvcu=.
generate byte st_val_sfbvcu=4
replace val_sfbvcu=real(subinstr(strtrim(raw_sfbvcu20),",","",.)) if source_year==2020
replace st_val_sfbvcu=cond(missing(val_sfbvcu),3,cond(val_sfbvcu<0,2,cond(val_sfbvcu==0,1,0))) if source_year==2020
replace st_val_sfbvcu=5 if source_year==2020 & missing(val_sfbvcu) & !inlist(upper(strtrim(raw_sfbvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfbvcu=real(subinstr(strtrim(raw_sfbvcu21),",","",.)) if source_year==2021
replace st_val_sfbvcu=cond(missing(val_sfbvcu),3,cond(val_sfbvcu<0,2,cond(val_sfbvcu==0,1,0))) if source_year==2021
replace st_val_sfbvcu=5 if source_year==2021 & missing(val_sfbvcu) & !inlist(upper(strtrim(raw_sfbvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfbvcu G0_source_state
generate double val_sfcvcu=.
generate byte st_val_sfcvcu=4
replace val_sfcvcu=real(subinstr(strtrim(raw_sfcvcu20),",","",.)) if source_year==2020
replace st_val_sfcvcu=cond(missing(val_sfcvcu),3,cond(val_sfcvcu<0,2,cond(val_sfcvcu==0,1,0))) if source_year==2020
replace st_val_sfcvcu=5 if source_year==2020 & missing(val_sfcvcu) & !inlist(upper(strtrim(raw_sfcvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfcvcu=real(subinstr(strtrim(raw_sfcvcu21),",","",.)) if source_year==2021
replace st_val_sfcvcu=cond(missing(val_sfcvcu),3,cond(val_sfcvcu<0,2,cond(val_sfcvcu==0,1,0))) if source_year==2021
replace st_val_sfcvcu=5 if source_year==2021 & missing(val_sfcvcu) & !inlist(upper(strtrim(raw_sfcvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfcvcu G0_source_state
generate double val_sfdvcu=.
generate byte st_val_sfdvcu=4
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu10),",","",.)) if source_year==2010
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2010
replace st_val_sfdvcu=5 if source_year==2010 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu11),",","",.)) if source_year==2011
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2011
replace st_val_sfdvcu=5 if source_year==2011 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu12),",","",.)) if source_year==2012
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2012
replace st_val_sfdvcu=5 if source_year==2012 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu13),",","",.)) if source_year==2013
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2013
replace st_val_sfdvcu=5 if source_year==2013 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu14),",","",.)) if source_year==2014
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2014
replace st_val_sfdvcu=5 if source_year==2014 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu),",","",.)) if source_year==2015
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2015
replace st_val_sfdvcu=5 if source_year==2015 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu17),",","",.)) if source_year==2017
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2017
replace st_val_sfdvcu=5 if source_year==2017 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu18),",","",.)) if source_year==2018
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2018
replace st_val_sfdvcu=5 if source_year==2018 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu19),",","",.)) if source_year==2019
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2019
replace st_val_sfdvcu=5 if source_year==2019 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu20),",","",.)) if source_year==2020
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2020
replace st_val_sfdvcu=5 if source_year==2020 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu21),",","",.)) if source_year==2021
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2021
replace st_val_sfdvcu=5 if source_year==2021 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_sfdvcu=real(subinstr(strtrim(raw_sfdvcu22),",","",.)) if source_year==2022
replace st_val_sfdvcu=cond(missing(val_sfdvcu),3,cond(val_sfdvcu<0,2,cond(val_sfdvcu==0,1,0))) if source_year==2022
replace st_val_sfdvcu=5 if source_year==2022 & missing(val_sfdvcu) & !inlist(upper(strtrim(raw_sfdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfdvcu G0_source_state
generate double val_sfgvcu=.
generate byte st_val_sfgvcu=4
replace val_sfgvcu=real(subinstr(strtrim(raw_sfgvcu20),",","",.)) if source_year==2020
replace st_val_sfgvcu=cond(missing(val_sfgvcu),3,cond(val_sfgvcu<0,2,cond(val_sfgvcu==0,1,0))) if source_year==2020
replace st_val_sfgvcu=5 if source_year==2020 & missing(val_sfgvcu) & !inlist(upper(strtrim(raw_sfgvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfgvcu=real(subinstr(strtrim(raw_sfgvcu21),",","",.)) if source_year==2021
replace st_val_sfgvcu=cond(missing(val_sfgvcu),3,cond(val_sfgvcu<0,2,cond(val_sfgvcu==0,1,0))) if source_year==2021
replace st_val_sfgvcu=5 if source_year==2021 & missing(val_sfgvcu) & !inlist(upper(strtrim(raw_sfgvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfgvcu G0_source_state
generate double val_sfjvcu=.
generate byte st_val_sfjvcu=4
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu10),",","",.)) if source_year==2010
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2010
replace st_val_sfjvcu=5 if source_year==2010 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu11),",","",.)) if source_year==2011
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2011
replace st_val_sfjvcu=5 if source_year==2011 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu12),",","",.)) if source_year==2012
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2012
replace st_val_sfjvcu=5 if source_year==2012 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu13),",","",.)) if source_year==2013
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2013
replace st_val_sfjvcu=5 if source_year==2013 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu14),",","",.)) if source_year==2014
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2014
replace st_val_sfjvcu=5 if source_year==2014 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu),",","",.)) if source_year==2015
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2015
replace st_val_sfjvcu=5 if source_year==2015 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu17),",","",.)) if source_year==2017
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2017
replace st_val_sfjvcu=5 if source_year==2017 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu18),",","",.)) if source_year==2018
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2018
replace st_val_sfjvcu=5 if source_year==2018 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu19),",","",.)) if source_year==2019
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2019
replace st_val_sfjvcu=5 if source_year==2019 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu20),",","",.)) if source_year==2020
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2020
replace st_val_sfjvcu=5 if source_year==2020 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu21),",","",.)) if source_year==2021
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2021
replace st_val_sfjvcu=5 if source_year==2021 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_sfjvcu=real(subinstr(strtrim(raw_sfjvcu22),",","",.)) if source_year==2022
replace st_val_sfjvcu=cond(missing(val_sfjvcu),3,cond(val_sfjvcu<0,2,cond(val_sfjvcu==0,1,0))) if source_year==2022
replace st_val_sfjvcu=5 if source_year==2022 & missing(val_sfjvcu) & !inlist(upper(strtrim(raw_sfjvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfjvcu G0_source_state
generate double val_sfkvcu=.
generate byte st_val_sfkvcu=4
replace val_sfkvcu=real(subinstr(strtrim(raw_sfkvcu20),",","",.)) if source_year==2020
replace st_val_sfkvcu=cond(missing(val_sfkvcu),3,cond(val_sfkvcu<0,2,cond(val_sfkvcu==0,1,0))) if source_year==2020
replace st_val_sfkvcu=5 if source_year==2020 & missing(val_sfkvcu) & !inlist(upper(strtrim(raw_sfkvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfkvcu=real(subinstr(strtrim(raw_sfkvcu21),",","",.)) if source_year==2021
replace st_val_sfkvcu=cond(missing(val_sfkvcu),3,cond(val_sfkvcu<0,2,cond(val_sfkvcu==0,1,0))) if source_year==2021
replace st_val_sfkvcu=5 if source_year==2021 & missing(val_sfkvcu) & !inlist(upper(strtrim(raw_sfkvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfkvcu G0_source_state
generate double val_sfnvcu=.
generate byte st_val_sfnvcu=4
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu10),",","",.)) if source_year==2010
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2010
replace st_val_sfnvcu=5 if source_year==2010 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu11),",","",.)) if source_year==2011
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2011
replace st_val_sfnvcu=5 if source_year==2011 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu12),",","",.)) if source_year==2012
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2012
replace st_val_sfnvcu=5 if source_year==2012 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu13),",","",.)) if source_year==2013
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2013
replace st_val_sfnvcu=5 if source_year==2013 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu14),",","",.)) if source_year==2014
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2014
replace st_val_sfnvcu=5 if source_year==2014 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu),",","",.)) if source_year==2015
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2015
replace st_val_sfnvcu=5 if source_year==2015 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu17),",","",.)) if source_year==2017
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2017
replace st_val_sfnvcu=5 if source_year==2017 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu18),",","",.)) if source_year==2018
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2018
replace st_val_sfnvcu=5 if source_year==2018 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu19),",","",.)) if source_year==2019
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2019
replace st_val_sfnvcu=5 if source_year==2019 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu20),",","",.)) if source_year==2020
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2020
replace st_val_sfnvcu=5 if source_year==2020 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu21),",","",.)) if source_year==2021
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2021
replace st_val_sfnvcu=5 if source_year==2021 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_sfnvcu=real(subinstr(strtrim(raw_sfnvcu22),",","",.)) if source_year==2022
replace st_val_sfnvcu=cond(missing(val_sfnvcu),3,cond(val_sfnvcu<0,2,cond(val_sfnvcu==0,1,0))) if source_year==2022
replace st_val_sfnvcu=5 if source_year==2022 & missing(val_sfnvcu) & !inlist(upper(strtrim(raw_sfnvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfnvcu G0_source_state
generate double val_sfovcu=.
generate byte st_val_sfovcu=4
replace val_sfovcu=real(subinstr(strtrim(raw_sfovcu20),",","",.)) if source_year==2020
replace st_val_sfovcu=cond(missing(val_sfovcu),3,cond(val_sfovcu<0,2,cond(val_sfovcu==0,1,0))) if source_year==2020
replace st_val_sfovcu=5 if source_year==2020 & missing(val_sfovcu) & !inlist(upper(strtrim(raw_sfovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfovcu=real(subinstr(strtrim(raw_sfovcu21),",","",.)) if source_year==2021
replace st_val_sfovcu=cond(missing(val_sfovcu),3,cond(val_sfovcu<0,2,cond(val_sfovcu==0,1,0))) if source_year==2021
replace st_val_sfovcu=5 if source_year==2021 & missing(val_sfovcu) & !inlist(upper(strtrim(raw_sfovcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfovcu G0_source_state
generate double val_sfrvcu=.
generate byte st_val_sfrvcu=4
replace val_sfrvcu=real(subinstr(strtrim(raw_sfrvcu20),",","",.)) if source_year==2020
replace st_val_sfrvcu=cond(missing(val_sfrvcu),3,cond(val_sfrvcu<0,2,cond(val_sfrvcu==0,1,0))) if source_year==2020
replace st_val_sfrvcu=5 if source_year==2020 & missing(val_sfrvcu) & !inlist(upper(strtrim(raw_sfrvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfrvcu=real(subinstr(strtrim(raw_sfrvcu21),",","",.)) if source_year==2021
replace st_val_sfrvcu=cond(missing(val_sfrvcu),3,cond(val_sfrvcu<0,2,cond(val_sfrvcu==0,1,0))) if source_year==2021
replace st_val_sfrvcu=5 if source_year==2021 & missing(val_sfrvcu) & !inlist(upper(strtrim(raw_sfrvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfrvcu G0_source_state
generate double val_sfsvcu=.
generate byte st_val_sfsvcu=4
replace val_sfsvcu=real(subinstr(strtrim(raw_sfsvcu20),",","",.)) if source_year==2020
replace st_val_sfsvcu=cond(missing(val_sfsvcu),3,cond(val_sfsvcu<0,2,cond(val_sfsvcu==0,1,0))) if source_year==2020
replace st_val_sfsvcu=5 if source_year==2020 & missing(val_sfsvcu) & !inlist(upper(strtrim(raw_sfsvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfsvcu=real(subinstr(strtrim(raw_sfsvcu21),",","",.)) if source_year==2021
replace st_val_sfsvcu=cond(missing(val_sfsvcu),3,cond(val_sfsvcu<0,2,cond(val_sfsvcu==0,1,0))) if source_year==2021
replace st_val_sfsvcu=5 if source_year==2021 & missing(val_sfsvcu) & !inlist(upper(strtrim(raw_sfsvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfsvcu G0_source_state
generate double val_sfuvcu=.
generate byte st_val_sfuvcu=4
replace val_sfuvcu=real(subinstr(strtrim(raw_sfuvcu20),",","",.)) if source_year==2020
replace st_val_sfuvcu=cond(missing(val_sfuvcu),3,cond(val_sfuvcu<0,2,cond(val_sfuvcu==0,1,0))) if source_year==2020
replace st_val_sfuvcu=5 if source_year==2020 & missing(val_sfuvcu) & !inlist(upper(strtrim(raw_sfuvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_sfuvcu=real(subinstr(strtrim(raw_sfuvcu21),",","",.)) if source_year==2021
replace st_val_sfuvcu=cond(missing(val_sfuvcu),3,cond(val_sfuvcu<0,2,cond(val_sfuvcu==0,1,0))) if source_year==2021
replace st_val_sfuvcu=5 if source_year==2021 & missing(val_sfuvcu) & !inlist(upper(strtrim(raw_sfuvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_sfuvcu G0_source_state
generate double val_shdvcu=.
generate byte st_val_shdvcu=4
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu10),",","",.)) if source_year==2010
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2010
replace st_val_shdvcu=5 if source_year==2010 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu11),",","",.)) if source_year==2011
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2011
replace st_val_shdvcu=5 if source_year==2011 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu12),",","",.)) if source_year==2012
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2012
replace st_val_shdvcu=5 if source_year==2012 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu13),",","",.)) if source_year==2013
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2013
replace st_val_shdvcu=5 if source_year==2013 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu14),",","",.)) if source_year==2014
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2014
replace st_val_shdvcu=5 if source_year==2014 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu),",","",.)) if source_year==2015
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2015
replace st_val_shdvcu=5 if source_year==2015 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu17),",","",.)) if source_year==2017
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2017
replace st_val_shdvcu=5 if source_year==2017 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu18),",","",.)) if source_year==2018
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2018
replace st_val_shdvcu=5 if source_year==2018 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu19),",","",.)) if source_year==2019
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2019
replace st_val_shdvcu=5 if source_year==2019 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu20),",","",.)) if source_year==2020
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2020
replace st_val_shdvcu=5 if source_year==2020 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu21),",","",.)) if source_year==2021
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2021
replace st_val_shdvcu=5 if source_year==2021 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_shdvcu=real(subinstr(strtrim(raw_shdvcu22),",","",.)) if source_year==2022
replace st_val_shdvcu=cond(missing(val_shdvcu),3,cond(val_shdvcu<0,2,cond(val_shdvcu==0,1,0))) if source_year==2022
replace st_val_shdvcu=5 if source_year==2022 & missing(val_shdvcu) & !inlist(upper(strtrim(raw_shdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_shdvcu G0_source_state
generate double val_shfvcu=.
generate byte st_val_shfvcu=4
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu10),",","",.)) if source_year==2010
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2010
replace st_val_shfvcu=5 if source_year==2010 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu11),",","",.)) if source_year==2011
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2011
replace st_val_shfvcu=5 if source_year==2011 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu12),",","",.)) if source_year==2012
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2012
replace st_val_shfvcu=5 if source_year==2012 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu13),",","",.)) if source_year==2013
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2013
replace st_val_shfvcu=5 if source_year==2013 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu14),",","",.)) if source_year==2014
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2014
replace st_val_shfvcu=5 if source_year==2014 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu),",","",.)) if source_year==2015
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2015
replace st_val_shfvcu=5 if source_year==2015 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu17),",","",.)) if source_year==2017
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2017
replace st_val_shfvcu=5 if source_year==2017 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu18),",","",.)) if source_year==2018
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2018
replace st_val_shfvcu=5 if source_year==2018 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu19),",","",.)) if source_year==2019
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2019
replace st_val_shfvcu=5 if source_year==2019 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu20),",","",.)) if source_year==2020
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2020
replace st_val_shfvcu=5 if source_year==2020 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu21),",","",.)) if source_year==2021
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2021
replace st_val_shfvcu=5 if source_year==2021 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_shfvcu=real(subinstr(strtrim(raw_shfvcu22),",","",.)) if source_year==2022
replace st_val_shfvcu=cond(missing(val_shfvcu),3,cond(val_shfvcu<0,2,cond(val_shfvcu==0,1,0))) if source_year==2022
replace st_val_shfvcu=5 if source_year==2022 & missing(val_shfvcu) & !inlist(upper(strtrim(raw_shfvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_shfvcu G0_source_state
generate double val_shjvcu=.
generate byte st_val_shjvcu=4
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu10),",","",.)) if source_year==2010
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2010
replace st_val_shjvcu=5 if source_year==2010 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu11),",","",.)) if source_year==2011
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2011
replace st_val_shjvcu=5 if source_year==2011 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu12),",","",.)) if source_year==2012
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2012
replace st_val_shjvcu=5 if source_year==2012 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu13),",","",.)) if source_year==2013
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2013
replace st_val_shjvcu=5 if source_year==2013 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu14),",","",.)) if source_year==2014
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2014
replace st_val_shjvcu=5 if source_year==2014 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu),",","",.)) if source_year==2015
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2015
replace st_val_shjvcu=5 if source_year==2015 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu17),",","",.)) if source_year==2017
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2017
replace st_val_shjvcu=5 if source_year==2017 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu18),",","",.)) if source_year==2018
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2018
replace st_val_shjvcu=5 if source_year==2018 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu19),",","",.)) if source_year==2019
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2019
replace st_val_shjvcu=5 if source_year==2019 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu20),",","",.)) if source_year==2020
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2020
replace st_val_shjvcu=5 if source_year==2020 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu21),",","",.)) if source_year==2021
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2021
replace st_val_shjvcu=5 if source_year==2021 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_shjvcu=real(subinstr(strtrim(raw_shjvcu22),",","",.)) if source_year==2022
replace st_val_shjvcu=cond(missing(val_shjvcu),3,cond(val_shjvcu<0,2,cond(val_shjvcu==0,1,0))) if source_year==2022
replace st_val_shjvcu=5 if source_year==2022 & missing(val_shjvcu) & !inlist(upper(strtrim(raw_shjvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_shjvcu G0_source_state
generate double val_srdvcu=.
generate byte st_val_srdvcu=4
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu10),",","",.)) if source_year==2010
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2010
replace st_val_srdvcu=5 if source_year==2010 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu11),",","",.)) if source_year==2011
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2011
replace st_val_srdvcu=5 if source_year==2011 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu12),",","",.)) if source_year==2012
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2012
replace st_val_srdvcu=5 if source_year==2012 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu13),",","",.)) if source_year==2013
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2013
replace st_val_srdvcu=5 if source_year==2013 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu14),",","",.)) if source_year==2014
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2014
replace st_val_srdvcu=5 if source_year==2014 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu),",","",.)) if source_year==2015
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2015
replace st_val_srdvcu=5 if source_year==2015 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu17),",","",.)) if source_year==2017
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2017
replace st_val_srdvcu=5 if source_year==2017 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu18),",","",.)) if source_year==2018
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2018
replace st_val_srdvcu=5 if source_year==2018 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu19),",","",.)) if source_year==2019
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2019
replace st_val_srdvcu=5 if source_year==2019 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu20),",","",.)) if source_year==2020
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2020
replace st_val_srdvcu=5 if source_year==2020 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu21),",","",.)) if source_year==2021
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2021
replace st_val_srdvcu=5 if source_year==2021 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_srdvcu=real(subinstr(strtrim(raw_srdvcu22),",","",.)) if source_year==2022
replace st_val_srdvcu=cond(missing(val_srdvcu),3,cond(val_srdvcu<0,2,cond(val_srdvcu==0,1,0))) if source_year==2022
replace st_val_srdvcu=5 if source_year==2022 & missing(val_srdvcu) & !inlist(upper(strtrim(raw_srdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_srdvcu G0_source_state
generate double val_srjvcu=.
generate byte st_val_srjvcu=4
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu10),",","",.)) if source_year==2010
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2010
replace st_val_srjvcu=5 if source_year==2010 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu11),",","",.)) if source_year==2011
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2011
replace st_val_srjvcu=5 if source_year==2011 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu12),",","",.)) if source_year==2012
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2012
replace st_val_srjvcu=5 if source_year==2012 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu13),",","",.)) if source_year==2013
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2013
replace st_val_srjvcu=5 if source_year==2013 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu14),",","",.)) if source_year==2014
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2014
replace st_val_srjvcu=5 if source_year==2014 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu),",","",.)) if source_year==2015
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2015
replace st_val_srjvcu=5 if source_year==2015 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu17),",","",.)) if source_year==2017
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2017
replace st_val_srjvcu=5 if source_year==2017 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu18),",","",.)) if source_year==2018
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2018
replace st_val_srjvcu=5 if source_year==2018 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu19),",","",.)) if source_year==2019
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2019
replace st_val_srjvcu=5 if source_year==2019 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu20),",","",.)) if source_year==2020
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2020
replace st_val_srjvcu=5 if source_year==2020 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu21),",","",.)) if source_year==2021
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2021
replace st_val_srjvcu=5 if source_year==2021 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_srjvcu=real(subinstr(strtrim(raw_srjvcu22),",","",.)) if source_year==2022
replace st_val_srjvcu=cond(missing(val_srjvcu),3,cond(val_srjvcu<0,2,cond(val_srjvcu==0,1,0))) if source_year==2022
replace st_val_srjvcu=5 if source_year==2022 & missing(val_srjvcu) & !inlist(upper(strtrim(raw_srjvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_srjvcu G0_source_state
generate double val_srmvcu=.
generate byte st_val_srmvcu=4
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu10),",","",.)) if source_year==2010
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2010
replace st_val_srmvcu=5 if source_year==2010 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu11),",","",.)) if source_year==2011
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2011
replace st_val_srmvcu=5 if source_year==2011 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu12),",","",.)) if source_year==2012
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2012
replace st_val_srmvcu=5 if source_year==2012 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu13),",","",.)) if source_year==2013
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2013
replace st_val_srmvcu=5 if source_year==2013 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu14),",","",.)) if source_year==2014
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2014
replace st_val_srmvcu=5 if source_year==2014 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu),",","",.)) if source_year==2015
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2015
replace st_val_srmvcu=5 if source_year==2015 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu17),",","",.)) if source_year==2017
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2017
replace st_val_srmvcu=5 if source_year==2017 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu18),",","",.)) if source_year==2018
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2018
replace st_val_srmvcu=5 if source_year==2018 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu19),",","",.)) if source_year==2019
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2019
replace st_val_srmvcu=5 if source_year==2019 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu20),",","",.)) if source_year==2020
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2020
replace st_val_srmvcu=5 if source_year==2020 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu21),",","",.)) if source_year==2021
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2021
replace st_val_srmvcu=5 if source_year==2021 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_srmvcu=real(subinstr(strtrim(raw_srmvcu22),",","",.)) if source_year==2022
replace st_val_srmvcu=cond(missing(val_srmvcu),3,cond(val_srmvcu<0,2,cond(val_srmvcu==0,1,0))) if source_year==2022
replace st_val_srmvcu=5 if source_year==2022 & missing(val_srmvcu) & !inlist(upper(strtrim(raw_srmvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_srmvcu G0_source_state
generate double val_stdvcu=.
generate byte st_val_stdvcu=4
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu10),",","",.)) if source_year==2010
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2010
replace st_val_stdvcu=5 if source_year==2010 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu11),",","",.)) if source_year==2011
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2011
replace st_val_stdvcu=5 if source_year==2011 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu12),",","",.)) if source_year==2012
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2012
replace st_val_stdvcu=5 if source_year==2012 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu13),",","",.)) if source_year==2013
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2013
replace st_val_stdvcu=5 if source_year==2013 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu14),",","",.)) if source_year==2014
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2014
replace st_val_stdvcu=5 if source_year==2014 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu),",","",.)) if source_year==2015
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2015
replace st_val_stdvcu=5 if source_year==2015 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu17),",","",.)) if source_year==2017
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2017
replace st_val_stdvcu=5 if source_year==2017 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu18),",","",.)) if source_year==2018
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2018
replace st_val_stdvcu=5 if source_year==2018 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu19),",","",.)) if source_year==2019
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2019
replace st_val_stdvcu=5 if source_year==2019 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu20),",","",.)) if source_year==2020
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2020
replace st_val_stdvcu=5 if source_year==2020 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu21),",","",.)) if source_year==2021
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2021
replace st_val_stdvcu=5 if source_year==2021 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_stdvcu=real(subinstr(strtrim(raw_stdvcu22),",","",.)) if source_year==2022
replace st_val_stdvcu=cond(missing(val_stdvcu),3,cond(val_stdvcu<0,2,cond(val_stdvcu==0,1,0))) if source_year==2022
replace st_val_stdvcu=5 if source_year==2022 & missing(val_stdvcu) & !inlist(upper(strtrim(raw_stdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_stdvcu G0_source_state
generate double val_stjvcu=.
generate byte st_val_stjvcu=4
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu10),",","",.)) if source_year==2010
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2010
replace st_val_stjvcu=5 if source_year==2010 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu11),",","",.)) if source_year==2011
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2011
replace st_val_stjvcu=5 if source_year==2011 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu12),",","",.)) if source_year==2012
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2012
replace st_val_stjvcu=5 if source_year==2012 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu13),",","",.)) if source_year==2013
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2013
replace st_val_stjvcu=5 if source_year==2013 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu14),",","",.)) if source_year==2014
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2014
replace st_val_stjvcu=5 if source_year==2014 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu),",","",.)) if source_year==2015
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2015
replace st_val_stjvcu=5 if source_year==2015 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu17),",","",.)) if source_year==2017
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2017
replace st_val_stjvcu=5 if source_year==2017 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu18),",","",.)) if source_year==2018
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2018
replace st_val_stjvcu=5 if source_year==2018 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu19),",","",.)) if source_year==2019
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2019
replace st_val_stjvcu=5 if source_year==2019 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu20),",","",.)) if source_year==2020
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2020
replace st_val_stjvcu=5 if source_year==2020 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu21),",","",.)) if source_year==2021
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2021
replace st_val_stjvcu=5 if source_year==2021 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_stjvcu=real(subinstr(strtrim(raw_stjvcu22),",","",.)) if source_year==2022
replace st_val_stjvcu=cond(missing(val_stjvcu),3,cond(val_stjvcu<0,2,cond(val_stjvcu==0,1,0))) if source_year==2022
replace st_val_stjvcu=5 if source_year==2022 & missing(val_stjvcu) & !inlist(upper(strtrim(raw_stjvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_stjvcu G0_source_state
generate double val_stlvcu=.
generate byte st_val_stlvcu=4
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu10),",","",.)) if source_year==2010
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2010
replace st_val_stlvcu=5 if source_year==2010 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu11),",","",.)) if source_year==2011
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2011
replace st_val_stlvcu=5 if source_year==2011 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu12),",","",.)) if source_year==2012
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2012
replace st_val_stlvcu=5 if source_year==2012 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu13),",","",.)) if source_year==2013
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2013
replace st_val_stlvcu=5 if source_year==2013 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu14),",","",.)) if source_year==2014
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2014
replace st_val_stlvcu=5 if source_year==2014 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu),",","",.)) if source_year==2015
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2015
replace st_val_stlvcu=5 if source_year==2015 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu17),",","",.)) if source_year==2017
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2017
replace st_val_stlvcu=5 if source_year==2017 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu18),",","",.)) if source_year==2018
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2018
replace st_val_stlvcu=5 if source_year==2018 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu19),",","",.)) if source_year==2019
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2019
replace st_val_stlvcu=5 if source_year==2019 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu20),",","",.)) if source_year==2020
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2020
replace st_val_stlvcu=5 if source_year==2020 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu21),",","",.)) if source_year==2021
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2021
replace st_val_stlvcu=5 if source_year==2021 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_stlvcu=real(subinstr(strtrim(raw_stlvcu22),",","",.)) if source_year==2022
replace st_val_stlvcu=cond(missing(val_stlvcu),3,cond(val_stlvcu<0,2,cond(val_stlvcu==0,1,0))) if source_year==2022
replace st_val_stlvcu=5 if source_year==2022 & missing(val_stlvcu) & !inlist(upper(strtrim(raw_stlvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_stlvcu G0_source_state
generate double val_vtlvcu=.
generate byte st_val_vtlvcu=4
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu10),",","",.)) if source_year==2010
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2010
replace st_val_vtlvcu=5 if source_year==2010 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu11),",","",.)) if source_year==2011
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2011
replace st_val_vtlvcu=5 if source_year==2011 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu12),",","",.)) if source_year==2012
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2012
replace st_val_vtlvcu=5 if source_year==2012 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu13),",","",.)) if source_year==2013
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2013
replace st_val_vtlvcu=5 if source_year==2013 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu14),",","",.)) if source_year==2014
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2014
replace st_val_vtlvcu=5 if source_year==2014 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu17),",","",.)) if source_year==2017
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2017
replace st_val_vtlvcu=5 if source_year==2017 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu18),",","",.)) if source_year==2018
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2018
replace st_val_vtlvcu=5 if source_year==2018 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu19),",","",.)) if source_year==2019
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2019
replace st_val_vtlvcu=5 if source_year==2019 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu20),",","",.)) if source_year==2020
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2020
replace st_val_vtlvcu=5 if source_year==2020 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu21),",","",.)) if source_year==2021
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2021
replace st_val_vtlvcu=5 if source_year==2021 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_vtlvcu=real(subinstr(strtrim(raw_vtlvcu22),",","",.)) if source_year==2022
replace st_val_vtlvcu=cond(missing(val_vtlvcu),3,cond(val_vtlvcu<0,2,cond(val_vtlvcu==0,1,0))) if source_year==2022
replace st_val_vtlvcu=5 if source_year==2022 & missing(val_vtlvcu) & !inlist(upper(strtrim(raw_vtlvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_vtlvcu G0_source_state
generate double val_yelvcu=.
generate byte st_val_yelvcu=4
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu10),",","",.)) if source_year==2010
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2010
replace st_val_yelvcu=5 if source_year==2010 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu11),",","",.)) if source_year==2011
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2011
replace st_val_yelvcu=5 if source_year==2011 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu12),",","",.)) if source_year==2012
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2012
replace st_val_yelvcu=5 if source_year==2012 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu13),",","",.)) if source_year==2013
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2013
replace st_val_yelvcu=5 if source_year==2013 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu14),",","",.)) if source_year==2014
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2014
replace st_val_yelvcu=5 if source_year==2014 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu),",","",.)) if source_year==2015
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2015
replace st_val_yelvcu=5 if source_year==2015 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu17),",","",.)) if source_year==2017
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2017
replace st_val_yelvcu=5 if source_year==2017 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu18),",","",.)) if source_year==2018
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2018
replace st_val_yelvcu=5 if source_year==2018 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu19),",","",.)) if source_year==2019
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2019
replace st_val_yelvcu=5 if source_year==2019 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu20),",","",.)) if source_year==2020
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2020
replace st_val_yelvcu=5 if source_year==2020 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu21),",","",.)) if source_year==2021
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2021
replace st_val_yelvcu=5 if source_year==2021 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_yelvcu=real(subinstr(strtrim(raw_yelvcu22),",","",.)) if source_year==2022
replace st_val_yelvcu=cond(missing(val_yelvcu),3,cond(val_yelvcu<0,2,cond(val_yelvcu==0,1,0))) if source_year==2022
replace st_val_yelvcu=5 if source_year==2022 & missing(val_yelvcu) & !inlist(upper(strtrim(raw_yelvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yelvcu G0_source_state
generate double val_yisvcu=.
generate byte st_val_yisvcu=4
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu10),",","",.)) if source_year==2010
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2010
replace st_val_yisvcu=5 if source_year==2010 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu11),",","",.)) if source_year==2011
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2011
replace st_val_yisvcu=5 if source_year==2011 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu12),",","",.)) if source_year==2012
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2012
replace st_val_yisvcu=5 if source_year==2012 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu13),",","",.)) if source_year==2013
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2013
replace st_val_yisvcu=5 if source_year==2013 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu14),",","",.)) if source_year==2014
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2014
replace st_val_yisvcu=5 if source_year==2014 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu),",","",.)) if source_year==2015
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2015
replace st_val_yisvcu=5 if source_year==2015 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu17),",","",.)) if source_year==2017
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2017
replace st_val_yisvcu=5 if source_year==2017 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu18),",","",.)) if source_year==2018
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2018
replace st_val_yisvcu=5 if source_year==2018 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu19),",","",.)) if source_year==2019
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2019
replace st_val_yisvcu=5 if source_year==2019 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu20),",","",.)) if source_year==2020
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2020
replace st_val_yisvcu=5 if source_year==2020 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu21),",","",.)) if source_year==2021
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2021
replace st_val_yisvcu=5 if source_year==2021 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_yisvcu=real(subinstr(strtrim(raw_yisvcu22),",","",.)) if source_year==2022
replace st_val_yisvcu=cond(missing(val_yisvcu),3,cond(val_yisvcu<0,2,cond(val_yisvcu==0,1,0))) if source_year==2022
replace st_val_yisvcu=5 if source_year==2022 & missing(val_yisvcu) & !inlist(upper(strtrim(raw_yisvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yisvcu G0_source_state
generate double val_yisvdo=.
generate byte st_val_yisvdo=4
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo14),",","",.)) if source_year==2014
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2014
replace st_val_yisvdo=5 if source_year==2014 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo14)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo17),",","",.)) if source_year==2017
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2017
replace st_val_yisvdo=5 if source_year==2017 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo17)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo18),",","",.)) if source_year==2018
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2018
replace st_val_yisvdo=5 if source_year==2018 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo18)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo19),",","",.)) if source_year==2019
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2019
replace st_val_yisvdo=5 if source_year==2019 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo19)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo20),",","",.)) if source_year==2020
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2020
replace st_val_yisvdo=5 if source_year==2020 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo20)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo21),",","",.)) if source_year==2021
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2021
replace st_val_yisvdo=5 if source_year==2021 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo21)),"","***",".","NA","N/A","NULL","-")
replace val_yisvdo=real(subinstr(strtrim(raw_yisvdo22),",","",.)) if source_year==2022
replace st_val_yisvdo=cond(missing(val_yisvdo),3,cond(val_yisvdo<0,2,cond(val_yisvdo==0,1,0))) if source_year==2022
replace st_val_yisvdo=5 if source_year==2022 & missing(val_yisvdo) & !inlist(upper(strtrim(raw_yisvdo22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yisvdo G0_source_state
generate double val_yisvfo=.
generate byte st_val_yisvfo=4
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo14),",","",.)) if source_year==2014
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2014
replace st_val_yisvfo=5 if source_year==2014 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo14)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo17),",","",.)) if source_year==2017
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2017
replace st_val_yisvfo=5 if source_year==2017 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo17)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo18),",","",.)) if source_year==2018
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2018
replace st_val_yisvfo=5 if source_year==2018 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo18)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo19),",","",.)) if source_year==2019
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2019
replace st_val_yisvfo=5 if source_year==2019 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo19)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo20),",","",.)) if source_year==2020
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2020
replace st_val_yisvfo=5 if source_year==2020 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo20)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo21),",","",.)) if source_year==2021
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2021
replace st_val_yisvfo=5 if source_year==2021 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo21)),"","***",".","NA","N/A","NULL","-")
replace val_yisvfo=real(subinstr(strtrim(raw_yisvfo22),",","",.)) if source_year==2022
replace st_val_yisvfo=cond(missing(val_yisvfo),3,cond(val_yisvfo<0,2,cond(val_yisvfo==0,1,0))) if source_year==2022
replace st_val_yisvfo=5 if source_year==2022 & missing(val_yisvfo) & !inlist(upper(strtrim(raw_yisvfo22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yisvfo G0_source_state
generate double val_ykdvcu=.
generate byte st_val_ykdvcu=4
replace val_ykdvcu=real(subinstr(strtrim(raw_ykdvcu19),",","",.)) if source_year==2019
replace st_val_ykdvcu=cond(missing(val_ykdvcu),3,cond(val_ykdvcu<0,2,cond(val_ykdvcu==0,1,0))) if source_year==2019
replace st_val_ykdvcu=5 if source_year==2019 & missing(val_ykdvcu) & !inlist(upper(strtrim(raw_ykdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ykdvcu=real(subinstr(strtrim(raw_ykdvcu20),",","",.)) if source_year==2020
replace st_val_ykdvcu=cond(missing(val_ykdvcu),3,cond(val_ykdvcu<0,2,cond(val_ykdvcu==0,1,0))) if source_year==2020
replace st_val_ykdvcu=5 if source_year==2020 & missing(val_ykdvcu) & !inlist(upper(strtrim(raw_ykdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ykdvcu=real(subinstr(strtrim(raw_ykdvcu21),",","",.)) if source_year==2021
replace st_val_ykdvcu=cond(missing(val_ykdvcu),3,cond(val_ykdvcu<0,2,cond(val_ykdvcu==0,1,0))) if source_year==2021
replace st_val_ykdvcu=5 if source_year==2021 & missing(val_ykdvcu) & !inlist(upper(strtrim(raw_ykdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ykdvcu=real(subinstr(strtrim(raw_ykdvcu22),",","",.)) if source_year==2022
replace st_val_ykdvcu=cond(missing(val_ykdvcu),3,cond(val_ykdvcu<0,2,cond(val_ykdvcu==0,1,0))) if source_year==2022
replace st_val_ykdvcu=5 if source_year==2022 & missing(val_ykdvcu) & !inlist(upper(strtrim(raw_ykdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ykdvcu G0_source_state
generate double val_ykfvcu=.
generate byte st_val_ykfvcu=4
replace val_ykfvcu=real(subinstr(strtrim(raw_ykfvcu19),",","",.)) if source_year==2019
replace st_val_ykfvcu=cond(missing(val_ykfvcu),3,cond(val_ykfvcu<0,2,cond(val_ykfvcu==0,1,0))) if source_year==2019
replace st_val_ykfvcu=5 if source_year==2019 & missing(val_ykfvcu) & !inlist(upper(strtrim(raw_ykfvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ykfvcu=real(subinstr(strtrim(raw_ykfvcu20),",","",.)) if source_year==2020
replace st_val_ykfvcu=cond(missing(val_ykfvcu),3,cond(val_ykfvcu<0,2,cond(val_ykfvcu==0,1,0))) if source_year==2020
replace st_val_ykfvcu=5 if source_year==2020 & missing(val_ykfvcu) & !inlist(upper(strtrim(raw_ykfvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ykfvcu=real(subinstr(strtrim(raw_ykfvcu21),",","",.)) if source_year==2021
replace st_val_ykfvcu=cond(missing(val_ykfvcu),3,cond(val_ykfvcu<0,2,cond(val_ykfvcu==0,1,0))) if source_year==2021
replace st_val_ykfvcu=5 if source_year==2021 & missing(val_ykfvcu) & !inlist(upper(strtrim(raw_ykfvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ykfvcu=real(subinstr(strtrim(raw_ykfvcu22),",","",.)) if source_year==2022
replace st_val_ykfvcu=cond(missing(val_ykfvcu),3,cond(val_ykfvcu<0,2,cond(val_ykfvcu==0,1,0))) if source_year==2022
replace st_val_ykfvcu=5 if source_year==2022 & missing(val_ykfvcu) & !inlist(upper(strtrim(raw_ykfvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ykfvcu G0_source_state
generate double val_ykivcu=.
generate byte st_val_ykivcu=4
replace val_ykivcu=real(subinstr(strtrim(raw_ykivcu19),",","",.)) if source_year==2019
replace st_val_ykivcu=cond(missing(val_ykivcu),3,cond(val_ykivcu<0,2,cond(val_ykivcu==0,1,0))) if source_year==2019
replace st_val_ykivcu=5 if source_year==2019 & missing(val_ykivcu) & !inlist(upper(strtrim(raw_ykivcu19)),"","***",".","NA","N/A","NULL","-")
label values st_val_ykivcu G0_source_state
generate double val_yprvcu=.
generate byte st_val_yprvcu=4
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu10),",","",.)) if source_year==2010
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2010
replace st_val_yprvcu=5 if source_year==2010 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu11),",","",.)) if source_year==2011
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2011
replace st_val_yprvcu=5 if source_year==2011 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu12),",","",.)) if source_year==2012
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2012
replace st_val_yprvcu=5 if source_year==2012 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu13),",","",.)) if source_year==2013
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2013
replace st_val_yprvcu=5 if source_year==2013 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu14),",","",.)) if source_year==2014
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2014
replace st_val_yprvcu=5 if source_year==2014 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu),",","",.)) if source_year==2015
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2015
replace st_val_yprvcu=5 if source_year==2015 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu17),",","",.)) if source_year==2017
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2017
replace st_val_yprvcu=5 if source_year==2017 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu18),",","",.)) if source_year==2018
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2018
replace st_val_yprvcu=5 if source_year==2018 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu19),",","",.)) if source_year==2019
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2019
replace st_val_yprvcu=5 if source_year==2019 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu20),",","",.)) if source_year==2020
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2020
replace st_val_yprvcu=5 if source_year==2020 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu21),",","",.)) if source_year==2021
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2021
replace st_val_yprvcu=5 if source_year==2021 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_yprvcu=real(subinstr(strtrim(raw_yprvcu22),",","",.)) if source_year==2022
replace st_val_yprvcu=cond(missing(val_yprvcu),3,cond(val_yprvcu<0,2,cond(val_yprvcu==0,1,0))) if source_year==2022
replace st_val_yprvcu=5 if source_year==2022 & missing(val_yprvcu) & !inlist(upper(strtrim(raw_yprvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yprvcu G0_source_state
generate double val_yrnvcu=.
generate byte st_val_yrnvcu=4
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu10),",","",.)) if source_year==2010
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2010
replace st_val_yrnvcu=5 if source_year==2010 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu11),",","",.)) if source_year==2011
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2011
replace st_val_yrnvcu=5 if source_year==2011 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu12),",","",.)) if source_year==2012
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2012
replace st_val_yrnvcu=5 if source_year==2012 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu13),",","",.)) if source_year==2013
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2013
replace st_val_yrnvcu=5 if source_year==2013 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu14),",","",.)) if source_year==2014
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2014
replace st_val_yrnvcu=5 if source_year==2014 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu),",","",.)) if source_year==2015
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2015
replace st_val_yrnvcu=5 if source_year==2015 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu17),",","",.)) if source_year==2017
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2017
replace st_val_yrnvcu=5 if source_year==2017 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu18),",","",.)) if source_year==2018
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2018
replace st_val_yrnvcu=5 if source_year==2018 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu19),",","",.)) if source_year==2019
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2019
replace st_val_yrnvcu=5 if source_year==2019 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu20),",","",.)) if source_year==2020
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2020
replace st_val_yrnvcu=5 if source_year==2020 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu21),",","",.)) if source_year==2021
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2021
replace st_val_yrnvcu=5 if source_year==2021 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_yrnvcu=real(subinstr(strtrim(raw_yrnvcu22),",","",.)) if source_year==2022
replace st_val_yrnvcu=cond(missing(val_yrnvcu),3,cond(val_yrnvcu<0,2,cond(val_yrnvcu==0,1,0))) if source_year==2022
replace st_val_yrnvcu=5 if source_year==2022 & missing(val_yrnvcu) & !inlist(upper(strtrim(raw_yrnvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yrnvcu G0_source_state
generate double val_yrsvcu=.
generate byte st_val_yrsvcu=4
replace val_yrsvcu=real(subinstr(strtrim(raw_yrsvcu19),",","",.)) if source_year==2019
replace st_val_yrsvcu=cond(missing(val_yrsvcu),3,cond(val_yrsvcu<0,2,cond(val_yrsvcu==0,1,0))) if source_year==2019
replace st_val_yrsvcu=5 if source_year==2019 & missing(val_yrsvcu) & !inlist(upper(strtrim(raw_yrsvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_yrsvcu=real(subinstr(strtrim(raw_yrsvcu20),",","",.)) if source_year==2020
replace st_val_yrsvcu=cond(missing(val_yrsvcu),3,cond(val_yrsvcu<0,2,cond(val_yrsvcu==0,1,0))) if source_year==2020
replace st_val_yrsvcu=5 if source_year==2020 & missing(val_yrsvcu) & !inlist(upper(strtrim(raw_yrsvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_yrsvcu=real(subinstr(strtrim(raw_yrsvcu21),",","",.)) if source_year==2021
replace st_val_yrsvcu=cond(missing(val_yrsvcu),3,cond(val_yrsvcu<0,2,cond(val_yrsvcu==0,1,0))) if source_year==2021
replace st_val_yrsvcu=5 if source_year==2021 & missing(val_yrsvcu) & !inlist(upper(strtrim(raw_yrsvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_yrsvcu=real(subinstr(strtrim(raw_yrsvcu22),",","",.)) if source_year==2022
replace st_val_yrsvcu=cond(missing(val_yrsvcu),3,cond(val_yrsvcu<0,2,cond(val_yrsvcu==0,1,0))) if source_year==2022
replace st_val_yrsvcu=5 if source_year==2022 & missing(val_yrsvcu) & !inlist(upper(strtrim(raw_yrsvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_yrsvcu G0_source_state
generate double val_ysnvcu=.
generate byte st_val_ysnvcu=4
replace val_ysnvcu=real(subinstr(strtrim(raw_ysnvcu19),",","",.)) if source_year==2019
replace st_val_ysnvcu=cond(missing(val_ysnvcu),3,cond(val_ysnvcu<0,2,cond(val_ysnvcu==0,1,0))) if source_year==2019
replace st_val_ysnvcu=5 if source_year==2019 & missing(val_ysnvcu) & !inlist(upper(strtrim(raw_ysnvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_ysnvcu=real(subinstr(strtrim(raw_ysnvcu20),",","",.)) if source_year==2020
replace st_val_ysnvcu=cond(missing(val_ysnvcu),3,cond(val_ysnvcu<0,2,cond(val_ysnvcu==0,1,0))) if source_year==2020
replace st_val_ysnvcu=5 if source_year==2020 & missing(val_ysnvcu) & !inlist(upper(strtrim(raw_ysnvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ysnvcu=real(subinstr(strtrim(raw_ysnvcu21),",","",.)) if source_year==2021
replace st_val_ysnvcu=cond(missing(val_ysnvcu),3,cond(val_ysnvcu<0,2,cond(val_ysnvcu==0,1,0))) if source_year==2021
replace st_val_ysnvcu=5 if source_year==2021 & missing(val_ysnvcu) & !inlist(upper(strtrim(raw_ysnvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ysnvcu=real(subinstr(strtrim(raw_ysnvcu22),",","",.)) if source_year==2022
replace st_val_ysnvcu=cond(missing(val_ysnvcu),3,cond(val_ysnvcu<0,2,cond(val_ysnvcu==0,1,0))) if source_year==2022
replace st_val_ysnvcu=5 if source_year==2022 & missing(val_ysnvcu) & !inlist(upper(strtrim(raw_ysnvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ysnvcu G0_source_state
generate double val_ytovcu=.
generate byte st_val_ytovcu=4
replace val_ytovcu=real(subinstr(strtrim(raw_ytovcu20),",","",.)) if source_year==2020
replace st_val_ytovcu=cond(missing(val_ytovcu),3,cond(val_ytovcu<0,2,cond(val_ytovcu==0,1,0))) if source_year==2020
replace st_val_ytovcu=5 if source_year==2020 & missing(val_ytovcu) & !inlist(upper(strtrim(raw_ytovcu20)),"","***",".","NA","N/A","NULL","-")
replace val_ytovcu=real(subinstr(strtrim(raw_ytovcu21),",","",.)) if source_year==2021
replace st_val_ytovcu=cond(missing(val_ytovcu),3,cond(val_ytovcu<0,2,cond(val_ytovcu==0,1,0))) if source_year==2021
replace st_val_ytovcu=5 if source_year==2021 & missing(val_ytovcu) & !inlist(upper(strtrim(raw_ytovcu21)),"","***",".","NA","N/A","NULL","-")
replace val_ytovcu=real(subinstr(strtrim(raw_ytovcu22),",","",.)) if source_year==2022
replace st_val_ytovcu=cond(missing(val_ytovcu),3,cond(val_ytovcu<0,2,cond(val_ytovcu==0,1,0))) if source_year==2022
replace st_val_ytovcu=5 if source_year==2022 & missing(val_ytovcu) & !inlist(upper(strtrim(raw_ytovcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_ytovcu G0_source_state
generate double val_znavcu=.
generate byte st_val_znavcu=4
replace val_znavcu=real(subinstr(strtrim(raw_znavcu10),",","",.)) if source_year==2010
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2010
replace st_val_znavcu=5 if source_year==2010 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu10)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu11),",","",.)) if source_year==2011
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2011
replace st_val_znavcu=5 if source_year==2011 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu11)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu12),",","",.)) if source_year==2012
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2012
replace st_val_znavcu=5 if source_year==2012 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu12)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu13),",","",.)) if source_year==2013
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2013
replace st_val_znavcu=5 if source_year==2013 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu13)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu14),",","",.)) if source_year==2014
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2014
replace st_val_znavcu=5 if source_year==2014 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu14)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu),",","",.)) if source_year==2015
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2015
replace st_val_znavcu=5 if source_year==2015 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu17),",","",.)) if source_year==2017
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2017
replace st_val_znavcu=5 if source_year==2017 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu17)),"","***",".","NA","N/A","NULL","-")
replace val_znavcu=real(subinstr(strtrim(raw_znavcu18),",","",.)) if source_year==2018
replace st_val_znavcu=cond(missing(val_znavcu),3,cond(val_znavcu<0,2,cond(val_znavcu==0,1,0))) if source_year==2018
replace st_val_znavcu=5 if source_year==2018 & missing(val_znavcu) & !inlist(upper(strtrim(raw_znavcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_znavcu G0_source_state
generate double val_zndvcu=.
generate byte st_val_zndvcu=4
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu10),",","",.)) if source_year==2010
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2010
replace st_val_zndvcu=5 if source_year==2010 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu11),",","",.)) if source_year==2011
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2011
replace st_val_zndvcu=5 if source_year==2011 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu12),",","",.)) if source_year==2012
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2012
replace st_val_zndvcu=5 if source_year==2012 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu13),",","",.)) if source_year==2013
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2013
replace st_val_zndvcu=5 if source_year==2013 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu14),",","",.)) if source_year==2014
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2014
replace st_val_zndvcu=5 if source_year==2014 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu),",","",.)) if source_year==2015
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2015
replace st_val_zndvcu=5 if source_year==2015 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu17),",","",.)) if source_year==2017
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2017
replace st_val_zndvcu=5 if source_year==2017 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu18),",","",.)) if source_year==2018
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2018
replace st_val_zndvcu=5 if source_year==2018 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu19),",","",.)) if source_year==2019
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2019
replace st_val_zndvcu=5 if source_year==2019 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu20),",","",.)) if source_year==2020
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2020
replace st_val_zndvcu=5 if source_year==2020 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu21),",","",.)) if source_year==2021
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2021
replace st_val_zndvcu=5 if source_year==2021 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_zndvcu=real(subinstr(strtrim(raw_zndvcu22),",","",.)) if source_year==2022
replace st_val_zndvcu=cond(missing(val_zndvcu),3,cond(val_zndvcu<0,2,cond(val_zndvcu==0,1,0))) if source_year==2022
replace st_val_zndvcu=5 if source_year==2022 & missing(val_zndvcu) & !inlist(upper(strtrim(raw_zndvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_zndvcu G0_source_state
generate double val_znevcu=.
generate byte st_val_znevcu=4
replace val_znevcu=real(subinstr(strtrim(raw_znevcu19),",","",.)) if source_year==2019
replace st_val_znevcu=cond(missing(val_znevcu),3,cond(val_znevcu<0,2,cond(val_znevcu==0,1,0))) if source_year==2019
replace st_val_znevcu=5 if source_year==2019 & missing(val_znevcu) & !inlist(upper(strtrim(raw_znevcu19)),"","***",".","NA","N/A","NULL","-")
replace val_znevcu=real(subinstr(strtrim(raw_znevcu20),",","",.)) if source_year==2020
replace st_val_znevcu=cond(missing(val_znevcu),3,cond(val_znevcu<0,2,cond(val_znevcu==0,1,0))) if source_year==2020
replace st_val_znevcu=5 if source_year==2020 & missing(val_znevcu) & !inlist(upper(strtrim(raw_znevcu20)),"","***",".","NA","N/A","NULL","-")
replace val_znevcu=real(subinstr(strtrim(raw_znevcu21),",","",.)) if source_year==2021
replace st_val_znevcu=cond(missing(val_znevcu),3,cond(val_znevcu<0,2,cond(val_znevcu==0,1,0))) if source_year==2021
replace st_val_znevcu=5 if source_year==2021 & missing(val_znevcu) & !inlist(upper(strtrim(raw_znevcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_znevcu G0_source_state
generate double val_znhvcu=.
generate byte st_val_znhvcu=4
replace val_znhvcu=real(subinstr(strtrim(raw_znhvcu19),",","",.)) if source_year==2019
replace st_val_znhvcu=cond(missing(val_znhvcu),3,cond(val_znhvcu<0,2,cond(val_znhvcu==0,1,0))) if source_year==2019
replace st_val_znhvcu=5 if source_year==2019 & missing(val_znhvcu) & !inlist(upper(strtrim(raw_znhvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_znhvcu=real(subinstr(strtrim(raw_znhvcu20),",","",.)) if source_year==2020
replace st_val_znhvcu=cond(missing(val_znhvcu),3,cond(val_znhvcu<0,2,cond(val_znhvcu==0,1,0))) if source_year==2020
replace st_val_znhvcu=5 if source_year==2020 & missing(val_znhvcu) & !inlist(upper(strtrim(raw_znhvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_znhvcu=real(subinstr(strtrim(raw_znhvcu21),",","",.)) if source_year==2021
replace st_val_znhvcu=cond(missing(val_znhvcu),3,cond(val_znhvcu<0,2,cond(val_znhvcu==0,1,0))) if source_year==2021
replace st_val_znhvcu=5 if source_year==2021 & missing(val_znhvcu) & !inlist(upper(strtrim(raw_znhvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_znhvcu G0_source_state
generate double val_znivcu=.
generate byte st_val_znivcu=4
replace val_znivcu=real(subinstr(strtrim(raw_znivcu10),",","",.)) if source_year==2010
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2010
replace st_val_znivcu=5 if source_year==2010 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu10)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu11),",","",.)) if source_year==2011
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2011
replace st_val_znivcu=5 if source_year==2011 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu11)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu12),",","",.)) if source_year==2012
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2012
replace st_val_znivcu=5 if source_year==2012 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu12)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu13),",","",.)) if source_year==2013
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2013
replace st_val_znivcu=5 if source_year==2013 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu13)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu14),",","",.)) if source_year==2014
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2014
replace st_val_znivcu=5 if source_year==2014 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu14)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu17),",","",.)) if source_year==2017
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2017
replace st_val_znivcu=5 if source_year==2017 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu17)),"","***",".","NA","N/A","NULL","-")
replace val_znivcu=real(subinstr(strtrim(raw_znivcu18),",","",.)) if source_year==2018
replace st_val_znivcu=cond(missing(val_znivcu),3,cond(val_znivcu<0,2,cond(val_znivcu==0,1,0))) if source_year==2018
replace st_val_znivcu=5 if source_year==2018 & missing(val_znivcu) & !inlist(upper(strtrim(raw_znivcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_znivcu G0_source_state
generate double val_znovcu=.
generate byte st_val_znovcu=4
replace val_znovcu=real(subinstr(strtrim(raw_znovcu10),",","",.)) if source_year==2010
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2010
replace st_val_znovcu=5 if source_year==2010 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu10)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu11),",","",.)) if source_year==2011
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2011
replace st_val_znovcu=5 if source_year==2011 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu11)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu12),",","",.)) if source_year==2012
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2012
replace st_val_znovcu=5 if source_year==2012 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu12)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu13),",","",.)) if source_year==2013
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2013
replace st_val_znovcu=5 if source_year==2013 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu13)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu14),",","",.)) if source_year==2014
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2014
replace st_val_znovcu=5 if source_year==2014 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu14)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu),",","",.)) if source_year==2015
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2015
replace st_val_znovcu=5 if source_year==2015 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu17),",","",.)) if source_year==2017
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2017
replace st_val_znovcu=5 if source_year==2017 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu17)),"","***",".","NA","N/A","NULL","-")
replace val_znovcu=real(subinstr(strtrim(raw_znovcu18),",","",.)) if source_year==2018
replace st_val_znovcu=cond(missing(val_znovcu),3,cond(val_znovcu<0,2,cond(val_znovcu==0,1,0))) if source_year==2018
replace st_val_znovcu=5 if source_year==2018 & missing(val_znovcu) & !inlist(upper(strtrim(raw_znovcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_znovcu G0_source_state
generate double val_znpvcu=.
generate byte st_val_znpvcu=4
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu10),",","",.)) if source_year==2010
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2010
replace st_val_znpvcu=5 if source_year==2010 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu11),",","",.)) if source_year==2011
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2011
replace st_val_znpvcu=5 if source_year==2011 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu12),",","",.)) if source_year==2012
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2012
replace st_val_znpvcu=5 if source_year==2012 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu13),",","",.)) if source_year==2013
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2013
replace st_val_znpvcu=5 if source_year==2013 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu14),",","",.)) if source_year==2014
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2014
replace st_val_znpvcu=5 if source_year==2014 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu),",","",.)) if source_year==2015
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2015
replace st_val_znpvcu=5 if source_year==2015 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu17),",","",.)) if source_year==2017
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2017
replace st_val_znpvcu=5 if source_year==2017 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_znpvcu=real(subinstr(strtrim(raw_znpvcu18),",","",.)) if source_year==2018
replace st_val_znpvcu=cond(missing(val_znpvcu),3,cond(val_znpvcu<0,2,cond(val_znpvcu==0,1,0))) if source_year==2018
replace st_val_znpvcu=5 if source_year==2018 & missing(val_znpvcu) & !inlist(upper(strtrim(raw_znpvcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_znpvcu G0_source_state
generate double val_znrvcu=.
generate byte st_val_znrvcu=4
replace val_znrvcu=real(subinstr(strtrim(raw_znrvcu19),",","",.)) if source_year==2019
replace st_val_znrvcu=cond(missing(val_znrvcu),3,cond(val_znrvcu<0,2,cond(val_znrvcu==0,1,0))) if source_year==2019
replace st_val_znrvcu=5 if source_year==2019 & missing(val_znrvcu) & !inlist(upper(strtrim(raw_znrvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_znrvcu=real(subinstr(strtrim(raw_znrvcu20),",","",.)) if source_year==2020
replace st_val_znrvcu=cond(missing(val_znrvcu),3,cond(val_znrvcu<0,2,cond(val_znrvcu==0,1,0))) if source_year==2020
replace st_val_znrvcu=5 if source_year==2020 & missing(val_znrvcu) & !inlist(upper(strtrim(raw_znrvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_znrvcu=real(subinstr(strtrim(raw_znrvcu21),",","",.)) if source_year==2021
replace st_val_znrvcu=cond(missing(val_znrvcu),3,cond(val_znrvcu<0,2,cond(val_znrvcu==0,1,0))) if source_year==2021
replace st_val_znrvcu=5 if source_year==2021 & missing(val_znrvcu) & !inlist(upper(strtrim(raw_znrvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_znrvcu=real(subinstr(strtrim(raw_znrvcu22),",","",.)) if source_year==2022
replace st_val_znrvcu=cond(missing(val_znrvcu),3,cond(val_znrvcu<0,2,cond(val_znrvcu==0,1,0))) if source_year==2022
replace st_val_znrvcu=5 if source_year==2022 & missing(val_znrvcu) & !inlist(upper(strtrim(raw_znrvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_znrvcu G0_source_state
generate double val_znsvcu=.
generate byte st_val_znsvcu=4
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu10),",","",.)) if source_year==2010
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2010
replace st_val_znsvcu=5 if source_year==2010 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu11),",","",.)) if source_year==2011
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2011
replace st_val_znsvcu=5 if source_year==2011 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu12),",","",.)) if source_year==2012
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2012
replace st_val_znsvcu=5 if source_year==2012 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu13),",","",.)) if source_year==2013
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2013
replace st_val_znsvcu=5 if source_year==2013 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu14),",","",.)) if source_year==2014
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2014
replace st_val_znsvcu=5 if source_year==2014 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu),",","",.)) if source_year==2015
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2015
replace st_val_znsvcu=5 if source_year==2015 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu17),",","",.)) if source_year==2017
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2017
replace st_val_znsvcu=5 if source_year==2017 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_znsvcu=real(subinstr(strtrim(raw_znsvcu18),",","",.)) if source_year==2018
replace st_val_znsvcu=cond(missing(val_znsvcu),3,cond(val_znsvcu<0,2,cond(val_znsvcu==0,1,0))) if source_year==2018
replace st_val_znsvcu=5 if source_year==2018 & missing(val_znsvcu) & !inlist(upper(strtrim(raw_znsvcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_znsvcu G0_source_state
generate double val_zntvcu=.
generate byte st_val_zntvcu=4
replace val_zntvcu=real(subinstr(strtrim(raw_zntvcu19),",","",.)) if source_year==2019
replace st_val_zntvcu=cond(missing(val_zntvcu),3,cond(val_zntvcu<0,2,cond(val_zntvcu==0,1,0))) if source_year==2019
replace st_val_zntvcu=5 if source_year==2019 & missing(val_zntvcu) & !inlist(upper(strtrim(raw_zntvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zntvcu=real(subinstr(strtrim(raw_zntvcu20),",","",.)) if source_year==2020
replace st_val_zntvcu=cond(missing(val_zntvcu),3,cond(val_zntvcu<0,2,cond(val_zntvcu==0,1,0))) if source_year==2020
replace st_val_zntvcu=5 if source_year==2020 & missing(val_zntvcu) & !inlist(upper(strtrim(raw_zntvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zntvcu=real(subinstr(strtrim(raw_zntvcu21),",","",.)) if source_year==2021
replace st_val_zntvcu=cond(missing(val_zntvcu),3,cond(val_zntvcu<0,2,cond(val_zntvcu==0,1,0))) if source_year==2021
replace st_val_zntvcu=5 if source_year==2021 & missing(val_zntvcu) & !inlist(upper(strtrim(raw_zntvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_zntvcu=real(subinstr(strtrim(raw_zntvcu22),",","",.)) if source_year==2022
replace st_val_zntvcu=cond(missing(val_zntvcu),3,cond(val_zntvcu<0,2,cond(val_zntvcu==0,1,0))) if source_year==2022
replace st_val_zntvcu=5 if source_year==2022 & missing(val_zntvcu) & !inlist(upper(strtrim(raw_zntvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_zntvcu G0_source_state
generate double val_zpavcu=.
generate byte st_val_zpavcu=4
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu10),",","",.)) if source_year==2010
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2010
replace st_val_zpavcu=5 if source_year==2010 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu11),",","",.)) if source_year==2011
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2011
replace st_val_zpavcu=5 if source_year==2011 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu12),",","",.)) if source_year==2012
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2012
replace st_val_zpavcu=5 if source_year==2012 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu13),",","",.)) if source_year==2013
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2013
replace st_val_zpavcu=5 if source_year==2013 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu14),",","",.)) if source_year==2014
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2014
replace st_val_zpavcu=5 if source_year==2014 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu),",","",.)) if source_year==2015
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2015
replace st_val_zpavcu=5 if source_year==2015 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu17),",","",.)) if source_year==2017
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2017
replace st_val_zpavcu=5 if source_year==2017 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zpavcu=real(subinstr(strtrim(raw_zpavcu18),",","",.)) if source_year==2018
replace st_val_zpavcu=cond(missing(val_zpavcu),3,cond(val_zpavcu<0,2,cond(val_zpavcu==0,1,0))) if source_year==2018
replace st_val_zpavcu=5 if source_year==2018 & missing(val_zpavcu) & !inlist(upper(strtrim(raw_zpavcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpavcu G0_source_state
generate double val_zpdvcu=.
generate byte st_val_zpdvcu=4
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu10),",","",.)) if source_year==2010
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2010
replace st_val_zpdvcu=5 if source_year==2010 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu11),",","",.)) if source_year==2011
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2011
replace st_val_zpdvcu=5 if source_year==2011 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu12),",","",.)) if source_year==2012
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2012
replace st_val_zpdvcu=5 if source_year==2012 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu13),",","",.)) if source_year==2013
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2013
replace st_val_zpdvcu=5 if source_year==2013 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu14),",","",.)) if source_year==2014
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2014
replace st_val_zpdvcu=5 if source_year==2014 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu),",","",.)) if source_year==2015
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2015
replace st_val_zpdvcu=5 if source_year==2015 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu17),",","",.)) if source_year==2017
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2017
replace st_val_zpdvcu=5 if source_year==2017 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu18),",","",.)) if source_year==2018
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2018
replace st_val_zpdvcu=5 if source_year==2018 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu18)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu19),",","",.)) if source_year==2019
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2019
replace st_val_zpdvcu=5 if source_year==2019 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu20),",","",.)) if source_year==2020
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2020
replace st_val_zpdvcu=5 if source_year==2020 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu21),",","",.)) if source_year==2021
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2021
replace st_val_zpdvcu=5 if source_year==2021 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_zpdvcu=real(subinstr(strtrim(raw_zpdvcu22),",","",.)) if source_year==2022
replace st_val_zpdvcu=cond(missing(val_zpdvcu),3,cond(val_zpdvcu<0,2,cond(val_zpdvcu==0,1,0))) if source_year==2022
replace st_val_zpdvcu=5 if source_year==2022 & missing(val_zpdvcu) & !inlist(upper(strtrim(raw_zpdvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpdvcu G0_source_state
generate double val_zpevcu=.
generate byte st_val_zpevcu=4
replace val_zpevcu=real(subinstr(strtrim(raw_zpevcu19),",","",.)) if source_year==2019
replace st_val_zpevcu=cond(missing(val_zpevcu),3,cond(val_zpevcu<0,2,cond(val_zpevcu==0,1,0))) if source_year==2019
replace st_val_zpevcu=5 if source_year==2019 & missing(val_zpevcu) & !inlist(upper(strtrim(raw_zpevcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zpevcu=real(subinstr(strtrim(raw_zpevcu20),",","",.)) if source_year==2020
replace st_val_zpevcu=cond(missing(val_zpevcu),3,cond(val_zpevcu<0,2,cond(val_zpevcu==0,1,0))) if source_year==2020
replace st_val_zpevcu=5 if source_year==2020 & missing(val_zpevcu) & !inlist(upper(strtrim(raw_zpevcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zpevcu=real(subinstr(strtrim(raw_zpevcu21),",","",.)) if source_year==2021
replace st_val_zpevcu=cond(missing(val_zpevcu),3,cond(val_zpevcu<0,2,cond(val_zpevcu==0,1,0))) if source_year==2021
replace st_val_zpevcu=5 if source_year==2021 & missing(val_zpevcu) & !inlist(upper(strtrim(raw_zpevcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpevcu G0_source_state
generate double val_zphvcu=.
generate byte st_val_zphvcu=4
replace val_zphvcu=real(subinstr(strtrim(raw_zphvcu19),",","",.)) if source_year==2019
replace st_val_zphvcu=cond(missing(val_zphvcu),3,cond(val_zphvcu<0,2,cond(val_zphvcu==0,1,0))) if source_year==2019
replace st_val_zphvcu=5 if source_year==2019 & missing(val_zphvcu) & !inlist(upper(strtrim(raw_zphvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zphvcu=real(subinstr(strtrim(raw_zphvcu20),",","",.)) if source_year==2020
replace st_val_zphvcu=cond(missing(val_zphvcu),3,cond(val_zphvcu<0,2,cond(val_zphvcu==0,1,0))) if source_year==2020
replace st_val_zphvcu=5 if source_year==2020 & missing(val_zphvcu) & !inlist(upper(strtrim(raw_zphvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zphvcu=real(subinstr(strtrim(raw_zphvcu21),",","",.)) if source_year==2021
replace st_val_zphvcu=cond(missing(val_zphvcu),3,cond(val_zphvcu<0,2,cond(val_zphvcu==0,1,0))) if source_year==2021
replace st_val_zphvcu=5 if source_year==2021 & missing(val_zphvcu) & !inlist(upper(strtrim(raw_zphvcu21)),"","***",".","NA","N/A","NULL","-")
label values st_val_zphvcu G0_source_state
generate double val_zpivcu=.
generate byte st_val_zpivcu=4
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu10),",","",.)) if source_year==2010
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2010
replace st_val_zpivcu=5 if source_year==2010 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu11),",","",.)) if source_year==2011
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2011
replace st_val_zpivcu=5 if source_year==2011 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu12),",","",.)) if source_year==2012
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2012
replace st_val_zpivcu=5 if source_year==2012 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu13),",","",.)) if source_year==2013
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2013
replace st_val_zpivcu=5 if source_year==2013 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu14),",","",.)) if source_year==2014
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2014
replace st_val_zpivcu=5 if source_year==2014 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu),",","",.)) if source_year==2015
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2015
replace st_val_zpivcu=5 if source_year==2015 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu17),",","",.)) if source_year==2017
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2017
replace st_val_zpivcu=5 if source_year==2017 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zpivcu=real(subinstr(strtrim(raw_zpivcu18),",","",.)) if source_year==2018
replace st_val_zpivcu=cond(missing(val_zpivcu),3,cond(val_zpivcu<0,2,cond(val_zpivcu==0,1,0))) if source_year==2018
replace st_val_zpivcu=5 if source_year==2018 & missing(val_zpivcu) & !inlist(upper(strtrim(raw_zpivcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpivcu G0_source_state
generate double val_zpovcu=.
generate byte st_val_zpovcu=4
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu10),",","",.)) if source_year==2010
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2010
replace st_val_zpovcu=5 if source_year==2010 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu11),",","",.)) if source_year==2011
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2011
replace st_val_zpovcu=5 if source_year==2011 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu12),",","",.)) if source_year==2012
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2012
replace st_val_zpovcu=5 if source_year==2012 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu13),",","",.)) if source_year==2013
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2013
replace st_val_zpovcu=5 if source_year==2013 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu14),",","",.)) if source_year==2014
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2014
replace st_val_zpovcu=5 if source_year==2014 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu),",","",.)) if source_year==2015
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2015
replace st_val_zpovcu=5 if source_year==2015 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu17),",","",.)) if source_year==2017
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2017
replace st_val_zpovcu=5 if source_year==2017 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zpovcu=real(subinstr(strtrim(raw_zpovcu18),",","",.)) if source_year==2018
replace st_val_zpovcu=cond(missing(val_zpovcu),3,cond(val_zpovcu<0,2,cond(val_zpovcu==0,1,0))) if source_year==2018
replace st_val_zpovcu=5 if source_year==2018 & missing(val_zpovcu) & !inlist(upper(strtrim(raw_zpovcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpovcu G0_source_state
generate double val_zppvcu=.
generate byte st_val_zppvcu=4
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu10),",","",.)) if source_year==2010
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2010
replace st_val_zppvcu=5 if source_year==2010 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu11),",","",.)) if source_year==2011
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2011
replace st_val_zppvcu=5 if source_year==2011 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu12),",","",.)) if source_year==2012
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2012
replace st_val_zppvcu=5 if source_year==2012 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu13),",","",.)) if source_year==2013
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2013
replace st_val_zppvcu=5 if source_year==2013 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu14),",","",.)) if source_year==2014
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2014
replace st_val_zppvcu=5 if source_year==2014 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu),",","",.)) if source_year==2015
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2015
replace st_val_zppvcu=5 if source_year==2015 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu17),",","",.)) if source_year==2017
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2017
replace st_val_zppvcu=5 if source_year==2017 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zppvcu=real(subinstr(strtrim(raw_zppvcu18),",","",.)) if source_year==2018
replace st_val_zppvcu=cond(missing(val_zppvcu),3,cond(val_zppvcu<0,2,cond(val_zppvcu==0,1,0))) if source_year==2018
replace st_val_zppvcu=5 if source_year==2018 & missing(val_zppvcu) & !inlist(upper(strtrim(raw_zppvcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_zppvcu G0_source_state
generate double val_zprvcu=.
generate byte st_val_zprvcu=4
replace val_zprvcu=real(subinstr(strtrim(raw_zprvcu19),",","",.)) if source_year==2019
replace st_val_zprvcu=cond(missing(val_zprvcu),3,cond(val_zprvcu<0,2,cond(val_zprvcu==0,1,0))) if source_year==2019
replace st_val_zprvcu=5 if source_year==2019 & missing(val_zprvcu) & !inlist(upper(strtrim(raw_zprvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zprvcu=real(subinstr(strtrim(raw_zprvcu20),",","",.)) if source_year==2020
replace st_val_zprvcu=cond(missing(val_zprvcu),3,cond(val_zprvcu<0,2,cond(val_zprvcu==0,1,0))) if source_year==2020
replace st_val_zprvcu=5 if source_year==2020 & missing(val_zprvcu) & !inlist(upper(strtrim(raw_zprvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zprvcu=real(subinstr(strtrim(raw_zprvcu21),",","",.)) if source_year==2021
replace st_val_zprvcu=cond(missing(val_zprvcu),3,cond(val_zprvcu<0,2,cond(val_zprvcu==0,1,0))) if source_year==2021
replace st_val_zprvcu=5 if source_year==2021 & missing(val_zprvcu) & !inlist(upper(strtrim(raw_zprvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_zprvcu=real(subinstr(strtrim(raw_zprvcu22),",","",.)) if source_year==2022
replace st_val_zprvcu=cond(missing(val_zprvcu),3,cond(val_zprvcu<0,2,cond(val_zprvcu==0,1,0))) if source_year==2022
replace st_val_zprvcu=5 if source_year==2022 & missing(val_zprvcu) & !inlist(upper(strtrim(raw_zprvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_zprvcu G0_source_state
generate double val_zpsvcu=.
generate byte st_val_zpsvcu=4
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu10),",","",.)) if source_year==2010
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2010
replace st_val_zpsvcu=5 if source_year==2010 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu10)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu11),",","",.)) if source_year==2011
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2011
replace st_val_zpsvcu=5 if source_year==2011 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu11)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu12),",","",.)) if source_year==2012
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2012
replace st_val_zpsvcu=5 if source_year==2012 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu12)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu13),",","",.)) if source_year==2013
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2013
replace st_val_zpsvcu=5 if source_year==2013 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu13)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu14),",","",.)) if source_year==2014
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2014
replace st_val_zpsvcu=5 if source_year==2014 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu14)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu),",","",.)) if source_year==2015
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2015
replace st_val_zpsvcu=5 if source_year==2015 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu17),",","",.)) if source_year==2017
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2017
replace st_val_zpsvcu=5 if source_year==2017 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu17)),"","***",".","NA","N/A","NULL","-")
replace val_zpsvcu=real(subinstr(strtrim(raw_zpsvcu18),",","",.)) if source_year==2018
replace st_val_zpsvcu=cond(missing(val_zpsvcu),3,cond(val_zpsvcu<0,2,cond(val_zpsvcu==0,1,0))) if source_year==2018
replace st_val_zpsvcu=5 if source_year==2018 & missing(val_zpsvcu) & !inlist(upper(strtrim(raw_zpsvcu18)),"","***",".","NA","N/A","NULL","-")
label values st_val_zpsvcu G0_source_state
generate double val_zptvcu=.
generate byte st_val_zptvcu=4
replace val_zptvcu=real(subinstr(strtrim(raw_zptvcu19),",","",.)) if source_year==2019
replace st_val_zptvcu=cond(missing(val_zptvcu),3,cond(val_zptvcu<0,2,cond(val_zptvcu==0,1,0))) if source_year==2019
replace st_val_zptvcu=5 if source_year==2019 & missing(val_zptvcu) & !inlist(upper(strtrim(raw_zptvcu19)),"","***",".","NA","N/A","NULL","-")
replace val_zptvcu=real(subinstr(strtrim(raw_zptvcu20),",","",.)) if source_year==2020
replace st_val_zptvcu=cond(missing(val_zptvcu),3,cond(val_zptvcu<0,2,cond(val_zptvcu==0,1,0))) if source_year==2020
replace st_val_zptvcu=5 if source_year==2020 & missing(val_zptvcu) & !inlist(upper(strtrim(raw_zptvcu20)),"","***",".","NA","N/A","NULL","-")
replace val_zptvcu=real(subinstr(strtrim(raw_zptvcu21),",","",.)) if source_year==2021
replace st_val_zptvcu=cond(missing(val_zptvcu),3,cond(val_zptvcu<0,2,cond(val_zptvcu==0,1,0))) if source_year==2021
replace st_val_zptvcu=5 if source_year==2021 & missing(val_zptvcu) & !inlist(upper(strtrim(raw_zptvcu21)),"","***",".","NA","N/A","NULL","-")
replace val_zptvcu=real(subinstr(strtrim(raw_zptvcu22),",","",.)) if source_year==2022
replace st_val_zptvcu=cond(missing(val_zptvcu),3,cond(val_zptvcu<0,2,cond(val_zptvcu==0,1,0))) if source_year==2022
replace st_val_zptvcu=5 if source_year==2022 & missing(val_zptvcu) & !inlist(upper(strtrim(raw_zptvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_val_zptvcu G0_source_state
generate double value_added_nominal=.
generate byte st_value_added_nominal=4
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu10),",","",.)) if source_year==2010
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2010
replace st_value_added_nominal=5 if source_year==2010 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu10)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu11),",","",.)) if source_year==2011
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2011
replace st_value_added_nominal=5 if source_year==2011 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu11)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu12),",","",.)) if source_year==2012
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2012
replace st_value_added_nominal=5 if source_year==2012 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu12)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu13),",","",.)) if source_year==2013
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2013
replace st_value_added_nominal=5 if source_year==2013 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu13)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu14),",","",.)) if source_year==2014
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2014
replace st_value_added_nominal=5 if source_year==2014 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu14)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu15),",","",.)) if source_year==2015
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2015
replace st_value_added_nominal=5 if source_year==2015 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu15)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu17),",","",.)) if source_year==2017
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2017
replace st_value_added_nominal=5 if source_year==2017 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu17)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu18),",","",.)) if source_year==2018
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2018
replace st_value_added_nominal=5 if source_year==2018 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu18)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu19),",","",.)) if source_year==2019
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2019
replace st_value_added_nominal=5 if source_year==2019 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu19)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu20),",","",.)) if source_year==2020
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2020
replace st_value_added_nominal=5 if source_year==2020 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu20)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu21),",","",.)) if source_year==2021
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2021
replace st_value_added_nominal=5 if source_year==2021 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu21)),"","***",".","NA","N/A","NULL","-")
replace value_added_nominal=real(subinstr(strtrim(raw_vtlvcu22),",","",.)) if source_year==2022
replace st_value_added_nominal=cond(missing(value_added_nominal),3,cond(value_added_nominal<0,2,cond(value_added_nominal==0,1,0))) if source_year==2022
replace st_value_added_nominal=5 if source_year==2022 & missing(value_added_nominal) & !inlist(upper(strtrim(raw_vtlvcu22)),"","***",".","NA","N/A","NULL","-")
label values st_value_added_nominal G0_source_state
generate double workers=.
generate byte st_workers=4
replace workers=real(subinstr(strtrim(raw_ltlnou10),",","",.)) if source_year==2010
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2010
replace st_workers=5 if source_year==2010 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou10)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou11),",","",.)) if source_year==2011
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2011
replace st_workers=5 if source_year==2011 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou11)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou12),",","",.)) if source_year==2012
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2012
replace st_workers=5 if source_year==2012 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou12)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou13),",","",.)) if source_year==2013
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2013
replace st_workers=5 if source_year==2013 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou13)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou14),",","",.)) if source_year==2014
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2014
replace st_workers=5 if source_year==2014 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou14)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou),",","",.)) if source_year==2015
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2015
replace st_workers=5 if source_year==2015 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou17),",","",.)) if source_year==2017
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2017
replace st_workers=5 if source_year==2017 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou17)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou18),",","",.)) if source_year==2018
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2018
replace st_workers=5 if source_year==2018 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou18)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou19),",","",.)) if source_year==2019
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2019
replace st_workers=5 if source_year==2019 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou19)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou20),",","",.)) if source_year==2020
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2020
replace st_workers=5 if source_year==2020 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou20)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou21),",","",.)) if source_year==2021
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2021
replace st_workers=5 if source_year==2021 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou21)),"","***",".","NA","N/A","NULL","-")
replace workers=real(subinstr(strtrim(raw_ltlnou22),",","",.)) if source_year==2022
replace st_workers=cond(missing(workers),3,cond(workers<0,2,cond(workers==0,1,0))) if source_year==2022
replace st_workers=5 if source_year==2022 & missing(workers) & !inlist(upper(strtrim(raw_ltlnou22)),"","***",".","NA","N/A","NULL","-")
label values st_workers G0_source_state
keep source_year source_row amdal_raw b3wste_raw capital_additions_nominal capital_nominal capital_stock_nominal export_binary_raw export_share_pct foreign_ownership_pct gross_output_nominal import_value_nominal innovation_marketing_raw innovation_org_raw innovation_process_raw innovation_product_raw innovation_raw inspli_raw intermediate_inputs_nominal liwste_raw pplihi_raw production_workers rd_cost_nominal rd_indicator_raw rd_workers sowste_raw spplhi_raw val_cbdacu val_cbfpcu val_cbsacu val_cbttcu val_cldacu val_clfpcu val_clsacu val_clttcu val_cmdacu val_cmfpcu val_cmsacu val_cmttcu val_codacu val_cofpcu val_cosacu val_costrd val_cottcu val_csdacu val_csfpcu val_cssacu val_csttcu val_ctdacu val_ctfpcu val_ctsacu val_cttcu val_ctttcu val_cvdacu val_cvfpcu val_cvsacu val_cvttcu val_devvcu val_ecavce val_ecavcu val_ecbvce val_ecbvcu val_eckvce val_eckvcu val_eclvce val_eclvcu val_edivce val_edivcu val_efovce val_efovcu val_efuvce val_efuvcu val_egavce val_egavcu val_egovce val_egovcu val_elpvce val_elpvcu val_eluvce val_eluvcu val_encvce val_encvcu val_engvce val_engvcu val_enpvcu val_eoivce val_eoivcu val_epevce val_epevcu val_eplvcu val_esdvce val_esdvcu val_esovce val_esovcu val_ibrvcu val_icovcu val_idevcu val_iinput val_iinvcu val_iisfov val_iislov val_iisvcu val_ikivcu val_iklvcu val_ikovcu val_ilrvcu val_insvcu val_intvcu val_iotvcu val_ipkvcu val_iprvcu val_irdvcu val_irevcu val_irrvcu val_itxvcu val_iuwvcu val_nopvcu val_othvcu val_output val_rdnvcu val_renvcu val_rimvcu val_rtlvcu val_sfbvcu val_sfcvcu val_sfdvcu val_sfgvcu val_sfjvcu val_sfkvcu val_sfnvcu val_sfovcu val_sfrvcu val_sfsvcu val_sfuvcu val_shdvcu val_shfvcu val_shjvcu val_srdvcu val_srjvcu val_srmvcu val_stdvcu val_stjvcu val_stlvcu val_vtlvcu val_yelvcu val_yisvcu val_yisvdo val_yisvfo val_ykdvcu val_ykfvcu val_ykivcu val_yprvcu val_yrnvcu val_yrsvcu val_ysnvcu val_ytovcu val_znavcu val_zndvcu val_znevcu val_znhvcu val_znivcu val_znovcu val_znpvcu val_znrvcu val_znsvcu val_zntvcu val_zpavcu val_zpdvcu val_zpevcu val_zphvcu val_zpivcu val_zpovcu val_zppvcu val_zprvcu val_zpsvcu val_zptvcu value_added_nominal workers st_*
isid source_year source_row
save "$G0D/G0_economic_fields.dta", replace
