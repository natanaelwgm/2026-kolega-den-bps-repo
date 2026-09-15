#!/usr/bin/env python3
"""Compile the complete G1 body inside an actual host with surrounding material."""
from pathlib import Path
import hashlib,json,re,shutil,subprocess,tempfile
P=Path(__file__).resolve().parent
out=P.parents[3]/(P.parents[2].name+'-g1-runs')/'publication-host-test'
out.mkdir(parents=True,exist_ok=True)
preamble=(P/'main.tex').read_text().split(r'\begin{document}')[0]
body=r'''
\begin{document}
\section{Main analysis}
\label{host:main}
This document tests insertion of the full production-function appendix in a host manuscript. The following host exhibits deliberately precede the insertion.
\begin{equation}a=b\label{host:before-eq}\end{equation}
\begin{figure}[H]\centering\fbox{Host figure before insertion}\caption{Host figure}\label{host:before-fig}\end{figure}
\begin{table}[H]\centering\caption{Host table}\label{host:before-tab}\begin{tabular}{ll}Item&Value\\Test&Present\end{tabular}\end{table}
\setcounter{figure}{7}\setcounter{table}{9}\setcounter{equation}{11}
\appendix
\section{Supplementary analysis}
\label{host:appendix-a}
The G1 manuscript is included below as a subsection of Appendix A. The host retains control of its ancestor and page numbering.
\renewcommand{\GOneRootLevel}{2}
\makeatletter
\let\GOneTestSavedLongtableOutput\LT@output
\makeatother
\input{appendix.tex}
\makeatletter
\ifx\GOneTestSavedLongtableOutput\LT@output
  \typeout{G1-HOST-LONGTABLE-RESTORED}
\else\PackageError{host-test}{Longtable output routine not restored}{}\fi
\makeatother
\ifnum\value{figure}=7\else\PackageError{host-test}{Figure counter not restored}{}\fi
\ifnum\value{table}=9\else\PackageError{host-test}{Table counter not restored}{}\fi
\ifnum\value{equation}=11\else\PackageError{host-test}{Equation counter not restored}{}\fi
\ifnum\value{section}=1\else\PackageError{host-test}{Ancestor section changed}{}\fi
\ifnum\value{secnumdepth}=4\else\PackageError{host-test}{Heading depth not restored}{}\fi
\begin{equation}c=d\label{host:after-eq}\end{equation}
\begin{figure}[H]\centering\fbox{Host figure after insertion}\caption{Host continuation figure}\label{host:after-fig}\end{figure}
\begin{table}[H]\centering\caption{Host continuation table}\label{host:after-tab}\begin{tabular}{ll}Item&Value\\Test&Present\end{tabular}\end{table}
\section{Another appendix}
\label{host:appendix-b}
External references resolve to the G1 root in Section~\ref{g1:app:nominal-production}, its introduction in Section~\ref{g1:sec:purpose}, Equation~\eqref{g1:eq:levels}, Table~\ref{g1:tab:measurement}, and Figure~\ref{g1:fig:sample-support}. Host continuation references are Figure~\ref{host:after-fig}, Table~\ref{host:after-tab}, and Equation~\eqref{host:after-eq}.
\end{document}
'''
source=preamble+body
(P/'provenance/host-test.tex').write_text(source)
with tempfile.TemporaryDirectory(prefix='g1-host-') as tmp:
    tmp=Path(tmp);tex=tmp/'host.tex';tex.write_text(source)
    # WFDOC: Minimal dua pass; ulangi terbatas bila lebar longtable atau referensi belum stabil.
    for i in range(1,7):
        run=subprocess.run(['xelatex','-interaction=nonstopmode','-halt-on-error','-file-line-error','-output-directory='+str(tmp),str(tex)],cwd=P,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True)
        (out/f'pass{i}.txt').write_text(run.stdout)
        assert run.returncode==0,run.stdout[-6000:]
        current_log=(tmp/'host.log').read_text()
        if i>=2 and not re.search(r'widths have changed|Label\(s\) may have changed|Rerun to get',current_log,re.I):break
    else:raise AssertionError('Host table widths or references did not settle in six passes')
    log=(tmp/'host.log').read_text();aux=(tmp/'host.aux').read_text()
    assert not re.search(r'undefined|multiply defined|destination with the same identifier|Overfull|ignored error',log,re.I),log[-5000:]
    # WFDOC: Bukti TeX membandingkan definisi LT@output sebelum/sesudah seluruh body, bukan hanya counter.
    assert 'G1-HOST-LONGTABLE-RESTORED' in log, 'Missing exact host longtable restoration proof'
    records={m.group(1):(m.group(2),m.group(3)) for m in re.finditer(r'\\newlabel\{([^}]+)\}\{\{([^}]+)\}\{([^}]+)\}',aux)}
    expected={'g1:app:nominal-production':'A.1','g1:sec:purpose':'A.1.1','g1:eq:levels':'A.1.1','g1:tab:measurement':'A.1.1','g1:fig:sample-support':'A.1.1','host:after-fig':'8','host:after-tab':'10','host:after-eq':'12','host:appendix-b':'B'}
    for key,value in expected.items(): assert records[key][0]==value,(key,records.get(key),value)
    for ext in ['pdf','aux','log']:shutil.copy2(tmp/('host.'+ext),out/('G1-Host-Test.'+ext))
    receipt={'status':'PASS','scope':'Full body inserted as subsection A.1 after host content and before another appendix; bounded XeLaTeX compilation until references and table widths settle','compile_passes':i,'longtable_output_definition_restored':True,'counter_and_label_assertions':expected,'compiled_label_count':len(records),'source_sha256':hashlib.sha256(source.encode()).hexdigest(),'style_sha256':hashlib.sha256((P/'g1-appendix.sty').read_bytes()).hexdigest(),'body_sha256':hashlib.sha256((P/'appendix.tex').read_bytes()).hexdigest(),'pdf':str(out/'G1-Host-Test.pdf'),'pdf_sha256':hashlib.sha256((out/'G1-Host-Test.pdf').read_bytes()).hexdigest(),'pdfinfo':subprocess.check_output(['pdfinfo',str(out/'G1-Host-Test.pdf')],text=True),'final_pass_warnings':[]}
    (P/'provenance/portability-test.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps({k:receipt[k] for k in ['status','compiled_label_count','pdf']}))
