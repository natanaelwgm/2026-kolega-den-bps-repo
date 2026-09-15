"""Metadata-only audit of the physical data dependency registry; never loads company values."""
from pathlib import Path
import argparse,datetime,json,re,hashlib
YEARS={2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022}
NONCOMPANY={'reference','metadata','code','fixture'}
class BoundaryError(ValueError): pass

def check(dag,root,require_published=False):
 errors=[];items=dag.get('nodes',[]);es=dag.get('edges',[])
 nodes={n['id']:n for n in items};edges={e['id']:e for e in es}
 if len(nodes)!=len(items):errors.append('Duplicate node ID')
 if len(edges)!=len(es):errors.append('Duplicate edge ID')
 producers={}
 for e in es:
  for nid in e.get('inputs',[])+e.get('outputs',[]):
   if nid not in nodes:errors.append(f"{e['id']}: unknown node {nid}")
  for nid in e.get('outputs',[]):
   if nid in producers:errors.append(f'{nid}: multiple producers')
   producers[nid]=e['id']
 for nid,n in nodes.items():
  for p in n.get('parents',[]):
   if p not in nodes:errors.append(f'{nid}: unknown parent {p}')
  prod=n.get('producer')
  if prod:
   if prod not in edges:errors.append(f'{nid}: unknown producer {prod}')
   else:
    if nid not in edges[prod].get('outputs',[]):errors.append(f'{nid}: producer does not list output')
    if set(n.get('parents',[]))!=set(edges[prod].get('inputs',[])):errors.append(f'{nid}: parent set differs from producer inputs')
  elif n.get('parents'):errors.append(f'{nid}: derived node has no producer')
  if nid in producers and prod!=producers[nid]:errors.append(f'{nid}: producer annotation mismatch')
 visited=set();visiting=set()
 def cycle(nid):
  if nid in visiting:raise BoundaryError(f'Cycle at {nid}')
  if nid in visited:return
  visiting.add(nid)
  for p in nodes[nid].get('parents',[]):
   if p in nodes:cycle(p)
  visiting.remove(nid);visited.add(nid)
 try:
  for nid in nodes:cycle(nid)
 except BoundaryError as e:errors.append(str(e))
 waves=[n for n in items if n.get('role')=='wave_ready'];waveyears=[]
 for n in waves:
  if not n.get('producer') or not n.get('parents'):
   errors.append(f"{n['id']}: wave has no construction producer or parents")
  elif n['producer'] in edges and edges[n['producer']].get('stage')!='upstream':
   errors.append(f"{n['id']}: wave producer must be upstream")
  p=Path(n['path']);m=re.fullmatch(r'wave_(\d{4})\.dta',p.name)
  if not m:errors.append(f"{n['id']}: invalid public wave filename")
  else:waveyears.append(int(m.group(1)))
  if require_published:
   if not p.is_absolute():p=root/p
   if not p.is_file():errors.append(f"{n['id']}: public wave file is absent")
   elif p.stat().st_size==0:errors.append(f"{n['id']}: public wave file is empty")
 if len(waves)!=12 or set(waveyears)!=YEARS:errors.append('Expected exactly 12 public annual waves for 2010–2015 and 2017–2022')
 masters=[n for n in items if n.get('role')=='consolidated_ready']
 if len(masters)!=1:errors.append('Expected exactly one final consolidated master')
 else:
  master=masters[0]
  if not master.get('producer') or not master.get('parents'):
   errors.append('Consolidated master has no construction producer or parents')
  elif master['producer'] in edges and edges[master['producer']].get('stage')!='upstream':
   errors.append('Master publication producer must be upstream')
  if Path(master['path']).name!='G0_analysis_ready.dta':
   errors.append('Consolidated master filename is not G0_analysis_ready.dta')
  def find_wave_ancestors(nid):
   if nodes[nid].get('role')=='wave_ready':return {nid}
   if nodes[nid].get('role') in NONCOMPANY:return set()
   if not nodes[nid].get('parents'):
    raise BoundaryError(f'Master has a company input outside the annual waves: {nid}')
   found=set()
   for p in nodes[nid].get('parents',[]):
    if p in nodes:found|=find_wave_ancestors(p)
   return found
  if not errors:
   try:
    if find_wave_ancestors(master['id'])!={n['id'] for n in waves}:
     errors.append('Consolidated master does not descend from all 12 declared waves')
   except BoundaryError as exc:errors.append(str(exc))
  if require_published:
   p=Path(master['path']);p=p if p.is_absolute() else root/p
   if not p.is_file() or p.stat().st_size==0:errors.append('Published consolidated master is absent or empty')
 if errors:raise BoundaryError('\n'.join(errors))
 # No historical comparator may supply any construction or analytical result.
 memo={}
 def comparison_parents(nid):
  if nid in memo:return memo[nid]
  n=nodes[nid]
  # A metadata receipt may hash historical comparator bytes. Its numbers are
  # not company observations; source-code review must verify this declared role.
  if n.get('role') in NONCOMPANY:return set()
  found={nid} if n.get('role','').startswith('validation_only') else set()
  for p in n.get('parents',[]):found|=comparison_parents(p)
  memo[nid]=found;return found
 for e in es:
  if e.get('stage') in ('validation','comparison') or e.get('kind') in NONCOMPANY|{'validation','comparison'}:continue
  for nid in e.get('inputs',[]):
   if comparison_parents(nid):errors.append(f"{e['id']}: comparator feeds construction via {nid}")
 # Analyses stop at the single consolidated master, never at individual waves.
 def boundary(nid,trail):
  n=nodes[nid];role=n.get('role')
  if role=='consolidated_ready':return {nid}
  if role in NONCOMPANY:return set()
  if role=='validation_only':raise BoundaryError('Comparator in numerical path: '+' → '.join(trail+[nid]))
  prod=n.get('producer')
  if not prod or edges[prod].get('stage')!='downstream':
   raise BoundaryError('Company input bypasses consolidated master: '+' → '.join(trail+[nid]))
  if not n.get('parents'):raise BoundaryError(f'{nid}: company result has no parents')
  reached=set()
  for p in n['parents']:reached|=boundary(p,trail+[nid])
  if not reached:raise BoundaryError(f'{nid}: company result has no consolidated-master ancestry')
  return reached
 checked=[]
 for e in es:
  if e.get('stage')!='downstream' or e.get('kind') in NONCOMPANY|{'validation','comparison'}:continue
  reached=set()
  try:
   for nid in e.get('inputs',[]):reached|=boundary(nid,[e['id']])
   if not reached:raise BoundaryError(f"{e['id']}: company numerical edge has no consolidated-master ancestor")
   checked.append({'edge':e['id'],'masters':sorted(reached)})
  except BoundaryError as exc:errors.append(str(exc))
 if not checked:errors.append('No downstream company computation registered')
 if errors:raise BoundaryError('\n'.join(errors))
 return {'status':'PASS','public_wave_count':len(waves),'consolidated_master_count':len(masters),'nodes':len(nodes),'edges':len(edges),
   'downstream_company_edges_checked':len(checked),'downstream':checked,
   'public_files_required':require_published,
   'limit':'Validates the declared physical dependency graph. Independent source-code read audit must prove registry completeness; this check alone does not establish values or source meanings.'}

def main():
 ap=argparse.ArgumentParser();ap.add_argument('registry',type=Path);ap.add_argument('--root',type=Path)
 ap.add_argument('--require-published',action='store_true');ap.add_argument('--output',type=Path);args=ap.parse_args()
 root=args.root or Path(__file__).resolve().parents[1]
 try:result=check(json.loads(args.registry.read_text()),root,args.require_published)
 except BoundaryError as e:result={'status':'FAIL','errors':str(e).splitlines()}
 result.update(timestamp=datetime.datetime.now(datetime.timezone.utc).isoformat(),registry_sha256=hashlib.sha256(args.registry.read_bytes()).hexdigest())
 if args.output:
  args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(result,indent=2)+'\n')
 print(json.dumps({k:v for k,v in result.items() if k!='downstream'},indent=2))
 raise SystemExit(0 if result['status']=='PASS' else 1)
if __name__=='__main__':main()
