#!/usr/bin/env python3
"""Run the owner do-file in one owned Stata process; detect Stata errors correctly."""
from pathlib import Path
import argparse
import datetime
import json
import os
import re
import shutil
import signal
import subprocess
import time
import uuid
import sys


def main():
    p=argparse.ArgumentParser();p.add_argument('home',type=Path);p.add_argument('--no-open',action='store_true');a=p.parse_args();home=a.home.resolve()
    stata=shutil.which('stata-se') or shutil.which('stata')
    config=home/'local_paths.do'
    if config.exists():
        match=re.search(r'^global RUN_STATA "([^"]+)"',config.read_text(),re.M)
        if match:stata=match.group(1)
    if not stata:raise SystemExit('Stata was not found. Configure RUN_STATA in local_paths.do.')
    folder=home/'launch-logs';folder.mkdir(exist_ok=True)
    name=datetime.datetime.now().strftime('%Y%m%d-%H%M%S')+'-'+uuid.uuid4().hex[:6]
    entry=folder/(name+'.do');entry.write_text('do "'+str(home/'00_RUN_ME.do')+'" "'+str(home)+'"\n')
    env=os.environ.copy();env.update(OPENBLAS_NUM_THREADS='1',OMP_NUM_THREADS='1',MKL_NUM_THREADS='1')
    log=entry.with_suffix('.log');position=0;buffer='';active_run=None;opened=False
    with (folder/(name+'-console.log')).open('w') as console:
        process=subprocess.Popen([stata,'-b','do',str(entry)],cwd=folder,stdout=console,stderr=subprocess.STDOUT,env=env,start_new_session=True)
        try:
            while process.poll() is None:
                if log.exists():
                    with log.open(errors='replace') as f:f.seek(position);chunk=f.read();position=f.tell()
                    buffer+=chunk
                    *lines,buffer=buffer.split('\n')
                    for line in lines:
                        if line.startswith('READY | '):active_run=Path(line.split(' | ',1)[1].strip())
                    if active_run and not opened and (active_run/'DEMO.html').exists() and not a.no_open:
                        subprocess.run(['open',str(active_run/'DEMO.html')],check=False);opened=True
                    for line in lines:
                        if line.startswith(('PREFLIGHT |','NORMALIZE |','START |','PASSED |','FAILED |','NOT_APPLICABLE |','COVERAGE |','G0 TABLE |','READY |','SELESAI |','G1_START |','G1_PASSED |','G1_N04 CELL |','DEMO_DONE |')):print(line,flush=True)
                time.sleep(.5)
        except KeyboardInterrupt:
            os.killpg(process.pid,signal.SIGTERM);process.wait();raise SystemExit('Owned Stata run stopped; completed outputs and logs retained.')
    text=log.read_text(errors='replace') if log.exists() else ''
    success=[line for line in text.splitlines() if line.startswith('DEMO_DONE | ')]
    if process.returncode or not success:
        if active_run:subprocess.run([sys.executable,str(home/'scripts/demo.py'),'failed',str(active_run),'See '+str(log)],check=False)
        print('FAILED | Stata did not report a completed run. Read '+str(log),flush=True)
        print('\n'.join(text.splitlines()[-35:]),flush=True);raise SystemExit(1)
    start=Path(success[-1].split(' | ',1)[1].strip());state=json.loads((start.parent/'DEMO_COMPLETE.json').read_text())
    if state['status']!='passed':raise SystemExit('Completion receipt did not pass: '+str(start.parent/'DEMO_COMPLETE.json'))
    print('SELESAI | '+str(start),flush=True)

if __name__=='__main__':main()
