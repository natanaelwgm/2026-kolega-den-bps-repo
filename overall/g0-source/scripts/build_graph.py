"""Bind explicit physical source/state paths to declared .do-process edges."""
from pathlib import Path
import json,re,hashlib
R=Path(__file__).resolve().parents[1];O=R.parent/'G0-rebuild';D='dag/data/word_data/G0';P='dag/edges/word_rows/G0';Y=[2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022]
nodes=[];edges=[];latest={};version={}
def pathnorm(p):
 for a,b in {'$G0D':D,'$G0R':'dag/reports/word_data/G0','$VYD':D+'/variable_year','$VYR':'dag/reports/word_data/G0/20260910-code-verification','$VYL':'dag/logs/word_data/G0/variable_year','$WFROOT':str(R)}.items():p=p.replace(a,b)
 if p.startswith(str(R)+'/'):p=p[len(str(R))+1:]
 return p

def node(p,role=None,producer=None,parents=None,new=False):
 p=pathnorm(p)
 if p in latest and not new:return latest[p]
 version[p]=version.get(p,0)+1
 nid='N_'+hashlib.sha256((p+'#'+str(version[p])).encode()).hexdigest()[:20]
 role=role or ('validation_only' if p.startswith(str(O)) else 'company')
 nodes.append({'id':nid,'path':p,'role':role,'producer':producer,'parents':parents or [],'version':version[p]});latest[p]=nid;return nid

def add(id,script,ip,op,stage='upstream',kind='calculation',roles=None):
 ins=list(dict.fromkeys(node(x) for x in ip));outs=[node(x,(roles or {}).get(x),id,ins,True) for x in dict.fromkeys(op)]
 edges.append({'id':id,'path':script,'stage':stage,'inputs':ins,'outputs':outs,'kind':kind});return outs

def io(script):
 s=(R/script).read_text();ip=[];op=[]
 for l in s.splitlines():
  l=l.strip()
  if re.match(r'^(use |merge |append |import delimited |wf_merge_guard,)',l):
   q=re.findall(r'"([^\"]+)"',l)
   if q and not any(x in q[0] for x in ['`',"'"]):ip.append(pathnorm(q[0]))
  if re.match(r'^(save |export delimited )',l):
   q=re.findall(r'"([^\"]+)"',l)
   if q and not any(x in q[0] for x in ['`',"'"]):op.append(pathnorm(q[0]))
  if l.startswith('g0c_finish '):
   q=re.findall(r'"([^\"]+)"',l);op.append('corrections/data/'+q[1]+'.dta')
  if l.startswith('postfile ') and ' using "' in l:
   q=re.findall(r'using "([^\"]+)"',l)
   if q and '`' not in q[0]:op.append(pathnorm(q[0]))
 return list(dict.fromkeys(ip)),list(dict.fromkeys(op))

def auto(id,p,stage='upstream',extra=(),roles=None):
 i,o=io(p); internal=set(o);i=[x for x in i if x not in internal or x in latest];return add(id,p,i+list(extra),o,stage,roles=roles)
# Non-company static operands are explicit nodes. Historical comparators never feed calculations.
for e in json.loads((R/'registry/inputs.json').read_text())['inputs']:
 p=e['path']
 if e['role'] in ['metadata','reference']:
  rel=str(Path(p).relative_to(O));node(rel,e['role'])
 elif e['role']=='upstream_raw':node(p,'upstream_raw')
 elif e['role']=='validation_only':node(p,'validation_only')
ops=json.loads((R/'registry/leaf-operands.json').read_text())
for y in Y:auto(f'F010_{y}',f'code/annual/raw_{y}.do')
for y in Y:
 for a in [a for a in ops['mapped'] if a['year']==y]:add(a['id'],a['launcher'],[a['parent']],[a['artifact']])
 add(f'F030_{y}',f'code/annual/merge_mapped_{y}.do',[f'data/intermediate/raw_wave_{y}.dta']+[a['artifact'] for a in ops['mapped'] if a['year']==y],[f'data/intermediate/mapped_wave_{y}.dta'])
add('F040','code/stages/F040_append_intermediate.do',[f'data/intermediate/mapped_wave_{y}.dta' for y in Y],[D+'/G0_raw_fields_preserved.dta',D+'/variable_year/mapped_fields.dta'])
for n in ['03_map_economic_fields','04_validate_real_identifiers','05_map_geography_industry','06_stage_validate_deflators','07_validate_energy_units_factors','08_construct_energy_emissions','09_construct_ratios_logs']:
 auto('F050_'+n,f'{P}/G0_{n}.do')
add('F050_10',f'{P}/G0_10_assemble_main_dataset.do',[D+'/G0_raw_fields_preserved.dta']+[D+'/G0_'+p+'.dta' for p in ['derived_fields','identifier_fields','classification_fields','deflator_fields']],[D+'/G0_main_candidate.dta'])
add('F050_integrate',f'{P}/G0_integrate_verified_candidate.do',[D+'/G0_main_candidate.dta',D+'/variable_year/mapped_fields.dta'],[D+'/G0_main_verified_20260910.dta'])
add('F060_split_verified','code/stages/F060_working.do',[D+'/G0_main_verified_20260910.dta'],[f'data/intermediate/verified_wave_{y}.dta' for y in Y])
for a in ops['working']:add('F060_'+str(a['variable'])+'_'+str(a['year']),a['launcher'],[f'data/intermediate/verified_wave_{a["year"]}.dta']+a.get('additional_parents',[]),[a['artifact']])
for y in Y:add(f'F060_JOIN_{y}',f'code/annual/merge_working_{y}.do',[f'data/intermediate/verified_wave_{y}.dta']+[a['artifact'] for a in ops['working'] if a['year']==y],[f'{D}/analysis_tunnel/wave_{y}.dta'])
add('F060_finish','code/stages/F060_finish_working.do',[D+'/G0_main_verified_20260910.dta']+[f'{D}/analysis_tunnel/wave_{y}.dta' for y in Y],[D+'/G0_main_analysis_tunnel_20260910.dta',D+'/G0_main_candidate.dta'])
add('F070_identity_off',f'{P}/G0_publish_complete_identity_dataset.do',[D+'/G0_main_candidate.dta'],[D+'/identity-options/G0_identity_spine_off.dta',D+'/G0_analysis_ready.dta'])
add('F070_numeric',f'{P}/G0_local_prepare_numeric.do',[D+'/G0_analysis_ready.dta'],[D+'/G0_analysis_ready_ACTUAL_LOCAL.dta'])
# Metadata-only field ordering is an explicit additional operation on the same physical path.
add('F070_schema','code/stages/F070_baseline.do',[D+'/G0_analysis_ready_ACTUAL_LOCAL.dta'],[D+'/G0_analysis_ready_ACTUAL_LOCAL.dta'])
for rel in re.findall(r'^do "([^\"]+)"',(R/'code/stages/F080_corrections.do').read_text(),re.M):
 if Path(rel).name in ['init.do','_utils.do','G0_known_answer_fixtures.do']:continue
 auto('PREP_'+Path(rel).stem,rel)
master='data/analysis/G0_analysis_ready.dta';waves=[f'data/waves/wave_{y}.dta' for y in Y]
add('F085','code/stages/F085_publish_waves.do',['corrections/data/C140.dta'],waves,roles={x:'wave_ready' for x in waves})
add('F090_MASTER','code/stages/F090_append_ready.do',waves,[master],roles={master:'consolidated_ready'})
for p in ['code/reports/rebuild_legacy_coverage.do','code/reports/rebuild_source_counts.do','code/reports/rebuild_signed_thresholds.do']:auto('POST_'+Path(p).stem,p,'downstream')
# Utility expands outputs and schemas in-memory; numerical report methods have explicit input parents.
for rel in re.findall(r'^do "([^\"]+)"',(R/'code/stages/F090_reports.do').read_text(),re.M):
 if rel=='code/init.do' or rel.startswith('code/reports/rebuild_'):continue
 if 'C180_' in rel:
  reports=json.loads((O/'corrections/runtime/aggregate-output-manifest.json').read_text())['reports'];a=['corrections/reports/'+Path(e['path']).name for e in reports];add('POST_C180',rel,a,[x[:-4]+'.csv' for x in a],'downstream');continue
 auto('POST_'+Path(rel).stem,rel,'downstream')
# Dynamic dictionary helper writes one metadata table, not company rows; bind its ready-master parent.
if 'corrections/reports/dictionary_all_columns.dta' not in latest:
 add('POST_dictionary','rows/G0/publication/G0_support_dictionary.do',[master,'correction-planning/registries/publication_variable_year_release.csv'],['corrections/reports/dictionary_all_columns.dta','corrections/reports/variable_year_release_status.dta'],'downstream')
# Expand dynamic dictionary source ordering before export edges to avoid dangling producer snapshots.
# Every thirty-table CSV node must bind its actual DTA producer, even if utility save was indirect.
for e in edges:
 if e['id']=='POST_C180':
  paths={n['id']:n['path'] for n in nodes};e['inputs']=[latest[paths[x]] for x in e['inputs']]
  for n in nodes:
   if n['producer']==e['id']:n['parents']=e['inputs']
# Histogram numeric bin source retained as post-master process.
add('POST_histogram_bins',P+'/G0_report_histogram_bins.do',[master],['report/tables/histogram_'+v+'.csv' for v in ['ln_workers','ln_output_nominal','ln_total_gj_s1']],'downstream')
# Witness reads live only in validation-kind edges; validator outcomes never parent computation.
for st in json.loads((R/'registry/stages.json').read_text()):
 if st['id'].startswith('V'):
  s=(R/st['path']).read_text();ip=[]
  for q in re.findall(r'"([^\"]+\.dta)"',s):ip.append(pathnorm(q))
  add(st['id'],st['path'],ip,['validation/'+st['id']+'.receipt'],'validation','validation',{'validation/'+st['id']+'.receipt':'validation_only'})
(R/'registry/dag.json').write_text(json.dumps({'version':2,'nodes':nodes,'edges':edges,'boundary':'one consolidated_ready master; wave_ready children are upstream preparation; old data only validation'},indent=2)+'\n')
print(json.dumps({'nodes':len(nodes),'edges':len(edges),'masters':sum(n['role']=='consolidated_ready' for n in nodes),'waves':sum(n['role']=='wave_ready' for n in nodes)}))
