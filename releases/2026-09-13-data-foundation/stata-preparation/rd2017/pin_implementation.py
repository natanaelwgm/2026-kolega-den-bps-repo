#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
H=Path(__file__).resolve().parent;F=H.parent
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
files=[p for p in H.rglob('*') if p.is_file() and not p.name.startswith('run_RD17_owned_') and (p.suffix in ['.py','.do'] or p.parent==H/'inputs' or p.name in ['output-contract.json','dag.json']) and not any(x in p.relative_to(H).parts for x in ['runtime','scratch','__pycache__','implementation-review','history'])]
m={'status':'IMPLEMENTED_NOT_EXECUTED','plan_freeze_sha256':sha(F/'plan-freeze.json'),'historical_method_plan_sha256':'09fea871f963451f6ee3699fac55ab0cd5ea02129875c3b8e186e7136197e3bd','process_children':11,'original_fixture_cases':61,'extra_guard_rows':13,'strict_literal_rows':49,'canonical_bridge_parity_rows':48,'canonical_bridge_expected_rejection_rows':1,'output_pairs':12,'extra_validation_pairs':['fixtures/guard_results','validation/equivalence'],'company_construction_parent':'../data/analysis/G0_analysis_ready.dta','files':[{'path':str(p.relative_to(H)),'sha256':sha(p),'bytes':p.stat().st_size} for p in sorted(files)]}
m['external_code_files']=[{'path':rel,'sha256':sha(F/rel),'bytes':(F/rel).stat().st_size} for rel in ['code/logging/__wf_progress.ado','scripts/live_relay.py','implementation-manifest.json']]
m['stata_sha256']=sha('/Applications/Stata/StataSE.app/Contents/MacOS/stata-se')
m['logging_contract']={'helper':'../code/logging/__wf_progress.ado','state_prefix':'WFLOG_','resolution_seconds':1,'batch_relay':'unique owned filename; exact byte relay after actual PID exit','scientific_do_files_changed_by_runner_adaptation':False}
(H/'implementation-manifest.json').write_text(json.dumps(m,indent=2)+'\n');print(sha(H/'implementation-manifest.json'))
