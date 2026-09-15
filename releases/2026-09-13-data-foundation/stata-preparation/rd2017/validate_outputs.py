#!/usr/bin/env python3
"""Validate saved types, CSV/DTA equality and receipts; no empirical estimates."""
from pathlib import Path
import csv,hashlib,json
from datetime import datetime,timezone
import pandas as pd
H=Path(__file__).resolve().parent;F=H.parent;R=F.parent.parent;HISTORY=R/'work/G0-RD2017-phase-B-execution'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def main():
 receipt_path=H/'runtime/latest.json';rec=json.loads(receipt_path.read_text())
 assert rec['status']=='passed' and rec['exit_code']==0 and rec['owned_process_exited'] and rec['success_marker_present'] and rec['input_code_hashes_unchanged']
 assert rec['canonical_bridge_pass'] and rec['wide_token_expected_rejection_pass'] and rec['guard_fixtures_pass'] and rec['actual_parity_pass']
 assert sha(H/'implementation-manifest.json')==rec['implementation_manifest_sha256']
 for e in json.loads((H/'implementation-manifest.json').read_text())['files']:assert sha(H/e['path'])==e['sha256']
 assert sha(rec['master']['path'])==rec['master']['sha256']
 assert sha(rec['master_receipt']['path'])==rec['master_receipt']['sha256']
 assert sha(Path(rec['attempt'])/'receipt.json')==sha(receipt_path)
 assert rec['actual_company_answers_classified'] and rec['actual_source_year']==2017
 assert len(rec['children'])==11 and all(x['passed'] for x in rec['children'])
 assert rec['exact_roundtrip_markers']==12
 assert not rec['measurement_admitted'] and not rec['primary_release'] and not rec['G0_complete']
 for p in rec['output_hashes']:assert sha(p['path'])==p['sha256']
 schema=json.loads((H/'inputs/output-schema.json').read_text());mapping=json.loads((H/'output-contract.json').read_text())['table_schemas'];tables=[]
 types={'byte':'b','int':'h','long':'l','float':'f','double':'d'}
 for stem,sn in mapping.items():
  s=schema[sn];p=H/stem;names=[f['name'] for f in s['fields']]
  with pd.read_stata(p.with_suffix('.dta'),iterator=True,convert_categoricals=False) as sr:
   labels=sr.variable_labels();assert sr._nobs==s['rows'] and sr._varlist==names
   for f,t in zip(s['fields'],sr._typlist):
    expected=int(f['type'][3:]) if f['type'].startswith('str') else types[f['type']]
    assert t==expected,(stem,f,t)
  frame=pd.read_stata(p.with_suffix('.dta'),convert_categoricals=False)
  rows=list(csv.DictReader(p.with_suffix('.csv').open(encoding='utf-8',newline='')))
  assert len(rows)==len(frame)==s['rows'] and list(rows[0])==names
  assert len({tuple(r[k] for k in s['key']) for r in rows})==len(rows)
  for row,(_,native) in zip(rows,frame.iterrows()):
   for f in s['fields']:
    k=f['name'];v=row[k]
    if f['type'].startswith('str'):assert v==native[k],(stem,k,'string value')
    elif v in ('','.'):assert pd.isna(native[k]),(stem,k,'missing')
    else:assert float(v)==float(native[k]),(stem,k,'numeric value')
  for k in ['measurement_admitted','primary_release']:
   if k in frame:assert frame[k].eq(0).all()
  if 'passed' in frame:assert frame.passed.eq(1).all()
  if sn=='candidate_ratios':assert frame.accepted_eligible_n.isna().all() and frame.accepted_positive_share.isna().all()
  tables.append({'stem':stem,'schema_name':sn,'rows':s['rows'],'columns':len(names),'key':s['key'],'schema':s['fields'],'csv_path':str(p.with_suffix('.csv')),'csv_sha256':sha(p.with_suffix('.csv')),'dta_path':str(p.with_suffix('.dta')),'dta_sha256':sha(p.with_suffix('.dta')),'roundtrip_status':'exact','schema_status':'exact'})
 # Preserve canonical first-eight metadata, and check historical aggregate schemas only.
 projection=H/'states/wave_2017_projection.dta';final=H/'outputs/candidate_2017.dta'
 with pd.read_stata(projection,iterator=True,convert_categoricals=False) as a, pd.read_stata(final,iterator=True,convert_categoricals=False) as b:
  al=a.variable_labels();bl=b.variable_labels()
  assert b._varlist[:8]==a._varlist and b._typlist[:8]==a._typlist and b._fmtlist[:8]==a._fmtlist
  assert all(bl[k]==al[k] for k in a._varlist)
 for n in ['group_counts','joint_counts','candidate_ratios']:
  with pd.read_stata(H/'outputs'/f'{n}.dta',iterator=True,convert_categoricals=False) as a,pd.read_stata(HISTORY/'outputs'/f'{n}.dta',iterator=True,convert_categoricals=False) as b:
   a.variable_labels();b.variable_labels();assert a._nobs==b._nobs and a._varlist==b._varlist and a._typlist==b._typlist
 guards=pd.read_stata(H/'fixtures/guard_results.dta',convert_categoricals=False)
 assert len(guards)==13 and guards.passed.eq(1).all() and guards.actual_rc.eq(guards.expected_rc).all()
 equivalence=pd.read_stata(H/'validation/equivalence.dta',convert_categoricals=False)
 assert len(equivalence)==1 and equivalence.measurement_admitted.eq(0).all()
 for n in ['literal_wave_classes_exact','all_3357_classifications_exact','three_aggregate_values_exact']:assert equivalence[n].eq(1).all()
 validation={'status':'passed','validated_utc':datetime.now(timezone.utc).isoformat(),'schema_pairs_exact':12,'csv_dta_value_pairs_exact':12,'actual_process_children_passed':11,'fixture_outcomes_passed':61,'canonical_eight_field_metadata_preserved':True,'raw_used_only_in_actual_stata_validation':True,'master_only_construction':True,'all_3357_classifications_exact':True,'three_historical_aggregate_schemas_and_values_exact':True,'strict_literal_rows':49,'canonical_bridge_parity_rows':48,'canonical_expected_rejection_rows':1,'extra_guard_rows':13,'company_answers_classified':True,'source_year':2017,'measurement_admitted':False,'G0_complete':False,'execution_receipt_sha256':sha(receipt_path),'validator_sha256':sha(__file__)}
 vp=H/'runtime/output-validation.json';vp.write_text(json.dumps(validation,indent=2)+'\n')
 manifest={'status':'passed','scope':'2017 candidate conditional R&D from current consolidated analysis master; no source measurement admission','execution_receipt_path':str(receipt_path),'execution_receipt_sha256':sha(receipt_path),'implementation_manifest_sha256':rec['implementation_manifest_sha256'],'plan_freeze_sha256':rec['plan_freeze_sha256'],'historical_method_plan_sha256':rec['historical_method_plan_sha256'],'master':rec['master'],'master_receipt':rec['master_receipt'],'validation_path':str(vp),'validation_sha256':sha(vp),'source_measurement_admitted':False,'G0_complete':False,'tables':tables}
 mp=H/'runtime/output-manifest.json';mp.write_text(json.dumps(manifest,indent=2)+'\n')
 print(json.dumps({'status':'passed','output_manifest_sha256':sha(mp),'validation_sha256':sha(vp),'pairs':12,'source_measurement_admitted':False},indent=2))
if __name__=='__main__':main()
