"""Independent reference workbook validation/provenance, not company calculations."""
from pathlib import Path
from openpyxl import load_workbook
import csv,json,hashlib,math,collections
P=Path(__file__).resolve().parent;D=P/'references/toar-wpi-20260910';R=P/'results'
w=load_workbook(D/'source/ihpb_annual_averages_2013_2022_clean.xlsx',read_only=True,data_only=True)
sheets=[{'sheet':s.title,'rows_including_header':s.max_row,'columns':s.max_column} for s in w]
monthly=[]
for row in list(w['monthly_long'].values)[1:]:
 vals=row[4:16];ok=all(isinstance(v,(int,float)) for v in vals);delta=sum(vals)/12-row[16] if ok else None
 if ok:assert abs(delta)<=.05,(row[:4],delta)
 monthly.append(dict(year=row[0],base=row[1],subsector=row[2],months_observed=sum(isinstance(x,(int,float)) for x in vals),mean_difference=delta,status='recomputed_pass' if ok else 'monthly_source_cells_incomplete'))
with (R/'wpi_monthly_checks.csv').open('w',newline='') as f:
 c=csv.DictWriter(f,fieldnames=list(monthly[0]));c.writeheader();c.writerows(monthly)
a={int(x['ihpb_sub']):x for x in csv.DictReader((D/'source/ihpb_annual_averages_2013_2022.csv').open())}
wide2018={x[0]:x for x in list(w['wide_2018base'].values)[1:]}
splice=[]
for row in list(w['splice_2020_2022'].values)[1:]:
 old,new,factor,*_=row
 if not isinstance(new,(int,float)):
  assert old==36 and factor is None
  continue
 assert factor>0
 for j,y in enumerate([2020,2021,2022]):
  raw=wide2018[new][j+2];reported=row[j+3];delta=raw*factor-reported
  assert abs(delta)<.02,(old,new,y,delta)
  assert abs(float(a[old]['ihpb'+str(y)])-reported)<=.0051  # workbook 2dp, CSV 4dp
  splice.append(dict(old_subsector=old,new_subsector=new,year=y,link_factor=factor,raw_2018base=raw,spliced_2010scale=reported,rounding_difference=delta))
with (R/'wpi_splice_checks.csv').open('w',newline='') as f:
 c=csv.DictWriter(f,fieldnames=list(splice[0]));c.writeheader();c.writerows(splice)
# Verify selected synthetic sector bridges against retained UN correspondence.
un=list(csv.DictReader((P.parents[2]/'references/july-end-to-end/data/concordance/isic_correspondence_rev31_rev4.csv').open()))
bridges=list(csv.DictReader((P/'contracts/synthetic-industry-wpi-bridge.csv').open()))
for b in bridges:assert any(x['isic_rev31']==b['isic4'] and x['isic_rev4']==b['isic_rev4'] for x in un)
manifest=json.loads((P/'contracts/wpi-source-manifest.json').read_text())
for m in manifest['files']:
 f=D/m['file'];assert hashlib.sha256(f.read_bytes()).hexdigest()==m['sha256']
out=dict(status='supplied_reference_arithmetic_checked_with_disclosed_gaps',sheets=sheets,monthly_rows=len(monthly),monthly_pass=sum(x['status']=='recomputed_pass' for x in monthly),monthly_incomplete=sum(x['status']!='recomputed_pass' for x in monthly),missing_monthly_rows_vs_claim=21,splice_cells_checked=len(splice),source_base=2000,source_classification='131 ISIC Rev3/3.1 manufacturing codes; fixture bridge reviewed separately',native_extension_years=[2013,2014,2015,2017,2018,2019],spliced_years=[2020,2021,2022],missing_years=[2016],index_use='output only; single-output-deflator VA approximation separately labelled',unavailable=['verified input-specific deflator (legacy WPIN exists, concept unverified)','appropriate capital deflator','appropriate wage deflator','original publication PDFs','raw Dec2019-on-both-bases anchors','monthly detail for 2018-base subsectors 51–57','validated all-industry all-year real-company classification bridge'],source_corrections=['Package filenames say 2000 but wide series begins 1983.','Stata dataset label still says 2019 despite columns through 2022.','Workbook README old no-splice warning conflicts with later splice sheet; use explicit numeric splice sheet with uncertainty.','Year FE do NOT generally absorb sector-specific splice errors; source README claim is not accepted.'])
(R/'wpi_workbook_audit.json').write_text(json.dumps(out,indent=2));w.close();print(json.dumps(out,indent=2))
