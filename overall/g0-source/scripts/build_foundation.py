"""Generate an isolated, explicit file-to-file wave pipeline. No Stata execution."""
from pathlib import Path
import csv,hashlib,json,re,shutil,datetime
ROOT=Path(__file__).resolve().parents[1]; OLD=ROOT.parent/'G0-rebuild'
YEARS=[2010,2011,2012,2013,2014,2015,2017,2018,2019,2020,2021,2022]
P=Path('dag/edges/word_rows/G0');D='dag/data/word_data/G0'
nodes={};edges=[];inputs={};patches=[]
def sha(p):
 h=hashlib.sha256()
 with Path(p).open('rb') as f:
  for b in iter(lambda:f.read(1024*1024),b''):h.update(b)
 return h.hexdigest()
def put(path,s):
 p=ROOT/path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s);return str(path)
def pin(p,role):
 p=Path(p);inputs[str(p)]={'path':str(p),'sha256':sha(p),'bytes':p.stat().st_size,'role':role}
def node(path,role='company',producer=None,parents=()):
 path=str(path);nid='N_'+hashlib.sha256(path.encode()).hexdigest()[:20]
 v={'id':nid,'path':path,'role':role,'producer':producer,'parents':list(parents)}
 if nid in nodes:
  if producer and nodes[nid]['producer'] is None:nodes[nid].update(v)
 else:nodes[nid]=v
 return nid
def edge(eid,path,ins,outs,stage='upstream',kind='calculation',outrole='company'):
 ii=[node(x) if isinstance(x,str) else x for x in ins]
 oo=[node(x,outrole,eid,ii) for x in outs]
 edges.append({'id':eid,'path':path,'stage':stage,'kind':kind,'inputs':ii,'outputs':oo});return oo

def copy_code(rel,transform=None,reason='root isolation; numerical expressions unchanged'):
 src=OLD/rel;original=src.read_text();s=original.replace(str(OLD),str(ROOT))
 if transform:s=transform(s)
 put(rel,s);pin(src,'source_code')
 if s!=original:patches.append({'path':str(rel),'source_sha256':sha(src),'new_sha256':sha(ROOT/rel),'reason':reason})
 return s

def trim_graphs(s):
 result=[];skip=False
 for no,l in enumerate(s.splitlines(),1):
  if skip:
   skip=l.rstrip().endswith('///');continue
  if re.match(r'^\s*(graph\s|twoway\s|histogram\s|set scheme\s)',l):
   skip=l.rstrip().endswith('///');continue
  result.append(l)
 return '\n'.join(result)+'\n'

freeze=json.loads((ROOT/'plan-freeze.json').read_text());assert freeze['status']=='READY_FOR_IMPLEMENTATION'
for r in freeze['files']:assert sha(r['path'])==r['sha256'],r
for d in ['registry','runtime','scratch','data/intermediate','data/waves','data/analysis','report/evidence','report/tables','report/figures','corrections/data','corrections/logs','corrections/reports','corrections/metadata','corrections/runtime','dag/data/word_data/G0/variable_year','dag/data/word_data/G0/analysis_tunnel','dag/data/word_data/G0/identity-options','dag/logs/word_data/G0/variable_year','dag/logs/word_data/G0/analysis_tunnel','dag/logs/word_data/G0/identity-options','dag/reports/word_data/G0/20260910-code-verification','dag/reports/word_data/G0/identity-options','references','validation']:(ROOT/d).mkdir(parents=True,exist_ok=True)
put('code/init.do',f'''version 17\nset more off\nset varabbrev off\nif c(maxvar)<10000 {{\n clear\n set maxvar 10000\n}}\nglobal WFROOT "{ROOT}"\ncd "$WFROOT"\nglobal G0D "{D}"\nglobal G0R "dag/reports/word_data/G0"\nglobal G0L "dag/logs/word_data/G0"\nglobal VYD "{D}/variable_year"\nglobal VYL "dag/logs/word_data/G0/variable_year"\nglobal VYR "dag/reports/word_data/G0/20260910-code-verification"\n''')
# Copy operative non-company metadata and references; no historical company result is copied.
cm=json.loads((OLD/'corrections/runtime/code-manifest.json').read_text())
for r in cm['inputs']:
 rel=r['path']
 if rel.startswith('corrections/metadata/') or rel=='references/WPI_output_lookup.dta':
  assert sha(OLD/rel)==r['sha256'];(ROOT/rel).parent.mkdir(parents=True,exist_ok=True);shutil.copy2(OLD/rel,ROOT/rel);pin(OLD/rel,'reference' if rel.endswith('.dta') else 'metadata');node(rel,'reference' if rel.endswith('.dta') else 'metadata')
for sub in ['correction-planning/registries']:
 for src in (OLD/sub).glob('*'):
  if src.is_file() and src.suffix in ['.csv','.json']:
   rel=src.relative_to(OLD);(ROOT/rel).parent.mkdir(parents=True,exist_ok=True);shutil.copy2(src,ROOT/rel);pin(src,'metadata');node(str(rel),'metadata')
# Header metadata is a comparator contract only, never a source of empirical values.
states=json.loads((OLD/'corrections/runtime/state-output-manifest.json').read_text())['states']
baseschema=next(x['schema'] for x in states if x['state_id']=='C000');fullschema=next(x['schema'] for x in states if x['state_id']=='C140')
put('registry/baseline-schema.json',json.dumps(baseschema,indent=2)+'\n');put('registry/corrected-schema.json',json.dumps(fullschema,indent=2)+'\n')
basefields=[x['name'] for x in baseschema['fields']];fullfields=[x['name'] for x in fullschema['fields']];assert len(basefields)==3824 and len(fullfields)==4591
put('code/order_baseline.do','order '+' '.join(basefields)+'\n')
# Actual mapped leaf method order from the executed annual driver.
orig=(OLD/P/'G0_verify_variable_year.do').read_text();yearleaves={y:[] for y in YEARS}
for rel in re.findall(r'do "(dag/edges/word_rows/G0/variable_year/[^\"]+\.do)"',orig):
 y=int(Path(rel).stem[-4:]);yearleaves[y].append(rel)
assert sum(map(len,yearleaves.values()))==2796 and all(len(v)==233 for v in yearleaves.values())
rawentry=[];mapentry=[];leafspec=[];comparisons=[]
for y in YEARS:
 rawsrc=OLD/f'dag/data/staged/sample_mfg{y}_raw.dta';pin(rawsrc,'upstream_raw');node(str(rawsrc),'upstream_raw')
 rawout=f'data/intermediate/raw_wave_{y}.dta'; rel=f'code/annual/raw_{y}.do'
 put(rel,f'do "code/init.do"\nuse "{rawsrc}", clear\nassert source_year=={y}\nisid source_year source_row\nsave "{rawout}", replace\n')
 edge(f'F010_{y}',rel,[str(rawsrc)],[rawout]);rawentry.append(f'do "{rel}"')
 merged=f'data/intermediate/mapped_wave_{y}.dta'; merges=[f'do "code/init.do"',f'use "{rawout}", clear',f'assert source_year=={y}','isid source_year source_row']
 for src_rel in yearleaves[y]:
  body=copy_code(src_rel); stem=Path(src_rel).stem;var=stem[:-5]; keep=re.findall(r'^keep (.+)$',body,re.M)[-1].split(); raw=[f for f in keep if f.startswith('raw_')]; raw_inputs=list(dict.fromkeys(raw+re.findall(r'\braw_[A-Za-z0-9_]+\b',body)))
  leafout=re.findall(r'^save "([^\"]+)"',body,re.M)[-1].replace('$VYD',D+'/variable_year');leafold=OLD/leafout;pin(leafold,'validation_only');node(str(leafold),'validation_only');comparisons.append((leafout,str(leafold)))
  wrapper=f'code/leaves/mapped/{stem}.do'
  # Each real leaf loads its own explicit narrow raw parent; no caller data or postfile required.
  s=f'do "code/init.do"\nuse source_year source_row '+ ' '.join(raw_inputs)+f' using "{rawout}", clear\nassert source_year=={y}\nisid source_year source_row\ntempfile metrics\ncapture postclose cell\npostfile cell int year str32 field long rows observed zeros invalid source_absent using `metrics\', replace\ndo "{src_rel}"\npostclose cell\n'
  put(wrapper,s);edge('F020_'+stem,wrapper,[rawout],[leafout]);mapentry.append(f'do "{wrapper}"')
  added=[f for f in keep if f not in raw+['source_year','source_row']]
  # Check raw overlap explicitly via a separate narrow invariant fixture before merge.
  if raw:
   merges += ['preserve','keep source_year source_row '+' '.join(raw),f'cf _all using "{leafout}", all','restore']
  merges.append(f'merge 1:1 source_year source_row using "{leafout}", assert(match) nogen keepusing('+ ' '.join(added)+')')
  leafspec.append({'id':'F020_'+stem,'year':y,'variable':var,'parent':rawout,'raw_fields':raw_inputs,'retained_raw_fields':raw,'outputs':added,'artifact':leafout,'method':src_rel,'launcher':wrapper,'execution':'rebuild'})
 merges += ['isid source_year source_row',f'save "{merged}", replace']
 rel=f'code/annual/merge_mapped_{y}.do';put(rel,'\n'.join(merges)+'\n');edge(f'F030_{y}',rel,[rawout]+[x['artifact'] for x in leafspec if x['year']==y],[merged]);mapentry.append(f'do "{rel}"')
put('code/stages/F010_raw.do','\n'.join(rawentry)+'\ndisplay "WF_STAGE_F010_PASS"\n')
put('code/stages/F030_mapped.do','\n'.join(mapentry)+'\ndisplay "WF_STAGE_F030_PASS"\n')
# Append assembled annual files; projections, never staged raw append.
s=['do "code/init.do"',f'use "data/intermediate/mapped_wave_{YEARS[0]}.dta", clear']+[f'append using "data/intermediate/mapped_wave_{y}.dta"' for y in YEARS[1:]]+['isid source_year source_row','assert _N==33049','assert source_year!=2016','preserve']
# Raw projection exact retained names; source key and metadata also survive as in original raw append.
s+=['drop '+ ' '.join(dict.fromkeys(f for x in leafspec if x['year']==2010 for f in x['outputs'])) ,f'save "{D}/G0_raw_fields_preserved.dta", replace','restore']
# All mapping vars (including absent year fields) follow historical keep projection; order may later be normalized by metadata contract.
lastkeep=re.findall(r'^keep (.+)$',orig,re.M)[-1]
s += ['keep '+lastkeep,f'save "{D}/variable_year/mapped_fields.dta", replace','display "WF_STAGE_F040_PASS"']
put('code/stages/F040_append_intermediate.do','\n'.join(s)+'\n');edge('F040','code/stages/F040_append_intermediate.do',[f'data/intermediate/mapped_wave_{y}.dta' for y in YEARS],[D+'/G0_raw_fields_preserved.dta',D+'/variable_year/mapped_fields.dta'])
# Numeric legacy preparation: explicit bounded original code closure, no old launcher/graphs.
legacy_names=['G0_03_map_economic_fields.do','G0_04_validate_real_identifiers.do','G0_05_map_geography_industry.do','G0_06_stage_validate_deflators.do','G0_07_validate_energy_units_factors.do','G0_08_construct_energy_emissions.do','G0_09_construct_ratios_logs.do','G0_10_assemble_main_dataset.do','G0_integrate_verified_candidate.do','G0_publish_complete_identity_dataset.do','G0_load_identity_view.do','G0_select_identity_mode.do','G0_refresh_preparation_actual.do']
for n in legacy_names:copy_code(P/n,trim_graphs,'isolated root; explicit numerical body retained; graph commands excluded')
copy_code('dag/edges/G0_economic_clean_program.do')
# Retain the original baseline-generation numerical prefix only; tables happen after ready waves.
localreport=(OLD/P/'G0_local_report_analysis.do').read_text().splitlines();put(P/'G0_local_prepare_numeric.do','\n'.join(localreport[:47])+'\n')
patches.append({'path':str(P/'G0_local_prepare_numeric.do'),'source':str(OLD/P/'G0_local_report_analysis.do'),'reason':'exact lines1-47 baseline-generation prefix retained; table/chart blocks not in upstream launcher'})
compat=['do "code/init.do"']+[f'do "{P/n}"' for n in legacy_names[:8]]+[f'do "{P}/G0_integrate_verified_candidate.do" "$WFROOT" "{D}/G0_main_candidate.dta"','display "WF_STAGE_F050_PASS"']
put('code/stages/F050_compatibility.do','\n'.join(compat)+'\n')
# Working children independently load their integrated annual parent; annual assembly uses files.
tunnel=(OLD/P/'G0_publish_analysis_tunnel.do').read_text();tunnelrels=re.findall(r'do "(dag/edges/word_rows/G0/analysis_tunnel/[^\"]+\.do)"',tunnel);assert len(tunnelrels)==108
workentry=['do "code/init.do"',f'use "{D}/G0_main_verified_20260910.dta", clear']
for y in YEARS:workentry+=['preserve',f'keep if source_year=={y}',f'save "data/intermediate/verified_wave_{y}.dta", replace','restore']
works=[]
for rel in tunnelrels:
 body=copy_code(rel);stem=Path(rel).stem;y=int(stem[-4:]);var=stem[:-5];out=re.findall(r'^save "([^\"]+)"',body,re.M)[-1];oldout=OLD/out;pin(oldout,'validation_only');node(str(oldout),'validation_only');comparisons.append((out,str(oldout)))
 wrapper=f'code/leaves/working/{stem}.do';parent=f'data/intermediate/verified_wave_{y}.dta'
 put(wrapper,f'do "code/init.do"\nuse "{parent}", clear\nassert source_year=={y}\nisid source_year source_row\ntempfile metrics\ncapture postclose counts\npostfile counts int source_year str32 variable long rows observed verified_only provisional using `metrics\', replace\ndo "{rel}"\npostclose counts\n')
 edge('F060_'+stem,wrapper,[parent],[out]);workentry.append(f'do "{wrapper}"');fields=re.findall(r'^keep (.+)$',body,re.M)[-1].split();works.append({'year':y,'variable':var,'artifact':out,'fields':fields,'launcher':wrapper,'method':rel})
for y in YEARS:
 records=[x for x in works if x['year']==y]; rel=f'code/annual/merge_working_{y}.do';out=f'{D}/analysis_tunnel/wave_{y}.dta'
 ss=['do "code/init.do"',f'use source_year source_row using "data/intermediate/verified_wave_{y}.dta", clear']
 for x in records:ss+=[f'merge 1:1 source_year source_row using "{x["artifact"]}", assert(match) nogen']
 ss+=['isid source_year source_row',f'save "{out}", replace'];put(rel,'\n'.join(ss)+'\n');edge(f'F060_JOIN_{y}',rel,[f'data/intermediate/verified_wave_{y}.dta']+[x['artifact'] for x in records],[out]);workentry.append(f'do "{rel}"')
# Exact original working tail applies documented replacements/bookkeeping after append.
ss=['do "code/init.do"',f'use "{D}/analysis_tunnel/wave_2010.dta", clear']+[f'append using "{D}/analysis_tunnel/wave_{y}.dta"' for y in YEARS[1:]]+['tempfile tunnel',"save `tunnel'"]
tail=tunnel.splitlines()[175:];tail=[l for l in tail if not l.startswith('log close tunnel')];ss+=tail;put('code/stages/F060_finish_working.do','\n'.join(ss)+'\n');workentry+=['do "code/stages/F060_finish_working.do"','display "WF_STAGE_F060_PASS"'];put('code/stages/F060_working.do','\n'.join(workentry)+'\n')
ss=['do "code/init.do"',f'do "{P}/G0_publish_complete_identity_dataset.do" "$WFROOT" "off"',f'do "{P}/G0_local_prepare_numeric.do" "$WFROOT"',f'use "{D}/G0_analysis_ready_ACTUAL_LOCAL.dta", clear','do "code/order_baseline.do"',f'save "{D}/G0_analysis_ready_ACTUAL_LOCAL.dta", replace','display "WF_STAGE_F070_PASS"'];put('code/stages/F070_baseline.do','\n'.join(ss)+'\n')
# Copied correction methods generate only new-root data. Four report children deliberately withheld until after waves.
entry=(OLD/'run_corrections_G0.do').read_text();allcalls=re.findall(r'^do "([^\"]+)"',entry,re.M);prep=[];reports=[]
for rel in allcalls:
 copy_code(rel)
 if '/corrections/' in rel and not any(t in Path(rel).name for t in ['C150_','C160_','C170_','C180_']):prep.append(f'do "{rel}"')
 elif '/publication/' in rel or any(t in Path(rel).name for t in ['C150_','C160_','C170_','C180_']):reports.append(rel)
assert len(prep)==372 and len(reports)==29
put('code/stages/F080_corrections.do','do "code/init.do"\n'+'\n'.join(prep)+'\ndisplay "WF_STAGE_F080_PASS"\n')
copy_code('rows/G0/edges/G0_raw_schema.do')
# Final ready-wave release adds only the root-approved literal-class companions.
ss=['do "code/init.do"','use "corrections/data/C140.dta", clear','assert c(k)==4591','do "rd2017/lib/wave_rd17_classes.do"','wave_rd17_classes','assert c(k)==4593','isid source_year source_row']
for y in YEARS:ss+=['preserve',f'keep if source_year=={y}',f'assert source_year=={y}','isid source_year source_row',f'save "data/waves/wave_{y}.dta", replace','restore']
ss+=['display "WF_STAGE_F085_PASS"'];put('code/stages/F085_publish_waves.do','\n'.join(ss)+'\n')
# Post-wave numerical consumers bind only ready append and its descendants.
ss=['do "code/init.do"','use "data/waves/wave_2010.dta", clear']+[f'append using "data/waves/wave_{y}.dta"' for y in YEARS[1:]]+['isid source_year source_row','assert _N==33049','assert c(k)==4593','save "data/analysis/G0_analysis_ready.dta", replace','display "WF_STAGE_F090_APPEND_PASS"'];put('code/stages/F090_append_ready.do','\n'.join(ss)+'\n')
# Recompute baseline coverage from ready projection: original report domain retained exactly.
ss=['do "code/init.do"','use "data/analysis/G0_analysis_ready.dta", clear','keep '+' '.join(basefields),'tempfile coverage','quietly levelsof source_year, local(years)']+localreport[55:82]
put('code/reports/rebuild_legacy_coverage.do','\n'.join(ss)+'\n')
# Recompute st_* counts using the original exact expressions; no old counts CSV.
old11=(OLD/P/'G0_11_tables_charts.do').read_text().splitlines();ss=['do "code/init.do"','use "data/analysis/G0_analysis_ready.dta", clear']+old11[28:45];put('code/reports/rebuild_source_counts.do','\n'.join(ss)+'\n')
# The threshold is a declared wave-derived annual aggregate; no upstream C050 operand below the boundary.
s=(OLD/'rows/G0/corrections/C050_signed_tail_threshold.do').read_text().replace('corrections/data/C030.dta','data/analysis/G0_analysis_ready.dta').replace('g0c_finish "C050_signed_tail_threshold" "C050"','save "data/analysis/signed_thresholds.dta", replace\ncapture log close G0CHILD');put('code/reports/rebuild_signed_thresholds.do',s.replace(str(OLD),str(ROOT)))
for rel in reports:
 p=ROOT/rel;s=p.read_text();s=s.replace('corrections/data/C140.dta','data/analysis/G0_analysis_ready.dta').replace('corrections/data/C010.dta','data/analysis/G0_analysis_ready.dta').replace('corrections/data/C050.dta','data/analysis/signed_thresholds.dta')
 if rel.endswith('G0_support_dictionary.do'):s=s.replace('do "rows/G0/edges/G0_raw_schema.do"','drop rd17_own_token_class rd17_external_token_class\ndo "rows/G0/edges/G0_raw_schema.do"')
 p.write_text(s);patches.append({'path':rel,'reason':'post-wave company reads rebound to ready-wave append/derived threshold; original dictionary projection excludes two new columns','new_sha256':sha(p)})
ss=['do "code/init.do"','do "code/reports/rebuild_legacy_coverage.do"','do "code/reports/rebuild_source_counts.do"','do "code/reports/rebuild_signed_thresholds.do"']+[f'do "{p}"' for p in reports]+['display "WF_STAGE_F090_REPORTS_PASS"'];put('code/stages/F090_reports.do','\n'.join(ss)+'\n')
# Numerical histogram builder retained, rebound to ready data; no graphics.
histrel=P/'G0_report_histogram_bins.do';hs=copy_code(histrel,trim_graphs,'histogram bin arithmetic preserved; input rebound to ready-wave append, no chart commands');hs=hs.replace(D+'/G0_analysis_ready_ACTUAL_LOCAL.dta','data/analysis/G0_analysis_ready.dta');put(histrel,hs)
# Validation uses witnesses only and writes no computational parents.
val=['do "code/init.do"']
for a,b in comparisons:
 val += [f'use "{a}", clear',f'cf _all using "{b}", all']
val+=['display "WF_LEAF_VALUES_2904_EXACT"']
put('code/validation/compare_leaves.do','\n'.join(val)+'\n')
for name,a,b in [('baseline',D+'/G0_analysis_ready_ACTUAL_LOCAL.dta',str(OLD/D/'G0_analysis_ready_ACTUAL_LOCAL.dta')),('corrected','corrections/data/C140.dta',str(OLD/'corrections/data/C140.dta'))]:
 pin(b,'validation_only');node(b,'validation_only');put(f'code/validation/compare_{name}.do',f'do "code/init.do"\nuse "{a}", clear\ncf _all using "{b}", all\ndisplay "WF_{name.upper()}_VALUES_EXACT"\n')
agg=json.loads((OLD/'corrections/runtime/aggregate-output-manifest.json').read_text())['reports'];val=['do "code/init.do"']
for r in agg:
 b=Path(r['path']);a='corrections/reports/'+b.name;pin(b,'validation_only');node(str(b),'validation_only');val += [f'use "{a}", clear']
 if b.name=='worker_denominator_domains.dta':
  val += ['isid source_year ratio','sort source_year ratio','tempfile sorted_worker_witness','preserve',f'use "{b}", clear','isid source_year ratio','sort source_year ratio',"save `sorted_worker_witness'",'restore',"cf _all using `sorted_worker_witness', all"]
 else:val += [f'cf _all using "{b}", all']
val+=['display "WF_REPORT_VALUES_30_EXACT"'];put('code/validation/compare_reports.do','\n'.join(val)+'\n')
# Deliberate root-level stages are resumed only by explicit runner argument; every actual receipt honest.
stagecalls=[('F010','code/stages/F010_raw.do'),('F030','code/stages/F030_mapped.do'),('F040','code/stages/F040_append_intermediate.do'),('F050','code/stages/F050_compatibility.do'),('F060','code/stages/F060_working.do'),('F070','code/stages/F070_baseline.do'),('V070','code/validation/compare_baseline.do'),('V060','code/validation/compare_leaves.do'),('F080','code/stages/F080_corrections.do'),('V080','code/validation/compare_corrected.do'),('F085','code/stages/F085_publish_waves.do'),('F090A','code/stages/F090_append_ready.do'),('F090R','code/stages/F090_reports.do'),('V090','code/validation/compare_reports.do'),('H090',str(histrel))]
put('registry/stages.json',json.dumps([{'id':a,'path':b} for a,b in stagecalls],indent=2)+'\n')
put('registry/leaf-operands.json',json.dumps({'mapped':leafspec,'working':works},indent=2)+'\n')
put('registry/inputs.json',json.dumps({'inputs':list(inputs.values())},indent=2)+'\n');put('registry/patch-ledger.json',json.dumps(patches,indent=2)+'\n')
put('registry/dag-draft.json',json.dumps({'nodes':list(nodes.values()),'edges':edges},indent=2)+'\n')
print(json.dumps({'status':'DRAFT_GENERATED_NOT_EXECUTED','mapped':len(leafspec),'working':len(works),'stages':len(stagecalls),'pinned_inputs':len(inputs),'next':'complete read graph, numerical fixtures, guarded runner, static review'}))
