"""Independent NumPy/SciPy arithmetic oracle for NEW algorithm-only test data.

All analytical coefficients come from Stata. This program only reconstructs
identities, exact-calendar membership, objective values and bootstrap covariance.
It never fits G0.5, supplies replacement coefficients or reads actual records.
"""
# WFDOC: Validator membaca hanya fixture DTA buatan serta keluaran algoritme/bootstrap yang disimpan Stata; seluruh hasilnya adalah cek aritmetika, bukan fit G0.5.
from pathlib import Path
import argparse, hashlib, json
import numpy as np
import pandas as pd
from scipy.optimize import minimize

p=argparse.ArgumentParser()
p.add_argument('outputdir',type=Path)
a=p.parse_args()
R=Path(__file__).resolve().parent
# WFDOC: Memastikan label fixture, grain id-tahun, persamaan pembangkit, dan gelombang 2016 yang hilang sebelum menghitung apa pun.
x=pd.read_stata(a.outputdir/'fixture.dta',convert_categoricals=False)
assert x.fixture.eq('INDEPENDENT_ALGORITHM_TEST_NOT_G05').all()
assert len(x)==2160 and x.id.nunique()==180 and not x.duplicated(['id','year']).any()
assert not x.year.eq(2016).any()
assert np.allclose(x.loc[x.eligible.eq(1),'y'],(.6*x.l+.3*x.k+x.omega+x.noise)[x.eligible.eq(1)],rtol=0,atol=1e-13)
# WFDOC: Lag dihitung ulang per ID lalu hanya transisi dengan selisih tahun tepat satu yang masuk; ini mempertahankan celah kalender dan mengecualikan 2017 tanpa lag 2016.
x=x.sort_values(['id','year']).reset_index(drop=True)
lag=x.groupby('id').shift()
adj=(x.year-lag.year).eq(1)
dynamic=x.eligible.eq(1)&lag.eligible.eq(1)&adj
assert dynamic.sum()==1273
assert not dynamic[x.year.isin([2010,2017])].any()
rows=pd.read_csv(R/'algorithm-results.csv')
assert set(rows.method)=={'op','lp','acf','wrdg'}
assert rows.converged.eq(1).all() and rows.N.eq(1273).all()
assert rows.labor.sub(.6).abs().lt(.08).all() and rows.capital.sub(.3).abs().lt(.08).all()

# WFDOC: Basis B_d membentuk satu kolom untuk tiap k^a*p^(d-a), untuk semua derajat total dari satu sampai d.
def basis(k,proxy,degree=3):
    return np.column_stack([np.asarray(k)**a*np.asarray(proxy)**(d-a) for d in range(1,degree+1) for a in range(d+1)])

checks=[]
# WFDOC: Koefisien point fit tetap berasal dari CSV Stata; loop ini merekonstruksi tahap pertama, domain dan objective secara terpisah tanpa mengestimasi pengganti.
for row in rows.itertuples():
    if row.method=='wrdg':
        # Exact system verification uses Stata's retained weight matrix, not a
        # guessed weighting normalization or a second estimator implementation.
        continue
    proxy=x.inv if row.method=='op' else x.p
    if row.method=='acf':
        A=np.column_stack([np.asarray(x.l)**aa*np.asarray(x.k)**bb*np.asarray(proxy)**(d-aa-bb)
            for d in range(1,4) for aa in range(d+1) for bb in range(d-aa+1)])
    else:
        A=np.column_stack([x.l,basis(x.k,proxy)])
    A=np.column_stack([np.ones(len(x)),A])
    eligible=x.eligible.eq(1).to_numpy()
    beta=np.linalg.lstsq(A[eligible],x.y[eligible],rcond=None)[0]
    fitted=A@beta
    if row.method!='acf':
        assert np.isclose(beta[1],row.labor,rtol=0,atol=1e-7)
        fitted=fitted-row.labor*x.l.to_numpy()
    phi=pd.Series(fitted)
    lphi=phi.groupby(x.id).shift()
    valid=dynamic.to_numpy()
    if row.method=='acf':
        omega=fitted[valid]-row.labor*x.l[valid].to_numpy()-row.capital*x.k[valid].to_numpy()
        lomega=lphi[valid].to_numpy()-row.labor*lag.l[valid].to_numpy()-row.capital*lag.k[valid].to_numpy()
    else:
        omega=fitted[valid]-row.capital*x.k[valid].to_numpy()
        lomega=lphi[valid].to_numpy()-row.capital*lag.k[valid].to_numpy()
    H=np.column_stack([np.ones(valid.sum()),lomega,lomega**2,lomega**3])
    # WFDOC: Untuk OP, bangun ulang lagged B_d pada seluruh risk set berlag lengkap, fit logit dari exit teramati, lalu buat probabilitas yang dipakai dalam polinomial transisi.
    if row.method=='op':
        B=basis(x.k,x.inv)
        lagB=pd.DataFrame(B).groupby(x.id).shift().to_numpy()
        risk=x.risk.eq(1).to_numpy()&adj.to_numpy()&np.isfinite(lagB).all(axis=1)
        assert risk.sum()==row.N_selection==1348
        # Conditioning the regressors changes numerical scale but not the logit.
        mu=lagB[risk].mean(axis=0); sd=lagB[risk].std(axis=0)
        S=np.column_stack([np.ones(risk.sum()),(lagB[risk]-mu)/sd])
        outcome=x.exited[risk].to_numpy()
        def loss(b):
            eta=S@b
            pr=1/(1+np.exp(-eta))
            return np.logaddexp(0,eta).sum()-outcome@eta, S.T@(pr-outcome)
        fit=minimize(loss,np.zeros(S.shape[1]),jac=True,method='BFGS',options={'gtol':1e-7,'maxiter':10000})
        assert np.linalg.norm(loss(fit.x)[1],np.inf)<1e-4
        pr=1/(1+np.exp(-(np.column_stack([np.ones(valid.sum()),(lagB[valid]-mu)/sd])@fit.x)))
        H=np.column_stack([H,pr,pr**2,pr**3,pr*lomega,pr**2*lomega,pr*lomega**2])
    g=np.linalg.lstsq(H,omega,rcond=None)[0]
    # WFDOC: Pada objective ACF, Z=[lag(l), k] dan W=invsym(Z'Z)/N; OP/LP membandingkan jumlah kuadrat error produksi pada transisi dinamis.
    if row.method=='acf':
        xi=omega-H@g
        Z=np.column_stack([lag.l[valid],x.k[valid]])
        objective=(Z.T@xi)@np.linalg.inv(Z.T@Z)@(Z.T@xi)/len(Z)
    else:
        xi=x.y[valid].to_numpy()-row.labor*x.l[valid].to_numpy()-row.capital*x.k[valid].to_numpy()-H@g
        objective=xi@xi
    # CSV coefficient precision limits the oracle, especially ACF's small Q.
    tolerance=1e-5 if row.method=='op' else 1e-6
    assert abs(objective-row.objective)<tolerance,(row.method,objective,row.objective)
    checks.append({'method':row.method,'reconstructed_objective':float(objective),'stata_objective':row.objective,'absolute_error':abs(float(objective)-row.objective),'tolerance':tolerance})

# WFDOC: Audit WRDG memakai parameter dan matriks bobot yang disimpan Stata untuk merekonstruksi dua persamaan dengan theta bersama dan momen instrumennya; tidak menjalankan estimator kedua.
wr_files=[a.outputdir/n for n in ['wrdg-b.csv','wrdg-W.csv']]
if all(f.exists() for f in wr_files):
    b=pd.read_csv(wr_files[0]).to_numpy().ravel()
    W=pd.read_csv(wr_files[1]).to_numpy()
    valid=dynamic.to_numpy()
    k=x.k.to_numpy(); m=x.p.to_numpy(); l=x.l.to_numpy()
    # Exact monomial order emitted by the pinned prodest source.
    B=np.column_stack([k,m,k*k,k*k*k,k*k*m,k*m,k*m*m,m*m,m*m*m])
    LB=pd.DataFrame(B).groupby(x.id).shift().to_numpy()
    Z1=np.column_stack([l[valid],B[valid],np.ones(valid.sum())])
    Z2=np.column_stack([k[valid],lag.l[valid],LB[valid],np.ones(valid.sum())])
    assert len(b)==13 and W.shape==(23,23)
    # GMM parser order: two structural coefficients, theta1..theta9, a0,e0.
    r1=x.y[valid].to_numpy()-b[0]*l[valid]-b[1]*k[valid]-B[valid]@b[2:11]-b[11]
    r2=x.y[valid].to_numpy()-b[0]*l[valid]-b[1]*k[valid]-LB[valid]@b[2:11]-b[11]-b[12]
    moment=np.r_[Z1.T@r1,Z2.T@r2]/valid.sum()
    q=float(moment@W@moment)
    reported=float(rows.loc[rows.method.eq('wrdg'),'objective'].iloc[0])
    assert abs(q-reported)<1e-6,(q,reported)
    checks.append({'method':'wrdg','reconstructed_objective':q,'stata_objective':reported,'absolute_error':abs(q-reported),'tolerance':1e-6})
else:
    raise AssertionError('Missing WRDG full-parameter/weight evidence; cannot claim four-method arithmetic check')

# WFDOC: Kovarians bootstrap dibandingkan pada dua draw fixture dengan penyebut sampel B-1; ini memeriksa aritmetika saja, bukan kecukupan 999 draw.
bootstrap=[]
for m in ['op','lp','acf','wrdg']:
    f=a.outputdir/f'bootstrap-{m}.csv'
    if not f.exists(): continue
    z=pd.read_csv(f)
    good=z[z.success.eq(1)]
    assert len(z)==2 and len(good)==2
    covariance=good[['labor','capital']].cov().to_numpy()
    stata=pd.read_csv(a.outputdir/f'bootstrap-{m}-cov.csv').to_numpy()
    assert np.allclose(covariance,stata,rtol=1e-6,atol=1e-10)
    bootstrap.append({'method':m,'requested':2,'successful':2,'covariance_denominator':1,'max_covariance_error':float(abs(covariance-stata).max()),'scope':'execution/arithmetic only, not inferential adequacy'})
# WFDOC: Receipt merekam cakupan fixture, sampel kalender, objective per metode, galat rekonstruksi dan lingkup terbatas validasi.
receipt={'status':'PASS','scope':'INDEPENDENT_ALGORITHM_TEST_NOT_G05','rows':len(x),'firms':int(x.id.nunique()),'dynamic_N':int(dynamic.sum()),'OP_selection_N':1348,'exact_calendar_gap_verified':True,'objectives':checks,'bootstrap':bootstrap,'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(R/'arithmetic-validation.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2))
