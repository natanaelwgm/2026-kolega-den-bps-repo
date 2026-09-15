"""Bounded static inventory of reachable literal Stata children and execution boundary."""
from pathlib import Path
import re,json,hashlib
P=Path(__file__).resolve().parent
queue=[P/'G0_build_synthetic_dataset.do'];seen=set();est=[];random=[];outside=[];edges=[]
while queue:
 p=queue.pop()
 if p in seen:continue
 seen.add(p);text=p.read_text();edges.append(dict(path=str(p.relative_to(P)),sha256=hashlib.sha256(p.read_bytes()).hexdigest()))
 for line in text.splitlines():
  line=line.strip()
  if not line or line.startswith(('*','//')):continue
  if re.match(r'(?:qui(?:etly)?\s+)?(?:reg(?:ress)?|xtreg|prodest|acfest|opreg|ivregress|reghdfe|didregress)\b',line):est.append(str(p.relative_to(P))+': '+line)
  if re.search(r'\b(?:runiform|rnormal|set seed)\b',line):random.append(str(p.relative_to(P))+': '+line)
  m=re.match(r'do\s+"([^"\n]+\.do)"',line)
  if m:
   name=m[1]
   if name.startswith('`root\'/'):name=name[len('`root\'/'):]
   child=P/name
   if child.is_file():queue.append(child)
   else:outside.append({'file':str(p.relative_to(P)),'unresolved_child':name})
  if re.match(r'(use|import (excel|delimited))\b',line) and re.search(r'/Users/|/Volumes/|data/raw/|original_company|SYNTHETIC_SCHEMA',line):outside.append({'file':str(p.relative_to(P)),'outside_read':line})
assert not est and not random and not outside,(est,random,outside)
result={'primary':'G0_build_synthetic_dataset.do','reachable_stata_files':len(seen),'outside_original_data_reads':outside,'estimator_commands':est,'random_linkage_commands':random,'actual_macro_reference_allowed':'references/toar-wpi-20260910','scope':'literal do-call/static boundary inventory; actual execution established separately by primary and per-node logs','files':sorted(edges,key=lambda x:x['path'])}
(P/'results/execution-scope-audit.json').write_text(json.dumps(result,indent=2));print('Reachable Stata files:',len(seen),'boundary PASS')
