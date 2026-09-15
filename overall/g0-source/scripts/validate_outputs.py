"""Post-exit metadata/hash/schema audit. Statistical values are compared only in Stata."""
from pathlib import Path
import json,hashlib,csv
import pandas as pd
R=Path(__file__).resolve().parents[1];O=R.parent/'G0-rebuild'
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
 return h.hexdigest()
def schema(p):
 with pd.read_stata(p,iterator=True,convert_categoricals=False) as r:
  labs=r.variable_labels();return {'rows':r._nobs,'columns':r._nvar,'dataset_label':r.data_label,'fields':[{'name':n,'storage':t,'label':labs[n],'display_format':f,'value_label':l} for n,t,f,l in zip(r._varlist,r._typlist,r._fmtlist,r._lbllist)]}
def value_labels(p):
 with pd.read_stata(p,iterator=True,convert_categoricals=False) as r:return r.value_labels()
def rec(p):return {'path':str(p.relative_to(R)),'sha256':sha(p),'bytes':p.stat().st_size,'schema':schema(p)}
def audit(stage):
 if stage in ['V070','V080','V085']:
  kind={'V070':'baseline','V080':'corrected','V085':'corrected'}[stage];sc=json.loads((R/f'registry/{kind}-schema.json').read_text())
  path=R/({'V070':'dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta','V080':'corrections/data/C140.dta','V085':'data/analysis/G0_analysis_ready.dta'}[stage]);actual=schema(path)
  assert actual['rows']==sc['rows'];assert actual['fields'][:sc['columns']]==sc['fields'],f'{stage} exact field/schema mismatch';assert actual['dataset_label']==sc['dataset_label']
  assert actual['columns']==sc['columns']+(2 if stage=='V085' else 0)
  witness=O/('dag/data/word_data/G0/G0_analysis_ready_ACTUAL_LOCAL.dta' if stage=='V070' else 'corrections/data/C140.dta')
  assert value_labels(path)==value_labels(witness),f'{stage} exact value-label definitions mismatch'
  out=rec(path)
  if stage=='V085':
   waves=[rec(p) for p in sorted((R/'data/waves').glob('wave_*.dta'))];assert len(waves)==12
   for w in waves:assert w['schema']['fields']==actual['fields'] and w['schema']['columns']==4593
   assert sum(w['schema']['rows'] for w in waves)==33049
   (R/'runtime/wave-output-manifest.json').write_text(json.dumps({'status':'passed','parent_process_exited':True,'master':out,'waves':waves,'original_projection_columns':4591,'declared_new_columns':['rd17_own_token_class','rd17_external_token_class']},indent=2)+'\n')
  return {'schema_status':'passed','artifact':out}
 if stage=='V060':
  ops=json.loads((R/'registry/leaf-operands.json').read_text());count=0
  for e in ops['mapped']+ops['working']:
   rel=e['artifact'];assert schema(R/rel)==schema(O/rel),rel;assert value_labels(R/rel)==value_labels(O/rel),rel;count+=1
  assert count==2904;return {'schema_status':'passed','exact_leaf_schemas':count,'value_equality':'owned Stata cf success marker required separately'}
 if stage=='V090':
  old=json.loads((O/'corrections/runtime/aggregate-output-manifest.json').read_text())['reports'];reports=[]
  for x in old:
   p=R/'corrections/reports'/Path(x['path']).name;actual=schema(p)
   # Core exporter intentionally formats all numeric fields to 17 digits in memory only.
   assert actual==x['schema'],f'aggregate schema mismatch {p.name}';assert value_labels(p)==value_labels(x['path']),p.name;c=p.with_suffix('.csv');assert c.exists()
   reports.append({**rec(p),'csv_path':str(c.relative_to(R)),'csv_sha256':sha(c),'csv_bytes':c.stat().st_size})
  rt=list(csv.DictReader((R/'corrections/reports/csv_roundtrip_validation.csv').open()))
  assert len(rt)==30 and all(x['different_cells']=='0' and x['roundtrip_pass']=='1' and x['all_keys_exact']=='1' for x in rt)
  (R/'corrections/runtime/aggregate-output-manifest.json').write_text(json.dumps({'status':'passed','reports':reports,'csv_roundtrip_cases':30},indent=2)+'\n')
  oldpub=json.loads((O/'corrections/runtime/publication-manifest.json').read_text());entries=[]
  for e in oldpub['entries']:
   n=dict(e);family=e['aggregate_family'];dta=R/'corrections/reports'/f'{family}.dta';csvp=dta.with_suffix('.csv')
   n['original_script_sha256']=n.get('script_sha256')
   if (R/n['script']).exists():n['script_sha256']=sha(R/n['script'])
   n.update(dta_path=str(dta.relative_to(R)),csv_path=str(csvp.relative_to(R)),dta_sha256=sha(dta),csv_sha256=sha(csvp),actual_schema=schema(dta),execution_status='passed',roundtrip_status='exact',source_company_boundary='data/analysis/G0_analysis_ready.dta',original_evidence_snapshot_preserved=True)
   entries.append(n)
  (R/'corrections/runtime/publication-manifest.json').write_text(json.dumps({'version':2,'status':'passed_stage_outputs_final_parent_receipt_required','entries':entries,'execution_receipt':'runtime/latest.json','execution_receipt_sha256':None,'G0_complete':False,'source_admission':False},indent=2)+'\n')
  return {'schema_status':'passed','reports':30,'csv_roundtrips':30}
 return {'schema_status':'not_required_for_this_stage'}

def finalize_publication():
 """Bind final exited run only after its durable receipt exists; no circular receipt hash."""
 receipt=R/'runtime/latest.json';r=json.loads(receipt.read_text())
 assert r['status']=='passed' and r['owned_process_exited'] and r['exit_code']==0 and r['success_marker_present'] and r['schema_comparison_status']=='passed'
 p=R/'corrections/runtime/publication-manifest.json';j=json.loads(p.read_text())
 assert len(j['entries'])==24 and all(x['roundtrip_status']=='exact' for x in j['entries'])
 for x in j['entries']:
  assert sha(R/x['csv_path'])==x['csv_sha256'] and sha(R/x['dta_path'])==x['dta_sha256']
 j.update(status='passed',execution_receipt='runtime/latest.json',execution_receipt_sha256=sha(receipt))
 p.write_text(json.dumps(j,indent=2)+'\n')
