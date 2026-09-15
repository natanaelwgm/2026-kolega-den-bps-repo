#!/usr/bin/env python3
"""Read hash/schema metadata only; canonical data are classified by Stata."""
from pathlib import Path
import hashlib,json
from datetime import datetime,timezone
import pandas as pd
H=Path(__file__).resolve().parent;F=H.parent;R=F.parent.parent
HISTORY=R/'work/G0-RD2017-phase-B-execution'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def pin(p):
 p=Path(p);return {'path':str(p),'sha256':sha(p),'bytes':p.stat().st_size}
def resolve_foundation(path):
 p=Path(path);p=p if p.is_absolute() else F/p
 p=p.resolve();assert p.is_relative_to(F),p
 return p
def validate(master_receipt):
 receipt_path=Path(master_receipt).resolve();assert receipt_path==F/'runtime/latest.json'
 rec=json.loads(receipt_path.read_text())
 assert rec['status']=='passed' and rec['owned_process_exited'] and rec['exit_code']==0 and rec['success_marker_present']
 assert rec['pid']>0 and rec['schema_comparison_status']=='passed'
 freeze=F/'plan-freeze.json';f=json.loads(freeze.read_text());assert f['status']=='READY_FOR_IMPLEMENTATION'
 assert rec['plan_freeze_sha256']==sha(freeze)
 for e in f['files']:assert sha(e['path'])==e['sha256']
 assert rec['implementation_manifest_sha256']==sha(F/'implementation-manifest.json')
 wave=F/'data/analysis/G0_analysis_ready.dta'
 outputs=rec['output_hashes'];assert len({e['path'] for e in outputs})==len(outputs)
 matches=[e for e in outputs if resolve_foundation(e['path'])==wave];assert len(matches)==1
 assert sha(wave)==matches[0]['sha256'] and wave.stat().st_size==matches[0]['bytes']
 # Recheck every declared producer output before using its passed status.
 for e in outputs:
  p=resolve_foundation(e['path']);assert sha(p)==e['sha256'] and p.stat().st_size==e['bytes']
 wm=F/'runtime/wave-output-manifest.json';assert wm.is_file()
 impl=H/'implementation-manifest.json';im=json.loads(impl.read_text());assert im['plan_freeze_sha256']==sha(freeze)
 for e in im['files']:assert sha(H/e['path'])==e['sha256']
 with pd.read_stata(wave,iterator=True,convert_categoricals=False) as sr:
  sr.variable_labels();assert sr._nobs==33049 and sr._nvar==4593
  types={'source_year':'h','source_row':'h','raw_rnd17':1,'raw_costrd17':1,'rd_indicator_raw':'d','val_costrd':'d','vs_rd_indicator_raw':'b','vs_val_costrd':'b','rd17_own_token_class':6,'rd17_external_token_class':6}
  for n,t in types.items():assert sr._typlist[sr._varlist.index(n)]==t,(n,t)
 pins=[pin(x) for x in [receipt_path,freeze,F/'implementation-manifest.json',wm,wave,impl]]
 pins += [pin(H/e['path']) for e in im['files']]
 history_inputs=json.loads((H/'inputs/historical-validation-inputs.json').read_text())
 for e in history_inputs['files']:
  assert sha(e['path'])==e['sha256'];pins.append(e)
 out={'status':'passed','checked_utc':datetime.now(timezone.utc).isoformat(),'company_values_decoded':False,'master_rows':33049,'master_columns':4593,'master_receipt':pin(receipt_path),'master':pin(wave),'plan_freeze_sha256':sha(freeze),'historical_method_plan_sha256':'09fea871f963451f6ee3699fac55ab0cd5ea02129875c3b8e186e7136197e3bd','implementation_manifest_sha256':sha(impl),'files_checked':pins,'historical_inputs_role':'Validator only; never construction parents'}
 (H/'runtime/preflight.json').write_text(json.dumps(out,indent=2)+'\n')
 (H/'runtime/preflight_pass.do').write_text('version 17\nglobal RD17_HISTORY "'+str(HISTORY)+'"\nassert 1==1\ndisplay "RD17_MASTER_PREFLIGHT_PINNED_METADATA_PASS"\n')
 return out
if __name__=='__main__':
 import argparse
 p=argparse.ArgumentParser();p.add_argument('--master-receipt',required=True);a=p.parse_args();o=validate(a.master_receipt);print(json.dumps({'status':o['status'],'master_rows':o['master_rows'],'master_columns':o['master_columns'],'company_values_decoded':False}))
