from pathlib import Path
import json,hashlib,shutil,importlib.util,sys,datetime
R=Path(__file__).resolve().parents[1];L=R.parent/'G0-logging';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();arc=R/'runtime/implementation-history/2f8a74e8-pre-working-parent-drop';arc.mkdir(parents=True,exist_ok=True)
for rel in ['implementation-manifest.json','implementation-review/static-review.json','registry/instrumentation-manifest.json','scripts/close_static_findings.py']:
 q=arc/rel;q.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(R/rel,q)
sp=importlib.util.spec_from_file_location('instrument',L/'instrument_stata.py');mod=importlib.util.module_from_spec(sp);sys.modules[sp.name]=mod;sp.loader.exec_module(mod)
im=json.loads((R/'registry/instrumentation-manifest.json').read_text());cm=json.loads((L/'comments/comment-manifest.json').read_text());docs={e['path']:e for e in cm['entries']};changes=[]
for year in [2017,2018]:
 rel=f'code/leaves/working/innovation_flag_{year}.do';p=R/rel;rec=next(x for x in im['files'] if x['path']==rel);before=(R/rec['original_path']).read_text();lines=[];source_to_new={}
 for n,line in enumerate(before.splitlines(keepends=True),1):
  source_to_new[n]=len(lines)+1
  if line.startswith('drop innovation_'):
   lines.extend('capture drop '+v+'\n' for v in line.strip().split()[1:])
  else:lines.append(line)
 after=''.join(lines);amended=R/'provenance/working-parent-drop-amendment'/rel;amended.parent.mkdir(parents=True,exist_ok=True);amended.write_text(after)
 out,blocks=mod.instrument(after,rel);doc=docs[rel];notes={}
 for n in doc['block_notes']:notes.setdefault(source_to_new[n['line']],[]).append(n['comment'])
 res=[x+' // WFDOC-INJECTED\n' for x in doc['header_comments']];idx=0
 for s in out.splitlines(keepends=True):
  if not s.rstrip().endswith(mod.TAG):
   idx+=1;res.extend(x+' // WFDOC-INJECTED\n' for x in notes.get(idx,[]))
  res.append(s)
 oldcode=arc/rel;oldcode.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,oldcode);p.write_text(''.join(res));rec.update(original_path=str(amended.relative_to(R)),original_sha256=sha(amended),original_bytes=amended.stat().st_size,instrumented_sha256=sha(p),instrumented_bytes=p.stat().st_size,blocks=blocks)
 method=f'dag/edges/word_rows/G0/analysis_tunnel/innovation_flag_{year}.do'
 changes.append({'launcher':rel,'old_original_sha256':hashlib.sha256(before.encode()).hexdigest(),'new_original_sha256':sha(amended),'method_unchanged_sha256':sha(R/'provenance/logging-originals'/method),'change':'Drop each pre-existing component separately with capture; absent fields are valid before the exact required working-parent merge.'})
im['working_parent_drop_amendment']=changes;im['block_count']=sum(len(e['blocks']) for e in im['files']);(R/'registry/instrumentation-manifest.json').write_text(json.dumps(im,indent=2)+'\n')
p=R/'scripts/close_static_findings.py';s=p.read_text();s=s.replace("[f'drop {v} vs_{v}',", "[f'capture drop {v}', f'capture drop vs_{v}',");p.write_text(s)
receipt={'status':'WRAPPER_PARENT_REPLACEMENT_REPAIR_NO_METHOD_CHANGE','failed_attempt':'runtime/run-20260913T061746Z/F060/receipt.json','changes':changes,'upstream_stages_reused':['T000','F010','F030','F040','F050'],'full_F060_rerun_required':True}
(R/'registry/working-parent-drop-amendment.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'changes':len(changes),'receipt_sha256':sha(R/'registry/working-parent-drop-amendment.json')}))
