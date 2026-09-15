from pathlib import Path
import json,re
R=Path(__file__).resolve().parents[1];D='dag/data/word_data/G0'
ops=json.loads((R/'registry/leaf-operands.json').read_text())
for a in ops['working']:
 if a['variable']=='innovation_flag' and a['year'] in [2017,2018]:
  p=R/a['launcher'];s=p.read_text();lines=[];deps=[]
  for v in ['innovation_product_flag','innovation_process_flag','innovation_marketing_flag','innovation_org_flag']:
   dep=f'{D}/analysis_tunnel/N_G0_tunnel_{v}_{a["year"]}.dta';deps.append(dep)
   lines += [f'capture drop {v}', f'capture drop vs_{v}',f'merge 1:1 source_year source_row using "{dep}", assert(match) nogen keepusing({v} vs_{v})']
  s=s.replace('tempfile metrics\n','\n'.join(lines)+'\ntempfile metrics\n');p.write_text(s);a['additional_parents']=deps
(R/'registry/leaf-operands.json').write_text(json.dumps(ops,indent=2)+'\n')
# Follow exact original scalar method, requiring an explicit current baseline.
p=R/'dag/edges/word_rows/G0/G0_integrate_verified_candidate.do';s=p.read_text();s=re.sub(r'^if .*local baseline "dag/data/word_data/G0/G0_main_accepted_20260909.dta"$', 'if `"`baseline\'"\'=="" {\n display as error "WF_EXPLICIT_REGENERATED_BASELINE_REQUIRED"\n exit 198\n}',s,flags=re.M);p.write_text(s)
# Distinct owned batch basename avoids stale log success or cross-task collisions.
p=R/'run_guarded.py';s=p.read_text().replace('entry=R/f\'run_{st["id"]}.do\'','entry=R/f\'run_WF_{runid}_{st["id"]}.do\'').replace('batch=R/f\'run_{st["id"]}.log\'','batch=entry.with_suffix(".log")\n   assert not batch.exists() and not (Path("/private/tmp")/batch.name).exists(), "Owned batch log collision"');p.write_text(s)
