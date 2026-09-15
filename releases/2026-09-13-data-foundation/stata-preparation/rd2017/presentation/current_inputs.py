"""Configuration adapter for source gates; aggregate-only, no empirical arithmetic."""
from pathlib import Path
import hashlib,json
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
class CurrentInputs:
 def __init__(self,binding):
  self.binding=Path(binding);self.data=json.loads(self.binding.read_text())
  assert self.data['status'] in ['CORE_INPUTS_CERTIFIED_MODULES_PENDING','ALL_DECLARED_PRESENTATION_INPUTS_CERTIFIED']
  for key in ['master_receipt','master','aggregate_manifest','publication_manifest']:
   e=self.data[key];assert sha(e['path'])==e['sha256']
  receipt=json.loads(Path(self.data['master_receipt']['path']).read_text());assert receipt['status']=='passed' and receipt['owned_process_exited'] and receipt['exit_code']==0
 def table(self,name):
  t=self.data['tables'][name]
  for kind in ['csv','dta']:assert sha(t[kind]['path'])==t[kind]['sha256']
  return {'csv':Path(t['csv']['path']),'dta':Path(t['dta']['path']),'schema':t['schema']}
 def exhibit(self,exhibit_id):return self.table(self.data['exhibits'][exhibit_id])
 def module(self,name):
  assert name not in self.data['pending_modules'],f'{name}: current generation module receipt is not available'
  m=self.data['modules'][name];assert sha(m['receipt']['path'])==m['receipt']['sha256']
  for t in m.get('tables',{}).values():
   for e in t.values():assert sha(e['path'])==e['sha256']
  for e in m.get('output_hashes',[]):assert sha(e['path'])==e['sha256']
  return m
