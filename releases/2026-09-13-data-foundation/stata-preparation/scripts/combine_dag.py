"""Join core and RD physical data registries without changing their numerical edges."""
from pathlib import Path
import json,hashlib
from copy import deepcopy
ROOT=Path(__file__).resolve().parents[1]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 cp=ROOT/'registry/dag.json';rp=ROOT/'rd2017/dag.json'
 core=json.loads(cp.read_text());rd=json.loads(rp.read_text());out=deepcopy(core)
 ns={n['id']:n for n in out['nodes']};es={e['id']:e for e in out['edges']}
 assert rd.get('external_metadata_producers', []) in ([], ['RD17_PREFLIGHT_PY'])
 for n in rd['nodes']:
  if n['id'] in ns:assert n==ns[n['id']],n['id']
  else:ns[n['id']]=deepcopy(n);out['nodes'].append(ns[n['id']])
 for e in rd['edges']:
  assert e['id'] not in es;e=deepcopy(e);out['edges'].append(e);es[e['id']]=e
 master=next(n for n in out['nodes'] if n['role']=='consolidated_ready')
 if 'RD17_PREFLIGHT_PY' not in es:
  pre=next(n for n in out['nodes'] if n.get('producer')=='RD17_PREFLIGHT_PY')
  pre['parents']=[master['id']]
  out['edges'].append({'id':'RD17_PREFLIGHT_PY','path':'rd2017/validate_inputs.py','stage':'metadata',
   'kind':'metadata','inputs':pre['parents'],'outputs':[pre['id']],
   'scope':'Current master hash/schema and producer receipt checks; no company values decoded.'})
 out['composition']={'inputs':[{'path':str(p),'sha256':sha(p)} for p in [cp,rp]],
  'scope':'Core complete dataset graph plus RD2017 numerical/validation states. Numerical child edges unchanged. Includes the declared metadata-only preflight producer.'}
 dest=ROOT/'registry/dag-complete.json';dest.write_text(json.dumps(out,indent=2)+'\n')
 print(f'Combined {len(out["nodes"])} data states and {len(out["edges"])} processes.')
if __name__=='__main__':main()
