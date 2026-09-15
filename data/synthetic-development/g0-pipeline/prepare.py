"""Adapt existing G0 Stata edges; inspect only committed synthetic Excel/schema inputs."""
from pathlib import Path
import csv,json,re,hashlib,datetime
from openpyxl import load_workbook
from openpyxl.utils import get_column_letter
ROOT=Path(__file__).resolve().parents[3]; P=Path(__file__).resolve().parent
SRC=ROOT/'research/1014/05-analysis/analytical-dag/dag/edges/word_rows'; S=P.parent/'schema'
def read(p):return list(csv.DictReader(p.open()))
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def write(p,s):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
for d in ['dag/data/staged','dag/data/references','dag/data/word_data/G0/variable_year','dag/data/word_data/G0/analysis_tunnel','dag/reports/word_data/G0/20260910-code-verification','dag/logs/word_data/G0/variable_year','dag/logs/word_data/G0/analysis_tunnel','dag/nodes','contracts','results']:(P/d).mkdir(parents=True,exist_ok=True)
# Only computational do-files. Do not copy any existing input/output data or run old preparers.
reuse=[]
for src in (SRC/'G0').rglob('*.do'):
 if src.name.startswith(('G0_select_identity','G0_load_identity','G0_finish_outputs','G0_audit_tunnel_updates')):continue
 text=src.read_text();original=text
 text=text.replace('assert _N==33049','assert _N==1200')
 if src.name=='G0_01_source_manifest.do':text=re.sub(r'assert _N==\d+','assert _N==100',text)
 text=text.replace('safe_sample_only; raw_preserved; conditional_energy; no_real_panel','SYNTHETIC_PIPELINE; raw_preserved; conditional_energy; fictional_panel')
 text=text.replace('safe_sample_unlinked_crosswalk_pending','SYNTHETIC_source_ID_preserved; not_real_linkage')
 if src.name=='G0_12_validate.do':
  a=text.index('* Compare E017 preserved');b=text.index('* Domain and boundary fixtures',a)
  text=text[:a]+'* Historical real-data compatibility inputs excluded. Synthetic accounting/percentile and final checks remain.\n'+text[b:]
 if src.name=='G0_06_stage_validate_deflators.do':
  text=text.replace('legacy_output_wpi_year_exists=source_year<=2012','legacy_output_wpi_year_exists=0').replace('legacy_input_wpi_year_exists=source_year<=2016','legacy_input_wpi_year_exists=0').replace('pending_uploaded_WPI_and_revision_bridge; no_real_values','WPI_staged; awaiting_verified_annual_mapping_before_deflation')
 if src.name=='G0_render_verified_charts.do':
  text=text.replace('title("Cakupan', 'title("SYNTHETIC: cakupan')
  text=text.replace('display "G0_READABLE_CHARTS_SUCCESS"', 'keep if variable=="rd_cost_nominal" & source_year>=2017\ngenerate double positive_pct=100*yes/rows\ngraph bar observed_pct positive_pct, over(source_year) ytitle("Percent of fictional records") title("SYNTHETIC: R&D expense coverage") legend(order(1 "Observed" 2 "Positive")) note("Calculated from synthetic IRDVCU; COSTRD is a funding code.") graphregion(color(white))\ngraph export "`out\'/rd_expense_coverage.png", width(1800) replace\ndisplay "G0_READABLE_CHARTS_SUCCESS"')
 if src.name=='G0_06_stage_validate_deflators.do':text='do \"dag/edges/wpi/G0_stage_wpi.do\"\n'+text
 dest=P/'dag/edges/word_rows/G0'/src.relative_to(SRC/'G0');write(dest,'* SYNTHETIC EXECUTION COPY; see contracts/reuse-manifest.csv for source hash.\n'+text)
 reuse.append(dict(source=str(src.relative_to(ROOT)),source_sha256=sha(src),adapted=str(dest.relative_to(P)),changes='synthetic record counts/labels; WPI availability zero' if text!=original else 'label only; calculations unchanged'))
with (P/'contracts/reuse-manifest.csv').open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(reuse[0]));w.writeheader();w.writerows(reuse)
contracts=json.loads((S/'input_headers.json').read_text());rawmap=read(S/'raw_field_map.csv');manifest=[];commands=[];fieldmap=[]
rules=read(S/'variable_year_rules.csv')
for c in contracts:
 path=P.parent/'input-excel'/('SYNTHETIC_'+c['filename']);wb=load_workbook(path,read_only=True,data_only=False);ws=wb['Sheet1'];rows=list(ws.values);wb.close();assert list(rows[0])==c['headers'];assert len(rows)-1==c['fixture_rows'];assert not any(isinstance(v,str) and v.startswith('=') for row in rows[1:] for v in row)
 y=c['year'];old=c['filename']=='si2010.xlsx';name='old_si2010_reference' if old else f'sample_mfg{y}_raw'
 mapping=[x for x in rawmap if int(x['source_year'])==y and x['candidate_field'].startswith('raw_')]
 if old:names=['ref_'+re.sub('[^a-z0-9_]','_',str(h).lower())[:28] for h in c['headers']]
 else:
  assert len(mapping)==len(c['headers']);assert [x['original_header'] for x in mapping]==c['headers'];names=[x['candidate_field'] for x in mapping]
 assert len(set(names))==len(names)
 code=[f'import excel using "../input-excel/{path.name}", sheet("Sheet1") cellrange(A2) allstring clear',f'assert _N=={c["fixture_rows"]}',f'assert c(k)=={len(names)}']
 for i,n in enumerate(names,1):
  code.append(f'rename {get_column_letter(i)} {n}');fieldmap.append(dict(input=path.name,year=y,column=i,header=c['headers'][i-1],staged_field=n,stage=name))
 id_field=names[0] if old else next(x['source'] for x in rules if x['field']=='source_id_raw' and int(x['year'])==y)
 code += [f'generate int source_year={y}','generate int source_row=_n','isid source_year source_row',f'assert real({id_field})==800000+source_row',f'assert strlen({id_field})==6',f'save "dag/data/staged/{name}.dta", replace',f'display "SYNTHETIC_EXCEL_IMPORT_PASS {path.name}"']
 edge=f'dag/edges/import/{name}.do';write(P/edge,'\n'.join(code)+'\n');commands.append(f'do "{edge}"')
 manifest.append(dict(path=str(path.relative_to(ROOT)),sha256=sha(path),rows=len(rows)-1,columns=len(names),role='synthetic_reference_not_appended' if old else 'synthetic_annual_input'))
for path in sorted((P.parent/'reference-excel').glob('*.xlsx')):
 wb=load_workbook(path,read_only=True,data_only=False);ws=wb.worksheets[0];rows=list(ws.values);sheet=ws.title;wb.close();assert not any(isinstance(v,str) and v.startswith('=') for row in rows for v in row)
 name=path.stem;edge=f'dag/edges/import/reference_{name}.do';code=f'import excel using "../reference-excel/{path.name}", sheet("{sheet}") firstrow allstring clear\nassert _N=={len(rows)-1}\nsave "dag/data/references/{name}.dta", replace\ndisplay "REFERENCE_IMPORT_PASS {name}"\n';write(P/edge,code);commands.append(f'do "{edge}"');manifest.append(dict(path=str(path.relative_to(ROOT)),sha256=sha(path),rows=len(rows)-1,columns=len(rows[0]),role='classification_reference_no_firm_observations'))
for name,rr in [('input-manifest.csv',manifest),('excel-field-map.csv',fieldmap)]:
 with (P/'contracts'/name).open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rr[0]));w.writeheader();w.writerows(rr)
write(P/'dag/edges/G0_import_synthetic_excel.do','\n'.join(commands)+'\n')
# Schema enforcement cannot truncate values. Leave wider storage and report every difference.
schema=read(S/'G0_analysis_ready_schema.csv');assert len(schema)==3793
schema+=read(P/'contracts/schema-additions.csv')
code=[]
for row in schema:
 name=row['name'];typ=row['type'];code.append(f'confirm variable {name}')
 if typ.startswith('str') and typ!='strL':code += [f'quietly count if strlen({name})>{typ[3:]}',f'if r(N)==0 recast {typ} {name}']
 elif not typ.startswith('str'):code += [f'capture recast {typ} {name}']
code += ['order '+' '.join(x['name'] for x in schema),f'assert c(k)=={len(schema)}']
write(P/'dag/edges/G0_enforce_target_schema.do','\n'.join(code)+'\n')
# Child processes remain exact copies/adaptations in this isolated DAG root.
children=['G0_01_source_manifest','G0_02_preserve_annual_fields','G0_03_map_economic_fields','G0_04_validate_real_identifiers','G0_05_map_geography_industry','G0_06_stage_validate_deflators','G0_07_validate_energy_units_factors','G0_08_construct_energy_emissions','G0_09_construct_ratios_logs','G0_10_assemble_main_dataset','G0_12_validate']
primary='''version 17
clear all
set more off
set varabbrev off
set maxvar 10000
args repo_root
if `"`repo_root'"'=="" local repo_root "."
cd "`repo_root'"
confirm file "data/synthetic-development/schema/G0_analysis_ready_schema.csv"
cd "data/synthetic-development/g0-pipeline"
local pipeline_root "`c(pwd)'"
global G0INPUT "dag/data/staged"
global G0D "dag/data/word_data/G0"
global G0R "dag/reports/word_data/G0"
global G0L "dag/logs/word_data/G0"
log using "dag/logs/G0_SYNTHETIC_PRIMARY.log", text replace name(primary)
display "SYNTHETIC_ONLY_NO_ORIGINAL_DATA_NO_ESTIMATION"
do "dag/edges/G0_import_synthetic_excel.do"
'''
for child in children:primary+=f'display "SYNTHETIC_CHILD_START {child}"\ndo "dag/edges/word_rows/G0/{child}.do"\ndisplay "SYNTHETIC_CHILD_PASS {child}"\n'
# Separate phase logs in inherited code close all logs; shell transcript captures complete run.
primary+='''log close primary
do "dag/edges/word_rows/G0/G0_verify_variable_year.do" "`pipeline_root'"
do "dag/edges/word_rows/G0/G0_integrate_verified_candidate.do" "`pipeline_root'" "dag/data/word_data/G0/G0_main_candidate.dta"
do "dag/edges/word_rows/G0/G0_publish_analysis_tunnel.do" "`pipeline_root'"
do "dag/edges/word_rows/G0/G0_render_verified_charts.do" "`pipeline_root'"
do "dag/edges/wpi/G0_apply_wpi.do"
do "dag/edges/G0_finish_preparation_gaps.do"
do "dag/edges/G0_test_preparation_cases.do"
do "dag/edges/G0_preserve_fixture_identity.do"
do "dag/edges/G0_validate_synthetic_final.do"
display "G0_SYNTHETIC_FULL_PIPELINE_SUCCESS"
'''
write(P/'G0_build_synthetic_dataset.do',primary)
print('Prepared',len(reuse),'reused edges;',len(manifest),'Excel inputs; no source company data read.')
