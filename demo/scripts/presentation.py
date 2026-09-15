"""Format Stata exports into a local workbook, SVG figures and a TeX companion."""
import csv
import math
from pathlib import Path
from workflow import load,write_json,sha

COUNT_FIELDS={'source_year','rows','n','observed','missing_rows','zero','zeros','negative','negatives','columns','missing_firm_ids','panel_ready','firms','multiwave_firms','adjacent_year_links','longer_calendar_gap_links','links','gap'}
COUNT_FIELDS.update({'numeric_cells','different_cells','all_keys_exact','roundtrip_pass','observed_denominator','set_id','required_test_fields','observed_test_fields','carry_flag'})
TEXT_FIELDS={'variable','storage','label','data_mode','bound_field','release_status','scope','variant','artifact','source','gate_status','unit','status'}


def typed(value, field):
    if value in ['', '.']: return None
    if field in TEXT_FIELDS: return value
    try:
        x=float(value)
        if not math.isfinite(x):return value
        if field in COUNT_FIELDS or x.is_integer() and abs(x)<2**53:return int(x)
        return x
    except ValueError:return value


def read_csv(path):
    with path.open(newline='') as f:
        reader=csv.DictReader(f);return reader.fieldnames,list(reader)


def workbook(run):
    from openpyxl import Workbook,load_workbook
    from openpyxl.styles import Font,PatternFill,Alignment
    from openpyxl.workbook.properties import CalcProperties
    from openpyxl.utils import get_column_letter
    from openpyxl.comments import Comment
    state=load(run/'run.json');wb=Workbook();overview=wb.active;overview.title='START HERE'
    wb.calculation=CalcProperties(calcId=191029,fullCalcOnLoad=True,forceFullCalc=True,calcMode='auto')
    blue='153C56';light='E9F1F5';sources=[]
    overview.append(['DEASY–IMED | Run results',''])
    overview.append(['Input profile',state['config']['profile']])
    overview.append(['Data mode',state['config']['mode']])
    overview.append(['Rows',state['input_schema']['rows']])
    overview.append(['Columns',state['input_schema']['columns']])
    overview.append(['Input SHA256',state['input_sha256']])
    overview.append(['Interpretation','Preparation and diagnostics; no TFP or other estimator executed.'])
    overview.append(['Identity','Fictional development IDs are not evidence of actual company continuity.'])
    overview.append(['Source','Selected annual inputs and native Stata calculations; see run.json.'])
    overview.append(['Notes','CSV retains the statistical export precision. Excel is a readable companion. Missing values are blank, not zero.'])
    overview.append(['Upstream stage','Status before workbook creation'])
    for stage,rec in state['stages'].items():
        if stage not in {'workbook','figures'}:overview.append([stage,rec['status']])
    overview.append(['Workbook validation','workbook-validation.json records the saved-file checks; STATUS.md records final stage outcomes.'])
    overview.column_dimensions['A'].width=30;overview.column_dimensions['B'].width=100
    overview.sheet_view.showGridLines=False
    for row in overview:
        for cell in row:
            cell.font=Font(name='Times New Roman',size=12)
            cell.alignment=Alignment(wrap_text=True,vertical='top')
        overview.row_dimensions[row[0].row].height=31 if row[0].row>1 else 28
    overview.merge_cells('A1:B1')
    overview.freeze_panes='B2'
    # All available exported tables are included; absent stages create no invented sheets.
    paths=sorted((run/'tables').rglob('*.csv'))+[run/'reports/input_check.csv']
    if (run/'reports/wave_counts.csv').exists():paths.append(run/'reports/wave_counts.csv')
    expectations=[]
    for index,path in enumerate(paths,1):
        print(f"EXCEL | sheet {index}/{len(paths)} | {path.stem}",flush=True)
        headers,rows=read_csv(path)
        title=(f'{index:02d} '+path.stem)[:31];ws=wb.create_sheet(title)
        ws.append([path.stem.replace('_',' ').title()])
        ws.append(['Source',str(path.relative_to(run)),sha(path)])
        ws.append(['Notes',f'{state["config"]["mode"]}; values calculated in Stata. Blank = missing.'])
        ws.append(headers)
        for row in rows:
            ws.append([typed(row[h],h) for h in headers])
        for row in ws.iter_rows():
            for cell in row:
                if isinstance(cell.value,str):cell.data_type='s'
                cell.font=Font(name='Times New Roman',size=12)
                cell.alignment=Alignment(vertical='top')
        for cell in ws[4]:
            cell.fill=PatternFill('solid',fgColor=blue);cell.font=Font(name='Times New Roman',bold=True,color='FFFFFF',size=12)
            cell.alignment=Alignment(wrap_text=True,vertical='center')
        ws.row_dimensions[4].height=44
        if len(headers)>1:
            last=get_column_letter(len(headers))
            ws.merge_cells(f'B2:{last}2');ws.merge_cells(f'B3:{last}3')
            ws['A2'].comment=Comment('Source CSV SHA256: '+sha(path),'Natanael')
            ws['B2'].alignment=Alignment(wrap_text=True,vertical='top')
            ws['B3'].alignment=Alignment(wrap_text=True,vertical='top')
            ws.row_dimensions[2].height=44;ws.row_dimensions[3].height=44
        for col,h in enumerate(headers,1):
            values=[ws.cell(r,col).value for r in range(5,len(rows)+5)]
            strings=[v for v in values if isinstance(v,str)]
            count=h in COUNT_FIELDS or h.startswith('n_') or h.endswith('_n')
            if strings:
                width=max(22,min(58,max(map(len,strings))+2))
            else:
                printed=[format(v,',.0f' if count else ',.6f') for v in values if isinstance(v,(int,float))]
                width=max(18,min(40,max(map(len,printed),default=0)+3))
            ws.column_dimensions[get_column_letter(col)].width=width
            for rownum in range(5,len(rows)+5):
                cell=ws.cell(rownum,col)
                cell.number_format='0' if h=='source_year' else '#,##0' if count else '#,##0.000000;[Red](#,##0.000000)' if not isinstance(cell.value,str) else 'General'
                if isinstance(cell.value,str):
                    cell.alignment=Alignment(wrap_text=True,vertical='top')
                    height=16*max(1,math.ceil(len(cell.value)/max(width-3,1)))
                    ws.row_dimensions[rownum].height=max(ws.row_dimensions[rownum].height or 16,height)
        ws.freeze_panes='C5';ws.auto_filter.ref=f'A4:{get_column_letter(len(headers))}{max(4,len(rows)+4)}'
        ws.sheet_view.showGridLines=False
        expectations.append((title,headers,rows,path))
        sources.append({'sheet':title,'csv':str(path.relative_to(run)),'sha256':sha(path),'rows':len(rows)})
    for ws in wb:
        for cell in ws[1]:cell.font=Font(name='Times New Roman',size=16,bold=True,color=blue)
        ws.row_dimensions[1].height=26
    target=run/'reports/Deasy-Imed-results.xlsx';print('EXCEL | menyimpan workbook...',flush=True);wb.save(target)
    print('EXCEL | membuka kembali dan membandingkan semua nilai dengan CSV Stata',flush=True)
    check=load_workbook(target,read_only=True,data_only=False)
    assert check.sheetnames==['START HERE']+[x[0] for x in expectations]
    assert check.calculation.calcMode=='auto' and check.calculation.fullCalcOnLoad
    cells=0;max_relative_error=0
    for title,headers,rows,path in expectations:
        ws=check[title];assert ws.max_row==len(rows)+4
        saved=ws.iter_rows(min_row=5,values_only=True)
        for original,actual in zip(rows,saved):
            for h,val in zip(headers,actual):
                expected=typed(original[h],h);cells+=1
                if isinstance(expected,(int,float)):
                    assert isinstance(val,(int,float))
                    relative=abs(val-expected)/max(abs(expected),1)
                    max_relative_error=max(max_relative_error,relative)
                    assert relative<1e-14,(title,h)
                else:assert val==expected,(title,h)
    check.close()
    write_json(run/'reports/workbook-validation.json',{'status':'PASS','workbook_sha256':sha(target),'sheets':len(wb.sheetnames),
        'cells_compared_to_Stata_CSV':cells,'maximum_scaled_numeric_roundtrip_error':max_relative_error,
        'formula_count':0,'auto_calculation':True,'source_tables':sources})


LABELS={
'workers':('Employment','Workers',1,0),
'gross_output_nominal':('Gross output','Million source units',1e6,2),
'value_added_nominal':('Reported value added','Million source units',1e6,2),
'intermediate_inputs_nominal':('Intermediate inputs','Million source units',1e6,2),
'val_rtlvcu':('Materials expenditure','Million source units',1e6,2),
'val_efuvcu':('Fuel expenditure','Million source units',1e6,2),
'elec_pln_kwh':('Purchased PLN electricity','kWh',1,0),
'val_zpdvcu':('Production payroll source field','Million source units',1e6,2),
'val_zndvcu':('Other payroll source field','Million source units',1e6,2),
'production_workers':('Production employment','Workers',1,0),
'capital_stock_nominal':('Reported capital stock','Million source units',1e6,2),
'capital_additions_nominal':('Capital additions','Million source units',1e6,2),
'import_value_nominal':('Reported imports','Million source units',1e6,2),
'r_elec_purchased_kwh':('Purchased electricity','kWh',1,0),
'r_gj_electricity':('Purchased electricity energy','GJ',1,2),
'total_gj_s1':('Legacy energy total (scenario 1)','GJ',1,2),
'r_co2_scope1_s1':('Retained scope 1 emissions','Tonnes of CO2',1,2),
'r_co2_scope2_s1':('Retained scope 2 emissions','Tonnes of CO2',1,2),
'r_co2_total_s1':('Retained combined emissions','Tonnes of CO2',1,2),
'rd_cost_nominal':('Reported R&D expenditure','Million source units',1e6,2),
'rd_workers':('Reported R&D employment','Workers',1,0),

}


def tex_escape(text):
    return str(text).replace('\\',r'\textbackslash{}').replace('_',r'\_').replace('&',r'\&').replace('%',r'\%').replace('#',r'\#')


def figures(run):
    import numpy as np
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    from matplotlib.font_manager import findfont,FontProperties
    from matplotlib.lines import Line2D
    from matplotlib.patches import Patch
    state=load(run/'run.json');source=run/'tables/descriptive_statistics.csv'
    if not source.exists():
        write_json(run/'reports/figure-trace.json',{'status':'not_applicable','reason':'RUN_SUMMARIES=0 and no summary CSV exists'})
        (run/'reports/writeup.tex').write_text('% No summaries selected; no figure or result is invented.\n')
        return
    font_path=findfont(FontProperties(family='Times New Roman'),fallback_to_default=False)
    plt.rcParams.update({'font.family':'Times New Roman','font.size':11,'svg.fonttype':'path','axes.spines.top':False,'axes.spines.right':False})
    _,rows=read_csv(source);variables=list(dict.fromkeys(r['variable'] for r in rows));trace=[];figures=[]
    years=list(range(min(state['years']),max(state['years'])+1));color='#18576D';missing_color='#E9ECEF'
    for figure_number,var in enumerate(variables,1):
        print(f"GRAFIK | {figure_number}/{len(variables)} | {var}",flush=True)
        group=[r for r in rows if r['variable']==var]
        if not any(int(r['n']) for r in group):continue
        label,unit,scale,precision=LABELS.get(var,(var.replace('_',' ').capitalize(),'Source units',1,2))
        seen={int(r['source_year']):r for r in group}
        values=[float(r[f])/scale for r in group for f in ['p25','p50','p75'] if r[f] not in ['','.'] and float(r[f])>0]
        # A fixed precision for this entire measure prevents tiny positive quartiles becoming zero.
        if values:
            precision=max(precision,min(10,max(0,math.ceil(-math.log10(min(values)))+1)))
        fmt=f',.{precision}f'
        fig=plt.figure(figsize=(11.6,max(5.5,.38*len(years)+2.8)))
        gs=fig.add_gridspec(1,2,width_ratios=[1.6,1],left=.08,right=.96,top=.80,bottom=.27,wspace=.13)
        ax=fig.add_subplot(gs[0]);tab=fig.add_subplot(gs[1],sharey=ax);tab.set_xlim(0,3);tab.set_axis_off()
        ycoords={year:i for i,year in enumerate(years)}
        for year in years:
            y=ycoords[year]
            if year not in seen:
                ax.axhspan(y-.43,y+.43,color=missing_color,zorder=0)
                for j in range(3):tab.text(j+.5,y,'—',ha='center',va='center',color='#68737B')
                continue
            row=seen[year]
            vals=[None if row[f] in ['', '.'] else float(row[f])/scale for f in ['p25','p50','p75']]
            if int(row['n'])>0:
                ax.plot([vals[0],vals[2]],[y,y],color=color,lw=2.1,zorder=2)
                ax.plot(vals[1],y,'o',color=color,ms=5,zorder=3)
            for j,(field,value) in enumerate(zip(['p25','p50','p75'],vals)):
                printed='—' if value is None else format(value,fmt)
                tab.text(j+.5,y,printed,ha='center',va='center',fontweight='bold' if j==1 else 'normal',fontsize=10)
                trace.append({'figure':var+'.svg','source_csv':str(source.relative_to(run)),'source_sha256':sha(source),
                    'variable':var,'source_year':year,'field':field,'source_value':None if value is None else float(row[field]),
                    'divisor':scale,'format':fmt,'printed':printed,'chart_anchor':None if value is None else [value,y]})
        for j,h in enumerate(['25th percentile','Median','75th percentile']):tab.text(j+.5,1.015,h,transform=tab.get_xaxis_transform(),ha='center',va='bottom',fontsize=10,fontweight='bold')
        ax.set_yticks(list(ycoords.values()),list(ycoords));ax.set_ylim(len(years)-.45,-.8)
        ax.set_xlabel(unit);ax.grid(axis='x',alpha=.17);ax.set_axisbelow(True)
        fig.suptitle(label+' across annual samples',x=.08,y=.96,ha='left',fontsize=19,fontweight='bold')
        basis=('Development data · fictional company links' if state['config']['profile'] in ['excel_demo','g05_full'] else 'Development data · identity method recorded separately') if state['config']['mode']=='development' else 'Actual values · identity status recorded separately'
        fig.text(.08,.905,basis,fontsize=11,color='#536572')
        fig.legend(handles=[Line2D([0],[0],color=color,lw=2,label='25th–75th percentile'),Line2D([0],[0],marker='o',lw=0,color=color,label='Median (bold value)'),Patch(color=missing_color,label='No annual file'),Line2D([0],[0],marker='$—$',lw=0,color='#68737B',label='Unavailable value')],
                   loc='lower left',bbox_to_anchor=(.07,.12),ncol=2,frameon=False,fontsize=10)
        source_label=('G0.5 v3 annual Excel views' if state['config']['profile']=='excel_demo' else 'G0.5 v3 full development data' if state['config']['mode']=='development' and state['config']['profile']=='g05_full' else 'Accepted local G0 master' if state['config']['profile']=='g05_full' else 'Configured Excel/DTA source files')
        fig.text(.08,.070,'Source: '+source_label+'; authors’ calculations in Stata.',fontsize=9)
        fig.text(.08,.039,'Notes: All available quartiles are shown. Signed values and missing years remain visible; no observations are trimmed.',fontsize=9)
        if var.startswith('r_co2_') or var=='total_gj_s1':
            fig.text(.08,.014,'Energy and emissions retain the source conversion assumptions and coverage limits; these are diagnostic totals.',fontsize=9)
        target=run/'figures'/f'{var}.svg';fig.savefig(target)
        fig.savefig(run/'scratch'/f'{var}-qa.png',dpi=100)
        plt.close(fig)
        figures.append({'path':str(target.relative_to(run)),'sha256':sha(target),'variable':var,'precision':precision,'divisor':scale})
    # Verify each annotation against its source cell, independently of plotting coordinates.
    index={(r['variable'],int(r['source_year'])):r for r in rows}
    for item in trace:
        raw=index[(item['variable'],item['source_year'])][item['field']]
        expected='—' if raw in ['', '.'] else format(float(raw)/item['divisor'],item['format'])
        assert item['printed']==expected
    write_json(run/'reports/figure-trace.json',{'status':'PASS','font':'Times New Roman','font_file':font_path,
        'source_sha256':sha(source),'figures':figures,'annotations':trace,'annotation_count':len(trace),'PDF_built':False})
    sample=run/'reports/input_check.csv';_,counts=read_csv(sample);count=counts[0]
    tex='''% Standalone LaTeX companion. Compile with XeLaTeX if desired; this run creates no PDF.
\\documentclass[11pt]{article}
\\usepackage{fontspec,booktabs,geometry}
\\setmainfont{Times New Roman}
\\geometry{margin=1in}
\\begin{document}
\\section*{Input preparation and descriptive checks}
'''
    tex+=f"We normalize the selected inputs into a common observation-level interface and retain their annual coverage. This run contains {int(count['rows']):,} observations and {int(count['columns']):,} columns. The data mode is {tex_escape(state['config']['mode'])}.\\par\n"
    tex+='We preserve missing measurements, reported signs and calendar gaps. Supplied identifiers retain their continuity; generated identifiers describe fictional development links and do not identify actual establishments.\\par\n'
    tex+='\\begin{center}\\begin{tabular}{lr}\\toprule Item & Count \\\\ \\midrule\n'
    tex+=f"Observations & {int(count['rows']):,} \\\\ \nColumns & {int(count['columns']):,} \\\\ \nMissing firm identifiers & {int(count['missing_firm_ids']):,} \\\\ \n"
    tex+='\\bottomrule\\end{tabular}\\end{center}\n\\noindent Source: Selected annual inputs; authors\' calculations in Stata.\\par\n\\noindent Notes: These counts audit the prepared input, not the validity or completion of a downstream estimator.\\par\n'
    tex+='The accompanying vector figures report each available annual median and interquartile range. We present every plotted quartile numerically and mark years without an input file. Variation in these summaries describes the selected inputs; it does not establish a causal effect or actual establishment transitions.\n\\end{document}\n'
    (run/'reports/writeup.tex').write_text(tex)
