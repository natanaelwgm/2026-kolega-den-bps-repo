#!/usr/bin/env python3
"""Verify the exact approved G0.5 v3 panel in this checkout, without estimation."""
# WFDOC: Pemeriksaan ini memverifikasi panel synthetic_development dan kalender, tanpa menyebut psid sintetis sebagai identitas aktual atau menjalankan estimator.
import json
from pathlib import Path
import subprocess
import sys
from datetime import datetime, timezone
import pandas as pd

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT))
from harness.data_source import load_data, export_data, sha

# WFDOC: Hash manifest harus cocok dengan snapshot panel yang disetujui sebelum kolom kunci dan lineage dibaca.
PIN="060b0ee0a2158a9c94b0e7e68fcfba719eda37561422855471a99da6810ba260"
assert sha(ROOT/"data/g0-5-development/manifest.json")==PIN
cols=["obs_id","source_year","psid","psid_status","dev_cluster_id","dev_panel_stratum","dev_prev_obs_id","dev_prev_year","dev_link_status","province_code","industry_code"]
frame=load_data(mode="development",require_panel=True,columns=cols)
assert frame.obs_id.is_unique
assert frame.psid.notna().all() and frame.psid_status.eq("synthetic_development").all()
assert not frame.duplicated(["psid","source_year"]).any()
assert frame.groupby("psid").dev_panel_stratum.nunique().le(1).all()
# WFDOC: Lag satu/dua tahun memakai pasangan kunci kalender; dev_prev dicocokkan ke observasi, tahun dan strata sumber.
keys=set(zip(frame.psid,frame.source_year))
lag1=sum((f,y-1) in keys for f,y in keys)
lag2=sum((f,y-2) in keys for f,y in keys)
ordered=frame.sort_values(["psid","source_year"])
gaps=ordered.groupby("psid").source_year.diff().dropna().value_counts().sort_index()
linked=frame.loc[frame.dev_prev_obs_id.notna() & frame.dev_prev_obs_id.ne("")]
prev=linked.merge(frame[["obs_id","psid","source_year","dev_panel_stratum"]],left_on="dev_prev_obs_id",right_on="obs_id",suffixes=("","_previous"),validate="one_to_one")
assert len(prev)==len(linked)
assert prev.psid.eq(prev.psid_previous).all()
assert prev.dev_prev_year.eq(prev.source_year_previous).all()
assert prev.dev_panel_stratum.eq(prev.dev_panel_stratum_previous).all()
assert not frame.source_year.eq(2016).any()
run=ROOT.parent/(ROOT.name+"-g1-runs")/("v3-inspection-"+datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ"))
run.mkdir(parents=True,exist_ok=False)
export_data(frame,run/"panel.dta",code_path=__file__)
do=run/"inspect.do"
# WFDOC: Do-file kecil di bawah memeriksa kontrak xtset dan hitungan panel di Stata; ia tidak memuat g1_fit atau mengestimasi produksi.
do.write_text('''version 17
clear all
set more off
log using "panel-check.log", text replace
use "panel.dta", clear
assert _N==33049
assert psid_status=="synthetic_development"
assert !missing(psid)
isid obs_id
isid psid source_year
xtset psid source_year
gen byte observed=1
gen byte lag1=!missing(L.observed)
gen byte lag2=!missing(L2.observed)
assert lag1==0 if source_year==2017
egen byte tag=tag(psid)
count if tag
assert r(N)==10395
count if lag1
assert r(N)==20579
collapse (count) N_source=observed (sum) N_lag1=lag1 N_lag2=lag2, by(source_year)
gen str90 data_label="G0.5 DEVELOPMENT - synthetic_development company continuity"
export delimited using "panel_calendar.csv", replace
display "G1_V3_PANEL_CHECK_PASS"
log close
exit, clear
''')
result=subprocess.run(["stata-se","-b","do",str(do)],cwd=run,timeout=120)
assert result.returncode==0 and "G1_V3_PANEL_CHECK_PASS" in (run/"panel-check.log").read_text()
cal=pd.read_csv(run/"panel_calendar.csv")
assert int(cal.N_lag1.sum())==lag1 and int(cal.N_lag2.sum())==lag2
manifest=json.loads((ROOT/"data/g0-5-development/manifest.json").read_text())
# WFDOC: Receipt merekam hash dan hitungan panel development serta menyatakan bahwa linkage aktual tidak diverifikasi.
receipt={"status":"PASS_DEVELOPMENT_PANEL", "created_utc":datetime.now(timezone.utc).isoformat(), "checkout":str(ROOT),"git_head":subprocess.check_output(["git","rev-parse","HEAD"],cwd=ROOT,text=True).strip(),"manifest_sha256":PIN,"version":manifest["version"],"rows_loaded":len(frame),"package_columns":len(manifest["column_names"]),"selected_columns":cols,"unique_psid":frame.psid.nunique(),"psid_missing":int(frame.psid.isna().sum()),"psid_status_counts":frame.psid_status.value_counts().to_dict(),"firm_year_duplicates":int(frame.duplicated(["psid","source_year"]).sum()),"constructed_links_verified":len(prev),"annual_lags":lag1,"calendar_two_year_lags":lag2,"adjacent_observed_gap_counts":{str(int(k)):int(v) for k,v in gaps.items()},"observed_years":sorted(map(int,frame.source_year.unique())),"firm_block_invariant":True,"stata_log_sha256":sha(run/"panel-check.log"),"code_sha256":sha(__file__),"local_run":str(run),"actual_linkage_claim":False}
(HERE/"qa/v3-panel-input-check.json").write_text(json.dumps(receipt,indent=2)+"\n")
cal.to_csv(HERE/"qa/v3-panel-calendar.csv",index=False)
print(json.dumps(receipt,indent=2))
