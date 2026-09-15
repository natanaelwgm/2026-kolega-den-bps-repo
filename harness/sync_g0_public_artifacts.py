"""Synchronize G0 code, documentation and screened aggregate artifacts; never copy datasets/live IPC payloads."""
from pathlib import Path
import argparse,csv,hashlib,shutil
ROOT=Path(__file__).resolve().parents[1]
ap=argparse.ArgumentParser();ap.add_argument('--source-root',type=Path,required=True);args=ap.parse_args();source=args.source_root.resolve()
roots=['05-analysis/analytical-dag/dag/edges/word_rows/G0','05-analysis/analytical-dag/dag/reports/word_data/G0','05-analysis/analytical-dag/dag/nodes/word_data/G0','05-analysis/analytical-dag/dag/logs/word_data/G0']
allow={'.do','.py','.md','.csv','.json','.html','.png','.xlsx','.log','.txt','.dot','.pdf'}
rows=[]
for rel in roots:
 for p in sorted((source/rel).rglob('*')):
  if not p.is_file():continue
  path=p.relative_to(source);dest=ROOT/'research/1014'/path;name=p.name.lower()
  reason=''
  if name.startswith(('~$','._')) or '__pycache__' in p.parts:reason='runtime/cache'
  elif any(t in name for t in ['home-','home_','home.','homeg0','inbox','thread','receipt']) and ('home' in name or 'inbox' in name or 'thread' in name or name.startswith('manager') or name.startswith('handoff')):reason='live_Home_or_message_payload; not_research_artifact'
  elif p.suffix.lower() not in allow:reason='dataset_or_unapproved_format'
  elif name in ['dummy_id_register.csv']:reason='firm_level_identity_diagnostic_on_original_source_spine'
  if reason:
   rows.append(dict(path=str(path),status='excluded',reason=reason,sha256=''));continue
  sha=hashlib.sha256(p.read_bytes()).hexdigest();same=dest.exists() and hashlib.sha256(dest.read_bytes()).hexdigest()==sha
  if not same:dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,dest)
  rows.append(dict(path=str(path),status='already_present' if same else 'synchronized',reason='G0_code_documentation_or_screened_aggregate',sha256=sha))
# Current primary and curated worker history are G0-specific, not complete chat exports.
for rel in ['05-analysis/analytical-dag/dag/edges/word_rows/G0_build_main_dataset.do','agent-history/20260910-g0-variable-year-verification.md']:
 p=source/rel;dest=ROOT/'research/1014'/rel;dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,dest);rows.append(dict(path=rel,status='synchronized',reason='G0_primary_or_curated_history',sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
p=ROOT/'data/synthetic-development/g0-pipeline/contracts/g0-public-sync.csv'
with p.open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
print('G0 public sync:',{s:sum(x['status']==s for x in rows) for s in ['synchronized','already_present','excluded']})
