"""Reconcile screened G0 synchronization with the source catalogue; retain prior included bytes."""
from pathlib import Path
import csv,json,hashlib,subprocess
ROOT=Path(__file__).resolve().parents[1];CAT=ROOT/'catalog'
records=json.loads((CAT/'source-files.json').read_text());sync=list(csv.DictReader((ROOT/'data/synthetic-development/g0-pipeline/contracts/g0-public-sync.csv').open()));index={r['repository_path']:r for r in records if r['disposition']=='included'}
changed=0;archived=0
for x in sync:
 if x['status']=='excluded':continue
 rel='research/1014/'+x['path'];p=ROOT/rel
 if not p.exists():continue
 digest=hashlib.sha256(p.read_bytes()).hexdigest();assert digest==x['sha256']
 old=index.get(rel)
 if old and old['sha256']==digest:continue
 if old:
  prior=subprocess.run(['git','show','d275921e:'+rel],cwd=ROOT,capture_output=True,check=True).stdout
  assert hashlib.sha256(prior).hexdigest()==old['sha256']
  archive='research/1014/g0-github-baseline-20260910/'+x['path'];a=ROOT/archive;a.parent.mkdir(parents=True,exist_ok=True);a.write_bytes(prior)
  preserved=dict(old);preserved.update(repository_path=archive,source='git:d275921e:'+rel,reason='preserved_G0_previous_publication_before_owner_sync');records.append(preserved);archived+=1
  old.update(bytes=p.stat().st_size,sha256=digest,reason='owner_authorized_G0_current_source_sync')
 else:
  records.append(dict(collection='project',source='/Users/natanaelmassie/Downloads/1014-deasy-imed-si-new-data-paper/'+x['path'],source_relative_path=x['path'],bytes=p.stat().st_size,disposition='included',reason='owner_authorized_G0_code_documentation_aggregate_sync',sha256=digest,repository_path=rel))
 changed+=1
(CAT/'source-files.json').write_text(json.dumps(records,ensure_ascii=False,indent=2)+'\n')
with (CAT/'source-files.csv').open('w',newline='') as f:
 w=csv.DictWriter(f,extrasaction='ignore',fieldnames=['collection','source','source_relative_path','bytes','disposition','reason','sha256','repository_path']);w.writeheader();w.writerows(records)
print('G0 catalogue reconciled:',changed,'current records;',archived,'prior versions retained')
