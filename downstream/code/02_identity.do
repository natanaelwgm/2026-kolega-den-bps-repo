version 17
args mode
if "$DS_RUN"=="" error 198
* Different parent observation namespaces; never row-join actual and development.
generate int year=source_year
if "`mode'"=="actual" {
 assert identity_real_link_verified==0 & real_panel_ready==0
 assert missing(selected_firm_id)
 generate str40 obs_id="g0:"+string(source_year,"%04.0f")+":"+string(source_row,"%09.0f")
 generate double firm_id=.
 generate double psid=.
 generate str24 psid_status="unverified_actual"
 drop selected_firm_id
}
else {
 assert psid_status=="synthetic_development"
 isid psid source_year
 generate double firm_id=psid
 generate long source_row=.
 generate byte identity_real_link_verified=0
 generate byte real_panel_ready=0
}
generate str12 dataset_mode="`mode'"
generate byte panel_id_synthetic=("`mode'"=="development")
generate byte panel_key_available=!missing(firm_id)
generate byte panel_empirical_ready=0
generate byte all_downstream_ready=0
generate byte district_observed=trim(district_code)!=""
generate byte province_observed=trim(province_code)!=""
generate str2 industry2_reported=substr(industry_code,1,2) if regexm(industry_code,"^[0-9][0-9]")
generate byte industry_bridge_verified=0
label variable obs_id "Unique source observation; actual/development have different namespaces"
label variable firm_id "Panel ID: fictional in development; missing in actual"
label variable year "Calendar year; 2016 absent, never compressed or filled"
label variable source_row "G0 source-row key; unavailable in G0.5 namespace"
label variable panel_empirical_ready "Verified actual longitudinal linkage: unavailable"
label variable all_downstream_ready "Universal empirical readiness: false; consult readiness contracts"
label variable industry2_reported "First 2 industry digits; cross-vintage bridge UNVERIFIED"
label variable district_code "Source district code; no fictional or province-based substitution"
isid obs_id
isid obs_id year
if "`mode'"=="development" {
 isid firm_id year
 xtset firm_id year
}
noisily display as result "IDENTITY OK | `mode' | synthetic=" ("`mode'"=="development")
