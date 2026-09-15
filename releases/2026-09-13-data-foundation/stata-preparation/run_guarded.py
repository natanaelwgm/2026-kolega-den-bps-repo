"""One owned Stata process at a time; bounded fresh stages, no graphics/portable replay."""
from pathlib import Path
import datetime,fcntl,hashlib,json,os,shutil,signal,subprocess,sys,time,argparse,importlib.util
R=Path(__file__).resolve().parent;O=R.parent/'G0-rebuild';STATA='/Applications/Stata/StataSE.app/Contents/MacOS/stata-se';CAP=10*1024**3;MINFREE=12*1024**3
sys.path.insert(0,str(R/'scripts'));from validate_outputs import sha,audit,schema,finalize_publication
from receipt_bindings import outputs,validate_parents
from live_relay import OwnedLogRelay

def write(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def utc():return datetime.datetime.now(datetime.timezone.utc).isoformat()
def size():return sum(p.stat().st_size for p in R.rglob('*') if p.is_file() and not p.is_symlink())
def checks(m):
 assert sha(R/"plan-freeze.json")==m["plan_freeze_sha256"]
 for x in m['code_files']:assert sha(R/x['path'])==x['sha256'],x['path']
 for x in json.loads((R/'plan-freeze.json').read_text())['files']:assert sha(x['path'])==x['sha256'],x['path']
def cleanup(stage,attempt):
 # Generated files only, after exact baseline comparison has actually passed and PID exited.
 if stage!='V070':return []
 paths=[R/'dag/data/word_data/G0'/f'G0_{x}.dta' for x in ['raw_fields_preserved','economic_fields','energy_fields','energy_emissions','derived_fields','identifier_fields','classification_fields','deflator_fields','main_verified_20260910','main_analysis_tunnel_20260910','main_candidate','analysis_ready']]
 paths += list((R/'data/intermediate').glob('verified_wave_*.dta'))
 rows=[]
 for p in paths:
  assert p.resolve().is_relative_to(R.resolve()) and not p.is_symlink()
  if p.exists():rows.append({'path':str(p.relative_to(R)),'bytes':p.stat().st_size,'sha256':sha(p)});p.unlink()
 write(attempt/'generated-last-consumer-cleanup.json',{'after_passed_stage':stage,'files':rows,'source_files_removed':False});return rows

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--from-stage',default='T000');ap.add_argument('--through');ap.add_argument('--resume-f030-tail',action='store_true');a=ap.parse_args()
 mpath=R/'implementation-manifest.json';m=json.loads(mpath.read_text());msha=sha(mpath)
 review=json.loads((R/'implementation-review/static-review.json').read_text());assert review['status'] in ['passed','PASS'];assert review['implementation_manifest_sha256']==msha
 assert json.loads((R/'plan-freeze.json').read_text())['status']=='READY_FOR_IMPLEMENTATION'
 checks(m)
 tail=None
 if a.resume_f030_tail:
  assert a.from_stage=='F030'
  tail=json.loads((R/'registry/F030-tail-resume.json').read_text())
  assert sha(R/tail['prior_failed_receipt'])==tail['prior_failed_receipt_sha256']
  prior=json.loads((R/tail['prior_failed_receipt']).read_text());assert prior['status']=='failed' and prior['owned_process_exited']
  assert sha(R/tail['full_stage_path'])==tail['full_stage_sha256'] and sha(R/tail['tail_path'])==tail['tail_sha256']
  for x in tail['retained_files']:assert (R/x['path']).stat().st_size==x['bytes'] and sha(R/x['path'])==x['sha256'],x['path']
 assert sha(STATA)==m['stata_sha256']
 lock=(O/'runtime/stata-owned.lock').open('a+');fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB)
 ps=subprocess.check_output(['ps','-axo','pid=,comm='],text=True)
 active=[l for l in ps.splitlines() if Path(l.strip().split(maxsplit=1)[-1]).name.lower() in ['stata-se','stata-mp','stata','statase','statamp']];assert not active,active
 assert shutil.disk_usage(R).free>=MINFREE and size()<CAP
 for x in m['input_files']:assert sha(x['path'])==x['sha256'],x['path']
 stages=json.loads((R/'registry/stages.json').read_text());ids=[x['id'] for x in stages];start=ids.index(a.from_stage);stop=ids.index(a.through)+1 if a.through else len(ids)
 if start:
  for id in ids[:start]:assert json.loads((R/f'runtime/{id}-latest.json').read_text())['status']=='passed',id
 completed=[];runid=datetime.datetime.now(datetime.timezone.utc).strftime('%Y%m%dT%H%M%SZ');run=R/'runtime'/('run-'+runid);run.mkdir()
 overall={'status':'running','attempt':str(run.relative_to(R)),'started_utc':utc(),'implementation_manifest_sha256':msha,'plan_freeze_sha256':sha(R/'plan-freeze.json'),'stage_order':ids,'actually_executed_stages':completed,'schema_comparison_status':'pending','root_at_run':str(R)};write(R/'runtime/latest.json',overall)
 try:
  for st in stages[start:stop]:
   checks(m);assert size()<CAP and shutil.disk_usage(R).free>=MINFREE
   parent_bindings=validate_parents(st)
   actual_stage_path=tail['tail_path'] if tail and st['id']=='F030' else st['path']
   attempt=run/st['id'];attempt.mkdir();entry=R/f'run_WF_{runid}_{st["id"]}.do'
   entry.write_text(f'* Tujuan: Jalankan tahap {st["id"]} dengan catatan setiap file dan blok.\n* Input: Do-file {st["path"]} serta masukan yang tercatat dalam registry.\n* Output: Artefak tahap dan log proses; belum selesai sampai pemeriksaannya lolos.\n* Gagal: Simpan kode error asli, tutup proses, dan jangan tandai tahap berhasil.\n* Siapkan pencatatan tanpa mengubah data penelitian.\nversion 17\nclear all\nset more off\nset linesize 255\nadopath ++ "{R}/code/logging"\ncapture noisily __wf_progress init "" "" "" 0 0 `=_rc\'\nassert "$WFLOG_READY"=="1" & "$WFLOG_ERRORS"=="0"\n* Tetapkan folder kerja untuk do-file anak yang memakai alamat relatif.\ncd "{R}"\n* Jalankan tahap asli; tangkap kode hasilnya segera setelah selesai.\ncapture noisily do "{R}/{actual_stage_path}" "{R}"\nlocal wf_stage_rc=_rc\n* Error menghentikan tahap; keberhasilan memerlukan semua tingkat log tertutup.\nif `wf_stage_rc\'!=0 {{\n capture noisily __wf_progress abort "" "" "" 0 0 `wf_stage_rc\'\n display as error "WF_STAGE_ERROR|stage={st["id"]}|rc=`wf_stage_rc\'"\n exit `wf_stage_rc\'\n}}\nassert "$WFLOG_DEPTH"=="0" & "$WFLOG_ERRORS"=="0"\ncapture noisily __wf_progress close "" "" "" 0 0 `=_rc\'\nassert "$WFLOG_READY"=="0"\ndisplay "WF_OWNED_STAGE_SUCCESS_{st["id"]}"\n')
   batch=entry.with_suffix(".log")
   assert not batch.exists() and not (Path("/private/tmp")/batch.name).exists(), "Owned batch log collision"
   if batch.exists():shutil.copy2(batch,attempt/'prior-batch.log')
   relay=OwnedLogRelay([batch,Path('/private/tmp')/batch.name],sys.stdout.buffer)
   console_relay=OwnedLogRelay([attempt/'console.log'],sys.stdout.buffer)
   env=os.environ.copy();env['STATATMP']=str(R/'scratch')+'/';env['TMPDIR']=str(R/'scratch')+'/'
   rcpt={'stage':st['id'],'entry':str(entry.relative_to(R)),'entry_sha256':sha(entry),'status':'running','started_utc':utc(),'implementation_manifest_sha256':msha,'attempt':str(attempt.relative_to(R)),'disk_samples':[],'current_parent_bindings':parent_bindings,'actual_stage_path':actual_stage_path}
   if tail and st['id']=='F030':rcpt['bounded_tail_resume']={'contract_path':'registry/F030-tail-resume.json','contract_sha256':sha(R/'registry/F030-tail-resume.json'),'prior_failed_receipt_sha256':tail['prior_failed_receipt_sha256'],'retained_files_count':len(tail['retained_files']),'full_stage_reexecuted':False}
   with (attempt/'console.log').open('wb') as log:
    child=subprocess.Popen([STATA,'-b','do',str(entry)],cwd='/private/tmp',env=env,stdout=log,stderr=subprocess.STDOUT,start_new_session=True);rcpt['pid']=child.pid;write(attempt/'receipt.json',rcpt);write(R/f'runtime/{st["id"]}-latest.json',rcpt);print(json.dumps({'stage':st['id'],'pid':child.pid,'status':'started'}),flush=True)
    try:
     last_guard=0
     while child.poll() is None:
      relay.poll();console_relay.poll();time.sleep(.1)
      if time.monotonic()-last_guard>=5:
       b=size();free=shutil.disk_usage(R).free;rcpt['disk_samples'].append({'utc':utc(),'bytes':b,'free':free});last_guard=time.monotonic()
       if b>CAP or free<MINFREE:raise RuntimeError('Resource guard reached')
    except BaseException:
     if child.poll() is None:
      os.killpg(child.pid,signal.SIGTERM)
      try:child.wait(timeout=20)
      except subprocess.TimeoutExpired:os.killpg(child.pid,signal.SIGKILL);child.wait()
     raise
    finally:
     child.wait();rcpt.update(exit_code=child.returncode,owned_process_exited=True,finished_utc=utc())
   # Batch log may be written relative to initial or changed cwd; only the exact owned name is considered.
   rcpt['batch_relay']=relay.finish();rcpt['console_relay']=console_relay.finish()
   if not batch.exists():
    alt=Path('/private/tmp')/batch.name
    if alt.exists():shutil.copy2(alt,batch)
   assert batch.exists(),f'Owned batch log absent: {batch}'
   shutil.copy2(batch,attempt/'batch.log');text=batch.read_text(errors='replace');marker=f'WF_OWNED_STAGE_SUCCESS_{st["id"]}'
   rcpt['success_marker_present']=marker in text.splitlines();assert child.returncode==0 and rcpt['success_marker_present'],f'{st["id"]} Stata error; see {attempt}/batch.log'
   assert 'WF_PROGRESS|CLOSED|depth=0|errors=0' in text.splitlines() and not any(x.startswith('WF_LOGGER_ERROR|') for x in text.splitlines()),'Hierarchy logger did not close cleanly'
   rcpt['logging_integrity']={'status':'passed','clock_resolution_seconds':1,'emitted_progress_events':sum(x.startswith('WF_PROGRESS|') for x in text.splitlines()),'closed_depth':0,'logger_errors':0}
   if tail and st['id']=='F030':
    for x in tail['retained_files']:assert (R/x['path']).stat().st_size==x['bytes'] and sha(R/x['path'])==x['sha256'],x['path']
    rcpt['bounded_tail_resume']['retained_outputs_unchanged']=True
   checks(m);rcpt['validation']=audit(st['id']);rcpt['output_hashes']=outputs(st);rcpt['input_code_hashes_unchanged']=True;rcpt['status']='passed';write(attempt/'receipt.json',rcpt);write(R/f'runtime/{st["id"]}-latest.json',rcpt)
   removed=cleanup(st['id'],attempt);completed.append(st['id']);print(json.dumps({'stage':st['id'],'status':'passed','removed_generated_bytes':sum(x['bytes'] for x in removed)}),flush=True)
  for x in m['input_files']:assert sha(x['path'])==x['sha256'],x['path']
  assert sha(mpath)==msha and sha(STATA)==m['stata_sha256']
  if stop==len(stages):
   wm=json.loads((R/'runtime/wave-output-manifest.json').read_text());am=json.loads((R/'corrections/runtime/aggregate-output-manifest.json').read_text());outs=[wm['master']]+wm['waves']+am['reports'];hh=[]
   for x in outs:
    for path in [x['path']]+([x['csv_path']] if 'csv_path' in x else []):p=R/path;hh.append({'path':path,'bytes':p.stat().st_size,'sha256':sha(p)})
   overall.update(status='passed',owned_process_exited=True,exit_code=0,success_marker_present=True,pid=rcpt['pid'],finished_utc=utc(),output_hashes=hh,schema_comparison_status='passed',input_code_hashes_unchanged=True,G0_complete=False,source_admission=False)
  else:overall.update(status='partial_stages_passed',owned_process_exited=True,exit_code=0,finished_utc=utc())
  write(run/'receipt.json',overall);write(R/'runtime/latest.json',overall)
  if overall['status']=='passed':finalize_publication()
 except BaseException as e:
  if 'rcpt' in locals():
   if 'relay' in locals() and relay.path and relay.path.is_file():shutil.copy2(relay.path,attempt/'batch.log');rcpt['failed_batch_sha256']=sha(attempt/'batch.log')
   rcpt.update(status='failed',error=repr(e));write(attempt/'receipt.json',rcpt);write(R/f'runtime/{st["id"]}-latest.json',rcpt)
  overall.update(status='failed',finished_utc=utc(),error=repr(e),owned_process_exited=('child' not in locals() or child.poll() is not None));write(run/'receipt.json',overall);write(R/'runtime/latest.json',overall);raise
 write(run/'receipt.json',overall);write(R/'runtime/latest.json',overall);print(json.dumps({'status':overall['status'],'receipt':str(R/'runtime/latest.json')}),flush=True)
if __name__=='__main__':main()
