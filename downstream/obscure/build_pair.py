"""Create actual/obscured pair; numerical transformations execute in native Stata."""
import os
for k in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']:os.environ[k]='1'
from pathlib import Path
import sys,json,hashlib,hmac,secrets,datetime,uuid,csv,shutil,subprocess,re
R=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(R/'harness/g05'))
from column_policy import classify
import numpy as np,pandas as pd

def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(4*1024**2),b''):h.update(b)
 return h.hexdigest()
def write(p,x):Path(p).write_text(json.dumps(x,indent=2,default=str)+'\n')
def run_stata(run,name,code):
 p=run/(name+'.do');p.write_text(code)
 print('STATA |',name,flush=True)
 c=subprocess.run(['/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','-b','do',p.name],cwd=run)
 log=(run/(name+'.log')).read_text();assert c.returncode==0 and '\nPAIR_STEP_DONE\n' in log,(name,log[-2500:])
 print('STATA PASS |',name,flush=True)

def main():
 receipt=json.loads((R/'downstream/reports/latest-build.json').read_text())
 src=Path(receipt['outputs']['actual']['file']);assert sha(src)==receipt['outputs']['actual']['sha256']
 output=Path(sys.argv[1]);output.mkdir(parents=True,exist_ok=True)
 if shutil.disk_usage(output).free<2*1024**3:raise ValueError('Need 2 GiB output headroom')
 run=output/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]);run.mkdir()
 (run/'data').mkdir();(run/'reports').mkdir()
 print('RUN |',run,flush=True)
 shutil.copyfile(src,run/'data/actual.dta')
 before=pd.read_stata(src,convert_categoricals=False)
 keydir=Path('/Users/natanaelmassie/Downloads/.kolega-private');keydir.mkdir(mode=0o700,exist_ok=True)
 keypath=keydir/(run.name+'.key');key=secrets.token_bytes(32);keypath.write_bytes(key);keypath.chmod(0o600)
 factors=[]
 for obs in before.obs_id:
  b=hmac.new(key,str(obs).encode(),hashlib.sha256).digest();u=int.from_bytes(b[:8],'big')/2**64;factors.append(1+(-1 if b[8]&1 else 1)*(.001+.004*u))
 factorfile=keydir/(run.name+'-factors.dta');pd.DataFrame({'obs_id':before.obs_id,'__f':factors}).to_stata(factorfile,write_index=False,version=118)
 meta={'firm_id','psid','psid_status','dataset_mode','panel_id_synthetic','panel_key_available','dev_panel_stratum','dev_prev_obs_id','dev_prev_year','dev_link_status'}
 policies=[]
 for n in before:
  action='preserve';reason='category, identifier, source flag, reference or unchanged ratio'
  if pd.api.types.is_numeric_dtype(before[n]) and not n.startswith('dev_nominal_'):
   action=classify(n)['action']
   if '_per_worker' in n or n in ['va_signed_per_worker','r_labor_productivity_nominal']:action='per_worker'
   if n in ['workers','production_workers','rd_workers']:action='count'
   if n in ['export_share_pct','foreign_ownership_pct']:action='percentage'
   if n=='va_signed_tail_sensitivity':action='scale'
   if n=='va_log_positive':action='log_shift'
   if n=='r_ln_workers':action='log_count_shift'
  if n.endswith('_state') or n.startswith(('st_','vs_','qs_','qn_','v_')):action='preserve'
  if n in meta:action='new_dummy_metadata';reason='declared exception: fictional identity/mode metadata'
  policies.append({'variable':n,'action':action,'reason':reason if action=='preserve' or n in meta else 'explicit numerical perturbation policy'})
 with (run/'reports/column_policy.csv').open('w') as f:
  w=csv.DictWriter(f,fieldnames=list(policies[0]));w.writeheader();w.writerows(policies)
 # Pull the three missing identity-feature operands from the SAME pinned G0 parent.
 parent=receipt['source_inputs']['actual']['path'];assert sha(parent)==receipt['source_inputs']['actual']['sha256']
 extra=['val_efuvcu','val_zpdvcu','val_zndvcu']
 code=f'''version 17
set more off
set varabbrev off
set maxvar 5000
use source_year source_row {' '.join(extra)} using "{parent}", clear
isid source_year source_row
tempfile extra
save `extra'
use "{src}", clear
generate long __order=_n
merge 1:1 source_year source_row using `extra', assert(match) nogen
merge 1:1 obs_id using "{factorfile}", assert(match) nogen
sort __order
generate double __old_workers=workers
'''
 for n in ['workers','production_workers','rd_workers']:
  code+=f'recast double {n}\nreplace {n}=max(1,round({n}*__f)) if {n}>0 & !missing({n})\n'
 code+='replace workers=min(workers,100) if __old_workers<=100 & __old_workers>0\nreplace workers=max(workers,101) if __old_workers>100 & !missing(__old_workers)\n'
 code+='generate double __wf=cond(__old_workers>0 & !missing(__old_workers),workers/__old_workers,1)\n'
 for row in policies+[{'variable':n,'action':'scale'} for n in extra]:
  n,action=row['variable'],row['action']
  formula={'scale':f'{n}*__f','log_shift':f'{n}+ln(__f)','per_worker':f'{n}*__f/__wf','log_count_shift':f'{n}+ln(__wf)'}.get(action)
  if formula:code+=f'recast double {n}\nreplace {n}={formula} if !missing({n})\n'
  if action=='percentage':
   code+=f'recast double {n}\ngenerate double __old_{n}={n}\nreplace {n}=min(100,{n}*__f) if {n}>0 & {n}<100\n'
   if n=='foreign_ownership_pct':code+=f'replace {n}=min({n},9.999999999) if __old_{n}<10 & __old_{n}>0\nreplace {n}=max(10,{n}) if __old_{n}>=10 & __old_{n}<100\n'
   code+=f'drop __old_{n}\n'
 code+=f'''drop __f __wf __old_workers
save "{run/'working_obscured.dta'}", replace
keep obs_id source_year province_code industry_code workers gross_output_nominal value_added_nominal intermediate_inputs_nominal val_rtlvcu {' '.join(extra)} elec_pln_kwh
save "{run/'matching_features.dta'}", replace
display "PAIR_STEP_DONE"
'''
 run_stata(run,'01_obscure_numeric',code)
 from panel_generator import generate,INPUT_COLUMNS
 match=pd.read_stata(run/'matching_features.dta',convert_categoricals=False)
 ids,report=generate(match[INPUT_COLUMNS],seed=20260916,progress=lambda x:print('DUMMY PANEL |',json.dumps(x),flush=True))
 keys=['obs_id','psid','psid_status','dev_panel_stratum','dev_prev_obs_id','dev_prev_year','dev_link_status']
 ids[keys].to_stata(run/'dummy_ids.dta',write_index=False,version=118)
 write(run/'reports/dummy_panel.json',report)
 code=f'''version 17
set more off
set varabbrev off
use "{run/'working_obscured.dta'}", clear
drop psid psid_status dev_panel_stratum dev_prev_obs_id dev_prev_year dev_link_status
merge 1:1 obs_id using "{run/'dummy_ids.dta'}", assert(match) nogen
recast double firm_id
replace firm_id=psid
replace dataset_mode="obscured"
replace panel_id_synthetic=1
replace panel_key_available=1
assert panel_empirical_ready==0 & g1_results_attached==0
sort __order
drop __order {' '.join(extra)}
isid firm_id year
isid obs_id
label data "OBSCURED numerical values + fictional IDs; research categories unchanged"
label variable firm_id "Fictional panel company ID; not verified real linkage"
char _dta[scope] "Actual-derived obscured data; categories kept; G1 requires a new estimation"
compress
save "{run/'data/obscured_dummy.dta'}", replace
xtset firm_id year
generate double _test_L=L.va_signed_nominal
assert missing(_test_L) if year==2017
display "PAIR_STEP_DONE"
'''
 run_stata(run,'02_attach_dummy',code)
 after=pd.read_stata(run/'data/obscured_dummy.dta',convert_categoricals=False)
 assert set(before)==set(after) and len(before)==len(after)==33049
 assert before.obs_id.equals(after.obs_id)
 # Independent semantic check: diagnostic/category fields cannot be transformed
 # merely because their name contains a quantitative parent such as per_worker.
 catpattern=re.compile(r'(^st_|^vs_|^qs_|^qn_|^v_|_state$|_status$|_flag$|_code$|_eligible$|_observed$|_verified$|_valid$|_ready$|_binary$)')
 semantic_categories=[n for n in before if catpattern.search(n) and n not in meta]
 for n in semantic_categories:
  assert (before[n].eq(after[n])|(before[n].isna()&after[n].isna())).all(),('Categorical field changed',n)
 protected=[];changes=[]
 for row in policies:
  n=row['variable'];b=before[n];a=after[n];same=(a.eq(b)|(a.isna()&b.isna()));changed=int((~same).sum())
  if row['action']=='preserve':
   assert same.all(),('Protected field changed',n);protected.append(n)
  if row['action'] not in ['new_dummy_metadata']:
   assert a.isna().equals(b.isna()),('Missingness changed',n)
  changes.append({**row,'changed_cells':changed})
 assert not after[['firm_id','year']].duplicated().any() and after.firm_id.notna().all()
 assert after.groupby('firm_id').dev_panel_stratum.nunique().le(1).all()
 assert after.year.value_counts().to_dict()==before.year.value_counts().to_dict()
 for n in ['workers','production_workers','rd_workers']:
  vals=after[n].dropna();assert np.all(vals==np.round(vals)),n
 # Every previously satisfied equation must remain satisfied. Audit masks are frozen from actual.
 from build_development import coherence_relations,check_coherence
 from collections import defaultdict
 coherence=defaultdict(lambda:defaultdict(int));relations=coherence_relations(list(before))
 relations += [{'output':'va_log_positive','operation':'log','inputs':['va_signed_nominal']},{'output':'va_signed_per_worker','operation':'ratio','inputs':['va_signed_nominal','workers']}]
 check_coherence(before,after,relations,coherence)
 assert sha(run/'data/actual.dta')==sha(src)
 for n in ['export_share_pct','foreign_ownership_pct']:
  eligible=before[n].between(0,100);assert after.loc[eligible,n].between(0,100).all()
 assert ((before.workers>100)==(after.workers>100)).all()
 with (run/'reports/change_audit.csv').open('w') as f:
  w=csv.DictWriter(f,fieldnames=list(changes[0]));w.writeheader();w.writerows(changes)
 summary={'status':'passed','run':str(run),'rows':len(after),'columns':len(after.columns),'semantic_categories_exact':len(semantic_categories),'protected_fields_exact':len(protected),'changed_numeric_fields':sum(x['changed_cells']>0 and x['action']!='new_dummy_metadata' for x in changes),'changed_numeric_cells':sum(x['changed_cells'] for x in changes if x['action']!='new_dummy_metadata'),'dummy_firms':report['synthetic_firms'],'level_relative_change':{'min':.001,'max':.005},'counts':'integer rounding; preserve >100 worker category','percentages':'bounded 0..100; preserve zeros/full shares and FDI 10pct domain','coherence':dict(coherence),'actual_sha256':sha(run/'data/actual.dta'),'obscured_sha256':sha(run/'data/obscured_dummy.dta'),'g1_reestimated':False,'categories':'exact per obs_id except declared dummy identity/mode metadata','fully_anonymous':False,'source_build':str(src),'key_hash':hashlib.sha256(key).hexdigest()}
 write(run/'COMPLETE.json',summary);write(R/'downstream/obscure/latest.json',summary)
 (run/'README.md').write_text('# Actual + obscured/dummy pair\n\nTwo datasets, same 33,049 rows and 515 field names.\n\n- data/actual.dta: byte-identical verified actual projection. Firm IDs remain missing.\n- data/obscured_dummy.dta: numerical magnitudes perturbed by 0.1–0.5%; worker counts rounded to integers, percentages bounded; categorical source values preserved exactly. Firm IDs are newly fictional.\n\nDerived logs/per-worker values follow changed magnitudes. Ratios sharing the same scaling factor remain unchanged by arithmetic. Zeros, missingness, calendar and categorical thresholds are retained. Flags describe inherited source quality; no new empirical admission.\n\nG1 columns remain missing in BOTH files: historical G1 estimates belong to a different input version and require re-estimation for this obscured dataset. Original G1 outputs remain in the previous package. This is development perturbation, not a guarantee of anonymity.\n\nreports/column_policy.csv and change_audit.csv list the rule and exact number of changed cells for every field. COMPLETE.json contains checksums and tests. Private key/factors are stored outside this package.\n')
 for name in ['actual','obscured_dummy']:
  text=f'version 17\nset more off\nuse "{run/"data"/(name+".dta")}", clear\nisid obs_id year\n'
  if name=='obscured_dummy':text+='xtset firm_id year\n'
  (run/('01_OPEN_ACTUAL.do' if name=='actual' else '02_OPEN_OBSCURED_DUMMY.do')).write_text(text)
 # Owned intermediate artifacts remain under scratch; do not duplicate them in the handoff.
 scratch=run/'scratch';scratch.mkdir()
 for n in ['working_obscured.dta','matching_features.dta','dummy_ids.dta']:(run/n).rename(scratch/n)
 # Verification complete; ephemeral factors are reproducible from the separate private key.
 factorfile.unlink()
 print('PAIR COMPLETE |',json.dumps(summary),flush=True)
if __name__=='__main__':main()
