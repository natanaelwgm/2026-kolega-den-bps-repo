"""Readable component status from actual output and execution receipts."""
from pathlib import Path
import csv,json,collections
P=Path(__file__).resolve().parent;R=P/'results'
def read(p):return list(csv.DictReader(p.open()))
def out(name,rows):
 with (R/name).open('w',newline='') as f:w=csv.DictWriter(f,fieldnames=list(rows[0]));w.writeheader();w.writerows(rows)
assert 'G0_SYNTHETIC_FINAL_VALIDATION_PASS' in (P/'dag/logs/G0_final_validation.log').read_text()
assert 'G0_ADVERSARIAL_CASES_PASS' in (P/'dag/logs/G0_adversarial_cases.log').read_text()
a=read(R/'actual_schema.csv');cov=read(R/'coverage_by_variable_year.csv');data=read(R/'G0_analysis_ready_SYNTHETIC_CALCULATED.csv')
assert len(a)==3837 and len(data)==1200
observed={}
for x in cov:observed[x['variable']]=observed.get(x['variable'],0)+int(x['observed'])
matched=sum(int(x['matched']) for x in read(R/'wpi_merge_audit.csv'));assert matched==1200
status=[]
def row(component,status_name,result,open_source):status.append(dict(component=component,status=status_name,actual_result=result,remaining_source_or_limit=open_source))
row('Create main dataset','selesai (sintetis)','1200 rows, 3837 columns; 3793 original names plus 44 documented fields; primary executed','No inference about original company observations')
row('Include all source variables','selesai (sintetis)','All staged raw columns preserved; 288000 raw Excel cells independently compared','Synthetic inputs only; additional real modules not supplied')
row('Clean outliers','selesai (aturan dan sensitivitas)','Within-year negative/>10*p99 flags; original rows/values retained; clean_* companions exclude flagged values. Shared production program passed 1002-row adversarial cases','Tail flag is diagnostic, not proof of data error; no automatic winsorization. Main fixture may contain no extreme tail')
row('Value logs','selesai (domain valid)','All val_* logs and 12 named logs refreshed after annual mapping; zero/negative/missing excluded from log only','Unverified value-code meanings remain explicit; positive number does not establish semantic validity')
row('Stable analytical names','selesai','3793 original names and meanings retained; legacy mixed capital aliases labelled; additions enumerated in schema-additions.csv','Some annual definitions remain provisional')
row('Panel','selesai (panel sintetis)','100 supplied IDs 800001–800100 across 12 waves, flags dummy=1 and real_verified=0','Genuine real-company link not established; 2016 not invented')
row('Merge WPI','parsial (output berjalan)','1200/1200 output deflated at base 2000 using four explicit fixture-sector bridges; 48 year/sector cells matched; VA single-output-deflator proxy','Appropriate input/capital/wage price series not established. 2020–22 splice and source extraction gaps disclosed. No double deflation')
row('Energy Scope1/Scope2/total','parsial','Observed nine-fuel GJ and purchased-electricity GJ; own generation excluded from additions; strict nine-component and sensitivity companions','Additional fuels/heat and some units/factors incomplete; 2018–19 known unit gap; no claim comprehensive total')
row('Emissions Scope1/Scope2/total','parsial','Nine-fuel combustion CO2 and purchased-electricity CO2; identities checked; no-grid-carry companion','Not full GHG CO2e; post-2014 grid carry and extra fuels/heat not certified')
row('VA/output/capital per worker','selesai sesuai cakupan sumber','VA and output nominal/positive worker; output real and VA real proxy/worker; stock and additions separately divided by worker','Main capital is capital_stock_per_worker; legacy capital_per_worker_nominal remains mixed alias. Later stock definitions/2015 exact additions remain open')
out('row0_status.csv',status)
meta=[('Source','Kolega DEN BPS group description → Working Folder → 2026 - IBS BPS Research Project/WPI_deflator_package'),('Version','OneDrive modified 3 September 2026 22:10 WIB; downloaded 10 September 2026 14:02:23 WIB'),('Index','Actual output WPI, base 2000=100; 131 four-digit ISIC Rev3/3.1 industries'),('Scope','1983–2022 columns; 2016 missing. Pipeline table 2010–2022; 1200 synthetic records omit 2016'),('Splice','Native extension 2013–19 excluding 2016; 2020–22 supplied December2019 link; source uncertainty retained'),('Conversion','deflator_output = wpi_output_index/100; real output = nominal output/deflator_output; Rp000 at 2000 prices'),('Value added','value_added_real = nominal VA/output deflator: explicit single-deflator approximation; not double deflation'),('Other deflators','Appropriate input, capital and wage deflators unavailable; legacy WPIN concept unverified; their real measures remain missing. No WPI=1 fallback'),('Classification','Four detailed synthetic activities mapped explicitly; UN Rev31↔Rev4 bridge and BPS KBLI definitions reviewed; not a general real-data yearly bridge'),('Matched',str(matched)+' / 1200; 48 year/industry cells; source lookup key isic4/year unique'),('Reconstruction','1179 extension values compared to delivered DTA; maximum relative discrepancy <1e-6 from CSV/float precision; delivered DTA values retained'),('Workbook validation','438 monthly annual-average rows recomputed; 12 incomplete monthly rows; 21 claimed newer subsector rows absent; 147 splice cells reconciled at displayed rounding precision'),('Interpretation','All company values are synthetic; actual macro indices do not make this empirical BPS evidence')]
out('wpi_metadata.csv',[dict(item=k,value=v) for k,v in meta])
audit=json.loads((R/'wpi_workbook_audit.json').read_text())
out('wpi_source_gaps.csv',[dict(source_gap=x,status='sumber belum tersedia',impact='See WPI-INTEGRATION.md; no silent fill') for x in audit['unavailable']])
md='# Data preparation baris 0 — hasil sintetis aktual\n\nDTA utama: `results/G0_analysis_ready_SYNTHETIC_CALCULATED.dta`. 1.200 baris, 3.837 kolom (3.793 dipertahankan +44 tambahan), 100 ID sintetis, 12 tahun.\n\n| Komponen Word | Status | Yang dihitung/diperiksa | Batas tersisa |\n|---|---|---|---|\n'
for r in status:md+='| '+' | '.join(r.values())+' |\n'
md+='\n## Ketersediaan inti per tahun\n\nJumlah berikut adalah nilai nonmissing, dari denominator 100 rekaman sintetis per tahun. Angka ini bukan validasi definisi sumber dan bukan estimasi nasional.\n\n| Tahun | Output nominal | Output riil | VA riil proxy | Capital stock | Capital additions | Stock/worker | Scope1 9-fuel GJ | Scope2 GJ |\n|---|---|---|---|---|---|---|---|\n'
fields=['gross_output_nominal','gross_output_real','value_added_real','capital_stock_nominal','capital_additions_nominal','capital_stock_per_worker','gj_fuel_s1','gj_electricity']
lookup={(x['source_year'],x['variable']):x['observed'] for x in cov}
for y in sorted({int(x['source_year']) for x in cov}):md+='| '+str(y)+' | '+' | '.join(lookup[str(y),v] for v in fields)+' |\n'
md+='\nSemua 3.837 variabel beserta missing/zero/negative per tahun ada di `coverage_by_variable_year.csv`; definisi setiap kolom ada di `actual_schema.csv`, definisi tambahan di `contracts/schema-additions.csv`. Readme/Excel bukan pengganti DTA.\n'
(R/'ROW0-STATUS.md').write_text(md)
print('Row0 component status and WPI metadata written from validated output')
