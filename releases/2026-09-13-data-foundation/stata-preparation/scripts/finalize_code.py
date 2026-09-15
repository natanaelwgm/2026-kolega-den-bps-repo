from pathlib import Path
import json,re,hashlib
R=Path(__file__).resolve().parents[1]; O=R.parent/'G0-rebuild';D='dag/data/word_data/G0';P='dag/edges/word_rows/G0'
def put(p,s):
 p=R/p;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
# Master-only authoritative boundary. Generator and operative copies both reflect latest owner steering.
for p in [R/'scripts/build_foundation.py']+list((R/'code').rglob('*.do'))+list((R/'rows').rglob('*.do'))+list((R/'dag/edges').rglob('*.do')):
 s=p.read_text();s=s.replace('data/analysis/ready_from_waves.dta','data/analysis/G0_analysis_ready.dta');p.write_text(s)
# export_flag's true file dependency is the previous working export_any_binary leaf.
ops=json.loads((R/'registry/leaf-operands.json').read_text())
for a in ops['working']:
 if a['variable']=='export_flag':
  p=R/a['launcher'];s=p.read_text();marker='tempfile metrics\n';dep=f'{D}/analysis_tunnel/N_G0_tunnel_export_any_binary_{a["year"]}.dta'
  s=s.replace(marker,'drop export_any_binary vs_export_any_binary\nmerge 1:1 source_year source_row using "'+dep+'", assert(match) nogen keepusing(export_any_binary vs_export_any_binary)\n'+marker);p.write_text(s);a['additional_parents']=[dep]
put('registry/leaf-operands.json',json.dumps(ops,indent=2)+'\n')
# Explicit extra field/year counts, separate from unchanged 4591-column X04 report.
put('code/reports/new_token_field_coverage.do','''do "code/init.do"
use source_year source_row rd17_own_token_class rd17_external_token_class using "data/analysis/G0_analysis_ready.dta", clear
tempname q
postfile `q' str32 variable int source_year long rows observed missing_rows using "report/tables/new_token_field_coverage.dta", replace
foreach v in rd17_own_token_class rd17_external_token_class {
 foreach y in 2010 2011 2012 2013 2014 2015 2017 2018 2019 2020 2021 2022 {
  quietly count if source_year==`y'
  local n=r(N)
  quietly count if source_year==`y' & !missing(`v')
  post `q' ("`v'") (`y') (`n') (r(N)) (`n'-r(N))
 }
}
postclose `q'
use "report/tables/new_token_field_coverage.dta", clear
isid variable source_year
assert _N==24
export delimited using "report/tables/new_token_field_coverage.csv", datafmt quote replace
''')
p=R/'code/stages/F090_reports.do';s=p.read_text().replace('display "WF_STAGE_F090_REPORTS_PASS"','do "code/reports/new_token_field_coverage.do"\ndisplay "WF_STAGE_F090_REPORTS_PASS"');p.write_text(s)
# Master equality is checked by validation, not a numerical construction fallback.
put('code/validation/compare_master.do',f'''do "code/init.do"
use "data/analysis/G0_analysis_ready.dta", clear
assert _N==33049 & c(k)==4593
isid source_year source_row
assert rd17_own_token_class=="" & rd17_external_token_class=="" if source_year!=2017
drop rd17_own_token_class rd17_external_token_class
cf _all using "{O}/corrections/data/C140.dta", all
display "WF_MASTER_ORIGINAL_4591_VALUES_EXACT"
''')
stages=json.loads((R/'registry/stages.json').read_text());idx=next(i for i,x in enumerate(stages) if x['id']=='F090A');stages.insert(idx+1,{'id':'V085','path':'code/validation/compare_master.do'});put('registry/stages.json',json.dumps(stages,indent=2)+'\n')
# A reusable merge guard used by actual annual merges, exercised with real rejection fixtures.
put('code/merge_guard.do','''capture program drop wf_merge_guard
program define wf_merge_guard
 syntax, USING(string) FIELDS(string) YEAR(integer)
 assert source_year==`year'
 isid source_year source_row
 local oldn=_N
 foreach v of local fields {
  capture confirm variable `v'
  assert _rc==111
 }
 preserve
 use "`using'", clear
 assert source_year==`year'
 isid source_year source_row
 foreach v of local fields {
  confirm variable `v'
 }
 restore
 merge 1:1 source_year source_row using "`using'", assert(match) nogen keepusing(`fields')
 assert _N==`oldn'
 isid source_year source_row
end
''')
# Use guard for each mapped merge (working leaves also have unique output ownership).
for p in (R/'code/annual').glob('merge_*.do'):
 s=p.read_text();y=int(p.stem[-4:]);s=s.replace('do "code/init.do"','do "code/init.do"\ndo "code/merge_guard.do"')
 s=re.sub(r'merge 1:1 source_year source_row using "([^\"]+)", assert\(match\) nogen keepusing\(([^\)]+)\)',lambda m:f'wf_merge_guard, using("{m.group(1)}") fields("{m.group(2)}") year({y})',s)
 # Working parents are only keys; declare exact complete 3-column leaf payload.
 if 'working' in p.name:
  for a in [a for a in ops['working'] if a['year']==y]:
   fields=[v for v in a['fields'] if v not in ['source_year','source_row']]
   s=s.replace(f'merge 1:1 source_year source_row using "{a["artifact"]}", assert(match) nogen',f'wf_merge_guard, using("{a["artifact"]}") fields("'+ ' '.join(fields)+f'") year({y})')
 p.write_text(s)
put('code/validation/merge_fixtures.do','''do "code/init.do"
do "code/merge_guard.do"
clear
input int source_year long source_row double x
2010 1 10
2010 2 20
end
tempfile good bad base
save `good'
drop x
save `base'
wf_merge_guard, using("`good'") fields("x") year(2010)
assert x==source_row*10
capture noisily wf_merge_guard, using("`good'") fields("x") year(2010)
assert _rc!=0
use `base', clear
capture noisily wf_merge_guard, using("`good'") fields("absent_field") year(2010)
assert _rc!=0
use `good', clear
replace source_row=1
save `bad'
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
assert _rc!=0
use `good', clear
replace source_year=2011
save `bad', replace
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
assert _rc!=0
use `good', clear
replace source_row=3 if source_row==2
save `bad', replace
use `base', clear
capture noisily wf_merge_guard, using("`bad'") fields("x") year(2010)
assert _rc!=0
use `good', clear
replace x=999 if source_row==1
save `bad', replace
use `base', clear
wf_merge_guard, using("`bad'") fields("x") year(2010)
assert x==999 if source_row==1
assert x==20 if source_row==2
display "WF_MERGE_FIXTURES_PASS_7"
''')
stages=json.loads((R/'registry/stages.json').read_text());stages.insert(0,{'id':'T000','path':'code/validation/merge_fixtures.do'});put('registry/stages.json',json.dumps(stages,indent=2)+'\n')
print('Master/working dependency/merge guard and fixtures finalized; no Stata execution.')

for p in (R/"code").rglob("*.do"):
 s=p.read_text().replace('do "code/init.do"',f'do "{R}/code/init.do"');p.write_text(s)
