"""Describe high-level executed edges alongside the already materialized annual node contracts."""
from pathlib import Path
import csv,json
P=Path(__file__).resolve().parent
read=lambda p:list(csv.DictReader(p.open()))
items=[]
for m in read(P/'contracts/input-manifest.csv'):
 filename=Path(m['path']).name;old='si2010' in filename and 'sampel' not in filename
 if m['role']=='classification_reference_no_firm_observations':stem='reference_'+Path(filename).stem;output='dag/data/references/'+Path(filename).stem+'.dta';grain='supplied classification reference row'
 else:
  year=2010 if old else int(filename.split('mfg')[1][:4]);stem='old_si2010_reference' if old else f'sample_mfg{year}_raw';output=f'dag/data/staged/{stem}.dta';grain='source_year/source_row'
 items.append(dict(node='N_import_'+stem,edge=f'dag/edges/import/{stem}.do',inputs=m['path'],output=output,grain=grain,rows=m['rows']))
outputs=['G0_raw_fields_preserved.dta','G0_raw_fields_preserved.dta','G0_economic_fields.dta','G0_identifier_fields.dta','G0_classification_fields.dta','G0_deflator_fields.dta','G0_energy_fields.dta','G0_energy_emissions.dta','G0_derived_fields.dta','G0_main_candidate.dta']
for n in range(1,11):
 edge=next((P/'dag/edges/word_rows/G0').glob(f'G0_{n:02}_*.do'))
 items.append(dict(node=f'N_base_{n:02}',edge=str(edge.relative_to(P)),inputs='annual synthetic states / explicit parent states in edge',output='dag/data/word_data/G0/'+outputs[n-1],grain='source_year/source_row',rows=1200))
for name,edge,output,rows in [('readable_charts','dag/edges/word_rows/G0/G0_render_verified_charts.do','dag/reports/word_data/G0/20260910-code-verification/indicator_coverage.png','verified annual coverage'),('checks','dag/edges/word_rows/G0/G0_12_validate.do','dag/logs/G0_build_synthetic_dataset_complete.log','domain/boundary cases plus 1200 records'),('annual_integration','dag/edges/word_rows/G0/G0_verify_variable_year.do','dag/data/word_data/G0/variable_year/mapped_fields.dta',1200),('corrections','dag/edges/word_rows/G0/G0_integrate_verified_candidate.do','dag/data/word_data/G0/G0_main_verified_20260910.dta',1200),('working_integration','dag/edges/word_rows/G0/G0_publish_analysis_tunnel.do','dag/data/word_data/G0/G0_main_candidate.dta',1200),('fixture_identity','dag/edges/G0_preserve_fixture_identity.do','results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta',1200),('final_validation','dag/edges/G0_validate_synthetic_final.do','results/coverage_by_variable_year.csv',45516),('workbook','publish.py','results/G0_analysis_ready_SYNTHETIC_CALCULATED.xlsx',1200)]:
 items.append(dict(node='N_'+name,edge=edge,inputs='explicit parent states in edge; synthetic only',output=output,grain='variable/year' if name=='final_validation' else 'source_year/source_row or validation state',rows=rows))
for name,edge,output,grain in [
 ('wpi_workbook_audit','inspect_wpi_reference.py','results/wpi_workbook_audit.json','year/subsector/month; supplied actual macro reference'),
 ('row0_status','describe_wpi_preparation.py','results/ROW0-STATUS.md','original Word component and variable/year'),
 ('wpi_reference','dag/edges/wpi/G0_stage_wpi.do','dag/data/references/WPI_output_lookup.dta','isic4/source_year; actual reference index'),
 ('wpi_application','dag/edges/wpi/G0_apply_wpi.do','dag/data/word_data/G0/G0_wpi_applied.dta','source_year/source_row; synthetic companies'),
 ('preparation_gaps','dag/edges/G0_finish_preparation_gaps.do','dag/data/word_data/G0/G0_preparation_completed.dta','source_year/source_row; synthetic companies'),
 ('adversarial_cases','dag/edges/G0_test_preparation_cases.do','dag/logs/G0_adversarial_cases.log','1002 controlled cases plus merge/domain fixtures')]:
 items.append(dict(node='N_'+name,edge=edge,inputs='WPI reference or synthetic source state; see edge and contracts',output=output,grain=grain,rows='see validated controls'))
for r in items:
 assert (P/r['edge']).exists() and (P/r['output']).exists(),r
 n=P/'dag/nodes'/r['node'];n.mkdir(exist_ok=True)
 (n/'triage.md').write_text('# PASS — executed synthetic process\n\nOutput exists after full primary success and independent publication checks. Reopen on source, rule or schema changes.\n')
 (n/'decision.md').write_text('# Synthetic input/output and grain contract\n\n'+json.dumps(r,indent=2)+'\n\nOnly authorized synthetic company inputs and actual macro WPI references. Source definitions/availability caveats remain visible; this status establishes execution, not genuine company evidence. See primary transcript and README.\n')
with (P/'results/process_registry.csv').open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(items[0]));w.writeheader();w.writerows(items)
print('Process contracts',len(items))

# Pipeline-owned ledgers; no manager/shared registry edits.
reg=P/'dag/registries';reg.mkdir(exist_ok=True)
allnodes=items+read(P/'results/executed_node_registry.csv')
triage=[];decisions=[]
for r in allnodes:
 triage.append(dict(node=r['node'],status='executed_with_source_limits',grain=r['grain'],reopen_rule='input_hash_rule_change_or_failed_assertion',decision='dag/nodes/'+r['node']+'/decision.md'))
 decisions.append(dict(node=r['node'],edge=r['edge'],output=r['output'],evidence='dag/nodes/'+r['node']+'/decision.md',primary_receipt='dag/logs/G0_build_synthetic_dataset_complete.log'))
for name,rows in [('triage_ledger.csv',triage),('decision_evidence_ledger.csv',decisions)]:
 with (reg/name).open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
(P/'dag/TRIAGE_LEDGER.md').write_text('# G0 pipeline-owned triage\n\n'+str(len(triage))+' process/annual nodes indexed in registries/triage_ledger.csv. Executed is not source completeness. WPI, energy and original-data limitations are explicit in ../WPI-INTEGRATION.md and ../results/ROW0-STATUS.md. Reopen only on source/rule/schema change or failed assertion. Manager shared registries unchanged.\n')
