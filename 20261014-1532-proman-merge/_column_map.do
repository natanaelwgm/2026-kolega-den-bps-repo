/*==========================================================================
  _column_map.do -- WHICH COLUMN HEADER MEANS WHAT  (edit here in the room)

  01_intake.do finds every column by its header, never by its position.
  A header is first NORMALISED:
      1. lower case, keep only the letters a-z and digits 0-9
         ("B3R307_K5_lokal (Nilai BB Lokal)" -> "b3r307k5lokalnilaibblokal")
      2. a trailing year is removed: 4 digits 2010-2022, or the file's own
         2-digit year ("Nilpro22" -> "nilpro", "Kbli522" -> "kbli5",
         "Volok21" -> "volok", "Kbli2015" -> "kbli")
  Then, for each item (concept) in the order of *_CONCEPTS:
      x_<item>  EXACT normalised names, tried first, left to right
      c_<item>  "CONTAINS" patterns, tried only after every item has had
                its exact names (so a long questionnaire header can match)
  One column is used for one item only.

  IF A FILE IS NOT READ CORRECTLY: run  00_run.do "" check , open
  output/intake_report.csv (column "mapping" shows item=header used, and
  "headers" every normalised header of the file), then add the normalised
  header to the right x_ list below and run again.

  Items marked REQUIRED stop the run when not found. Everything else is
  optional: a missing optional item is created empty and reported.
==========================================================================*/

* ---- PROMAN (products) ------------------------------------------------------
global PM_CONCEPTS "kipb year prov kab kbli5 product kbki unit volume val_prod exp_pct dest_name dest_code flag"
global PM_REQUIRED "prov kbli5 val_prod"
global PM_x_kipb      "kipb kip kipbn kipbaru idkip nokip kipbbaru kodekip"
global PM_c_kipb      ""
global PM_x_year      "tahun year thn"
global PM_c_year      ""
global PM_x_prov      "prop prov provinsi kdprop kodeprop kodeprov kdprov dprovi kodeprovinsi"
global PM_c_prov      ""
global PM_x_kab       "kab kabu kabupaten kabkota kdkab kodekab kodekabkota dkabup kodekabupaten"
global PM_c_kab       ""
global PM_x_kbli5     "kbli kbli5 kbli2009 kodekbli kbliperusahaan kbli5digit"
global PM_c_kbli5     ""
global PM_x_product   "komoditi produk namaproduk namakomoditi barang komoditas"
global PM_c_product   ""
global PM_x_kbki      "kodkbki kodekbki kbki kdkbki kodekomoditi kodeproduk"
global PM_c_kbki      ""
global PM_x_unit      "satuan sat unit"
global PM_c_unit      ""
global PM_x_volume    "volume volpro vol volprod banyaknya kuantitas jumlahproduksi"
global PM_c_volume    ""
global PM_x_val_prod  "nilai nilpro nilaiproduksi nilprod nilaiprod"
global PM_c_val_prod  "nilaiproduksi"
global PM_x_exp_pct   "prprex ekspor persenekspor pctekspor prexp eksporpersen proporsiekspor persentaseekspor"
global PM_c_exp_pct   "persenekspor persentaseekspor proporsiekspor"
global PM_x_dest_name "namaneg negara negaratujuan desneg namanegara negaratujuanekspor"
global PM_c_dest_name "negaratujuan"
global PM_x_dest_code "kodeneg kdneg kodenegara kodenegaratujuan"
global PM_c_dest_code ""
global PM_x_flag      "flg flagpr flag"
global PM_c_flag      ""

* ---- BAHAN BAKU (raw materials) -----------------------------------------------
* (at least one of val_local / val_import / val_total must be found)
global BB_CONCEPTS "kipb year prov kab kbli5 material kbki unit vol_local val_local vol_import val_import val_total origin_name origin_code flag"
global BB_REQUIRED "prov kbli5"
global BB_x_kipb        "kipb kip kipbn kipbaru idkip nokip kipbbaru kodekip"
global BB_c_kipb        ""
global BB_x_year        "tahun year thn"
global BB_c_year        ""
global BB_x_prov        "prop prov provinsi kdprop kodeprop kodeprov kdprov dprovi kodeprovinsi"
global BB_c_prov        ""
global BB_x_kab         "kab kabu kabupaten kabkota kdkab kodekab kodekabkota dkabup kodekabupaten"
global BB_c_kab         ""
global BB_x_kbli5       "kbli5 kbli kbli2009 kodekbli kbliperusahaan kbli5digit"
global BB_c_kbli5       ""
global BB_x_material    "komoditi bahanbaku namabahanbaku b3r307k2bahanbaku bahan komoditas"
global BB_c_material    "bahanbaku"
global BB_x_kbki        "kodekbki kodkbki kbki kdkbki kodebahanbaku"
global BB_c_kbki        ""
global BB_x_unit        "satuan sat unit"
global BB_c_unit        ""
global BB_x_vol_local   "volok vollokal banyaklokal banyaknyalokal"
global BB_c_vol_local   "banyaknyabblokal banyaknyalokal banyaklokal"
global BB_x_val_local   "nilok nilailokal nillok nilaibblokal"
global BB_c_val_local   "nilaibblokal nilailokal"
global BB_x_vol_import  "volim volimpor banyakimpor banyaknyaimpor"
global BB_c_vol_import  "banyaknyabbimpor banyaknyaimpor banyakimpor"
global BB_x_val_import  "nilim nilaiimpor nilimp nilaibbimpor"
global BB_c_val_import  "nilaibbimpor nilaiimpor"
global BB_x_val_total   "totalnilaibahanbaku nilaitotal totalnilai nilai"
global BB_c_val_total   "totalnilai"
global BB_x_origin_name "desneg negarautamadesk namanegara namaneg negaraasal negara"
global BB_c_origin_name "negarautamadesk negaraasal"
global BB_x_origin_code "kodeneg kdneg kodenegara"
global BB_c_origin_code "negarautama"
global BB_x_flag        "flg flag"
global BB_c_flag        ""

* ---- which file is which roster (normalised file name, a-z0-9 only) ----------
* Bahan Baku is tested first (more specific). Add words if the real files
* are named differently.
global PM_FILE_BB     "bahanbaku bahan rawmaterial"
global PM_FILE_PROMAN "proman produk produksi production"
