#!/usr/bin/env python3
"""Bind verified Stata aggregate files for existing Python/R graphics; never draw."""
from pathlib import Path
import argparse,hashlib,json
from datetime import datetime,timezone
H=Path(__file__).resolve().parents[1];F=H.parent
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def path(p):
 q=Path(p);q=q if q.is_absolute() else F/q;q=q.resolve();assert q.is_relative_to(F),q;return q
def pin(p):
 q=Path(p);return {'path':str(q),'sha256':sha(q),'bytes':q.stat().st_size}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--master-receipt',required=True);ap.add_argument('--output',default=str(H/'presentation/presentation-inputs.json'));a=ap.parse_args()
 receipt=path(a.master_receipt);r=json.loads(receipt.read_text())
 assert r['status']=='passed' and r['exit_code']==0 and r['owned_process_exited'] and r['success_marker_present'] and r['schema_comparison_status']=='passed'
 assert r['pid']>0 and r['plan_freeze_sha256']==sha(F/'plan-freeze.json')
 outputs={str(path(e['path'])):e for e in r['output_hashes']};assert len(outputs)==len(r['output_hashes'])
 for n,e in outputs.items():assert sha(n)==e['sha256'] and Path(n).stat().st_size==e['bytes']
 master=F/'data/analysis/G0_analysis_ready.dta';assert str(master) in outputs
 ag=F/'corrections/runtime/aggregate-output-manifest.json';j=json.loads(ag.read_text());assert len(j['reports'])==30
 declared=json.loads((F/'plans/presentation-adaptation-proposal.json').read_text())['aggregate_tables'];expected={e['table_id']:e for e in declared}
 tables={}
 for e in j['reports']:
  dta=path(e['path']);csv=dta.with_suffix('.csv');name=dta.stem;assert name in expected
  assert sha(dta)==e['sha256'] and sha(csv)==e['csv_sha256']
  assert str(dta) in outputs and str(csv) in outputs
  assert e['schema']==expected[name]['schema'],name
  tables[name]={'dta':pin(dta),'csv':pin(csv),'schema':e['schema']}
 assert set(tables)==set(expected)
 pub=F/'corrections/runtime/publication-manifest.json';pj=json.loads(pub.read_text());assert len(pj['entries'])==24 and not pj['G0_complete'] and not pj['source_admission']
 assert sha(path(pj['execution_receipt']))==pj['execution_receipt_sha256']==sha(receipt)
 exhibits={}
 for e in pj['entries']:
  csv=path(e['csv_path']);assert e['execution_status']=='passed' and e['roundtrip_status']=='exact' and not e['missing_expected_fields']
  assert sha(csv)==e['csv_sha256'] and sha(csv.with_suffix('.dta'))==e['dta_sha256'];exhibits[e['exhibit_id']]=csv.stem
 # Optional ready modules must supply their own exited receipts; no old receipt fallback.
 modules={};pending=[]
 for name,root in [('rd2017',H),('display-x04',F/'display-x04'),('display-atlas',F/'display-atlas'),('current-evidence',F/'current-evidence')]:
  rp=root/'runtime/latest.json'
  if not rp.is_file():pending.append(name);continue
  mr=json.loads(rp.read_text());assert mr['status']=='passed' and mr['exit_code']==0 and mr['owned_process_exited'] and mr['success_marker_present'],name
  for e in mr['output_hashes']:
   q=path(e['path']);assert sha(q)==e['sha256']
  if name=='rd2017':
   mp=root/'runtime/output-manifest.json';m=json.loads(mp.read_text());assert m['status']=='passed' and sha(rp)==m['execution_receipt_sha256']
   assert m['master']['sha256']==sha(master) and m['master_receipt']['sha256']==sha(receipt)
   modules[name]={'receipt':pin(rp),'manifest':pin(mp),'tables':{Path(t['stem']).name:{'csv':pin(t['csv_path']),'dta':pin(t['dta_path'])} for t in m['tables'] if t['stem'].startswith('outputs/') and t['stem']!='outputs/candidate_2017'}}
  else:
   # Same-generation numeric parent is required before a display module is usable.
   parents=mr.get('current_inputs',[])
   wanted='variable_year_acceptance' if name=='display-x04' else 'core_descriptive_statistics' if name=='display-atlas' else 'completion_gate'
   parent=tables[wanted]['dta']
   assert any(path(e['path'])==Path(parent['path']) and e['sha256']==parent['sha256'] for e in parents),name
   modules[name]={'receipt':pin(rp),'numeric_parent':parent,'output_hashes':mr['output_hashes']}
 out={'status':'CORE_INPUTS_CERTIFIED_MODULES_PENDING' if pending else 'ALL_DECLARED_PRESENTATION_INPUTS_CERTIFIED','created_utc':datetime.now(timezone.utc).isoformat(),'generation_root':str(F),'master_receipt':pin(receipt),'master':pin(master),'aggregate_manifest':pin(ag),'publication_manifest':pin(pub),'tables':tables,'exhibits':exhibits,'modules':modules,'pending_modules':pending,'no_graphics_or_pdf_rendered':True,'existing_pdfs':'Historical reviewed releases; not redrawn from this generation','source_admission':False,'G0_complete':False}
 target=Path(a.output).resolve();assert target.is_relative_to(H/'presentation');target.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({'status':out['status'],'tables':30,'pending_modules':pending,'path':str(target),'sha256':sha(target)}))
if __name__=='__main__':main()
