#!/usr/bin/env python3
"""Prepare an isolated copy of the accepted 17-stage G0 replay; originals are read only."""
from pathlib import Path
import argparse
import datetime as dt
import importlib.util
import json
import os
import shutil
import signal
import subprocess
import sys
import time
import uuid
from workflow import sha,write_json,quoted,reply

OLD='/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2'


def prepare(original,output):
    original=original.resolve();output=output.resolve()
    if output.is_relative_to(original) or original.is_relative_to(output): raise ValueError('Replay output must be separate from the original G0 workspace')
    output.mkdir(parents=True,exist_ok=True)
    manifest=json.loads((original/'implementation-manifest.json').read_text())
    def frozen_path(value):
        path=Path(value)
        try: return original.parent/path.relative_to(Path(OLD).parent)
        except ValueError: return path
    missing=[x['path'] for x in manifest['input_files'] if not frozen_path(x['path']).is_file()]
    if missing: raise ValueError(f'{len(missing)} frozen input/reference files are missing; first: {missing[0]}. No Stata started.')
    print('G0 PREFLIGHT | Verify original code and declared inputs...',flush=True)
    for x in manifest['code_files']:
        if sha(original/x['path'])!=x['sha256']:raise ValueError('Original sealed code changed: '+x['path'])
    for x in manifest['input_files']:
        if sha(frozen_path(x['path']))!=x['sha256']:raise ValueError('Original input changed: '+x['path'])
    root=output/(dt.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]);root.mkdir()
    foundation=root/'foundation';foundation.mkdir()
    parent=original.parent/'G0-rebuild'
    # The copied audit helper reads its sibling reference directory. Only read
    # operations may name this reference; all generated outputs go to foundation.
    (root/'G0-rebuild').symlink_to(parent,target_is_directory=True)
    files={x['path'] for x in manifest['code_files']}
    for prefix in ['registry','references','corrections/metadata','correction-planning','provenance','rd2017/metadata','rd2017/registry']:
        folder=original/prefix
        if folder.exists():
            files.update(str(p.relative_to(original)) for p in folder.rglob('*') if p.is_file() and p.suffix in {'.json','.csv','.dta','.do','.ado','.md','.txt'})
    records=[]
    for rel in sorted(files):
        source=original/rel;dest=foundation/rel;dest.parent.mkdir(parents=True,exist_ok=True)
        if source.suffix in {'.do','.ado','.py','.json','.command'}:
            text=source.read_text()
            if source.suffix=='.do':
                # Disabling the original optional statement logger bounds log volume;
                # all explanatory comments and number-moving statements are retained.
                text='\n'.join(l for l in text.splitlines() if 'WFLOG-INJECTED' not in l)+'\n'
            text=text.replace(OLD,str(foundation)).replace(str(Path(OLD).parent),str(root))
            text=text.replace(str(original),str(foundation))
            dest.write_text(text)
        else: shutil.copy2(source,dest)
        records.append({'path':rel,'source_sha256':sha(source),'copy_sha256':sha(dest)})
    # Empty generated directories are required by the unchanged Stata do-files.
    for prefix in ['data','validation','corrections','dag/data','dag/logs','dag/reports','report','runtime','scratch','audit','rd2017']:
        folder=original/prefix
        if folder.exists():
            for p in folder.rglob('*'):
                if p.is_dir(): (foundation/p.relative_to(original)).mkdir(parents=True,exist_ok=True)
        (foundation/prefix).mkdir(parents=True,exist_ok=True)
    stages=json.loads((original/'registry/stages.json').read_text())
    assert len(stages)==17 and stages[0]['id']=='T000' and stages[-1]['id']=='H090'
    audit_path=foundation/'scripts/validate_outputs.py'
    for stage in stages:
        sid=stage['id'];path=foundation/'runtime'/f'{sid}.do'
        path.write_text(f'''* Accepted G0 stage {sid}; copied code and inputs recorded in replay.json.
version 17
clear all
set more off
set varabbrev off
set maxvar 10000
cd {quoted(foundation)}
capture quietly do {quoted(foundation/stage['path'])} {quoted(foundation)}
local stage_rc=_rc
if `stage_rc' {{
    noisily display as error "G0_REPLAY_FAILED|{sid}|rc=`stage_rc'"
    exit `stage_rc'
}}
noisily display "G0_REPLAY_PASSED_{sid}"
''')
    receipt={'status':'prepared_not_executed','prepared_at':dt.datetime.now(dt.timezone.utc).isoformat(),
             'original_root':str(original),'foundation':str(foundation),
             'original_implementation_sha256':sha(original/'implementation-manifest.json'),
             'input_files':manifest['input_files'],'copied_files':records,'stage_order':stages,'stages':[],
             'boundary':'Starts from the 12 accepted staged annual DTA files and frozen mappings, not a newly generalized Excel import.',
             'modifications':['absolute output root rebound','per-statement logging disabled; explanatory comments retained'],
             'originals_unchanged':True,'all_17_stages_rerun':False}
    write_json(root/'replay.json',receipt)
    (root/'README.md').write_text('# G0 replay prepared\n\nAll declared original inputs and code hashes passed. No Stata stage has run until `replay.json` records it.\n\nThe copied code writes only inside `foundation/`. `G0-rebuild` is a read-only-use reference to retained comparison inputs. Do not edit that reference.\n')
    return root


def execute(root,stata,through):
    receipt=json.loads((root/'replay.json').read_text());foundation=Path(receipt['foundation'])
    order=receipt['stage_order'];ids=[x['id'] for x in order]
    if through not in ids:raise ValueError('Unknown through-stage')
    selected=order[:ids.index(through)+1]
    spec=importlib.util.spec_from_file_location('owner_g0_audit',foundation/'scripts/validate_outputs.py')
    audit=importlib.util.module_from_spec(spec);spec.loader.exec_module(audit)
    cap=10*1024**3;minimum=5*1024**3
    env=os.environ.copy();env.update(STATATMP=str(foundation/'scratch')+'/',TMPDIR=str(foundation/'scratch')+'/',OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1')
    receipt['status']='running';write_json(root/'replay.json',receipt)
    for stage in selected:
        sid=stage['id'];started=time.monotonic()
        if shutil.disk_usage(root).free<minimum:raise RuntimeError('Free disk below 5 GiB; no new stage started')
        print(f'START | G0 {sid} | {stage["path"]}',flush=True)
        entry=foundation/'runtime'/f'{sid}.do'
        with (foundation/'runtime'/f'{sid}-console.log').open('w') as console:
            process=subprocess.Popen([str(stata),'-b','do',str(entry)],cwd=foundation/'runtime',env=env,stdout=console,stderr=subprocess.STDOUT,start_new_session=True)
            try:
                while process.poll() is None:
                    time.sleep(1)
                    if shutil.disk_usage(root).free<minimum:
                        raise RuntimeError('Free disk reached 5 GiB guard')
                    if time.monotonic()-started>7200:raise RuntimeError('Owned stage exceeded the two-hour bound')
            except BaseException:
                if process.poll() is None:
                    os.killpg(process.pid,signal.SIGTERM)
                    try:process.wait(timeout=10)
                    except subprocess.TimeoutExpired:os.killpg(process.pid,signal.SIGKILL);process.wait()
                receipt.update(status='failed',failed_stage=sid);write_json(root/'replay.json',receipt);raise
        log=entry.with_suffix('.log');lines=log.read_text(errors='replace').splitlines() if log.exists() else []
        if process.returncode or f'G0_REPLAY_PASSED_{sid}' not in lines:
            receipt.update(status='failed',failed_stage=sid);write_json(root/'replay.json',receipt)
            raise RuntimeError(f'{sid} failed; see {log}. Earlier outputs and original data remain intact.')
        validation=audit.audit(sid)
        rec={'stage':sid,'status':'passed','elapsed_seconds':time.monotonic()-started,'pid':process.pid,
             'process_exited':True,'log_sha256':sha(log),'validation':validation}
        receipt['stages'].append(rec);write_json(root/'replay.json',receipt)
        print(f'PASS | G0 {sid} | {rec["elapsed_seconds"]:.1f} seconds',flush=True)
        if sid=='V070':
            # Exact baseline comparison has passed. These are generated duplicate
            # masters from this owned replay, never original inputs or final waves.
            names=['raw_fields_preserved','economic_fields','energy_fields','energy_emissions','derived_fields','identifier_fields','classification_fields','deflator_fields','main_verified_20260910','main_analysis_tunnel_20260910','main_candidate','analysis_ready']
            candidates=[foundation/'dag/data/word_data/G0'/f'G0_{n}.dta' for n in names]+list((foundation/'data/intermediate').glob('verified_wave_*.dta'))
            removed=[]
            for p in candidates:
                if p.exists():
                    assert p.is_relative_to(foundation) and not p.is_symlink()
                    removed.append({'path':str(p.relative_to(foundation)),'bytes':p.stat().st_size,'sha256':sha(p)});p.unlink()
            write_json(foundation/'runtime/generated-duplicate-cleanup.json',{'after_stage':'V070','files':removed,'originals_removed':False})
    for x in receipt['input_files']:
        input_path=Path(receipt['original_root']).parent/Path(x['path']).relative_to(Path(OLD).parent)
        if sha(input_path)!=x['sha256']:raise RuntimeError('Original input changed during replay')
    receipt.update(status='passed_full_replay' if through=='H090' else 'passed_selected_initial_stages',all_17_stages_rerun=through=='H090',finished_at=dt.datetime.now(dt.timezone.utc).isoformat())
    write_json(root/'replay.json',receipt)


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--original',type=Path,required=True);p.add_argument('--output',type=Path,required=True)
    p.add_argument('--stata',type=Path,required=True);p.add_argument('--execute',choices=['0','1'],default='0');p.add_argument('--through',default='H090');p.add_argument('--reply',required=True)
    a=p.parse_args()
    try:
        root=prepare(a.original,a.output)
        if a.execute=='1':execute(root,a.stata,a.through)
        reply(a.reply,G0_REPLAY_FOLDER=root,G0_REPLAY_STATUS=json.loads((root/'replay.json').read_text())['status'])
        print('G0 REPLAY | '+str(root),flush=True)
    except Exception as e:print('G0 REPLAY FAILED | '+str(e),file=sys.stderr);raise SystemExit(1)

if __name__=='__main__':main()
