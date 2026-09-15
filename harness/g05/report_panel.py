#!/usr/bin/env python3
"""Publication-ready aggregate diagnostics for the fictional panel, no estimates."""
import json
import os
from pathlib import Path
import tempfile
os.environ.setdefault('MPLCONFIGDIR', str(Path(tempfile.gettempdir())/'g05-panel-mpl'))
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

BASE=Path(__file__).resolve().parents[2]/'data/g0-5-development'


def report():
    r=json.loads((BASE/'panel-generation.json').read_text());t=r['transitions']
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'svg.fonttype':'none',
                         'axes.spines.top':False,'axes.spines.right':False,'axes.spines.left':False,
                         'axes.edgecolor':'#c5cdd7','xtick.color':'#526172','ytick.color':'#526172'})
    fig,(a,b)=plt.subplots(1,2,figsize=(14,7),gridspec_kw={'width_ratios':[1.3,1]})
    fig.patch.set_facecolor('white'); fig.subplots_adjust(top=.71,bottom=.25,wspace=.34,left=.12,right=.97)
    fig.text(.07,.93,'G0.5  /  DEVELOPMENT PANEL',fontsize=11,color='#147d92',weight='bold')
    fig.text(.07,.865,f"{r['rows']:,} observations form {r['synthetic_firms']:,} fictional firms",fontsize=24,color='#183153',weight='bold')
    fig.text(.07,.81,'Nine continuous variables • compulsory province × sector • optional one-to-one matching',fontsize=12,color='#526172')
    y=np.arange(len(t));matched=np.array([x['matched'] for x in t]);new=np.array([x['new_current'] for x in t])
    a.barh(y,matched,color='#147d92',label='Matched to prior supplied wave',height=.65)
    a.barh(y,new,left=matched,color='#dbe3eb',label='New fictional ID',height=.65)
    a.set_yticks(y,[f"{x['from_year']} → {x['to_year']}" for x in t]);a.invert_yaxis()
    a.set_xlabel('Observations in the receiving wave');a.set_title('Matched records by transition',loc='left',pad=15,weight='bold',color='#183153')
    fig.legend(*a.get_legend_handles_labels(),loc='upper left',bbox_to_anchor=(.12,.19),ncol=2,frameon=False,fontsize=9)
    a.set_axisbelow(True);a.grid(axis='x',alpha=.16)
    dist=r['firm_wave_count_distribution'];x=np.array([int(k) for k in dist]);counts=np.array(list(dist.values()))
    b.bar(x,counts,color=['#dbe3eb' if i==1 else '#147d92' for i in x],width=.68)
    b.set_xticks(x);b.set_xlabel('Number of supplied waves per fictional firm')
    b.set_title(f"{r['firms_multiple_waves']:,} firms span multiple waves",loc='left',pad=15,weight='bold',color='#183153')
    b.set_ylabel('Fictional firms');b.set_axisbelow(True);b.grid(axis='y',alpha=.16)
    for i,n in zip(x,counts):
        if i in {1,2,6,12}:b.text(i,n+80,f'{n:,}',ha='center',fontsize=9,color='#183153')
    b.set_ylim(0,max(counts)*1.13)
    fig.text(.07,.08,'SIMULATION ONLY. Similarity-based continuity is constructed, not recovered actual company identity.',fontsize=10,color='#9b532a')
    fig.text(.07,.047,'2015 → 2017 remains a two-calendar-year gap. Unmatched records are not evidence of actual entry or closure.',fontsize=9,color='#526172')
    for ext in ['svg','png']:fig.savefig(BASE/f'panel-diagnostics.{ext}',dpi=150,facecolor='white')
    plt.close(fig)


if __name__=='__main__':report()
