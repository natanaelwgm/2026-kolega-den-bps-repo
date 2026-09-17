*! Log kemajuan saja: tidak menghitung data penelitian. Jangan instrumentasi berkas ini.
* Jam komputer dibaca sampai detik; langkah cepat boleh tercatat 0 detik.
* Kode kesalahan serta hasil r() dan e() milik perintah asli harus tetap sama.
program define __wf_progress
 version 17
 args action id parent kind ordinal total incoming_rc spec_type spec
 local saved_rc=real("`incoming_rc'")
 if missing(`saved_rc') local saved_rc=0
 tempname held_r
 _return hold `held_r'
 capture noisily __wf_progress_core `"`action'"' `"`id'"' `"`parent'"' `"`kind'"' `"`ordinal'"' `"`total'"' `"`saved_rc'"' `"`spec_type'"' `"`spec'"'
 local logger_rc=_rc
 _return restore `held_r'
 if `logger_rc'!=0 {
  local faults=real("$WFLOG_ERRORS")
  if missing(`faults') local faults=0
  global WFLOG_ERRORS=`faults'+1
  noisily display as error "WF_LOGGER_ERROR|action=`action'|id=`id'|logger_rc=`logger_rc'|scientific_rc=`saved_rc'"
 }
 exit `saved_rc'
end

program define __wf_progress_core
 version 17
 args action id parent kind ordinal total incoming_rc spec_type spec
 local now=clock("`c(current_date)' `c(current_time)'","DMYhms")/1000
 if missing(`now') error 198
 if "`action'"=="init" {
  if "$WFLOG_READY"=="1" error 198
  global WFLOG_READY=1
  global WFLOG_DEPTH=0
  global WFLOG_ERRORS=0
  global WFLOG_LAST : display %24.17g `now'
  noisily display "WF_PROGRESS|INITIALIZED|clock_resolution_s=1|clock=date_aware_wall"
  exit
 }
 if "$WFLOG_READY"!="1" error 198
 * Jam mundur berarti bukti waktu gagal; jangan mengubahnya diam-diam menjadi nol.
 if `now'<real("$WFLOG_LAST") error 198
 global WFLOG_LAST : display %24.17g `now'
 local depth=real("$WFLOG_DEPTH")
 if missing(`depth') | `depth'<0 error 198
 if "`action'"=="start" {
  * Reconcile lexical parent after original continue/break/exit/error transfers.
  * A new file or program with an empty parent attaches to the live caller.
  if `"`parent'"'!="" {
   local anchor=0
   forvalues j=`depth'(-1)1 {
    if `"${WFLOG_ID_`j'}"'==`"`parent'"' & `anchor'==0 local anchor=`j'
   }
   if `anchor'==0 error 198
   if `anchor'<`depth' {
    local floor=`anchor'+1
    forvalues j=`depth'(-1)`floor' {
     local why=cond(real("`incoming_rc'")!=0,"captured_error","parent_transfer")
     global WFLOG_DONE_`j'=1
     __wf_progress_emit UNWOUND `j' `now' `incoming_rc' `why'
     foreach slot in ID PAR K ORD TOT TIME EXPECT ITER DONE {
      macro drop WFLOG_`slot'_`j'
     }
    }
    local depth=`anchor'
    global WFLOG_DEPTH=`depth'
   }
  }
  else if `depth'>0 local parent `"${WFLOG_ID_`depth'}"'
  local ord=real("`ordinal'")
  local tot=real("`total'")
  if missing(`ord') | missing(`tot') error 198
  local expected=0
  if "`kind'"=="loop" {
   if inlist("`spec_type'","in","local-expanded","global-expanded") {
    local expected : word count `spec'
   }
   else if "`spec_type'"=="varlist" {
    unab expanded : `spec'
    local expected : word count `expanded'
   }
   else if "`spec_type'"=="numlist" {
    numlist `"`spec'"'
    local expanded `r(numlist)'
    local expected : word count `expanded'
   }
   else if "`spec_type'"=="forvalues" {
    local clean=subinstr(`"`spec'"'," ","",.)
    if regexm("`clean'","^(-?[0-9]+)/(-?[0-9]+)$") {
     local first=real(regexs(1))
     local last=real(regexs(2))
     local step=1
    }
    else if regexm("`clean'","^(-?[0-9]+)\((-?[0-9]+)\)(-?[0-9]+)$") {
     local first=real(regexs(1))
     local step=real(regexs(2))
     local last=real(regexs(3))
    }
    else error 198
    if `step'==0 error 198
    local expected=max(0,floor((`last'-`first')/`step')+1)
   }
   else if "`spec_type'"=="count" local expected=real("`spec'")
   else error 198
   if missing(`expected') | `expected'<0 | `expected'!=floor(`expected') error 198
  }
  if "`kind'"=="iteration" & `ord'==0 & `tot'==0 {
   local loop=0
   forvalues j=`depth'(-1)1 {
    if "${WFLOG_K_`j'}"=="loop" & `loop'==0 local loop=`j'
   }
   if `loop'==0 error 198
   local ord=real("${WFLOG_ITER_`loop'}")+1
   local tot=real("${WFLOG_EXPECT_`loop'}")
   if `ord'>`tot' error 198
   global WFLOG_ITER_`loop'=`ord'
  }
  if `ord'<1 | `tot'<1 | `ord'>`tot' error 198
  local depth=`depth'+1
  global WFLOG_DEPTH=`depth'
  global WFLOG_ID_`depth' `"`id'"'
  global WFLOG_PAR_`depth' `"`parent'"'
  global WFLOG_K_`depth' `"`kind'"'
  global WFLOG_ORD_`depth'=`ord'
  global WFLOG_TOT_`depth'=`tot'
  global WFLOG_TIME_`depth' : display %24.17g `now'
  global WFLOG_EXPECT_`depth'=`expected'
  global WFLOG_ITER_`depth'=0
  global WFLOG_DONE_`depth'=0
  __wf_progress_emit STARTING `depth' `now' `incoming_rc' start
  exit
 }
 if inlist("`action'","end","jump","abort","close") {
  local target=0
  if inlist("`action'","end","jump") {
   forvalues j=`depth'(-1)1 {
    if "${WFLOG_ID_`j'}"=="`id'" & `target'==0 local target=`j'
   }
   if `target'==0 error 198
  }
  else local target=1
  if "`action'"=="close" & `depth'!=0 error 198
  if "`action'"=="close" {
   global WFLOG_READY=0
   noisily display "WF_PROGRESS|CLOSED|depth=0|errors=$WFLOG_ERRORS"
   exit
  }
  forvalues j=`depth'(-1)`target' {
   local event=cond("`action'"=="end" & `j'==`target',"FINISHED","UNWOUND")
   local why=cond("`action'"=="end" & `j'==`target',cond(real("`incoming_rc'")!=0,"captured_rc","end"),cond("`action'"=="jump","jump_`kind'",cond("`action'"=="abort","abort",cond(real("`incoming_rc'")!=0,"captured_error","early_return"))))
   global WFLOG_DONE_`j'=1
   __wf_progress_emit `event' `j' `now' `incoming_rc' `why'
   foreach slot in ID PAR K ORD TOT TIME EXPECT ITER DONE {
    macro drop WFLOG_`slot'_`j'
   }
  }
  global WFLOG_DEPTH=`target'-1
  exit
 }
 error 198
end

program define __wf_progress_emit
 version 17
 args event depth now incoming_rc reason
 local elapsed=real("`now'")-real("${WFLOG_TIME_`depth'}")
 local x=real("${WFLOG_ORD_`depth'}")-1+real("${WFLOG_DONE_`depth'}")
 local X=real("${WFLOG_TOT_`depth'}")
 local pct=100*`x'/`X'
 local elapsed_text : display %12.0f `elapsed'
 local pct_text : display %6.1f `pct'
 noisily display "WF_PROGRESS|`event'|level=`depth'|id=${WFLOG_ID_`depth'}|kind=${WFLOG_K_`depth'}|x=`x'|X=`X'|pct=`pct_text'|elapsed_s=`elapsed_text'|clock_resolution_s=1|rc=`incoming_rc'|reason=`reason'"
 forvalues j=1/`depth' {
  local elapsed=real("`now'")-real("${WFLOG_TIME_`j'}")
  local elapsed_text : display %12.0f `elapsed'
  local ord=real("${WFLOG_ORD_`j'}")
  local total=real("${WFLOG_TOT_`j'}")
  local done=`ord'-1+real("${WFLOG_DONE_`j'}")
  local pct_text : display %6.1f 100*`done'/`total'
  local child_x=.
  local child_X=.
  local child_pct_text "."
  if `j'<real("`depth'") {
   local child=`j'+1
   local child_x=real("${WFLOG_ORD_`child'}")-1+real("${WFLOG_DONE_`child'}")
   local child_X=real("${WFLOG_TOT_`child'}")
   local child_pct_text : display %6.1f 100*`child_x'/`child_X'
  }
  noisily display "WF_STACK|level=`j'|id=${WFLOG_ID_`j'}|kind=${WFLOG_K_`j'}|x=`done'|X=`total'|pct=`pct_text'|elapsed_s=`elapsed_text'|clock_resolution_s=1|child_x=`child_x'|child_X=`child_X'|child_pct=`child_pct_text'|iteration=${WFLOG_ITER_`j'}|iterations=${WFLOG_EXPECT_`j'}"
 }
end
