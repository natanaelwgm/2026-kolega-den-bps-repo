#!/usr/bin/env python3
"""One owned helper, streamed through a Stata polling program (no parallel estimators)."""
import os,sys,subprocess,json,signal
from pathlib import Path

def main():
 action,logfile,donefile,pidfile=sys.argv[1:5]
 log,done,pid=map(Path,[logfile,donefile,pidfile])
 command=sys.argv[6:] if len(sys.argv)>5 and sys.argv[5]=='--' else []
 if action=='start':
  log.write_text('');p=subprocess.Popen([sys.executable,__file__,'worker',logfile,donefile,pidfile,'--',*command],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,start_new_session=True)
  pid.write_text(str(p.pid));return
 if action=='stop':
  if pid.exists() and not done.exists():
   try:os.killpg(int(pid.read_text()),signal.SIGTERM)
   except ProcessLookupError:pass
  return
 if action!='worker':raise ValueError(action)
 rc=1
 with log.open('a',buffering=1) as out:
  try:
   env=os.environ.copy();env['PYTHONUNBUFFERED']='1'
   cache=Path(__file__).resolve().parents[1]/'runtime-cache';cache.mkdir(exist_ok=True)
   env['MPLCONFIGDIR']=str(cache/'matplotlib');env['XDG_CACHE_HOME']=str(cache)
   rc=subprocess.run(command,stdout=out,stderr=subprocess.STDOUT,env=env).returncode
  except BaseException as exc:out.write(str(exc)+'\n')
 temporary=done.with_suffix('.pending');temporary.write_text(f'global DEMO_HELPER_RC {rc}\n');temporary.replace(done)
if __name__=='__main__':main()
