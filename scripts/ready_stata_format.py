"""Tested native Stata entry and PNG/Excel/CSV export transformation."""
from pathlib import Path
import re

def no_pdf(source):
    """Remove only PDF presentation statements, retaining all data calculations."""
    out, removed = [], []
    continuation = False
    in_pdf_program = False
    for n, line in enumerate(source.splitlines(), 1):
        s = line.strip()
        if re.match(r'program\s+(?:define\s+)?ctable_pdf\b', s):
            in_pdf_program = True
        if in_pdf_program:
            removed.append(n)
            out.append('* SI presentation: PDF helper omitted from this package.')
            if s == 'end':
                in_pdf_program = False
            continue
        comment = s.startswith(('*', '//'))
        presentation = not comment and (
            bool(re.search(r'\bputpdf\s', s)) or
            bool(re.search(r'\bgraph export\s+.*\.pdf', s)) or
            bool(re.match(r'ctable_pdf\s', s)) or
            bool(re.match(r'(?:di(?:splay)?)(?:\s+as\s+\w+)?\s+.*(?:\.pdf|putpdf)', s))
        )
        if continuation or presentation:
            removed.append(n)
            # Stata continues after /// even when a human comment follows it.
            continuation = bool(re.search(r'///(?:\s.*)?$', s))
            out.append('* SI presentation: PDF export omitted; CSV and PNG remain.')
        else:
            out.append(re.sub(r'^(\s*foreach\s+out\s+in\s+)png\s+pdf(\s*\{)',r'\1png\2',line))
    assert not in_pdf_program and not continuation
    return '\n'.join(out)+'\n', removed


def render_master(modules, code_paths):
    lines=['/*','SURVEI INDUSTRI: DATA READY -> SELURUH ANALISIS','Buka do-file ini di Stata Do-file Editor. Ubah dua lokasi di bawah, lalu Do.','Data dan add-on sudah disertakan. Tidak perlu Python atau file .command.','Mac: contoh folder /Users/natanaelmassie/Downloads/SI-Ready-STATA','Windows: contoh folder C:/SI-Ready-STATA','*/','version 17','clear all','set more off','set varabbrev off','set maxvar 10000','set linesize 255','','* ===== UBAH LOKASI DI SINI =====','global SI_ROOT "/Users/natanaelmassie/Downloads/SI-Ready-STATA"','global READY_DATA "$SI_ROOT/data/analysis_ready_data.dta"','','* Opsional: isi folder data produk bila tersedia; boleh tetap kosong.','global PRODUCT_DATA ""','','* ===== JALANKAN SELURUH DO-FILE; BAGIAN BAWAH TIDAK PERLU DIUBAH =====','capture confirm file "$READY_DATA"','if _rc {','    display as error "Data tidak ditemukan. Perbaiki global READY_DATA di bagian atas."','    exit 601','}','capture confirm file "$SI_ROOT/modules.json"','if _rc {','    display as error "Folder kode tidak ditemukan. Perbaiki global SI_ROOT di bagian atas."','    exit 601','}','adopath ++ "$SI_ROOT/ado"','mata: mata mlib index','foreach p in reghdfe ftools csdid drdid did_imputation eventstudyinteract did_multiplegt_dyn require gtools estout prodest {','    capture which `p\'','    if _rc {','        display as error "Add-on `p\' tidak ditemukan. Ekstrak seluruh isi ZIP, termasuk folder ado."','        exit 499','    }','}','use "$READY_DATA", clear','isid firm_id year','confirm numeric variable workers value_added_nominal','assert year==floor(year) & !missing(year)','','capture mkdir "$SI_ROOT/hasil"','local waktu = subinstr("`c(current_date)\'_`c(current_time)\'"," ","",.)','local waktu = subinstr("`waktu\'",":","",.)','global SI_RUN "$SI_ROOT/hasil/`waktu\'"','mkdir "$SI_RUN"','global SI_KODE "$SI_RUN/kode"','global SI_INPUT "$SI_KODE/20260917-run/block-0-data-preparation/analysis_ready_data.dta"','global ROSTER "$PRODUCT_DATA"','if "$ROSTER"=="" global ROSTER "$SI_RUN/input-produk-belum-tersedia"','mkdir "$SI_KODE"']
    files=sorted(Path(x) for x in code_paths)
    dirs=set()
    for f in files:
        for parent in f.parents:
            if str(parent) != '.':
                dirs.add(parent.as_posix())
    dirs.add('20260917-run/block-0-data-preparation');dirs.add('20260917-run')
    for d in sorted(dirs,key=lambda x:(x.count('/'),x)):lines.append('capture mkdir "$SI_KODE/'+d+'"')
    for f in files:
        rel = f.as_posix()
        lines.append('quietly copy "$SI_ROOT/kode/'+rel+'" "$SI_KODE/'+rel+'"')
    lines += ['quietly copy "$READY_DATA" "$SI_INPUT"','file open si_status using "$SI_RUN/STATUS.tsv", write text','file write si_status "analisis" _tab "penyusun" _tab "kode_stata" _tab "detik" _tab "hasil" _n','file close si_status','local si_success 0','local si_missing 0','local si_failed 0']
    for i,m in enumerate(modules,1):
     path='$SI_KODE/'+m['path']
     args='"$SI_INPUT" "'+path+'"' if m['kind']=='estimasi' else '"$SI_KODE" "" "$ROSTER"'
     lines += ['',f'display _n as result "[{i}/34] {m["id"]}: {m["title"]}"',f'cd "{path}"','local mulai = clock("`c(current_date)\' `c(current_time)\'", "DMYhms")',f'capture noisily do "{path}/00_run.do" {args}','local kode = _rc','local detik = (clock("`c(current_date)\' `c(current_time)\'", "DMYhms")-`mulai\')/1000','local keadaan "selesai"','if `kode\'!=0 local keadaan "gagal"','if `kode\'==601 local keadaan "data_tambahan_belum_ada"']
     if m['id']=='G12':lines += [f'capture confirm file "{path}/output/b1_12_tables.xlsx"','if _rc & `kode\'==0 local keadaan "data_tambahan_belum_ada"']
     lines += ['if "`keadaan\'"=="selesai" local si_success = `si_success\'+1','if "`keadaan\'"=="data_tambahan_belum_ada" local si_missing = `si_missing\'+1','if "`keadaan\'"=="gagal" local si_failed = `si_failed\'+1','file open si_status using "$SI_RUN/STATUS.tsv", write text append',f'file write si_status "{m["id"]}" _tab "{m["person"]}" _tab "`kode\'" _tab "`detik\'" _tab "`keadaan\'" _n','file close si_status','capture log close _all',f'display as result "{m["id"]}: `keadaan\' (kode Stata `kode\')"']
    lines += ['','cd "$SI_RUN"','display _n as result "SELESAI MENCOBA 34 KELOMPOK ANALISIS."','display as result "Berhasil: `si_success\'. Menunggu data tambahan: `si_missing\'. Gagal: `si_failed\'."','display as result "Folder hasil: $SI_RUN"','display as result "Buka STATUS.tsv untuk ringkasan; tabel ada di kode/<kelompok>/output atau tables."','display as text "Hasil latihan. Lima kelompok memerlukan kepemilikan pemerintah atau data produk/bahan baku."']
    return '\n'.join(lines)+'\n'
