#!/usr/bin/env python3
"""Publication figures from frozen Stata CSVs, with exact annotation operands."""
# WFDOC: Builder memakai CSV agregat nominal yang dibekukan; figur tetap berlabel development, bukan TFP riil final.
from pathlib import Path
import argparse
import hashlib
import json
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib import font_manager
from matplotlib.lines import Line2D
from matplotlib.patches import Patch

HERE=Path(__file__).resolve().parent
FONT=Path('/System/Library/Fonts/Supplemental')
FONTFILES=['Times New Roman.ttf','Times New Roman Bold.ttf','Times New Roman Italic.ttf','Times New Roman Bold Italic.ttf']
for name in FONTFILES:
    assert (FONT/name).is_file()
    font_manager.fontManager.addfont(str(FONT/name))
assert Path(font_manager.findfont('Times New Roman')).name.startswith('Times New Roman')
plt.rcParams.update({'font.family':'Times New Roman','font.size':10,'axes.labelsize':10,'axes.titlesize':10,'legend.fontsize':8.5,'axes.spines.top':False,'axes.spines.right':False,'axes.linewidth':.6,'xtick.major.width':.6,'ytick.major.width':.6,'svg.fonttype':'none','pdf.fonttype':42,'ps.fonttype':42,'savefig.facecolor':'white'})
METHOD={'op':'OP','lp':'LP','acf':'ACF','wrdg':'Wooldridge'}
COLORS={'op':'#8B6E55','lp':'#264C66','acf':'#498276','wrdg':'#8C789C'}


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--results',type=Path,required=True);args=parser.parse_args()
    out=args.results/'outputs' if (args.results/'outputs').is_dir() else args.results
    figs=HERE/'figures';figs.mkdir(exist_ok=True)
    provenance=HERE/'provenance';provenance.mkdir(exist_ok=True)
    trace=[];inventory=[]
    def read(name): return pd.read_csv(out/name,dtype={'sector':str})
    # WFDOC: Setiap angka cetak menyimpan field, kunci baris, hash CSV, nilai sebelum pembulatan, format, teks dan posisi anotasi.
    def annotate(figure,source,row,key,field,scale,fmt,anchor,role):
        value=float(row[field]);printed=format(value*scale,fmt)
        trace.append({'figure':figure,'source_file':source,'source_sha256':hashlib.sha256((out/source).read_bytes()).hexdigest(),'row_key':{k:str(row[k]) for k in key},'field':field,'unrounded_value':value,'display_scale':scale,'decimal_format':fmt,'printed_string':printed,'plotting_anchor':anchor,'role':role})
        return printed
    def save(fig,name,sources,legend):
        for ext in ['pdf','svg','png']: fig.savefig(figs/f'{name}.{ext}',dpi=200)
        inventory.append({'figure':name,'sources':[{'path':f'outputs/{n}','sha256':hashlib.sha256((out/n).read_bytes()).hexdigest()} for n in sources], 'visible_legend':legend,'outputs':[{ 'path':f'figures/{name}.{ext}','sha256':hashlib.sha256((figs/f'{name}.{ext}').read_bytes()).hexdigest()} for ext in ['pdf','svg','png']]})
        plt.close(fig)
    # WFDOC: Point estimate hanya mengambil primary fit_success; interval digambar bila Stata menandai interval_admitted.
    fits=read('nominal_coefficients.csv');good=fits[(fits.variant=='primary')&(fits.status=='fit_success')]
    good=good[good.sample_id.eq('own')]
    sectors=sorted(good.sector.unique());methods=[m for m in METHOD if m in set(good.method)]
    assert len(methods), 'No successful primary own-domain model: review run before plotting'
    support=read('nominal_sample_support.csv');own=support[(support.sample_id=='own')&support.sector.isin(sectors)]
    fig,ax=plt.subplots(figsize=(6.5,3.5));x=np.arange(len(sectors))
    for j,m in enumerate(COLORS):
        g=own[own.method==m].set_index('sector').reindex(sectors).reset_index()
        for i,row in g.iterrows():
            anchor=[float(x[i]+(j-1.5)*.18),float(row.N_dynamic)]
            ax.bar(*anchor,width=.16,color=COLORS[m])
            printed=annotate('sample_support','nominal_sample_support.csv',row,['sector','method','sample_id'],'N_dynamic',1,'.0f',anchor,'bar_count')
            # Stagger adjacent method labels so equal counts remain separate.
            ax.annotate(printed,anchor,xytext=(0,3+9*j),textcoords='offset points',ha='center',va='bottom',fontsize=7 if len(sectors)>8 else 8,color=COLORS[m])
    ax.set_xticks(x,labels=sectors);ax.set_xlabel('Reported two-digit sector');ax.set_ylabel('Eligible consecutive-year records');ax.set_ylim(0,max(1,float(own.N_dynamic.max()))*1.35)
    ax.legend(handles=[Patch(color=COLORS[m],label=METHOD[m]) for m in COLORS],ncol=4,frameon=False,loc='upper right')
    fig.subplots_adjust(left=.11,right=.985,bottom=.20,top=.96)
    save(fig,'sample_support',['nominal_sample_support.csv'],['OP','LP','ACF','Wooldridge'])

    boot=read('nominal_bootstrap_summary.csv');co=good.merge(boot,on=['sector','method','sample_id'],suffixes=('','_bootstrap')).sort_values(['sector','method']).reset_index(drop=True)
    fig,axes=plt.subplots(1,2,figsize=(6.5,min(6.8,max(3.6,.145*len(co)+1.0))),sharey=True)
    for j,term in enumerate(['L','K']):
        ax=axes[j]
        for i,row in co.iterrows():
            value=float(row[f'beta_{term}']);lo=float(row[f'ci_{term}_lo']);hi=float(row[f'ci_{term}_hi'])
            if row.interval_admitted: ax.plot([lo,hi],[i,i],color='#777777',lw=1)
            ax.plot(value,i,'o',color='black',ms=2.7)
            rawrow=good[(good.sector==row.sector)&(good.method==row.method)&(good.sample_id==row.sample_id)].iloc[0]
            printed=annotate('coefficients','nominal_coefficients.csv',rawrow,['sector','method','sample_id','variant'],f'beta_{term}',1,('.3f' if term=='L' else '.4f'),[value,float(i)],'point_estimate')
            ax.text(1.015,i,printed,transform=ax.get_yaxis_transform(),va='center',ha='left',fontsize=7.8)
        ax.axvline(0,color='#CCCCCC',lw=.6,zorder=0);ax.set_title('Labor elasticity' if term=='L' else 'Beginning-capital elasticity');ax.set_xlabel('Coefficient')
    axes[0].set_yticks(range(len(co)),labels=[f'{r.sector} {METHOD[r.method]}' for r in co.itertuples()],fontsize=8);axes[0].invert_yaxis()
    fig.legend(handles=[Line2D([0],[0],marker='o',ls='',color='black',ms=3,label='Point estimate (number)'),Line2D([0],[0],color='#777777',lw=1,label='95% percentile interval')],loc='lower center',ncol=2,frameon=False,bbox_to_anchor=(.55,.015))
    fig.subplots_adjust(left=.17,right=.90,top=.92,bottom=.20,wspace=.48)
    save(fig,'coefficients',['nominal_coefficients.csv','nominal_bootstrap_summary.csv'],['Point estimate (number)','95% percentile interval'])

    # WFDOC: Distribusi memakai bin yang diekspor Stata; angka anotasi menandai bin pertama, modal dan terakhir yang terisi.
    hist=read('nominal_histogram_bins.csv');h=hist[(hist.sector=='ALL')&(hist.sample_id=='own')&(hist.measure=='centered')]
    fig,axes=plt.subplots(1,len(methods),figsize=(6.5,3.8),sharey=True,squeeze=False);axes=axes[0]
    for ax,m in zip(axes,methods):
        g=h[h.method==m].sort_values('bin_lower').reset_index(drop=True)
        centers=(g.bin_lower+g.bin_upper)/2;ax.bar(centers,100*g.share,width=.48,color=COLORS[m]);ax.set_title(METHOD[m])
        ax.set_xlabel('Centered log residual');ax.set_ylim(0,100*g.share.max()*1.70)
        chosen=sorted(set([0,int(g.share.idxmax()),len(g)-1]))
        for j,idx in enumerate(chosen):
            row=g.iloc[idx];anchor=[float((row.bin_lower+row.bin_upper)/2),float(100*row.share)]
            percent=annotate('distribution','nominal_histogram_bins.csv',row,['sector','method','sample_id','measure','bin_lower'],'share',100,'.3f',anchor,'selected_bin_share')
            count=annotate('distribution','nominal_histogram_bins.csv',row,['sector','method','sample_id','measure','bin_lower'],'N_bin',1,'.0f',anchor,'selected_bin_count')
            xpos=[.015,.5,.985][j] if len(chosen)==3 else .5
            ypos=.94 if j!=1 else .86
            ax.annotate(percent+'%\n(n='+count+')',xy=anchor,xycoords='data',xytext=(xpos,ypos),textcoords='axes fraction',ha=['left','center','right'][j] if len(chosen)==3 else 'center',va='top',fontsize=7.5,arrowprops={'arrowstyle':'-','lw':.5,'color':'black'})
        ax.tick_params(axis='x',labelsize=8)
    axes[0].set_ylabel('Share of fitted records (%)')
    fig.legend(handles=[*[Patch(color=COLORS[m],label=METHOD[m]) for m in methods],Line2D([0],[0],color='black',lw=.5,label='Labels: first, modal and last occupied bins')],loc='lower center',ncol=2,frameon=False,bbox_to_anchor=(.55,.005))
    fig.subplots_adjust(left=.10,right=.99,top=.92,bottom=.34,wspace=.16)
    save(fig,'distribution',['nominal_histogram_bins.csv'],[*[METHOD[m] for m in methods],'Labels: first, modal and last occupied bins'])

    # WFDOC: Heatmap menampilkan Spearman pairwise pada sampel own per sektor; pasangan tanpa prediksi bersama diberi sel abu-abu.
    pairs=read('nominal_pairwise_comparisons.csv');p=pairs[(pairs.sample_id=='own')&(pairs.comparison_scope=='pairwise')&pairs.sector.isin(sectors)].copy();p['pair']=p.method_a.map(METHOD)+' / '+p.method_b.map(METHOD)
    matrix=p.pivot(index='pair',columns='sector',values='rho_spearman').reindex(columns=sectors)
    fig,ax=plt.subplots(figsize=(6.5,3.25));cmap=plt.colormaps['Blues'].copy();cmap.set_bad('#EEEEEE');im=ax.imshow(matrix.to_numpy(),vmin=-1,vmax=1,cmap=cmap,aspect='auto')
    ax.set_yticks(range(len(matrix)),labels=matrix.index,fontsize=9);ax.set_xticks(range(len(sectors)),labels=sectors);ax.set_xlabel('Reported two-digit sector');ax.tick_params(length=0)
    for i,pairname in enumerate(matrix.index):
        for j,sector in enumerate(sectors):
            row=p[(p.pair==pairname)&(p.sector==sector)].iloc[0];value=row.rho_spearman
            printed='—' if pd.isna(value) else annotate('rank_comparison','nominal_pairwise_comparisons.csv',row,['sector','sample_id','method_a','method_b','comparison_scope'],'rho_spearman',1,'.3f',[float(j),float(i)],'matrix_correlation')
            ax.text(j,i,printed,ha='center',va='center',fontsize=9,color='white' if pd.notna(value) and value>.62 else 'black')
    cb=fig.colorbar(im,ax=ax,fraction=.028,pad=.025);cb.ax.tick_params(labelsize=8)
    fig.legend(handles=[Patch(facecolor='#EEEEEE',edgecolor='#CCCCCC',label='No shared predictions'),Patch(facecolor=plt.colormaps['Blues'](.7),label='Darker shading: higher rank agreement')],loc='lower center',ncol=2,frameon=False,bbox_to_anchor=(.54,.02))
    fig.subplots_adjust(left=.24,right=.92,top=.98,bottom=.24)
    save(fig,'rank_comparison',['nominal_pairwise_comparisons.csv'],['No shared predictions','Darker shading: higher rank agreement'])

    # WFDOC: Rank scatter merangkum bin rank yang diekspor dan memberi label koordinat di kedua ujung; garis putus-putus berarti rank sama.
    scatter=read('nominal_rank_scatter_bins.csv');s=scatter[(scatter.sector=='ALL')&(scatter.sample_id=='own')&(scatter.comparison_scope=='pairwise')]
    from itertools import combinations
    combos=list(combinations(methods,2));ncols=min(3,len(combos));nrows=int(np.ceil(len(combos)/ncols))
    fig,axes=plt.subplots(nrows,ncols,figsize=(6.5,2.8*nrows+.6),sharex=True,sharey=True,squeeze=False);axes=axes.ravel()
    for ax in axes[len(combos):]: ax.axis('off')
    for ax,(a,b) in zip(axes,combos):
        g=s[(s.method_a==a)&(s.method_b==b)].sort_values('rank_bin')
        ax.plot([0,1],[0,1],ls='--',lw=.7,color='#999999');ax.plot(g.mean_rank_x,g.mean_rank_y,'o-',lw=.6,ms=2.5,color='#264C66')
        ax.set_title(METHOD[a]+' / '+METHOD[b]);ax.set_xlabel(METHOD[a]+' mean rank');ax.set_xlim(0,1);ax.set_ylim(0,1)
        for idx in (sorted(set([0,len(g)-1])) if len(g) else []):
            row=g.iloc[idx];anchor=[float(row.mean_rank_x),float(row.mean_rank_y)]
            xtext=annotate('rank_scatter','nominal_rank_scatter_bins.csv',row,['sector','sample_id','method_a','method_b','comparison_scope','rank_bin'],'mean_rank_x',1,'.3f',anchor,'endpoint_mean_rank_x')
            ytext=annotate('rank_scatter','nominal_rank_scatter_bins.csv',row,['sector','sample_id','method_a','method_b','comparison_scope','rank_bin'],'mean_rank_y',1,'.3f',anchor,'endpoint_mean_rank_y')
            ax.annotate('('+xtext+', '+ytext+')',anchor,xytext=(3,-12 if idx else 7),textcoords='offset points',ha='right' if idx else 'left',fontsize=7)
    axes[0].set_ylabel('Second-method mean rank')
    fig.legend(handles=[Line2D([0],[0],marker='o',color='#264C66',lw=.6,ms=3,label='Mean rank in bins (at least five records)'),Line2D([0],[0],ls='--',color='#999999',lw=.7,label='Equal rank')],loc='lower center',ncol=1,frameon=False,bbox_to_anchor=(.55,.005))
    fig.subplots_adjust(left=.09,right=.98,top=.90,bottom=.18,wspace=.17,hspace=.55)
    save(fig,'rank_scatter',['nominal_rank_scatter_bins.csv'],['Mean rank in bins (at least five records)','Equal rank'])

    # Fixed variants remain visible, including failed or unsupported cells.
    variants=['primary','low_l','high_l','poly2']
    fig,axes=plt.subplots(1,len(methods),figsize=(6.5,max(3.8,min(6.0,.26*len(sectors)+1.4))),sharey=True,squeeze=False);axes=axes[0]
    success=fits[(fits.method.isin(methods)) & fits.sample_id.eq('own') & fits.status.eq('fit_success')]
    maximum=float(success.beta_L.max());minimum=float(success.beta_L.min())
    cmap=plt.colormaps['Greys'].copy();cmap.set_bad('#E6EEF5')
    for ax,m in zip(axes,methods):
        g=success[success.method.eq(m)]
        values=g.pivot(index='sector',columns='variant',values='beta_L').reindex(index=sectors,columns=variants)
        im=ax.imshow(values.to_numpy(),vmin=minimum,vmax=maximum,cmap=cmap,aspect='auto')
        for i,sector in enumerate(sectors):
            for j,v in enumerate(variants):
                hit=g[g.variant.eq(v)&g.sector.eq(sector)]
                if len(hit):
                    row=hit.iloc[0];value=float(row.beta_L)
                    printed=annotate('sensitivity','nominal_coefficients.csv',row,['sector','method','sample_id','variant'],'beta_L',1,'.3f',[float(j),float(i)],'all_fixed_variant_labor_coefficient')
                else:
                    value=np.nan;printed='—'
                ax.text(j,i,printed,ha='center',va='center',fontsize=6.3,color='white' if np.isfinite(value) and (value-minimum)/max(maximum-minimum,1e-12)>.60 else 'black')
        ax.set_title(METHOD[m]);ax.set_xticks(range(4),labels=['Cubic','Low L','High L','Quad.'],rotation=65,ha='right',fontsize=7);ax.tick_params(length=0)
    axes[0].set_yticks(range(len(sectors)),labels=sectors,fontsize=8);axes[0].set_ylabel('Reported sector')
    fig.subplots_adjust(left=.09,right=.98,top=.92,bottom=.36,wspace=.12)
    cax=fig.add_axes([.25,.14,.50,.025]);cb=fig.colorbar(im,cax=cax,orientation='horizontal');cb.set_label('Labor elasticity: darker cells indicate larger coefficients',fontsize=8);cb.ax.xaxis.set_label_position('top');cb.ax.tick_params(labelsize=8)
    fig.legend(handles=[Patch(facecolor='#E6EEF5',label='No successful fit for this specification')],loc='lower center',frameon=False,bbox_to_anchor=(.54,.005))
    save(fig,'sensitivity',['nominal_coefficients.csv'],['Labor elasticity: darker cells indicate larger coefficients','No successful fit for this specification'])
    # WFDOC: Trace angka dan manifest gambar mencatat operand, CSV/hash, font dan hash PDF/SVG/PNG.
    (provenance/'figure-annotations.json').write_text(json.dumps(trace,indent=2)+'\n')
    (provenance/'figure-manifest.json').write_text(json.dumps({'data_label':'G0.5 DEVELOPMENT — nominal production residuals; not final real TFP','font_mapping':[{'file':str(FONT/n),'sha256':hashlib.sha256((FONT/n).read_bytes()).hexdigest()} for n in FONTFILES],'figures':inventory},indent=2)+'\n')
    print(json.dumps({'figures':len(inventory),'numeric_annotations':len(trace),'font':'Times New Roman'}))


if __name__=='__main__': main()
