#!/usr/bin/env python3
"""Draw statistical charts only from saved Stata aggregate CSVs; no estimation."""
# WFDOC: Plot operasional hanya membaca CSV agregat Stata dan selalu berlabel DEVELOPMENT; grafik ini bukan hasil empiris riil.
import json
from pathlib import Path
import sys
import hashlib
import numpy as np
import pandas as pd
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

LABEL = "G0.5 DEVELOPMENT — perturbed data; not final empirical findings"
BLUE, TEAL, ORANGE, GREY = "#214E75", "#008879", "#C66A20", "#64748B"
plt.rcParams.update({"font.family": "Times New Roman", "font.size": 11, "axes.titlesize": 17, "axes.labelsize": 11, "axes.spines.top": False, "axes.spines.right": False, "svg.fonttype": "none", "savefig.facecolor": "white"})


def main(run):
    out, figdir = run / "outputs", run / "figures"
    figdir.mkdir(exist_ok=True)
    receipt = []
    def save(fig, name, files, caption):
        fig.text(.07, .11, caption, fontsize=9, color=GREY, va="top")
        fig.text(.07, .025, LABEL, fontsize=9, weight="bold", color=BLUE)
        left = .26 if name in {"input_domains", "estimator_status"} else (.20 if name=="sample_flow" else .09)
        fig.subplots_adjust(left=left, right=.96, top=.82, bottom=.25 if name=="input_domains" else .22)
        for ext in ["svg", "png"]:
            fig.savefig(figdir / f"{name}.{ext}", dpi=180)
        receipt.append({"figure": name, "data": [{"path": f"outputs/{f}", "sha256": hashlib.sha256((out/f).read_bytes()).hexdigest()} for f in files], "label": LABEL})
        plt.close(fig)
    # WFDOC: Grafik gelombang menghitung catatan per tahun, menandai 2016 yang hilang, dan tidak mengartikan batang sebagai perusahaan unik atau bobot nasional.
    waves = pd.read_csv(out / "observed_waves.csv")
    fig, ax = plt.subplots(figsize=(12, 7))
    ax.bar(waves.source_year, waves.N_source, color=BLUE, width=.65)
    ax.set_xticks(range(2010, 2023))
    ax.set_ylabel("Observasi sumber; bukan jumlah perusahaan unik")
    ax.yaxis.set_major_formatter(FuncFormatter(lambda x,p:f"{int(x):,}"))
    ax.set_ylim(0, 4000)
    for r in waves.itertuples():
        ax.text(r.source_year, r.N_source+55, f"{r.N_source:,}", ha="center", fontsize=9)
    ax.axvspan(2015.55,2016.45, color="#F1F5F9")
    ax.text(2016, 1950, "2016\ntidak\ntersedia", ha="center", color=GREY)
    fig.suptitle("33.049 observasi membentuk 10.395 perusahaan fiktif", x=.07, ha="left", fontsize=17, weight="bold")
    save(fig,"coverage_by_year",["observed_waves.csv"],"Sumber: ekspor Stata G1_E01. 12 wave, 2010–2015 dan 2017–2022. Tidak ada bobot nasional.\nBatang menghitung catatan per tahun; celah 2016 dipertahankan. Tidak ada interval sampling untuk hitungan extract.")
    # WFDOC: Nilai positif, nol, negatif dan missing ditampilkan terpisah; positif saja belum membuktikan definisi, skala, deflator atau harga input.
    domain = pd.read_csv(out / "variable_domains.csv")
    names={"value_added_nominal":"Nilai tambah nominal", "workers":"Pekerja", "capital_stock_nominal":"Stok modal nominal", "capital_additions_nominal":"Tambahan modal nominal", "val_rtlvcu":"Kandidat bahan baku", "value_added_real":"Nilai tambah riil", "capital_real":"Stok modal riil"}
    d=domain.groupby("variable")[["N_positive","N_zero","N_negative","N_missing","N_source"]].sum().loc[list(names)]
    fig,ax=plt.subplots(figsize=(12,7)); left=np.zeros(len(d))
    for col,label,color in [("N_positive","Positif",TEAL),("N_zero","Nol",GREY),("N_negative","Negatif",ORANGE),("N_missing","Missing","#E2E8F0")]:
        val=d[col].to_numpy(); ax.barh(list(names.values()),val,left=left,color=color,label=label); left+=val
    for j,(_,r) in enumerate(d.iterrows()):
        ax.text(33400,j,f"{int(r.N_positive):,} positif",va="center",fontsize=10)
    ax.invert_yaxis(); ax.set_xlim(0,40500); ax.set_xticks([0,10000,20000,33049]); ax.set_xticklabels(["0","10.000","20.000","33.049"])
    ax.set_xlabel("Observasi; denominator tiap variabel = 33.049")
    fig.legend(*ax.get_legend_handles_labels(),ncol=4,frameon=False,loc="lower center",bbox_to_anchor=(.57,.14))
    fig.suptitle("Nilai kandidat terisi, tetapi variabel riil belum tersedia",x=.07,ha="left",fontsize=18,weight="bold")
    fig.subplots_adjust(left=.26)
    save(fig,"input_domains",["variable_domains.csv"],"Sumber: ekspor Stata G1_E04. Positif berarti lolos domain angka saja; definisi, skala dan harga masih perlu bukti.\nBahan baku: val_rtlvcu, kandidat belum diterima sebagai proxy TFP. Tidak ada pengisian nilai missing.")
    # WFDOC: Funnel menunjukkan attrition setiap gate metode; domain awal adalah kandidat nominal dan tidak menyiratkan input riil diterima.
    flow=pd.read_csv(out / "tfp_sample_attrition.csv",dtype={"code_prefix":str})
    f=flow.loc[flow.code_prefix.eq("ALL")].groupby(["method","stage"]).N_retained.sum()
    fig,axs=plt.subplots(1,2,figsize=(12,7),sharex=True)
    stages=["Semua catatan","Domain nominal positif","Flag konsep modal","Input riil diterima","Eligible metode","Sampel bersama"]
    for ax,m,title in [(axs[0],"op","OP: proxy investasi"),(axs[1],"lp","LP / ACF / Wooldridge: kandidat bahan baku")]:
        values=f.loc[m].sort_index().to_numpy()
        ax.barh(stages,values,color=[BLUE,TEAL,TEAL,ORANGE,ORANGE,ORANGE]); ax.invert_yaxis()
        ax.set_title(title,fontsize=12,pad=15)
        for j,n in enumerate(values): ax.text(n+550,j,f"{int(n):,}",va="center",fontsize=11)
        ax.set_xlim(0,39000); ax.set_xticks([0,15000,33049]); ax.set_xticklabels(["0","15.000","33.049"]); ax.set_xlabel("Observasi tersisa")
    fig.suptitle("Spesifikasi riil utama masih tertahan pada pengukuran dan harga",x=.05,ha="left",fontsize=17,weight="bold")
    fig.subplots_adjust(wspace=.7)
    save(fig,"sample_flow",["tfp_sample_attrition.csv"],"Sumber: ekspor Stata G1_E09. Flag konsep modal diwarisi dari kuesioner; bukan pengesahan skala pengukuran.\nDomain awal OP mensyaratkan tambahan modal positif. LP/ACF/W memiliki hitungan awal sama; asumsi metodenya berbeda.")
    # WFDOC: Heatmap menunjukkan bagian observasi yang lolos gate bukti per tahun, bukan koefisien atau hasil estimasi.
    gates=pd.read_csv(out / "eligibility_gates.csv")
    chosen={"g1_panel_usable":"Hubungan perusahaan", "g1_stock_concept":"Flag konsep stok modal", "g1_measurement_admitted":"Skala pengukuran diterima", "g1_technology_verified":"Padanan teknologi diterima", "g1_proxy_definition_verified":"Definisi proxy diterima", "g1_real_base":"Input riil dasar diterima"}
    matrix=gates.loc[gates.gate.isin(chosen)].pivot(index="gate",columns="source_year",values="N_pass").loc[list(chosen)]
    den=gates.loc[gates.gate.isin(chosen)].pivot(index="gate",columns="source_year",values="N_source").loc[list(chosen)]
    values=100*matrix/den
    fig,ax=plt.subplots(figsize=(12,7)); im=ax.imshow(values,vmin=0,vmax=100,cmap="Blues",aspect="auto")
    ax.set_yticks(range(len(chosen)),labels=list(chosen.values())); ax.set_xticks(range(12),labels=[str(int(x)) for x in matrix.columns]); ax.tick_params(length=0)
    for i in range(values.shape[0]):
        for j in range(values.shape[1]): ax.text(j,i,f"{values.iloc[i,j]:.0f}%",ha="center",va="center",color="white" if values.iloc[i,j]>55 else BLUE,fontsize=10)
    fig.suptitle("Panel development lolos; pengukuran riil memerlukan bukti",x=.05,ha="left",fontsize=17,weight="bold")
    save(fig,"estimator_status",["eligibility_gates.csv"],"Sumber: ekspor Stata G1_E19. Persen observasi yang memenuhi tiap gate; penyebut: seluruh catatan pada tahun terkait.\nGate ini untuk spesifikasi riil utama. Hasil cabang nominal development disajikan pada exhibit terpisah.")
    # WFDOC: Manifest plot merekam CSV sumber, hash dan label development untuk setiap gambar.
    (run / "qa/plot-data-manifest.json").write_text(json.dumps(receipt,indent=2,ensure_ascii=False)+"\n")
    print(f"Saved {len(receipt)} chart pairs from Stata CSVs")


if __name__=="__main__":
    main(Path(sys.argv[1]).resolve())
