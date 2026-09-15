* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta; `real_crosswalk' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
clear all
set more off
set varabbrev off
* Owner-requested optional identity adapter. Never rewrite the frozen G0 main.
* Arguments: DAG_ROOT [off|dummy|real] [VERIFIED_CROSSWALK] [DUMMY_DISTRICTS]
args dag_root mode real_crosswalk dummy_district_count
if `"`dag_root'"'=="" local dag_root "."
if `"`mode'"'=="" local mode "off"
* Isi blok hanya dijalankan bila bukan inlist("`mode'","off","dummy","real"). // WFDOC-INJECTED
if !inlist("`mode'","off","dummy","real") {
    display as error "IDENTITY_MODE_INVALID: use off (default), dummy, or real."
    exit 198
}
if `"`dummy_district_count'"'=="" local dummy_district_count 5
* Isi blok hanya dijalankan bila kolom real("`dummy_district_count'" kosong) atau real("`dummy_district_count'") kurang dari 1 atau real("`dummy_district_count'") lebih dari 99 atau mod(real("`dummy_district_count'"),1)bukan =0. // WFDOC-INJECTED
if missing(real("`dummy_district_count'")) | real("`dummy_district_count'")<1 | real("`dummy_district_count'")>99 | mod(real("`dummy_district_count'"),1)!=0 {
    display as error "DUMMY_DISTRICTS_INVALID: integer 1..99 required."
    exit 198
}
cd "`dag_root'"
local data "dag/data/word_data/G0/identity-options"
local reports "dag/reports/word_data/G0/identity-options"
local logs "dag/logs/word_data/G0/identity-options"
capture mkdir "`data'"
capture mkdir "`reports'"
capture mkdir "`logs'"
capture log close G0identity
log using "`logs'/G0_identity_`mode'.log", text replace name(G0identity)
use source_year source_row province_code district_code industry_code source_id_raw using "dag/data/word_data/G0/G0_main_candidate.dta", clear
isid source_year source_row
local original_n=_N
generate str8 identity_mode="`mode'"
generate byte identity_is_dummy=("`mode'"=="dummy")
generate byte identity_real_link_verified=0
generate byte identity_xtset_ready=0
generate str80 identity_eligibility="unlinked_source_records_only"
generate double selected_firm_id=.
generate str64 selected_district_code=district_code
generate str80 identity_district_status=cond(district_code=="","source_missing","reported_source_code_not_revision_harmonized")
generate long dummy_firm_id=.
generate str64 dummy_district_code=""
generate byte dummy_district_count=.
generate long identity_seed=.
generate str80 identity_method="off_preserve_source_ids; no_synthetic_fallback"
label variable selected_firm_id "MODE-DEPENDENT panel key: always check identity_mode/is_dummy"
label variable dummy_firm_id "SIMULATION ONLY: not a real firm identifier or match"
label variable dummy_district_code "SIMULATION ONLY: arbitrary groups, NOT BPS district codes"
label variable identity_real_link_verified "Verified crosswalk flag; independent of dummy xtset readiness"
label variable identity_xtset_ready "Technical uniqueness only; dummy readiness is NOT real linkage"
* Isi blok hanya dijalankan bila "`mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`mode'"=="dummy" {
    * Reuse U320 exact random-slot method and seed (25 August 2026).
    generate str2 demo_province=province_code
    replace demo_province="00" if demo_province==""
    generate str2 demo_industry2=substr(industry_code,1,2)
    replace demo_industry2="00" if demo_industry2==""
    sort source_year demo_province demo_industry2 source_row
    set rng mt64
    set seed 20260825
    generate double __random_order=runiform()
    sort source_year demo_province demo_industry2 __random_order source_row
    by source_year demo_province demo_industry2: generate long demo_slot=_n
    egen long __synthetic=group(demo_province demo_industry2 demo_slot)
    replace dummy_firm_id=__synthetic
    replace selected_firm_id=dummy_firm_id
    * Arbitrary demo geography: stable across years for each synthetic slot.
    * Five artificial groups/province by default; not administrative geography.
    generate byte demo_district_slot=mod(demo_slot-1,`dummy_district_count')+1
    replace dummy_district_code="DUMMY_P"+demo_province+"_D"+string(demo_district_slot,"%02.0f")
    replace dummy_district_count=`dummy_district_count'
    replace selected_district_code=dummy_district_code
    replace identity_district_status="arbitrary_simulation_groups; NOT_BPS_kabkot"
    replace identity_seed=20260825
    replace identity_method="U320_province_industry2_random_slot; synthetic_district_slot_groups"
    replace identity_xtset_ready=1
    replace identity_eligibility="simulation_only; no_real_firm_or_spatial_inference"
    drop __random_order __synthetic
    bysort dummy_firm_id (source_year): assert demo_province==demo_province[1] & demo_industry2==demo_industry2[1]
    bysort dummy_firm_id (source_year): assert dummy_district_code==dummy_district_code[1]
    assert identity_real_link_verified==0
    assert strpos(dummy_district_code,"DUMMY_")==1
    isid selected_firm_id source_year
    xtset selected_firm_id source_year
}
* Isi blok hanya dijalankan bila "`mode'" sama dengan "real". // WFDOC-INJECTED
if "`mode'"=="real" {
* Isi blok hanya dijalankan bila `"`real_crosswalk'"' sama dengan "". // WFDOC-INJECTED
    if `"`real_crosswalk'"'=="" {
        display as error "REAL_CROSSWALK_REQUIRED: no synthetic fallback."
        log close G0identity
        exit 198
    }
    capture confirm file "`real_crosswalk'"
* Isi blok hanya dijalankan bila _rc. // WFDOC-INJECTED
    if _rc {
        display as error "REAL_CROSSWALK_NOT_FOUND: no synthetic fallback."
        log close G0identity
        exit 601
    }
    tempfile base validated
    save `base'
    use "`real_crosswalk'", clear
    confirm variable source_year source_row real_firm_id real_district_code real_link_verified real_id_source
    confirm numeric variable source_year source_row real_link_verified
    confirm string variable real_firm_id real_district_code real_id_source
    isid source_year source_row
    assert real_link_verified==1
    assert strtrim(real_firm_id)!="" & strtrim(real_id_source)!=""
    assert !inlist(upper(strtrim(real_firm_id)),"***",".","NA","N/A","NULL","-")
    assert strpos(upper(real_firm_id),"DUMMY")==0
    capture confirm variable identity_test_fixture
    if !_rc assert identity_test_fixture!=1
    assert strlen(real_district_code)<=64
    * District may remain missing; never invent a real code to complete it.
    keep source_year source_row real_firm_id real_district_code real_link_verified real_id_source
    save `validated'
    use `base', clear
    merge 1:1 source_year source_row using `validated', assert(match) nogen
    * Numeric recoding preserves exact provided real ID; creates no linkage.
    egen double __real_numeric=group(real_firm_id)
    replace selected_firm_id=__real_numeric
    drop __real_numeric
    replace selected_district_code=real_district_code
    replace identity_district_status=cond(real_district_code=="","verified_crosswalk_district_missing","crosswalk_reported_district; revision_bridge_separate")
    replace identity_real_link_verified=1
    replace identity_xtset_ready=1
    replace identity_eligibility="real_crosswalk_verified; other_G0_definition_gates_remain"
    replace identity_method="provided_verified_crosswalk; numeric_recode_of_real_firm_id"
    assert identity_is_dummy==0 & missing(dummy_firm_id) & dummy_district_code==""
    isid selected_firm_id source_year
    xtset selected_firm_id source_year
}
* Isi blok hanya dijalankan bila "`mode'" sama dengan "off". // WFDOC-INJECTED
if "`mode'"=="off" {
    assert missing(selected_firm_id) & missing(dummy_firm_id)
    assert identity_is_dummy==0 & identity_real_link_verified==0 & identity_xtset_ready==0
    assert selected_district_code==district_code
    xtset, clear
}
assert _N==`original_n'
isid source_year source_row
sort source_year source_row
order source_year source_row identity_mode identity_is_dummy identity_real_link_verified identity_xtset_ready selected_firm_id selected_district_code dummy_firm_id dummy_district_code
save "`data'/G0_identity_spine_`mode'.dta", replace
preserve
    generate byte __selected=!missing(selected_firm_id)
    generate byte __source_id=(source_id_raw!="")
    generate byte __source_district=(district_code!="")
    generate byte __selected_district=(selected_district_code!="")
    collapse (count) records=source_row (sum) selected_id_rows=__selected source_id_rows=__source_id source_district_rows=__source_district selected_district_rows=__selected_district dummy_rows=identity_is_dummy real_link_rows=identity_real_link_verified, by(source_year identity_mode identity_eligibility)
    export delimited using "`reports'/coverage_`mode'.csv", replace
restore
* Isi blok hanya dijalankan bila "`mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`mode'"=="dummy" {
    preserve
        bysort dummy_firm_id: generate int waves_observed=_N
        bysort dummy_firm_id (source_year): keep if _n==1
        keep dummy_firm_id demo_province demo_industry2 demo_slot dummy_district_code waves_observed identity_is_dummy identity_seed identity_method
        export delimited using "`reports'/dummy_id_register.csv", replace
    restore
}
display as result "G0_IDENTITY_ADAPTER_SUCCESS mode=`mode' rows=" _N
log close G0identity
