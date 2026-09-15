* Tujuan: Jalankan perintah yang tercantum di file ini pada data atau argumen yang disediakan pemanggilnya. // WFDOC-INJECTED
* Input: dag/data/word_data/G0/G0_main_candidate.dta; `real_crosswalk' // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:step-version" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 1 59 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:step-version" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 1 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L2:step-clear" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 2 59 `=_rc' // WFLOG-INJECTED
clear all
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L2:step-clear" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 2 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L3:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 3 59 `=_rc' // WFLOG-INJECTED
set more off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L3:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 3 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L4:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 4 59 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L4:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 4 59 `=_rc' // WFLOG-INJECTED
* Owner-requested optional identity adapter. Never rewrite the frozen G0 main.
* Arguments: DAG_ROOT [off|dummy|real] [VERIFIED_CROSSWALK] [DUMMY_DISTRICTS]
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L7:step-args" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 5 59 `=_rc' // WFLOG-INJECTED
args dag_root mode real_crosswalk dummy_district_count
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L7:step-args" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 5 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L8:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 6 59 `=_rc' // WFLOG-INJECTED
if `"`dag_root'"'=="" local dag_root "."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L8:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 6 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L9:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 7 59 `=_rc' // WFLOG-INJECTED
if `"`mode'"'=="" local mode "off"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L9:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 7 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 8 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila bukan inlist("`mode'","off","dummy","real"). // WFDOC-INJECTED
if !inlist("`mode'","off","dummy","real") {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L11:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    display as error "IDENTITY_MODE_INVALID: use off (default), dummy, or real."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L11:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L12:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    exit 198
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L12:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L10:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 8 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L14:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 9 59 `=_rc' // WFLOG-INJECTED
if `"`dummy_district_count'"'=="" local dummy_district_count 5
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L14:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 9 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 10 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila kolom real("`dummy_district_count'" kosong) atau real("`dummy_district_count'") kurang dari 1 atau real("`dummy_district_count'") lebih dari 99 atau mod(real("`dummy_district_count'"),1)bukan =0. // WFDOC-INJECTED
if missing(real("`dummy_district_count'")) | real("`dummy_district_count'")<1 | real("`dummy_district_count'")>99 | mod(real("`dummy_district_count'"),1)!=0 {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L16:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
    display as error "DUMMY_DISTRICTS_INVALID: integer 1..99 required."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L16:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "statement" 1 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L17:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
    exit 198
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L17:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "statement" 2 2 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L15:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 10 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L19:step-cd" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 11 59 `=_rc' // WFLOG-INJECTED
cd "`dag_root'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L19:step-cd" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 11 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L20:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 12 59 `=_rc' // WFLOG-INJECTED
local data "dag/data/word_data/G0/identity-options"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L20:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 12 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L21:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 13 59 `=_rc' // WFLOG-INJECTED
local reports "dag/reports/word_data/G0/identity-options"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L21:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 13 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L22:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 14 59 `=_rc' // WFLOG-INJECTED
local logs "dag/logs/word_data/G0/identity-options"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L22:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 14 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L23:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 15 59 `=_rc' // WFLOG-INJECTED
capture mkdir "`data'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L23:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 15 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L24:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 16 59 `=_rc' // WFLOG-INJECTED
capture mkdir "`reports'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L24:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 16 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L25:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 17 59 `=_rc' // WFLOG-INJECTED
capture mkdir "`logs'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L25:step-mkdir" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 17 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L26:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 18 59 `=_rc' // WFLOG-INJECTED
capture log close G0identity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L26:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 18 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L27:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 19 59 `=_rc' // WFLOG-INJECTED
log using "`logs'/G0_identity_`mode'.log", text replace name(G0identity)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L27:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 19 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L28:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 20 59 `=_rc' // WFLOG-INJECTED
use source_year source_row province_code district_code industry_code source_id_raw using "dag/data/word_data/G0/G0_main_candidate.dta", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L28:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 20 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L29:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 21 59 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L29:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 21 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L30:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 22 59 `=_rc' // WFLOG-INJECTED
local original_n=_N
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L30:step-local" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 22 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L31:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 23 59 `=_rc' // WFLOG-INJECTED
generate str8 identity_mode="`mode'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L31:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 23 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L32:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 24 59 `=_rc' // WFLOG-INJECTED
generate byte identity_is_dummy=("`mode'"=="dummy")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L32:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 24 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L33:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 25 59 `=_rc' // WFLOG-INJECTED
generate byte identity_real_link_verified=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L33:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 25 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L34:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 26 59 `=_rc' // WFLOG-INJECTED
generate byte identity_xtset_ready=0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L34:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 26 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L35:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 27 59 `=_rc' // WFLOG-INJECTED
generate str80 identity_eligibility="unlinked_source_records_only"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L35:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 27 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L36:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 28 59 `=_rc' // WFLOG-INJECTED
generate double selected_firm_id=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L36:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 28 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L37:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 29 59 `=_rc' // WFLOG-INJECTED
generate str64 selected_district_code=district_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L37:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 29 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L38:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 30 59 `=_rc' // WFLOG-INJECTED
generate str80 identity_district_status=cond(district_code=="","source_missing","reported_source_code_not_revision_harmonized")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L38:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 30 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L39:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 31 59 `=_rc' // WFLOG-INJECTED
generate long dummy_firm_id=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L39:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 31 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L40:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 32 59 `=_rc' // WFLOG-INJECTED
generate str64 dummy_district_code=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L40:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 32 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L41:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 33 59 `=_rc' // WFLOG-INJECTED
generate byte dummy_district_count=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L41:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 33 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L42:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 34 59 `=_rc' // WFLOG-INJECTED
generate long identity_seed=.
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L42:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 34 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L43:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 35 59 `=_rc' // WFLOG-INJECTED
generate str80 identity_method="off_preserve_source_ids; no_synthetic_fallback"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L43:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 35 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L44:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 36 59 `=_rc' // WFLOG-INJECTED
label variable selected_firm_id "MODE-DEPENDENT panel key: always check identity_mode/is_dummy"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L44:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 36 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L45:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 37 59 `=_rc' // WFLOG-INJECTED
label variable dummy_firm_id "SIMULATION ONLY: not a real firm identifier or match"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L45:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 37 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L46:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 38 59 `=_rc' // WFLOG-INJECTED
label variable dummy_district_code "SIMULATION ONLY: arbitrary groups, NOT BPS district codes"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L46:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 38 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L47:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 39 59 `=_rc' // WFLOG-INJECTED
label variable identity_real_link_verified "Verified crosswalk flag; independent of dummy xtset readiness"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L47:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 39 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L48:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 40 59 `=_rc' // WFLOG-INJECTED
label variable identity_xtset_ready "Technical uniqueness only; dummy readiness is NOT real linkage"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L48:step-label" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 40 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 41 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`mode'"=="dummy" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
    * Reuse U320 exact random-slot method and seed (25 August 2026).
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L51:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 1 29 `=_rc' // WFLOG-INJECTED
    generate str2 demo_province=province_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L51:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 1 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L52:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 2 29 `=_rc' // WFLOG-INJECTED
    replace demo_province="00" if demo_province==""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L52:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 2 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L53:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 3 29 `=_rc' // WFLOG-INJECTED
    generate str2 demo_industry2=substr(industry_code,1,2)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L53:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 3 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L54:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 4 29 `=_rc' // WFLOG-INJECTED
    replace demo_industry2="00" if demo_industry2==""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L54:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 4 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L55:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 5 29 `=_rc' // WFLOG-INJECTED
    sort source_year demo_province demo_industry2 source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L55:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 5 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L56:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 6 29 `=_rc' // WFLOG-INJECTED
    set rng mt64
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L56:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 6 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L57:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 7 29 `=_rc' // WFLOG-INJECTED
    set seed 20260825
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L57:step-set" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 7 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L58:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 8 29 `=_rc' // WFLOG-INJECTED
    generate double __random_order=runiform()
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L58:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 8 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L59:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 9 29 `=_rc' // WFLOG-INJECTED
    sort source_year demo_province demo_industry2 __random_order source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L59:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 9 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L60:step-by" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 10 29 `=_rc' // WFLOG-INJECTED
    by source_year demo_province demo_industry2: generate long demo_slot=_n
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L60:step-by" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 10 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L61:step-egen" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 11 29 `=_rc' // WFLOG-INJECTED
    egen long __synthetic=group(demo_province demo_industry2 demo_slot)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L61:step-egen" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 11 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L62:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 12 29 `=_rc' // WFLOG-INJECTED
    replace dummy_firm_id=__synthetic
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L62:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 12 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L63:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 13 29 `=_rc' // WFLOG-INJECTED
    replace selected_firm_id=dummy_firm_id
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L63:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 13 29 `=_rc' // WFLOG-INJECTED
    * Arbitrary demo geography: stable across years for each synthetic slot.
    * Five artificial groups/province by default; not administrative geography.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L66:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 14 29 `=_rc' // WFLOG-INJECTED
    generate byte demo_district_slot=mod(demo_slot-1,`dummy_district_count')+1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L66:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 14 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L67:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 15 29 `=_rc' // WFLOG-INJECTED
    replace dummy_district_code="DUMMY_P"+demo_province+"_D"+string(demo_district_slot,"%02.0f")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L67:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 15 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L68:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 16 29 `=_rc' // WFLOG-INJECTED
    replace dummy_district_count=`dummy_district_count'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L68:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 16 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L69:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 17 29 `=_rc' // WFLOG-INJECTED
    replace selected_district_code=dummy_district_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L69:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 17 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L70:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 18 29 `=_rc' // WFLOG-INJECTED
    replace identity_district_status="arbitrary_simulation_groups; NOT_BPS_kabkot"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L70:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 18 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L71:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 19 29 `=_rc' // WFLOG-INJECTED
    replace identity_seed=20260825
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L71:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 19 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L72:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 20 29 `=_rc' // WFLOG-INJECTED
    replace identity_method="U320_province_industry2_random_slot; synthetic_district_slot_groups"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L72:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 20 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L73:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 21 29 `=_rc' // WFLOG-INJECTED
    replace identity_xtset_ready=1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L73:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 21 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L74:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 22 29 `=_rc' // WFLOG-INJECTED
    replace identity_eligibility="simulation_only; no_real_firm_or_spatial_inference"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L74:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 22 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L75:step-drop" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 23 29 `=_rc' // WFLOG-INJECTED
    drop __random_order __synthetic
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L75:step-drop" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 23 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L76:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 24 29 `=_rc' // WFLOG-INJECTED
    bysort dummy_firm_id (source_year): assert demo_province==demo_province[1] & demo_industry2==demo_industry2[1]
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L76:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 24 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L77:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 25 29 `=_rc' // WFLOG-INJECTED
    bysort dummy_firm_id (source_year): assert dummy_district_code==dummy_district_code[1]
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L77:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 25 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L78:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 26 29 `=_rc' // WFLOG-INJECTED
    assert identity_real_link_verified==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L78:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 26 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L79:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 27 29 `=_rc' // WFLOG-INJECTED
    assert strpos(dummy_district_code,"DUMMY_")==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L79:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 27 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L80:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 28 29 `=_rc' // WFLOG-INJECTED
    isid selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L80:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 28 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L81:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 29 29 `=_rc' // WFLOG-INJECTED
    xtset selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L81:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "statement" 29 29 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L49:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 41 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 42 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`mode'" sama dengan "real". // WFDOC-INJECTED
if "`mode'"=="real" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 1 33 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila `"`real_crosswalk'"' sama dengan "". // WFDOC-INJECTED
    if `"`real_crosswalk'"'=="" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L85:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
        display as error "REAL_CROSSWALK_REQUIRED: no synthetic fallback."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L85:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L86:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
        log close G0identity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L86:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L87:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
        exit 198
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L87:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L84:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 1 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L89:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 2 33 `=_rc' // WFLOG-INJECTED
    capture confirm file "`real_crosswalk'"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L89:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 2 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 3 33 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila _rc. // WFDOC-INJECTED
    if _rc {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L91:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
        display as error "REAL_CROSSWALK_NOT_FOUND: no synthetic fallback."
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L91:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L92:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
        log close G0identity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L92:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L93:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
        exit 601
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L93:step-exit" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
    }
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L90:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 3 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L95:step-tempfile" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 4 33 `=_rc' // WFLOG-INJECTED
    tempfile base validated
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L95:step-tempfile" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 4 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L96:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 5 33 `=_rc' // WFLOG-INJECTED
    save `base'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L96:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 5 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L97:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 6 33 `=_rc' // WFLOG-INJECTED
    use "`real_crosswalk'", clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L97:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 6 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L98:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 7 33 `=_rc' // WFLOG-INJECTED
    confirm variable source_year source_row real_firm_id real_district_code real_link_verified real_id_source
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L98:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 7 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L99:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 8 33 `=_rc' // WFLOG-INJECTED
    confirm numeric variable source_year source_row real_link_verified
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L99:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 8 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L100:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 9 33 `=_rc' // WFLOG-INJECTED
    confirm string variable real_firm_id real_district_code real_id_source
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L100:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 9 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L101:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 10 33 `=_rc' // WFLOG-INJECTED
    isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L101:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 10 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L102:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 11 33 `=_rc' // WFLOG-INJECTED
    assert real_link_verified==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L102:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 11 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L103:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 12 33 `=_rc' // WFLOG-INJECTED
    assert strtrim(real_firm_id)!="" & strtrim(real_id_source)!=""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L103:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 12 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L104:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 13 33 `=_rc' // WFLOG-INJECTED
    assert !inlist(upper(strtrim(real_firm_id)),"***",".","NA","N/A","NULL","-")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L104:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 13 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L105:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 14 33 `=_rc' // WFLOG-INJECTED
    assert strpos(upper(real_firm_id),"DUMMY")==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L105:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 14 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L106:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 15 33 `=_rc' // WFLOG-INJECTED
    capture confirm variable identity_test_fixture
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L106:step-confirm" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 15 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L107:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 16 33 `=_rc' // WFLOG-INJECTED
    if !_rc assert identity_test_fixture!=1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L107:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 16 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L108:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 17 33 `=_rc' // WFLOG-INJECTED
    assert strlen(real_district_code)<=64
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L108:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 17 33 `=_rc' // WFLOG-INJECTED
    * District may remain missing; never invent a real code to complete it.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L110:step-keep" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 18 33 `=_rc' // WFLOG-INJECTED
    keep source_year source_row real_firm_id real_district_code real_link_verified real_id_source
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L110:step-keep" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 18 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L111:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 19 33 `=_rc' // WFLOG-INJECTED
    save `validated'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L111:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 19 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L112:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 20 33 `=_rc' // WFLOG-INJECTED
    use `base', clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L112:step-use" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 20 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L113:step-merge" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 21 33 `=_rc' // WFLOG-INJECTED
    merge 1:1 source_year source_row using `validated', assert(match) nogen
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L113:step-merge" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 21 33 `=_rc' // WFLOG-INJECTED
    * Numeric recoding preserves exact provided real ID; creates no linkage.
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L115:step-egen" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 22 33 `=_rc' // WFLOG-INJECTED
    egen double __real_numeric=group(real_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L115:step-egen" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 22 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L116:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 23 33 `=_rc' // WFLOG-INJECTED
    replace selected_firm_id=__real_numeric
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L116:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 23 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L117:step-drop" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 24 33 `=_rc' // WFLOG-INJECTED
    drop __real_numeric
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L117:step-drop" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 24 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L118:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 25 33 `=_rc' // WFLOG-INJECTED
    replace selected_district_code=real_district_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L118:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 25 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L119:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 26 33 `=_rc' // WFLOG-INJECTED
    replace identity_district_status=cond(real_district_code=="","verified_crosswalk_district_missing","crosswalk_reported_district; revision_bridge_separate")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L119:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 26 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L120:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 27 33 `=_rc' // WFLOG-INJECTED
    replace identity_real_link_verified=1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L120:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 27 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L121:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 28 33 `=_rc' // WFLOG-INJECTED
    replace identity_xtset_ready=1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L121:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 28 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L122:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 29 33 `=_rc' // WFLOG-INJECTED
    replace identity_eligibility="real_crosswalk_verified; other_G0_definition_gates_remain"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L122:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 29 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L123:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 30 33 `=_rc' // WFLOG-INJECTED
    replace identity_method="provided_verified_crosswalk; numeric_recode_of_real_firm_id"
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L123:step-replace" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 30 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L124:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 31 33 `=_rc' // WFLOG-INJECTED
    assert identity_is_dummy==0 & missing(dummy_firm_id) & dummy_district_code==""
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L124:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 31 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L125:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 32 33 `=_rc' // WFLOG-INJECTED
    isid selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L125:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 32 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L126:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 33 33 `=_rc' // WFLOG-INJECTED
    xtset selected_firm_id source_year
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L126:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "statement" 33 33 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L83:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 42 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 43 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`mode'" sama dengan "off". // WFDOC-INJECTED
if "`mode'"=="off" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L129:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
    assert missing(selected_firm_id) & missing(dummy_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L129:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L130:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
    assert identity_is_dummy==0 & identity_real_link_verified==0 & identity_xtset_ready==0
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L130:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L131:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
    assert selected_district_code==district_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L131:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L132:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
    xtset, clear
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L132:step-xtset" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L128:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 43 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L134:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 44 59 `=_rc' // WFLOG-INJECTED
assert _N==`original_n'
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L134:step-assert" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 44 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L135:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 45 59 `=_rc' // WFLOG-INJECTED
isid source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L135:step-isid" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 45 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L136:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 46 59 `=_rc' // WFLOG-INJECTED
sort source_year source_row
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L136:step-sort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 46 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L137:step-order" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 47 59 `=_rc' // WFLOG-INJECTED
order source_year source_row identity_mode identity_is_dummy identity_real_link_verified identity_xtset_ready selected_firm_id selected_district_code dummy_firm_id dummy_district_code
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L137:step-order" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 47 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L138:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 48 59 `=_rc' // WFLOG-INJECTED
save "`data'/G0_identity_spine_`mode'.dta", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L138:step-save" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 48 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L139:step-preserve" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 49 59 `=_rc' // WFLOG-INJECTED
preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L139:step-preserve" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 49 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L140:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 50 59 `=_rc' // WFLOG-INJECTED
    generate byte __selected=!missing(selected_firm_id)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L140:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 50 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L141:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 51 59 `=_rc' // WFLOG-INJECTED
    generate byte __source_id=(source_id_raw!="")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L141:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 51 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L142:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 52 59 `=_rc' // WFLOG-INJECTED
    generate byte __source_district=(district_code!="")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L142:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 52 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L143:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 53 59 `=_rc' // WFLOG-INJECTED
    generate byte __selected_district=(selected_district_code!="")
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L143:step-generate" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 53 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L144:step-collapse" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 54 59 `=_rc' // WFLOG-INJECTED
    collapse (count) records=source_row (sum) selected_id_rows=__selected source_id_rows=__source_id source_district_rows=__source_district selected_district_rows=__selected_district dummy_rows=identity_is_dummy real_link_rows=identity_real_link_verified, by(source_year identity_mode identity_eligibility)
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L144:step-collapse" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 54 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L145:step-export" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 55 59 `=_rc' // WFLOG-INJECTED
    export delimited using "`reports'/coverage_`mode'.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L145:step-export" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 55 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L146:step-restore" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 56 59 `=_rc' // WFLOG-INJECTED
restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L146:step-restore" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 56 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 57 59 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`mode'" sama dengan "dummy". // WFDOC-INJECTED
if "`mode'"=="dummy" {
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L148:step-preserve" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
    preserve
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L148:step-preserve" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L149:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
        bysort dummy_firm_id: generate int waves_observed=_N
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L149:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L150:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
        bysort dummy_firm_id (source_year): keep if _n==1
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L150:step-bysort" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L151:step-keep" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
        keep dummy_firm_id demo_province demo_industry2 demo_slot dummy_district_code waves_observed identity_is_dummy identity_seed identity_method
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L151:step-keep" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L152:step-export" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
        export delimited using "`reports'/dummy_id_register.csv", replace
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L152:step-export" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L153:step-restore" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
    restore
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L153:step-restore" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:block-body" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
}
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L147:step-if" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 57 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L155:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 58 59 `=_rc' // WFLOG-INJECTED
display as result "G0_IDENTITY_ADAPTER_SUCCESS mode=`mode' rows=" _N
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L155:step-display" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 58 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "dag/edges/word_rows/G0/G0_select_identity_mode.do:L156:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 59 59 `=_rc' // WFLOG-INJECTED
log close G0identity
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L156:step-log" "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "statement" 59 59 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "dag/edges/word_rows/G0/G0_select_identity_mode.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
