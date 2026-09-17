"""Pin sources and independently validate/package Stata-built projections."""
import os
for key in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']:os.environ[key]='1'
from pathlib import Path
import sys,json,hashlib,datetime,uuid,shutil,csv,html

def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(4*1024**2),b''):h.update(b)
 return h.hexdigest()
def write(p,obj):Path(p).write_text(json.dumps(obj,indent=2,default=str)+'\n')
def code(root):
 files=[root/'downstream/00_MASTER.do',root/'downstream/contracts/fields.json',*sorted((root/'downstream/code').glob('*.do'))]
 return {str(p.relative_to(root)):sha(p) for p in files}
def prepare(root,actual,g1,output,reply):
 root=Path(root);out=Path(output);out.mkdir(parents=True,exist_ok=True)
 if shutil.disk_usage(out).free<2*1024**3:raise ValueError('Need at least 2 GiB free on output volume')
 run=out/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]);run.mkdir()
 for d in ['data','reports','logs','metadata']:(run/d).mkdir()
 sources={}
 for name,p in [('actual',Path(actual)),('development',Path(g1))]:
  print('PIN SOURCE |',name,p,flush=True)
  sources[name]={'path':str(p),'bytes':p.stat().st_size,'sha256':sha(p)}
 receipt=json.loads((root/'work-items/G1/release/run-manifest.json').read_text())
 assert receipt['stata_exit_code']==0 and receipt['successful_primary_models']==41
 assert receipt['actual_finalisation_status']=='NOT_RUN_NOT_ADMITTED'
 for p in (root/'downstream/contracts').glob('*'):
  if p.is_file():shutil.copyfile(p,run/'metadata'/p.name)
 write(run/'BUILD.json',{'status':'building','source_inputs':sources,'code':code(root),'g1_receipt_sha256':sha(root/'work-items/G1/release/run-manifest.json'),'g1_status':receipt['development_status'],'created_at':datetime.datetime.now().astimezone().isoformat(),'root':str(root)})
 Path(reply).write_text('global DS_RUN "'+str(run)+'"\n')
 print('READY |',run,flush=True)
def finish(root,run):
 import pandas as pd
 root=Path(root);run=Path(run);m=json.loads((run/'BUILD.json').read_text());assert code(root)==m['code'],'Source code changed during execution'
 summary={};schema={}
 expected={2010:2334,2011:2337,2012:2359,2013:2369,2014:2452,2015:2632,2017:3357,2018:3011,2019:3007,2020:2936,2021:3078,2022:3177}
 for mode,name in [('actual','analysis_actual'),('development','panel_development')]:
  p=run/f'data/{name}.dta';print('VERIFY |',p,flush=True)
  df=pd.read_stata(p,convert_categoricals=False);assert len(df)==33049
  assert df.obs_id.is_unique and not df[['obs_id','year']].duplicated().any()
  assert df.year.value_counts().sort_index().to_dict()==expected
  assert (df.panel_empirical_ready==0).all() and (df.g1_real_tfp_ready==0).all()
  assert (df.dataset_mode==mode).all()
  assert df.district_code.eq('').all()
  if mode=='actual':assert df.firm_id.isna().all() and df.filter(regex='^dev_nominal_tfp_').isna().all().all()
  else:
   assert df.firm_id.notna().all() and not df[['firm_id','year']].duplicated().any()
   assert (df.panel_id_synthetic==1).all()
  cov=pd.read_csv(run/f'reports/coverage_{mode}.csv');assert (cov.N==cov.nonmissing+cov.missing_n).all();assert len(cov)==len(df.columns)*12
  assert cov.groupby('variable').N.sum().eq(33049).all()
  schema[mode]=set(df.columns)
  summary[mode]={'file':str(p),'rows':len(df),'columns':len(df.columns),'sha256':sha(p),'bytes':p.stat().st_size,'years':expected,'nonmissing_firm_ids':int(df.firm_id.notna().sum()),'distinct_firm_ids':int(df.firm_id.nunique()),'district_nonmissing':int(df.district_code.ne('').sum()),'province_nonmissing':int(df.province_code.ne('').sum()),'g1_nonmissing':{x:int(df[x].notna().sum()) for x in df if x.startswith('dev_nominal_tfp_')}}
  with pd.read_stata(p,iterator=True) as r:
   labs=r.variable_labels()
  with (run/f'metadata/dictionary_{mode}.csv').open('w') as f:
   w=csv.writer(f);w.writerow(['variable','storage','label','nonmissing'])
   for n in df:w.writerow([n,str(df[n].dtype),labs.get(n,''),int((df[n].notna() & (df[n].ne('') if df[n].dtype=='object' else True)).sum())])
  del df,cov
 assert schema['actual']==schema['development'],'Outputs must expose the same field names'
 log=(run/'logs/00_MASTER.log').read_text()
 for signal in ['SOURCE VALUES EXACT | actual','SOURCE VALUES EXACT | development','G1_SIDECAR_EXACT']:assert signal in log,signal
 for mode,src in m['source_inputs'].items():
  print('RECHECK SOURCE |',mode,flush=True);assert sha(src['path'])==src['sha256'],'Input changed during run'
 readiness=[
 ['Dataset structure, keys, Stata-readable schema','ready','ready','33,049 rows; same field names; preserved calendar'],
 ['Year/province/source-sector descriptive programming','conditional','development_only','Keep missingness and annual semantic/unit gates; sector vintages not bridged'],
 ['Firm fixed effects, lags, transitions, DID','blocked','development_only','Actual company crosswalk unavailable; development IDs fictional'],
 ['District-level analysis','blocked','blocked','All district codes unavailable; province is not substituted'],
 ['Nominal G1 residual analysis','not_attached','development_only','Existing 41 primary fits retained, source sidecar reconciled'],
 ['Real TFP, deflated output/capital comparisons','blocked','blocked','Deflators, stock/unit semantics and classification bridge not admitted'],
 ['2016 outcomes or consecutive 2015-2017 annual lags','unavailable','unavailable','2016 absent; use true calendar lags'],
 ['All 44 downstream requests empirically complete','no','no','377 prerequisite references preserved; dataset assembly does not execute/admit each analysis']]
 with (run/'reports/readiness.csv').open('w') as f:
  w=csv.writer(f);w.writerow(['use','actual','development','reason']);w.writerows(readiness)
 m.update(status='passed_structural_and_source_preservation',outputs=summary,all_downstream_empirically_ready=False,completed_at=datetime.datetime.now().astimezone().isoformat())
 write(run/'COMPLETE.json',m);write(root/'downstream/reports/latest-build.json',m)
 # Honest reusable handoff without copying the large original masters.
 for mode,name in [('actual','analysis_actual'),('development','panel_development')]:
  body='version 17\nset more off\nuse "'+str(run/f'data/{name}.dta')+'", clear\nisid obs_id year\n'
  if mode=='development':body+='xtset firm_id year\ndisplay as result "DEVELOPMENT: fictional panel IDs; nominal G1 results"\n'
  else:body+='display as result "ACTUAL: record-year data; firm_id unverified/missing"\n'
  (run/('01_OPEN_DEVELOPMENT.do' if mode=='development' else '02_OPEN_ACTUAL.do')).write_text(body)
 for f in ['README.md','SCHEMA.md']:
  if (root/'downstream'/f).exists():shutil.copyfile(root/'downstream'/f,run/f)
 print('PACKAGE VERIFIED |',json.dumps(summary),flush=True)
if __name__=='__main__':
 if sys.argv[1]=='prepare':prepare(*sys.argv[2:])
 elif sys.argv[1]=='finish':finish(*sys.argv[2:])
