"""Format/validate actual Stata output. Never read the illustrative G0 fixture or original observations."""
from pathlib import Path
import csv,json,hashlib,datetime,re,math,collections
from openpyxl import Workbook,load_workbook
from openpyxl.cell import WriteOnlyCell
from openpyxl.styles import Font,PatternFill,Alignment
from openpyxl.workbook.properties import CalcProperties
from openpyxl.drawing.image import Image
from openpyxl.utils import get_column_letter
P=Path(__file__).resolve().parent;ROOT=P.parents[2];R=P/'results';S=P.parent/'schema';OLD=ROOT/'research/1014/05-analysis/analytical-dag/dag'
def read(p):return list(csv.DictReader(p.open()))
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def out(p,rows):
 with p.open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
assert 'G0_SYNTHETIC_FINAL_VALIDATION_PASS' in (P/'dag/logs/G0_final_validation.log').read_text()
actual=read(R/'actual_schema.csv');target=read(S/'G0_analysis_ready_schema.csv')+read(P/'contracts/schema-additions.csv');assert [x['name'] for x in actual]==[x['name'] for x in target] and len(actual)==3837
diff=[]
for a,t in zip(actual,target):
 if a['type']!=t['type']:diff.append(dict(variable=a['name'],target_type=t['type'],actual_type=a['type'],reason='widened to preserve complete synthetic strings/IDs' if t['type'].startswith('str') else 'safe recast retained precision/range; no forced conversion'))
out(R/'schema_differences.csv',diff or [dict(variable='NONE',target_type='',actual_type='',reason='all types match')])
coverage=read(R/'coverage_by_variable_year.csv');assert len(coverage)==3837*12
for x in coverage:assert int(x['rows'])==100 and int(x['observed'])+int(x['missing_rows'])==100
numeric={x['name']:x['isnumeric']=='1' for x in actual};headers=[x['name'] for x in actual]
def typed(row):return [None if v in ['', '.'] and numeric[k] else float(v) if numeric[k] else v or None for k,v in zip(headers,row)]
# Independent synthetic raw-cell preservation check: Excel -> published Stata CSV, keyed by year/row.
rawmap=read(P/'contracts/excel-field-map.csv');annual=collections.defaultdict(list)
for x in rawmap:
 if x['stage'].startswith('sample_'):annual[int(x['year'])].append(x)
source={}
for y,mapping in annual.items():
 wb=load_workbook(P.parent/'input-excel'/mapping[0]['input'],read_only=True,data_only=False);rows=wb['Sheet1'].iter_rows(values_only=True);next(rows)
 for i,row in enumerate(rows,1):source[y,i]={x['staged_field']:(row[int(x['column'])-1] if int(x['column'])<=len(row) else None) for x in mapping}
 wb.close()
keys=set();raw_checked=0;formula_checks=0
with (R/'G0_analysis_ready_SYNTHETIC_CALCULATED.csv').open() as f:
 for r in csv.DictReader(f):
  key=int(r['source_year']),int(r['source_row']);assert key not in keys;keys.add(key)
  assert int(r['selected_firm_id'])==800000+key[1] and r['source_id_raw']==str(800000+key[1])
  assert r['identity_is_dummy']=='1' and r['identity_real_link_verified']=='0'
  for k,v in source[key].items():
   got=r[k]
   if v is None:assert got==''
   elif isinstance(v,(int,float)):assert math.isclose(float(got),v,rel_tol=1e-12,abs_tol=1e-10),(key,k,got,v)
   else:assert got==v,(key,k,got,v)
   raw_checked+=1
  def val(n):return float(r[n]) if r[n] not in ['', '.'] else None
  for result,num,den in [('labor_productivity_nominal','value_added_nominal','workers'),('output_per_worker_nominal','gross_output_nominal','workers'),('energy_intensity_monetary','energy_expenditure_rp000','gross_output_nominal'),('gross_output_real','gross_output_nominal','deflator_output'),('value_added_real','value_added_nominal','deflator_output'),('capital_stock_per_worker','capital_stock_nominal','workers'),('capital_additions_per_worker','capital_additions_nominal','workers'),('output_real_per_worker','gross_output_real','workers'),('va_real_proxy_per_worker','value_added_real','workers')]:
   a,b=val(num),val(den);z=val(result)
   if a is not None and b is not None and b>0:assert z is not None and math.isclose(z,a/b,rel_tol=1e-12,abs_tol=1e-10)
   else:assert z is None
   formula_checks+=1
assert len(keys)==1200
assert 'G0_ADVERSARIAL_CASES_PASS' in (P/'dag/logs/G0_adversarial_cases.log').read_text()
assert 'G0_WPI_APPLICATION_PASS' in (P/'dag/logs/G0_wpi_application.log').read_text()
wpi_checks=json.loads((R/'wpi_workbook_audit.json').read_text())
assert len(read(R/'wpi_merge_audit.csv'))==48
# Every annual conversion/working node gets its own executed state contract.
metrics=read(P/'dag/reports/word_data/G0/20260910-code-verification/variable_year_metrics.csv');rules=read(S/'variable_year_rules.csv');rl={(x['field'],x['year']):x for x in rules};registry=[]
for m in metrics:
 name=f"N_G0_{m['field']}_{m['year']}";log=P/f'dag/logs/word_data/G0/variable_year/{name}.log';assert f'VARIABLE_YEAR_PASS {name}' in log.read_text();node=P/'dag/nodes'/name;node.mkdir(exist_ok=True);rule=rl[m['field'],m['year']]
 decision=f"# SYNTHETIC decision — {name}\n\nGrain: source_year/source_row; {m['rows']} fictional input records. Source: {rule['source'] or 'not supplied'}. Rule: {rule['kind']}; factor {rule['factor']}; source-definition status: {rule['definition_status']}. Evidence reference: {rule['evidence']}. These references describe code semantics, not validation of real observations.\n\nObserved: {m['observed']}; zeros: {m['zeros']}; invalid/universe-excluded: {m['invalid']}; source absent: {m['source_absent']}. Status and raw text are retained.\n"
 (node/'decision.md').write_text(decision);(node/'triage.md').write_text('# PASS — synthetic execution\n\nAnnual edge ran and materialized its DTA. Source definition caveats remain distinct from execution success. Reopen on input/hash/rule change or failed assertion.\n')
 registry.append(dict(node=name,grain='source_year/source_row',input=f'dag/data/staged/sample_mfg{m["year"]}_raw.dta',edge=f'dag/edges/word_rows/G0/variable_year/{m["field"]}_{m["year"]}.do',output=f'dag/data/word_data/G0/variable_year/{name}.dta',rows=m['rows'],status='synthetic_pass'))
working=read(P/'dag/reports/word_data/G0/20260910-code-verification/analysis_tunnel_coverage.csv')
for m in working:
 name=f"N_G0_tunnel_{m['variable']}_{m['source_year']}";log=P/f'dag/logs/word_data/G0/analysis_tunnel/{name}.log';assert f'TUNNEL_NODE_PASS {name}' in log.read_text();node=P/'dag/nodes'/name;node.mkdir(exist_ok=True)
 (node/'triage.md').write_text('# PASS — synthetic working-value node\n\nRan on synthetic input; provisional values are explicit, verified values preserved.\n')
 (node/'decision.md').write_text('# SYNTHETIC working-value decision\n\n'+json.dumps(m,indent=2)+'\n\nGrain source_year/source_row. Main working field and v_ verified-only companion share input. vs_=10 is provisional; no source-zero recode to false. See corresponding executable edge and preserved upstream decision.\n')
 registry.append(dict(node=name,grain='source_year/source_row',input='dag/data/word_data/G0/G0_main_verified_20260910.dta',edge=f'dag/edges/word_rows/G0/analysis_tunnel/{m["variable"]}_{m["source_year"]}.do',output=f'dag/data/word_data/G0/analysis_tunnel/{name}.dta',rows=m['rows'],status='synthetic_pass'))
assert len(metrics)==2796 and len(working)==108
out(R/'executed_node_registry.csv',registry)
# Detailed type table in native Markdown.
md='# SYNTHETIC schema reconciliation\n\nAll **3,793 target names** exist in the target order. 44 documented additions extend the contract to 3,837; no original names removed. Types are enforced only when values fit without truncation or precision loss.\n\n| Field | Target | Actual | Reason |\n|---|---|---|---|\n'
for x in diff:md+=f"| `{x['variable']}` | {x['target_type']} | {x['actual_type']} | {x['reason']} |\n"
(R/'SCHEMA-DIFFERENCES.md').write_text(md)
# Streaming openpyxl workbook: complete 4.55m-cell data table plus compact readable view.
wb=Workbook(write_only=True);wb.calculation=CalcProperties(calcMode='auto',fullCalcOnLoad=True,forceFullCalc=True)
def sheet(name,cols,rows,width=24):
 ws=wb.create_sheet(name);ws.row_dimensions[1].height=44;ws.freeze_panes='C2' if name=='Data' else 'A2'
 for i,k in enumerate(cols,1):ws.column_dimensions[get_column_letter(i)].width=70 if k in ['varlab','reason','value','description','actual_result','remaining_source_or_limit','source_gap','impact'] else width
 cells=[]
 for k in cols:
  c=WriteOnlyCell(ws,k);c.font=Font(color='FFFFFF',bold=True);c.fill=PatternFill('solid',fgColor='20365E');c.alignment=Alignment(wrap_text=True);cells.append(c)
 ws.append(cells);n=1
 for row in rows:
  if name in ['README','Dictionary','Type differences','WPI metadata','WPI source gaps','Row 0 status']:
   ws.row_dimensions[n+1].height=max(52,15*max(math.ceil(len(str(v or ''))/65) for v in row)+12)
   cells=[]
   for v in row:
    c=WriteOnlyCell(ws,v);c.alignment=Alignment(wrap_text=True,vertical='top');cells.append(c)
   ws.append(cells)
  elif name in ['Year summary','Coverage']:
   cells=[]
   for k,v in zip(cols,row):
    if isinstance(v,str) and re.fullmatch(r'-?\d+(\.\d+)?',v):v=float(v) if '.' in v else int(v)
    c=WriteOnlyCell(ws,v or None if v=='' else v);c.number_format='0' if k=='source_year' else '#,##0.00' if isinstance(v,float) else '#,##0' if isinstance(v,int) else 'General';cells.append(c)
   ws.append(cells)
  else:ws.append(row)
  n+=1
 ws.auto_filter.ref=f'A1:{get_column_letter(len(cols))}{n}';return ws
notes=[('Status','SYNTHETIC CALCULATED OUTPUT — from 13 input Excel files, NOT the schema example'),('Dimensions','1200 records / 100 supplied fictional IDs / 12 years / 3837 columns (3793 retained + 44 additions)'),('ID rule','800001–800100 preserved across years; identity_is_dummy=1; identity_real_link_verified=0'),('Data','Complete target columns in original order. Analysis view provides an easier subset.'),('Sources','2010–2015 and 2017–2022. 2016 absent. Old-si2010 synthetic reference staged separately, never appended.'),('Caveats','Provisional code mappings, partial 9-fuel energy, later-year grid carry; actual output WPI with splice; VA single-deflator approximation; no genuine company observations'),('Schema differences',f'{len(diff)} storage differences, all enumerated; no truncated IDs'),('Checks',f'{raw_checked} Excel raw cells independently reconciled; {formula_checks} ratio checks; Stata per-node/key/domain/identity checks passed')]
sheet('README',['item','value'],notes)
core=['source_year','source_row','selected_firm_id','selected_district_code','identity_is_dummy','identity_real_link_verified','workers','gross_output_nominal','value_added_nominal','capital_stock_nominal','capital_additions_nominal','rd_cost_nominal','export_flag','export_direct_flag','innovation_flag','env_amdal_flag','total_gj_s1','co2_total_s1','energy_expenditure_rp000','labor_productivity_nominal','deflator_applied','wpi_output_index','wpi_spliced','gross_output_real','value_added_real','real_va_is_single_proxy','output_real_per_worker','capital_stock_per_worker']
with (R/'G0_analysis_ready_SYNTHETIC_CALCULATED.csv').open() as f:
 rows=list(csv.DictReader(f));sheet('Analysis view',core,([None if x[k] in ['', '.'] and numeric[k] else float(x[k]) if numeric[k] else x[k] or None for k in core] for x in rows));del rows
with (R/'G0_analysis_ready_SYNTHETIC_CALCULATED.csv').open() as f:
 rr=csv.reader(f);assert next(rr)==headers;sheet('Data',headers,(typed(x) for x in rr),18)
sheet('Dictionary',list(actual[0]),(list(x.values()) for x in actual))
sheet('Type differences',list((diff or [dict(variable='NONE',target_type='',actual_type='',reason='all matched')])[0]),(list(x.values()) for x in (diff or [dict(variable='NONE',target_type='',actual_type='',reason='all matched')])) )
years=read(R/'year_summary.csv');sheet('Year summary',list(years[0]),(list(x.values()) for x in years))
sheet('Coverage',list(coverage[0]),(list(x.values()) for x in coverage))
for title,filename in [('WPI merge','wpi_merge_audit.csv'),('WPI metadata','wpi_metadata.csv'),('Row 0 status','row0_status.csv'),('WPI source gaps','wpi_source_gaps.csv')]:
 rr=read(R/filename);sheet(title,list(rr[0]),(list(x.values()) for x in rr))
charts=wb.create_sheet('Charts')
for i,name in enumerate(['indicator_coverage','environment_coverage','rd_expense_coverage','wpi_index_by_sector']):
 p=P/f'dag/reports/word_data/G0/20260910-code-verification/{name}.png'
 if p.exists():im=Image(p);im.width=900;im.height=550;charts.add_image(im,f'A{1+i*30}')
xlsx=R/'G0_analysis_ready_SYNTHETIC_CALCULATED.xlsx';wb.save(xlsx)
check=load_workbook(xlsx,read_only=True,data_only=False);assert len(check.sheetnames)==12 and check.calculation.calcMode=='auto'
checked=0
with (R/'G0_analysis_ready_SYNTHETIC_CALCULATED.csv').open() as f:
 rr=csv.reader(f);assert list(next(check['Data'].values))==next(rr)
 for got,raw in zip(check['Data'].iter_rows(min_row=2,max_col=len(headers),values_only=True),rr,strict=True):
  expected=typed(raw)
  for a,b in zip(got,expected,strict=True):
   if isinstance(b,float):assert a is not None and math.isclose(a,b,rel_tol=1e-14,abs_tol=1e-12),(a,b)
   else:assert a==b,(a,b)
   checked+=1
check.close();assert checked==3837*1200
manifest=dict(timestamp=datetime.datetime.now().astimezone().isoformat(),status='SYNTHETIC_WPI_PREPARATION_EXECUTED_WITH_DISCLOSED_SOURCE_GAPS',rows=1200,columns=3837,firms=100,years=sorted(annual),all_raw_excel_cells_checked=raw_checked,independent_ratio_checks=formula_checks,workbook_cells_checked=checked,type_differences=len(diff),variable_year_nodes_passed=len(metrics),working_nodes_passed=len(working),original_company_data_read=False,illustrative_G0_workbook_read=False,estimators_run=False,wpi_workbook_checks=wpi_checks,wpi_source_files=json.loads((P/'contracts/wpi-source-manifest.json').read_text()),input_files=read(P/'contracts/input-manifest.csv'),outputs=[dict(path=str(p.relative_to(P)),sha256=sha(p),bytes=p.stat().st_size) for p in [R/'G0_analysis_ready_SYNTHETIC_CALCULATED.dta',xlsx,R/'actual_schema.csv',R/'coverage_by_variable_year.csv']])
(R/'RUN-MANIFEST.json').write_text(json.dumps(manifest,indent=2));print(json.dumps({k:v for k,v in manifest.items() if k not in ['input_files','outputs']},indent=2))

# Exact allowlist for owner-authorized synthetic DTA publication; no other dataset extension is released.
artifacts=[dict(path=str(p.relative_to(ROOT)),sha256=sha(p),bytes=p.stat().st_size,kind='actual_WPI_reference_no_company_observations' if 'references/toar-wpi-20260910/' in str(p) or p.name.startswith('WPI_') else 'executed_synthetic_Stata_state') for p in sorted(P.rglob('*.dta'))]
(R/'synthetic-artifact-manifest.json').write_text(json.dumps({'synthetic_only':True,'run_manifest_sha256':sha(R/'RUN-MANIFEST.json'),'artifacts':artifacts},indent=2))
