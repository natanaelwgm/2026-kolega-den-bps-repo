"""Format validated Stata aggregates into native tables and linked scientific prose.

This module does not estimate models or reconstruct firm-level statistics. All
values come from the released N08--N13 CSVs; each displayed cell uses the parent
builder's source-row trace callback.
"""
from pathlib import Path
import json
import re

METHOD={'lp':'LP','op':'OP','acf':'ACF','wrdg':'Wooldridge'}
INPUT={'y':'Value added','l':'Workers','k_end':'December stock','k_begin':'Beginning capital','i':'Capital additions','m':'Materials'}
SCOPE={'all':'All predictions','in_fit':'In dynamic fit','outside_fit':'Outside dynamic fit'}

def build(data,one,cell,val,table,sectors,figure,pub):
    out={}
    # WFDOC: Tahun positif berasal dari CSV yang tersedia; source_year=0 hanya label pooled dan tidak dipakai sebagai tanggal kalender.
    source_years=sorted(int(y) for y in data['deep_input_domains'].source_year.unique() if y>0)
    annual_years=sorted(int(y) for y in data['deep_prediction_profiles'].source_year.unique() if y>0)
    production_years=sorted(int(y) for y in data['deep_input_domains'].loc[data['deep_input_domains'].production_year_supported.eq(1),'source_year'].unique() if y>0)
    fits=data['nominal_coefficients'].query("sample_id == 'own' and variant == 'primary' and status == 'fit_success'")
    def c(name,r,field,anchor,fmt='.3f',display=None): return cell(name,r,field,'deep:'+anchor,fmt,display)
    def v(name,r,field,anchor,fmt='.3f'): return val(name,r,field,'deep:'+anchor,fmt)
    def ref(file): return '\\GOneInput{tables/'+file+'}\n'
    def methodrow(name,m,**kw): return one(name,method=m,sample_id='own',**kw)
    # The annual table separates observable positivity from the concept/timing gate.
    name='deep_input_domains'; rows=[]
    for year in source_years:
        rr=one(name,source_year=year,input='y')
        row=[c(name,rr,'source_year',f'annual:{year}:year',',.0f'),c(name,rr,'N_source',f'annual:{year}:N',',.0f')]
        for inp in ['y','l','k_end','k_begin','i','m']:
            r=one(name,source_year=year,input=inp)
            row.append(c(name,r,'N_log_usable',f'annual:{year}:{inp}',',.0f'))
        rows.append(row)
    table('deep_input_availability.tex','Input availability by year','deep-input-availability','lrrrrrrr',['Year','Source $N$','$y$','$l$',r'$k^{\rm end}$','$k$','$i$','$m$'],rows,'We count usable values separately for each variable, before requiring complete inputs and consecutive years. We take logs only of positive amounts. We assume that reported stocks describe year-end capital and reported additions describe investment throughout the available years. Beginning capital uses only the immediately preceding calendar-year stock. The documentary flags remain separate evidence and do not restrict eligibility under these assumptions. The supplied files have no 2016 sample; we preserve that gap rather than supplying a one-year lag across it.')
    rows=[]
    for year in source_years:
        for inp in ['y','l','k_end','k_begin','i','m']:
            r=one(name,source_year=year,input=inp)
            row=[c(name,r,'source_year',f'states:{year}:{inp}:year',',.0f'),c(name,r,'input',f'states:{year}:{inp}:input',display=INPUT[inp])]
            row.extend(c(name,r,f,f'states:{year}:{inp}:{f}',',.0f') for f in ['N_missing','N_zero','N_negative','N_positive','N_concept_fail','N_log_usable'])
            rows.append(row)
    table('deep_input_states.tex','Missing and nonpositive inputs by year','deep-input-states','llrrrrrr',['Year','Input','Missing','Zero','Negative','Positive',r'\makecell{Assumption\\domain fails}',r'\makecell{Usable\\log}'],rows,'For each variable and year, missing, zero, negative and positive counts sum to the source sample. We separately count failures of the maintained assumption domain or timing rule; these failures can overlap with the response states. This column does not count historical documentary failures, which remain separately preserved in the source data. An em dash means that this separate check does not apply. Beginning capital can be missing because we lack the immediately preceding calendar-year stock, even when the current record reports other inputs.')
    name='deep_input_distributions'; rows=[]
    for year in production_years:
        for inp in ['y','l','k_begin','m','i']:
            r=one(name,source_year=year,input=inp,scale='positive')
            rows.append([c(name,r,'source_year',f'inputlevel:{year}:{inp}:year',',.0f'),c(name,r,'input',f'inputlevel:{year}:{inp}:input',display=INPUT[inp]),*[c(name,r,f,f'inputlevel:{year}:{inp}:{f}',',.0f' if f=='N' else '.3e') for f in ['N','p1','p25','p50','p75','p99']]])
    table('deep_input_levels.tex','Summary statistics of positive inputs','deep-input-levels','llrrrrrr',['Year','Input','$N$','P1','P25','Median','P75','P99'],rows,'We summarize the positive values of each variable separately. The records with positive value added need not be the same records with positive capital or materials. Monetary amounts retain the supplied nominal units, and workers retain the reported count units. We display quantities in scientific notation with three decimals in the mantissa without converting money or adjusting for prices. These positive-value summaries do not establish that every record meets the definition, timing and complete-input requirements for estimation.')
    name='deep_method_funnel'; stages=[('source_original','Original records'),('production_valid_sector','Production year and sector'),('positive_output','Positive value added'),('positive_labor','Positive workers'),('positive_begin_capital','Usable beginning capital'),('positive_proxy','Positive materials'),('sample_domain','Eligible current inputs'),('calendar_dynamic','Consecutive eligible records'),('admitted_dynamic','Accepted estimation records')]
    rows=[]
    for year in production_years:
        for stage,label in stages:
            r=methodrow(name,'lp',sector='ALL',source_year=year,stage=stage)
            rows.append([c(name,r,'source_year',f'funnel:{stage}:{year}:year',',.0f'),c(name,r,'stage',f'funnel:{stage}:{year}:label',display=label),*[c(name,r,f,f'funnel:{stage}:{year}:{f}',',.0f') for f in ['N_retained','N_lost']]])
    table('deep_funnel.tex','Sample restrictions for materials-based estimators','deep-funnel','llrr',['Year','Condition','Retained','Lost'],rows,'We apply the conditions in order across observed sectors. Lost records equal the preceding retained count minus the current retained count. LP, ACF and Wooldridge share the input and calendar restrictions, while numerical acceptance can differ. We pool valid consecutive-year records within a sector before applying its estimation requirements. Eligible records outside the dynamic stage may still inform a separate first stage or receive residuals from already estimated slopes. OP continuation uses a separate risk sample.')
    out['deep_data']=r'''\GOneSubsubsection{Input availability and response states}
\GOneLabel{sec:deep-inputs}
We first count how many records provide each required variable in every supplied year. Table~\GOneRef{tab:deep-input-availability} reports these counts separately, so that missing capital does not obscure the availability of value added or workers. Estimation requires the necessary variables together in the same record, and the dynamic stage uses consecutive-year information, requiring an eligible record in the preceding year as well. The separate counts therefore describe the available information before we form the estimation sample.
'''+ref('deep_input_availability.tex')+r'''We extend beginning capital to every available year with a positive stock in its immediately preceding calendar year. This uses the stated year-end assumption even where documentary support is narrower. The missing 2016 file leaves no 2017 beginning stock. A 2018 observation can supply current inputs using the 2017 stock, but a dynamic pair ending in 2018 also needs an eligible 2017 production observation. The source gap therefore affects prediction and dynamic estimation differently. We report those sample differences explicitly.

To explain why a value cannot enter the calculation, we distinguish a missing response from a reported zero or negative amount. Table~\GOneRef{tab:deep-input-states} counts these response states for the history used in the model. We also report failures of the maintained assumption-domain and timing rules. The stock and investment meanings are maintained assumptions for every supplied year; we retain the documentary evidence without treating it as verification of those assumptions.
'''+ref('deep_input_states.tex')+r'''We cannot take the natural logarithm of zero. Adding a small constant would change the measured proxy and the records used to estimate its relationship with output, so we keep the specified positive-value rule. Missing beginning capital has a different meaning: the prior stock may be unavailable even if the record reports current production. Neither exclusion establishes that an actual company used no capital.

We next examine how much the positive amounts vary before requiring complete inputs on the same record. Table~\GOneRef{tab:deep-input-levels} reports the median and selected percentiles in the supplied units. The median divides the ordered observations in half; P25 and P75 locate the lower and upper quarters, while P1 and P99 describe values near the ends. Monetary amounts and worker counts retain different units even when we later take their logarithms.
'''+ref('deep_input_levels.tex')+r'''The upper percentiles are well above the median for several inputs, showing that a typical positive observation does not describe the largest reported amounts. This variation can affect the estimated relationship between inputs and output as well as the residual distribution. A large amount alone does not establish a reporting error. We retain eligible observations, including the large values, and examine the resulting residual tails below.

\GOneSubsubsection{Sample restrictions}
\GOneLabel{sec:deep-funnel}
We now require the inputs together and then apply the calendar condition. We first retain records with all required current inputs; the dynamic sample also requires an eligible predecessor. Table~\GOneRef{tab:deep-funnel} follows these restrictions in order for the materials-based methods. At each step, we count exclusions among the records retained by the preceding step. We can therefore distinguish a missing or unusable beginning stock from the later loss of a record that lacks an eligible predecessor.
'''+ref('deep_funnel.tex')+'''The table separates losses due to missing beginning capital from losses due to a missing eligible predecessor. We apply the minimum estimation requirements after pooling the valid pairs within each sector. A broader set can receive residuals because calculating a residual only requires current inputs and an available coefficient vector. Records outside the dynamic stage can also contribute to an earlier regression in methods with a separate first stage. We therefore retain each record's role rather than treating every prediction as an estimation observation.\n'''
    for asset,title,label in [('deep_input_availability_core','Availability of outcome, labor and capital','deep-input-core'),('deep_input_availability_proxy','Availability of proxy inputs','deep-input-proxy')]:
        if (pub/'figures'/(asset+'.pdf')).exists():
            out['deep_data']+='Figure~\\GOneRef{fig:'+label+'} compares the number of positive values for each input with the full annual record count. We draw a separate bar for each variable because an observation can supply one input and lack another. Estimation still requires the inputs together and the specified calendar history.\n'+figure(asset,title,label,'Bars count positive reported or constructed values separately for each variable and source year; the background shows the full annual sample. Positive values still require the applicable calendar timing before estimation; stock and investment meanings follow the stated assumptions. The legend distinguishes the missing annual file from reported zero counts. We retain zero counts. These separate-variable counts do not give the number of records used to estimate coefficients.')+'\nPositive amounts can still fail to provide all required inputs for the same record. Beginning capital also needs the immediately preceding stock, and dynamic estimation needs an eligible preceding production observation. The annual bars show the input availability before imposing those joint requirements.\n'
    # Method-level calculations retain every year; pooled source_year=0 is never a calendar date.
    # WFDOC: Keluarga figure dibaca dari manifest deep saat ini dan hanya halaman terdaftar yang boleh masuk appendix.
    def grouped_figures(prefix, title, label, notes):
        registered={item['figure'] for item in json.loads((pub/'provenance/deep-figure-manifest.json').read_text())['figures']}
        paths=sorted((pub/'figures'/(name+'.pdf') for name in registered if name==prefix or re.fullmatch(re.escape(prefix)+r'_p[0-9]+',name)), key=lambda path:(0 if path.stem==prefix else int(path.stem.rsplit('_p',1)[-1]) if '_p' in path.stem and path.stem.rsplit('_p',1)[-1].isdigit() else 999, path.name))
        assert paths and paths[0].stem==prefix, ('Missing current diagnostic figure family',prefix)
        text=''
        for position,path in enumerate(paths):
            suffix='' if position==0 else '-p'+str(position+1)
            text+=figure(path.stem,title+(' (continued)' if position else ''),label+suffix,notes)+'\n'
        return text

    for m in ['lp','op','acf','wrdg']:
        method_sectors=sorted(fits.loc[fits.method.eq(m),'sector'].unique())
        if not method_sectors:
            for key in ['worked','deepdistribution','bootstrap']: out[m+key]=''
            continue
        label=METHOD[m]
        name='deep_worked_calculations'
        eligible=data[name].query("method == @m and sample_id == 'own' and example_type == 'observed_group_means' and source_year > 0 and numeric_released == 1").sort_values(['sector','source_year'])
        if eligible.empty:
            out[m+'worked']=''
        else:
            example_sector=str(eligible.iloc[0].sector)
            candidates=eligible.loc[eligible.sector.eq(example_sector)]
            example_years=list(candidates.source_year.astype(int).unique())
            # Select the first and last observed groups for a reproducible arithmetic example.
            shown_years=sorted(set([example_years[0],example_years[-1]]))
            rr={year:methodrow(name,m,sector=example_sector,source_year=year,example_type='observed_group_means') for year in shown_years}
            metric=[('N','Predicted records',',.0f'),('mean_y',r'Mean $y$','.4f'),('mean_l',r'Mean $l$','.4f'),('mean_k',r'Mean $k$','.4f'),('beta_L',r'$\widehat\beta_L$','.4f'),('beta_K',r'$\widehat\beta_K$','.4f'),('labor_product',r'$\widehat\beta_L\overline l$','.4f'),('capital_product',r'$\widehat\beta_K\overline k$','.4f'),('raw_residual','Mean uncentered residual','.4f'),('normalizer_value','Pooled fitted reference mean','.4f'),('centered_residual','Mean centered residual','.4f'),('exp_centered','Exponential of mean centered log','.4f'),('mean_index','Mean exponentiated index','.4f')]
            rows=[[title,*[c(name,rr[year],field,f'{m}:worked:{year}:{field}',fmt) for year in shown_years]] for field,title,fmt in metric]
            headers=['Quantity',*[c(name,rr[year],'source_year',f'{m}:worked:{year}:header',',.0f') for year in shown_years]]
            sector_display=c(name,rr[shown_years[0]],'sector',f'{m}:worked:sector',display=example_sector)
            table(f'deep_{m}_worked.tex',label+': residual calculation, sector '+sector_display,'deep-'+m+'-worked','l'+'r'*len(shown_years),headers,rows,'We show the first and last prediction years with releasable observed group means in the first estimated sector that supplies such groups. Each year uses all eligible primary predictions in that group, including observations outside dynamic estimation. We first log individual inputs, then average the logs. Every year uses the same pooled sector coefficients and pooled dynamic-sample reference mean. The exponential of the mean centered log is the geometric mean of the index; the last row is its arithmetic mean. No individual company record supplies this example.')
            first=rr[shown_years[0]]
            observed={field:v(name,first,field,f'{m}:worked:prose:{field}','.0f' if field=='source_year' else '.4f') for field in ['source_year','mean_y','labor_product','capital_product','raw_residual','normalizer_value','centered_residual','exp_centered','mean_index']}
            out[m+'worked']=f'''\\GOneSubsubsection{{Worked aggregate calculation}}
\\GOneLabel{{sec:{m}-worked}}
We illustrate the calculation using mean logged inputs within one sector. Multiplying each mean log input by its fitted coefficient and subtracting both contributions from mean logged value added gives the mean individual residual exactly, because the same slopes apply to every record in that sector. Table~\\GOneRef{{tab:deep-{m}-worked}} follows Equations~\\GOneEqref{{eq:native-definition}}--\\GOneEqref{{eq:relative-index}} through centering and exponentiation, using full precision before rounding.
'''+ref(f'deep_{m}_worked.tex')+f'''In {observed['source_year']}, mean logged value added is {observed['mean_y']}. The fitted labor and capital contributions are {observed['labor_product']} and {observed['capital_product']}, leaving {observed['raw_residual']}. Subtracting the pooled reference mean of {observed['normalizer_value']} gives a centered mean of {observed['centered_residual']}. Its exponential is {observed['exp_centered']}, while the arithmetic mean of individual index values is {observed['mean_index']}. The latter gives greater weight to large individual residuals after exponentiation. Both annual examples use the same pooled equation; neither estimates a separate annual technology.\n'''

        name='deep_prediction_profiles'; rows=[]
        for year in [0,*source_years]:
            for scope in ['all','in_fit','outside_fit']:
                r=methodrow(name,m,sector='ALL',source_year=year,fit_scope=scope,measure='centered')
                year_display=c(name,r,'source_year',f'{m}:scope:{year}:{scope}:year',display='Pooled') if year==0 else c(name,r,'source_year',f'{m}:scope:{year}:{scope}:year',',.0f')
                rows.append([year_display,c(name,r,'fit_scope',f'{m}:scope:{year}:{scope}:scope',display=SCOPE[scope]),*[c(name,r,f,f'{m}:scope:{year}:{scope}:{f}',',.0f' if f=='N' else '.3f') for f in ['N','mean','p1','p50','p99']]])
        table(f'deep_{m}_scopes.tex',label+' residuals by year and prediction sample','deep-'+m+'-scopes','llrrrrr',['Year','Prediction sample','$N$','Mean','P1','Median','P99'],rows,'Pooled combines company-year observations across all years, not unique companies. All predictions partitions into dynamic-fit and outside-fit records. A record outside the dynamic stage may still inform an earlier regression. Each year uses the same sector coefficients and pooled dynamic-sample reference mean. Empty groups retain their zero count; numeric summaries of groups with fewer than five records remain unavailable. Subsample percentiles are not additive.')
        rows=[]
        for measure in ['raw','centered','index']:
            r=methodrow(name,m,sector='ALL',source_year=0,fit_scope='in_fit',measure=measure)
            rows.append([c(name,r,'measure',f'{m}:scales:{measure}:measure',display={'raw':'Uncentered log','centered':'Centered log','index':'Relative index'}[measure]),*[c(name,r,f,f'{m}:scales:{measure}:{f}','.3e' if measure=='index' else '.3f') for f in ['min','p1','p25','p50','p75','p99','max']]])
        table(f'deep_{m}_quantiles.tex',label+': pooled residual and index quantiles','deep-'+m+'-quantiles','lrrrrrrr',['Scale','Min','P1','P25','Median','P75','P99','Max'],rows,'All rows use this method\'s own pooled dynamic estimation sample. We center original-log residuals within sector and method, then exponentiate with multiplier one. We compute empirical percentiles separately on each scale. If the percentile averages adjacent observations, exponentiating that average need not equal the index percentile. Log rows use three decimals; index rows use scientific notation with three decimals to preserve tiny positive tails. All finite tails remain in the calculation.')
        name='deep_prediction_tails';rows=[]
        for sector in [*method_sectors,'ALL']:
            r=methodrow(name,m,sector=sector,source_year=0,fit_scope='in_fit',measure='centered')
            rows.append([c(name,r,'sector',f'{m}:tails:{sector}:sector',display=sector),*[c(name,r,f,f'{m}:tails:{sector}:{f}',',.0f') for f in ['N','N_below15','N_above15','N_abs_gt2','N_abs_gt3','N_index_below_half','N_index_above_two']]])
        table(f'deep_{m}_tails.tex',label+' pooled residual tail counts by sector','deep-'+m+'-tails','lrrrrrrr',['Code','$N$',r'\makecell{Below\\IQR fence}',r'\makecell{Above\\IQR fence}',r'$|\widetilde r|>2$',r'$|\widetilde r|>3$',r'$I<0.5$',r'$I>2$'],rows,'The interquartile range is P75 minus P25. The fences are P25 minus 1.5 IQR and P75 plus 1.5 IQR, with strict inequalities for tail counts. The pooled ALL row has its own fences, whose counts need not equal the sum of sector counts. Absolute-log and index thresholds are fixed across sectors. Each row uses all pooled dynamic observations in its named group. Flags can overlap; we retain flagged observations.')
        name='deep_prediction_profiles';rows=[]
        for sector in method_sectors:
            for year in source_years:
                r=methodrow(name,m,sector=sector,source_year=year,fit_scope='all',measure='centered')
                rows.append([c(name,r,'sector',f'{m}:annual:{sector}:{year}:sector',display=sector),c(name,r,'source_year',f'{m}:annual:{sector}:{year}:year',',.0f'),*[c(name,r,f,f'{m}:annual:{sector}:{year}:{f}',',.0f' if f=='N' else '.3f') for f in ['N','mean','p25','p50','p75']]])
        table(f'deep_{m}_annual.tex',label+' annual residual distributions by sector','deep-'+m+'-annual','llrrrrr',['Code','Year','$N$','Mean','P25','Median','P75'],rows,'Every source year remains visible. We include all eligible primary predictions in each sector-year group, including records outside dynamic estimation. One estimated coefficient vector and one pooled dynamic reference mean apply throughout each sector. No annual recentering removes annual mean differences. Missing numeric summaries denote empty or suppressed groups. Annual composition can change; these are distributions under pooled coefficients, not separate annual technologies or real-productivity growth.')
        pooled=methodrow(name,m,sector='ALL',source_year=0,fit_scope='all',measure='centered')
        in_fit=methodrow(name,m,sector='ALL',source_year=0,fit_scope='in_fit',measure='centered')
        outside=methodrow(name,m,sector='ALL',source_year=0,fit_scope='outside_fit',measure='centered')
        npred=v(name,pooled,'N',f'{m}:coverage:N',',.0f');nfit=v(name,in_fit,'N',f'{m}:coverage:infit',',.0f');nout=v(name,outside,'N',f'{m}:coverage:outside',',.0f')
        tail=methodrow('deep_prediction_tails',m,sector='ALL',source_year=0,fit_scope='in_fit',measure='centered')
        nt=v('deep_prediction_tails',tail,'N_abs_gt2',f'{m}:tail_abs2',',.0f')
        out[m+'deepdistribution']=f'''\\GOneSubsubsection{{Prediction samples and tails}}
\\GOneLabel{{sec:{m}-prediction}}
The histogram above describes the dynamic estimation sample. We can calculate residuals more broadly whenever a record supplies the required current inputs in a sector with estimated slopes. Table~\\GOneRef{{tab:deep-{m}-scopes}} distinguishes these roles for every source year and for the pooled records.
'''+ref(f'deep_{m}_scopes.tex')+f'''There are {npred} predicted company-year observations: {nfit} belong to the pooled dynamic fit and {nout} lie outside it. Only the dynamic-fit records determine the reference mean. The annual fit means and the broader prediction means can therefore differ from zero, even though the pooled fit mean is zero by construction. A company appearing repeatedly contributes several observations to these counts.

Table~\\GOneRef{{tab:deep-{m}-quantiles}} holds the fitted records fixed and compares the uncentered logs, centered logs and positive index. We include the minimum and maximum so that the transformed tails remain visible.
'''+ref(f'deep_{m}_quantiles.tex')+f'''Centering preserves every within-sector gap. Exponentiation preserves within-sector ordering but enlarges distances at high values, as Equation~\\GOneEqref{{eq:relative-index}} shows. A large index maximum therefore needs to be read through this transformation, rather than treated directly as physical efficiency.

Table~\\GOneRef{{tab:deep-{m}-tails}} identifies distant observations using two distinct rules. The interquartile range (IQR) is the distance from P25 to P75. Fences placed 1.5 IQR beyond those quartiles compare a value with the spread of its own distribution. Fixed absolute-log and index cutoffs instead apply the same numerical threshold in every sector. A record can exceed more than one cutoff.
'''+ref(f'deep_{m}_tails.tex')+f'''In the pooled dynamic sample, {nt} records have an absolute centered log residual above two. These flags describe the residuals produced by the fitted equation. Prices, reported amounts, the estimated input contributions and production conditions can all affect an extreme residual, so the flag alone identifies neither an error nor its cause. We retain every flagged observation.

\\GOneSubsubsection{{Annual distributions}}
\\GOneLabel{{sec:{m}-annual}}
Table~\\GOneRef{{tab:deep-{m}-annual}} compares all eligible predictions by sector and year. We keep each sector's fitted slopes and reference mean constant over time. This preserves annual differences instead of subtracting each year's average separately.
'''+ref(f'deep_{m}_annual.tex')+'''Changes in annual means and quartiles combine differences in reported outcomes and inputs with differences in sample composition. A year with more high-residual observations can have a higher mean without every continuing assignment improving. We examine this distinction next by matching observations within adjacent years.\n'''
        prefix=f'deep_{m}_year_sector'
        out[m+'deepdistribution']+=f'Figure~\\GOneRef{{fig:deep-{m}-year-sector}} and its continuation panels plot the annual median and quartiles for each sector. These intervals measure dispersion across observations, not uncertainty in an estimated coefficient.\n'+grouped_figures(prefix,label+' annual residual quartiles','deep-'+m+'-year-sector','Each sector panel includes the available annual predictions, using one pooled coefficient vector and reference mean. Dots mark medians and intervals run from P25 to P75; all available values are numerically labelled. An empty group is not a zero. The legend identifies any missing-file region. Continuation panels use the same construction.')+'\nThe sector panels separate variation within each industry from changes in which industries dominate a pooled annual distribution. They describe the same fixed sector equations over time.\n'

        name='deep_paired_changes';rows=[]
        part=data[name].query("method == @m and sample_id == 'own' and measure == 'centered'")
        # WFDOC: Interval pasangan mengikuti year_from/year_to yang benar-benar diekspor; gap 2016 tidak diubah menjadi pasangan berurutan.
        intervals=sorted(set((int(r.year_from),int(r.year_to)) for _,r in part.iterrows()))
        for sector in [*method_sectors,'ALL']:
            for year_from,year_to in intervals:
                r=methodrow(name,m,sector=sector,measure='centered',year_from=year_from,year_to=year_to)
                anchor=f'{m}:pairs:{sector}:{year_from}:{year_to}'
                interval=(c(name,r,'year_from',anchor+':from',display='Pooled') if year_from==0 else c(name,r,'year_from',anchor+':from',',.0f')+'--'+c(name,r,'year_to',anchor+':to',',.0f'))
                rows.append([c(name,r,'sector',anchor+':sector',display=sector),interval,*[c(name,r,f,anchor+':'+f,',.0f' if f=='N_pairs' else '.3f') for f in ['N_pairs','mean_change','p25_change','p50_change','p75_change','spearman_levels','mean_index_ratio']]])
        table(f'deep_{m}_paired.tex',label+': adjacent-year residual changes','deep-'+m+'-paired','llrrrrrrr',['Code','Interval','Pairs',r'Mean $\Delta$',r'P25 $\Delta$',r'Median $\Delta$',r'P75 $\Delta$',r'Rank $\rho$',r'\makecell{Mean\\$I_t/I_{t-1}$}'],rows,'Each interval matches eligible predictions with the same fictional company identifier, sector, method and sample in adjacent calendar years. The source gap is never bridged. Pooled rows combine all record-pair intervals, so the same company may contribute repeatedly; they are not unique-company summaries. The fixed sector slopes and pooled reference mean are unchanged between endpoints. The last column averages individual index ratios and is not exp(mean log change). Empty or suppressed comparisons retain their counts but have unavailable summaries.')
        rows=[]
        for year_from,year_to in intervals:
            r=methodrow(name,m,sector='ALL',measure='centered',year_from=year_from,year_to=year_to)
            anchor=f'{m}:paircoverage:{year_from}:{year_to}'
            interval=c(name,r,'year_from',anchor+':from',display='Pooled') if year_from==0 else c(name,r,'year_from',anchor+':from',',.0f')+'--'+c(name,r,'year_to',anchor+':to',',.0f')
            rows.append([interval,*[c(name,r,f,anchor+':'+f,',.0f') for f in ['N_from','N_to','N_pairs','N_to_in_fit','N_to_outside_fit']]])
        table(f'deep_{m}_pair_coverage.tex',label+': adjacent-year comparison samples','deep-'+m+'-pair-coverage','lrrrrr',['Interval',r'\makecell{Earlier\\predictions}',r'\makecell{Later\\predictions}','Pairs',r'\makecell{Later in\\dynamic fit}',r'\makecell{Later outside\\dynamic fit}'],rows,'Earlier and later counts refer to prediction records in each endpoint year. Pairs additionally require the same fictional identifier and sector. Later-in-fit and later-outside-fit columns partition matched pairs by the role of their later observation. In a pooled row the endpoint counts sum over the listed intervals and may repeat the same company-year. Absence of a matching prediction can reflect missing inputs or generated links; these counts do not identify company entry or closure.')
        r=methodrow(name,m,sector='ALL',measure='centered',year_from=0,year_to=0)
        delta=v(name,r,'mean_change',f'{m}:pairs:meanchange');rho=v(name,r,'spearman_levels',f'{m}:pairs:rho');ratio=v(name,r,'mean_index_ratio',f'{m}:pairs:ratio');npairs=v(name,r,'N_pairs',f'{m}:pairs:N',',.0f')
        out[m+'deepdistribution']+=f'''\\GOneSubsubsection{{Adjacent-year changes}}
\\GOneLabel{{sec:{m}-paired}}
We hold membership fixed within each comparison by requiring a prediction for the same fictional assignment and sector in adjacent calendar years. Table~\\GOneRef{{tab:deep-{m}-pair-coverage}} shows how this restriction narrows the endpoint samples. We retain intervals with no matched predictions so that missing capital history remains visible.
'''+ref(f'deep_{m}_pair_coverage.tex')+f'''The pooled comparison contains {npairs} record-pair intervals. A company can enter several successive intervals, so this is not a count of independent companies. Restricting to matched predictions removes changes in membership within each interval, although membership can still differ between intervals.

For each pair, we subtract the earlier centered residual from the later one. Let $\\Delta x_{{it}}=x_{{it}}-x_{{i,t-1}}$ for any logged variable $x$. Holding the sector slopes fixed gives
\\begin{{equation}}
\\Delta\\widetilde r_{{it}}=\\Delta y_{{it}}-\\widehat\\beta_{{L,s}}\\Delta l_{{it}}-\\widehat\\beta_{{K,s}}\\Delta k_{{it}}.
\\GOneLabel{{eq:{m}-paired-change}}
\\end{{equation}}
The pooled reference mean cancels because we subtract the same constant in both years. Table~\\GOneRef{{tab:deep-{m}-paired}} reports the resulting changes for each interval and sector, then pools the record-pair intervals under the same rule.
'''+ref(f'deep_{m}_paired.tex')+f'''The pooled mean log change is {delta}. The correlation of earlier and later ranks is {rho}, measuring persistence in ordering. The mean individual index ratio is {ratio}; large ratios can strongly influence this arithmetic mean, which need not equal the exponential of the mean log change. These comparisons use fictional links and reported-price equations; they do not establish real-company productivity changes.\n'''
        prefix=f'deep_{m}_paired_change'
        out[m+'deepdistribution']+=f'Figure~\\GOneRef{{fig:deep-{m}-paired-change}} and its continuation panels plot these adjacent-year changes under the same matched-prediction rule.\n'+grouped_figures(prefix,label+' adjacent-year residual changes','deep-'+m+'-paired-change','Each comparison uses same-sector fictional assignments with eligible predictions in consecutive calendar years. Sector coefficients and pooled reference means remain fixed. Histograms retain all finite changes. Numeric labels identify the modal and first and last occupied bins. Pooled panels combine record-pair intervals, allowing repeated company contributions; interval panels retain their own denominators.')+'\nA pooled average can conceal increases and decreases across matched assignments. The interval panels show how their distributions vary over time under the fixed sector equations.\n'

        name='deep_bootstrap_profiles';rows=[]
        for sector in method_sectors:
            for measure in ['labor','capital']:
                r=methodrow(name,m,sector=sector,measure=measure)
                rows.append([c(name,r,'sector',f'{m}:boot:{sector}:{measure}:sector',display=sector),c(name,r,'measure',f'{m}:boot:{sector}:{measure}:term',display=measure.capitalize()),*[c(name,r,f,f'{m}:boot:{sector}:{measure}:{f}',',.0f' if f=='N' else '.4f') for f in ['N','min','p5','p50','p95','max']]])
        table(f'deep_{m}_bootstrap.tex',label+' bootstrap coefficient distributions','deep-'+m+'-bootstrap','llrrrrrr',['Code','Slope','Draws','Min','P5','Median','P95','Max'],rows,'Each row summarizes successful resamples of full fictional-company histories for its primary own-sample estimate. The successful count can differ from the requested count. P5 and P95 are the 5th and 95th percentiles, not the endpoints of the 95 percent intervals in the coefficient figures. We retain finite extreme estimates and keep the original-sample coefficient as the primary estimate. Resampling holds the generated links and measurement assumptions fixed.')
        labor_profiles=data[name].query("method == @m and sample_id == 'own' and measure == 'labor'").dropna(subset=['sd'])
        bootstrap_result=''
        if not labor_profiles.empty:
            extreme=labor_profiles.loc[labor_profiles.sd.idxmax()]
            values={field:v(name,extreme,field,f'{m}:bootstrap:largest_labor_sd:{field}','.4f') for field in ['sd','min','p5','p50','p95','max']}
            values['sector']=c(name,extreme,'sector',f'{m}:bootstrap:largest_labor_sd:sector',display=str(extreme.sector))
            bootstrap_result=f"The largest labor-coefficient standard deviation occurs in sector {values['sector']}, at {values['sd']}. Its bootstrap median is {values['p50']}, with P5 and P95 at {values['p5']} and {values['p95']}; the full range is {values['min']} to {values['max']}. Comparing the middle of this distribution with its extremes helps distinguish broad dispersion from a small number of distant estimates. "
        out[m+'bootstrap']=f'''\\GOneSubsubsection{{Bootstrap coefficient distributions}}
\\GOneLabel{{sec:{m}-bootstrap}}
Table~\\GOneRef{{tab:deep-{m}-bootstrap}} reports the spread of the repeated coefficient estimates. The standard error is their sample standard deviation, while the median and percentiles reveal features that a single standard error can conceal. The minimum and maximum make finite extremes visible.
'''+ref(f'deep_{m}_bootstrap.tex')+bootstrap_result+'''We retain every finite resampled estimate and keep the original-sample coefficient as the primary result. A limited number of resamples determines the extreme percentiles, so their locations should not be interpreted as precise tail probabilities. The exercise also leaves uncertainty about actual identities, prices and economic restrictions outside the resampling calculation.\n'''
    return out
