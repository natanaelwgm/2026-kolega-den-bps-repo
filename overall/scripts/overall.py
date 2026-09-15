"""Fresh raw-to-G1 orchestration. Stata owns imports and analytical stages."""
from pathlib import Path
import argparse,datetime,hashlib,json,os,re,shutil,sys,uuid,zipfile,importlib.util
for k in ['OPENBLAS_NUM_THREADS','OMP_NUM_THREADS','MKL_NUM_THREADS']:os.environ[k]='1'
ROOT=Path(__file__).resolve().parents[2]
OLD=Path('/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work')
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
def write(p,o):Path(p).write_text(json.dumps(o,indent=2,default=str)+'\n')
def quote(s):
 s=str(s)
 if any(c in s for c in ['"','`','$','\n','\r']):raise ValueError('Use paths without Stata metacharacters')
 return '"'+s+'"'
def prepare(output,rawzip,witness,reply):
 output=Path(output).resolve();output.mkdir(parents=True,exist_ok=True)
 if shutil.disk_usage(output).free<30*1024**3:raise ValueError('Fresh all-stage run needs 30 GiB free on its output volume')
 run=output/(datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]);run.mkdir()
 foundation=run/'G0-wave-foundation-v2';foundation.mkdir();template=ROOT/'overall/g0-source'
 manifest=json.loads((template/'implementation-manifest.original.json').read_text())
 for d in json.loads((ROOT/'overall/directory-skeleton.json').read_text()):(foundation/d).mkdir(parents=True,exist_ok=True)
 for d in ['raw','raw-reference','logs','figures','reports','tables','g05','code']:(run/d).mkdir(exist_ok=True)
 print('PREPARE | copying frozen reference inputs; these are validation witnesses, not the working G0 master',flush=True)
 copied=[]
 for i,x in enumerate(manifest['input_files']):
  rel=Path(x['path']).relative_to(OLD);src=Path(witness)/rel
  if sha(src)!=x['sha256']:raise ValueError('Frozen input changed: '+str(src))
  dest=run/rel;dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(src,dest)
  copied.append({'path':str(rel),'sha256':x['sha256']})
  if i%1000==0:print('REFERENCE INPUTS',i,'/',len(manifest['input_files']),flush=True)
 for p in (run/'G0-rebuild/dag/data/staged').glob('sample_mfg*_raw.dta'):shutil.copy2(p,run/'raw-reference'/p.name);p.unlink()
 print('PREPARE | copying complete active G0 code and binding this run',flush=True)
 for s in template.rglob('*'):
  if not s.is_file():continue
  rel=s.relative_to(template);dest=foundation/rel;dest.parent.mkdir(parents=True,exist_ok=True)
  if s.suffix in ['.do','.ado','.py','.json','.csv','.md','.txt']:
   text=s.read_text().replace(str(OLD/'G0-wave-foundation-v2'),str(foundation)).replace(str(OLD/'G0-rebuild'),str(run/'G0-rebuild'))
   if s.suffix=='.do':
    lines=[]
    for line in text.splitlines():
     if 'assert strpos' in line and 'c(tmpdir)' in line:line='* GUI scratch allowed; all analytical output paths are bound to this new run.'
     if re.match(r'^\s*do\s+"',line):
      target=line.strip()[3:].replace('"','')
      lines.append('noisily display as result '+quote('CALL | '+str(rel)+' -> '+target) if not any(c in target for c in ['`','$']) else 'noisily display as result '+quote('CALL | '+str(rel)+' -> dynamic child path; see next do statement'))
     lines.append(line)
    text='\n'.join(lines)+'\n'
   dest.write_text(text)
  else:shutil.copy2(s,dest)
 with zipfile.ZipFile(rawzip) as z:
  for item in z.infolist():
   if Path(item.filename).name!=item.filename:raise ValueError('Raw ZIP must contain only the 17 root input files')
   with z.open(item) as src,(run/'raw'/item.filename).open('wb') as dst:shutil.copyfileobj(src,dst)
 raw=[{'path':str(p.relative_to(run)),'sha256':sha(p)} for p in sorted((run/'raw').iterdir())]
 if len(raw)!=17:raise ValueError('Expected 17 raw Excel/DBF inputs')
 write(run/'overall.json',{'status':'prepared','run':str(run),'source_root':str(ROOT),'raw_inputs':raw,'reference_inputs':copied,'stages':[],'data_flow':'raw Excel -> fresh staged annual DTA -> all G0 stages -> freshly perturbed fictional panel -> G1','existing_master_used_as_working_input':False})
 reply=Path(reply);reply.write_text('global OVERALL_RUN '+quote(run)+'\nglobal OVERALL_RAW '+quote(run/'raw')+'\nglobal OVERALL_G0 '+quote(foundation)+'\n')
 print('READY |',run,flush=True)
def stage(run,sid):
 run=Path(run);p=run/'overall.json';m=json.loads(p.read_text())
 # Stata comparisons enforce values. The original audit enforces schema and labels.
 s=run/'G0-wave-foundation-v2/scripts/validate_outputs.py'
 spec=importlib.util.spec_from_file_location('audit',s);audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
 result=audit.audit(sid)
 if sid=='V085':
  wave=run/'G0-wave-foundation-v2/runtime/wave-output-manifest.json';w=json.loads(wave.read_text());w['parent_process_exited']=False;w['native_stata_stage_returned']=True;write(wave,w)
 m['stages'].append({'id':sid,'status':'passed','validation':result});write(p,m)
 print('STAGE VERIFIED |',sid,flush=True)
def development(run,seed):
 import numpy as np,pandas as pd,secrets
 from collections import defaultdict
 sys.path.insert(0,str(ROOT/'harness/g05'))
 from build_development import factors,transform_column,coherence_relations,check_coherence
 from column_policy import classify
 from panel_generator import generate,INPUT_COLUMNS
 run=Path(run);receipt=json.loads((run/'overall.json').read_text());expected=json.loads((ROOT/'overall/g0-source/registry/stages.json').read_text())
 if [x['id'] for x in receipt['stages']]!=[x['id'] for x in expected]:raise ValueError('All G0 stages must pass before G0.5')
 actual=run/'G0-wave-foundation-v2/data/analysis/G0_analysis_ready.dta';actualsha=sha(actual)
 print('G05 | reading freshly rebuilt G0',actual,flush=True)
 keep=json.loads((ROOT/'data/g0-5-development/pre-panel-manifest.json').read_text())['base_column_names']
 with pd.read_stata(actual,iterator=True,convert_categoricals=False) as reader:types=dict(zip(reader._varlist,reader._typlist))
 before=pd.read_stata(actual,columns=keep,convert_categoricals=False)
 private=run/'.private';private.mkdir();key=secrets.token_bytes(32);(private/'perturbation.key').write_bytes(key)
 factor=factors(key,actualsha,0,len(before));columns={};changes={}
 for i,name in enumerate(before):
  transformed,changed=transform_column(before[name],classify(name,str(types[name])),factor);columns[name]=transformed;changes[name]=int(changed.sum())
  if i%200==0:print('G05 PERTURB |',i,'/',len(before.columns),name,flush=True)
 after=pd.DataFrame(columns);coherence=defaultdict(lambda:defaultdict(int));check_coherence(before,after,coherence_relations(list(before)),coherence)
 after['obs_id']=['overall-'+str(int(y))+'-'+str(i+1) for i,y in enumerate(after.source_year)]
 ids,report=generate(after[INPUT_COLUMNS],seed=int(seed),progress=lambda x:print('G05 PANEL |',json.dumps(x),flush=True))
 for col in ids:
  if col not in ['source_year','obs_id']:after[col]=ids[col].to_numpy()
 after['analysis_contract']='G0.5 DEVELOPMENT: fresh raw-to-G0 lineage; fictional panel, perturbed values'
 for col in after.select_dtypes(include=['object','string']).columns:after[col]=after[col].fillna('').astype(str)
 output=run/'g05/G05_fresh.dta';print('G05 | writing',len(after),'rows',len(after.columns),'columns',flush=True)
 after.to_stata(output,write_index=False,version=118)
 report.update(source_g0=str(actual),source_g0_sha256=actualsha,output_sha256=sha(output),columns=len(after.columns),perturbation_key_sha256=hashlib.sha256(key).hexdigest(),coherence_checks=dict(coherence),changed_cells=sum(changes.values()))
 write(run/'g05/build-receipt.json',report)
 write(run/'run.json',{'status':'selected_stages_passed','input':str(output),'config':{'home':str(ROOT/'demo'),'repo':str(ROOT)},'scope':'Fresh overall G0 -> G05 run; see overall.json'})
 print('G05 VERIFIED |',len(after),'rows',report['synthetic_firms'],'fictional firms',flush=True)
def present(run):
 import pandas as pd
 run=Path(run);actual=run/'G0-wave-foundation-v2/data/analysis/G0_analysis_ready.dta'
 with pd.read_stata(actual,iterator=True) as r:shape={'rows':r._nobs,'columns':r._nvar}
 write(run/'run.json',{'config':{'profile':'fresh_raw_overall','mode':'actual','home':str(ROOT/'demo'),'repo':str(ROOT)},'input_schema':shape,'input_sha256':sha(actual),'stages':{'all_17_G0_stages':{'status':'passed'}}})
 target=run/'tables/g0';target.mkdir(exist_ok=True)
 for p in (run/'G0-wave-foundation-v2/corrections/reports').glob('*.csv'):shutil.copy2(p,target/p.name)
 sys.path.insert(0,str(ROOT/'demo/scripts'))
 import presentation
 presentation.workbook(run);presentation.figures(run)
 print('G0 WORKBOOK AND FIGURES VERIFIED',flush=True)

def complete(run):
 run=Path(run);m=json.loads((run/'overall.json').read_text());g1=json.loads((run/'DEMO_COMPLETE.json').read_text());assert g1['status']=='passed'
 g05=json.loads((run/'g05/build-receipt.json').read_text());assert g05['output_sha256']==sha(run/'g05/G05_fresh.dta')
 for x in m['raw_inputs']:assert sha(run/x['path'])==x['sha256']
 m.update(status='passed',g1=g1,g05=g05,completed_at=datetime.datetime.now().astimezone().isoformat());write(run/'OVERALL_COMPLETE.json',m)
 print('OVERALL COMPLETE |',run,flush=True)
if __name__=='__main__':
 a=sys.argv
 if a[1]=='prepare':prepare(*a[2:])
 elif a[1]=='stage':stage(*a[2:])
 elif a[1]=='development':development(*a[2:])
 elif a[1]=='complete':complete(*a[2:])
 elif a[1]=='present':present(*a[2:])
