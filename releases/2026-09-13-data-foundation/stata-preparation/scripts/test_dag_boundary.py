from copy import deepcopy
from pathlib import Path
import unittest
from check_dag_boundary import check,BoundaryError,YEARS

def fixture():
 nodes=[{'id':'raw','path':'raw.dta','role':'company_raw','producer':None,'parents':[]}]
 edges=[]
 for y in sorted(YEARS):
  nodes.append({'id':f'w{y}','path':f'data/waves/wave_{y}.dta','role':'wave_ready','producer':f'prepare{y}','parents':['raw']})
  edges.append({'id':f'prepare{y}','path':f'p{y}.do','stage':'upstream','inputs':['raw'],'outputs':[f'w{y}'],'kind':'company'})
 nodes.append({'id':'master','path':'data/analysis/G0_analysis_ready.dta','role':'consolidated_ready','producer':'append_master','parents':[f'w{y}' for y in sorted(YEARS)]})
 edges.append({'id':'append_master','path':'append_master.do','stage':'upstream','inputs':[f'w{y}' for y in sorted(YEARS)],'outputs':['master'],'kind':'company'})
 nodes.append({'id':'table','path':'table.csv','role':'aggregate','producer':'summarize','parents':['master']})
 edges.append({'id':'summarize','path':'summarize.do','stage':'downstream','kind':'company','inputs':['master'],'outputs':['table']})
 return {'nodes':nodes,'edges':edges}
class BoundaryTests(unittest.TestCase):
 def test_good(self):self.assertEqual(check(fixture(),Path('.'))['status'],'PASS')
 def test_direct_raw_bypass(self):
  d=fixture();d['nodes'][-1]['parents']=['raw'];d['edges'][-1]['inputs']=['raw']
  with self.assertRaisesRegex(BoundaryError,'bypasses'):check(d,Path('.'))
 def test_hidden_comparator_upstream(self):
  d=fixture();d['nodes'][0]['role']='validation_only'
  with self.assertRaisesRegex(BoundaryError,'comparator feeds'):check(d,Path('.'))
 def test_mismatched_edge_input(self):
  d=fixture();d['edges'][-1]['inputs']=['raw']
  with self.assertRaisesRegex(BoundaryError,'parent set differs'):check(d,Path('.'))
 def test_cycle(self):
  d=fixture();d['nodes'][-1]['parents']=['table'];d['edges'][-1]['inputs']=['table']
  with self.assertRaisesRegex(BoundaryError,'Cycle'):check(d,Path('.'))
 def test_missing_wave(self):
  d=fixture();d['nodes'][1]['role']='company_intermediate'
  with self.assertRaisesRegex(BoundaryError,'exactly 12'):check(d,Path('.'))
 def test_reference_allowed(self):
  d=fixture();d['nodes'].append({'id':'reference','path':'factor.csv','role':'reference','producer':None,'parents':[]})
  d['nodes'][-2]['parents'].append('reference');d['edges'][-1]['inputs'].append('reference')
  self.assertEqual(check(d,Path('.'))['status'],'PASS')
 def test_direct_wave_bypass(self):
  d=fixture();d['nodes'][-1]['parents']=['w2017'];d['edges'][-1]['inputs']=['w2017']
  with self.assertRaisesRegex(BoundaryError,'bypasses consolidated master'):check(d,Path('.'))
 def test_orphan_wave(self):
  d=fixture();d['edges']=[e for e in d['edges'] if not e['id'].startswith('prepare')]
  for n in d['nodes']:
   if n['role']=='wave_ready':n['producer']=None;n['parents']=[]
  with self.assertRaisesRegex(BoundaryError,'wave has no construction'):check(d,Path('.'))
 def test_master_missing_one_wave(self):
  d=fixture();d['nodes'][-2]['parents']=d['nodes'][-2]['parents'][:-1];d['edges'][-2]['inputs']=d['edges'][-2]['inputs'][:-1]
  with self.assertRaisesRegex(BoundaryError,'all 12'):check(d,Path('.'))
 def test_master_raw_side_input(self):
  d=fixture();d['nodes'][-2]['parents'].append('raw');d['edges'][-2]['inputs'].append('raw')
  with self.assertRaisesRegex(BoundaryError,'outside the annual waves'):check(d,Path('.'))
 def test_unknown_producer(self):
  d=fixture();d['nodes'][1]['producer']='absent_producer'
  with self.assertRaisesRegex(BoundaryError,'unknown producer'):check(d,Path('.'))
 def test_metadata_hashes_comparator_without_numeric_feed(self):
  d=fixture();d['nodes'] += [
   {'id':'old','path':'old.dta','role':'validation_only','producer':None,'parents':[]},
   {'id':'pin','path':'hash-receipt.json','role':'metadata','producer':'hash_old','parents':['old']}]
  d['edges'].append({'id':'hash_old','path':'hash_old.py','stage':'metadata','kind':'metadata','inputs':['old'],'outputs':['pin']})
  self.assertEqual(check(d,Path('.'))['status'],'PASS')
 def test_missing_published_file(self):
  with self.assertRaisesRegex(BoundaryError,'public wave file is absent'):check(fixture(),Path('/nonexistent-fixture-path'),True)
if __name__=='__main__':unittest.main()
