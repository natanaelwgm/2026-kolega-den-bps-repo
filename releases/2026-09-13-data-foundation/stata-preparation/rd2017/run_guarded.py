#!/usr/bin/env python3
"""Single owned Stata launch; sole executor invokes this, never a Stata child."""
from pathlib import Path
import argparse,datetime,fcntl,hashlib,json,os,resource,shutil,signal,subprocess,sys,time,uuid
from validate_inputs import validate
H=Path(__file__).resolve().parent;F=H.parent;R=F.parent.parent
sys.path.insert(0,str(F/'scripts'))
from live_relay import OwnedLogRelay
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def write(p,x):Path(p).write_text(json.dumps(x,indent=2)+'\n')
def size(p):return sum(x.stat().st_size for x in p.rglob('*') if x.is_file() and not x.is_symlink())
def no_stata():
 out=subprocess.run(['/bin/ps','-axo','pid=,comm='],check=True,capture_output=True,text=True).stdout
 for line in out.splitlines():
  _,name=line.strip().split(None,1)
  assert Path(name).name.lower() not in {'stata','stata-se','stata-mp','statase','statamp'},line
def main():
 p=argparse.ArgumentParser();p.add_argument('--master-receipt');p.add_argument('--fixtures-only',action='store_true');a=p.parse_args()
 assert a.fixtures_only or a.master_receipt
 for n in ['runtime','scratch','states','outputs','fixtures','validation']:(H/n).mkdir(exist_ok=True)
 lock=(R/'work/G0-rebuild/runtime/stata-owned.lock').open('a');fcntl.flock(lock,fcntl.LOCK_EX|fcntl.LOCK_NB);no_stata()
 assert shutil.disk_usage(F).free>=12*1024**3 and size(F)<=10*1024**3
 imp=H/'implementation-manifest.json';im=json.loads(imp.read_text());freeze=F/'plan-freeze.json'
 assert im['plan_freeze_sha256']==sha(freeze)
 for e in json.loads(freeze.read_text())['files']:assert sha(e['path'])==e['sha256']
 for e in im['files']:assert sha(H/e['path'])==e['sha256']
 for e in im['external_code_files']:
  q=F/e['path'];assert q.resolve().is_relative_to(F.resolve()) and sha(q)==e['sha256']
 assert sha('/Applications/Stata/StataSE.app/Contents/MacOS/stata-se')==im['stata_sha256']
 review_path=H/'implementation-review/static-review.json';review=json.loads(review_path.read_text())
 assert review['status']=='PASS_STATIC_IMPLEMENTATION_REVIEW' and review['implementation_manifest_sha256']==sha(imp)
 pre=None if a.fixtures_only else validate(a.master_receipt)
 pins=[{'path':str(H/e['path']),'sha256':e['sha256']} for e in im['files']]
 pins += [{'path':str(q),'sha256':sha(q)} for q in [imp,freeze,review_path]]
 pins += [{'path':str(F/e['path']),'sha256':e['sha256']} for e in im['external_code_files']]
 pins += [{'path':'/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','sha256':im['stata_sha256']}]
 if pre:pins+=pre['files_checked']+[{'path':str(H/'runtime'/n),'sha256':sha(H/'runtime'/n)} for n in ['preflight.json','preflight_pass.do']]
 t=datetime.datetime.now(datetime.timezone.utc);tag=('fixtures-' if a.fixtures_only else 'actual-')+t.strftime('%Y%m%dT%H%M%SZ')+'-'+uuid.uuid4().hex[:8];attempt=H/'runtime'/tag;attempt.mkdir()
 write(attempt/'pinned-inputs.json',pins)
 logname='fixtures-run.log' if a.fixtures_only else 'run.log'
 for name in [logname]+[f'RD17-{i:03d}.log' for i in range(0,101,10)]:
  q=H/'runtime'/name
  if q.exists():shutil.copy2(q,attempt/f'previous-{name}');q.unlink()
 script='run_fixtures.do' if a.fixtures_only else 'run.do'
 # Berkas pembungkus hanya menyiapkan log dan memeriksa hasil proses asli.
 entry=H/f'run_RD17_owned_{tag}.do'
 entry.write_text(f'''* Tujuan: Jalankan R&D 2017 dengan log bertingkat tanpa mengganti rumus asli.
* Input: {script}; seluruh jawaban perusahaan berasal dari master gabungan yang lolos.
* Output: Dataset dan CSV R&D, beserta log yang disimpan persis seperti ditampilkan.
* Gagal: Pertahankan kode error asli dan jangan terbitkan bukti kelulusan.
version 17
clear all
set more off
set linesize 255
adopath ++ "{F}/code/logging"
capture noisily __wf_progress init "" "" "" 0 0 `=_rc'
assert "$WFLOG_READY"=="1" & "$WFLOG_ERRORS"=="0"
* Parameter foundation tetap sama dengan peluncur asli.
capture noisily do "{H/script}" "{F}"
local rd_owned_rc=_rc
if `rd_owned_rc'!=0 {{
 capture noisily __wf_progress abort "" "" "" 0 0 `rd_owned_rc'
 display as error "RD17_OWNED_METHOD_ERROR rc=`rd_owned_rc'"
 exit `rd_owned_rc'
}}
* Kode rc pada marker bisa berasal dari perintah sebelumnya; batas ini menangkap kegagalan proses.
assert "$WFLOG_DEPTH"=="0" & "$WFLOG_ERRORS"=="0"
capture noisily __wf_progress close "" "" "" 0 0 `=_rc'
assert "$WFLOG_READY"=="0"
display "RD17_OWNED_LOGGED_PROCESS_SUCCESS"
''')
 command=['/Applications/Stata/StataSE.app/Contents/MacOS/stata-se','-b','do',str(entry)]
 relay=OwnedLogRelay([entry.with_suffix('.log'),Path('/private/tmp')/entry.with_suffix('.log').name],sys.stdout.buffer)
 console_relay=OwnedLogRelay([attempt/'console.log'],sys.stdout.buffer)
 env=os.environ.copy();env['TMPDIR']=str(H/'scratch')+'/';env['STATATMP']=str(H/'scratch')+'/'
 rec={'status':'running','attempt':str(attempt),'command':command,'cwd':str(H),'started_utc':t.isoformat(),'fixture_only':a.fixtures_only,'actual_source_year':None if a.fixtures_only else 2017,'actual_company_answers_classified':False,'measurement_admitted':False,'primary_release':False,'G0_complete':False,'plan_freeze_sha256':sha(freeze),'historical_method_plan_sha256':im['historical_method_plan_sha256'],'implementation_manifest_sha256':sha(imp),'static_review_sha256':sha(review_path),'master_receipt':pre['master_receipt'] if pre else None,'master':pre['master'] if pre else None,'resource_contract':{'target_foundation_bytes':8*1024**3,'hard_foundation_bytes':10*1024**3,'minimum_free_bytes':12*1024**3},'samples':[]}
 rec.update(entry=str(entry),entry_sha256=sha(entry),logging_helper_sha256=sha(F/'code/logging/__wf_progress.ado'),clock_resolution_seconds=1)
 started=time.monotonic();child=None;error=None
 try:
  with (attempt/'console.log').open('wb') as out:
   child=subprocess.Popen(command,cwd=H,env=env,stdout=out,stderr=subprocess.STDOUT,start_new_session=True)
   rec['pid']=child.pid;write(attempt/'running.json',rec);print(json.dumps({'pid':child.pid,'attempt':str(attempt),'fixture_only':a.fixtures_only}),flush=True)
   while child.poll() is None:
    relay.poll();console_relay.poll();time.sleep(.1)
    if not rec['samples'] or time.monotonic()-started-rec['samples'][-1]['seconds']>=2:
     s={'seconds':round(time.monotonic()-started,2),'foundation_bytes':size(F),'free_bytes':shutil.disk_usage(F).free};rec['samples'].append(s)
     if s['foundation_bytes']>10*1024**3 or s['free_bytes']<12*1024**3:raise RuntimeError('Foundation storage boundary reached')
 except BaseException as ex:
  error=f'{type(ex).__name__}: {ex}'
 finally:
  if child is not None:
   if child.poll() is None:
    os.killpg(child.pid,signal.SIGTERM)
    try:child.wait(timeout=20)
    except subprocess.TimeoutExpired:os.killpg(child.pid,signal.SIGKILL);child.wait()
   else:child.wait()
 try:
  rec['batch_relay']=relay.finish();rec['console_relay']=console_relay.finish()
  shutil.copy2(relay.path,attempt/'batch.log')
 except BaseException as ex:
  error=error or f'Log relay: {type(ex).__name__}: {ex}'
  if relay.path and relay.path.exists():shutil.copy2(relay.path,attempt/'batch.log')
 text=(attempt/'batch.log').read_text(errors='replace') if (attempt/'batch.log').exists() else ''
 actual_lines=text.splitlines()
 rec['logging_integrity']={'status':'passed' if 'RD17_OWNED_LOGGED_PROCESS_SUCCESS' in actual_lines and 'WF_PROGRESS|CLOSED|depth=0|errors=0' in actual_lines and not any(x.startswith('WF_LOGGER_ERROR|') for x in actual_lines) else 'failed','clock_resolution_seconds':1,'progress_events':sum(x.startswith('WF_PROGRESS|') for x in actual_lines),'stack_lines':sum(x.startswith('WF_STACK|') for x in actual_lines),'echoed_source_is_not_evidence':True}
 for q in [H/'runtime'/logname,H/'run.log',H/'run_fixtures.log']:
  if q.exists():shutil.copy2(q,attempt/('batch-'+q.name if q.parent==H else q.name))
 wanted=[10] if a.fixtures_only else list(range(0,101,10));children=[]
 for i in wanted:
  q=H/'runtime'/f'RD17-{i:03d}.log';ok=q.exists() and f'PASS CHILD RD17-{i:03d}' in q.read_text(errors='replace').splitlines();children.append({'process_id':f'RD17-{i:03d}','passed':ok})
  if q.exists():shutil.copy2(q,attempt/q.name)
 marker='G0_RD17_CANONICAL_FIXTURES_SUCCESS' if a.fixtures_only else 'G0_RD2017_MASTER_ONLY_SUCCESS_CANDIDATE_ONLY'
 rec.update({'error':error,'finished_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'exit_code':None if child is None else child.returncode,'owned_process_exited':child is not None and child.poll() is not None,'elapsed_seconds':round(time.monotonic()-started,2),'success_marker_present':marker in text.splitlines(),'input_code_hashes_unchanged':all(Path(e['path']).exists() and sha(e['path'])==e['sha256'] for e in pins),'children':children,'exact_roundtrip_markers':sum(x.startswith('RD17_ROUNDTRIP_PASS ') for x in text.splitlines()),'canonical_bridge_pass':all(f'RD17_CANONICAL_BRIDGE_PASS {n}' in text.splitlines() for n in ['truth25-literal-inputs','literal-parser-fixtures']),'wide_token_expected_rejection_pass':'RD17_L07_EXPECTED_CANONICAL_REJECTION_PASS' in text.splitlines(),'guard_fixtures_pass':'RD17_BRIDGE_AND_GUARD_FIXTURES_PASS' in text.splitlines(),'actual_parity_pass':False if a.fixtures_only else 'RD17_MASTER_AND_HISTORICAL_PARITY_PASS' in text.splitlines()})
 rec['status']='passed' if not error and rec['exit_code']==0 and rec['owned_process_exited'] and rec['success_marker_present'] and rec['input_code_hashes_unchanged'] and sha(entry)==rec['entry_sha256'] and rec['logging_integrity']['status']=='passed' and rec['logging_integrity']['progress_events']>0 and rec['logging_integrity']['stack_lines']>0 and all(x['passed'] for x in children) and rec['canonical_bridge_pass'] and rec['wide_token_expected_rejection_pass'] and rec['guard_fixtures_pass'] and rec['exact_roundtrip_markers']==(4 if a.fixtures_only else 12) and (a.fixtures_only or rec['actual_parity_pass']) else 'failed'
 rec['actual_company_answers_classified']=rec['status']=='passed' and not a.fixtures_only
 stems=list(json.loads((H/'output-contract.json').read_text())['table_schemas'])
 if a.fixtures_only:stems=[x for x in stems if x.startswith('fixtures/')]
 stems+=['fixtures/guard_results']+([] if a.fixtures_only else ['validation/equivalence'])
 rec['output_hashes']=[{'path':str(H/f'{stem}.{ext}'),'sha256':sha(H/f'{stem}.{ext}'),'bytes':(H/f'{stem}.{ext}').stat().st_size} for stem in stems for ext in ['dta','csv'] if (H/f'{stem}.{ext}').exists()]
 rec['log_hashes']=[{'path':str(q),'sha256':sha(q),'bytes':q.stat().st_size} for q in [attempt/'batch.log',attempt/'console.log',entry] if q.is_file()]
 write(attempt/'receipt.json',rec);write(H/'runtime'/('fixtures-latest.json' if a.fixtures_only else 'latest.json'),rec)
 print(json.dumps({k:rec[k] for k in ['status','pid','exit_code','owned_process_exited','actual_company_answers_classified'] if k in rec}),flush=True)
 return 0 if rec['status']=='passed' else 1
if __name__=='__main__':raise SystemExit(main())
