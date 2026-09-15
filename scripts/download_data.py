#!/usr/bin/env python3
"""Download private release assets with gh, check SHA-256, safely restore scoped files."""
import argparse, hashlib, json, shutil, subprocess, tarfile
from pathlib import Path, PurePosixPath
ROOT=Path(__file__).resolve().parents[1]
def sha(path):
 h=hashlib.sha256()
 with path.open('rb') as f:
  for b in iter(lambda:f.read(1048576),b''):h.update(b)
 return h.hexdigest()
def restore(archive,root):
 count=0
 with tarfile.open(archive,'r:gz') as tf:
  for item in tf:
   rel=PurePosixPath(item.name)
   if rel.is_absolute() or '..' in rel.parts or not item.isfile():raise ValueError('Unsafe archive member: '+item.name)
   dest=root.joinpath(*rel.parts)
   if not dest.resolve().is_relative_to(root.resolve()):raise ValueError('Destination escapes repository')
   incoming=tf.extractfile(item)
   if dest.exists():
    h=hashlib.sha256()
    for b in iter(lambda:incoming.read(1048576),b''):h.update(b)
    if sha(dest)!=h.hexdigest():raise ValueError('Preserved differing local file: '+str(dest))
   else:
    dest.parent.mkdir(parents=True,exist_ok=True)
    temporary=dest.with_name(dest.name+'.download-part')
    with temporary.open('wb') as out:shutil.copyfileobj(incoming,out,1048576)
    temporary.chmod(item.mode & 0o777);temporary.replace(dest)
   count+=1
 return count

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--profile',choices=['demo','all'],default='demo');a=p.parse_args()
 manifest=json.loads((ROOT/'docs/release-assets.json').read_text())
 if len(manifest['assets'])!=9:raise SystemExit('Release is incomplete; pull main after publication finishes.')
 wanted=[x for x in manifest['assets'] if a.profile=='all' or x['name'][:2] in {'01','02','06','07','08'}]
 cache=ROOT/'.downloads';cache.mkdir(exist_ok=True)
 for asset in wanted:
  archive=cache/asset['name'];stamp=cache/(asset['name']+'.restored.json')
  if stamp.exists() and json.loads(stamp.read_text()).get('sha256')==asset['sha256']:
   print('ALREADY RESTORED',asset['name'],flush=True);continue
  if shutil.disk_usage(ROOT).free<asset['unpacked_bytes']+asset['bytes']+1024**3:raise SystemExit('Insufficient disk for '+asset['name']+'; free space or clone onto a larger volume.')
  if not archive.exists():
   print('DOWNLOAD',asset['name'],flush=True)
   subprocess.run(['gh','release','download',manifest['tag'],'--repo',manifest['repository'],'--pattern',asset['name'],'--dir',str(cache)],check=True)
  if sha(archive)!=asset['sha256']:raise SystemExit('SHA-256 mismatch: '+str(archive)+'; archive preserved for inspection.')
  print('EXTRACT',asset['name'],flush=True);count=restore(archive,ROOT)
  if count!=asset['files']:raise RuntimeError('Archive count mismatch')
  stamp.write_text(json.dumps({'sha256':asset['sha256'],'files':count})+'\n')
  archive.unlink()
  print('VERIFIED',asset['name'],count,'files',flush=True)
 print('Ready. Run scripts/setup_coauthor.py next.',flush=True)
if __name__=='__main__':main()
