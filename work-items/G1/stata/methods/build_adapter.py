"""Build a narrowly scoped, auditable single-point adapter of pinned prodest.

The input is immutable. No changes to the user's installed Stata package.
The primary Wooldridge shared-theta restriction is retained deliberately.
"""
from pathlib import Path
import difflib, hashlib, json, re
# WFDOC: Builder hanya membaca salinan vendor yang dipatok hash; ia membuat adapter dan bukti diff, tanpa membaca data perusahaan atau menjalankan estimasi.
R=Path(__file__).resolve().parent
src=(R/'vendor/prodest.ado').read_bytes()
assert hashlib.sha256(src).hexdigest()=='2e9786201189f6eafd90475b72b11d2d68eab8815b3740bd6054ddfb5dc34fae'
s=src.decode(); t=s

# WFDOC: Setiap penggantian memeriksa jumlah kecocokan yang diharapkan agar perubahan sumber vendor menghentikan build, bukan diterapkan secara diam-diam.
def replace(old,new,count=1):
    global t
    actual=t.count(old)
    if actual != count:
        raise AssertionError((old,actual,count))
    t=t.replace(old,new)

# WFDOC: Penggantian berikut membatasi salinan vendor menjadi point fit value-added yang dipakai G1; batas metode, probabilitas OP eksternal, dan nilai awal eksplisit dijaga oleh guard.
replace('capture program drop prodest','capture program drop g1_prodest_point')
replace('program define prodest,','program define g1_prodest_point,')
replace('TRANSlog OVERidentification]', 'TRANSlog OVERidentification OPPROB(varname numeric)]')
# This adapter supports exactly one point fit. All uncertainty is external.
a=t.index('\tif (`reps\' < 2)')
b=t.index('\n\t',t.index('\n\t}',a)+3)
t=t[:a]+'''\tif `reps' != 1 {
        di as error "G1 adapter requires reps(1); bootstrap the full source/risk universe externally"
        exit 198
    }
    if "`valueadded'"=="" | !inlist("`method'","op","lp","wrdg") {
        di as error "G1 adapter supports only the registered value-added estimators"
        exit 198
    }
    if "`method'"=="wrdg" & "`gmm'"=="" exit 198
    if "`method'"=="op" & ("`attrition'"=="" | "`opprob'"=="") {
        di as error "OP requires authenticated external selection probabilities"
        exit 459
    }
    if "`init'"=="" {
        di as error "G1 requires an explicit deterministic starting vector"
        exit 198
    }
'''+t[b:]
# WFDOC: Nama parameter awal Wooldridge dipetakan ke koefisien struktural yang benar; nama xb_ yang tidak cocok tidak dipakai.
replace("loc init_gmm `init_gmm' xb_`var' `val'", "loc init_gmm `init_gmm' `var' `val'")
replace("keep `depvar' `free' `state' `proxy' `control' `id' `t' `touse'  `endogenous'", "keep `depvar' `free' `state' `proxy' `control' `id' `t' `touse' `endogenous' `opprob'")
a=t.index('\t\t/// generate an "exit" dummy')
b=t.index('\t\tqui save `temp\'',a)
t=t[:a]+'''        * Exit is NEVER derived from estimator-filtered record absence.
'''+t[b:]
a=t.index('\t\t\t\tif !mi("`attrition\'"){')
b=t.index('\t\t\t\t/// in case of ACF',a)
t=t[:a]+'''                if "`method'"=="op" {
                    qui gen double Pr_hat = `opprob'
                    assert inrange(Pr_hat,0,1) if !missing(Pr_hat)
                }
                else qui gen double Pr_hat = .
'''+t[b:]
# WFDOC: Proyeksi QR dan tipe double menstabilkan perhitungan numerik; keduanya tidak mendefinisikan persamaan atau momen baru.
# ACF already removes the duplicate linear labor monomial in pinned source.
# Stable projection and storage change arithmetic, not model/moment equations.
replace("g_b = invsym(OMEGA_lag_pol'OMEGA_lag_pol)*OMEGA_lag_pol'OMEGA", "g_b = qrsolve(OMEGA_lag_pol,OMEGA)",2)
t=t.replace('qui g ', 'qui gen double ').replace('cap g ', 'cap gen double ')
t=t.replace('predict phihat', 'predict double phihat')
# WFDOC: Matriks diagnostik menyimpan status konvergensi, objective, iterasi, ukuran sampel, rank instrumen/transisi, dan Jacobian ACF sebelum data dipulihkan.
# Record dynamic membership before the package restores its first-stage domain.
replace('p = optimize(S)', '''p = optimize(S)
        st_matrix("G1_POINT_DIAG", (optimize_result_converged(S), optimize_result_value(S), optimize_result_iterations(S), rows(X), cols(Z), rank(Z)))
        st_matrix("G1_POINT_GRADIENT", optimize_result_gradient(S))
        G1_lom=LPHI-lX*p'
        if (!missing(PR_HAT)) G1_transition=(J(rows(X),1,1),G1_lom,G1_lom:^2,G1_lom:^3,PR_HAT,PR_HAT:^2,PR_HAT:^3,PR_HAT:*G1_lom,(PR_HAT:^2):*G1_lom,PR_HAT:*(G1_lom:^2),ENDO)
        else G1_transition=(J(rows(X),1,1),G1_lom,G1_lom:^2,G1_lom:^3,ENDO)
        st_matrix("G1_TRANSITION_DIAG",(rows(G1_transition),cols(G1_transition),rank(G1_transition),cond(G1_transition)))

        if (cols(X)==2) {
            G1_mom = g1_cf_mom(p,X,lX,PHI,LPHI,Z)
            G1_D = J(rows(G1_mom),cols(X),.)
            for (G1_j=1;G1_j<=cols(X);G1_j++) {
                G1_plus=p; G1_minus=p
                G1_plus[G1_j]=G1_plus[G1_j]+1e-5
                G1_minus[G1_j]=G1_minus[G1_j]-1e-5
                G1_D[,G1_j]=(g1_cf_mom(G1_plus,X,lX,PHI,LPHI,Z)-g1_cf_mom(G1_minus,X,lX,PHI,LPHI,Z))/2e-5
            }
            st_matrix("G1_POINT_MOMENTS",G1_mom')
            st_matrix("G1_POINT_JACOBIAN",G1_D)
        }''')
marker='\n\t\t\t\t\t\t/// save locals for Hanses\'s J and p-value'
replace(marker,'''
                        matrix G1_POINT_DIAG=(e(converged),e(Q),e(ic),e(N),e(n_moments),e(rank))
                        matrix G1_POINT_W=e(W)
                        matrix G1_POINT_S=e(S)
                        matrix G1_POINT_FULL_B=e(b)
                        matrix G1_POINT_V=e(V)
'''+marker)
# Required OP correction must also be guarded for direct low-level callers.
replace("\t\t\t\t\t/// the routine cannot fail the first estimation", "\t\t\t\t\tif \"`method'\"==\"op\" assert !missing(Pr_hat)\n\t\t\t\t\t/// the routine cannot fail the first estimation",1)
# WFDOC: Derivatif GMM mengikat koefisien theta yang sama di dua persamaan sesuai pembatasan WRDG pada sumber prodest yang dipatok.
# Exact analytic derivatives for shared theta, retained in BOTH equations.
replace('loc eq1counter = 0', 'loc eq1counter = 0\n                        loc g1_derivs ""',2)
replace("loc eq1vars `eq1vars' -{xb`eq1counter'}*`var'", "loc eq1vars `eq1vars' -{xb`eq1counter'}*`var'\n                            loc g1_derivs `g1_derivs' derivative(eq1/xb`eq1counter' = -`var')",1)
replace("loc eq2vars `eq2vars' -{xb`eq2counter'}*`var'", "loc eq2vars `eq2vars' -{xb`eq2counter'}*`var'\n                            loc g1_derivs `g1_derivs' derivative(eq2/xb`eq2counter' = -`var')",1)
replace("`vv' qui gmm (eq1:", "foreach element in `free' `state'{\n                            loc g1_derivs `g1_derivs' derivative(eq1/`element' = -`element') derivative(eq2/`element' = -`element')\n                        }\n                        loc g1_derivs `g1_derivs' derivative(eq1/a0 = -1) derivative(eq2/a0 = -1) derivative(eq2/e0 = -1)\n                        `vv' qui gmm (eq1:",1)
replace("/*nocommonesample*/ technique(`optimizer') conv_maxiter(`maxiter') `conv_nrtol' `init_gmm'", "/*nocommonesample*/ technique(`optimizer') conv_maxiter(`maxiter') `conv_nrtol' `init_gmm' `g1_derivs'",1)
a=t.index('\t\tif !inlist("`method\'","wrdg","mr","rob")/*')
b=t.index('\n\trestore ',a)
t=t[:a]+'''        * Single fit: there is no internal bootstrap covariance or Wald test.
        mat `__b' = `__b'[1,1...]
'''+t[b:]
a=t.index('\n\tmat coleq `__b\' = ""')
b=t.index('\n\tif !mi("`acf\'")',a)
t=t[:a]+'''
    mat coleq `__b' = ""
    mat colnames `__b' = `free' `state' `control' `proxyGO' `transNames'
    eret clear
    eret post `__b', e(`touse') obs(`nObs')
    loc waldT "."
    loc waldP "."
'''+t[b:]
# WFDOC: Hasil adapter berisi satu vektor beta dan metadata point fit; kovarians internal dan prediksi omega otomatis tidak dinyatakan sebagai output inferensial.
replace('eret loc cmd "prodest"','eret loc cmd "g1_prodest_point"')
replace('eret loc predict "prodest_p"','eret loc predict "G1_NO_AUTOMATIC_LATENT_PREDICTION"')
replace('\n\t_coef_table, level(`level\')','\n\tmat list e(b)')
# Namespace Mata symbols so loading does not replace the installed package.
for old,new in [('opt_mata','g1p_opt_mata'),('foplp','g1p_foplp'),('facf','g1p_facf')]:
    t=t.replace(old,new)
replace('capture mata mata drop g1p_facf()', 'capture mata mata drop g1p_facf()\ncapture mata mata drop g1_cf_mom()')
replace('mata:\n', '''mata:
    real colvector g1_cf_mom(real rowvector b, real matrix X, real matrix lX,
        real colvector PHI, real colvector LPHI, real matrix Z) {
        real colvector om, lom, xi
        real matrix H
        om=PHI-X*b'; lom=LPHI-lX*b'
        H=(J(rows(om),1,1),lom,lom:^2,lom:^3)
        xi=om-H*qrsolve(H,om)
        return(Z'xi/rows(Z))
    }
''',1)
# WFDOC: Overlay memakai base_sha256 dan insertion before_line berbasis nomor baris satu-indeks; hanya komentar WFDOC mandiri diterima, dengan // untuk isi Mata.
# Optional Luna commentary overlay: every inserted line is a standalone comment.
# The base hash prevents comments silently moving after a scientific code change.
base_sha256=hashlib.sha256(t.encode()).hexdigest()
overlay_path=R/'adapter-commentary.json'
overlay_sha256=None
if overlay_path.exists():
    overlay=json.loads(overlay_path.read_text())
    assert overlay['base_sha256']==base_sha256, 'Comment overlay base differs from generated scientific code'
    lines=t.splitlines(keepends=True)
    inserts={}
    mata_lines=set()
    in_mata=False
    for n,base_line in enumerate(lines,1):
        if in_mata: mata_lines.add(n)
        if base_line.strip()=='mata:': in_mata=True
        elif in_mata and base_line.strip()=='end': in_mata=False
    for item in overlay['insertions']:
        line=item['before_line']; comment=item['text']
        assert isinstance(line,int) and 1<=line<=len(lines)+1
        assert isinstance(comment,str) and re.fullmatch(r'[ \t]*(?:\*|//) WFDOC: [^\r\n]+',comment), 'Overlay may contain only standalone WFDOC comment lines'
        assert '/*' not in comment and '*/' not in comment, 'Overlay must not alter block-comment delimiters'
        assert not (line>1 and lines[line-2].rstrip().endswith('///')), 'Insert only between complete Stata commands'
        assert not (line in mata_lines and comment.lstrip().startswith('*')), 'Mata requires // WFDOC comments'
        inserts.setdefault(line,[]).append(comment+'\n')
    t=''.join(''.join(inserts.get(n,[]))+line for n,line in enumerate(lines,1))+''.join(inserts.get(len(lines)+1,[]))
    overlay_sha256=hashlib.sha256(overlay_path.read_bytes()).hexdigest()
# WFDOC: Build menulis ulang adapter, diff terhadap vendor, dan manifest hash; adapter-commentary.json hanya menambah baris komentar dan terikat pada hash kode dasar.
(R/'g1_prodest_point.ado').write_text(t)
(R/'adapter.patch').write_text(''.join(difflib.unified_diff(s.splitlines(True),t.splitlines(True),fromfile='vendor/prodest.ado',tofile='g1_prodest_point.ado')))
(R/'adapter-manifest.json').write_text(json.dumps({'source_sha256':hashlib.sha256(src).hexdigest(),'adapter_base_sha256':base_sha256,'commentary_overlay_sha256':overlay_sha256,'adapter_sha256':hashlib.sha256(t.encode()).hexdigest(),'equation_policy':'Pinned primary equations retained, including shared WRDG theta; external authenticated OP selection supplied; QR replaces normal-equation projection; no internal bootstrap or covariance claim'},indent=2)+'\n')
print('adapter built; source hash and replacement counts verified')
