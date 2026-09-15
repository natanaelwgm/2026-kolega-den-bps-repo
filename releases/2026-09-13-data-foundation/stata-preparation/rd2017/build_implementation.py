#!/usr/bin/env python3
"""Generate only declared Stata code and metadata; never read company values."""
from pathlib import Path
import json,hashlib
H=Path(__file__).resolve().parent; P=H.parents[1]/'G0-RD2017-phase-B-plan'
F=H.parent
freeze=json.loads((F/'plan-freeze.json').read_text())
assert freeze['status']=='READY_FOR_IMPLEMENTATION'
for item in freeze['files']: assert hashlib.sha256(Path(item['path']).read_bytes()).hexdigest()==item['sha256']
schema=json.loads((H/'inputs/output-schema.json').read_text());counts=json.loads((H/'inputs/counts-registry.json').read_text());sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
assert json.loads((P/'root-freeze.json').read_text())['plan_manifest_sha256']==sha(P/'plan-manifest.json')

def write(p,s):
 p=H/p;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')

def ordered(spec):return ' '.join(x['name'] for x in schema[spec]['fields'])
lib=r'''
version 17
set varabbrev off
capture program drop rd17_candidate
program define rd17_candidate
 syntax, STAGE(string)
 if "`stage'"=="tokens" {
  confirm string variable raw_rnd17 raw_costrd17
  assert inlist(parent_present,0,1) & inlist(child_present,0,1)
  clonevar parent_token=raw_rnd17
  clonevar child_token=raw_costrd17
  replace parent_token=ustrtrim(parent_token)
  replace child_token=ustrtrim(child_token)
  foreach side in parent child {
   generate str6 `side'_token_class="other"
   replace `side'_token_class=`side'_token if inlist(`side'_token,"1","2")
   replace `side'_token_class="blank" if `side'_token==""
   replace `side'_token_class="absent" if `side'_present==0
  }
  exit
 }
 if "`stage'"=="universe" {
  generate byte rd_universe_candidate=.
  replace rd_universe_candidate=0 if parent_token_class=="2"
  replace rd_universe_candidate=1 if parent_token_class=="1"
  replace rd_universe_candidate=2 if inlist(parent_token_class,"blank","other")
  replace rd_universe_candidate=3 if parent_token_class=="absent"
  assert inrange(rd_universe_candidate,0,3)
  exit
 }
 if "`stage'"=="answer" {
  generate byte rd_answer_state_candidate=.
  replace rd_answer_state_candidate=4 if rd_universe_candidate==1
  replace rd_answer_state_candidate=5 if inlist(rd_universe_candidate,2,3)
  replace rd_answer_state_candidate=0 if rd_universe_candidate==0 & child_token_class=="1"
  replace rd_answer_state_candidate=1 if rd_universe_candidate==0 & child_token_class=="2"
  replace rd_answer_state_candidate=2 if rd_universe_candidate==0 & child_token_class=="blank"
  replace rd_answer_state_candidate=3 if rd_universe_candidate==0 & child_token_class=="other"
  replace rd_answer_state_candidate=6 if rd_universe_candidate==0 & child_token_class=="absent"
  assert inrange(rd_answer_state_candidate,0,6)
  generate byte rd_external_candidate=.
  replace rd_external_candidate=1 if rd_answer_state_candidate==0
  replace rd_external_candidate=0 if rd_answer_state_candidate==1
  assert missing(rd_external_candidate) if !inlist(rd_answer_state_candidate,0,1)
  exit
 }
 if "`stage'"=="audit" {
  generate byte outside_answer_candidate=rd_universe_candidate==1 & inlist(child_token_class,"1","2","other")
  generate byte measurement_admitted=0
  generate byte primary_release=0
  assert missing(rd_external_candidate) if rd_universe_candidate!=0
  assert outside_answer_candidate==0 if rd_universe_candidate!=1
  exit
 }
 display as error "Undeclared classifier stage"
 exit 198
end
capture program drop rd17_ratio
program define rd17_ratio
 confirm numeric variable eligible_yes_n eligible_no_n eligible_n
 assert !missing(eligible_yes_n,eligible_no_n,eligible_n)
 assert eligible_yes_n>=0 & eligible_no_n>=0 & eligible_n>=eligible_yes_n+eligible_no_n
 assert inlist(estimate_id,"candidate_yes_among_known_eligible","candidate_known_response_coverage")
 generate long numerator_n=.
 generate long denominator_n=.
 replace numerator_n=eligible_yes_n if estimate_id=="candidate_yes_among_known_eligible"
 replace denominator_n=eligible_yes_n+eligible_no_n if estimate_id=="candidate_yes_among_known_eligible"
 replace numerator_n=eligible_yes_n+eligible_no_n if estimate_id=="candidate_known_response_coverage"
 replace denominator_n=eligible_n if estimate_id=="candidate_known_response_coverage"
 generate double ratio=.
 replace ratio=numerator_n/denominator_n if denominator_n>0 & !missing(denominator_n,numerator_n)
 generate double percent=100*ratio if !missing(ratio)
 assert missing(ratio) & missing(percent) if denominator_n==0
 assert inrange(ratio,0,1) & inrange(percent,0,100) if denominator_n>0
end
'''
# Generate the exact fixed group predicates once, shared by fixtures and actual data.
groups=counts['groups'];idx={x['group_id']:i+1 for i,x in enumerate(groups)}
lib+='\ncapture program drop rd17_counts\nprogram define rd17_counts\n syntax, SAVING(string) EXPECTED(integer)\n assert _N==`expected\'\n assert source_year==2017\n'
for i,g in enumerate(groups,1):
 pred=g['predicate'].replace('\\"','"')
 lib+=f' quietly count if {pred}\n local C{i}=r(N)\n'
for a,bs in [('all_rows',['eligible','structural_skip','parent_blank','parent_invalid','parent_absent']),('eligible',['eligible_yes','eligible_no','eligible_blank','eligible_invalid','eligible_child_absent']),('eligible_known',['eligible_yes','eligible_no']),('unknown_parent',['parent_blank','parent_invalid','parent_absent'])]:
 lib+=' assert `C'+str(idx[a])+"'=="+'+'.join('`C'+str(idx[b])+"'" for b in bs)+'\n'
lib+=' tempname POST\n postfile `POST\' int source_year str40 group_id long numerator_n str40 denominator_id long denominator_n byte candidate_only byte measurement_admitted using "`saving\'", replace\n'
for g in groups:
 lib+=' post `POST\' (2017) ("'+g['group_id']+'") (`C'+str(idx[g['group_id']])+"') (\""+g['denominator_id']+'") (`C'+str(idx[g['denominator_id']])+"') (1) (0)\n"
lib+=' postclose `POST\'\nend\n'
# Schema-driven typed import, ordering and exact structural checks.
lib+='\ncapture program drop rd17_import\nprogram define rd17_import\n syntax, FILE(string) SPEC(string)\n import delimited using "`file\'", varnames(1) case(preserve) stringcols(_all) bindquote(strict) encoding("UTF-8") clear\n'
for sn,s in schema.items():
 lib+=f' if "`spec\'"=="{sn}" {{\n'
 for f in s['fields']:
  n,t=f['name'],f['type']
  if t.startswith('str'):
   lib+=f'  assert strlen({n})<={t[3:]}\n  recast {t} {n}\n'
  else:
   lib+=f'  rename {n} __rd17_raw\n  generate {t} {n}=real(strtrim(__rd17_raw))\n  assert !missing({n}) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."\n  drop __rd17_raw\n'
 lib+=f'  order {ordered(sn)}\n  rd17_schema, spec("{sn}")\n  exit\n }}\n'
lib+=' display as error "Undeclared import schema"\n exit 198\nend\n'
lib+='\ncapture program drop rd17_schema\nprogram define rd17_schema\n syntax, SPEC(string)\n'
for sn,s in schema.items():
 lib+=f' if "`spec\'"=="{sn}" {{\n  unab actual_order : _all\n  assert "`actual_order\'"=="{ordered(sn)}"\n  assert _N=={s["rows"]}\n'
 for f in s['fields']:lib+=f'  local actual_type : type {f["name"]}\n  assert "`actual_type\'"=="{f["type"]}"\n'
 if sn=='fixture_results':lib+='  assert !missing(fixture_family) & !missing(fixture_id)\n  assert missing(estimate_id) if inlist(fixture_family,"truth25","literal")\n  assert !missing(estimate_id) if fixture_family=="ratio"\n  isid fixture_family fixture_id estimate_id, missok\n'
 else:lib+='  isid '+' '.join(s['key'])+'\n'
 if sn.endswith('_2017'):lib+='  assert source_year==2017\n  assert inrange(source_row,1,3357)\n'
 lib+='  exit\n }\n'
lib+=' display as error "Undeclared output schema"\n exit 198\nend\n'
lib+=r'''
capture program drop rd17_export
program define rd17_export
 syntax, STEM(string) SPEC(string)
 rd17_schema, spec("`spec'")
 save "`stem'.dta", replace
 unab original_order : _all
 quietly ds, has(type numeric)
 local numeric `r(varlist)'
 local types
 foreach v of local numeric {
  local t : type `v'
  local types "`types' `t'"
  format `v' %24.17g
 }
 local rows=_N
 local columns=c(k)
 export delimited using "`stem'.csv", datafmt nolabel quote replace
 rd17_import, file("`stem'.csv") spec("`spec'")
 assert _N==`rows' & c(k)==`columns'
 cf _all using "`stem'.dta"
 rd17_schema, spec("`spec'")
 use "`stem'.dta", clear
 rd17_schema, spec("`spec'")
 display "RD17_ROUNDTRIP_PASS `stem'"
end
'''
write('lib/shared.do',lib)

def edge(i,body):
 eid=f'RD17-{i:03d}'
 write(f'rows/G0/RD2017/{eid}.do',f'version 17\nlog using "runtime/{eid}.log", name(RD17CHILD) text replace\n'+body+f'\ndisplay "PASS CHILD {eid}"\nlog close RD17CHILD')

edge(0,r'''
confirm file "runtime/preflight.json"
confirm file "runtime/preflight_pass.do"
do "runtime/preflight_pass.do"
assert `"`c(tmpdir)'"'=="$RD17_SCRATCH/"
''')
fixture=''
for inputstem,spec,out,result_spec,family in [('truth25-literal-inputs','truth25_literal_inputs','truth25_results','fixture_truth25_results','truth25'),('literal-parser-fixtures','literal_parser_inputs','literal_results','fixture_literal_results','literal')]:
 fixture+=f'rd17_import, file("inputs/{inputstem}.csv") spec("{spec}")\n'
 fixture+='tempfile original\nsave `original\'\nforeach stage in tokens universe answer audit {\n rd17_candidate, stage("`stage\'")\n}\n'
 fixture+=r'''
assert parent_token_class==expected_parent_class & child_token_class==expected_child_class
assert rd_universe_candidate==expected_universe & rd_answer_state_candidate==expected_answer_state
assert rd_external_candidate==expected_external & outside_answer_candidate==expected_outside
assert measurement_admitted==expected_admission & primary_release==0
cf raw_rnd17 raw_costrd17 parent_present child_present using `original'
local a : type parent_token
local b : type child_token
assert "`a'"=="str40" & "`b'"=="str40"
'''
 if family=='truth25':
  fixture+='preserve\ngenerate int source_year=2017\ntempfile fc\nrd17_counts, saving("`fc\'") expected(25)\nuse `fc\', clear\n'
  expected=json.loads((P/'tests-specification.json').read_text())['shared_25case_expected_count_checks']
  for k,v in expected.items():fixture+=f'assert numerator_n=={v} if group_id=="{k}"\n'
  fixture+='restore\n'
 fixture+=f'generate byte passed=1\norder {ordered(result_spec)}\nrd17_export, stem("fixtures/{out}") spec("{result_spec}")\n'
fixture+='rd17_import, file("inputs/ratio-fixtures.csv") spec("ratio_fixture_inputs")\nrd17_ratio\n'
fixture+=r'''
assert numerator_n==expected_numerator_n & denominator_n==expected_denominator_n
assert missing(ratio)==expected_missing & missing(percent)==expected_missing
assert abs(ratio-expected_ratio)<=2*epsdouble()*max(1,abs(expected_ratio)) if expected_missing==0
assert abs(percent-expected_percent)<=2*epsdouble()*max(1,abs(expected_percent)) if expected_missing==0
assert ratio==expected_ratio if inlist(expected_ratio,0,1)
assert percent==expected_percent if inlist(expected_percent,0,100)
assert ratio!=float(ratio) & percent!=float(percent) if precision_probe==1
local a : type ratio
local b : type percent
assert "`a'"=="double" & "`b'"=="double"
generate byte passed=1
'''
fixture+=f'order {ordered("fixture_ratio_results")}\nrd17_export, stem("fixtures/ratio_results") spec("fixture_ratio_results")\n'
for family,stem in [('truth25','truth25_results'),('literal','literal_results'),('ratio','ratio_results')]:
 fixture+=f'use "fixtures/{stem}.dta", clear\nkeep fixture_id '+('estimate_id ' if family=='ratio' else '')+'passed\n'
 fixture+=f'generate str12 fixture_family="{family}"\n'
 if family!='ratio':fixture+='generate str40 estimate_id=""\n'
 fixture+=f'order {ordered("fixture_results")}\ntempfile f_{family}\nsave `f_{family}\'\n'
fixture+='use `f_truth25\', clear\nappend using `f_literal\' `f_ratio\'\nassert passed==1\nrd17_export, stem("fixtures/results") spec("fixture_results")\n'
fixture+='do "fixtures/bridge_checks.do"\n'
edge(10,fixture)

# Actual numerical branch: only published wave or this module's saved descendants.
edge(20,f'use {ordered("wave_2017_projection")} using "$RD17_MASTER", clear\nkeep if source_year==2017\norder {ordered("wave_2017_projection")}\nrd17_export, stem("states/wave_2017_projection") spec("wave_2017_projection")')
edge(30,f'use "states/wave_2017_projection.dta", clear\nrd17_from_wave, stage("classes")\norder {ordered("canonical_decisions_2017")}\nrd17_export, stem("states/canonical_decisions_2017") spec("canonical_decisions_2017")')
for i,inp,out,stage in [(40,'canonical_decisions_2017','universe_2017','universe'),(50,'universe_2017','answer_2017','answer')]:
 edge(i,f'use "states/{inp}.dta", clear\nrd17_from_wave, stage("{stage}")\norder {ordered(out)}\nrd17_export, stem("states/{out}") spec("{out}")')
edge(60,f'use "states/answer_2017.dta", clear\nrd17_from_wave, stage("audit")\norder {ordered("candidate_2017")}\nrd17_export, stem("outputs/candidate_2017") spec("candidate_2017")')
edge(70,r'''
use "outputs/candidate_2017.dta", clear
local N=_N
contract source_year parent_token_class child_token_class, freq(n) nomiss
recast long n
tempfile observed
save `observed'
rd17_import, file("inputs/truth25-literal-inputs.csv") spec("truth25_literal_inputs")
keep expected_parent_class expected_child_class
rename expected_parent_class parent_token_class
rename expected_child_class child_token_class
generate int source_year=2017
merge 1:1 source_year parent_token_class child_token_class using `observed'
assert inlist(_merge,1,3)
replace n=0 if _merge==1
assert n>=0 & !missing(n)
drop _merge
recast long n
generate long all_rows=`N'
generate byte measurement_admitted=0
quietly summarize n, meanonly
assert r(sum)==3357 & `N'==3357
order source_year parent_token_class child_token_class n all_rows measurement_admitted
rd17_export, stem("outputs/joint_counts") spec("joint_counts")
''')
edge(80,r'''
use "outputs/candidate_2017.dta", clear
rd17_counts, saving("outputs/group_counts.dta") expected(3357)
use "outputs/group_counts.dta", clear
assert numerator_n>=0 & denominator_n>=numerator_n
rd17_export, stem("outputs/group_counts") spec("group_counts")
''')
edge(90,r'''
use "outputs/group_counts.dta", clear
foreach g in eligible_yes eligible_no eligible {
 quietly summarize numerator_n if group_id=="`g'", meanonly
 assert r(N)==1
 local C_`g'=r(mean)
}
clear
set obs 2
generate int source_year=2017
generate str40 estimate_id="candidate_yes_among_known_eligible" in 1
replace estimate_id="candidate_known_response_coverage" in 2
generate long eligible_yes_n=`C_eligible_yes'
generate long eligible_no_n=`C_eligible_no'
generate long eligible_n=`C_eligible'
rd17_ratio
drop eligible_yes_n eligible_no_n eligible_n
generate long accepted_eligible_n=.
generate double accepted_positive_share=.
generate byte measurement_admitted=0
generate byte primary_release=0
rd17_export, stem("outputs/candidate_ratios") spec("candidate_ratios")
''')

edge(100,r"""
use "outputs/candidate_2017.dta", clear
isid source_year source_row
assert source_year==2017 & _N==3357
assert measurement_admitted==0 & primary_release==0
assert missing(rd_external_candidate) if rd_universe_candidate!=0
use "outputs/candidate_ratios.dta", clear
assert missing(accepted_eligible_n) & missing(accepted_positive_share)
assert measurement_admitted==0 & primary_release==0
use "fixtures/results.dta", clear
assert _N==61 & passed==1
do "validation/compare_current_wave.do"
""")
entry='version 17\nclear all\nset more off\nset varabbrev off\nargs foundation_root\n'
entry+='assert `"`foundation_root\'"\'!=""\n'
entry+='global RD17_FOUNDATION `"`foundation_root\'"\'\n'
entry+='global RD17_ROOT "$RD17_FOUNDATION/rd2017"\nglobal RD17_MASTER "$RD17_FOUNDATION/data/analysis/G0_analysis_ready.dta"\nglobal RD17_SCRATCH "$RD17_ROOT/scratch"\ncd "$RD17_ROOT"\n'
entry+='log using "runtime/run.log", name(RD17RUN) text replace\ndo "lib/shared.do"\ndo "lib/wave_rd17_classes.do"\ndo "lib/from_wave.do"\n'
for i in range(0,101,10):entry+=f'do "rows/G0/RD2017/RD17-{i:03d}.do"\n'
entry+='display "G0_RD2017_MASTER_ONLY_SUCCESS_CANDIDATE_ONLY"\nlog close RD17RUN\n'
write('rows/G0/RD2017/RD2017.do',entry)
write('run.do','version 17\nargs foundation_root\nassert `"`foundation_root\'"\'!=""\ndo `"`foundation_root\'/rd2017/rows/G0/RD2017/RD2017.do"\' `"`foundation_root\'"\'')
outmap={'states/wave_2017_projection':'wave_2017_projection','states/canonical_decisions_2017':'canonical_decisions_2017','states/universe_2017':'universe_2017','states/answer_2017':'answer_2017','outputs/candidate_2017':'candidate_2017','outputs/joint_counts':'joint_counts','outputs/group_counts':'group_counts','outputs/candidate_ratios':'candidate_ratios','fixtures/truth25_results':'fixture_truth25_results','fixtures/literal_results':'fixture_literal_results','fixtures/ratio_results':'fixture_ratio_results','fixtures/results':'fixture_results'}
write('output-contract.json',json.dumps({'status':'IMPLEMENTED_NOT_EXECUTED','table_schemas':outmap,'renderer_tables':{'RD17-X01':'outputs/group_counts.csv','RD17-X02':'outputs/joint_counts.csv','RD17-X03':'outputs/candidate_ratios.csv'},'final_manifest':'runtime/output-manifest.json','final_execution_receipt':'runtime/latest.json','measurement_admitted':False,'old_X13_changed':False,'actual_company_source':'../data/analysis/G0_analysis_ready.dta','validation_only_history':'../../G0-RD2017-phase-B-execution/outputs','ready_wave_schema_columns':4593},indent=2))
print(json.dumps({'process_children':11,'original_fixture_outcomes':61,'output_pairs':12,'status':'generated_not_run'}))
