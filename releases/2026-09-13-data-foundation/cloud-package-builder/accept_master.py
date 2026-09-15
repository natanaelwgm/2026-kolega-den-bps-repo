"""Accept only the completed data preparation; report regeneration is separate."""
from pathlib import Path
import datetime, hashlib, json
H=Path(__file__).resolve().parent;F=H.parent/'G0-wave-foundation-v2'
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as s:
  for b in iter(lambda:s.read(1024*1024),b''):h.update(b)
 return h.hexdigest()
def main():
 implementation=sha(F/'implementation-manifest.json')
 overall=json.loads((F/'runtime/latest.json').read_text())
 stages=overall['stage_order'][:overall['stage_order'].index('V085')+1]
 receipts={};proof=[]
 for stage in stages:
  p=F/'runtime'/f'{stage}-latest.json';d=json.loads(p.read_text())
  assert d['status']=='passed' and d['owned_process_exited'] and d['exit_code']==0
  assert d['success_marker_present'] and d['input_code_hashes_unchanged']
  assert d['stage']==stage and sha(F/d['attempt']/'receipt.json')==sha(p)
  receipts[stage]=d
  proof.append({'stage':stage,'receipt_sha256':sha(p),'attempt':d['attempt'],'pid':d['pid'],'implementation_manifest_sha256':d['implementation_manifest_sha256']})
 for stage in ['F085','F090A','V085']:
  assert receipts[stage]['implementation_manifest_sha256']==implementation
 assert receipts['V085']['validation']['schema_status']=='passed'
 for left,right in [('F085','F090A'),('F090A','V085')]:
  assert datetime.datetime.fromisoformat(receipts[left]['finished_utc']) <= datetime.datetime.fromisoformat(receipts[right]['started_utc'])
 wp=F/'runtime/wave-output-manifest.json';wave=json.loads(wp.read_text())
 assert wave['status']=='passed' and wave['parent_process_exited']
 assert wave['original_projection_columns']==4591 and len(wave['waves'])==12
 master=wave['master'];validation=receipts['V085']['validation']['artifact']
 assert master['path']=='data/analysis/G0_analysis_ready.dta'
 assert validation['path']==master['path'] and validation['sha256']==master['sha256']
 assert validation==master
 assert master['schema']['rows']==33049 and len(master['schema']['fields'])==4593
 outputs=[master]+wave['waves']
 produced={x['path']:x['sha256'] for s in ['F085','F090A'] for x in receipts[s]['output_hashes']}
 assert {x['path']:x['sha256'] for x in wave['waves']}=={x['path']:x['sha256'] for x in receipts['F090A']['current_parent_bindings']}
 for x in outputs:
  assert produced[x['path']]==x['sha256'] and sha(F/x['path'])==x['sha256']
 result={'status':'passed','scope':'DATA_PREPARATION_ONLY','owned_process_exited':True,'exit_code':0,'schema_comparison_status':'passed','created_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'implementation_manifest_sha256':implementation,'stage_order':stages,'stage_receipts':proof,'wave_manifest_sha256':sha(wp),'output_hashes':[{'path':x['path'],'sha256':x['sha256']} for x in outputs],'report_regeneration_status_at_acceptance':overall['status'],'all_reports_complete':False,'all_44_modules_complete':False,'source_admission':False,'G0_complete':False}
 out=H/'master-acceptance.json';assert not out.exists(),'Preserve an existing acceptance receipt.'
 out.write_text(json.dumps(result,indent=2)+'\n');print('DATA_ONLY_PASS',sha(out))
if __name__=='__main__':main()
