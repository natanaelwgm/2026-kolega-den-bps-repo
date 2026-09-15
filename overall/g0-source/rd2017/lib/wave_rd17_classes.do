* Tujuan: Jalankan langkah R&D 2017 yang ditunjukkan perintah dan berkas input pada file ini. // WFDOC-INJECTED
* Input: Data atau argumen yang disediakan pemanggil; lihat perintah di file ini. // WFDOC-INJECTED
* Output: Hasil atau perubahan data yang disebut oleh perintah di file ini. // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
* Upstream only. Exact literal classes from the passed 2017 parser.
capture program drop wave_rd17_literal_class
* Definisikan perintah bantu wave_rd17_literal_class; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wave_rd17_literal_class
 syntax varname(string), GENerate(name) PRESENT(varname numeric)
 assert inlist(`present',0,1)
 tempvar token
 clonevar `token'=`varlist'
 replace `token'=ustrtrim(`token')
 generate str6 `generate'="other"
 replace `generate'=`token' if inlist(`token',"1","2")
 replace `generate'="blank" if `token'==""
 replace `generate'="absent" if `present'==0
end
capture program drop wave_rd17_classes
* Definisikan perintah bantu wave_rd17_classes; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define wave_rd17_classes
 confirm numeric variable source_year
 confirm new variable rd17_own_token_class rd17_external_token_class
 quietly count if source_year==2017
* Isi blok hanya dijalankan bila r(N) sama dengan 0. // WFDOC-INJECTED
 if r(N)==0 {
  generate str6 rd17_own_token_class=""
  generate str6 rd17_external_token_class=""
  exit
 }
 confirm string variable raw_rnd17 raw_costrd17
 confirm numeric variable rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd
* Ulangi blok untuk v: raw_rnd17, raw_costrd17. // WFDOC-INJECTED
 foreach v in raw_rnd17 raw_costrd17 {
  local t : type `v'
  assert "`t'"=="str1"
 }
 tempvar present own external
 generate byte `present'=1
 wave_rd17_literal_class raw_rnd17, generate(`own') present(`present')
 wave_rd17_literal_class raw_costrd17, generate(`external') present(`present')
 generate str6 rd17_own_token_class=`own' if source_year==2017
 generate str6 rd17_external_token_class=`external' if source_year==2017
* Ulangi blok untuk side: own, external. // WFDOC-INJECTED
 foreach side in own external {
  local value=cond("`side'"=="own","rd_indicator_raw","val_costrd")
  local state=cond("`side'"=="own","vs_rd_indicator_raw","vs_val_costrd")
  assert inlist(`state',0,1,2,3,5) if source_year==2017
  assert `value'==1 & `state'==0 if source_year==2017 & rd17_`side'_token_class=="1"
  assert `value'==2 & `state'==0 if source_year==2017 & rd17_`side'_token_class=="2"
  assert missing(`value') & inlist(`state',3,5) if source_year==2017 & rd17_`side'_token_class=="blank"
  assert inlist(rd17_`side'_token_class,"1","2","blank","other") if source_year==2017
  assert rd17_`side'_token_class=="" if source_year!=2017
 }
end
