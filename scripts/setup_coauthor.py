#!/usr/bin/env python3
"""Configure the shared Stata demo for this machine; preserve frozen data."""
import argparse, hashlib, json, shutil, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def sha(path):
 h=hashlib.sha256()
 with path.open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
def digest(obj):return hashlib.sha256(json.dumps(obj,sort_keys=True,ensure_ascii=False).encode()).hexdigest()
def quote(value):
 value=str(value)
 if any(c in value for c in ['"','`','$','\r','\n','\t']):raise ValueError('Use a path without Stata metacharacters')
 return '"'+value+'"'
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',type=Path,required=True);p.add_argument('--stata',required=True);a=p.parse_args()
 out=a.output.expanduser().resolve()
 if out.is_relative_to(ROOT):raise SystemExit('--output must be outside the Git checkout')
 stata=shutil.which(a.stata) or (str(Path(a.stata).resolve()) if Path(a.stata).is_file() else None)
 if not stata:raise SystemExit('Stata executable not found')
 actual=ROOT/'inputs/actual/source_actual.dta';manifest_path=ROOT/'data/g0-5-development/manifest.json'
 manifest=json.loads(manifest_path.read_text())
 if sha(actual)!=manifest['source_g0_master_sha256']:raise SystemExit('Actual source hash mismatch')
 for mode in ['development','actual']:
  folder=ROOT/'inputs'/mode;receipt=json.loads((folder/'cache.json').read_text())
  if sha(folder/'G0_analysis_ready.dta')!=receipt['dta_sha256']:raise SystemExit('Master hash mismatch: '+mode)
  key=digest({'mode':mode,'development_manifest':sha(manifest_path),'actual_path':str(actual),'adapter':sha(ROOT/'harness/data_source.py')})
  target=out/'cache'/key;target.parent.mkdir(parents=True,exist_ok=True)
  if target.is_symlink() and target.resolve()==folder.resolve():pass
  elif target.exists() or target.is_symlink():raise SystemExit('Existing different cache: '+str(target))
  else:target.symlink_to(folder,target_is_directory=True)
 home=ROOT/'demo'
 settings={'RUN_REPO':ROOT,'RUN_OUTPUT':out,'RUN_PYTHON':sys.executable,'RUN_STATA':stata,'RUN_ACTUAL_PATH':actual,'G0_ORIGINAL_ROOT':ROOT/'g0-original/G0-wave-foundation-v2'}
 text='\n'.join('global '+k+' '+quote(v) for k,v in settings.items())+'\n'
 local=home/'local_paths.do'
 if local.exists() and local.read_text()!=text:raise SystemExit('Existing local_paths.do differs; preserve it before reconfiguring')
 local.write_text(text)
 print('Stata commands:\ncd '+quote(home)+'\ndoedit '+quote(home/'00_MASTER.do')+'\nClick Do for the entire file.')
if __name__=='__main__':main()
