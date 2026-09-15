"""Focused checks for archive safety and portable cache configuration; no estimation."""
import importlib.util,io,json,hashlib,sys,tarfile,tempfile
from pathlib import Path
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[1]
def module(name):
 spec=importlib.util.spec_from_file_location(name,ROOT/'scripts'/f'{name}.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m

def main():
 downloader=module('download_data');setup=module('setup_coauthor')
 with tempfile.TemporaryDirectory(prefix='kolega-packaging-') as temp:
  t=Path(temp).resolve();root=t/'repo';root.mkdir();archive=t/'safe.tar.gz'
  with tarfile.open(archive,'w:gz') as tar:
   item=tarfile.TarInfo('nested/evidence.txt');body=b'frozen evidence';item.size=len(body);tar.addfile(item,io.BytesIO(body))
  assert downloader.restore(archive,root)==1
  assert downloader.restore(archive,root)==1
  (root/'nested/evidence.txt').write_text('coauthor edit')
  try:downloader.restore(archive,root)
  except ValueError:pass
  else:raise AssertionError('Differing coauthor file overwritten')
  with tarfile.open(archive,'w:gz') as tar:
   item=tarfile.TarInfo('../escape.txt');item.size=1;tar.addfile(item,io.BytesIO(b'x'))
  try:downloader.restore(archive,root)
  except ValueError:pass
  else:raise AssertionError('Archive traversal accepted')
  assert not (t/'escape.txt').exists()
  for name in ['inputs/actual','inputs/development','demo','data/g0-5-development','harness']:(root/name).mkdir(parents=True,exist_ok=True)
  actual=root/'inputs/actual/source_actual.dta';actual.write_bytes(b'actual source')
  manifest=root/'data/g0-5-development/manifest.json';manifest.write_text(json.dumps({'source_g0_master_sha256':setup.sha(actual)}))
  adapter=root/'harness/data_source.py';adapter.write_text('# adapter\n')
  for mode in ['actual','development']:
   folder=root/'inputs'/mode;master=folder/'G0_analysis_ready.dta';master.write_bytes(mode.encode())
   (folder/'cache.json').write_text(json.dumps({'dta_sha256':setup.sha(master)}))
  setup.ROOT=root;output=t/'run folder'
  with patch.object(sys,'argv',['setup','--output',str(output),'--stata',sys.executable]):setup.main();setup.main()
  for mode in ['actual','development']:
   expected=setup.digest({'mode':mode,'development_manifest':setup.sha(manifest),'actual_path':str(actual),'adapter':setup.sha(adapter)})
   assert (output/'cache'/expected).resolve()==root/'inputs'/mode
  (root/'inputs/development/G0_analysis_ready.dta').write_bytes(b'changed')
  with patch.object(sys,'argv',['setup','--output',str(output),'--stata',sys.executable]):
   try:setup.main()
   except SystemExit:pass
   else:raise AssertionError('Changed master accepted')
 print('PASS: safe extraction, repeat extraction, edit preservation, path traversal rejection, both portable cache keys, repeated setup, changed-input rejection.')
if __name__=='__main__':main()
