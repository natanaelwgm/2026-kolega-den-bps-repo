from pathlib import Path
import json,csv
R=Path(__file__).resolve().parents[2];D=R/'downstream'
a={x['name']:x for x in json.loads((D/'contracts/source_schema_actual.json').read_text())};g={x['name']:x for x in json.loads((D/'contracts/source_schema_development.json').read_text())}
explicit='''gross_output_nominal value_added_nominal intermediate_inputs_nominal workers production_workers capital_stock_nominal capital_additions_nominal capital_stock_verified capital_additions_verified capital_definition_status inputs_definition_status rd_cost_nominal rd_cost_definition_status rd_workers rd_indicator_raw rd_activity_flag rd_external_funding_flag innovation_flag innovation_product_flag innovation_process_flag innovation_marketing_flag innovation_org_flag export_share_pct export_flag export_direct_flag export_any_binary export_observed export_share_valid export_binary_valid export_verified_conflict export_definition_status import_value_nominal import_flag import_observed foreign_ownership_pct fdi_any_flag fdi_10_flag fdi_observed large_gt100_flag val_rtlvcu val_zpsvcu val_znsvcu env_amdal_flag env_ukl_upl_flag env_sppl_flag env_waste_treatment_flag waste_solid_flag waste_liquid_flag waste_hazardous_flag energy_expenditure_rp000 electricity_expenditure_rp000 fuel_expenditure_rp000 fuel_expenditure_basis energy_cost_reported_n energy_exp_observed_repaired energy_cost_reported_partial energy_cost_reported_complete energy_all_sources_complete energy_unit_gap_2018_19 energy_coverage_status energy_outlier_flag own_gen_source_state own_gen_observed_valid own_gen_positive_reported own_gen_unknown own_generation_reported own_generation_added any_negative_quantity any_implausible_price any_negative_observed any_negative_decision n_quantity_tests n_quantity_unknown all_applicable_tests_observed coal_unit_verified coal_source_unit nine_fuels_complete electricity_n_observed grid_factor_s1 grid_factor_s2 grid_factor_is_carried factor_status factor_contract unit_status money_unit_status classification_status deflator_applied deflator_status deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real wpi_company_bridge_verified va_source_state va_signed_eligible va_missing_reason va_signed_nominal va_signed_per_worker va_log_positive va_abs_tail_flag va_signed_tail_sensitivity va_share_output_repaired ei_money_output_repaired ei_gj_output_repaired ci_co2_output_repaired accounting_gap accounting_identity_valid total_gj_s1 total_gj_complete total_gj_clean_sensitivity'''.split()
# Retain concrete source feature families; no inherited raw layouts, deprecated mixed-capital aliases or hundreds of duplicate logs.
selected=set(explicit)
for n in a:
 if n.startswith(('fuel_','elec_','co2_','gj_','qs_','qn_')):selected.add(n)
 if n.startswith('r_') and not n.startswith(('r_ln_val_','r_pw_val_')):selected.add(n)
for n in list(selected):
 for prefix in ['vs_','st_','v_']:
  if prefix+n in a:selected.add(prefix+n)
selected.discard('co2_per_worker');selected.discard('co2_intensity_nominal') # repaired versions retained
selected={n for n in selected if n in a or n in g}
for n in ['r_capital_per_worker_nominal','r_ln_capital_nominal','r_ln_capital_nominal_state'] :selected.discard(n)
def family(n):
 if n.startswith(('vs_','st_','v_','qs_','qn_')):return 'quality'
 if n.startswith('dev_nominal_'):return 'G1'
 if any(t in n for t in ['fuel','elec','energy','co2','gj','grid','factor','own_gen','coal']):return 'energy_environment'
 if any(t in n for t in ['export','import','fdi','foreign']):return 'trade_ownership'
 if any(t in n for t in ['rd_','innovation','env_','waste']):return 'innovation_environment'
 if any(t in n for t in ['status','verified','deflator','unit','wpi','state','eligible','observed','n_quantity','negative','accounting']):return 'quality'
 return 'economic'
records=[]
for n in sorted(selected|{n for n in g if n.startswith('dev_nominal_')}):
 x=a.get(n,g.get(n));label=x['label'] or n.replace('_',' ')
 records.append({'name':n,'family':family(n),'source_field':n,'actual_available':n in a,'development_available':n in g,'string':x['type'].isdigit() or x['type']=='Q','label':label,'unit':'state/status; see source dictionary' if family(n)=='quality' else 'inherited source unit; see variable-year evidence; no new unit admission','claim':'development nominal estimate only' if n.startswith('dev_nominal_') else 'source values preserved; eligibility depends on variable/year evidence'})
(D/'contracts/fields.json').write_text(json.dumps(records,indent=2)+'\n')
with (D/'contracts/variable_dictionary.csv').open('w') as f:
 w=csv.DictWriter(f,fieldnames=list(records[0]));w.writeheader();w.writerows(records)
# Direct source projections generated from a checked metadata inventory. Same schema in both outputs.
for mode,inventory in [('actual',a),('development',g)]:
 needed=['source_year']+(['source_row','selected_firm_id','identity_real_link_verified','real_panel_ready'] if mode=='actual' else ['obs_id','psid','psid_status','dev_panel_stratum','dev_prev_obs_id','dev_prev_year','dev_link_status'])+['province_code','district_code','industry_code']+[x['name'] for x in records if x[mode+'_available']]
 assert all(n in inventory for n in needed),(mode,[n for n in needed if n not in inventory])
 (D/f'code/fields_{mode}.do').write_text('global DS_FIELDS "'+' '.join(needed)+'"\n')
 (D/f'code/missing_{mode}.do').write_text('\n'.join(('generate str1 ' if x['string'] else 'generate double ')+x['name']+('=""' if x['string'] else '=.') for x in records if not x[mode+'_available'])+'\n')
(D/'code/labels.do').write_text('\n'.join('label variable '+x['name']+' "'+x['label'].replace('"',"'").replace('`','').replace('$','')[:79]+'"' for x in records)+'\n')
print('selected',len(records),'actual',sum(x['actual_available'] for x in records),'dev',sum(x['development_available'] for x in records))
# Store every source field in a searchable catalogue without copying the large masters.
with (D/'contracts/full_source_catalogue.csv').open('w') as f:
 w=csv.writer(f);w.writerow(['source_mode','name','storage','label','in_clean_output'])
 for mode,inv in [('actual',a),('development',g)]:
  for n,x in inv.items():w.writerow([mode,n,x['type'],x['label'],n in {x['name'] for x in records}])
# Preserve all 44 original task contracts; do not promote plan status to empirical acceptance.
plans=[];deps=[];req=[]
for p in sorted((R/'releases/2026-09-13-data-foundation/stata-preparation/row-plans').glob('*.json')):
 j=json.loads(p.read_text())
 if 'row_id' not in j:continue
 plans.append({'row_id':j['row_id'],'title':j['title'],'family':j['family'],'unit_of_analysis':str(j['unit_of_analysis']),'source_plan':str(p.relative_to(R)),'plan_status':j['status'],'primary_empirical_ready':False,'assessment':'Dataset supports development; task-specific dependency admission remains required','blocker_count':len(j.get('current_blockers',[]))})
 for dep in j.get('dependencies',[]):deps.append({'row_id':j['row_id'],**dep})
 for node in j['nodes']:
  for field in node.get('required_fields',[]):req.append({'row_id':j['row_id'],'node':node['id'],'field':field,'kind':'plan state requirement; may describe an intermediate or result, not necessarily a master column','exact_clean_field':field in selected or field in ['obs_id','source_year','province_code','district_code','industry_code'],'exact_source_field':field in a or field in g})
for name,rows in [('downstream_plans',plans),('downstream_fields',req)]:
 with (D/f'contracts/{name}.csv').open('w') as f:
  w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
(D/'contracts/downstream_dependencies.json').write_text(json.dumps(deps,indent=2)+'\n')
print('plans',len(plans),'dependency records',len(deps),'required field references',len(req))
