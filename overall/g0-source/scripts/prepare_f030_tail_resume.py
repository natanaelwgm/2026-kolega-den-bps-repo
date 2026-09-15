from pathlib import Path
import json,hashlib,importlib.util,sys,datetime
R=Path(__file__).resolve().parents[1];L=R.parent/'G0-logging'
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
ops=json.loads((R/'registry/leaf-operands.json').read_text());done=[e for e in ops['mapped'] if (R/e['artifact']).exists()];remaining=[e for e in ops['mapped'] if not (R/e['artifact']).exists()];assert len(done)==2791 and len(remaining)==5
expected=['waste_solid_flag','waste_liquid_flag','waste_hazardous_flag','fuel_natgas_mmbtu','fuel_biomass_kg'];assert set(e['variable'] for e in remaining)==set(expected) and all(e['year']==2022 for e in remaining)
rel='code/stages/F030_resume_tail.do';body='* Tujuan: Lengkapi lima variabel terakhir dan gabungan tahun 2022 dari proses yang terhenti.\n* Input: Dua belas sumber tahunan; hasil sebelumnya wajib cocok dengan hash pada kontrak resume.\n* Output: Sisa berkas variabel dan mapped_wave_2022.dta; seluruh hasil akan dibandingkan pada V060/V070.\n* Gagal: Hentikan proses dan simpan kode error asli; jangan mengulang atau menerima hasil diam-diam.\n'
body+='do "'+str(R/'code/init.do')+'"\n'
for v in expected:body+=f'do "code/leaves/mapped/{v}_2022.do"\n'
body+='do "code/annual/merge_mapped_2022.do"\ndisplay "WF_F030_TAIL_COMPLETION_PASS"\n'
original=R/'provenance/f030-tail-resume'/rel;original.parent.mkdir(parents=True,exist_ok=True);original.write_text(body)
sp=importlib.util.spec_from_file_location('instrument',L/'instrument_stata.py');mod=importlib.util.module_from_spec(sp);sys.modules[sp.name]=mod;sp.loader.exec_module(mod);out,blocks=mod.instrument(body,rel);(R/rel).write_text(out)
p=R/'registry/instrumentation-manifest.json';im=json.loads(p.read_text());im['files'].append({'path':rel,'original_path':str(original.relative_to(R)),'original_sha256':sha(original),'instrumented_sha256':sha(R/rel),'original_bytes':len(body.encode()),'instrumented_bytes':len(out.encode()),'original_projection_exact':True,'blocks':blocks,'scope':'explicit partial-attempt dispatcher; default full stage unchanged'});im['files_count']=len(im['files']);im['block_count']=sum(len(e['blocks']) for e in im['files']);p.write_text(json.dumps(im,indent=2)+'\n')
files=[R/e['artifact'] for e in done]+sorted((R/'data/intermediate').glob('mapped_wave_*.dta'));assert len(files)==2802
prior=R/'runtime/run-20260913T060456Z/F030/receipt.json';j=json.loads(prior.read_text());assert j['status']=='failed' and j['owned_process_exited']
contract={'status':'AUTHORIZED_BOUNDED_PARTIAL_ATTEMPT_CONTINUATION','prior_failed_receipt':str(prior.relative_to(R)),'prior_failed_receipt_sha256':sha(prior),'full_stage_path':'code/stages/F030_mapped.do','full_stage_sha256':sha(R/'code/stages/F030_mapped.do'),'tail_path':rel,'tail_sha256':sha(R/rel),'completed_leaf_count':2791,'completed_annual_merge_count':11,'remaining_leaves':[e['launcher'] for e in remaining],'remaining_annual_merges':['code/annual/merge_mapped_2022.do'],'retained_files':[{'path':str(p.relative_to(R)),'bytes':p.stat().st_size,'sha256':sha(p)} for p in files],'numeric_comparisons_still_required':['V060','V070'],'default_full_stage_unchanged':True}
p=R/'registry/F030-tail-resume.json';p.write_text(json.dumps(contract,indent=2)+'\n');print({'contract_sha256':sha(p),'retained_files':len(files),'remaining_leaves':5})
