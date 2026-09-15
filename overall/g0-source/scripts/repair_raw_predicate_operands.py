"""Bind omitted original-predicate raw operands; numerical method bodies unchanged."""
from pathlib import Path
import json,hashlib,shutil,importlib.util,sys,datetime,re
R=Path(__file__).resolve().parents[1];L=R.parent/'G0-logging';sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest();arc=R/'runtime/implementation-history/59b5371c-pre-raw-predicate-binding';arc.mkdir(parents=True,exist_ok=True)
for rel in ['implementation-manifest.json','implementation-review/static-review.json','registry/leaf-operands.json','registry/instrumentation-manifest.json','scripts/build_foundation.py']:
 q=arc/rel;q.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(R/rel,q)
sp=importlib.util.spec_from_file_location('instrument',L/'instrument_stata.py');mod=importlib.util.module_from_spec(sp);sys.modules[sp.name]=mod;sp.loader.exec_module(mod)
ops=json.loads((R/'registry/leaf-operands.json').read_text());im=json.loads((R/'registry/instrumentation-manifest.json').read_text());cm=json.loads((L/'comments/comment-manifest.json').read_text());docs={e['path']:e for e in cm['entries']};changes=[]
for e in ops['mapped']:
 body=(R/'provenance/logging-originals'/e['method']).read_text();missing=set(re.findall(r'\braw_[A-Za-z0-9_]+\b',body))-set(e['raw_fields'])
 if not missing:continue
 assert e['year']==2022 and e['variable'] in ['waste_solid_flag','waste_liquid_flag','waste_hazardous_flag'] and missing=={'raw_inspli22'}
 rel=e['launcher'];p=R/rel;rec=next(x for x in im['files'] if x['path']==rel);before=(R/rec['original_path']).read_text();after=before.replace(' using "data/intermediate/raw_wave_2022.dta"',' raw_inspli22 using "data/intermediate/raw_wave_2022.dta"',1);assert after!=before
 amended=R/'provenance/raw-predicate-binding-amendment'/rel;amended.parent.mkdir(parents=True,exist_ok=True);amended.write_text(after)
 out,blocks=mod.instrument(after,rel);doc=docs[rel];notes={}
 for n in doc['block_notes']:notes.setdefault(n['line'],[]).append(n['comment'])
 lines=[x+' // WFDOC-INJECTED\n' for x in doc['header_comments']];idx=0
 for s in out.splitlines(keepends=True):
  if not s.rstrip().endswith(mod.TAG):
   idx+=1;lines.extend(x+' // WFDOC-INJECTED\n' for x in notes.get(idx,[]))
  lines.append(s)
 oldcode=arc/rel;oldcode.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,oldcode);p.write_text(''.join(lines));rec.update(original_path=str(amended.relative_to(R)),original_sha256=sha(amended),original_bytes=amended.stat().st_size,instrumented_sha256=sha(p),instrumented_bytes=p.stat().st_size,blocks=blocks)
 e['retained_raw_fields']=e['raw_fields'][:];e['raw_fields']+=sorted(missing);e['additional_predicate_operands']=sorted(missing)
 changes.append({'launcher':rel,'method':e['method'],'old_original_sha256':hashlib.sha256(before.encode()).hexdigest(),'new_original_sha256':sha(amended),'method_sha256_unchanged':sha(R/'provenance/logging-originals'/e['method']),'added_input_fields':sorted(missing),'parent':e['parent']})
assert len(changes)==3
(R/'registry/leaf-operands.json').write_text(json.dumps(ops,indent=2)+'\n');im['raw_predicate_binding_amendment']=changes;(R/'registry/instrumentation-manifest.json').write_text(json.dumps(im,indent=2)+'\n')
p=R/'scripts/build_foundation.py';s=p.read_text();needle="raw=[f for f in keep if f.startswith('raw_')]";assert needle in s;s=s.replace(needle,needle+"; raw_inputs=list(dict.fromkeys(raw+re.findall(r'\\braw_[A-Za-z0-9_]+\\b',body)))",1);s=s.replace("' '.join(raw)+f' using", "' '.join(raw_inputs)+f' using",1);s=s.replace("'raw_fields':raw,'outputs'", "'raw_fields':raw_inputs,'retained_raw_fields':raw,'outputs'",1);p.write_text(s)
receipt={'status':'SOURCE_BINDING_REPAIR_NO_METHOD_FORMULA_CHANGE','created_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'failed_attempt':'runtime/run-20260913T060456Z/F030/receipt.json','changes':changes,'all_mapped_raw_reference_census':2796,'only_missing_bindings':3,'historical_originals_preserved':True}
(R/'registry/raw-predicate-binding-amendment.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'changes':len(changes),'receipt_sha256':sha(R/'registry/raw-predicate-binding-amendment.json')}))
