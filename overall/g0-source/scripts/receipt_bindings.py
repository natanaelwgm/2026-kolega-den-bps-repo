"""Bind actual declared generated parents/outputs to each owned phase receipt."""
from pathlib import Path
import re,json
from validate_outputs import sha
R=Path(__file__).resolve().parents[1]
def closure(path,seen=None):
 seen=set() if seen is None else seen
 if path in seen:return seen
 seen.add(path);p=R/path
 if not p.exists():return seen
 for q in re.findall(r'^\s*(?:do|include) "([^\"]+\.do)"',p.read_text(),re.M):
  if q.startswith(str(R)+'/'):q=q[len(str(R))+1:]
  if '`' not in q and '$' not in q and (R/q).exists():closure(q,seen)
 return seen

def paths(stage):
 d=json.loads((R/'registry/dag.json').read_text());nn={x['id']:x for x in d['nodes']};cc=closure(stage['path']);ee=[e for e in d['edges'] if e['path'] in cc and e['stage']!='validation'];outs=set(nn[n]['path'] for e in ee for n in e['outputs']);ins=set(nn[n]['path'] for e in ee for n in e['inputs'])-outs
 return ins,outs

def outputs(stage):
 _,paths_=paths(stage);ret=[]
 for rel in sorted(paths_):
  p=R/rel
  assert p.is_file(),f'Declared stage output missing: {stage["id"]}: {rel}'
  ret.append({'path':rel,'bytes':p.stat().st_size,'sha256':sha(p)})
 return ret

def validate_parents(stage):
 ins,_=paths(stage);existing={}
 d=json.loads((R/'registry/dag.json').read_text())
 generated={x['path'] for x in d['nodes'] if x.get('producer')}
 stages=json.loads((R/'registry/stages.json').read_text())
 for s in stages:
  if s['id']==stage['id']:break
  p=R/f'runtime/{s["id"]}-latest.json'
  if p.exists():
   r=json.loads(p.read_text());assert r['status']=='passed' and r['owned_process_exited'] and r['exit_code']==0 and r['success_marker_present'],str(p)
   for x in r.get('output_hashes',[]):existing[x['path']]=x
 bindings=[]
 for rel in sorted(ins):
  if rel in generated:assert rel in existing,f'Declared generated parent lacks prior passed receipt: {stage["id"]}: {rel}'
  if rel in existing:
   x=existing[rel];assert (R/rel).is_file() and (R/rel).stat().st_size==x['bytes'] and sha(R/rel)==x['sha256'],f'Current declared parent changed: {rel}';bindings.append(x)
 return bindings
