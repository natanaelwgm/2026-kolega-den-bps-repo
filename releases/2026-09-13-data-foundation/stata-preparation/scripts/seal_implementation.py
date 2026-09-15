from pathlib import Path
import json,hashlib,ast,datetime,re
R=Path(__file__).resolve().parents[1]
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
 return h.hexdigest()
# Exclude module runtime/generated files and all company inputs from code inventory.
files=[]
for root in ['code','rows','dag/edges','scripts','registry']:
 for p in (R/root).rglob('*'):
  if p.is_file() and p.suffix in ['.do','.ado','.py','.json','.csv'] and '__pycache__' not in p.parts:files.append(p)
files += [R/'run_guarded.py',R/'run_preparation.command',R/'rd2017/lib/wave_rd17_classes.do']
for p in files:
 if p.suffix=='.py':ast.parse(p.read_text())
 # Active Stata presentation commands are prohibited. Numeric histogram-bin builders remain valid.
 if p.suffix=='.do':assert not re.search(r'^\s*(graph |twoway |histogram |scatter |line )',p.read_text(),re.M),p
freeze=json.loads((R/'plan-freeze.json').read_text())
for e in freeze['files']:assert sha(e['path'])==e['sha256'],e['path']
inputs=json.loads((R/'registry/inputs.json').read_text())['inputs']
for e in inputs:assert sha(e['path'])==e['sha256'],e['path']
manifest={'status':'PINNED_FOR_STATIC_REVIEW_NOT_EXECUTED','created_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'plan_freeze_sha256':sha(R/'plan-freeze.json'),'code_files':[{'path':str(p.relative_to(R)),'sha256':sha(p),'bytes':p.stat().st_size} for p in sorted(set(files))],'input_files':inputs,'stata_path':'/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','stata_sha256':sha('/Applications/Stata/StataSE.app/Contents/MacOS/stata-se'),'counts':{'mapped_leaf_methods':2796,'working_leaf_methods':108,'upstream_correction_processes':370,'post_boundary_correction_processes':4,'publication_exhibit_processes':24,'ready_annual_waves':12,'consolidated_company_masters':1,'master_rows':33049,'master_columns':4593,'legacy_corrected_projection_columns':4591,'comparison_reports':30},'resource':{'target_bytes':8*1024**3,'hard_bytes':10*1024**3,'minimum_free_bytes':12*1024**3},'company_boundary':'data/analysis/G0_analysis_ready.dta','source_admission':False,'G0_complete':False}
p=R/'implementation-manifest.json';p.write_text(json.dumps(manifest,indent=2)+'\n');print(json.dumps({'manifest':str(p),'sha256':sha(p),'code_files':len(files),'pinned_inputs':len(inputs)}))
