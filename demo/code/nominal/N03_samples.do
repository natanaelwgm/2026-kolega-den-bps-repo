* WFDOC: Freeze own/common samples across all supplied years; each dynamic observation needs exact t−1 production in the same sector.
* WFDOC: Support CSV mencatat denominator sumber, domain, transisi, selection risk dan disappearance per sektor/metode/sampel.
use "$G1_RUN/nominal/N02_source_and_risk.dta", clear
xtset psid source_year
foreach m in op lp acf wrdg common {
* WFDOC: Transisi butuh domain di t dan t−1 kalender; tidak ada pemampatan gap.
    * WFDOC: nom_sector_num memeriksa sektor t dan t−1 sama; event interval dengan lag sektor berbeda tidak memenuhi dynamic.
    gen byte nom_dynamic_`m'=nom_domain_`m'==1 & L.nom_domain_`m'==1 & nom_sector_num==L.nom_sector_num
    assert !inlist(source_year,2010,2011,2016,2017,2018) if nom_dynamic_`m'
}
* WFDOC: Selection mencakup risk rows dengan lagged K dan I; event intervals dapat berada di luar production domain.
* WFDOC: Selection memakai interval risk dengan stok awal dan kandidat investasi lagged yang lengkap; interval event dapat mendukung OP tanpa menjadi baris produksi.
gen byte nom_selection=nom_risk==1 & !missing(L.nom_k,L.nom_i) & nom_sector_num==L.nom_sector_num
save "$G1_RUN/nominal/N03_frozen.dta", replace
tempname supp
* WFDOC: Support menyimpan denominator source, domain, dynamic dan selection secara terpisah per sektor×metode×sampel agar attrition tidak terbaca sebagai satu sampel.
postfile `supp' str2 sector str8 method str8 sample_id double N_source double N_domain double N_dynamic double N_selection double N_disappearance using "$G1_RUN/nominal/support.dta", replace
levelsof nom_sector if !nom_interval_only, local(sectors)
foreach sector of local sectors {
    foreach method in op lp acf wrdg {
        foreach sample in own common {
            local domain `method'
            if "`sample'"=="common" local domain common
            quietly count if nom_sector=="`sector'" & !nom_interval_only
            local nsource=r(N)
            quietly count if nom_sector=="`sector'" & nom_domain_`domain'
            local ndomain=r(N)
            quietly count if nom_sector=="`sector'" & nom_dynamic_`domain'
            local ndynamic=r(N)
            quietly count if nom_sector=="`sector'" & nom_selection
            local nselection=r(N)
            quietly count if nom_sector=="`sector'" & nom_selection & nom_disappearance==1
            post `supp' ("`sector'") ("`method'") ("`sample'") (`nsource') (`ndomain') (`ndynamic') (`nselection') (r(N))
        }
    }
}
postclose `supp'
preserve
use "$G1_RUN/nominal/support.dta", clear
gen str100 data_label="G0.5 DEVELOPMENT - nominal VA compatibility; not real TFP"
export delimited using "$G1_RUN/outputs/nominal_sample_support.csv", replace
restore
