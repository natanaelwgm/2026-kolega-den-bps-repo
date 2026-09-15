confirm variable source_year
capture recast int source_year
confirm variable source_row
capture recast int source_row
confirm variable raw_kipb
quietly count if strlen(raw_kipb)>3
if r(N)==0 recast str3 raw_kipb
confirm variable raw_dprovi10
quietly count if strlen(raw_dprovi10)>2
if r(N)==0 recast str2 raw_dprovi10
confirm variable raw_dklui10
quietly count if strlen(raw_dklui10)>3
if r(N)==0 recast str3 raw_dklui10
confirm variable raw_dseqno10
quietly count if strlen(raw_dseqno10)>4
if r(N)==0 recast str4 raw_dseqno10
confirm variable raw_dstats10
quietly count if strlen(raw_dstats10)>1
if r(N)==0 recast str1 raw_dstats10
confirm variable raw_locati10
quietly count if strlen(raw_locati10)>1
if r(N)==0 recast str1 raw_locati10
confirm variable raw_jan10
quietly count if strlen(raw_jan10)>1
if r(N)==0 recast str1 raw_jan10
confirm variable raw_feb10
quietly count if strlen(raw_feb10)>1
if r(N)==0 recast str1 raw_feb10
confirm variable raw_mar10
quietly count if strlen(raw_mar10)>1
if r(N)==0 recast str1 raw_mar10
confirm variable raw_apr10
quietly count if strlen(raw_apr10)>1
if r(N)==0 recast str1 raw_apr10
confirm variable raw_mei10
quietly count if strlen(raw_mei10)>1
if r(N)==0 recast str1 raw_mei10
confirm variable raw_jun10
quietly count if strlen(raw_jun10)>1
if r(N)==0 recast str1 raw_jun10
confirm variable raw_jul10
quietly count if strlen(raw_jul10)>1
if r(N)==0 recast str1 raw_jul10
confirm variable raw_ags10
quietly count if strlen(raw_ags10)>1
if r(N)==0 recast str1 raw_ags10
confirm variable raw_sep10
quietly count if strlen(raw_sep10)>1
if r(N)==0 recast str1 raw_sep10
confirm variable raw_okt10
quietly count if strlen(raw_okt10)>1
if r(N)==0 recast str1 raw_okt10
confirm variable raw_nop10
quietly count if strlen(raw_nop10)>1
if r(N)==0 recast str1 raw_nop10
confirm variable raw_des10
quietly count if strlen(raw_des10)>1
if r(N)==0 recast str1 raw_des10
confirm variable raw_year10
quietly count if strlen(raw_year10)>2
if r(N)==0 recast str2 raw_year10
confirm variable raw_disic510
quietly count if strlen(raw_disic510)>5
if r(N)==0 recast str5 raw_disic510
confirm variable raw_mainpr10
quietly count if strlen(raw_mainpr10)>40
if r(N)==0 recast str40 raw_mainpr10
confirm variable raw_dpusat10
quietly count if strlen(raw_dpusat10)>5
if r(N)==0 recast str5 raw_dpusat10
confirm variable raw_dpemda10
quietly count if strlen(raw_dpemda10)>5
if r(N)==0 recast str5 raw_dpemda10
confirm variable raw_ddmstk10
quietly count if strlen(raw_ddmstk10)>5
if r(N)==0 recast str5 raw_ddmstk10
confirm variable raw_dasing10
quietly count if strlen(raw_dasing10)>17
if r(N)==0 recast str17 raw_dasing10
confirm variable raw_ceksum10
quietly count if strlen(raw_ceksum10)>9
if r(N)==0 recast str9 raw_ceksum10
confirm variable raw_lpmltl10
quietly count if strlen(raw_lpmltl10)>4
if r(N)==0 recast str4 raw_lpmltl10
confirm variable raw_lpwltl10
quietly count if strlen(raw_lpwltl10)>5
if r(N)==0 recast str5 raw_lpwltl10
confirm variable raw_lprnou10
quietly count if strlen(raw_lprnou10)>5
if r(N)==0 recast str5 raw_lprnou10
confirm variable raw_lnmltl10
quietly count if strlen(raw_lnmltl10)>4
if r(N)==0 recast str4 raw_lnmltl10
confirm variable raw_lnwltl10
quietly count if strlen(raw_lnwltl10)>4
if r(N)==0 recast str4 raw_lnwltl10
confirm variable raw_lnpnou10
quietly count if strlen(raw_lnpnou10)>5
if r(N)==0 recast str5 raw_lnpnou10
confirm variable raw_zpsvcu10
quietly count if strlen(raw_zpsvcu10)>9
if r(N)==0 recast str9 raw_zpsvcu10
confirm variable raw_zpovcu10
quietly count if strlen(raw_zpovcu10)>8
if r(N)==0 recast str8 raw_zpovcu10
confirm variable raw_zpivcu10
quietly count if strlen(raw_zpivcu10)>8
if r(N)==0 recast str8 raw_zpivcu10
confirm variable raw_zppvcu10
quietly count if strlen(raw_zppvcu10)>8
if r(N)==0 recast str8 raw_zppvcu10
confirm variable raw_zpavcu10
quietly count if strlen(raw_zpavcu10)>8
if r(N)==0 recast str8 raw_zpavcu10
confirm variable raw_zpdvcu10
quietly count if strlen(raw_zpdvcu10)>9
if r(N)==0 recast str9 raw_zpdvcu10
confirm variable raw_znsvcu10
quietly count if strlen(raw_znsvcu10)>9
if r(N)==0 recast str9 raw_znsvcu10
confirm variable raw_znovcu10
quietly count if strlen(raw_znovcu10)>8
if r(N)==0 recast str8 raw_znovcu10
confirm variable raw_znivcu10
quietly count if strlen(raw_znivcu10)>8
if r(N)==0 recast str8 raw_znivcu10
confirm variable raw_znpvcu10
quietly count if strlen(raw_znpvcu10)>8
if r(N)==0 recast str8 raw_znpvcu10
confirm variable raw_znavcu10
quietly count if strlen(raw_znavcu10)>6
if r(N)==0 recast str6 raw_znavcu10
confirm variable raw_zndvcu10
quietly count if strlen(raw_zndvcu10)>9
if r(N)==0 recast str9 raw_zndvcu10
confirm variable raw_epeliu10
quietly count if strlen(raw_epeliu10)>8
if r(N)==0 recast str8 raw_epeliu10
confirm variable raw_epevcu10
quietly count if strlen(raw_epevcu10)>8
if r(N)==0 recast str8 raw_epevcu10
confirm variable raw_epelie10
quietly count if strlen(raw_epelie10)>5
if r(N)==0 recast str5 raw_epelie10
confirm variable raw_epevce10
quietly count if strlen(raw_epevce10)>6
if r(N)==0 recast str6 raw_epevce10
confirm variable raw_esoliu10
quietly count if strlen(raw_esoliu10)>8
if r(N)==0 recast str8 raw_esoliu10
confirm variable raw_esovcu10
quietly count if strlen(raw_esovcu10)>9
if r(N)==0 recast str9 raw_esovcu10
confirm variable raw_esolie10
quietly count if strlen(raw_esolie10)>8
if r(N)==0 recast str8 raw_esolie10
confirm variable raw_esovce10
quietly count if strlen(raw_esovce10)>9
if r(N)==0 recast str9 raw_esovce10
confirm variable raw_eoiliu10
quietly count if strlen(raw_eoiliu10)>7
if r(N)==0 recast str7 raw_eoiliu10
confirm variable raw_eoivcu10
quietly count if strlen(raw_eoivcu10)>8
if r(N)==0 recast str8 raw_eoivcu10
confirm variable raw_eoilie10
quietly count if strlen(raw_eoilie10)>1
if r(N)==0 recast str1 raw_eoilie10
confirm variable raw_eoivce10
quietly count if strlen(raw_eoivce10)>1
if r(N)==0 recast str1 raw_eoivce10
confirm variable raw_eclkgu10
quietly count if strlen(raw_eclkgu10)>8
if r(N)==0 recast str8 raw_eclkgu10
confirm variable raw_eclvcu10
quietly count if strlen(raw_eclvcu10)>8
if r(N)==0 recast str8 raw_eclvcu10
confirm variable raw_eclkge10
quietly count if strlen(raw_eclkge10)>7
if r(N)==0 recast str7 raw_eclkge10
confirm variable raw_eclvce10
quietly count if strlen(raw_eclvce10)>7
if r(N)==0 recast str7 raw_eclvce10
confirm variable raw_egam3u10
quietly count if strlen(raw_egam3u10)>7
if r(N)==0 recast str7 raw_egam3u10
confirm variable raw_egavcu10
quietly count if strlen(raw_egavcu10)>9
if r(N)==0 recast str9 raw_egavcu10
confirm variable raw_egam3e10
quietly count if strlen(raw_egam3e10)>6
if r(N)==0 recast str6 raw_egam3e10
confirm variable raw_egavce10
quietly count if strlen(raw_egavce10)>8
if r(N)==0 recast str8 raw_egavce10
confirm variable raw_elpkgu10
quietly count if strlen(raw_elpkgu10)>6
if r(N)==0 recast str6 raw_elpkgu10
confirm variable raw_elpvcu10
quietly count if strlen(raw_elpvcu10)>7
if r(N)==0 recast str7 raw_elpvcu10
confirm variable raw_elpkge10
quietly count if strlen(raw_elpkge10)>6
if r(N)==0 recast str6 raw_elpkge10
confirm variable raw_elpvce10
quietly count if strlen(raw_elpvce10)>7
if r(N)==0 recast str7 raw_elpvce10
confirm variable raw_encvcu10
quietly count if strlen(raw_encvcu10)>8
if r(N)==0 recast str8 raw_encvcu10
confirm variable raw_encvce10
quietly count if strlen(raw_encvce10)>7
if r(N)==0 recast str7 raw_encvce10
confirm variable raw_eluliu10
quietly count if strlen(raw_eluliu10)>6
if r(N)==0 recast str6 raw_eluliu10
confirm variable raw_eluvcu10
quietly count if strlen(raw_eluvcu10)>7
if r(N)==0 recast str7 raw_eluvcu10
confirm variable raw_elulie10
quietly count if strlen(raw_elulie10)>6
if r(N)==0 recast str6 raw_elulie10
confirm variable raw_eluvce10
quietly count if strlen(raw_eluvce10)>7
if r(N)==0 recast str7 raw_eluvce10
confirm variable raw_efuvcu10
quietly count if strlen(raw_efuvcu10)>9
if r(N)==0 recast str9 raw_efuvcu10
confirm variable raw_efuvce10
quietly count if strlen(raw_efuvce10)>9
if r(N)==0 recast str9 raw_efuvce10
confirm variable raw_mgenou10
quietly count if strlen(raw_mgenou10)>5
if r(N)==0 recast str5 raw_mgenou10
confirm variable raw_mgekwu10
quietly count if strlen(raw_mgekwu10)>7
if r(N)==0 recast str7 raw_mgekwu10
confirm variable raw_eplkhu10
quietly count if strlen(raw_eplkhu10)>9
if r(N)==0 recast str9 raw_eplkhu10
confirm variable raw_eplvcu10
quietly count if strlen(raw_eplvcu10)>9
if r(N)==0 recast str9 raw_eplvcu10
confirm variable raw_enpkhu10
quietly count if strlen(raw_enpkhu10)>8
if r(N)==0 recast str8 raw_enpkhu10
confirm variable raw_enpvcu10
quietly count if strlen(raw_enpvcu10)>8
if r(N)==0 recast str8 raw_enpvcu10
confirm variable raw_esgkhu10
quietly count if strlen(raw_esgkhu10)>9
if r(N)==0 recast str9 raw_esgkhu10
confirm variable raw_oelkhu10
quietly count if strlen(raw_oelkhu10)>7
if r(N)==0 recast str7 raw_oelkhu10
confirm variable raw_yelvcu10
quietly count if strlen(raw_yelvcu10)>8
if r(N)==0 recast str8 raw_yelvcu10
confirm variable raw_ibrvcu10
quietly count if strlen(raw_ibrvcu10)>9
if r(N)==0 recast str9 raw_ibrvcu10
confirm variable raw_ilrvcu10
quietly count if strlen(raw_ilrvcu10)>8
if r(N)==0 recast str8 raw_ilrvcu10
confirm variable raw_itxvcu10
quietly count if strlen(raw_itxvcu10)>10
if r(N)==0 recast str10 raw_itxvcu10
confirm variable raw_iisvcu10
quietly count if strlen(raw_iisvcu10)>9
if r(N)==0 recast str9 raw_iisvcu10
confirm variable raw_iinvcu10
quietly count if strlen(raw_iinvcu10)>9
if r(N)==0 recast str9 raw_iinvcu10
confirm variable raw_icovcu10
quietly count if strlen(raw_icovcu10)>9
if r(N)==0 recast str9 raw_icovcu10
confirm variable raw_irrvcu10
quietly count if strlen(raw_irrvcu10)>8
if r(N)==0 recast str8 raw_irrvcu10
confirm variable raw_iotvcu10
quietly count if strlen(raw_iotvcu10)>9
if r(N)==0 recast str9 raw_iotvcu10
confirm variable raw_it1vcu10
quietly count if strlen(raw_it1vcu10)>10
if r(N)==0 recast str10 raw_it1vcu10
confirm variable raw_rdnvcu10
quietly count if strlen(raw_rdnvcu10)>11
if r(N)==0 recast str11 raw_rdnvcu10
confirm variable raw_rimvcu10
quietly count if strlen(raw_rimvcu10)>11
if r(N)==0 recast str11 raw_rimvcu10
confirm variable raw_rtlvcu10
quietly count if strlen(raw_rtlvcu10)>11
if r(N)==0 recast str11 raw_rtlvcu10
confirm variable raw_ekspor10
quietly count if strlen(raw_ekspor10)>1
if r(N)==0 recast str1 raw_ekspor10
confirm variable raw_yprvcu10
quietly count if strlen(raw_yprvcu10)>11
if r(N)==0 recast str11 raw_yprvcu10
confirm variable raw_prprca10
quietly count if strlen(raw_prprca10)>17
if r(N)==0 recast str17 raw_prprca10
confirm variable raw_yisvcu10
quietly count if strlen(raw_yisvcu10)>9
if r(N)==0 recast str9 raw_yisvcu10
confirm variable raw_yrnvcu10
quietly count if strlen(raw_yrnvcu10)>9
if r(N)==0 recast str9 raw_yrnvcu10
confirm variable raw_yt1vcu10
quietly count if strlen(raw_yt1vcu10)>9
if r(N)==0 recast str9 raw_yt1vcu10
confirm variable raw_srjvcu10
quietly count if strlen(raw_srjvcu10)>10
if r(N)==0 recast str10 raw_srjvcu10
confirm variable raw_srdvcu10
quietly count if strlen(raw_srdvcu10)>10
if r(N)==0 recast str10 raw_srdvcu10
confirm variable raw_srmvcu10
quietly count if strlen(raw_srmvcu10)>10
if r(N)==0 recast str10 raw_srmvcu10
confirm variable raw_shjvcu10
quietly count if strlen(raw_shjvcu10)>10
if r(N)==0 recast str10 raw_shjvcu10
confirm variable raw_shdvcu10
quietly count if strlen(raw_shdvcu10)>10
if r(N)==0 recast str10 raw_shdvcu10
confirm variable raw_shfvcu10
quietly count if strlen(raw_shfvcu10)>10
if r(N)==0 recast str10 raw_shfvcu10
confirm variable raw_sfjvcu10
quietly count if strlen(raw_sfjvcu10)>10
if r(N)==0 recast str10 raw_sfjvcu10
confirm variable raw_sfdvcu10
quietly count if strlen(raw_sfdvcu10)>10
if r(N)==0 recast str10 raw_sfdvcu10
confirm variable raw_sfnvcu10
quietly count if strlen(raw_sfnvcu10)>10
if r(N)==0 recast str10 raw_sfnvcu10
confirm variable raw_stjvcu10
quietly count if strlen(raw_stjvcu10)>10
if r(N)==0 recast str10 raw_stjvcu10
confirm variable raw_stdvcu10
quietly count if strlen(raw_stdvcu10)>10
if r(N)==0 recast str10 raw_stdvcu10
confirm variable raw_stlvcu10
quietly count if strlen(raw_stlvcu10)>11
if r(N)==0 recast str11 raw_stlvcu10
confirm variable raw_clttcu10
quietly count if strlen(raw_clttcu10)>8
if r(N)==0 recast str8 raw_clttcu10
confirm variable raw_clsacu10
quietly count if strlen(raw_clsacu10)>7
if r(N)==0 recast str7 raw_clsacu10
confirm variable raw_cldacu10
quietly count if strlen(raw_cldacu10)>7
if r(N)==0 recast str7 raw_cldacu10
confirm variable raw_v1101
quietly count if strlen(raw_v1101)>12
if r(N)==0 recast str12 raw_v1101
confirm variable raw_cbttcu10
quietly count if strlen(raw_cbttcu10)>9
if r(N)==0 recast str9 raw_cbttcu10
confirm variable raw_cbsacu10
quietly count if strlen(raw_cbsacu10)>8
if r(N)==0 recast str8 raw_cbsacu10
confirm variable raw_cbdacu10
quietly count if strlen(raw_cbdacu10)>10
if r(N)==0 recast str10 raw_cbdacu10
confirm variable raw_v1103
quietly count if strlen(raw_v1103)>12
if r(N)==0 recast str12 raw_v1103
confirm variable raw_cmttcu10
quietly count if strlen(raw_cmttcu10)>10
if r(N)==0 recast str10 raw_cmttcu10
confirm variable raw_cmsacu10
quietly count if strlen(raw_cmsacu10)>9
if r(N)==0 recast str9 raw_cmsacu10
confirm variable raw_cmdacu10
quietly count if strlen(raw_cmdacu10)>10
if r(N)==0 recast str10 raw_cmdacu10
confirm variable raw_v1106
quietly count if strlen(raw_v1106)>12
if r(N)==0 recast str12 raw_v1106
confirm variable raw_cvttcu10
quietly count if strlen(raw_cvttcu10)>9
if r(N)==0 recast str9 raw_cvttcu10
confirm variable raw_cvsacu10
quietly count if strlen(raw_cvsacu10)>7
if r(N)==0 recast str7 raw_cvsacu10
confirm variable raw_cvdacu10
quietly count if strlen(raw_cvdacu10)>9
if r(N)==0 recast str9 raw_cvdacu10
confirm variable raw_v1109
quietly count if strlen(raw_v1109)>11
if r(N)==0 recast str11 raw_v1109
confirm variable raw_cottcu10
quietly count if strlen(raw_cottcu10)>9
if r(N)==0 recast str9 raw_cottcu10
confirm variable raw_cosacu10
quietly count if strlen(raw_cosacu10)>8
if r(N)==0 recast str8 raw_cosacu10
confirm variable raw_codacu10
quietly count if strlen(raw_codacu10)>8
if r(N)==0 recast str8 raw_codacu10
confirm variable raw_v1112
quietly count if strlen(raw_v1112)>11
if r(N)==0 recast str11 raw_v1112
confirm variable raw_ctttcu10
quietly count if strlen(raw_ctttcu10)>10
if r(N)==0 recast str10 raw_ctttcu10
confirm variable raw_ctsacu10
quietly count if strlen(raw_ctsacu10)>9
if r(N)==0 recast str9 raw_ctsacu10
confirm variable raw_ctdacu10
quietly count if strlen(raw_ctdacu10)>10
if r(N)==0 recast str10 raw_ctdacu10
confirm variable raw_v1115
quietly count if strlen(raw_v1115)>12
if r(N)==0 recast str12 raw_v1115
confirm variable raw_iinput10
quietly count if strlen(raw_iinput10)>11
if r(N)==0 recast str11 raw_iinput10
confirm variable raw_output10
quietly count if strlen(raw_output10)>11
if r(N)==0 recast str11 raw_output10
confirm variable raw_vtlvcu10
quietly count if strlen(raw_vtlvcu10)>11
if r(N)==0 recast str11 raw_vtlvcu10
confirm variable raw_userid
quietly count if strlen(raw_userid)>2
if r(N)==0 recast str2 raw_userid
confirm variable raw_klpdos1
quietly count if strlen(raw_klpdos1)>2
if r(N)==0 recast str2 raw_klpdos1
confirm variable raw_ltmnou10
quietly count if strlen(raw_ltmnou10)>4
if r(N)==0 recast str4 raw_ltmnou10
confirm variable raw_ltwnou10
quietly count if strlen(raw_ltwnou10)>5
if r(N)==0 recast str5 raw_ltwnou10
confirm variable raw_ltlnou10
quietly count if strlen(raw_ltlnou10)>5
if r(N)==0 recast str5 raw_ltlnou10
confirm variable raw_dkabup10
quietly count if strlen(raw_dkabup10)>3
if r(N)==0 recast str3 raw_dkabup10
confirm variable raw_dkecam10
quietly count if strlen(raw_dkecam10)>3
if r(N)==0 recast str3 raw_dkecam10
confirm variable raw_ddesa10
quietly count if strlen(raw_ddesa10)>3
if r(N)==0 recast str3 raw_ddesa10
confirm variable raw_flages
quietly count if strlen(raw_flages)>2
if r(N)==0 recast str2 raw_flages
confirm variable raw_flg10
quietly count if strlen(raw_flg10)>1
if r(N)==0 recast str1 raw_flg10
confirm variable raw_kipn
quietly count if strlen(raw_kipn)>3
if r(N)==0 recast str3 raw_kipn
confirm variable raw_kbli05
quietly count if strlen(raw_kbli05)>5
if r(N)==0 recast str5 raw_kbli05
confirm variable raw_prprex10
quietly count if strlen(raw_prprex10)>5
if r(N)==0 recast str5 raw_prprex10
confirm variable raw_dsrvyr10
quietly count if strlen(raw_dsrvyr10)>4
if r(N)==0 recast str4 raw_dsrvyr10
confirm variable raw_jan11
quietly count if strlen(raw_jan11)>1
if r(N)==0 recast str1 raw_jan11
confirm variable raw_feb11
quietly count if strlen(raw_feb11)>1
if r(N)==0 recast str1 raw_feb11
confirm variable raw_mar11
quietly count if strlen(raw_mar11)>1
if r(N)==0 recast str1 raw_mar11
confirm variable raw_apr11
quietly count if strlen(raw_apr11)>1
if r(N)==0 recast str1 raw_apr11
confirm variable raw_mei11
quietly count if strlen(raw_mei11)>1
if r(N)==0 recast str1 raw_mei11
confirm variable raw_jun11
quietly count if strlen(raw_jun11)>1
if r(N)==0 recast str1 raw_jun11
confirm variable raw_jul11
quietly count if strlen(raw_jul11)>1
if r(N)==0 recast str1 raw_jul11
confirm variable raw_agt11
quietly count if strlen(raw_agt11)>1
if r(N)==0 recast str1 raw_agt11
confirm variable raw_sep11
quietly count if strlen(raw_sep11)>1
if r(N)==0 recast str1 raw_sep11
confirm variable raw_okt11
quietly count if strlen(raw_okt11)>1
if r(N)==0 recast str1 raw_okt11
confirm variable raw_nov11
quietly count if strlen(raw_nov11)>1
if r(N)==0 recast str1 raw_nov11
confirm variable raw_des11
quietly count if strlen(raw_des11)>1
if r(N)==0 recast str1 raw_des11
confirm variable raw_year11
quietly count if strlen(raw_year11)>2
if r(N)==0 recast str2 raw_year11
confirm variable raw_dprovi11
quietly count if strlen(raw_dprovi11)>2
if r(N)==0 recast str2 raw_dprovi11
confirm variable raw_dklui11
quietly count if strlen(raw_dklui11)>3
if r(N)==0 recast str3 raw_dklui11
confirm variable raw_dseqno11
quietly count if strlen(raw_dseqno11)>4
if r(N)==0 recast str4 raw_dseqno11
confirm variable raw_mainpr11
quietly count if strlen(raw_mainpr11)>40
if r(N)==0 recast str40 raw_mainpr11
confirm variable raw_disic511
quietly count if strlen(raw_disic511)>5
if r(N)==0 recast str5 raw_disic511
confirm variable raw_dpusat11
quietly count if strlen(raw_dpusat11)>3
if r(N)==0 recast str3 raw_dpusat11
confirm variable raw_dpemda11
quietly count if strlen(raw_dpemda11)>12
if r(N)==0 recast str12 raw_dpemda11
confirm variable raw_ddmstk11
quietly count if strlen(raw_ddmstk11)>17
if r(N)==0 recast str17 raw_ddmstk11
confirm variable raw_dasing11
quietly count if strlen(raw_dasing11)>17
if r(N)==0 recast str17 raw_dasing11
confirm variable raw_ceksum11
quietly count if strlen(raw_ceksum11)>9
if r(N)==0 recast str9 raw_ceksum11
confirm variable raw_resech11
quietly count if strlen(raw_resech11)>1
if r(N)==0 recast str1 raw_resech11
confirm variable raw_innova11
quietly count if strlen(raw_innova11)>1
if r(N)==0 recast str1 raw_innova11
confirm variable raw_lpmnou11
quietly count if strlen(raw_lpmnou11)>4
if r(N)==0 recast str4 raw_lpmnou11
confirm variable raw_lnmnou11
quietly count if strlen(raw_lnmnou11)>4
if r(N)==0 recast str4 raw_lnmnou11
confirm variable raw_lfmnou11
quietly count if strlen(raw_lfmnou11)>1
if r(N)==0 recast str1 raw_lfmnou11
confirm variable raw_ltmnou11
quietly count if strlen(raw_ltmnou11)>4
if r(N)==0 recast str4 raw_ltmnou11
confirm variable raw_lpwnou11
quietly count if strlen(raw_lpwnou11)>4
if r(N)==0 recast str4 raw_lpwnou11
confirm variable raw_lnwnou11
quietly count if strlen(raw_lnwnou11)>4
if r(N)==0 recast str4 raw_lnwnou11
confirm variable raw_lfwnou11
quietly count if strlen(raw_lfwnou11)>1
if r(N)==0 recast str1 raw_lfwnou11
confirm variable raw_ltwnou11
quietly count if strlen(raw_ltwnou11)>4
if r(N)==0 recast str4 raw_ltwnou11
confirm variable raw_lprnou11
quietly count if strlen(raw_lprnou11)>5
if r(N)==0 recast str5 raw_lprnou11
confirm variable raw_lnpnou11
quietly count if strlen(raw_lnpnou11)>4
if r(N)==0 recast str4 raw_lnpnou11
confirm variable raw_lfanou11
quietly count if strlen(raw_lfanou11)>1
if r(N)==0 recast str1 raw_lfanou11
confirm variable raw_ltlnou11
quietly count if strlen(raw_ltlnou11)>5
if r(N)==0 recast str5 raw_ltlnou11
confirm variable raw_zpsvcu11
quietly count if strlen(raw_zpsvcu11)>9
if r(N)==0 recast str9 raw_zpsvcu11
confirm variable raw_znsvcu11
quietly count if strlen(raw_znsvcu11)>8
if r(N)==0 recast str8 raw_znsvcu11
confirm variable raw_zpovcu11
quietly count if strlen(raw_zpovcu11)>9
if r(N)==0 recast str9 raw_zpovcu11
confirm variable raw_znovcu11
quietly count if strlen(raw_znovcu11)>8
if r(N)==0 recast str8 raw_znovcu11
confirm variable raw_zpivcu11
quietly count if strlen(raw_zpivcu11)>8
if r(N)==0 recast str8 raw_zpivcu11
confirm variable raw_znivcu11
quietly count if strlen(raw_znivcu11)>7
if r(N)==0 recast str7 raw_znivcu11
confirm variable raw_zppvcu11
quietly count if strlen(raw_zppvcu11)>8
if r(N)==0 recast str8 raw_zppvcu11
confirm variable raw_znpvcu11
quietly count if strlen(raw_znpvcu11)>7
if r(N)==0 recast str7 raw_znpvcu11
confirm variable raw_zpavcu11
quietly count if strlen(raw_zpavcu11)>7
if r(N)==0 recast str7 raw_zpavcu11
confirm variable raw_znavcu11
quietly count if strlen(raw_znavcu11)>6
if r(N)==0 recast str6 raw_znavcu11
confirm variable raw_zpdvcu11
quietly count if strlen(raw_zpdvcu11)>10
if r(N)==0 recast str10 raw_zpdvcu11
confirm variable raw_zndvcu11
quietly count if strlen(raw_zndvcu11)>8
if r(N)==0 recast str8 raw_zndvcu11
confirm variable raw_epeliu11
quietly count if strlen(raw_epeliu11)>7
if r(N)==0 recast str7 raw_epeliu11
confirm variable raw_epevcu11
quietly count if strlen(raw_epevcu11)>8
if r(N)==0 recast str8 raw_epevcu11
confirm variable raw_epelie11
quietly count if strlen(raw_epelie11)>5
if r(N)==0 recast str5 raw_epelie11
confirm variable raw_epevce11
quietly count if strlen(raw_epevce11)>6
if r(N)==0 recast str6 raw_epevce11
confirm variable raw_esoliu11
quietly count if strlen(raw_esoliu11)>8
if r(N)==0 recast str8 raw_esoliu11
confirm variable raw_esovcu11
quietly count if strlen(raw_esovcu11)>9
if r(N)==0 recast str9 raw_esovcu11
confirm variable raw_esolie11
quietly count if strlen(raw_esolie11)>7
if r(N)==0 recast str7 raw_esolie11
confirm variable raw_esovce11
quietly count if strlen(raw_esovce11)>8
if r(N)==0 recast str8 raw_esovce11
confirm variable raw_eoiliu11
quietly count if strlen(raw_eoiliu11)>7
if r(N)==0 recast str7 raw_eoiliu11
confirm variable raw_eoivcu11
quietly count if strlen(raw_eoivcu11)>7
if r(N)==0 recast str7 raw_eoivcu11
confirm variable raw_eoilie11
quietly count if strlen(raw_eoilie11)>4
if r(N)==0 recast str4 raw_eoilie11
confirm variable raw_eoivce11
quietly count if strlen(raw_eoivce11)>5
if r(N)==0 recast str5 raw_eoivce11
confirm variable raw_eclkgu11
quietly count if strlen(raw_eclkgu11)>9
if r(N)==0 recast str9 raw_eclkgu11
confirm variable raw_eclvcu11
quietly count if strlen(raw_eclvcu11)>9
if r(N)==0 recast str9 raw_eclvcu11
confirm variable raw_eclkge11
quietly count if strlen(raw_eclkge11)>7
if r(N)==0 recast str7 raw_eclkge11
confirm variable raw_eclvce11
quietly count if strlen(raw_eclvce11)>7
if r(N)==0 recast str7 raw_eclvce11
confirm variable raw_egam3u11
quietly count if strlen(raw_egam3u11)>7
if r(N)==0 recast str7 raw_egam3u11
confirm variable raw_egavcu11
quietly count if strlen(raw_egavcu11)>8
if r(N)==0 recast str8 raw_egavcu11
confirm variable raw_egam3e11
quietly count if strlen(raw_egam3e11)>6
if r(N)==0 recast str6 raw_egam3e11
confirm variable raw_egavce11
quietly count if strlen(raw_egavce11)>7
if r(N)==0 recast str7 raw_egavce11
confirm variable raw_elpkgu11
quietly count if strlen(raw_elpkgu11)>7
if r(N)==0 recast str7 raw_elpkgu11
confirm variable raw_elpvcu11
quietly count if strlen(raw_elpvcu11)>8
if r(N)==0 recast str8 raw_elpvcu11
confirm variable raw_elpkge11
quietly count if strlen(raw_elpkge11)>5
if r(N)==0 recast str5 raw_elpkge11
confirm variable raw_elpvce11
quietly count if strlen(raw_elpvce11)>5
if r(N)==0 recast str5 raw_elpvce11
confirm variable raw_encvcu11
quietly count if strlen(raw_encvcu11)>9
if r(N)==0 recast str9 raw_encvcu11
confirm variable raw_encvce11
quietly count if strlen(raw_encvce11)>6
if r(N)==0 recast str6 raw_encvce11
confirm variable raw_eluliu11
quietly count if strlen(raw_eluliu11)>7
if r(N)==0 recast str7 raw_eluliu11
confirm variable raw_eluvcu11
quietly count if strlen(raw_eluvcu11)>8
if r(N)==0 recast str8 raw_eluvcu11
confirm variable raw_elulie11
quietly count if strlen(raw_elulie11)>5
if r(N)==0 recast str5 raw_elulie11
confirm variable raw_eluvce11
quietly count if strlen(raw_eluvce11)>7
if r(N)==0 recast str7 raw_eluvce11
confirm variable raw_efuvcu11
quietly count if strlen(raw_efuvcu11)>9
if r(N)==0 recast str9 raw_efuvcu11
confirm variable raw_efuvce11
quietly count if strlen(raw_efuvce11)>8
if r(N)==0 recast str8 raw_efuvce11
confirm variable raw_mgenou11
quietly count if strlen(raw_mgenou11)>7
if r(N)==0 recast str7 raw_mgenou11
confirm variable raw_mgekwu11
quietly count if strlen(raw_mgekwu11)>7
if r(N)==0 recast str7 raw_mgekwu11
confirm variable raw_eplkhu11
quietly count if strlen(raw_eplkhu11)>9
if r(N)==0 recast str9 raw_eplkhu11
confirm variable raw_eplvcu11
quietly count if strlen(raw_eplvcu11)>9
if r(N)==0 recast str9 raw_eplvcu11
confirm variable raw_enpkhu11
quietly count if strlen(raw_enpkhu11)>8
if r(N)==0 recast str8 raw_enpkhu11
confirm variable raw_enpvcu11
quietly count if strlen(raw_enpvcu11)>8
if r(N)==0 recast str8 raw_enpvcu11
confirm variable raw_esgkhu11
quietly count if strlen(raw_esgkhu11)>8
if r(N)==0 recast str8 raw_esgkhu11
confirm variable raw_oelkhu11
quietly count if strlen(raw_oelkhu11)>6
if r(N)==0 recast str6 raw_oelkhu11
confirm variable raw_yelvcu11
quietly count if strlen(raw_yelvcu11)>6
if r(N)==0 recast str6 raw_yelvcu11
confirm variable raw_ibrvcu11
quietly count if strlen(raw_ibrvcu11)>9
if r(N)==0 recast str9 raw_ibrvcu11
confirm variable raw_ilrvcu11
quietly count if strlen(raw_ilrvcu11)>8
if r(N)==0 recast str8 raw_ilrvcu11
confirm variable raw_itxvcu11
quietly count if strlen(raw_itxvcu11)>9
if r(N)==0 recast str9 raw_itxvcu11
confirm variable raw_iisvcu11
quietly count if strlen(raw_iisvcu11)>9
if r(N)==0 recast str9 raw_iisvcu11
confirm variable raw_iinvcu11
quietly count if strlen(raw_iinvcu11)>8
if r(N)==0 recast str8 raw_iinvcu11
confirm variable raw_icovcu11
quietly count if strlen(raw_icovcu11)>8
if r(N)==0 recast str8 raw_icovcu11
confirm variable raw_irrvcu11
quietly count if strlen(raw_irrvcu11)>8
if r(N)==0 recast str8 raw_irrvcu11
confirm variable raw_iotvcu11
quietly count if strlen(raw_iotvcu11)>9
if r(N)==0 recast str9 raw_iotvcu11
confirm variable raw_it1vcu11
quietly count if strlen(raw_it1vcu11)>9
if r(N)==0 recast str9 raw_it1vcu11
confirm variable raw_rdnvcu11
quietly count if strlen(raw_rdnvcu11)>10
if r(N)==0 recast str10 raw_rdnvcu11
confirm variable raw_rimvcu11
quietly count if strlen(raw_rimvcu11)>11
if r(N)==0 recast str11 raw_rimvcu11
confirm variable raw_rtlvcu11
quietly count if strlen(raw_rtlvcu11)>11
if r(N)==0 recast str11 raw_rtlvcu11
confirm variable raw_ekspor11
quietly count if strlen(raw_ekspor11)>1
if r(N)==0 recast str1 raw_ekspor11
confirm variable raw_yprvcu11
quietly count if strlen(raw_yprvcu11)>11
if r(N)==0 recast str11 raw_yprvcu11
confirm variable raw_prprca11
quietly count if strlen(raw_prprca11)>17
if r(N)==0 recast str17 raw_prprca11
confirm variable raw_yisvcu11
quietly count if strlen(raw_yisvcu11)>10
if r(N)==0 recast str10 raw_yisvcu11
confirm variable raw_yrnvcu11
quietly count if strlen(raw_yrnvcu11)>10
if r(N)==0 recast str10 raw_yrnvcu11
confirm variable raw_yt1vcu11
quietly count if strlen(raw_yt1vcu11)>10
if r(N)==0 recast str10 raw_yt1vcu11
confirm variable raw_srjvcu11
quietly count if strlen(raw_srjvcu11)>10
if r(N)==0 recast str10 raw_srjvcu11
confirm variable raw_srdvcu11
quietly count if strlen(raw_srdvcu11)>10
if r(N)==0 recast str10 raw_srdvcu11
confirm variable raw_srmvcu11
quietly count if strlen(raw_srmvcu11)>10
if r(N)==0 recast str10 raw_srmvcu11
confirm variable raw_shjvcu11
quietly count if strlen(raw_shjvcu11)>10
if r(N)==0 recast str10 raw_shjvcu11
confirm variable raw_shdvcu11
quietly count if strlen(raw_shdvcu11)>10
if r(N)==0 recast str10 raw_shdvcu11
confirm variable raw_shfvcu11
quietly count if strlen(raw_shfvcu11)>10
if r(N)==0 recast str10 raw_shfvcu11
confirm variable raw_sfjvcu11
quietly count if strlen(raw_sfjvcu11)>10
if r(N)==0 recast str10 raw_sfjvcu11
confirm variable raw_sfdvcu11
quietly count if strlen(raw_sfdvcu11)>10
if r(N)==0 recast str10 raw_sfdvcu11
confirm variable raw_sfnvcu11
quietly count if strlen(raw_sfnvcu11)>10
if r(N)==0 recast str10 raw_sfnvcu11
confirm variable raw_stjvcu11
quietly count if strlen(raw_stjvcu11)>10
if r(N)==0 recast str10 raw_stjvcu11
confirm variable raw_stdvcu11
quietly count if strlen(raw_stdvcu11)>10
if r(N)==0 recast str10 raw_stdvcu11
confirm variable raw_stlvcu11
quietly count if strlen(raw_stlvcu11)>10
if r(N)==0 recast str10 raw_stlvcu11
confirm variable raw_clttcu11
quietly count if strlen(raw_clttcu11)>10
if r(N)==0 recast str10 raw_clttcu11
confirm variable raw_clsacu11
quietly count if strlen(raw_clsacu11)>7
if r(N)==0 recast str7 raw_clsacu11
confirm variable raw_cldacu11
quietly count if strlen(raw_cldacu11)>8
if r(N)==0 recast str8 raw_cldacu11
confirm variable raw_cbttcu11
quietly count if strlen(raw_cbttcu11)>10
if r(N)==0 recast str10 raw_cbttcu11
confirm variable raw_cbsacu11
quietly count if strlen(raw_cbsacu11)>7
if r(N)==0 recast str7 raw_cbsacu11
confirm variable raw_cbdacu11
quietly count if strlen(raw_cbdacu11)>9
if r(N)==0 recast str9 raw_cbdacu11
confirm variable raw_cmttcu11
quietly count if strlen(raw_cmttcu11)>10
if r(N)==0 recast str10 raw_cmttcu11
confirm variable raw_cmsacu11
quietly count if strlen(raw_cmsacu11)>8
if r(N)==0 recast str8 raw_cmsacu11
confirm variable raw_cmdacu11
quietly count if strlen(raw_cmdacu11)>10
if r(N)==0 recast str10 raw_cmdacu11
confirm variable raw_cvttcu11
quietly count if strlen(raw_cvttcu11)>9
if r(N)==0 recast str9 raw_cvttcu11
confirm variable raw_cvsacu11
quietly count if strlen(raw_cvsacu11)>9
if r(N)==0 recast str9 raw_cvsacu11
confirm variable raw_cvdacu11
quietly count if strlen(raw_cvdacu11)>8
if r(N)==0 recast str8 raw_cvdacu11
confirm variable raw_cottcu11
quietly count if strlen(raw_cottcu11)>9
if r(N)==0 recast str9 raw_cottcu11
confirm variable raw_cosacu11
quietly count if strlen(raw_cosacu11)>9
if r(N)==0 recast str9 raw_cosacu11
confirm variable raw_codacu11
quietly count if strlen(raw_codacu11)>9
if r(N)==0 recast str9 raw_codacu11
confirm variable raw_ctttcu11
quietly count if strlen(raw_ctttcu11)>10
if r(N)==0 recast str10 raw_ctttcu11
confirm variable raw_ctsacu11
quietly count if strlen(raw_ctsacu11)>9
if r(N)==0 recast str9 raw_ctsacu11
confirm variable raw_ctdacu11
quietly count if strlen(raw_ctdacu11)>10
if r(N)==0 recast str10 raw_ctdacu11
confirm variable raw_vtlvcu11
quietly count if strlen(raw_vtlvcu11)>10
if r(N)==0 recast str10 raw_vtlvcu11
confirm variable raw_laki11
quietly count if strlen(raw_laki11)>4
if r(N)==0 recast str4 raw_laki11
confirm variable raw_perem11
quietly count if strlen(raw_perem11)>4
if r(N)==0 recast str4 raw_perem11
confirm variable raw_tottk11
quietly count if strlen(raw_tottk11)>5
if r(N)==0 recast str5 raw_tottk11
confirm variable raw_dstats11
quietly count if strlen(raw_dstats11)>1
if r(N)==0 recast str1 raw_dstats11
confirm variable raw_locati11
quietly count if strlen(raw_locati11)>1
if r(N)==0 recast str1 raw_locati11
confirm variable raw_v0408j
quietly count if strlen(raw_v0408j)>10
if r(N)==0 recast str10 raw_v0408j
confirm variable raw_iinput11
quietly count if strlen(raw_iinput11)>11
if r(N)==0 recast str11 raw_iinput11
confirm variable raw_output11
quietly count if strlen(raw_output11)>11
if r(N)==0 recast str11 raw_output11
confirm variable raw_dkabup11
quietly count if strlen(raw_dkabup11)>3
if r(N)==0 recast str3 raw_dkabup11
confirm variable raw_dkecam11
quietly count if strlen(raw_dkecam11)>3
if r(N)==0 recast str3 raw_dkecam11
confirm variable raw_ddesa11
quietly count if strlen(raw_ddesa11)>3
if r(N)==0 recast str3 raw_ddesa11
confirm variable raw_ags11
quietly count if strlen(raw_ags11)>1
if r(N)==0 recast str1 raw_ags11
confirm variable raw_nop11
quietly count if strlen(raw_nop11)>1
if r(N)==0 recast str1 raw_nop11
confirm variable raw_prprex11
quietly count if strlen(raw_prprex11)>17
if r(N)==0 recast str17 raw_prprex11
confirm variable raw_kbli2
quietly count if strlen(raw_kbli2)>2
if r(N)==0 recast str2 raw_kbli2
confirm variable raw_jan12
quietly count if strlen(raw_jan12)>1
if r(N)==0 recast str1 raw_jan12
confirm variable raw_feb12
quietly count if strlen(raw_feb12)>1
if r(N)==0 recast str1 raw_feb12
confirm variable raw_mar12
quietly count if strlen(raw_mar12)>1
if r(N)==0 recast str1 raw_mar12
confirm variable raw_apr12
quietly count if strlen(raw_apr12)>1
if r(N)==0 recast str1 raw_apr12
confirm variable raw_mei12
quietly count if strlen(raw_mei12)>1
if r(N)==0 recast str1 raw_mei12
confirm variable raw_jun12
quietly count if strlen(raw_jun12)>1
if r(N)==0 recast str1 raw_jun12
confirm variable raw_jul12
quietly count if strlen(raw_jul12)>1
if r(N)==0 recast str1 raw_jul12
confirm variable raw_ags12
quietly count if strlen(raw_ags12)>1
if r(N)==0 recast str1 raw_ags12
confirm variable raw_sep12
quietly count if strlen(raw_sep12)>1
if r(N)==0 recast str1 raw_sep12
confirm variable raw_okt12
quietly count if strlen(raw_okt12)>1
if r(N)==0 recast str1 raw_okt12
confirm variable raw_nov12
quietly count if strlen(raw_nov12)>1
if r(N)==0 recast str1 raw_nov12
confirm variable raw_des12
quietly count if strlen(raw_des12)>1
if r(N)==0 recast str1 raw_des12
confirm variable raw_year12
quietly count if strlen(raw_year12)>2
if r(N)==0 recast str2 raw_year12
confirm variable raw_egam3u12
quietly count if strlen(raw_egam3u12)>7
if r(N)==0 recast str7 raw_egam3u12
confirm variable raw_egavcu12
quietly count if strlen(raw_egavcu12)>8
if r(N)==0 recast str8 raw_egavcu12
confirm variable raw_egam3e12
quietly count if strlen(raw_egam3e12)>4
if r(N)==0 recast str4 raw_egam3e12
confirm variable raw_egavce12
quietly count if strlen(raw_egavce12)>5
if r(N)==0 recast str5 raw_egavce12
confirm variable raw_dprovi12
quietly count if strlen(raw_dprovi12)>2
if r(N)==0 recast str2 raw_dprovi12
confirm variable raw_dklui12
quietly count if strlen(raw_dklui12)>3
if r(N)==0 recast str3 raw_dklui12
confirm variable raw_dseqno12
quietly count if strlen(raw_dseqno12)>4
if r(N)==0 recast str4 raw_dseqno12
confirm variable raw_iinput12
quietly count if strlen(raw_iinput12)>10
if r(N)==0 recast str10 raw_iinput12
confirm variable raw_output12
quietly count if strlen(raw_output12)>10
if r(N)==0 recast str10 raw_output12
confirm variable raw_disic512
quietly count if strlen(raw_disic512)>5
if r(N)==0 recast str5 raw_disic512
confirm variable raw_mainpr12
quietly count if strlen(raw_mainpr12)>40
if r(N)==0 recast str40 raw_mainpr12
confirm variable raw_dpusat12
quietly count if strlen(raw_dpusat12)>3
if r(N)==0 recast str3 raw_dpusat12
confirm variable raw_dpemda12
quietly count if strlen(raw_dpemda12)>3
if r(N)==0 recast str3 raw_dpemda12
confirm variable raw_ddmstk12
quietly count if strlen(raw_ddmstk12)>5
if r(N)==0 recast str5 raw_ddmstk12
confirm variable raw_dasing12
quietly count if strlen(raw_dasing12)>17
if r(N)==0 recast str17 raw_dasing12
confirm variable raw_ceksum12
quietly count if strlen(raw_ceksum12)>9
if r(N)==0 recast str9 raw_ceksum12
confirm variable raw_lpmnou12
quietly count if strlen(raw_lpmnou12)>5
if r(N)==0 recast str5 raw_lpmnou12
confirm variable raw_lpwnou12
quietly count if strlen(raw_lpwnou12)>4
if r(N)==0 recast str4 raw_lpwnou12
confirm variable raw_lprnou12
quietly count if strlen(raw_lprnou12)>5
if r(N)==0 recast str5 raw_lprnou12
confirm variable raw_lnmnou12
quietly count if strlen(raw_lnmnou12)>4
if r(N)==0 recast str4 raw_lnmnou12
confirm variable raw_lnwnou12
quietly count if strlen(raw_lnwnou12)>3
if r(N)==0 recast str3 raw_lnwnou12
confirm variable raw_lnpnou12
quietly count if strlen(raw_lnpnou12)>4
if r(N)==0 recast str4 raw_lnpnou12
confirm variable raw_zpsvcu12
quietly count if strlen(raw_zpsvcu12)>9
if r(N)==0 recast str9 raw_zpsvcu12
confirm variable raw_zpovcu12
quietly count if strlen(raw_zpovcu12)>9
if r(N)==0 recast str9 raw_zpovcu12
confirm variable raw_zpivcu12
quietly count if strlen(raw_zpivcu12)>8
if r(N)==0 recast str8 raw_zpivcu12
confirm variable raw_zppvcu12
quietly count if strlen(raw_zppvcu12)>8
if r(N)==0 recast str8 raw_zppvcu12
confirm variable raw_zpavcu12
quietly count if strlen(raw_zpavcu12)>7
if r(N)==0 recast str7 raw_zpavcu12
confirm variable raw_zpdvcu12
quietly count if strlen(raw_zpdvcu12)>9
if r(N)==0 recast str9 raw_zpdvcu12
confirm variable raw_znsvcu12
quietly count if strlen(raw_znsvcu12)>9
if r(N)==0 recast str9 raw_znsvcu12
confirm variable raw_znovcu12
quietly count if strlen(raw_znovcu12)>8
if r(N)==0 recast str8 raw_znovcu12
confirm variable raw_znivcu12
quietly count if strlen(raw_znivcu12)>7
if r(N)==0 recast str7 raw_znivcu12
confirm variable raw_znpvcu12
quietly count if strlen(raw_znpvcu12)>8
if r(N)==0 recast str8 raw_znpvcu12
confirm variable raw_znavcu12
quietly count if strlen(raw_znavcu12)>6
if r(N)==0 recast str6 raw_znavcu12
confirm variable raw_zndvcu12
quietly count if strlen(raw_zndvcu12)>9
if r(N)==0 recast str9 raw_zndvcu12
confirm variable raw_epeliu12
quietly count if strlen(raw_epeliu12)>8
if r(N)==0 recast str8 raw_epeliu12
confirm variable raw_epevcu12
quietly count if strlen(raw_epevcu12)>9
if r(N)==0 recast str9 raw_epevcu12
confirm variable raw_epelie12
quietly count if strlen(raw_epelie12)>6
if r(N)==0 recast str6 raw_epelie12
confirm variable raw_epevce12
quietly count if strlen(raw_epevce12)>7
if r(N)==0 recast str7 raw_epevce12
confirm variable raw_esoliu12
quietly count if strlen(raw_esoliu12)>8
if r(N)==0 recast str8 raw_esoliu12
confirm variable raw_esovcu12
quietly count if strlen(raw_esovcu12)>9
if r(N)==0 recast str9 raw_esovcu12
confirm variable raw_esolie12
quietly count if strlen(raw_esolie12)>8
if r(N)==0 recast str8 raw_esolie12
confirm variable raw_esovce12
quietly count if strlen(raw_esovce12)>9
if r(N)==0 recast str9 raw_esovce12
confirm variable raw_eoiliu12
quietly count if strlen(raw_eoiliu12)>7
if r(N)==0 recast str7 raw_eoiliu12
confirm variable raw_eoivcu12
quietly count if strlen(raw_eoivcu12)>8
if r(N)==0 recast str8 raw_eoivcu12
confirm variable raw_eoilie12
quietly count if strlen(raw_eoilie12)>7
if r(N)==0 recast str7 raw_eoilie12
confirm variable raw_eoivce12
quietly count if strlen(raw_eoivce12)>8
if r(N)==0 recast str8 raw_eoivce12
confirm variable raw_eclkgu12
quietly count if strlen(raw_eclkgu12)>9
if r(N)==0 recast str9 raw_eclkgu12
confirm variable raw_eclvcu12
quietly count if strlen(raw_eclvcu12)>9
if r(N)==0 recast str9 raw_eclvcu12
confirm variable raw_eclkge12
quietly count if strlen(raw_eclkge12)>8
if r(N)==0 recast str8 raw_eclkge12
confirm variable raw_eclvce12
quietly count if strlen(raw_eclvce12)>8
if r(N)==0 recast str8 raw_eclvce12
confirm variable raw_elpkgu12
quietly count if strlen(raw_elpkgu12)>7
if r(N)==0 recast str7 raw_elpkgu12
confirm variable raw_elpvcu12
quietly count if strlen(raw_elpvcu12)>8
if r(N)==0 recast str8 raw_elpvcu12
confirm variable raw_elpkge12
quietly count if strlen(raw_elpkge12)>5
if r(N)==0 recast str5 raw_elpkge12
confirm variable raw_elpvce12
quietly count if strlen(raw_elpvce12)>6
if r(N)==0 recast str6 raw_elpvce12
confirm variable raw_encvcu12
quietly count if strlen(raw_encvcu12)>9
if r(N)==0 recast str9 raw_encvcu12
confirm variable raw_encvce12
quietly count if strlen(raw_encvce12)>7
if r(N)==0 recast str7 raw_encvce12
confirm variable raw_eluliu12
quietly count if strlen(raw_eluliu12)>6
if r(N)==0 recast str6 raw_eluliu12
confirm variable raw_eluvcu12
quietly count if strlen(raw_eluvcu12)>8
if r(N)==0 recast str8 raw_eluvcu12
confirm variable raw_elulie12
quietly count if strlen(raw_elulie12)>6
if r(N)==0 recast str6 raw_elulie12
confirm variable raw_eluvce12
quietly count if strlen(raw_eluvce12)>8
if r(N)==0 recast str8 raw_eluvce12
confirm variable raw_efuvcu12
quietly count if strlen(raw_efuvcu12)>9
if r(N)==0 recast str9 raw_efuvcu12
confirm variable raw_efuvce12
quietly count if strlen(raw_efuvce12)>9
if r(N)==0 recast str9 raw_efuvce12
confirm variable raw_mgenou12
quietly count if strlen(raw_mgenou12)>8
if r(N)==0 recast str8 raw_mgenou12
confirm variable raw_mgekwu12
quietly count if strlen(raw_mgekwu12)>9
if r(N)==0 recast str9 raw_mgekwu12
confirm variable raw_eplkhu12
quietly count if strlen(raw_eplkhu12)>8
if r(N)==0 recast str8 raw_eplkhu12
confirm variable raw_eplvcu12
quietly count if strlen(raw_eplvcu12)>9
if r(N)==0 recast str9 raw_eplvcu12
confirm variable raw_enpkhu12
quietly count if strlen(raw_enpkhu12)>8
if r(N)==0 recast str8 raw_enpkhu12
confirm variable raw_enpvcu12
quietly count if strlen(raw_enpvcu12)>9
if r(N)==0 recast str9 raw_enpvcu12
confirm variable raw_esgkhu12
quietly count if strlen(raw_esgkhu12)>9
if r(N)==0 recast str9 raw_esgkhu12
confirm variable raw_oelkhu12
quietly count if strlen(raw_oelkhu12)>6
if r(N)==0 recast str6 raw_oelkhu12
confirm variable raw_yelvcu12
quietly count if strlen(raw_yelvcu12)>7
if r(N)==0 recast str7 raw_yelvcu12
confirm variable raw_ibrvcu12
quietly count if strlen(raw_ibrvcu12)>10
if r(N)==0 recast str10 raw_ibrvcu12
confirm variable raw_ilrvcu12
quietly count if strlen(raw_ilrvcu12)>7
if r(N)==0 recast str7 raw_ilrvcu12
confirm variable raw_itxvcu12
quietly count if strlen(raw_itxvcu12)>9
if r(N)==0 recast str9 raw_itxvcu12
confirm variable raw_iisvcu12
quietly count if strlen(raw_iisvcu12)>9
if r(N)==0 recast str9 raw_iisvcu12
confirm variable raw_iinvcu12
quietly count if strlen(raw_iinvcu12)>9
if r(N)==0 recast str9 raw_iinvcu12
confirm variable raw_icovcu12
quietly count if strlen(raw_icovcu12)>8
if r(N)==0 recast str8 raw_icovcu12
confirm variable raw_iotvcu12
quietly count if strlen(raw_iotvcu12)>9
if r(N)==0 recast str9 raw_iotvcu12
confirm variable raw_it1vcu12
quietly count if strlen(raw_it1vcu12)>10
if r(N)==0 recast str10 raw_it1vcu12
confirm variable raw_rdnvcu12
quietly count if strlen(raw_rdnvcu12)>10
if r(N)==0 recast str10 raw_rdnvcu12
confirm variable raw_rimvcu12
quietly count if strlen(raw_rimvcu12)>10
if r(N)==0 recast str10 raw_rimvcu12
confirm variable raw_rtlvcu12
quietly count if strlen(raw_rtlvcu12)>10
if r(N)==0 recast str10 raw_rtlvcu12
confirm variable raw_ekspor12
quietly count if strlen(raw_ekspor12)>1
if r(N)==0 recast str1 raw_ekspor12
confirm variable raw_yprvcu12
quietly count if strlen(raw_yprvcu12)>10
if r(N)==0 recast str10 raw_yprvcu12
confirm variable raw_prprca12
quietly count if strlen(raw_prprca12)>17
if r(N)==0 recast str17 raw_prprca12
confirm variable raw_yisvcu12
quietly count if strlen(raw_yisvcu12)>10
if r(N)==0 recast str10 raw_yisvcu12
confirm variable raw_yrnvcu12
quietly count if strlen(raw_yrnvcu12)>9
if r(N)==0 recast str9 raw_yrnvcu12
confirm variable raw_yt1vcu12
quietly count if strlen(raw_yt1vcu12)>10
if r(N)==0 recast str10 raw_yt1vcu12
confirm variable raw_srjvcu12
quietly count if strlen(raw_srjvcu12)>11
if r(N)==0 recast str11 raw_srjvcu12
confirm variable raw_srdvcu12
quietly count if strlen(raw_srdvcu12)>11
if r(N)==0 recast str11 raw_srdvcu12
confirm variable raw_srmvcu12
quietly count if strlen(raw_srmvcu12)>11
if r(N)==0 recast str11 raw_srmvcu12
confirm variable raw_shjvcu12
quietly count if strlen(raw_shjvcu12)>10
if r(N)==0 recast str10 raw_shjvcu12
confirm variable raw_shdvcu12
quietly count if strlen(raw_shdvcu12)>10
if r(N)==0 recast str10 raw_shdvcu12
confirm variable raw_shfvcu12
quietly count if strlen(raw_shfvcu12)>10
if r(N)==0 recast str10 raw_shfvcu12
confirm variable raw_sfjvcu12
quietly count if strlen(raw_sfjvcu12)>11
if r(N)==0 recast str11 raw_sfjvcu12
confirm variable raw_sfdvcu12
quietly count if strlen(raw_sfdvcu12)>11
if r(N)==0 recast str11 raw_sfdvcu12
confirm variable raw_sfnvcu12
quietly count if strlen(raw_sfnvcu12)>11
if r(N)==0 recast str11 raw_sfnvcu12
confirm variable raw_stjvcu12
quietly count if strlen(raw_stjvcu12)>11
if r(N)==0 recast str11 raw_stjvcu12
confirm variable raw_stdvcu12
quietly count if strlen(raw_stdvcu12)>11
if r(N)==0 recast str11 raw_stdvcu12
confirm variable raw_stlvcu12
quietly count if strlen(raw_stlvcu12)>11
if r(N)==0 recast str11 raw_stlvcu12
confirm variable raw_clttcu12
quietly count if strlen(raw_clttcu12)>9
if r(N)==0 recast str9 raw_clttcu12
confirm variable raw_clsacu12
quietly count if strlen(raw_clsacu12)>8
if r(N)==0 recast str8 raw_clsacu12
confirm variable raw_cldacu12
quietly count if strlen(raw_cldacu12)>7
if r(N)==0 recast str7 raw_cldacu12
confirm variable raw_cbttcu12
quietly count if strlen(raw_cbttcu12)>10
if r(N)==0 recast str10 raw_cbttcu12
confirm variable raw_cbsacu12
quietly count if strlen(raw_cbsacu12)>8
if r(N)==0 recast str8 raw_cbsacu12
confirm variable raw_cbdacu12
quietly count if strlen(raw_cbdacu12)>9
if r(N)==0 recast str9 raw_cbdacu12
confirm variable raw_cmttcu12
quietly count if strlen(raw_cmttcu12)>10
if r(N)==0 recast str10 raw_cmttcu12
confirm variable raw_cmsacu12
quietly count if strlen(raw_cmsacu12)>8
if r(N)==0 recast str8 raw_cmsacu12
confirm variable raw_cmdacu12
quietly count if strlen(raw_cmdacu12)>10
if r(N)==0 recast str10 raw_cmdacu12
confirm variable raw_cvttcu12
quietly count if strlen(raw_cvttcu12)>9
if r(N)==0 recast str9 raw_cvttcu12
confirm variable raw_cvsacu12
quietly count if strlen(raw_cvsacu12)>8
if r(N)==0 recast str8 raw_cvsacu12
confirm variable raw_cvdacu12
quietly count if strlen(raw_cvdacu12)>8
if r(N)==0 recast str8 raw_cvdacu12
confirm variable raw_cottcu12
quietly count if strlen(raw_cottcu12)>9
if r(N)==0 recast str9 raw_cottcu12
confirm variable raw_cosacu12
quietly count if strlen(raw_cosacu12)>8
if r(N)==0 recast str8 raw_cosacu12
confirm variable raw_codacu12
quietly count if strlen(raw_codacu12)>9
if r(N)==0 recast str9 raw_codacu12
confirm variable raw_ctttcu12
quietly count if strlen(raw_ctttcu12)>10
if r(N)==0 recast str10 raw_ctttcu12
confirm variable raw_ctsacu12
quietly count if strlen(raw_ctsacu12)>9
if r(N)==0 recast str9 raw_ctsacu12
confirm variable raw_ctdacu12
quietly count if strlen(raw_ctdacu12)>10
if r(N)==0 recast str10 raw_ctdacu12
confirm variable raw_vtlvcu12
quietly count if strlen(raw_vtlvcu12)>10
if r(N)==0 recast str10 raw_vtlvcu12
confirm variable raw_flgent
quietly count if strlen(raw_flgent)>10
if r(N)==0 recast str10 raw_flgent
confirm variable raw_lfmnou12
quietly count if strlen(raw_lfmnou12)>2
if r(N)==0 recast str2 raw_lfmnou12
confirm variable raw_lfwnou12
quietly count if strlen(raw_lfwnou12)>3
if r(N)==0 recast str3 raw_lfwnou12
confirm variable raw_lfanou12
quietly count if strlen(raw_lfanou12)>3
if r(N)==0 recast str3 raw_lfanou12
confirm variable raw_ltmnou12
quietly count if strlen(raw_ltmnou12)>5
if r(N)==0 recast str5 raw_ltmnou12
confirm variable raw_ltwnou12
quietly count if strlen(raw_ltwnou12)>4
if r(N)==0 recast str4 raw_ltwnou12
confirm variable raw_ltlnou12
quietly count if strlen(raw_ltlnou12)>5
if r(N)==0 recast str5 raw_ltlnou12
confirm variable raw_ecbkgu12
quietly count if strlen(raw_ecbkgu12)>6
if r(N)==0 recast str6 raw_ecbkgu12
confirm variable raw_ecbvcu12
quietly count if strlen(raw_ecbvcu12)>7
if r(N)==0 recast str7 raw_ecbvcu12
confirm variable raw_ecbkge12
quietly count if strlen(raw_ecbkge12)>1
if r(N)==0 recast str1 raw_ecbkge12
confirm variable raw_ecbvce12
quietly count if strlen(raw_ecbvce12)>7
if r(N)==0 recast str7 raw_ecbvce12
confirm variable raw_egom3u12
quietly count if strlen(raw_egom3u12)>4
if r(N)==0 recast str4 raw_egom3u12
confirm variable raw_egovcu12
quietly count if strlen(raw_egovcu12)>6
if r(N)==0 recast str6 raw_egovcu12
confirm variable raw_egom3e12
quietly count if strlen(raw_egom3e12)>1
if r(N)==0 recast str1 raw_egom3e12
confirm variable raw_egovce12
quietly count if strlen(raw_egovce12)>1
if r(N)==0 recast str1 raw_egovce12
confirm variable raw_irrvcu12
quietly count if strlen(raw_irrvcu12)>8
if r(N)==0 recast str8 raw_irrvcu12
confirm variable raw_flg12
quietly count if strlen(raw_flg12)>1
if r(N)==0 recast str1 raw_flg12
confirm variable raw_dkabup12
quietly count if strlen(raw_dkabup12)>3
if r(N)==0 recast str3 raw_dkabup12
confirm variable raw_dkecam12
quietly count if strlen(raw_dkecam12)>3
if r(N)==0 recast str3 raw_dkecam12
confirm variable raw_ddesa12
quietly count if strlen(raw_ddesa12)>3
if r(N)==0 recast str3 raw_ddesa12
confirm variable raw_dstats12
quietly count if strlen(raw_dstats12)>1
if r(N)==0 recast str1 raw_dstats12
confirm variable raw_bdhukum
quietly count if strlen(raw_bdhukum)>2
if r(N)==0 recast str2 raw_bdhukum
confirm variable raw_dyrstr12
quietly count if strlen(raw_dyrstr12)>4
if r(N)==0 recast str4 raw_dyrstr12
confirm variable raw_locati12
quietly count if strlen(raw_locati12)>1
if r(N)==0 recast str1 raw_locati12
confirm variable raw_prprex12
quietly count if strlen(raw_prprex12)>5
if r(N)==0 recast str5 raw_prprex12
confirm variable raw_dsrvyr12
quietly count if strlen(raw_dsrvyr12)>4
if r(N)==0 recast str4 raw_dsrvyr12
confirm variable raw_dprovi13___2
quietly count if strlen(raw_dprovi13___2)>2
if r(N)==0 recast str2 raw_dprovi13___2
confirm variable raw_dkabup13___3
quietly count if strlen(raw_dkabup13___3)>3
if r(N)==0 recast str3 raw_dkabup13___3
confirm variable raw_dkecam13___4
quietly count if strlen(raw_dkecam13___4)>3
if r(N)==0 recast str3 raw_dkecam13___4
confirm variable raw_jan13
quietly count if strlen(raw_jan13)>1
if r(N)==0 recast str1 raw_jan13
confirm variable raw_feb13
quietly count if strlen(raw_feb13)>1
if r(N)==0 recast str1 raw_feb13
confirm variable raw_mar13
quietly count if strlen(raw_mar13)>1
if r(N)==0 recast str1 raw_mar13
confirm variable raw_apr13
quietly count if strlen(raw_apr13)>1
if r(N)==0 recast str1 raw_apr13
confirm variable raw_mei13
quietly count if strlen(raw_mei13)>1
if r(N)==0 recast str1 raw_mei13
confirm variable raw_jun13
quietly count if strlen(raw_jun13)>1
if r(N)==0 recast str1 raw_jun13
confirm variable raw_jul13
quietly count if strlen(raw_jul13)>1
if r(N)==0 recast str1 raw_jul13
confirm variable raw_ags13
quietly count if strlen(raw_ags13)>1
if r(N)==0 recast str1 raw_ags13
confirm variable raw_sep13
quietly count if strlen(raw_sep13)>1
if r(N)==0 recast str1 raw_sep13
confirm variable raw_okt13
quietly count if strlen(raw_okt13)>1
if r(N)==0 recast str1 raw_okt13
confirm variable raw_nov13
quietly count if strlen(raw_nov13)>1
if r(N)==0 recast str1 raw_nov13
confirm variable raw_des13
quietly count if strlen(raw_des13)>1
if r(N)==0 recast str1 raw_des13
confirm variable raw_year13
quietly count if strlen(raw_year13)>2
if r(N)==0 recast str2 raw_year13
confirm variable raw_dprovi13___19
quietly count if strlen(raw_dprovi13___19)>2
if r(N)==0 recast str2 raw_dprovi13___19
confirm variable raw_dklui13
quietly count if strlen(raw_dklui13)>3
if r(N)==0 recast str3 raw_dklui13
confirm variable raw_dseqno13
quietly count if strlen(raw_dseqno13)>4
if r(N)==0 recast str4 raw_dseqno13
confirm variable raw_dstats13
quietly count if strlen(raw_dstats13)>1
if r(N)==0 recast str1 raw_dstats13
confirm variable raw_locati13
quietly count if strlen(raw_locati13)>1
if r(N)==0 recast str1 raw_locati13
confirm variable raw_disic513
quietly count if strlen(raw_disic513)>5
if r(N)==0 recast str5 raw_disic513
confirm variable raw_mainpr13
quietly count if strlen(raw_mainpr13)>31
if r(N)==0 recast str31 raw_mainpr13
confirm variable raw_dpusat13
quietly count if strlen(raw_dpusat13)>3
if r(N)==0 recast str3 raw_dpusat13
confirm variable raw_dpemda13
quietly count if strlen(raw_dpemda13)>12
if r(N)==0 recast str12 raw_dpemda13
confirm variable raw_ddmstk13
quietly count if strlen(raw_ddmstk13)>5
if r(N)==0 recast str5 raw_ddmstk13
confirm variable raw_dasing13
quietly count if strlen(raw_dasing13)>17
if r(N)==0 recast str17 raw_dasing13
confirm variable raw_ceksum13
quietly count if strlen(raw_ceksum13)>9
if r(N)==0 recast str9 raw_ceksum13
confirm variable raw_lpmnou13
quietly count if strlen(raw_lpmnou13)>5
if r(N)==0 recast str5 raw_lpmnou13
confirm variable raw_lpwnou13
quietly count if strlen(raw_lpwnou13)>5
if r(N)==0 recast str5 raw_lpwnou13
confirm variable raw_lprnou13
quietly count if strlen(raw_lprnou13)>5
if r(N)==0 recast str5 raw_lprnou13
confirm variable raw_lnmnou13
quietly count if strlen(raw_lnmnou13)>4
if r(N)==0 recast str4 raw_lnmnou13
confirm variable raw_lnwnou13
quietly count if strlen(raw_lnwnou13)>4
if r(N)==0 recast str4 raw_lnwnou13
confirm variable raw_lnpnou13
quietly count if strlen(raw_lnpnou13)>5
if r(N)==0 recast str5 raw_lnpnou13
confirm variable raw_lfmnou13
quietly count if strlen(raw_lfmnou13)>2
if r(N)==0 recast str2 raw_lfmnou13
confirm variable raw_lfwnou13
quietly count if strlen(raw_lfwnou13)>3
if r(N)==0 recast str3 raw_lfwnou13
confirm variable raw_lfanou13
quietly count if strlen(raw_lfanou13)>3
if r(N)==0 recast str3 raw_lfanou13
confirm variable raw_ltmnou13
quietly count if strlen(raw_ltmnou13)>5
if r(N)==0 recast str5 raw_ltmnou13
confirm variable raw_ltwnou13
quietly count if strlen(raw_ltwnou13)>5
if r(N)==0 recast str5 raw_ltwnou13
confirm variable raw_ltlnou13
quietly count if strlen(raw_ltlnou13)>5
if r(N)==0 recast str5 raw_ltlnou13
confirm variable raw_zpsvcu13
quietly count if strlen(raw_zpsvcu13)>9
if r(N)==0 recast str9 raw_zpsvcu13
confirm variable raw_zpovcu13
quietly count if strlen(raw_zpovcu13)>9
if r(N)==0 recast str9 raw_zpovcu13
confirm variable raw_zpivcu13
quietly count if strlen(raw_zpivcu13)>9
if r(N)==0 recast str9 raw_zpivcu13
confirm variable raw_zppvcu13
quietly count if strlen(raw_zppvcu13)>9
if r(N)==0 recast str9 raw_zppvcu13
confirm variable raw_zpavcu13
quietly count if strlen(raw_zpavcu13)>7
if r(N)==0 recast str7 raw_zpavcu13
confirm variable raw_zpdvcu13
quietly count if strlen(raw_zpdvcu13)>9
if r(N)==0 recast str9 raw_zpdvcu13
confirm variable raw_znsvcu13
quietly count if strlen(raw_znsvcu13)>9
if r(N)==0 recast str9 raw_znsvcu13
confirm variable raw_znovcu13
quietly count if strlen(raw_znovcu13)>8
if r(N)==0 recast str8 raw_znovcu13
confirm variable raw_znivcu13
quietly count if strlen(raw_znivcu13)>8
if r(N)==0 recast str8 raw_znivcu13
confirm variable raw_znpvcu13
quietly count if strlen(raw_znpvcu13)>8
if r(N)==0 recast str8 raw_znpvcu13
confirm variable raw_znavcu13
quietly count if strlen(raw_znavcu13)>8
if r(N)==0 recast str8 raw_znavcu13
confirm variable raw_zndvcu13
quietly count if strlen(raw_zndvcu13)>9
if r(N)==0 recast str9 raw_zndvcu13
confirm variable raw_epeliu13
quietly count if strlen(raw_epeliu13)>8
if r(N)==0 recast str8 raw_epeliu13
confirm variable raw_epevcu13
quietly count if strlen(raw_epevcu13)>9
if r(N)==0 recast str9 raw_epevcu13
confirm variable raw_epelie13
quietly count if strlen(raw_epelie13)>6
if r(N)==0 recast str6 raw_epelie13
confirm variable raw_epevce13
quietly count if strlen(raw_epevce13)>7
if r(N)==0 recast str7 raw_epevce13
confirm variable raw_esoliu13
quietly count if strlen(raw_esoliu13)>8
if r(N)==0 recast str8 raw_esoliu13
confirm variable raw_esovcu13
quietly count if strlen(raw_esovcu13)>9
if r(N)==0 recast str9 raw_esovcu13
confirm variable raw_esolie13
quietly count if strlen(raw_esolie13)>7
if r(N)==0 recast str7 raw_esolie13
confirm variable raw_esovce13
quietly count if strlen(raw_esovce13)>8
if r(N)==0 recast str8 raw_esovce13
confirm variable raw_eoiliu13
quietly count if strlen(raw_eoiliu13)>6
if r(N)==0 recast str6 raw_eoiliu13
confirm variable raw_eoivcu13
quietly count if strlen(raw_eoivcu13)>7
if r(N)==0 recast str7 raw_eoivcu13
confirm variable raw_eoilie13
quietly count if strlen(raw_eoilie13)>5
if r(N)==0 recast str5 raw_eoilie13
confirm variable raw_eoivce13
quietly count if strlen(raw_eoivce13)>6
if r(N)==0 recast str6 raw_eoivce13
confirm variable raw_eclkgu13
quietly count if strlen(raw_eclkgu13)>10
if r(N)==0 recast str10 raw_eclkgu13
confirm variable raw_eclvcu13
quietly count if strlen(raw_eclvcu13)>9
if r(N)==0 recast str9 raw_eclvcu13
confirm variable raw_eclkge13
quietly count if strlen(raw_eclkge13)>9
if r(N)==0 recast str9 raw_eclkge13
confirm variable raw_eclvce13
quietly count if strlen(raw_eclvce13)>9
if r(N)==0 recast str9 raw_eclvce13
confirm variable raw_ecbkgu13
quietly count if strlen(raw_ecbkgu13)>6
if r(N)==0 recast str6 raw_ecbkgu13
confirm variable raw_ecbvcu13
quietly count if strlen(raw_ecbvcu13)>6
if r(N)==0 recast str6 raw_ecbvcu13
confirm variable raw_ecbkge13
quietly count if strlen(raw_ecbkge13)>1
if r(N)==0 recast str1 raw_ecbkge13
confirm variable raw_ecbvce13
quietly count if strlen(raw_ecbvce13)>1
if r(N)==0 recast str1 raw_ecbvce13
confirm variable raw_egam3u13
quietly count if strlen(raw_egam3u13)>8
if r(N)==0 recast str8 raw_egam3u13
confirm variable raw_egavcu13
quietly count if strlen(raw_egavcu13)>9
if r(N)==0 recast str9 raw_egavcu13
confirm variable raw_egam3e13
quietly count if strlen(raw_egam3e13)>6
if r(N)==0 recast str6 raw_egam3e13
confirm variable raw_egavce13
quietly count if strlen(raw_egavce13)>7
if r(N)==0 recast str7 raw_egavce13
confirm variable raw_egom3u13
quietly count if strlen(raw_egom3u13)>7
if r(N)==0 recast str7 raw_egom3u13
confirm variable raw_egovcu13
quietly count if strlen(raw_egovcu13)>8
if r(N)==0 recast str8 raw_egovcu13
confirm variable raw_egom3e13
quietly count if strlen(raw_egom3e13)>1
if r(N)==0 recast str1 raw_egom3e13
confirm variable raw_egovce13
quietly count if strlen(raw_egovce13)>1
if r(N)==0 recast str1 raw_egovce13
confirm variable raw_elpkgu13
quietly count if strlen(raw_elpkgu13)>6
if r(N)==0 recast str6 raw_elpkgu13
confirm variable raw_elpvcu13
quietly count if strlen(raw_elpvcu13)>8
if r(N)==0 recast str8 raw_elpvcu13
confirm variable raw_elpkge13
quietly count if strlen(raw_elpkge13)>5
if r(N)==0 recast str5 raw_elpkge13
confirm variable raw_elpvce13
quietly count if strlen(raw_elpvce13)>6
if r(N)==0 recast str6 raw_elpvce13
confirm variable raw_encvcu13
quietly count if strlen(raw_encvcu13)>9
if r(N)==0 recast str9 raw_encvcu13
confirm variable raw_encvce13
quietly count if strlen(raw_encvce13)>7
if r(N)==0 recast str7 raw_encvce13
confirm variable raw_eluliu13
quietly count if strlen(raw_eluliu13)>7
if r(N)==0 recast str7 raw_eluliu13
confirm variable raw_eluvcu13
quietly count if strlen(raw_eluvcu13)>8
if r(N)==0 recast str8 raw_eluvcu13
confirm variable raw_elulie13
quietly count if strlen(raw_elulie13)>5
if r(N)==0 recast str5 raw_elulie13
confirm variable raw_eluvce13
quietly count if strlen(raw_eluvce13)>6
if r(N)==0 recast str6 raw_eluvce13
confirm variable raw_efuvcu13
quietly count if strlen(raw_efuvcu13)>9
if r(N)==0 recast str9 raw_efuvcu13
confirm variable raw_efuvce13
quietly count if strlen(raw_efuvce13)>9
if r(N)==0 recast str9 raw_efuvce13
confirm variable raw_mgenou13
quietly count if strlen(raw_mgenou13)>6
if r(N)==0 recast str6 raw_mgenou13
confirm variable raw_mgekwu13
quietly count if strlen(raw_mgekwu13)>9
if r(N)==0 recast str9 raw_mgekwu13
confirm variable raw_eplkhu13
quietly count if strlen(raw_eplkhu13)>9
if r(N)==0 recast str9 raw_eplkhu13
confirm variable raw_eplvcu13
quietly count if strlen(raw_eplvcu13)>9
if r(N)==0 recast str9 raw_eplvcu13
confirm variable raw_enpkhu13
quietly count if strlen(raw_enpkhu13)>8
if r(N)==0 recast str8 raw_enpkhu13
confirm variable raw_enpvcu13
quietly count if strlen(raw_enpvcu13)>9
if r(N)==0 recast str9 raw_enpvcu13
confirm variable raw_esgkhu13
quietly count if strlen(raw_esgkhu13)>8
if r(N)==0 recast str8 raw_esgkhu13
confirm variable raw_oelkhu13
quietly count if strlen(raw_oelkhu13)>4
if r(N)==0 recast str4 raw_oelkhu13
confirm variable raw_yelvcu13
quietly count if strlen(raw_yelvcu13)>5
if r(N)==0 recast str5 raw_yelvcu13
confirm variable raw_ibrvcu13
quietly count if strlen(raw_ibrvcu13)>9
if r(N)==0 recast str9 raw_ibrvcu13
confirm variable raw_ilrvcu13
quietly count if strlen(raw_ilrvcu13)>7
if r(N)==0 recast str7 raw_ilrvcu13
confirm variable raw_itxvcu13
quietly count if strlen(raw_itxvcu13)>9
if r(N)==0 recast str9 raw_itxvcu13
confirm variable raw_iinvcu13
quietly count if strlen(raw_iinvcu13)>9
if r(N)==0 recast str9 raw_iinvcu13
confirm variable raw_icovcu13
quietly count if strlen(raw_icovcu13)>7
if r(N)==0 recast str7 raw_icovcu13
confirm variable raw_irrvcu13
quietly count if strlen(raw_irrvcu13)>8
if r(N)==0 recast str8 raw_irrvcu13
confirm variable raw_iotvcu13
quietly count if strlen(raw_iotvcu13)>9
if r(N)==0 recast str9 raw_iotvcu13
confirm variable raw_it1vcu13
quietly count if strlen(raw_it1vcu13)>10
if r(N)==0 recast str10 raw_it1vcu13
confirm variable raw_rdnvcu13
quietly count if strlen(raw_rdnvcu13)>10
if r(N)==0 recast str10 raw_rdnvcu13
confirm variable raw_rimvcu13
quietly count if strlen(raw_rimvcu13)>10
if r(N)==0 recast str10 raw_rimvcu13
confirm variable raw_rtlvcu13
quietly count if strlen(raw_rtlvcu13)>10
if r(N)==0 recast str10 raw_rtlvcu13
confirm variable raw_ekspor13
quietly count if strlen(raw_ekspor13)>1
if r(N)==0 recast str1 raw_ekspor13
confirm variable raw_yprvcu13
quietly count if strlen(raw_yprvcu13)>11
if r(N)==0 recast str11 raw_yprvcu13
confirm variable raw_prprca13
quietly count if strlen(raw_prprca13)>9
if r(N)==0 recast str9 raw_prprca13
confirm variable raw_yisvcu13
quietly count if strlen(raw_yisvcu13)>10
if r(N)==0 recast str10 raw_yisvcu13
confirm variable raw_yrnvcu13
quietly count if strlen(raw_yrnvcu13)>10
if r(N)==0 recast str10 raw_yrnvcu13
confirm variable raw_yt1vcu13
quietly count if strlen(raw_yt1vcu13)>10
if r(N)==0 recast str10 raw_yt1vcu13
confirm variable raw_srjvcu13
quietly count if strlen(raw_srjvcu13)>10
if r(N)==0 recast str10 raw_srjvcu13
confirm variable raw_srdvcu13
quietly count if strlen(raw_srdvcu13)>10
if r(N)==0 recast str10 raw_srdvcu13
confirm variable raw_srmvcu13
quietly count if strlen(raw_srmvcu13)>11
if r(N)==0 recast str11 raw_srmvcu13
confirm variable raw_shjvcu13
quietly count if strlen(raw_shjvcu13)>10
if r(N)==0 recast str10 raw_shjvcu13
confirm variable raw_shdvcu13
quietly count if strlen(raw_shdvcu13)>10
if r(N)==0 recast str10 raw_shdvcu13
confirm variable raw_shfvcu13
quietly count if strlen(raw_shfvcu13)>10
if r(N)==0 recast str10 raw_shfvcu13
confirm variable raw_sfjvcu13
quietly count if strlen(raw_sfjvcu13)>10
if r(N)==0 recast str10 raw_sfjvcu13
confirm variable raw_sfdvcu13
quietly count if strlen(raw_sfdvcu13)>10
if r(N)==0 recast str10 raw_sfdvcu13
confirm variable raw_sfnvcu13
quietly count if strlen(raw_sfnvcu13)>10
if r(N)==0 recast str10 raw_sfnvcu13
confirm variable raw_stjvcu13
quietly count if strlen(raw_stjvcu13)>10
if r(N)==0 recast str10 raw_stjvcu13
confirm variable raw_stdvcu13
quietly count if strlen(raw_stdvcu13)>10
if r(N)==0 recast str10 raw_stdvcu13
confirm variable raw_stlvcu13
quietly count if strlen(raw_stlvcu13)>11
if r(N)==0 recast str11 raw_stlvcu13
confirm variable raw_clttcu13
quietly count if strlen(raw_clttcu13)>9
if r(N)==0 recast str9 raw_clttcu13
confirm variable raw_clsacu13
quietly count if strlen(raw_clsacu13)>8
if r(N)==0 recast str8 raw_clsacu13
confirm variable raw_cldacu13
quietly count if strlen(raw_cldacu13)>8
if r(N)==0 recast str8 raw_cldacu13
confirm variable raw_cbttcu13
quietly count if strlen(raw_cbttcu13)>10
if r(N)==0 recast str10 raw_cbttcu13
confirm variable raw_cbsacu13
quietly count if strlen(raw_cbsacu13)>8
if r(N)==0 recast str8 raw_cbsacu13
confirm variable raw_cbdacu13
quietly count if strlen(raw_cbdacu13)>10
if r(N)==0 recast str10 raw_cbdacu13
confirm variable raw_cmttcu13
quietly count if strlen(raw_cmttcu13)>10
if r(N)==0 recast str10 raw_cmttcu13
confirm variable raw_cmsacu13
quietly count if strlen(raw_cmsacu13)>8
if r(N)==0 recast str8 raw_cmsacu13
confirm variable raw_cmdacu13
quietly count if strlen(raw_cmdacu13)>10
if r(N)==0 recast str10 raw_cmdacu13
confirm variable raw_cvttcu13
quietly count if strlen(raw_cvttcu13)>10
if r(N)==0 recast str10 raw_cvttcu13
confirm variable raw_cvsacu13
quietly count if strlen(raw_cvsacu13)>9
if r(N)==0 recast str9 raw_cvsacu13
confirm variable raw_cvdacu13
quietly count if strlen(raw_cvdacu13)>10
if r(N)==0 recast str10 raw_cvdacu13
confirm variable raw_cottcu13
quietly count if strlen(raw_cottcu13)>10
if r(N)==0 recast str10 raw_cottcu13
confirm variable raw_cosacu13
quietly count if strlen(raw_cosacu13)>9
if r(N)==0 recast str9 raw_cosacu13
confirm variable raw_codacu13
quietly count if strlen(raw_codacu13)>9
if r(N)==0 recast str9 raw_codacu13
confirm variable raw_ctttcu13
quietly count if strlen(raw_ctttcu13)>11
if r(N)==0 recast str11 raw_ctttcu13
confirm variable raw_ctdacu13
quietly count if strlen(raw_ctdacu13)>11
if r(N)==0 recast str11 raw_ctdacu13
confirm variable raw_iinput13
quietly count if strlen(raw_iinput13)>10
if r(N)==0 recast str10 raw_iinput13
confirm variable raw_output13
quietly count if strlen(raw_output13)>11
if r(N)==0 recast str11 raw_output13
confirm variable raw_vtlvcu13
quietly count if strlen(raw_vtlvcu13)>10
if r(N)==0 recast str10 raw_vtlvcu13
confirm variable raw_kode
quietly count if strlen(raw_kode)>1
if r(N)==0 recast str1 raw_kode
confirm variable raw_nama
quietly count if strlen(raw_nama)>3
if r(N)==0 recast str3 raw_nama
confirm variable raw_alamat
quietly count if strlen(raw_alamat)>3
if r(N)==0 recast str3 raw_alamat
confirm variable raw_stat
quietly count if strlen(raw_stat)>2
if r(N)==0 recast str2 raw_stat
confirm variable raw_useridpu
quietly count if strlen(raw_useridpu)>2
if r(N)==0 recast str2 raw_useridpu
confirm variable raw_kdkabu
quietly count if strlen(raw_kdkabu)>3
if r(N)==0 recast str3 raw_kdkabu
confirm variable raw_kdkeca
quietly count if strlen(raw_kdkeca)>3
if r(N)==0 recast str3 raw_kdkeca
confirm variable raw_kddesa
quietly count if strlen(raw_kddesa)>3
if r(N)==0 recast str3 raw_kddesa
confirm variable raw_tahun
quietly count if strlen(raw_tahun)>4
if r(N)==0 recast str4 raw_tahun
confirm variable raw_nama1
quietly count if strlen(raw_nama1)>3
if r(N)==0 recast str3 raw_nama1
confirm variable raw_alamat1
quietly count if strlen(raw_alamat1)>3
if r(N)==0 recast str3 raw_alamat1
confirm variable raw_email2
quietly count if strlen(raw_email2)>3
if r(N)==0 recast str3 raw_email2
confirm variable raw_stat1
quietly count if strlen(raw_stat1)>2
if r(N)==0 recast str2 raw_stat1
confirm variable raw_pekerja
quietly count if strlen(raw_pekerja)>10
if r(N)==0 recast str10 raw_pekerja
confirm variable raw_bbakar
quietly count if strlen(raw_bbakar)>9
if r(N)==0 recast str9 raw_bbakar
confirm variable raw_listrk
quietly count if strlen(raw_listrk)>9
if r(N)==0 recast str9 raw_listrk
confirm variable raw_iisvcu13
quietly count if strlen(raw_iisvcu13)>10
if r(N)==0 recast str10 raw_iisvcu13
confirm variable raw_bbpen
quietly count if strlen(raw_bbpen)>10
if r(N)==0 recast str10 raw_bbpen
confirm variable raw_inp
quietly count if strlen(raw_inp)>10
if r(N)==0 recast str10 raw_inp
confirm variable raw_lisjual
quietly count if strlen(raw_lisjual)>4
if r(N)==0 recast str4 raw_lisjual
confirm variable raw_prod
quietly count if strlen(raw_prod)>11
if r(N)==0 recast str11 raw_prod
confirm variable raw_jasa
quietly count if strlen(raw_jasa)>10
if r(N)==0 recast str10 raw_jasa
confirm variable raw_tambahn
quietly count if strlen(raw_tambahn)>10
if r(N)==0 recast str10 raw_tambahn
confirm variable raw_stok
quietly count if strlen(raw_stok)>9
if r(N)==0 recast str9 raw_stok
confirm variable raw_out
quietly count if strlen(raw_out)>11
if r(N)==0 recast str11 raw_out
confirm variable raw_land
quietly count if strlen(raw_land)>7
if r(N)==0 recast str7 raw_land
confirm variable raw_pajak
quietly count if strlen(raw_pajak)>9
if r(N)==0 recast str9 raw_pajak
confirm variable raw_pinjam
quietly count if strlen(raw_pinjam)>9
if r(N)==0 recast str9 raw_pinjam
confirm variable raw_derma
quietly count if strlen(raw_derma)>7
if r(N)==0 recast str7 raw_derma
confirm variable raw_ntb1
quietly count if strlen(raw_ntb1)>10
if r(N)==0 recast str10 raw_ntb1
confirm variable raw_royal
quietly count if strlen(raw_royal)>8
if r(N)==0 recast str8 raw_royal
confirm variable raw_ntb2
quietly count if strlen(raw_ntb2)>17
if r(N)==0 recast str17 raw_ntb2
confirm variable raw_ctsacu13
quietly count if strlen(raw_ctsacu13)>10
if r(N)==0 recast str10 raw_ctsacu13
confirm variable raw_dkabup13___194
quietly count if strlen(raw_dkabup13___194)>3
if r(N)==0 recast str3 raw_dkabup13___194
confirm variable raw_dkecam13___195
quietly count if strlen(raw_dkecam13___195)>3
if r(N)==0 recast str3 raw_dkecam13___195
confirm variable raw_ddesa13
quietly count if strlen(raw_ddesa13)>3
if r(N)==0 recast str3 raw_ddesa13
confirm variable raw_flg13
quietly count if strlen(raw_flg13)>1
if r(N)==0 recast str1 raw_flg13
confirm variable raw_prprex13
quietly count if strlen(raw_prprex13)>5
if r(N)==0 recast str5 raw_prprex13
confirm variable raw_dsrvyr13
quietly count if strlen(raw_dsrvyr13)>4
if r(N)==0 recast str4 raw_dsrvyr13
confirm variable raw_kip_syst
quietly count if strlen(raw_kip_syst)>3
if r(N)==0 recast str3 raw_kip_syst
confirm variable raw_dprovi14
quietly count if strlen(raw_dprovi14)>2
if r(N)==0 recast str2 raw_dprovi14
confirm variable raw_dkabup14
quietly count if strlen(raw_dkabup14)>3
if r(N)==0 recast str3 raw_dkabup14
confirm variable raw_dkecam14
quietly count if strlen(raw_dkecam14)>3
if r(N)==0 recast str3 raw_dkecam14
confirm variable raw_ddesa14
quietly count if strlen(raw_ddesa14)>3
if r(N)==0 recast str3 raw_ddesa14
confirm variable raw_dstats14
quietly count if strlen(raw_dstats14)>1
if r(N)==0 recast str1 raw_dstats14
confirm variable raw_bhukum14
quietly count if strlen(raw_bhukum14)>2
if r(N)==0 recast str2 raw_bhukum14
confirm variable raw_disic514
quietly count if strlen(raw_disic514)>5
if r(N)==0 recast str5 raw_disic514
confirm variable raw_mainpr14
quietly count if strlen(raw_mainpr14)>97
if r(N)==0 recast str97 raw_mainpr14
confirm variable raw_ltlnou14
quietly count if strlen(raw_ltlnou14)>5
if r(N)==0 recast str5 raw_ltlnou14
confirm variable raw_vtlvcu14
quietly count if strlen(raw_vtlvcu14)>10
if r(N)==0 recast str10 raw_vtlvcu14
confirm variable raw_output14
quietly count if strlen(raw_output14)>11
if r(N)==0 recast str11 raw_output14
confirm variable raw_iinput14
quietly count if strlen(raw_iinput14)>11
if r(N)==0 recast str11 raw_iinput14
confirm variable raw_flg14
quietly count if strlen(raw_flg14)>1
if r(N)==0 recast str1 raw_flg14
confirm variable raw_yprvcu14
quietly count if strlen(raw_yprvcu14)>11
if r(N)==0 recast str11 raw_yprvcu14
confirm variable raw_yisvcu14
quietly count if strlen(raw_yisvcu14)>10
if r(N)==0 recast str10 raw_yisvcu14
confirm variable raw_yrnvcu14
quietly count if strlen(raw_yrnvcu14)>10
if r(N)==0 recast str10 raw_yrnvcu14
confirm variable raw_yelvcu14
quietly count if strlen(raw_yelvcu14)>7
if r(N)==0 recast str7 raw_yelvcu14
confirm variable raw_shfvcu14
quietly count if strlen(raw_shfvcu14)>10
if r(N)==0 recast str10 raw_shfvcu14
confirm variable raw_yt1vcu14
quietly count if strlen(raw_yt1vcu14)>10
if r(N)==0 recast str10 raw_yt1vcu14
confirm variable raw_rtlvcu14
quietly count if strlen(raw_rtlvcu14)>11
if r(N)==0 recast str11 raw_rtlvcu14
confirm variable raw_efuvcu14
quietly count if strlen(raw_efuvcu14)>9
if r(N)==0 recast str9 raw_efuvcu14
confirm variable raw_ibrvcu14
quietly count if strlen(raw_ibrvcu14)>10
if r(N)==0 recast str10 raw_ibrvcu14
confirm variable raw_iisvcu14
quietly count if strlen(raw_iisvcu14)>9
if r(N)==0 recast str9 raw_iisvcu14
confirm variable raw_irrvcu14
quietly count if strlen(raw_irrvcu14)>9
if r(N)==0 recast str9 raw_irrvcu14
confirm variable raw_eplvcu14
quietly count if strlen(raw_eplvcu14)>10
if r(N)==0 recast str10 raw_eplvcu14
confirm variable raw_enpvcu14
quietly count if strlen(raw_enpvcu14)>8
if r(N)==0 recast str8 raw_enpvcu14
confirm variable raw_iotvcu14
quietly count if strlen(raw_iotvcu14)>10
if r(N)==0 recast str10 raw_iotvcu14
confirm variable raw_epevcu14
quietly count if strlen(raw_epevcu14)>8
if r(N)==0 recast str8 raw_epevcu14
confirm variable raw_esovcu14
quietly count if strlen(raw_esovcu14)>9
if r(N)==0 recast str9 raw_esovcu14
confirm variable raw_eoivcu14
quietly count if strlen(raw_eoivcu14)>8
if r(N)==0 recast str8 raw_eoivcu14
confirm variable raw_eclvcu14
quietly count if strlen(raw_eclvcu14)>9
if r(N)==0 recast str9 raw_eclvcu14
confirm variable raw_ecbvcu14
quietly count if strlen(raw_ecbvcu14)>8
if r(N)==0 recast str8 raw_ecbvcu14
confirm variable raw_egavcu14
quietly count if strlen(raw_egavcu14)>9
if r(N)==0 recast str9 raw_egavcu14
confirm variable raw_egovcu14
quietly count if strlen(raw_egovcu14)>9
if r(N)==0 recast str9 raw_egovcu14
confirm variable raw_elpvcu14
quietly count if strlen(raw_elpvcu14)>8
if r(N)==0 recast str8 raw_elpvcu14
confirm variable raw_eluvcu14
quietly count if strlen(raw_eluvcu14)>9
if r(N)==0 recast str9 raw_eluvcu14
confirm variable raw_encvcu14
quietly count if strlen(raw_encvcu14)>9
if r(N)==0 recast str9 raw_encvcu14
confirm variable raw_efuvce14
quietly count if strlen(raw_efuvce14)>8
if r(N)==0 recast str8 raw_efuvce14
confirm variable raw_epevce14
quietly count if strlen(raw_epevce14)>7
if r(N)==0 recast str7 raw_epevce14
confirm variable raw_eluvce14
quietly count if strlen(raw_eluvce14)>7
if r(N)==0 recast str7 raw_eluvce14
confirm variable raw_esovce14
quietly count if strlen(raw_esovce14)>8
if r(N)==0 recast str8 raw_esovce14
confirm variable raw_eoivce14
quietly count if strlen(raw_eoivce14)>1
if r(N)==0 recast str1 raw_eoivce14
confirm variable raw_ecbvce14
quietly count if strlen(raw_ecbvce14)>1
if r(N)==0 recast str1 raw_ecbvce14
confirm variable raw_encvce14
quietly count if strlen(raw_encvce14)>7
if r(N)==0 recast str7 raw_encvce14
confirm variable raw_eclvce14
quietly count if strlen(raw_eclvce14)>8
if r(N)==0 recast str8 raw_eclvce14
confirm variable raw_eclkge14
quietly count if strlen(raw_eclkge14)>8
if r(N)==0 recast str8 raw_eclkge14
confirm variable raw_ecbkge14
quietly count if strlen(raw_ecbkge14)>1
if r(N)==0 recast str1 raw_ecbkge14
confirm variable raw_egavce14
quietly count if strlen(raw_egavce14)>7
if r(N)==0 recast str7 raw_egavce14
confirm variable raw_egam3e14
quietly count if strlen(raw_egam3e14)>6
if r(N)==0 recast str6 raw_egam3e14
confirm variable raw_egovce14
quietly count if strlen(raw_egovce14)>1
if r(N)==0 recast str1 raw_egovce14
confirm variable raw_egom3e14
quietly count if strlen(raw_egom3e14)>1
if r(N)==0 recast str1 raw_egom3e14
confirm variable raw_elpvce14
quietly count if strlen(raw_elpvce14)>6
if r(N)==0 recast str6 raw_elpvce14
confirm variable raw_elpkge14
quietly count if strlen(raw_elpkge14)>5
if r(N)==0 recast str5 raw_elpkge14
confirm variable raw_epeliu14
quietly count if strlen(raw_epeliu14)>8
if r(N)==0 recast str8 raw_epeliu14
confirm variable raw_esoliu14
quietly count if strlen(raw_esoliu14)>8
if r(N)==0 recast str8 raw_esoliu14
confirm variable raw_eoiliu14
quietly count if strlen(raw_eoiliu14)>7
if r(N)==0 recast str7 raw_eoiliu14
confirm variable raw_eclkgu14
quietly count if strlen(raw_eclkgu14)>10
if r(N)==0 recast str10 raw_eclkgu14
confirm variable raw_ecbkgu14
quietly count if strlen(raw_ecbkgu14)>7
if r(N)==0 recast str7 raw_ecbkgu14
confirm variable raw_egam3u14
quietly count if strlen(raw_egam3u14)>8
if r(N)==0 recast str8 raw_egam3u14
confirm variable raw_egom3u14
quietly count if strlen(raw_egom3u14)>7
if r(N)==0 recast str7 raw_egom3u14
confirm variable raw_elpkgu14
quietly count if strlen(raw_elpkgu14)>6
if r(N)==0 recast str6 raw_elpkgu14
confirm variable raw_eluliu14
quietly count if strlen(raw_eluliu14)>8
if r(N)==0 recast str8 raw_eluliu14
confirm variable raw_epelie14
quietly count if strlen(raw_epelie14)>6
if r(N)==0 recast str6 raw_epelie14
confirm variable raw_esolie14
quietly count if strlen(raw_esolie14)>7
if r(N)==0 recast str7 raw_esolie14
confirm variable raw_eoilie14
quietly count if strlen(raw_eoilie14)>1
if r(N)==0 recast str1 raw_eoilie14
confirm variable raw_elulie14
quietly count if strlen(raw_elulie14)>5
if r(N)==0 recast str5 raw_elulie14
confirm variable raw_eplkhu14
quietly count if strlen(raw_eplkhu14)>9
if r(N)==0 recast str9 raw_eplkhu14
confirm variable raw_enpkhu14
quietly count if strlen(raw_enpkhu14)>8
if r(N)==0 recast str8 raw_enpkhu14
confirm variable raw_oelkhu14
quietly count if strlen(raw_oelkhu14)>7
if r(N)==0 recast str7 raw_oelkhu14
confirm variable raw_esgkhu14
quietly count if strlen(raw_esgkhu14)>8
if r(N)==0 recast str8 raw_esgkhu14
confirm variable raw_srjvcu14
quietly count if strlen(raw_srjvcu14)>10
if r(N)==0 recast str10 raw_srjvcu14
confirm variable raw_shjvcu14
quietly count if strlen(raw_shjvcu14)>10
if r(N)==0 recast str10 raw_shjvcu14
confirm variable raw_sfjvcu14
quietly count if strlen(raw_sfjvcu14)>11
if r(N)==0 recast str11 raw_sfjvcu14
confirm variable raw_srmvcu14
quietly count if strlen(raw_srmvcu14)>11
if r(N)==0 recast str11 raw_srmvcu14
confirm variable raw_sfnvcu14
quietly count if strlen(raw_sfnvcu14)>11
if r(N)==0 recast str11 raw_sfnvcu14
confirm variable raw_srdvcu14
quietly count if strlen(raw_srdvcu14)>11
if r(N)==0 recast str11 raw_srdvcu14
confirm variable raw_shdvcu14
quietly count if strlen(raw_shdvcu14)>11
if r(N)==0 recast str11 raw_shdvcu14
confirm variable raw_sfdvcu14
quietly count if strlen(raw_sfdvcu14)>11
if r(N)==0 recast str11 raw_sfdvcu14
confirm variable raw_stjvcu14
quietly count if strlen(raw_stjvcu14)>11
if r(N)==0 recast str11 raw_stjvcu14
confirm variable raw_stdvcu14
quietly count if strlen(raw_stdvcu14)>11
if r(N)==0 recast str11 raw_stdvcu14
confirm variable raw_stlvcu14
quietly count if strlen(raw_stlvcu14)>11
if r(N)==0 recast str11 raw_stlvcu14
confirm variable raw_rdnvcu14
quietly count if strlen(raw_rdnvcu14)>11
if r(N)==0 recast str11 raw_rdnvcu14
confirm variable raw_rimvcu14
quietly count if strlen(raw_rimvcu14)>10
if r(N)==0 recast str10 raw_rimvcu14
confirm variable raw_lprnou14
quietly count if strlen(raw_lprnou14)>5
if r(N)==0 recast str5 raw_lprnou14
confirm variable raw_lfanou14
quietly count if strlen(raw_lfanou14)>2
if r(N)==0 recast str2 raw_lfanou14
confirm variable raw_lnpnou14
quietly count if strlen(raw_lnpnou14)>4
if r(N)==0 recast str4 raw_lnpnou14
confirm variable raw_lpmnou14
quietly count if strlen(raw_lpmnou14)>5
if r(N)==0 recast str5 raw_lpmnou14
confirm variable raw_lpwnou14
quietly count if strlen(raw_lpwnou14)>4
if r(N)==0 recast str4 raw_lpwnou14
confirm variable raw_lnmnou14
quietly count if strlen(raw_lnmnou14)>4
if r(N)==0 recast str4 raw_lnmnou14
confirm variable raw_lnwnou14
quietly count if strlen(raw_lnwnou14)>3
if r(N)==0 recast str3 raw_lnwnou14
confirm variable raw_lfmnou14
quietly count if strlen(raw_lfmnou14)>1
if r(N)==0 recast str1 raw_lfmnou14
confirm variable raw_lfwnou14
quietly count if strlen(raw_lfwnou14)>2
if r(N)==0 recast str2 raw_lfwnou14
confirm variable raw_ltmnou14
quietly count if strlen(raw_ltmnou14)>5
if r(N)==0 recast str5 raw_ltmnou14
confirm variable raw_ltwnou14
quietly count if strlen(raw_ltwnou14)>4
if r(N)==0 recast str4 raw_ltwnou14
confirm variable raw_zpdvcu14
quietly count if strlen(raw_zpdvcu14)>9
if r(N)==0 recast str9 raw_zpdvcu14
confirm variable raw_zndvcu14
quietly count if strlen(raw_zndvcu14)>9
if r(N)==0 recast str9 raw_zndvcu14
confirm variable raw_zpsvcu14
quietly count if strlen(raw_zpsvcu14)>9
if r(N)==0 recast str9 raw_zpsvcu14
confirm variable raw_zpovcu14
quietly count if strlen(raw_zpovcu14)>8
if r(N)==0 recast str8 raw_zpovcu14
confirm variable raw_zpivcu14
quietly count if strlen(raw_zpivcu14)>9
if r(N)==0 recast str9 raw_zpivcu14
confirm variable raw_zppvcu14
quietly count if strlen(raw_zppvcu14)>8
if r(N)==0 recast str8 raw_zppvcu14
confirm variable raw_zpavcu14
quietly count if strlen(raw_zpavcu14)>7
if r(N)==0 recast str7 raw_zpavcu14
confirm variable raw_znsvcu14
quietly count if strlen(raw_znsvcu14)>9
if r(N)==0 recast str9 raw_znsvcu14
confirm variable raw_znovcu14
quietly count if strlen(raw_znovcu14)>8
if r(N)==0 recast str8 raw_znovcu14
confirm variable raw_znivcu14
quietly count if strlen(raw_znivcu14)>9
if r(N)==0 recast str9 raw_znivcu14
confirm variable raw_znpvcu14
quietly count if strlen(raw_znpvcu14)>8
if r(N)==0 recast str8 raw_znpvcu14
confirm variable raw_znavcu14
quietly count if strlen(raw_znavcu14)>8
if r(N)==0 recast str8 raw_znavcu14
confirm variable raw_jan14
quietly count if strlen(raw_jan14)>1
if r(N)==0 recast str1 raw_jan14
confirm variable raw_feb14
quietly count if strlen(raw_feb14)>1
if r(N)==0 recast str1 raw_feb14
confirm variable raw_mar14
quietly count if strlen(raw_mar14)>1
if r(N)==0 recast str1 raw_mar14
confirm variable raw_apr14
quietly count if strlen(raw_apr14)>1
if r(N)==0 recast str1 raw_apr14
confirm variable raw_mei14
quietly count if strlen(raw_mei14)>1
if r(N)==0 recast str1 raw_mei14
confirm variable raw_jun14
quietly count if strlen(raw_jun14)>1
if r(N)==0 recast str1 raw_jun14
confirm variable raw_jul14
quietly count if strlen(raw_jul14)>1
if r(N)==0 recast str1 raw_jul14
confirm variable raw_ags14
quietly count if strlen(raw_ags14)>1
if r(N)==0 recast str1 raw_ags14
confirm variable raw_sep14
quietly count if strlen(raw_sep14)>1
if r(N)==0 recast str1 raw_sep14
confirm variable raw_okt14
quietly count if strlen(raw_okt14)>1
if r(N)==0 recast str1 raw_okt14
confirm variable raw_nov14
quietly count if strlen(raw_nov14)>1
if r(N)==0 recast str1 raw_nov14
confirm variable raw_des14
quietly count if strlen(raw_des14)>1
if r(N)==0 recast str1 raw_des14
confirm variable raw_year14
quietly count if strlen(raw_year14)>2
if r(N)==0 recast str2 raw_year14
confirm variable raw_dpusat14
quietly count if strlen(raw_dpusat14)>3
if r(N)==0 recast str3 raw_dpusat14
confirm variable raw_dpemda14
quietly count if strlen(raw_dpemda14)>8
if r(N)==0 recast str8 raw_dpemda14
confirm variable raw_ddmstk14
quietly count if strlen(raw_ddmstk14)>5
if r(N)==0 recast str5 raw_ddmstk14
confirm variable raw_dasing14
quietly count if strlen(raw_dasing14)>5
if r(N)==0 recast str5 raw_dasing14
confirm variable raw_ceksum14
quietly count if strlen(raw_ceksum14)>3
if r(N)==0 recast str3 raw_ceksum14
confirm variable raw_mgenou14
quietly count if strlen(raw_mgenou14)>6
if r(N)==0 recast str6 raw_mgenou14
confirm variable raw_mgekwu14
quietly count if strlen(raw_mgekwu14)>8
if r(N)==0 recast str8 raw_mgekwu14
confirm variable raw_ilrvcu14
quietly count if strlen(raw_ilrvcu14)>7
if r(N)==0 recast str7 raw_ilrvcu14
confirm variable raw_itxvcu14
quietly count if strlen(raw_itxvcu14)>9
if r(N)==0 recast str9 raw_itxvcu14
confirm variable raw_iinvcu14
quietly count if strlen(raw_iinvcu14)>9
if r(N)==0 recast str9 raw_iinvcu14
confirm variable raw_icovcu14
quietly count if strlen(raw_icovcu14)>8
if r(N)==0 recast str8 raw_icovcu14
confirm variable raw_prprca14
quietly count if strlen(raw_prprca14)>10
if r(N)==0 recast str10 raw_prprca14
confirm variable raw_clttcu14
quietly count if strlen(raw_clttcu14)>10
if r(N)==0 recast str10 raw_clttcu14
confirm variable raw_clsacu14
quietly count if strlen(raw_clsacu14)>8
if r(N)==0 recast str8 raw_clsacu14
confirm variable raw_cldacu14
quietly count if strlen(raw_cldacu14)>9
if r(N)==0 recast str9 raw_cldacu14
confirm variable raw_cbttcu14
quietly count if strlen(raw_cbttcu14)>11
if r(N)==0 recast str11 raw_cbttcu14
confirm variable raw_cbsacu14
quietly count if strlen(raw_cbsacu14)>7
if r(N)==0 recast str7 raw_cbsacu14
confirm variable raw_cbdacu14
quietly count if strlen(raw_cbdacu14)>10
if r(N)==0 recast str10 raw_cbdacu14
confirm variable raw_cmttcu14
quietly count if strlen(raw_cmttcu14)>11
if r(N)==0 recast str11 raw_cmttcu14
confirm variable raw_cmsacu14
quietly count if strlen(raw_cmsacu14)>9
if r(N)==0 recast str9 raw_cmsacu14
confirm variable raw_cmdacu14
quietly count if strlen(raw_cmdacu14)>11
if r(N)==0 recast str11 raw_cmdacu14
confirm variable raw_cvttcu14
quietly count if strlen(raw_cvttcu14)>10
if r(N)==0 recast str10 raw_cvttcu14
confirm variable raw_cvsacu14
quietly count if strlen(raw_cvsacu14)>9
if r(N)==0 recast str9 raw_cvsacu14
confirm variable raw_cvdacu14
quietly count if strlen(raw_cvdacu14)>10
if r(N)==0 recast str10 raw_cvdacu14
confirm variable raw_cottcu14
quietly count if strlen(raw_cottcu14)>9
if r(N)==0 recast str9 raw_cottcu14
confirm variable raw_cosacu14
quietly count if strlen(raw_cosacu14)>10
if r(N)==0 recast str10 raw_cosacu14
confirm variable raw_codacu14
quietly count if strlen(raw_codacu14)>10
if r(N)==0 recast str10 raw_codacu14
confirm variable raw_ctttcu14
quietly count if strlen(raw_ctttcu14)>11
if r(N)==0 recast str11 raw_ctttcu14
confirm variable raw_ctdacu14
quietly count if strlen(raw_ctdacu14)>11
if r(N)==0 recast str11 raw_ctdacu14
confirm variable raw_ctsacu14
quietly count if strlen(raw_ctsacu14)>10
if r(N)==0 recast str10 raw_ctsacu14
confirm variable raw_prprex14
quietly count if strlen(raw_prprex14)>17
if r(N)==0 recast str17 raw_prprex14
confirm variable raw_it1vcu14
quietly count if strlen(raw_it1vcu14)>10
if r(N)==0 recast str10 raw_it1vcu14
confirm variable raw_r12k10r
quietly count if strlen(raw_r12k10r)>11
if r(N)==0 recast str11 raw_r12k10r
confirm variable raw_exp
quietly count if strlen(raw_exp)>17
if r(N)==0 recast str17 raw_exp
confirm variable raw_r17ak4r
quietly count if strlen(raw_r17ak4r)>11
if r(N)==0 recast str11 raw_r17ak4r
confirm variable raw_r17bk4r
quietly count if strlen(raw_r17bk4r)>10
if r(N)==0 recast str10 raw_r17bk4r
confirm variable raw_r17ck4r
quietly count if strlen(raw_r17ck4r)>11
if r(N)==0 recast str11 raw_r17ck4r
confirm variable raw_r21_1
quietly count if strlen(raw_r21_1)>9
if r(N)==0 recast str9 raw_r21_1
confirm variable raw_r21_2
quietly count if strlen(raw_r21_2)>9
if r(N)==0 recast str9 raw_r21_2
confirm variable raw_r21_3
quietly count if strlen(raw_r21_3)>9
if r(N)==0 recast str9 raw_r21_3
confirm variable raw_r21_4
quietly count if strlen(raw_r21_4)>10
if r(N)==0 recast str10 raw_r21_4
confirm variable raw_r21_5
quietly count if strlen(raw_r21_5)>11
if r(N)==0 recast str11 raw_r21_5
confirm variable raw_r21sum
quietly count if strlen(raw_r21sum)>11
if r(N)==0 recast str11 raw_r21sum
confirm variable raw_r22_1
quietly count if strlen(raw_r22_1)>7
if r(N)==0 recast str7 raw_r22_1
confirm variable raw_r22_2
quietly count if strlen(raw_r22_2)>11
if r(N)==0 recast str11 raw_r22_2
confirm variable raw_r22_3
quietly count if strlen(raw_r22_3)>10
if r(N)==0 recast str10 raw_r22_3
confirm variable raw_r22_4
quietly count if strlen(raw_r22_4)>9
if r(N)==0 recast str9 raw_r22_4
confirm variable raw_r22_5
quietly count if strlen(raw_r22_5)>10
if r(N)==0 recast str10 raw_r22_5
confirm variable raw_r22sum
quietly count if strlen(raw_r22sum)>11
if r(N)==0 recast str11 raw_r22sum
confirm variable raw_r23a1
quietly count if strlen(raw_r23a1)>7
if r(N)==0 recast str7 raw_r23a1
confirm variable raw_r23a2
quietly count if strlen(raw_r23a2)>9
if r(N)==0 recast str9 raw_r23a2
confirm variable raw_r23a3
quietly count if strlen(raw_r23a3)>9
if r(N)==0 recast str9 raw_r23a3
confirm variable raw_r23a4
quietly count if strlen(raw_r23a4)>8
if r(N)==0 recast str8 raw_r23a4
confirm variable raw_r23asum
quietly count if strlen(raw_r23asum)>9
if r(N)==0 recast str9 raw_r23asum
confirm variable raw_r23b
quietly count if strlen(raw_r23b)>10
if r(N)==0 recast str10 raw_r23b
confirm variable raw_locati14
quietly count if strlen(raw_locati14)>1
if r(N)==0 recast str1 raw_locati14
confirm variable raw_ekspor14
quietly count if strlen(raw_ekspor14)>1
if r(N)==0 recast str1 raw_ekspor14
confirm variable raw_reeksp14
quietly count if strlen(raw_reeksp14)>1
if r(N)==0 recast str1 raw_reeksp14
confirm variable raw_yisvdo14
quietly count if strlen(raw_yisvdo14)>10
if r(N)==0 recast str10 raw_yisvdo14
confirm variable raw_yisvfo14
quietly count if strlen(raw_yisvfo14)>10
if r(N)==0 recast str10 raw_yisvfo14
confirm variable raw_dsrvyr14
quietly count if strlen(raw_dsrvyr14)>4
if r(N)==0 recast str4 raw_dsrvyr14
confirm variable raw_dklui14
quietly count if strlen(raw_dklui14)>1
if r(N)==0 recast str1 raw_dklui14
confirm variable raw_dseqno14
quietly count if strlen(raw_dseqno14)>1
if r(N)==0 recast str1 raw_dseqno14
confirm variable raw_export
quietly count if strlen(raw_export)>1
if r(N)==0 recast str1 raw_export
confirm variable raw_sdd
quietly count if strlen(raw_sdd)>8
if r(N)==0 recast str8 raw_sdd
confirm variable raw_ctttcu15
quietly count if strlen(raw_ctttcu15)>8
if r(N)==0 recast str8 raw_ctttcu15
confirm variable raw_ras1
quietly count if strlen(raw_ras1)>17
if r(N)==0 recast str17 raw_ras1
confirm variable raw_kip
quietly count if strlen(raw_kip)>3
if r(N)==0 recast str3 raw_kip
confirm variable raw_dprovi
quietly count if strlen(raw_dprovi)>2
if r(N)==0 recast str2 raw_dprovi
confirm variable raw_kodekab
quietly count if strlen(raw_kodekab)>3
if r(N)==0 recast str3 raw_kodekab
confirm variable raw_kodekec
quietly count if strlen(raw_kodekec)>3
if r(N)==0 recast str3 raw_kodekec
confirm variable raw_kodedesa
quietly count if strlen(raw_kodedesa)>3
if r(N)==0 recast str3 raw_kodedesa
confirm variable raw_bloksens
quietly count if strlen(raw_bloksens)>4
if r(N)==0 recast str4 raw_bloksens
confirm variable raw_dstats
quietly count if strlen(raw_dstats)>1
if r(N)==0 recast str1 raw_dstats
confirm variable raw_locati
quietly count if strlen(raw_locati)>1
if r(N)==0 recast str1 raw_locati
confirm variable raw_jan
quietly count if strlen(raw_jan)>1
if r(N)==0 recast str1 raw_jan
confirm variable raw_feb
quietly count if strlen(raw_feb)>1
if r(N)==0 recast str1 raw_feb
confirm variable raw_mar
quietly count if strlen(raw_mar)>1
if r(N)==0 recast str1 raw_mar
confirm variable raw_apr
quietly count if strlen(raw_apr)>1
if r(N)==0 recast str1 raw_apr
confirm variable raw_mei
quietly count if strlen(raw_mei)>1
if r(N)==0 recast str1 raw_mei
confirm variable raw_jun
quietly count if strlen(raw_jun)>1
if r(N)==0 recast str1 raw_jun
confirm variable raw_jul
quietly count if strlen(raw_jul)>1
if r(N)==0 recast str1 raw_jul
confirm variable raw_ags
quietly count if strlen(raw_ags)>1
if r(N)==0 recast str1 raw_ags
confirm variable raw_sep
quietly count if strlen(raw_sep)>1
if r(N)==0 recast str1 raw_sep
confirm variable raw_okt
quietly count if strlen(raw_okt)>1
if r(N)==0 recast str1 raw_okt
confirm variable raw_nop
quietly count if strlen(raw_nop)>1
if r(N)==0 recast str1 raw_nop
confirm variable raw_des
quietly count if strlen(raw_des)>1
if r(N)==0 recast str1 raw_des
confirm variable raw_year
quietly count if strlen(raw_year)>2
if r(N)==0 recast str2 raw_year
confirm variable raw_produksi
quietly count if strlen(raw_produksi)>168
if r(N)==0 recast str168 raw_produksi
confirm variable raw_disic5
quietly count if strlen(raw_disic5)>5
if r(N)==0 recast str5 raw_disic5
confirm variable raw_dpusat
quietly count if strlen(raw_dpusat)>3
if r(N)==0 recast str3 raw_dpusat
confirm variable raw_dpemda
quietly count if strlen(raw_dpemda)>5
if r(N)==0 recast str5 raw_dpemda
confirm variable raw_ddmstk
quietly count if strlen(raw_ddmstk)>17
if r(N)==0 recast str17 raw_ddmstk
confirm variable raw_dasing
quietly count if strlen(raw_dasing)>17
if r(N)==0 recast str17 raw_dasing
confirm variable raw_ceksum
quietly count if strlen(raw_ceksum)>3
if r(N)==0 recast str3 raw_ceksum
confirm variable raw_lpmltl
quietly count if strlen(raw_lpmltl)>4
if r(N)==0 recast str4 raw_lpmltl
confirm variable raw_lnmltl
quietly count if strlen(raw_lnmltl)>4
if r(N)==0 recast str4 raw_lnmltl
confirm variable raw_lfmnou
quietly count if strlen(raw_lfmnou)>1
if r(N)==0 recast str1 raw_lfmnou
confirm variable raw_ltmnou
quietly count if strlen(raw_ltmnou)>4
if r(N)==0 recast str4 raw_ltmnou
confirm variable raw_lpwltl
quietly count if strlen(raw_lpwltl)>5
if r(N)==0 recast str5 raw_lpwltl
confirm variable raw_lnwltl
quietly count if strlen(raw_lnwltl)>4
if r(N)==0 recast str4 raw_lnwltl
confirm variable raw_lfwnou
quietly count if strlen(raw_lfwnou)>1
if r(N)==0 recast str1 raw_lfwnou
confirm variable raw_ltwnou
quietly count if strlen(raw_ltwnou)>5
if r(N)==0 recast str5 raw_ltwnou
confirm variable raw_lprnou
quietly count if strlen(raw_lprnou)>5
if r(N)==0 recast str5 raw_lprnou
confirm variable raw_lnpnou
quietly count if strlen(raw_lnpnou)>4
if r(N)==0 recast str4 raw_lnpnou
confirm variable raw_lfanou
quietly count if strlen(raw_lfanou)>1
if r(N)==0 recast str1 raw_lfanou
confirm variable raw_ltlnou
quietly count if strlen(raw_ltlnou)>5
if r(N)==0 recast str5 raw_ltlnou
confirm variable raw_zpsvcu
quietly count if strlen(raw_zpsvcu)>9
if r(N)==0 recast str9 raw_zpsvcu
confirm variable raw_znsvcu
quietly count if strlen(raw_znsvcu)>9
if r(N)==0 recast str9 raw_znsvcu
confirm variable raw_zpovcu
quietly count if strlen(raw_zpovcu)>9
if r(N)==0 recast str9 raw_zpovcu
confirm variable raw_znovcu
quietly count if strlen(raw_znovcu)>9
if r(N)==0 recast str9 raw_znovcu
confirm variable raw_zpivcu
quietly count if strlen(raw_zpivcu)>9
if r(N)==0 recast str9 raw_zpivcu
confirm variable raw_field46
quietly count if strlen(raw_field46)>9
if r(N)==0 recast str9 raw_field46
confirm variable raw_zppvcu
quietly count if strlen(raw_zppvcu)>9
if r(N)==0 recast str9 raw_zppvcu
confirm variable raw_znpvcu
quietly count if strlen(raw_znpvcu)>9
if r(N)==0 recast str9 raw_znpvcu
confirm variable raw_zpavcu
quietly count if strlen(raw_zpavcu)>7
if r(N)==0 recast str7 raw_zpavcu
confirm variable raw_znavcu
quietly count if strlen(raw_znavcu)>7
if r(N)==0 recast str7 raw_znavcu
confirm variable raw_zpdvcu
quietly count if strlen(raw_zpdvcu)>9
if r(N)==0 recast str9 raw_zpdvcu
confirm variable raw_zndvcu
quietly count if strlen(raw_zndvcu)>9
if r(N)==0 recast str9 raw_zndvcu
confirm variable raw_epeliu
quietly count if strlen(raw_epeliu)>8
if r(N)==0 recast str8 raw_epeliu
confirm variable raw_epevcu
quietly count if strlen(raw_epevcu)>8
if r(N)==0 recast str8 raw_epevcu
confirm variable raw_epelie
quietly count if strlen(raw_epelie)>6
if r(N)==0 recast str6 raw_epelie
confirm variable raw_epevce
quietly count if strlen(raw_epevce)>7
if r(N)==0 recast str7 raw_epevce
confirm variable raw_esoliu
quietly count if strlen(raw_esoliu)>8
if r(N)==0 recast str8 raw_esoliu
confirm variable raw_esovcu
quietly count if strlen(raw_esovcu)>9
if r(N)==0 recast str9 raw_esovcu
confirm variable raw_esolie
quietly count if strlen(raw_esolie)>8
if r(N)==0 recast str8 raw_esolie
confirm variable raw_esovce
quietly count if strlen(raw_esovce)>9
if r(N)==0 recast str9 raw_esovce
confirm variable raw_eoiliu
quietly count if strlen(raw_eoiliu)>7
if r(N)==0 recast str7 raw_eoiliu
confirm variable raw_eoivcu
quietly count if strlen(raw_eoivcu)>8
if r(N)==0 recast str8 raw_eoivcu
confirm variable raw_eoilie
quietly count if strlen(raw_eoilie)>1
if r(N)==0 recast str1 raw_eoilie
confirm variable raw_eoivce
quietly count if strlen(raw_eoivce)>1
if r(N)==0 recast str1 raw_eoivce
confirm variable raw_eclkgu
quietly count if strlen(raw_eclkgu)>9
if r(N)==0 recast str9 raw_eclkgu
confirm variable raw_eclvcu
quietly count if strlen(raw_eclvcu)>9
if r(N)==0 recast str9 raw_eclvcu
confirm variable raw_eclkge
quietly count if strlen(raw_eclkge)>9
if r(N)==0 recast str9 raw_eclkge
confirm variable raw_eclvce
quietly count if strlen(raw_eclvce)>9
if r(N)==0 recast str9 raw_eclvce
confirm variable raw_r6ek3
quietly count if strlen(raw_r6ek3)>6
if r(N)==0 recast str6 raw_r6ek3
confirm variable raw_r6ek4
quietly count if strlen(raw_r6ek4)>7
if r(N)==0 recast str7 raw_r6ek4
confirm variable raw_r6ek5
quietly count if strlen(raw_r6ek5)>1
if r(N)==0 recast str1 raw_r6ek5
confirm variable raw_r6ek6
quietly count if strlen(raw_r6ek6)>1
if r(N)==0 recast str1 raw_r6ek6
confirm variable raw_egam3u
quietly count if strlen(raw_egam3u)>9
if r(N)==0 recast str9 raw_egam3u
confirm variable raw_egavcu
quietly count if strlen(raw_egavcu)>10
if r(N)==0 recast str10 raw_egavcu
confirm variable raw_egam3e
quietly count if strlen(raw_egam3e)>6
if r(N)==0 recast str6 raw_egam3e
confirm variable raw_egavce
quietly count if strlen(raw_egavce)>7
if r(N)==0 recast str7 raw_egavce
confirm variable raw_r6gk3
quietly count if strlen(raw_r6gk3)>8
if r(N)==0 recast str8 raw_r6gk3
confirm variable raw_r6gk4
quietly count if strlen(raw_r6gk4)>9
if r(N)==0 recast str9 raw_r6gk4
confirm variable raw_r6gk5
quietly count if strlen(raw_r6gk5)>5
if r(N)==0 recast str5 raw_r6gk5
confirm variable raw_r6gk6
quietly count if strlen(raw_r6gk6)>6
if r(N)==0 recast str6 raw_r6gk6
confirm variable raw_elpkgu
quietly count if strlen(raw_elpkgu)>6
if r(N)==0 recast str6 raw_elpkgu
confirm variable raw_elpvcu
quietly count if strlen(raw_elpvcu)>8
if r(N)==0 recast str8 raw_elpvcu
confirm variable raw_elpkge
quietly count if strlen(raw_elpkge)>4
if r(N)==0 recast str4 raw_elpkge
confirm variable raw_elpvce
quietly count if strlen(raw_elpvce)>7
if r(N)==0 recast str7 raw_elpvce
confirm variable raw_encvcu
quietly count if strlen(raw_encvcu)>10
if r(N)==0 recast str10 raw_encvcu
confirm variable raw_encvce
quietly count if strlen(raw_encvce)>8
if r(N)==0 recast str8 raw_encvce
confirm variable raw_eluliu
quietly count if strlen(raw_eluliu)>7
if r(N)==0 recast str7 raw_eluliu
confirm variable raw_eluvcu
quietly count if strlen(raw_eluvcu)>9
if r(N)==0 recast str9 raw_eluvcu
confirm variable raw_elulie
quietly count if strlen(raw_elulie)>6
if r(N)==0 recast str6 raw_elulie
confirm variable raw_eluvce
quietly count if strlen(raw_eluvce)>7
if r(N)==0 recast str7 raw_eluvce
confirm variable raw_efuvcu
quietly count if strlen(raw_efuvcu)>10
if r(N)==0 recast str10 raw_efuvcu
confirm variable raw_efuvce
quietly count if strlen(raw_efuvce)>9
if r(N)==0 recast str9 raw_efuvce
confirm variable raw_mgenou
quietly count if strlen(raw_mgenou)>7
if r(N)==0 recast str7 raw_mgenou
confirm variable raw_mgekwu
quietly count if strlen(raw_mgekwu)>13
if r(N)==0 recast str13 raw_mgekwu
confirm variable raw_eplkhu
quietly count if strlen(raw_eplkhu)>11
if r(N)==0 recast str11 raw_eplkhu
confirm variable raw_eplvcu
quietly count if strlen(raw_eplvcu)>10
if r(N)==0 recast str10 raw_eplvcu
confirm variable raw_enpkhu
quietly count if strlen(raw_enpkhu)>8
if r(N)==0 recast str8 raw_enpkhu
confirm variable raw_enpvcu
quietly count if strlen(raw_enpvcu)>9
if r(N)==0 recast str9 raw_enpvcu
confirm variable raw_esgkhu
quietly count if strlen(raw_esgkhu)>12
if r(N)==0 recast str12 raw_esgkhu
confirm variable raw_oelkhu
quietly count if strlen(raw_oelkhu)>9
if r(N)==0 recast str9 raw_oelkhu
confirm variable raw_yelvcu
quietly count if strlen(raw_yelvcu)>9
if r(N)==0 recast str9 raw_yelvcu
confirm variable raw_ibrvcu
quietly count if strlen(raw_ibrvcu)>9
if r(N)==0 recast str9 raw_ibrvcu
confirm variable raw_ilrvcu
quietly count if strlen(raw_ilrvcu)>8
if r(N)==0 recast str8 raw_ilrvcu
confirm variable raw_itxvcu
quietly count if strlen(raw_itxvcu)>9
if r(N)==0 recast str9 raw_itxvcu
confirm variable raw_iisvcu
quietly count if strlen(raw_iisvcu)>10
if r(N)==0 recast str10 raw_iisvcu
confirm variable raw_iinvcu
quietly count if strlen(raw_iinvcu)>9
if r(N)==0 recast str9 raw_iinvcu
confirm variable raw_icovcu
quietly count if strlen(raw_icovcu)>9
if r(N)==0 recast str9 raw_icovcu
confirm variable raw_irevcu
quietly count if strlen(raw_irevcu)>8
if r(N)==0 recast str8 raw_irevcu
confirm variable raw_iotvcu
quietly count if strlen(raw_iotvcu)>10
if r(N)==0 recast str10 raw_iotvcu
confirm variable raw_it1vcu
quietly count if strlen(raw_it1vcu)>10
if r(N)==0 recast str10 raw_it1vcu
confirm variable raw_rdnvcu
quietly count if strlen(raw_rdnvcu)>10
if r(N)==0 recast str10 raw_rdnvcu
confirm variable raw_rimvcu
quietly count if strlen(raw_rimvcu)>10
if r(N)==0 recast str10 raw_rimvcu
confirm variable raw_rtlvcu
quietly count if strlen(raw_rtlvcu)>10
if r(N)==0 recast str10 raw_rtlvcu
confirm variable raw_ekspor
quietly count if strlen(raw_ekspor)>4
if r(N)==0 recast str4 raw_ekspor
confirm variable raw_yprvcu
quietly count if strlen(raw_yprvcu)>11
if r(N)==0 recast str11 raw_yprvcu
confirm variable raw_prprca
quietly count if strlen(raw_prprca)>6
if r(N)==0 recast str6 raw_prprca
confirm variable raw_r15a
quietly count if strlen(raw_r15a)>10
if r(N)==0 recast str10 raw_r15a
confirm variable raw_r15b
quietly count if strlen(raw_r15b)>9
if r(N)==0 recast str9 raw_r15b
confirm variable raw_yisvcu
quietly count if strlen(raw_yisvcu)>10
if r(N)==0 recast str10 raw_yisvcu
confirm variable raw_yrnvcu
quietly count if strlen(raw_yrnvcu)>11
if r(N)==0 recast str11 raw_yrnvcu
confirm variable raw_yt1vcu
quietly count if strlen(raw_yt1vcu)>11
if r(N)==0 recast str11 raw_yt1vcu
confirm variable raw_srjvcu
quietly count if strlen(raw_srjvcu)>11
if r(N)==0 recast str11 raw_srjvcu
confirm variable raw_srdvcu
quietly count if strlen(raw_srdvcu)>11
if r(N)==0 recast str11 raw_srdvcu
confirm variable raw_srmvcu
quietly count if strlen(raw_srmvcu)>11
if r(N)==0 recast str11 raw_srmvcu
confirm variable raw_shjvcu
quietly count if strlen(raw_shjvcu)>11
if r(N)==0 recast str11 raw_shjvcu
confirm variable raw_shdvcu
quietly count if strlen(raw_shdvcu)>11
if r(N)==0 recast str11 raw_shdvcu
confirm variable raw_shfvcu
quietly count if strlen(raw_shfvcu)>11
if r(N)==0 recast str11 raw_shfvcu
confirm variable raw_sfjvcu
quietly count if strlen(raw_sfjvcu)>11
if r(N)==0 recast str11 raw_sfjvcu
confirm variable raw_sfdvcu
quietly count if strlen(raw_sfdvcu)>11
if r(N)==0 recast str11 raw_sfdvcu
confirm variable raw_sfnvcu
quietly count if strlen(raw_sfnvcu)>11
if r(N)==0 recast str11 raw_sfnvcu
confirm variable raw_stjvcu
quietly count if strlen(raw_stjvcu)>12
if r(N)==0 recast str12 raw_stjvcu
confirm variable raw_stdvcu
quietly count if strlen(raw_stdvcu)>12
if r(N)==0 recast str12 raw_stdvcu
confirm variable raw_stlvcu
quietly count if strlen(raw_stlvcu)>11
if r(N)==0 recast str11 raw_stlvcu
confirm variable raw_clttcu
quietly count if strlen(raw_clttcu)>10
if r(N)==0 recast str10 raw_clttcu
confirm variable raw_clsacu
quietly count if strlen(raw_clsacu)>8
if r(N)==0 recast str8 raw_clsacu
confirm variable raw_v12
quietly count if strlen(raw_v12)>8
if r(N)==0 recast str8 raw_v12
confirm variable raw_v11
quietly count if strlen(raw_v11)>11
if r(N)==0 recast str11 raw_v11
confirm variable raw_cbttcu
quietly count if strlen(raw_cbttcu)>10
if r(N)==0 recast str10 raw_cbttcu
confirm variable raw_cbsacu
quietly count if strlen(raw_cbsacu)>8
if r(N)==0 recast str8 raw_cbsacu
confirm variable raw_v15
quietly count if strlen(raw_v15)>10
if r(N)==0 recast str10 raw_v15
confirm variable raw_v13
quietly count if strlen(raw_v13)>11
if r(N)==0 recast str11 raw_v13
confirm variable raw_cmttcu
quietly count if strlen(raw_cmttcu)>11
if r(N)==0 recast str11 raw_cmttcu
confirm variable raw_cmsacu
quietly count if strlen(raw_cmsacu)>10
if r(N)==0 recast str10 raw_cmsacu
confirm variable raw_v18
quietly count if strlen(raw_v18)>11
if r(N)==0 recast str11 raw_v18
confirm variable raw_v16
quietly count if strlen(raw_v16)>12
if r(N)==0 recast str12 raw_v16
confirm variable raw_cvttcu
quietly count if strlen(raw_cvttcu)>10
if r(N)==0 recast str10 raw_cvttcu
confirm variable raw_cvsacu
quietly count if strlen(raw_cvsacu)>9
if r(N)==0 recast str9 raw_cvsacu
confirm variable raw_v1111
quietly count if strlen(raw_v1111)>9
if r(N)==0 recast str9 raw_v1111
confirm variable raw_v19
quietly count if strlen(raw_v19)>10
if r(N)==0 recast str10 raw_v19
confirm variable raw_cottcu
quietly count if strlen(raw_cottcu)>10
if r(N)==0 recast str10 raw_cottcu
confirm variable raw_cosacu
quietly count if strlen(raw_cosacu)>9
if r(N)==0 recast str9 raw_cosacu
confirm variable raw_v1114
quietly count if strlen(raw_v1114)>9
if r(N)==0 recast str9 raw_v1114
confirm variable raw_cttcu
quietly count if strlen(raw_cttcu)>11
if r(N)==0 recast str11 raw_cttcu
confirm variable raw_ctsacu
quietly count if strlen(raw_ctsacu)>10
if r(N)==0 recast str10 raw_ctsacu
confirm variable raw_v1117
quietly count if strlen(raw_v1117)>11
if r(N)==0 recast str11 raw_v1117
confirm variable raw_pprex2
quietly count if strlen(raw_pprex2)>1
if r(N)==0 recast str1 raw_pprex2
confirm variable raw_vtlvcu15
quietly count if strlen(raw_vtlvcu15)>11
if r(N)==0 recast str11 raw_vtlvcu15
confirm variable raw_output15
quietly count if strlen(raw_output15)>11
if r(N)==0 recast str11 raw_output15
confirm variable raw_iinput15
quietly count if strlen(raw_iinput15)>10
if r(N)==0 recast str10 raw_iinput15
confirm variable raw_flg15
quietly count if strlen(raw_flg15)>1
if r(N)==0 recast str1 raw_flg15
confirm variable raw_psid
quietly count if strlen(raw_psid)>6
if r(N)==0 recast str6 raw_psid
confirm variable raw_dprovi17
quietly count if strlen(raw_dprovi17)>2
if r(N)==0 recast str2 raw_dprovi17
confirm variable raw_dkabup17
quietly count if strlen(raw_dkabup17)>3
if r(N)==0 recast str3 raw_dkabup17
confirm variable raw_nov
quietly count if strlen(raw_nov)>1
if r(N)==0 recast str1 raw_nov
confirm variable raw_disic517
quietly count if strlen(raw_disic517)>5
if r(N)==0 recast str5 raw_disic517
confirm variable raw_dstats17
quietly count if strlen(raw_dstats17)>1
if r(N)==0 recast str1 raw_dstats17
confirm variable raw_dpusat17
quietly count if strlen(raw_dpusat17)>3
if r(N)==0 recast str3 raw_dpusat17
confirm variable raw_dpemda17
quietly count if strlen(raw_dpemda17)>3
if r(N)==0 recast str3 raw_dpemda17
confirm variable raw_ddmstk17
quietly count if strlen(raw_ddmstk17)>14
if r(N)==0 recast str14 raw_ddmstk17
confirm variable raw_dasing17
quietly count if strlen(raw_dasing17)>3
if r(N)==0 recast str3 raw_dasing17
confirm variable raw_iuib17
quietly count if strlen(raw_iuib17)>1
if r(N)==0 recast str1 raw_iuib17
confirm variable raw_iuim17
quietly count if strlen(raw_iuim17)>1
if r(N)==0 recast str1 raw_iuim17
confirm variable raw_iuik17
quietly count if strlen(raw_iuik17)>1
if r(N)==0 recast str1 raw_iuik17
confirm variable raw_tdi17
quietly count if strlen(raw_tdi17)>1
if r(N)==0 recast str1 raw_tdi17
confirm variable raw_tdp17
quietly count if strlen(raw_tdp17)>1
if r(N)==0 recast str1 raw_tdp17
confirm variable raw_izino17
quietly count if strlen(raw_izino17)>1
if r(N)==0 recast str1 raw_izino17
confirm variable raw_izino17k
quietly count if strlen(raw_izino17k)>47
if r(N)==0 recast str47 raw_izino17k
confirm variable raw_sni17
quietly count if strlen(raw_sni17)>1
if r(N)==0 recast str1 raw_sni17
confirm variable raw_snipro17
quietly count if strlen(raw_snipro17)>1
if r(N)==0 recast str1 raw_snipro17
confirm variable raw_sniman17
quietly count if strlen(raw_sniman17)>1
if r(N)==0 recast str1 raw_sniman17
confirm variable raw_snimet17
quietly count if strlen(raw_snimet17)>1
if r(N)==0 recast str1 raw_snimet17
confirm variable raw_snipcs17
quietly count if strlen(raw_snipcs17)>1
if r(N)==0 recast str1 raw_snipcs17
confirm variable raw_snipsn17
quietly count if strlen(raw_snipsn17)>1
if r(N)==0 recast str1 raw_snipsn17
confirm variable raw_bensni17
quietly count if strlen(raw_bensni17)>1
if r(N)==0 recast str1 raw_bensni17
confirm variable raw_concst17
quietly count if strlen(raw_concst17)>1
if r(N)==0 recast str1 raw_concst17
confirm variable raw_consin17
quietly count if strlen(raw_consin17)>1
if r(N)==0 recast str1 raw_consin17
confirm variable raw_coninf17
quietly count if strlen(raw_coninf17)>1
if r(N)==0 recast str1 raw_coninf17
confirm variable raw_fitsni17
quietly count if strlen(raw_fitsni17)>1
if r(N)==0 recast str1 raw_fitsni17
confirm variable raw_demand17
quietly count if strlen(raw_demand17)>1
if r(N)==0 recast str1 raw_demand17
confirm variable raw_rnd17
quietly count if strlen(raw_rnd17)>1
if r(N)==0 recast str1 raw_rnd17
confirm variable raw_costrd17
quietly count if strlen(raw_costrd17)>1
if r(N)==0 recast str1 raw_costrd17
confirm variable raw_inoprd17
quietly count if strlen(raw_inoprd17)>1
if r(N)==0 recast str1 raw_inoprd17
confirm variable raw_inopcs17
quietly count if strlen(raw_inopcs17)>1
if r(N)==0 recast str1 raw_inopcs17
confirm variable raw_inomkt17
quietly count if strlen(raw_inomkt17)>1
if r(N)==0 recast str1 raw_inomkt17
confirm variable raw_inoorg17
quietly count if strlen(raw_inoorg17)>1
if r(N)==0 recast str1 raw_inoorg17
confirm variable raw_lpmnou17
quietly count if strlen(raw_lpmnou17)>4
if r(N)==0 recast str4 raw_lpmnou17
confirm variable raw_lnmnou17
quietly count if strlen(raw_lnmnou17)>4
if r(N)==0 recast str4 raw_lnmnou17
confirm variable raw_lfmnou17
quietly count if strlen(raw_lfmnou17)>2
if r(N)==0 recast str2 raw_lfmnou17
confirm variable raw_ltmnou17
quietly count if strlen(raw_ltmnou17)>4
if r(N)==0 recast str4 raw_ltmnou17
confirm variable raw_lpwnou17
quietly count if strlen(raw_lpwnou17)>4
if r(N)==0 recast str4 raw_lpwnou17
confirm variable raw_lnwnou17
quietly count if strlen(raw_lnwnou17)>3
if r(N)==0 recast str3 raw_lnwnou17
confirm variable raw_lfwnou17
quietly count if strlen(raw_lfwnou17)>2
if r(N)==0 recast str2 raw_lfwnou17
confirm variable raw_ltwnou17
quietly count if strlen(raw_ltwnou17)>4
if r(N)==0 recast str4 raw_ltwnou17
confirm variable raw_lprnou17
quietly count if strlen(raw_lprnou17)>4
if r(N)==0 recast str4 raw_lprnou17
confirm variable raw_lnpnou17
quietly count if strlen(raw_lnpnou17)>4
if r(N)==0 recast str4 raw_lnpnou17
confirm variable raw_lfanou17
quietly count if strlen(raw_lfanou17)>2
if r(N)==0 recast str2 raw_lfanou17
confirm variable raw_ltlnou17
quietly count if strlen(raw_ltlnou17)>5
if r(N)==0 recast str5 raw_ltlnou17
confirm variable raw_ltlrnd17
quietly count if strlen(raw_ltlrnd17)>3
if r(N)==0 recast str3 raw_ltlrnd17
confirm variable raw_zpsvcu17
quietly count if strlen(raw_zpsvcu17)>9
if r(N)==0 recast str9 raw_zpsvcu17
confirm variable raw_znsvcu17
quietly count if strlen(raw_znsvcu17)>9
if r(N)==0 recast str9 raw_znsvcu17
confirm variable raw_zpovcu17
quietly count if strlen(raw_zpovcu17)>9
if r(N)==0 recast str9 raw_zpovcu17
confirm variable raw_znovcu17
quietly count if strlen(raw_znovcu17)>8
if r(N)==0 recast str8 raw_znovcu17
confirm variable raw_zpivcu17
quietly count if strlen(raw_zpivcu17)>8
if r(N)==0 recast str8 raw_zpivcu17
confirm variable raw_znivcu17
quietly count if strlen(raw_znivcu17)>9
if r(N)==0 recast str9 raw_znivcu17
confirm variable raw_zppvcu17
quietly count if strlen(raw_zppvcu17)>8
if r(N)==0 recast str8 raw_zppvcu17
confirm variable raw_znpvcu17
quietly count if strlen(raw_znpvcu17)>9
if r(N)==0 recast str9 raw_znpvcu17
confirm variable raw_zpavcu17
quietly count if strlen(raw_zpavcu17)>7
if r(N)==0 recast str7 raw_zpavcu17
confirm variable raw_znavcu17
quietly count if strlen(raw_znavcu17)>8
if r(N)==0 recast str8 raw_znavcu17
confirm variable raw_zpdvcu17
quietly count if strlen(raw_zpdvcu17)>9
if r(N)==0 recast str9 raw_zpdvcu17
confirm variable raw_zndvcu17
quietly count if strlen(raw_zndvcu17)>9
if r(N)==0 recast str9 raw_zndvcu17
confirm variable raw_epeliu17
quietly count if strlen(raw_epeliu17)>7
if r(N)==0 recast str7 raw_epeliu17
confirm variable raw_epevcu17
quietly count if strlen(raw_epevcu17)>8
if r(N)==0 recast str8 raw_epevcu17
confirm variable raw_epelie17
quietly count if strlen(raw_epelie17)>5
if r(N)==0 recast str5 raw_epelie17
confirm variable raw_epevce17
quietly count if strlen(raw_epevce17)>6
if r(N)==0 recast str6 raw_epevce17
confirm variable raw_esoliu17
quietly count if strlen(raw_esoliu17)>7
if r(N)==0 recast str7 raw_esoliu17
confirm variable raw_esovcu17
quietly count if strlen(raw_esovcu17)>8
if r(N)==0 recast str8 raw_esovcu17
confirm variable raw_esolie17
quietly count if strlen(raw_esolie17)>7
if r(N)==0 recast str7 raw_esolie17
confirm variable raw_esovce17
quietly count if strlen(raw_esovce17)>8
if r(N)==0 recast str8 raw_esovce17
confirm variable raw_eclkgu17
quietly count if strlen(raw_eclkgu17)>9
if r(N)==0 recast str9 raw_eclkgu17
confirm variable raw_eclvcu17
quietly count if strlen(raw_eclvcu17)>9
if r(N)==0 recast str9 raw_eclvcu17
confirm variable raw_eclkge17
quietly count if strlen(raw_eclkge17)>1
if r(N)==0 recast str1 raw_eclkge17
confirm variable raw_eclvce17
quietly count if strlen(raw_eclvce17)>1
if r(N)==0 recast str1 raw_eclvce17
confirm variable raw_ecbkgu17
quietly count if strlen(raw_ecbkgu17)>8
if r(N)==0 recast str8 raw_ecbkgu17
confirm variable raw_ecbvcu17
quietly count if strlen(raw_ecbvcu17)>9
if r(N)==0 recast str9 raw_ecbvcu17
confirm variable raw_ecbkge17
quietly count if strlen(raw_ecbkge17)>1
if r(N)==0 recast str1 raw_ecbkge17
confirm variable raw_ecbvce17
quietly count if strlen(raw_ecbvce17)>1
if r(N)==0 recast str1 raw_ecbvce17
confirm variable raw_egam3u17
quietly count if strlen(raw_egam3u17)>7
if r(N)==0 recast str7 raw_egam3u17
confirm variable raw_egavcu17
quietly count if strlen(raw_egavcu17)>8
if r(N)==0 recast str8 raw_egavcu17
confirm variable raw_egam3e17
quietly count if strlen(raw_egam3e17)>6
if r(N)==0 recast str6 raw_egam3e17
confirm variable raw_egavce17
quietly count if strlen(raw_egavce17)>6
if r(N)==0 recast str6 raw_egavce17
confirm variable raw_egom3u17
quietly count if strlen(raw_egom3u17)>7
if r(N)==0 recast str7 raw_egom3u17
confirm variable raw_egovcu17
quietly count if strlen(raw_egovcu17)>8
if r(N)==0 recast str8 raw_egovcu17
confirm variable raw_egom3e17
quietly count if strlen(raw_egom3e17)>1
if r(N)==0 recast str1 raw_egom3e17
confirm variable raw_egovce17
quietly count if strlen(raw_egovce17)>1
if r(N)==0 recast str1 raw_egovce17
confirm variable raw_elpkgu17
quietly count if strlen(raw_elpkgu17)>7
if r(N)==0 recast str7 raw_elpkgu17
confirm variable raw_elpvcu17
quietly count if strlen(raw_elpvcu17)>8
if r(N)==0 recast str8 raw_elpvcu17
confirm variable raw_elpkge17
quietly count if strlen(raw_elpkge17)>4
if r(N)==0 recast str4 raw_elpkge17
confirm variable raw_elpvce17
quietly count if strlen(raw_elpvce17)>5
if r(N)==0 recast str5 raw_elpvce17
confirm variable raw_encvcu17
quietly count if strlen(raw_encvcu17)>8
if r(N)==0 recast str8 raw_encvcu17
confirm variable raw_encvce17
quietly count if strlen(raw_encvce17)>7
if r(N)==0 recast str7 raw_encvce17
confirm variable raw_eluliu17
quietly count if strlen(raw_eluliu17)>6
if r(N)==0 recast str6 raw_eluliu17
confirm variable raw_eluvcu17
quietly count if strlen(raw_eluvcu17)>8
if r(N)==0 recast str8 raw_eluvcu17
confirm variable raw_elulie17
quietly count if strlen(raw_elulie17)>6
if r(N)==0 recast str6 raw_elulie17
confirm variable raw_eluvce17
quietly count if strlen(raw_eluvce17)>7
if r(N)==0 recast str7 raw_eluvce17
confirm variable raw_efuvcu17
quietly count if strlen(raw_efuvcu17)>10
if r(N)==0 recast str10 raw_efuvcu17
confirm variable raw_efuvce17
quietly count if strlen(raw_efuvce17)>8
if r(N)==0 recast str8 raw_efuvce17
confirm variable raw_eplkhu17
quietly count if strlen(raw_eplkhu17)>9
if r(N)==0 recast str9 raw_eplkhu17
confirm variable raw_eplvcu17
quietly count if strlen(raw_eplvcu17)>9
if r(N)==0 recast str9 raw_eplvcu17
confirm variable raw_enpkhu17
quietly count if strlen(raw_enpkhu17)>8
if r(N)==0 recast str8 raw_enpkhu17
confirm variable raw_enpvcu17
quietly count if strlen(raw_enpvcu17)>9
if r(N)==0 recast str9 raw_enpvcu17
confirm variable raw_mgenou17
quietly count if strlen(raw_mgenou17)>5
if r(N)==0 recast str5 raw_mgenou17
confirm variable raw_mgekwu17
quietly count if strlen(raw_mgekwu17)>10
if r(N)==0 recast str10 raw_mgekwu17
confirm variable raw_esgkhu17
quietly count if strlen(raw_esgkhu17)>8
if r(N)==0 recast str8 raw_esgkhu17
confirm variable raw_oelkhu17
quietly count if strlen(raw_oelkhu17)>7
if r(N)==0 recast str7 raw_oelkhu17
confirm variable raw_yelvcu17
quietly count if strlen(raw_yelvcu17)>8
if r(N)==0 recast str8 raw_yelvcu17
confirm variable raw_ibrvcu17
quietly count if strlen(raw_ibrvcu17)>9
if r(N)==0 recast str9 raw_ibrvcu17
confirm variable raw_ilrvcu17
quietly count if strlen(raw_ilrvcu17)>8
if r(N)==0 recast str8 raw_ilrvcu17
confirm variable raw_itxvcu17
quietly count if strlen(raw_itxvcu17)>9
if r(N)==0 recast str9 raw_itxvcu17
confirm variable raw_iisvcu17
quietly count if strlen(raw_iisvcu17)>9
if r(N)==0 recast str9 raw_iisvcu17
confirm variable raw_iinvcu17
quietly count if strlen(raw_iinvcu17)>9
if r(N)==0 recast str9 raw_iinvcu17
confirm variable raw_icovcu17
quietly count if strlen(raw_icovcu17)>8
if r(N)==0 recast str8 raw_icovcu17
confirm variable raw_irrvcu17
quietly count if strlen(raw_irrvcu17)>9
if r(N)==0 recast str9 raw_irrvcu17
confirm variable raw_idevcu17
quietly count if strlen(raw_idevcu17)>9
if r(N)==0 recast str9 raw_idevcu17
confirm variable raw_iprvcu17
quietly count if strlen(raw_iprvcu17)>8
if r(N)==0 recast str8 raw_iprvcu17
confirm variable raw_irdvcu17
quietly count if strlen(raw_irdvcu17)>7
if r(N)==0 recast str7 raw_irdvcu17
confirm variable raw_ikivcu17
quietly count if strlen(raw_ikivcu17)>8
if r(N)==0 recast str8 raw_ikivcu17
confirm variable raw_iotvcu17
quietly count if strlen(raw_iotvcu17)>10
if r(N)==0 recast str10 raw_iotvcu17
confirm variable raw_it1vcu17
quietly count if strlen(raw_it1vcu17)>10
if r(N)==0 recast str10 raw_it1vcu17
confirm variable raw_rdnvcu17
quietly count if strlen(raw_rdnvcu17)>10
if r(N)==0 recast str10 raw_rdnvcu17
confirm variable raw_rimvcu17
quietly count if strlen(raw_rimvcu17)>10
if r(N)==0 recast str10 raw_rimvcu17
confirm variable raw_rtlvcu17
quietly count if strlen(raw_rtlvcu17)>10
if r(N)==0 recast str10 raw_rtlvcu17
confirm variable raw_ekspor17
quietly count if strlen(raw_ekspor17)>1
if r(N)==0 recast str1 raw_ekspor17
confirm variable raw_yprvcu17
quietly count if strlen(raw_yprvcu17)>11
if r(N)==0 recast str11 raw_yprvcu17
confirm variable raw_prprca17
quietly count if strlen(raw_prprca17)>3
if r(N)==0 recast str3 raw_prprca17
confirm variable raw_yisvdo17
quietly count if strlen(raw_yisvdo17)>10
if r(N)==0 recast str10 raw_yisvdo17
confirm variable raw_yisvfo17
quietly count if strlen(raw_yisvfo17)>9
if r(N)==0 recast str9 raw_yisvfo17
confirm variable raw_yisvcu17
quietly count if strlen(raw_yisvcu17)>10
if r(N)==0 recast str10 raw_yisvcu17
confirm variable raw_yrnvcu17
quietly count if strlen(raw_yrnvcu17)>17
if r(N)==0 recast str17 raw_yrnvcu17
confirm variable raw_yt1vcu17
quietly count if strlen(raw_yt1vcu17)>17
if r(N)==0 recast str17 raw_yt1vcu17
confirm variable raw_devvcu17
quietly count if strlen(raw_devvcu17)>10
if r(N)==0 recast str10 raw_devvcu17
confirm variable raw_intvcu17
quietly count if strlen(raw_intvcu17)>11
if r(N)==0 recast str11 raw_intvcu17
confirm variable raw_renvcu17
quietly count if strlen(raw_renvcu17)>8
if r(N)==0 recast str8 raw_renvcu17
confirm variable raw_insvcu17
quietly count if strlen(raw_insvcu17)>7
if r(N)==0 recast str7 raw_insvcu17
confirm variable raw_nopvcu17
quietly count if strlen(raw_nopvcu17)>11
if r(N)==0 recast str11 raw_nopvcu17
confirm variable raw_srjvcu17
quietly count if strlen(raw_srjvcu17)>10
if r(N)==0 recast str10 raw_srjvcu17
confirm variable raw_srdvcu17
quietly count if strlen(raw_srdvcu17)>11
if r(N)==0 recast str11 raw_srdvcu17
confirm variable raw_shjvcu17
quietly count if strlen(raw_shjvcu17)>10
if r(N)==0 recast str10 raw_shjvcu17
confirm variable raw_shdvcu17
quietly count if strlen(raw_shdvcu17)>10
if r(N)==0 recast str10 raw_shdvcu17
confirm variable raw_sfjvcu17
quietly count if strlen(raw_sfjvcu17)>10
if r(N)==0 recast str10 raw_sfjvcu17
confirm variable raw_sfdvcu17
quietly count if strlen(raw_sfdvcu17)>10
if r(N)==0 recast str10 raw_sfdvcu17
confirm variable raw_stjvcu17
quietly count if strlen(raw_stjvcu17)>11
if r(N)==0 recast str11 raw_stjvcu17
confirm variable raw_stdvcu17
quietly count if strlen(raw_stdvcu17)>11
if r(N)==0 recast str11 raw_stdvcu17
confirm variable raw_clttcu17
quietly count if strlen(raw_clttcu17)>10
if r(N)==0 recast str10 raw_clttcu17
confirm variable raw_clsacu17
quietly count if strlen(raw_clsacu17)>8
if r(N)==0 recast str8 raw_clsacu17
confirm variable raw_cldacu17
quietly count if strlen(raw_cldacu17)>7
if r(N)==0 recast str7 raw_cldacu17
confirm variable raw_cbttcu17
quietly count if strlen(raw_cbttcu17)>10
if r(N)==0 recast str10 raw_cbttcu17
confirm variable raw_cbsacu17
quietly count if strlen(raw_cbsacu17)>8
if r(N)==0 recast str8 raw_cbsacu17
confirm variable raw_cbdacu17
quietly count if strlen(raw_cbdacu17)>10
if r(N)==0 recast str10 raw_cbdacu17
confirm variable raw_cmttcu17
quietly count if strlen(raw_cmttcu17)>10
if r(N)==0 recast str10 raw_cmttcu17
confirm variable raw_cmsacu17
quietly count if strlen(raw_cmsacu17)>10
if r(N)==0 recast str10 raw_cmsacu17
confirm variable raw_cmdacu17
quietly count if strlen(raw_cmdacu17)>10
if r(N)==0 recast str10 raw_cmdacu17
confirm variable raw_cvttcu17
quietly count if strlen(raw_cvttcu17)>9
if r(N)==0 recast str9 raw_cvttcu17
confirm variable raw_cvsacu17
quietly count if strlen(raw_cvsacu17)>9
if r(N)==0 recast str9 raw_cvsacu17
confirm variable raw_cvdacu17
quietly count if strlen(raw_cvdacu17)>9
if r(N)==0 recast str9 raw_cvdacu17
confirm variable raw_csttcu17
quietly count if strlen(raw_csttcu17)>10
if r(N)==0 recast str10 raw_csttcu17
confirm variable raw_cssacu17
quietly count if strlen(raw_cssacu17)>7
if r(N)==0 recast str7 raw_cssacu17
confirm variable raw_csdacu17
quietly count if strlen(raw_csdacu17)>8
if r(N)==0 recast str8 raw_csdacu17
confirm variable raw_v1110
quietly count if strlen(raw_v1110)>10
if r(N)==0 recast str10 raw_v1110
confirm variable raw_cottcu17
quietly count if strlen(raw_cottcu17)>9
if r(N)==0 recast str9 raw_cottcu17
confirm variable raw_cosacu17
quietly count if strlen(raw_cosacu17)>10
if r(N)==0 recast str10 raw_cosacu17
confirm variable raw_codacu17
quietly count if strlen(raw_codacu17)>10
if r(N)==0 recast str10 raw_codacu17
confirm variable raw_ctttcu17
quietly count if strlen(raw_ctttcu17)>11
if r(N)==0 recast str11 raw_ctttcu17
confirm variable raw_ctsacu17
quietly count if strlen(raw_ctsacu17)>10
if r(N)==0 recast str10 raw_ctsacu17
confirm variable raw_ctdacu17
quietly count if strlen(raw_ctdacu17)>11
if r(N)==0 recast str11 raw_ctdacu17
confirm variable raw_srmvcu17
quietly count if strlen(raw_srmvcu17)>11
if r(N)==0 recast str11 raw_srmvcu17
confirm variable raw_shfvcu17
quietly count if strlen(raw_shfvcu17)>9
if r(N)==0 recast str9 raw_shfvcu17
confirm variable raw_sfnvcu17
quietly count if strlen(raw_sfnvcu17)>11
if r(N)==0 recast str11 raw_sfnvcu17
confirm variable raw_stlvcu17
quietly count if strlen(raw_stlvcu17)>11
if r(N)==0 recast str11 raw_stlvcu17
confirm variable raw_iinput17
quietly count if strlen(raw_iinput17)>10
if r(N)==0 recast str10 raw_iinput17
confirm variable raw_output17
quietly count if strlen(raw_output17)>11
if r(N)==0 recast str11 raw_output17
confirm variable raw_vtlvcu17
quietly count if strlen(raw_vtlvcu17)>17
if r(N)==0 recast str17 raw_vtlvcu17
confirm variable raw_disic417
quietly count if strlen(raw_disic417)>4
if r(N)==0 recast str4 raw_disic417
confirm variable raw_number
quietly count if strlen(raw_number)>5
if r(N)==0 recast str5 raw_number
confirm variable raw_dprovi18
quietly count if strlen(raw_dprovi18)>2
if r(N)==0 recast str2 raw_dprovi18
confirm variable raw_dkabup18
quietly count if strlen(raw_dkabup18)>3
if r(N)==0 recast str3 raw_dkabup18
confirm variable raw_dkecam18
quietly count if strlen(raw_dkecam18)>3
if r(N)==0 recast str3 raw_dkecam18
confirm variable raw_ddesa18
quietly count if strlen(raw_ddesa18)>3
if r(N)==0 recast str3 raw_ddesa18
confirm variable raw_dbs18
quietly count if strlen(raw_dbs18)>4
if r(N)==0 recast str4 raw_dbs18
confirm variable raw_nama18
quietly count if strlen(raw_nama18)>3
if r(N)==0 recast str3 raw_nama18
confirm variable raw_alamat18
quietly count if strlen(raw_alamat18)>3
if r(N)==0 recast str3 raw_alamat18
confirm variable raw_kdpos18
quietly count if strlen(raw_kdpos18)>3
if r(N)==0 recast str3 raw_kdpos18
confirm variable raw_rtrw18
quietly count if strlen(raw_rtrw18)>7
if r(N)==0 recast str7 raw_rtrw18
confirm variable raw_email18
quietly count if strlen(raw_email18)>3
if r(N)==0 recast str3 raw_email18
confirm variable raw_wiltel18
quietly count if strlen(raw_wiltel18)>10
if r(N)==0 recast str10 raw_wiltel18
confirm variable raw_tlp18
quietly count if strlen(raw_tlp18)>3
if r(N)==0 recast str3 raw_tlp18
confirm variable raw_wilfax18
quietly count if strlen(raw_wilfax18)>3
if r(N)==0 recast str3 raw_wilfax18
confirm variable raw_fax18
quietly count if strlen(raw_fax18)>3
if r(N)==0 recast str3 raw_fax18
confirm variable raw_kpusat18
quietly count if strlen(raw_kpusat18)>3
if r(N)==0 recast str3 raw_kpusat18
confirm variable raw_kdpos18p
quietly count if strlen(raw_kdpos18p)>3
if r(N)==0 recast str3 raw_kdpos18p
confirm variable raw_rtrw18p
quietly count if strlen(raw_rtrw18p)>3
if r(N)==0 recast str3 raw_rtrw18p
confirm variable raw_email18p
quietly count if strlen(raw_email18p)>3
if r(N)==0 recast str3 raw_email18p
confirm variable raw_wltel18p
quietly count if strlen(raw_wltel18p)>5
if r(N)==0 recast str5 raw_wltel18p
confirm variable raw_tlp18p
quietly count if strlen(raw_tlp18p)>3
if r(N)==0 recast str3 raw_tlp18p
confirm variable raw_wlfax18p
quietly count if strlen(raw_wlfax18p)>3
if r(N)==0 recast str3 raw_wlfax18p
confirm variable raw_fax18p
quietly count if strlen(raw_fax18p)>3
if r(N)==0 recast str3 raw_fax18p
confirm variable raw_locati18
quietly count if strlen(raw_locati18)>1
if r(N)==0 recast str1 raw_locati18
confirm variable raw_disic518
quietly count if strlen(raw_disic518)>5
if r(N)==0 recast str5 raw_disic518
confirm variable raw_dstats18
quietly count if strlen(raw_dstats18)>1
if r(N)==0 recast str1 raw_dstats18
confirm variable raw_dpusat18
quietly count if strlen(raw_dpusat18)>3
if r(N)==0 recast str3 raw_dpusat18
confirm variable raw_dpemda18
quietly count if strlen(raw_dpemda18)>12
if r(N)==0 recast str12 raw_dpemda18
confirm variable raw_ddmstk18
quietly count if strlen(raw_ddmstk18)>17
if r(N)==0 recast str17 raw_ddmstk18
confirm variable raw_dasing18
quietly count if strlen(raw_dasing18)>17
if r(N)==0 recast str17 raw_dasing18
confirm variable raw_nameown1
quietly count if strlen(raw_nameown1)>52
if r(N)==0 recast str52 raw_nameown1
confirm variable raw_controw1
quietly count if strlen(raw_controw1)>3
if r(N)==0 recast str3 raw_controw1
confirm variable raw_busines1
quietly count if strlen(raw_busines1)>47
if r(N)==0 recast str47 raw_busines1
confirm variable raw_stockow1
quietly count if strlen(raw_stockow1)>17
if r(N)==0 recast str17 raw_stockow1
confirm variable raw_nameown2
quietly count if strlen(raw_nameown2)>39
if r(N)==0 recast str39 raw_nameown2
confirm variable raw_controw2
quietly count if strlen(raw_controw2)>3
if r(N)==0 recast str3 raw_controw2
confirm variable raw_busines2
quietly count if strlen(raw_busines2)>43
if r(N)==0 recast str43 raw_busines2
confirm variable raw_stockow2
quietly count if strlen(raw_stockow2)>17
if r(N)==0 recast str17 raw_stockow2
confirm variable raw_nameown3
quietly count if strlen(raw_nameown3)>26
if r(N)==0 recast str26 raw_nameown3
confirm variable raw_controw3
quietly count if strlen(raw_controw3)>3
if r(N)==0 recast str3 raw_controw3
confirm variable raw_busines3
quietly count if strlen(raw_busines3)>21
if r(N)==0 recast str21 raw_busines3
confirm variable raw_stockow3
quietly count if strlen(raw_stockow3)>2
if r(N)==0 recast str2 raw_stockow3
confirm variable raw_nameown4
quietly count if strlen(raw_nameown4)>23
if r(N)==0 recast str23 raw_nameown4
confirm variable raw_controw4
quietly count if strlen(raw_controw4)>3
if r(N)==0 recast str3 raw_controw4
confirm variable raw_busines4
quietly count if strlen(raw_busines4)>21
if r(N)==0 recast str21 raw_busines4
confirm variable raw_stockow4
quietly count if strlen(raw_stockow4)>2
if r(N)==0 recast str2 raw_stockow4
confirm variable raw_nameown5
quietly count if strlen(raw_nameown5)>1
if r(N)==0 recast str1 raw_nameown5
confirm variable raw_controw5
quietly count if strlen(raw_controw5)>1
if r(N)==0 recast str1 raw_controw5
confirm variable raw_busines5
quietly count if strlen(raw_busines5)>1
if r(N)==0 recast str1 raw_busines5
confirm variable raw_stockow5
quietly count if strlen(raw_stockow5)>2
if r(N)==0 recast str2 raw_stockow5
confirm variable raw_prrmsm18
quietly count if strlen(raw_prrmsm18)>3
if r(N)==0 recast str3 raw_prrmsm18
confirm variable raw_prrmsp18
quietly count if strlen(raw_prrmsp18)>3
if r(N)==0 recast str3 raw_prrmsp18
confirm variable raw_prrmop18
quietly count if strlen(raw_prrmop18)>3
if r(N)==0 recast str3 raw_prrmop18
confirm variable raw_prrmoc18
quietly count if strlen(raw_prrmoc18)>3
if r(N)==0 recast str3 raw_prrmoc18
confirm variable raw_pryrsm18
quietly count if strlen(raw_pryrsm18)>3
if r(N)==0 recast str3 raw_pryrsm18
confirm variable raw_pryrsp18
quietly count if strlen(raw_pryrsp18)>3
if r(N)==0 recast str3 raw_pryrsp18
confirm variable raw_pryrop18
quietly count if strlen(raw_pryrop18)>3
if r(N)==0 recast str3 raw_pryrop18
confirm variable raw_pryroc18
quietly count if strlen(raw_pryroc18)>3
if r(N)==0 recast str3 raw_pryroc18
confirm variable raw_pryrsg18
quietly count if strlen(raw_pryrsg18)>3
if r(N)==0 recast str3 raw_pryrsg18
confirm variable raw_pryrom18
quietly count if strlen(raw_pryrom18)>3
if r(N)==0 recast str3 raw_pryrom18
confirm variable raw_pryrwh18
quietly count if strlen(raw_pryrwh18)>3
if r(N)==0 recast str3 raw_pryrwh18
confirm variable raw_pryrin18
quietly count if strlen(raw_pryrin18)>3
if r(N)==0 recast str3 raw_pryrin18
confirm variable raw_pryrot18
quietly count if strlen(raw_pryrot18)>3
if r(N)==0 recast str3 raw_pryrot18
confirm variable raw_pryrod18
quietly count if strlen(raw_pryrod18)>50
if r(N)==0 recast str50 raw_pryrod18
confirm variable raw_sni18
quietly count if strlen(raw_sni18)>1
if r(N)==0 recast str1 raw_sni18
confirm variable raw_snipro18
quietly count if strlen(raw_snipro18)>1
if r(N)==0 recast str1 raw_snipro18
confirm variable raw_sniman18
quietly count if strlen(raw_sniman18)>1
if r(N)==0 recast str1 raw_sniman18
confirm variable raw_snioth18
quietly count if strlen(raw_snioth18)>1
if r(N)==0 recast str1 raw_snioth18
confirm variable raw_rnd18
quietly count if strlen(raw_rnd18)>1
if r(N)==0 recast str1 raw_rnd18
confirm variable raw_costrd18
quietly count if strlen(raw_costrd18)>1
if r(N)==0 recast str1 raw_costrd18
confirm variable raw_inoprd18
quietly count if strlen(raw_inoprd18)>1
if r(N)==0 recast str1 raw_inoprd18
confirm variable raw_inopcs18
quietly count if strlen(raw_inopcs18)>1
if r(N)==0 recast str1 raw_inopcs18
confirm variable raw_inomkt18
quietly count if strlen(raw_inomkt18)>1
if r(N)==0 recast str1 raw_inomkt18
confirm variable raw_inoorg18
quietly count if strlen(raw_inoorg18)>1
if r(N)==0 recast str1 raw_inoorg18
confirm variable raw_lpmnol18
quietly count if strlen(raw_lpmnol18)>5
if r(N)==0 recast str5 raw_lpmnol18
confirm variable raw_lpmnof18
quietly count if strlen(raw_lpmnof18)>2
if r(N)==0 recast str2 raw_lpmnof18
confirm variable raw_lnmnol18
quietly count if strlen(raw_lnmnol18)>4
if r(N)==0 recast str4 raw_lnmnol18
confirm variable raw_lnmnof18
quietly count if strlen(raw_lnmnof18)>2
if r(N)==0 recast str2 raw_lnmnof18
confirm variable raw_lfmnou18
quietly count if strlen(raw_lfmnou18)>1
if r(N)==0 recast str1 raw_lfmnou18
confirm variable raw_ltmnou18
quietly count if strlen(raw_ltmnou18)>5
if r(N)==0 recast str5 raw_ltmnou18
confirm variable raw_lpwnol18
quietly count if strlen(raw_lpwnol18)>4
if r(N)==0 recast str4 raw_lpwnol18
confirm variable raw_lpwnof18
quietly count if strlen(raw_lpwnof18)>2
if r(N)==0 recast str2 raw_lpwnof18
confirm variable raw_lnwnol18
quietly count if strlen(raw_lnwnol18)>3
if r(N)==0 recast str3 raw_lnwnol18
confirm variable raw_lnwnof18
quietly count if strlen(raw_lnwnof18)>1
if r(N)==0 recast str1 raw_lnwnof18
confirm variable raw_lfwnou18
quietly count if strlen(raw_lfwnou18)>1
if r(N)==0 recast str1 raw_lfwnou18
confirm variable raw_ltwnou18
quietly count if strlen(raw_ltwnou18)>4
if r(N)==0 recast str4 raw_ltwnou18
confirm variable raw_lprnol18
quietly count if strlen(raw_lprnol18)>5
if r(N)==0 recast str5 raw_lprnol18
confirm variable raw_lprnof18
quietly count if strlen(raw_lprnof18)>2
if r(N)==0 recast str2 raw_lprnof18
confirm variable raw_lnpnol18
quietly count if strlen(raw_lnpnol18)>4
if r(N)==0 recast str4 raw_lnpnol18
confirm variable raw_lnpnof18
quietly count if strlen(raw_lnpnof18)>2
if r(N)==0 recast str2 raw_lnpnof18
confirm variable raw_lfanou18
quietly count if strlen(raw_lfanou18)>1
if r(N)==0 recast str1 raw_lfanou18
confirm variable raw_ltlnou18
quietly count if strlen(raw_ltlnou18)>5
if r(N)==0 recast str5 raw_ltlnou18
confirm variable raw_ltlrnd18
quietly count if strlen(raw_ltlrnd18)>3
if r(N)==0 recast str3 raw_ltlrnd18
confirm variable raw_zpsvcu18
quietly count if strlen(raw_zpsvcu18)>9
if r(N)==0 recast str9 raw_zpsvcu18
confirm variable raw_znsvcu18
quietly count if strlen(raw_znsvcu18)>9
if r(N)==0 recast str9 raw_znsvcu18
confirm variable raw_zpovcu18
quietly count if strlen(raw_zpovcu18)>8
if r(N)==0 recast str8 raw_zpovcu18
confirm variable raw_znovcu18
quietly count if strlen(raw_znovcu18)>8
if r(N)==0 recast str8 raw_znovcu18
confirm variable raw_zpivcu18
quietly count if strlen(raw_zpivcu18)>9
if r(N)==0 recast str9 raw_zpivcu18
confirm variable raw_znivcu18
quietly count if strlen(raw_znivcu18)>8
if r(N)==0 recast str8 raw_znivcu18
confirm variable raw_zppvcu18
quietly count if strlen(raw_zppvcu18)>9
if r(N)==0 recast str9 raw_zppvcu18
confirm variable raw_znpvcu18
quietly count if strlen(raw_znpvcu18)>9
if r(N)==0 recast str9 raw_znpvcu18
confirm variable raw_zpavcu18
quietly count if strlen(raw_zpavcu18)>8
if r(N)==0 recast str8 raw_zpavcu18
confirm variable raw_znavcu18
quietly count if strlen(raw_znavcu18)>8
if r(N)==0 recast str8 raw_znavcu18
confirm variable raw_zpdvcu18
quietly count if strlen(raw_zpdvcu18)>9
if r(N)==0 recast str9 raw_zpdvcu18
confirm variable raw_zndvcu18
quietly count if strlen(raw_zndvcu18)>9
if r(N)==0 recast str9 raw_zndvcu18
confirm variable raw_epeliu18
quietly count if strlen(raw_epeliu18)>8
if r(N)==0 recast str8 raw_epeliu18
confirm variable raw_epevcu18
quietly count if strlen(raw_epevcu18)>9
if r(N)==0 recast str9 raw_epevcu18
confirm variable raw_epelie18
quietly count if strlen(raw_epelie18)>6
if r(N)==0 recast str6 raw_epelie18
confirm variable raw_epevce18
quietly count if strlen(raw_epevce18)>7
if r(N)==0 recast str7 raw_epevce18
confirm variable raw_esoliu18
quietly count if strlen(raw_esoliu18)>8
if r(N)==0 recast str8 raw_esoliu18
confirm variable raw_esovcu18
quietly count if strlen(raw_esovcu18)>9
if r(N)==0 recast str9 raw_esovcu18
confirm variable raw_esolie18
quietly count if strlen(raw_esolie18)>7
if r(N)==0 recast str7 raw_esolie18
confirm variable raw_esovce18
quietly count if strlen(raw_esovce18)>8
if r(N)==0 recast str8 raw_esovce18
confirm variable raw_eclkgu18
quietly count if strlen(raw_eclkgu18)>8
if r(N)==0 recast str8 raw_eclkgu18
confirm variable raw_eclvcu18
quietly count if strlen(raw_eclvcu18)>10
if r(N)==0 recast str10 raw_eclvcu18
confirm variable raw_eclkge18
quietly count if strlen(raw_eclkge18)>8
if r(N)==0 recast str8 raw_eclkge18
confirm variable raw_eclvce18
quietly count if strlen(raw_eclvce18)>9
if r(N)==0 recast str9 raw_eclvce18
confirm variable raw_ecbkgu18
quietly count if strlen(raw_ecbkgu18)>7
if r(N)==0 recast str7 raw_ecbkgu18
confirm variable raw_ecbvcu18
quietly count if strlen(raw_ecbvcu18)>8
if r(N)==0 recast str8 raw_ecbvcu18
confirm variable raw_egam3u18
quietly count if strlen(raw_egam3u18)>8
if r(N)==0 recast str8 raw_egam3u18
confirm variable raw_egavcu18
quietly count if strlen(raw_egavcu18)>9
if r(N)==0 recast str9 raw_egavcu18
confirm variable raw_egam3e18
quietly count if strlen(raw_egam3e18)>8
if r(N)==0 recast str8 raw_egam3e18
confirm variable raw_egavce18
quietly count if strlen(raw_egavce18)>9
if r(N)==0 recast str9 raw_egavce18
confirm variable raw_egom3u18
quietly count if strlen(raw_egom3u18)>7
if r(N)==0 recast str7 raw_egom3u18
confirm variable raw_egovcu18
quietly count if strlen(raw_egovcu18)>9
if r(N)==0 recast str9 raw_egovcu18
confirm variable raw_egom3e18
quietly count if strlen(raw_egom3e18)>5
if r(N)==0 recast str5 raw_egom3e18
confirm variable raw_egovce18
quietly count if strlen(raw_egovce18)>7
if r(N)==0 recast str7 raw_egovce18
confirm variable raw_elpkgu18
quietly count if strlen(raw_elpkgu18)>7
if r(N)==0 recast str7 raw_elpkgu18
confirm variable raw_elpvcu18
quietly count if strlen(raw_elpvcu18)>8
if r(N)==0 recast str8 raw_elpvcu18
confirm variable raw_encvcu18
quietly count if strlen(raw_encvcu18)>9
if r(N)==0 recast str9 raw_encvcu18
confirm variable raw_eluliu18
quietly count if strlen(raw_eluliu18)>6
if r(N)==0 recast str6 raw_eluliu18
confirm variable raw_eluvcu18
quietly count if strlen(raw_eluvcu18)>8
if r(N)==0 recast str8 raw_eluvcu18
confirm variable raw_elulie18
quietly count if strlen(raw_elulie18)>6
if r(N)==0 recast str6 raw_elulie18
confirm variable raw_eluvce18
quietly count if strlen(raw_eluvce18)>7
if r(N)==0 recast str7 raw_eluvce18
confirm variable raw_efuvcu18
quietly count if strlen(raw_efuvcu18)>10
if r(N)==0 recast str10 raw_efuvcu18
confirm variable raw_efuvce18
quietly count if strlen(raw_efuvce18)>9
if r(N)==0 recast str9 raw_efuvce18
confirm variable raw_eplkhu18
quietly count if strlen(raw_eplkhu18)>10
if r(N)==0 recast str10 raw_eplkhu18
confirm variable raw_eplvcu18
quietly count if strlen(raw_eplvcu18)>10
if r(N)==0 recast str10 raw_eplvcu18
confirm variable raw_enpkhu18
quietly count if strlen(raw_enpkhu18)>8
if r(N)==0 recast str8 raw_enpkhu18
confirm variable raw_enpvcu18
quietly count if strlen(raw_enpvcu18)>9
if r(N)==0 recast str9 raw_enpvcu18
confirm variable raw_esgkhu18
quietly count if strlen(raw_esgkhu18)>8
if r(N)==0 recast str8 raw_esgkhu18
confirm variable raw_mgenou18
quietly count if strlen(raw_mgenou18)>5
if r(N)==0 recast str5 raw_mgenou18
confirm variable raw_mgekwu18
quietly count if strlen(raw_mgekwu18)>9
if r(N)==0 recast str9 raw_mgekwu18
confirm variable raw_oelkhu18
quietly count if strlen(raw_oelkhu18)>9
if r(N)==0 recast str9 raw_oelkhu18
confirm variable raw_yelvcu18
quietly count if strlen(raw_yelvcu18)>10
if r(N)==0 recast str10 raw_yelvcu18
confirm variable raw_ibrvcu18
quietly count if strlen(raw_ibrvcu18)>9
if r(N)==0 recast str9 raw_ibrvcu18
confirm variable raw_ilrvcu18
quietly count if strlen(raw_ilrvcu18)>8
if r(N)==0 recast str8 raw_ilrvcu18
confirm variable raw_itxvcu18
quietly count if strlen(raw_itxvcu18)>9
if r(N)==0 recast str9 raw_itxvcu18
confirm variable raw_iislov18
quietly count if strlen(raw_iislov18)>9
if r(N)==0 recast str9 raw_iislov18
confirm variable raw_iisfov18
quietly count if strlen(raw_iisfov18)>9
if r(N)==0 recast str9 raw_iisfov18
confirm variable raw_iinvcu18
quietly count if strlen(raw_iinvcu18)>9
if r(N)==0 recast str9 raw_iinvcu18
confirm variable raw_icovcu18
quietly count if strlen(raw_icovcu18)>8
if r(N)==0 recast str8 raw_icovcu18
confirm variable raw_irrvcu18
quietly count if strlen(raw_irrvcu18)>9
if r(N)==0 recast str9 raw_irrvcu18
confirm variable raw_idevcu18
quietly count if strlen(raw_idevcu18)>8
if r(N)==0 recast str8 raw_idevcu18
confirm variable raw_iprvcu18
quietly count if strlen(raw_iprvcu18)>8
if r(N)==0 recast str8 raw_iprvcu18
confirm variable raw_irdvcu18
quietly count if strlen(raw_irdvcu18)>9
if r(N)==0 recast str9 raw_irdvcu18
confirm variable raw_ikivcu18
quietly count if strlen(raw_ikivcu18)>8
if r(N)==0 recast str8 raw_ikivcu18
confirm variable raw_iotvcu18
quietly count if strlen(raw_iotvcu18)>17
if r(N)==0 recast str17 raw_iotvcu18
confirm variable raw_it1vcu18
quietly count if strlen(raw_it1vcu18)>17
if r(N)==0 recast str17 raw_it1vcu18
confirm variable raw_rdnvcu18
quietly count if strlen(raw_rdnvcu18)>11
if r(N)==0 recast str11 raw_rdnvcu18
confirm variable raw_rimvcu18
quietly count if strlen(raw_rimvcu18)>10
if r(N)==0 recast str10 raw_rimvcu18
confirm variable raw_rtlvcu18
quietly count if strlen(raw_rtlvcu18)>11
if r(N)==0 recast str11 raw_rtlvcu18
confirm variable raw_ekspor18
quietly count if strlen(raw_ekspor18)>1
if r(N)==0 recast str1 raw_ekspor18
confirm variable raw_exsrtl18
quietly count if strlen(raw_exsrtl18)>1
if r(N)==0 recast str1 raw_exsrtl18
confirm variable raw_yprvcu18
quietly count if strlen(raw_yprvcu18)>17
if r(N)==0 recast str17 raw_yprvcu18
confirm variable raw_prprca18
quietly count if strlen(raw_prprca18)>6
if r(N)==0 recast str6 raw_prprca18
confirm variable raw_yisvdo18
quietly count if strlen(raw_yisvdo18)>10
if r(N)==0 recast str10 raw_yisvdo18
confirm variable raw_yisvfo18
quietly count if strlen(raw_yisvfo18)>10
if r(N)==0 recast str10 raw_yisvfo18
confirm variable raw_yisvcu18
quietly count if strlen(raw_yisvcu18)>10
if r(N)==0 recast str10 raw_yisvcu18
confirm variable raw_yrnvcu18
quietly count if strlen(raw_yrnvcu18)>17
if r(N)==0 recast str17 raw_yrnvcu18
confirm variable raw_yt1vcu18
quietly count if strlen(raw_yt1vcu18)>17
if r(N)==0 recast str17 raw_yt1vcu18
confirm variable raw_devvcu18
quietly count if strlen(raw_devvcu18)>9
if r(N)==0 recast str9 raw_devvcu18
confirm variable raw_intvcu18
quietly count if strlen(raw_intvcu18)>10
if r(N)==0 recast str10 raw_intvcu18
confirm variable raw_renvcu18
quietly count if strlen(raw_renvcu18)>9
if r(N)==0 recast str9 raw_renvcu18
confirm variable raw_insvcu18
quietly count if strlen(raw_insvcu18)>8
if r(N)==0 recast str8 raw_insvcu18
confirm variable raw_nopvcu18
quietly count if strlen(raw_nopvcu18)>10
if r(N)==0 recast str10 raw_nopvcu18
confirm variable raw_srjvcu18
quietly count if strlen(raw_srjvcu18)>9
if r(N)==0 recast str9 raw_srjvcu18
confirm variable raw_srdvcu18
quietly count if strlen(raw_srdvcu18)>10
if r(N)==0 recast str10 raw_srdvcu18
confirm variable raw_shjvcu18
quietly count if strlen(raw_shjvcu18)>9
if r(N)==0 recast str9 raw_shjvcu18
confirm variable raw_shdvcu18
quietly count if strlen(raw_shdvcu18)>11
if r(N)==0 recast str11 raw_shdvcu18
confirm variable raw_sfjvcu18
quietly count if strlen(raw_sfjvcu18)>9
if r(N)==0 recast str9 raw_sfjvcu18
confirm variable raw_sfdvcu18
quietly count if strlen(raw_sfdvcu18)>9
if r(N)==0 recast str9 raw_sfdvcu18
confirm variable raw_stjvcu18
quietly count if strlen(raw_stjvcu18)>10
if r(N)==0 recast str10 raw_stjvcu18
confirm variable raw_stdvcu18
quietly count if strlen(raw_stdvcu18)>11
if r(N)==0 recast str11 raw_stdvcu18
confirm variable raw_clttcu18
quietly count if strlen(raw_clttcu18)>11
if r(N)==0 recast str11 raw_clttcu18
confirm variable raw_clsacu18
quietly count if strlen(raw_clsacu18)>7
if r(N)==0 recast str7 raw_clsacu18
confirm variable raw_cbttcu18
quietly count if strlen(raw_cbttcu18)>11
if r(N)==0 recast str11 raw_cbttcu18
confirm variable raw_cbsacu18
quietly count if strlen(raw_cbsacu18)>9
if r(N)==0 recast str9 raw_cbsacu18
confirm variable raw_cbdacu18
quietly count if strlen(raw_cbdacu18)>10
if r(N)==0 recast str10 raw_cbdacu18
confirm variable raw_cmttcu18
quietly count if strlen(raw_cmttcu18)>11
if r(N)==0 recast str11 raw_cmttcu18
confirm variable raw_cmsacu18
quietly count if strlen(raw_cmsacu18)>9
if r(N)==0 recast str9 raw_cmsacu18
confirm variable raw_cmdacu18
quietly count if strlen(raw_cmdacu18)>10
if r(N)==0 recast str10 raw_cmdacu18
confirm variable raw_cvttcu18
quietly count if strlen(raw_cvttcu18)>10
if r(N)==0 recast str10 raw_cvttcu18
confirm variable raw_cvsacu18
quietly count if strlen(raw_cvsacu18)>10
if r(N)==0 recast str10 raw_cvsacu18
confirm variable raw_cvdacu18
quietly count if strlen(raw_cvdacu18)>10
if r(N)==0 recast str10 raw_cvdacu18
confirm variable raw_csttcu18
quietly count if strlen(raw_csttcu18)>8
if r(N)==0 recast str8 raw_csttcu18
confirm variable raw_cssacu18
quietly count if strlen(raw_cssacu18)>6
if r(N)==0 recast str6 raw_cssacu18
confirm variable raw_cottcu18
quietly count if strlen(raw_cottcu18)>9
if r(N)==0 recast str9 raw_cottcu18
confirm variable raw_cosacu18
quietly count if strlen(raw_cosacu18)>9
if r(N)==0 recast str9 raw_cosacu18
confirm variable raw_codacu18
quietly count if strlen(raw_codacu18)>9
if r(N)==0 recast str9 raw_codacu18
confirm variable raw_ctttcu18
quietly count if strlen(raw_ctttcu18)>11
if r(N)==0 recast str11 raw_ctttcu18
confirm variable raw_ctsacu18
quietly count if strlen(raw_ctsacu18)>10
if r(N)==0 recast str10 raw_ctsacu18
confirm variable raw_ctdacu18
quietly count if strlen(raw_ctdacu18)>10
if r(N)==0 recast str10 raw_ctdacu18
confirm variable raw_p7r32a
quietly count if strlen(raw_p7r32a)>54
if r(N)==0 recast str54 raw_p7r32a
confirm variable raw_p7r32p
quietly count if strlen(raw_p7r32p)>45
if r(N)==0 recast str45 raw_p7r32p
confirm variable raw_p7r32c
quietly count if strlen(raw_p7r32c)>23
if r(N)==0 recast str23 raw_p7r32c
confirm variable raw_p7r32d
quietly count if strlen(raw_p7r32d)>18
if r(N)==0 recast str18 raw_p7r32d
confirm variable raw_p7r32e
quietly count if strlen(raw_p7r32e)>49
if r(N)==0 recast str49 raw_p7r32e
confirm variable raw_p7r32f
quietly count if strlen(raw_p7r32f)>1
if r(N)==0 recast str1 raw_p7r32f
confirm variable raw_p7r32gda
quietly count if strlen(raw_p7r32gda)>2
if r(N)==0 recast str2 raw_p7r32gda
confirm variable raw_p7r32gmo
quietly count if strlen(raw_p7r32gmo)>2
if r(N)==0 recast str2 raw_p7r32gmo
confirm variable raw_p7r32gye
quietly count if strlen(raw_p7r32gye)>4
if r(N)==0 recast str4 raw_p7r32gye
confirm variable raw_p7r33a
quietly count if strlen(raw_p7r33a)>31
if r(N)==0 recast str31 raw_p7r33a
confirm variable raw_p7r33b
quietly count if strlen(raw_p7r33b)>37
if r(N)==0 recast str37 raw_p7r33b
confirm variable raw_p7r33c
quietly count if strlen(raw_p7r33c)>1
if r(N)==0 recast str1 raw_p7r33c
confirm variable raw_p8
quietly count if strlen(raw_p8)>200
if r(N)==0 recast str200 raw_p8
confirm variable raw_p9r34a
quietly count if strlen(raw_p9r34a)>9
if r(N)==0 recast str9 raw_p9r34a
confirm variable raw_p9r34b
quietly count if strlen(raw_p9r34b)>10
if r(N)==0 recast str10 raw_p9r34b
confirm variable raw_p9r34c
quietly count if strlen(raw_p9r34c)>9
if r(N)==0 recast str9 raw_p9r34c
confirm variable raw_p9r34d
quietly count if strlen(raw_p9r34d)>9
if r(N)==0 recast str9 raw_p9r34d
confirm variable raw_p9r34e
quietly count if strlen(raw_p9r34e)>11
if r(N)==0 recast str11 raw_p9r34e
confirm variable raw_p9r34sum
quietly count if strlen(raw_p9r34sum)>11
if r(N)==0 recast str11 raw_p9r34sum
confirm variable raw_p9r35a
quietly count if strlen(raw_p9r35a)>8
if r(N)==0 recast str8 raw_p9r35a
confirm variable raw_p9r35b
quietly count if strlen(raw_p9r35b)>11
if r(N)==0 recast str11 raw_p9r35b
confirm variable raw_p9r35c
quietly count if strlen(raw_p9r35c)>10
if r(N)==0 recast str10 raw_p9r35c
confirm variable raw_p9r35d
quietly count if strlen(raw_p9r35d)>10
if r(N)==0 recast str10 raw_p9r35d
confirm variable raw_p9r35e
quietly count if strlen(raw_p9r35e)>11
if r(N)==0 recast str11 raw_p9r35e
confirm variable raw_p9r35sum
quietly count if strlen(raw_p9r35sum)>11
if r(N)==0 recast str11 raw_p9r35sum
confirm variable raw_p9r36a1
quietly count if strlen(raw_p9r36a1)>8
if r(N)==0 recast str8 raw_p9r36a1
confirm variable raw_p9r36a2
quietly count if strlen(raw_p9r36a2)>9
if r(N)==0 recast str9 raw_p9r36a2
confirm variable raw_p9r36a3
quietly count if strlen(raw_p9r36a3)>9
if r(N)==0 recast str9 raw_p9r36a3
confirm variable raw_p9r36a4
quietly count if strlen(raw_p9r36a4)>8
if r(N)==0 recast str8 raw_p9r36a4
confirm variable raw_p9r36a5
quietly count if strlen(raw_p9r36a5)>8
if r(N)==0 recast str8 raw_p9r36a5
confirm variable raw_p9r36asu
quietly count if strlen(raw_p9r36asu)>9
if r(N)==0 recast str9 raw_p9r36asu
confirm variable raw_p9r36b
quietly count if strlen(raw_p9r36b)>10
if r(N)==0 recast str10 raw_p9r36b
confirm variable raw_p10r37
quietly count if strlen(raw_p10r37)>29
if r(N)==0 recast str29 raw_p10r37
confirm variable raw_p10r38
quietly count if strlen(raw_p10r38)>45
if r(N)==0 recast str45 raw_p10r38
confirm variable raw_p10r39da
quietly count if strlen(raw_p10r39da)>2
if r(N)==0 recast str2 raw_p10r39da
confirm variable raw_p10r39mo
quietly count if strlen(raw_p10r39mo)>2
if r(N)==0 recast str2 raw_p10r39mo
confirm variable raw_p10r39ye
quietly count if strlen(raw_p10r39ye)>4
if r(N)==0 recast str4 raw_p10r39ye
confirm variable raw_p10r40
quietly count if strlen(raw_p10r40)>1
if r(N)==0 recast str1 raw_p10r40
confirm variable raw_statusd
quietly count if strlen(raw_statusd)>1
if r(N)==0 recast str1 raw_statusd
confirm variable raw_operat1
quietly count if strlen(raw_operat1)>11
if r(N)==0 recast str11 raw_operat1
confirm variable raw_operat2
quietly count if strlen(raw_operat2)>11
if r(N)==0 recast str11 raw_operat2
confirm variable raw_operat3
quietly count if strlen(raw_operat3)>11
if r(N)==0 recast str11 raw_operat3
confirm variable raw_jmlent
quietly count if strlen(raw_jmlent)>3
if r(N)==0 recast str3 raw_jmlent
confirm variable raw_datecre
quietly count if strlen(raw_datecre)>26
if r(N)==0 recast str26 raw_datecre
confirm variable raw_datemod
quietly count if strlen(raw_datemod)>19
if r(N)==0 recast str19 raw_datemod
confirm variable raw_tahuns
quietly count if strlen(raw_tahuns)>4
if r(N)==0 recast str4 raw_tahuns
confirm variable raw_field1x
quietly count if strlen(raw_field1x)>128
if r(N)==0 recast str128 raw_field1x
confirm variable raw_field2x
quietly count if strlen(raw_field2x)>36
if r(N)==0 recast str36 raw_field2x
confirm variable raw_field3x
quietly count if strlen(raw_field3x)>1
if r(N)==0 recast str1 raw_field3x
confirm variable raw_field4x
quietly count if strlen(raw_field4x)>1
if r(N)==0 recast str1 raw_field4x
confirm variable raw_field5x
quietly count if strlen(raw_field5x)>1
if r(N)==0 recast str1 raw_field5x
confirm variable raw_keadaan
quietly count if strlen(raw_keadaan)>1
if r(N)==0 recast str1 raw_keadaan
confirm variable raw_alasan
quietly count if strlen(raw_alasan)>1
if r(N)==0 recast str1 raw_alasan
confirm variable raw_bltutup
quietly count if strlen(raw_bltutup)>2
if r(N)==0 recast str2 raw_bltutup
confirm variable raw_thtutup
quietly count if strlen(raw_thtutup)>4
if r(N)==0 recast str4 raw_thtutup
confirm variable raw_output18
quietly count if strlen(raw_output18)>11
if r(N)==0 recast str11 raw_output18
confirm variable raw_iinput18
quietly count if strlen(raw_iinput18)>17
if r(N)==0 recast str17 raw_iinput18
confirm variable raw_vtlvcu18
quietly count if strlen(raw_vtlvcu18)>17
if r(N)==0 recast str17 raw_vtlvcu18
confirm variable raw_pengtk18
quietly count if strlen(raw_pengtk18)>9
if r(N)==0 recast str9 raw_pengtk18
confirm variable raw_flg18
quietly count if strlen(raw_flg18)>1
if r(N)==0 recast str1 raw_flg18
confirm variable raw_shfvcu18
quietly count if strlen(raw_shfvcu18)>11
if r(N)==0 recast str11 raw_shfvcu18
confirm variable raw_srmvcu18
quietly count if strlen(raw_srmvcu18)>10
if r(N)==0 recast str10 raw_srmvcu18
confirm variable raw_sfnvcu18
quietly count if strlen(raw_sfnvcu18)>10
if r(N)==0 recast str10 raw_sfnvcu18
confirm variable raw_stlvcu18
quietly count if strlen(raw_stlvcu18)>11
if r(N)==0 recast str11 raw_stlvcu18
confirm variable raw_prprex18
quietly count if strlen(raw_prprex18)>17
if r(N)==0 recast str17 raw_prprex18
confirm variable raw_iisvcu18
quietly count if strlen(raw_iisvcu18)>9
if r(N)==0 recast str9 raw_iisvcu18
confirm variable raw_lpmnou18
quietly count if strlen(raw_lpmnou18)>5
if r(N)==0 recast str5 raw_lpmnou18
confirm variable raw_lpwnou18
quietly count if strlen(raw_lpwnou18)>4
if r(N)==0 recast str4 raw_lpwnou18
confirm variable raw_lnmnou18
quietly count if strlen(raw_lnmnou18)>4
if r(N)==0 recast str4 raw_lnmnou18
confirm variable raw_lnwnou18
quietly count if strlen(raw_lnwnou18)>3
if r(N)==0 recast str3 raw_lnwnou18
confirm variable raw_lprnou18
quietly count if strlen(raw_lprnou18)>5
if r(N)==0 recast str5 raw_lprnou18
confirm variable raw_lnpnou18
quietly count if strlen(raw_lnpnou18)>4
if r(N)==0 recast str4 raw_lnpnou18
confirm variable raw_dprovi19
quietly count if strlen(raw_dprovi19)>2
if r(N)==0 recast str2 raw_dprovi19
confirm variable raw_dkabup19
quietly count if strlen(raw_dkabup19)>3
if r(N)==0 recast str3 raw_dkabup19
confirm variable raw_dkecam19
quietly count if strlen(raw_dkecam19)>3
if r(N)==0 recast str3 raw_dkecam19
confirm variable raw_ddesa19
quietly count if strlen(raw_ddesa19)>3
if r(N)==0 recast str3 raw_ddesa19
confirm variable raw_dbs19
quietly count if strlen(raw_dbs19)>1
if r(N)==0 recast str1 raw_dbs19
confirm variable raw_nama19
quietly count if strlen(raw_nama19)>3
if r(N)==0 recast str3 raw_nama19
confirm variable raw_alamat19
quietly count if strlen(raw_alamat19)>3
if r(N)==0 recast str3 raw_alamat19
confirm variable raw_drt19
quietly count if strlen(raw_drt19)>3
if r(N)==0 recast str3 raw_drt19
confirm variable raw_drw19
quietly count if strlen(raw_drw19)>3
if r(N)==0 recast str3 raw_drw19
confirm variable raw_kdpos19
quietly count if strlen(raw_kdpos19)>3
if r(N)==0 recast str3 raw_kdpos19
confirm variable raw_email19
quietly count if strlen(raw_email19)>3
if r(N)==0 recast str3 raw_email19
confirm variable raw_websit19
quietly count if strlen(raw_websit19)>3
if r(N)==0 recast str3 raw_websit19
confirm variable raw_wiltel19
quietly count if strlen(raw_wiltel19)>6
if r(N)==0 recast str6 raw_wiltel19
confirm variable raw_tlp19
quietly count if strlen(raw_tlp19)>3
if r(N)==0 recast str3 raw_tlp19
confirm variable raw_wilfax19
quietly count if strlen(raw_wilfax19)>3
if r(N)==0 recast str3 raw_wilfax19
confirm variable raw_fax19
quietly count if strlen(raw_fax19)>3
if r(N)==0 recast str3 raw_fax19
confirm variable raw_kpusat19
quietly count if strlen(raw_kpusat19)>3
if r(N)==0 recast str3 raw_kpusat19
confirm variable raw_alpus19
quietly count if strlen(raw_alpus19)>3
if r(N)==0 recast str3 raw_alpus19
confirm variable raw_drtpus19
quietly count if strlen(raw_drtpus19)>3
if r(N)==0 recast str3 raw_drtpus19
confirm variable raw_drwpus19
quietly count if strlen(raw_drwpus19)>3
if r(N)==0 recast str3 raw_drwpus19
confirm variable raw_kdposp19
quietly count if strlen(raw_kdposp19)>3
if r(N)==0 recast str3 raw_kdposp19
confirm variable raw_email19p
quietly count if strlen(raw_email19p)>3
if r(N)==0 recast str3 raw_email19p
confirm variable raw_web19p
quietly count if strlen(raw_web19p)>3
if r(N)==0 recast str3 raw_web19p
confirm variable raw_wltel19p
quietly count if strlen(raw_wltel19p)>5
if r(N)==0 recast str5 raw_wltel19p
confirm variable raw_tlppus19
quietly count if strlen(raw_tlppus19)>3
if r(N)==0 recast str3 raw_tlppus19
confirm variable raw_wlfax19p
quietly count if strlen(raw_wlfax19p)>3
if r(N)==0 recast str3 raw_wlfax19p
confirm variable raw_faxpus19
quietly count if strlen(raw_faxpus19)>3
if r(N)==0 recast str3 raw_faxpus19
confirm variable raw_disic519
quietly count if strlen(raw_disic519)>5
if r(N)==0 recast str5 raw_disic519
confirm variable raw_dpusat19
quietly count if strlen(raw_dpusat19)>3
if r(N)==0 recast str3 raw_dpusat19
confirm variable raw_dpemda19
quietly count if strlen(raw_dpemda19)>3
if r(N)==0 recast str3 raw_dpemda19
confirm variable raw_ddmstk19
quietly count if strlen(raw_ddmstk19)>12
if r(N)==0 recast str12 raw_ddmstk19
confirm variable raw_dasing19
quietly count if strlen(raw_dasing19)>11
if r(N)==0 recast str11 raw_dasing19
confirm variable raw_pryrsg19
quietly count if strlen(raw_pryrsg19)>3
if r(N)==0 recast str3 raw_pryrsg19
confirm variable raw_pryrom19
quietly count if strlen(raw_pryrom19)>3
if r(N)==0 recast str3 raw_pryrom19
confirm variable raw_pryrwh19
quietly count if strlen(raw_pryrwh19)>3
if r(N)==0 recast str3 raw_pryrwh19
confirm variable raw_pryrre19
quietly count if strlen(raw_pryrre19)>3
if r(N)==0 recast str3 raw_pryrre19
confirm variable raw_pryrin19
quietly count if strlen(raw_pryrin19)>3
if r(N)==0 recast str3 raw_pryrin19
confirm variable raw_pryrot19
quietly count if strlen(raw_pryrot19)>3
if r(N)==0 recast str3 raw_pryrot19
confirm variable raw_pryrod19
quietly count if strlen(raw_pryrod19)>1
if r(N)==0 recast str1 raw_pryrod19
confirm variable raw_sni19
quietly count if strlen(raw_sni19)>1
if r(N)==0 recast str1 raw_sni19
confirm variable raw_rnd19
quietly count if strlen(raw_rnd19)>1
if r(N)==0 recast str1 raw_rnd19
confirm variable raw_costrd19
quietly count if strlen(raw_costrd19)>1
if r(N)==0 recast str1 raw_costrd19
confirm variable raw_lpmnol19
quietly count if strlen(raw_lpmnol19)>4
if r(N)==0 recast str4 raw_lpmnol19
confirm variable raw_lpmnof19
quietly count if strlen(raw_lpmnof19)>2
if r(N)==0 recast str2 raw_lpmnof19
confirm variable raw_lnmnol19
quietly count if strlen(raw_lnmnol19)>4
if r(N)==0 recast str4 raw_lnmnol19
confirm variable raw_lnmnof19
quietly count if strlen(raw_lnmnof19)>2
if r(N)==0 recast str2 raw_lnmnof19
confirm variable raw_lfmnou19
quietly count if strlen(raw_lfmnou19)>1
if r(N)==0 recast str1 raw_lfmnou19
confirm variable raw_ltmnou19
quietly count if strlen(raw_ltmnou19)>4
if r(N)==0 recast str4 raw_ltmnou19
confirm variable raw_lpwnol19
quietly count if strlen(raw_lpwnol19)>5
if r(N)==0 recast str5 raw_lpwnol19
confirm variable raw_lpwnof19
quietly count if strlen(raw_lpwnof19)>2
if r(N)==0 recast str2 raw_lpwnof19
confirm variable raw_lnwnol19
quietly count if strlen(raw_lnwnol19)>3
if r(N)==0 recast str3 raw_lnwnol19
confirm variable raw_lnwnof19
quietly count if strlen(raw_lnwnof19)>2
if r(N)==0 recast str2 raw_lnwnof19
confirm variable raw_lfwnou19
quietly count if strlen(raw_lfwnou19)>1
if r(N)==0 recast str1 raw_lfwnou19
confirm variable raw_ltwnou19
quietly count if strlen(raw_ltwnou19)>5
if r(N)==0 recast str5 raw_ltwnou19
confirm variable raw_lprnol19
quietly count if strlen(raw_lprnol19)>5
if r(N)==0 recast str5 raw_lprnol19
confirm variable raw_lprnof19
quietly count if strlen(raw_lprnof19)>2
if r(N)==0 recast str2 raw_lprnof19
confirm variable raw_lnpnol19
quietly count if strlen(raw_lnpnol19)>4
if r(N)==0 recast str4 raw_lnpnol19
confirm variable raw_lnpnof19
quietly count if strlen(raw_lnpnof19)>2
if r(N)==0 recast str2 raw_lnpnof19
confirm variable raw_lfanou19
quietly count if strlen(raw_lfanou19)>1
if r(N)==0 recast str1 raw_lfanou19
confirm variable raw_ltlnou19
quietly count if strlen(raw_ltlnou19)>5
if r(N)==0 recast str5 raw_ltlnou19
confirm variable raw_kategori
quietly count if strlen(raw_kategori)>1
if r(N)==0 recast str1 raw_kategori
confirm variable raw_ltlrnd19
quietly count if strlen(raw_ltlrnd19)>3
if r(N)==0 recast str3 raw_ltlrnd19
confirm variable raw_zptvcu19
quietly count if strlen(raw_zptvcu19)>9
if r(N)==0 recast str9 raw_zptvcu19
confirm variable raw_zntvcu19
quietly count if strlen(raw_zntvcu19)>9
if r(N)==0 recast str9 raw_zntvcu19
confirm variable raw_zpevcu19
quietly count if strlen(raw_zpevcu19)>9
if r(N)==0 recast str9 raw_zpevcu19
confirm variable raw_znevcu19
quietly count if strlen(raw_znevcu19)>8
if r(N)==0 recast str8 raw_znevcu19
confirm variable raw_zphvcu19
quietly count if strlen(raw_zphvcu19)>8
if r(N)==0 recast str8 raw_zphvcu19
confirm variable raw_znhvcu19
quietly count if strlen(raw_znhvcu19)>8
if r(N)==0 recast str8 raw_znhvcu19
confirm variable raw_zprvcu19
quietly count if strlen(raw_zprvcu19)>8
if r(N)==0 recast str8 raw_zprvcu19
confirm variable raw_znrvcu19
quietly count if strlen(raw_znrvcu19)>8
if r(N)==0 recast str8 raw_znrvcu19
confirm variable raw_zpdvcu19
quietly count if strlen(raw_zpdvcu19)>9
if r(N)==0 recast str9 raw_zpdvcu19
confirm variable raw_zndvcu19
quietly count if strlen(raw_zndvcu19)>9
if r(N)==0 recast str9 raw_zndvcu19
confirm variable raw_epeliu19
quietly count if strlen(raw_epeliu19)>7
if r(N)==0 recast str7 raw_epeliu19
confirm variable raw_epevcu19
quietly count if strlen(raw_epevcu19)>8
if r(N)==0 recast str8 raw_epevcu19
confirm variable raw_epelie19
quietly count if strlen(raw_epelie19)>7
if r(N)==0 recast str7 raw_epelie19
confirm variable raw_epevce19
quietly count if strlen(raw_epevce19)>8
if r(N)==0 recast str8 raw_epevce19
confirm variable raw_esoliu19
quietly count if strlen(raw_esoliu19)>8
if r(N)==0 recast str8 raw_esoliu19
confirm variable raw_esovcu19
quietly count if strlen(raw_esovcu19)>9
if r(N)==0 recast str9 raw_esovcu19
confirm variable raw_esolie19
quietly count if strlen(raw_esolie19)>7
if r(N)==0 recast str7 raw_esolie19
confirm variable raw_esovce19
quietly count if strlen(raw_esovce19)>8
if r(N)==0 recast str8 raw_esovce19
confirm variable raw_eclkgu19
quietly count if strlen(raw_eclkgu19)>9
if r(N)==0 recast str9 raw_eclkgu19
confirm variable raw_eclvcu19
quietly count if strlen(raw_eclvcu19)>9
if r(N)==0 recast str9 raw_eclvcu19
confirm variable raw_eclkge19
quietly count if strlen(raw_eclkge19)>8
if r(N)==0 recast str8 raw_eclkge19
confirm variable raw_eclvce19
quietly count if strlen(raw_eclvce19)>9
if r(N)==0 recast str9 raw_eclvce19
confirm variable raw_ecbkgu19
quietly count if strlen(raw_ecbkgu19)>7
if r(N)==0 recast str7 raw_ecbkgu19
confirm variable raw_ecbvcu19
quietly count if strlen(raw_ecbvcu19)>7
if r(N)==0 recast str7 raw_ecbvcu19
confirm variable raw_ecbkge19
quietly count if strlen(raw_ecbkge19)>3
if r(N)==0 recast str3 raw_ecbkge19
confirm variable raw_ecbvce19
quietly count if strlen(raw_ecbvce19)>4
if r(N)==0 recast str4 raw_ecbvce19
confirm variable raw_egam3u19
quietly count if strlen(raw_egam3u19)>8
if r(N)==0 recast str8 raw_egam3u19
confirm variable raw_egavcu19
quietly count if strlen(raw_egavcu19)>8
if r(N)==0 recast str8 raw_egavcu19
confirm variable raw_egam3e19
quietly count if strlen(raw_egam3e19)>5
if r(N)==0 recast str5 raw_egam3e19
confirm variable raw_egavce19
quietly count if strlen(raw_egavce19)>7
if r(N)==0 recast str7 raw_egavce19
confirm variable raw_egom3u19
quietly count if strlen(raw_egom3u19)>7
if r(N)==0 recast str7 raw_egom3u19
confirm variable raw_egovcu19
quietly count if strlen(raw_egovcu19)>8
if r(N)==0 recast str8 raw_egovcu19
confirm variable raw_egom3e19
quietly count if strlen(raw_egom3e19)>6
if r(N)==0 recast str6 raw_egom3e19
confirm variable raw_egovce19
quietly count if strlen(raw_egovce19)>7
if r(N)==0 recast str7 raw_egovce19
confirm variable raw_elpkgu19
quietly count if strlen(raw_elpkgu19)>7
if r(N)==0 recast str7 raw_elpkgu19
confirm variable raw_elpvcu19
quietly count if strlen(raw_elpvcu19)>8
if r(N)==0 recast str8 raw_elpvcu19
confirm variable raw_elpkge19
quietly count if strlen(raw_elpkge19)>4
if r(N)==0 recast str4 raw_elpkge19
confirm variable raw_elpvce19
quietly count if strlen(raw_elpvce19)>5
if r(N)==0 recast str5 raw_elpvce19
confirm variable raw_encdes19
quietly count if strlen(raw_encdes19)>39
if r(N)==0 recast str39 raw_encdes19
confirm variable raw_encvcu19
quietly count if strlen(raw_encvcu19)>8
if r(N)==0 recast str8 raw_encvcu19
confirm variable raw_encvce19
quietly count if strlen(raw_encvce19)>7
if r(N)==0 recast str7 raw_encvce19
confirm variable raw_eluliu19
quietly count if strlen(raw_eluliu19)>7
if r(N)==0 recast str7 raw_eluliu19
confirm variable raw_eluvcu19
quietly count if strlen(raw_eluvcu19)>9
if r(N)==0 recast str9 raw_eluvcu19
confirm variable raw_elulie19
quietly count if strlen(raw_elulie19)>5
if r(N)==0 recast str5 raw_elulie19
confirm variable raw_eluvce19
quietly count if strlen(raw_eluvce19)>6
if r(N)==0 recast str6 raw_eluvce19
confirm variable raw_efuvcu19
quietly count if strlen(raw_efuvcu19)>9
if r(N)==0 recast str9 raw_efuvcu19
confirm variable raw_efuvce19
quietly count if strlen(raw_efuvce19)>9
if r(N)==0 recast str9 raw_efuvce19
confirm variable raw_epckva19
quietly count if strlen(raw_epckva19)>10
if r(N)==0 recast str10 raw_epckva19
confirm variable raw_eplkhu19
quietly count if strlen(raw_eplkhu19)>9
if r(N)==0 recast str9 raw_eplkhu19
confirm variable raw_eplvcu19
quietly count if strlen(raw_eplvcu19)>9
if r(N)==0 recast str9 raw_eplvcu19
confirm variable raw_enpkhu19
quietly count if strlen(raw_enpkhu19)>8
if r(N)==0 recast str8 raw_enpkhu19
confirm variable raw_enpvcu19
quietly count if strlen(raw_enpvcu19)>9
if r(N)==0 recast str9 raw_enpvcu19
confirm variable raw_mgenou19
quietly count if strlen(raw_mgenou19)>2
if r(N)==0 recast str2 raw_mgenou19
confirm variable raw_mgekwu19
quietly count if strlen(raw_mgekwu19)>8
if r(N)==0 recast str8 raw_mgekwu19
confirm variable raw_esgkhu19
quietly count if strlen(raw_esgkhu19)>9
if r(N)==0 recast str9 raw_esgkhu19
confirm variable raw_oelkhu19
quietly count if strlen(raw_oelkhu19)>8
if r(N)==0 recast str8 raw_oelkhu19
confirm variable raw_yelvcu19
quietly count if strlen(raw_yelvcu19)>9
if r(N)==0 recast str9 raw_yelvcu19
confirm variable raw_ibrvcu19
quietly count if strlen(raw_ibrvcu19)>10
if r(N)==0 recast str10 raw_ibrvcu19
confirm variable raw_ilrvcu19
quietly count if strlen(raw_ilrvcu19)>8
if r(N)==0 recast str8 raw_ilrvcu19
confirm variable raw_itxvcu19
quietly count if strlen(raw_itxvcu19)>8
if r(N)==0 recast str8 raw_itxvcu19
confirm variable raw_iislov19
quietly count if strlen(raw_iislov19)>9
if r(N)==0 recast str9 raw_iislov19
confirm variable raw_iisfov19
quietly count if strlen(raw_iisfov19)>9
if r(N)==0 recast str9 raw_iisfov19
confirm variable raw_iisfmc19
quietly count if strlen(raw_iisfmc19)>3
if r(N)==0 recast str3 raw_iisfmc19
confirm variable raw_iisfmp19
quietly count if strlen(raw_iisfmp19)>3
if r(N)==0 recast str3 raw_iisfmp19
confirm variable raw_iisfmo19
quietly count if strlen(raw_iisfmo19)>1
if r(N)==0 recast str1 raw_iisfmo19
confirm variable raw_iinvcu19
quietly count if strlen(raw_iinvcu19)>8
if r(N)==0 recast str8 raw_iinvcu19
confirm variable raw_icovcu19
quietly count if strlen(raw_icovcu19)>8
if r(N)==0 recast str8 raw_icovcu19
confirm variable raw_irrvcu19
quietly count if strlen(raw_irrvcu19)>7
if r(N)==0 recast str7 raw_irrvcu19
confirm variable raw_idevcu19
quietly count if strlen(raw_idevcu19)>8
if r(N)==0 recast str8 raw_idevcu19
confirm variable raw_iprvcu19
quietly count if strlen(raw_iprvcu19)>7
if r(N)==0 recast str7 raw_iprvcu19
confirm variable raw_irdvcu19
quietly count if strlen(raw_irdvcu19)>9
if r(N)==0 recast str9 raw_irdvcu19
confirm variable raw_iklvcu19
quietly count if strlen(raw_iklvcu19)>7
if r(N)==0 recast str7 raw_iklvcu19
confirm variable raw_ikovcu19
quietly count if strlen(raw_ikovcu19)>7
if r(N)==0 recast str7 raw_ikovcu19
confirm variable raw_ikivmc19
quietly count if strlen(raw_ikivmc19)>3
if r(N)==0 recast str3 raw_ikivmc19
confirm variable raw_ikivmp19
quietly count if strlen(raw_ikivmp19)>3
if r(N)==0 recast str3 raw_ikivmp19
confirm variable raw_ikivmo19
quietly count if strlen(raw_ikivmo19)>3
if r(N)==0 recast str3 raw_ikivmo19
confirm variable raw_iotvcu19
quietly count if strlen(raw_iotvcu19)>10
if r(N)==0 recast str10 raw_iotvcu19
confirm variable raw_it1vcu19
quietly count if strlen(raw_it1vcu19)>10
if r(N)==0 recast str10 raw_it1vcu19
confirm variable raw_rdnvcu19
quietly count if strlen(raw_rdnvcu19)>11
if r(N)==0 recast str11 raw_rdnvcu19
confirm variable raw_rimvcu19
quietly count if strlen(raw_rimvcu19)>10
if r(N)==0 recast str10 raw_rimvcu19
confirm variable raw_rtlvcu19
quietly count if strlen(raw_rtlvcu19)>11
if r(N)==0 recast str11 raw_rtlvcu19
confirm variable raw_namrtl
quietly count if strlen(raw_namrtl)>137
if r(N)==0 recast str137 raw_namrtl
confirm variable raw_pr1rtl
quietly count if strlen(raw_pr1rtl)>3
if r(N)==0 recast str3 raw_pr1rtl
confirm variable raw_prov1rtl
quietly count if strlen(raw_prov1rtl)>2
if r(N)==0 recast str2 raw_prov1rtl
confirm variable raw_pprv1rtl
quietly count if strlen(raw_pprv1rtl)>17
if r(N)==0 recast str17 raw_pprv1rtl
confirm variable raw_prov2rtl
quietly count if strlen(raw_prov2rtl)>2
if r(N)==0 recast str2 raw_prov2rtl
confirm variable raw_pprv2rtl
quietly count if strlen(raw_pprv2rtl)>17
if r(N)==0 recast str17 raw_pprv2rtl
confirm variable raw_prov3rtl
quietly count if strlen(raw_prov3rtl)>5
if r(N)==0 recast str5 raw_prov3rtl
confirm variable raw_pprv3rtl
quietly count if strlen(raw_pprv3rtl)>5
if r(N)==0 recast str5 raw_pprv3rtl
confirm variable raw_pprvortl
quietly count if strlen(raw_pprvortl)>17
if r(N)==0 recast str17 raw_pprvortl
confirm variable raw_ekspor19
quietly count if strlen(raw_ekspor19)>1
if r(N)==0 recast str1 raw_ekspor19
confirm variable raw_exsrtl19
quietly count if strlen(raw_exsrtl19)>1
if r(N)==0 recast str1 raw_exsrtl19
confirm variable raw_yprvcu19
quietly count if strlen(raw_yprvcu19)>11
if r(N)==0 recast str11 raw_yprvcu19
confirm variable raw_namypr
quietly count if strlen(raw_namypr)>100
if r(N)==0 recast str100 raw_namypr
confirm variable raw_pr1ypr
quietly count if strlen(raw_pr1ypr)>3
if r(N)==0 recast str3 raw_pr1ypr
confirm variable raw_prov1ypr
quietly count if strlen(raw_prov1ypr)>2
if r(N)==0 recast str2 raw_prov1ypr
confirm variable raw_pprv1ypr
quietly count if strlen(raw_pprv1ypr)>17
if r(N)==0 recast str17 raw_pprv1ypr
confirm variable raw_prov2ypr
quietly count if strlen(raw_prov2ypr)>2
if r(N)==0 recast str2 raw_prov2ypr
confirm variable raw_pprv2ypr
quietly count if strlen(raw_pprv2ypr)>17
if r(N)==0 recast str17 raw_pprv2ypr
confirm variable raw_prov3ypr
quietly count if strlen(raw_prov3ypr)>5
if r(N)==0 recast str5 raw_prov3ypr
confirm variable raw_pprv3ypr
quietly count if strlen(raw_pprv3ypr)>17
if r(N)==0 recast str17 raw_pprv3ypr
confirm variable raw_pprvoypr
quietly count if strlen(raw_pprvoypr)>17
if r(N)==0 recast str17 raw_pprvoypr
confirm variable raw_prprca19
quietly count if strlen(raw_prprca19)>11
if r(N)==0 recast str11 raw_prprca19
confirm variable raw_yisvdo19
quietly count if strlen(raw_yisvdo19)>10
if r(N)==0 recast str10 raw_yisvdo19
confirm variable raw_yisvfo19
quietly count if strlen(raw_yisvfo19)>9
if r(N)==0 recast str9 raw_yisvfo19
confirm variable raw_yisvmc19
quietly count if strlen(raw_yisvmc19)>3
if r(N)==0 recast str3 raw_yisvmc19
confirm variable raw_yisvmp19
quietly count if strlen(raw_yisvmp19)>3
if r(N)==0 recast str3 raw_yisvmp19
confirm variable raw_yisvmo19
quietly count if strlen(raw_yisvmo19)>3
if r(N)==0 recast str3 raw_yisvmo19
confirm variable raw_yisvcu19
quietly count if strlen(raw_yisvcu19)>10
if r(N)==0 recast str10 raw_yisvcu19
confirm variable raw_yrsvcu19
quietly count if strlen(raw_yrsvcu19)>10
if r(N)==0 recast str10 raw_yrsvcu19
confirm variable raw_ykivcu19
quietly count if strlen(raw_ykivcu19)>7
if r(N)==0 recast str7 raw_ykivcu19
confirm variable raw_ykdvcu19
quietly count if strlen(raw_ykdvcu19)>7
if r(N)==0 recast str7 raw_ykdvcu19
confirm variable raw_ykfvcu19
quietly count if strlen(raw_ykfvcu19)>1
if r(N)==0 recast str1 raw_ykfvcu19
confirm variable raw_ykfvmc19
quietly count if strlen(raw_ykfvmc19)>1
if r(N)==0 recast str1 raw_ykfvmc19
confirm variable raw_ykfvmp19
quietly count if strlen(raw_ykfvmp19)>1
if r(N)==0 recast str1 raw_ykfvmp19
confirm variable raw_ykfvmo19
quietly count if strlen(raw_ykfvmo19)>1
if r(N)==0 recast str1 raw_ykfvmo19
confirm variable raw_ysnvcu19
quietly count if strlen(raw_ysnvcu19)>8
if r(N)==0 recast str8 raw_ysnvcu19
confirm variable raw_yrnvcu19
quietly count if strlen(raw_yrnvcu19)>10
if r(N)==0 recast str10 raw_yrnvcu19
confirm variable raw_devvcu19
quietly count if strlen(raw_devvcu19)>10
if r(N)==0 recast str10 raw_devvcu19
confirm variable raw_intvcu19
quietly count if strlen(raw_intvcu19)>9
if r(N)==0 recast str9 raw_intvcu19
confirm variable raw_renvcu19
quietly count if strlen(raw_renvcu19)>7
if r(N)==0 recast str7 raw_renvcu19
confirm variable raw_insvcu19
quietly count if strlen(raw_insvcu19)>7
if r(N)==0 recast str7 raw_insvcu19
confirm variable raw_othvcu19
quietly count if strlen(raw_othvcu19)>8
if r(N)==0 recast str8 raw_othvcu19
confirm variable raw_nopvcu19
quietly count if strlen(raw_nopvcu19)>10
if r(N)==0 recast str10 raw_nopvcu19
confirm variable raw_srjvcu19
quietly count if strlen(raw_srjvcu19)>11
if r(N)==0 recast str11 raw_srjvcu19
confirm variable raw_srdvcu19
quietly count if strlen(raw_srdvcu19)>11
if r(N)==0 recast str11 raw_srdvcu19
confirm variable raw_shjvcu19
quietly count if strlen(raw_shjvcu19)>10
if r(N)==0 recast str10 raw_shjvcu19
confirm variable raw_shdvcu19
quietly count if strlen(raw_shdvcu19)>11
if r(N)==0 recast str11 raw_shdvcu19
confirm variable raw_sfjvcu19
quietly count if strlen(raw_sfjvcu19)>10
if r(N)==0 recast str10 raw_sfjvcu19
confirm variable raw_sfdvcu19
quietly count if strlen(raw_sfdvcu19)>11
if r(N)==0 recast str11 raw_sfdvcu19
confirm variable raw_stjvcu19
quietly count if strlen(raw_stjvcu19)>11
if r(N)==0 recast str11 raw_stjvcu19
confirm variable raw_stdvcu19
quietly count if strlen(raw_stdvcu19)>11
if r(N)==0 recast str11 raw_stdvcu19
confirm variable raw_clttcu19
quietly count if strlen(raw_clttcu19)>10
if r(N)==0 recast str10 raw_clttcu19
confirm variable raw_clsacu19
quietly count if strlen(raw_clsacu19)>7
if r(N)==0 recast str7 raw_clsacu19
confirm variable raw_cbttcu19
quietly count if strlen(raw_cbttcu19)>10
if r(N)==0 recast str10 raw_cbttcu19
confirm variable raw_cbsacu19
quietly count if strlen(raw_cbsacu19)>8
if r(N)==0 recast str8 raw_cbsacu19
confirm variable raw_cbdacu19
quietly count if strlen(raw_cbdacu19)>10
if r(N)==0 recast str10 raw_cbdacu19
confirm variable raw_cmttcu19
quietly count if strlen(raw_cmttcu19)>11
if r(N)==0 recast str11 raw_cmttcu19
confirm variable raw_cmsacu19
quietly count if strlen(raw_cmsacu19)>9
if r(N)==0 recast str9 raw_cmsacu19
confirm variable raw_cmdacu19
quietly count if strlen(raw_cmdacu19)>10
if r(N)==0 recast str10 raw_cmdacu19
confirm variable raw_cvttcu19
quietly count if strlen(raw_cvttcu19)>11
if r(N)==0 recast str11 raw_cvttcu19
confirm variable raw_cvsacu19
quietly count if strlen(raw_cvsacu19)>7
if r(N)==0 recast str7 raw_cvsacu19
confirm variable raw_cvdacu19
quietly count if strlen(raw_cvdacu19)>10
if r(N)==0 recast str10 raw_cvdacu19
confirm variable raw_csttcu19
quietly count if strlen(raw_csttcu19)>8
if r(N)==0 recast str8 raw_csttcu19
confirm variable raw_cssacu19
quietly count if strlen(raw_cssacu19)>6
if r(N)==0 recast str6 raw_cssacu19
confirm variable raw_cottcu19
quietly count if strlen(raw_cottcu19)>10
if r(N)==0 recast str10 raw_cottcu19
confirm variable raw_cosacu19
quietly count if strlen(raw_cosacu19)>8
if r(N)==0 recast str8 raw_cosacu19
confirm variable raw_codacu19
quietly count if strlen(raw_codacu19)>9
if r(N)==0 recast str9 raw_codacu19
confirm variable raw_ctttcu19
quietly count if strlen(raw_ctttcu19)>11
if r(N)==0 recast str11 raw_ctttcu19
confirm variable raw_ctsacu19
quietly count if strlen(raw_ctsacu19)>9
if r(N)==0 recast str9 raw_ctsacu19
confirm variable raw_ctdacu19
quietly count if strlen(raw_ctdacu19)>11
if r(N)==0 recast str11 raw_ctdacu19
confirm variable raw_r701
quietly count if strlen(raw_r701)>1
if r(N)==0 recast str1 raw_r701
confirm variable raw_r702a
quietly count if strlen(raw_r702a)>36
if r(N)==0 recast str36 raw_r702a
confirm variable raw_r702b
quietly count if strlen(raw_r702b)>44
if r(N)==0 recast str44 raw_r702b
confirm variable raw_r702c
quietly count if strlen(raw_r702c)>34
if r(N)==0 recast str34 raw_r702c
confirm variable raw_r702d
quietly count if strlen(raw_r702d)>47
if r(N)==0 recast str47 raw_r702d
confirm variable raw_r702e
quietly count if strlen(raw_r702e)>1
if r(N)==0 recast str1 raw_r702e
confirm variable raw_r702fdat
quietly count if strlen(raw_r702fdat)>2
if r(N)==0 recast str2 raw_r702fdat
confirm variable raw_r702fmon
quietly count if strlen(raw_r702fmon)>2
if r(N)==0 recast str2 raw_r702fmon
confirm variable raw_r702fyea
quietly count if strlen(raw_r702fyea)>4
if r(N)==0 recast str4 raw_r702fyea
confirm variable raw_rb8
quietly count if strlen(raw_rb8)>256
if r(N)==0 recast str256 raw_rb8
confirm variable raw_r901a
quietly count if strlen(raw_r901a)>39
if r(N)==0 recast str39 raw_r901a
confirm variable raw_r901b
quietly count if strlen(raw_r901b)>31
if r(N)==0 recast str31 raw_r901b
confirm variable raw_r901c
quietly count if strlen(raw_r901c)>1
if r(N)==0 recast str1 raw_r901c
confirm variable raw_b9r1001a
quietly count if strlen(raw_b9r1001a)>10
if r(N)==0 recast str10 raw_b9r1001a
confirm variable raw_b9r1001b
quietly count if strlen(raw_b9r1001b)>9
if r(N)==0 recast str9 raw_b9r1001b
confirm variable raw_b9r1001c
quietly count if strlen(raw_b9r1001c)>9
if r(N)==0 recast str9 raw_b9r1001c
confirm variable raw_b9r1001d
quietly count if strlen(raw_b9r1001d)>9
if r(N)==0 recast str9 raw_b9r1001d
confirm variable raw_b9r1001e
quietly count if strlen(raw_b9r1001e)>10
if r(N)==0 recast str10 raw_b9r1001e
confirm variable raw_b9r1001s
quietly count if strlen(raw_b9r1001s)>10
if r(N)==0 recast str10 raw_b9r1001s
confirm variable raw_br1002a
quietly count if strlen(raw_br1002a)>6
if r(N)==0 recast str6 raw_br1002a
confirm variable raw_br1002b
quietly count if strlen(raw_br1002b)>11
if r(N)==0 recast str11 raw_br1002b
confirm variable raw_br1002c
quietly count if strlen(raw_br1002c)>10
if r(N)==0 recast str10 raw_br1002c
confirm variable raw_br1002d
quietly count if strlen(raw_br1002d)>9
if r(N)==0 recast str9 raw_br1002d
confirm variable raw_br1002e
quietly count if strlen(raw_br1002e)>10
if r(N)==0 recast str10 raw_br1002e
confirm variable raw_br1002s
quietly count if strlen(raw_br1002s)>11
if r(N)==0 recast str11 raw_br1002s
confirm variable raw_br1003a
quietly count if strlen(raw_br1003a)>8
if r(N)==0 recast str8 raw_br1003a
confirm variable raw_br1003b
quietly count if strlen(raw_br1003b)>8
if r(N)==0 recast str8 raw_br1003b
confirm variable raw_br1003c
quietly count if strlen(raw_br1003c)>8
if r(N)==0 recast str8 raw_br1003c
confirm variable raw_br1003d
quietly count if strlen(raw_br1003d)>8
if r(N)==0 recast str8 raw_br1003d
confirm variable raw_br1003e
quietly count if strlen(raw_br1003e)>8
if r(N)==0 recast str8 raw_br1003e
confirm variable raw_br1003f
quietly count if strlen(raw_br1003f)>7
if r(N)==0 recast str7 raw_br1003f
confirm variable raw_br1003s
quietly count if strlen(raw_br1003s)>9
if r(N)==0 recast str9 raw_br1003s
confirm variable raw_br1004
quietly count if strlen(raw_br1004)>11
if r(N)==0 recast str11 raw_br1004
confirm variable raw_br1101
quietly count if strlen(raw_br1101)>28
if r(N)==0 recast str28 raw_br1101
confirm variable raw_br1102
quietly count if strlen(raw_br1102)>31
if r(N)==0 recast str31 raw_br1102
confirm variable raw_br1103da
quietly count if strlen(raw_br1103da)>2
if r(N)==0 recast str2 raw_br1103da
confirm variable raw_br1103mo
quietly count if strlen(raw_br1103mo)>2
if r(N)==0 recast str2 raw_br1103mo
confirm variable raw_br1103ye
quietly count if strlen(raw_br1103ye)>4
if r(N)==0 recast str4 raw_br1103ye
confirm variable raw_br1104
quietly count if strlen(raw_br1104)>1
if r(N)==0 recast str1 raw_br1104
confirm variable raw_kondisi
quietly count if strlen(raw_kondisi)>2
if r(N)==0 recast str2 raw_kondisi
confirm variable raw_lat
quietly count if strlen(raw_lat)>22
if r(N)==0 recast str22 raw_lat
confirm variable raw_long
quietly count if strlen(raw_long)>22
if r(N)==0 recast str22 raw_long
confirm variable raw_lokasi
quietly count if strlen(raw_lokasi)>1
if r(N)==0 recast str1 raw_lokasi
confirm variable raw_deslokas
quietly count if strlen(raw_deslokas)>48
if r(N)==0 recast str48 raw_deslokas
confirm variable raw_dstats19
quietly count if strlen(raw_dstats19)>1
if r(N)==0 recast str1 raw_dstats19
confirm variable raw_output19
quietly count if strlen(raw_output19)>11
if r(N)==0 recast str11 raw_output19
confirm variable raw_iinput19
quietly count if strlen(raw_iinput19)>11
if r(N)==0 recast str11 raw_iinput19
confirm variable raw_vtlvcu19
quietly count if strlen(raw_vtlvcu19)>11
if r(N)==0 recast str11 raw_vtlvcu19
confirm variable raw_pengtk19
quietly count if strlen(raw_pengtk19)>10
if r(N)==0 recast str10 raw_pengtk19
confirm variable raw_flag19
quietly count if strlen(raw_flag19)>2
if r(N)==0 recast str2 raw_flag19
confirm variable raw_flg19
quietly count if strlen(raw_flg19)>1
if r(N)==0 recast str1 raw_flg19
confirm variable raw_shfvcu19
quietly count if strlen(raw_shfvcu19)>10
if r(N)==0 recast str10 raw_shfvcu19
confirm variable raw_srmvcu19
quietly count if strlen(raw_srmvcu19)>11
if r(N)==0 recast str11 raw_srmvcu19
confirm variable raw_sfnvcu19
quietly count if strlen(raw_sfnvcu19)>11
if r(N)==0 recast str11 raw_sfnvcu19
confirm variable raw_stlvcu19
quietly count if strlen(raw_stlvcu19)>11
if r(N)==0 recast str11 raw_stlvcu19
confirm variable raw_prprex19
quietly count if strlen(raw_prprex19)>17
if r(N)==0 recast str17 raw_prprex19
confirm variable raw_iisvcu19
quietly count if strlen(raw_iisvcu19)>9
if r(N)==0 recast str9 raw_iisvcu19
confirm variable raw_lpmnou19
quietly count if strlen(raw_lpmnou19)>4
if r(N)==0 recast str4 raw_lpmnou19
confirm variable raw_lpwnou19
quietly count if strlen(raw_lpwnou19)>5
if r(N)==0 recast str5 raw_lpwnou19
confirm variable raw_lnmnou19
quietly count if strlen(raw_lnmnou19)>4
if r(N)==0 recast str4 raw_lnmnou19
confirm variable raw_lnwnou19
quietly count if strlen(raw_lnwnou19)>3
if r(N)==0 recast str3 raw_lnwnou19
confirm variable raw_lprnou19
quietly count if strlen(raw_lprnou19)>5
if r(N)==0 recast str5 raw_lprnou19
confirm variable raw_lnpnou19
quietly count if strlen(raw_lnpnou19)>4
if r(N)==0 recast str4 raw_lnpnou19
confirm variable raw_ikivcu19
quietly count if strlen(raw_ikivcu19)>7
if r(N)==0 recast str7 raw_ikivcu19
confirm variable raw_baku119
quietly count if strlen(raw_baku119)>115
if r(N)==0 recast str115 raw_baku119
confirm variable raw_prod119
quietly count if strlen(raw_prod119)>68
if r(N)==0 recast str68 raw_prod119
confirm variable raw_dprovi20
quietly count if strlen(raw_dprovi20)>2
if r(N)==0 recast str2 raw_dprovi20
confirm variable raw_dkabup20
quietly count if strlen(raw_dkabup20)>3
if r(N)==0 recast str3 raw_dkabup20
confirm variable raw_nama20
quietly count if strlen(raw_nama20)>3
if r(N)==0 recast str3 raw_nama20
confirm variable raw_disic520
quietly count if strlen(raw_disic520)>5
if r(N)==0 recast str5 raw_disic520
confirm variable raw_ltlnou20
quietly count if strlen(raw_ltlnou20)>5
if r(N)==0 recast str5 raw_ltlnou20
confirm variable raw_flg20
quietly count if strlen(raw_flg20)>1
if r(N)==0 recast str1 raw_flg20
confirm variable raw_dkecam20
quietly count if strlen(raw_dkecam20)>3
if r(N)==0 recast str3 raw_dkecam20
confirm variable raw_ddesa20
quietly count if strlen(raw_ddesa20)>3
if r(N)==0 recast str3 raw_ddesa20
confirm variable raw_alamat20
quietly count if strlen(raw_alamat20)>3
if r(N)==0 recast str3 raw_alamat20
confirm variable raw_dyrstr20
quietly count if strlen(raw_dyrstr20)>4
if r(N)==0 recast str4 raw_dyrstr20
confirm variable raw_zpdvcu20
quietly count if strlen(raw_zpdvcu20)>9
if r(N)==0 recast str9 raw_zpdvcu20
confirm variable raw_zndvcu20
quietly count if strlen(raw_zndvcu20)>9
if r(N)==0 recast str9 raw_zndvcu20
confirm variable raw_pengtk20
quietly count if strlen(raw_pengtk20)>9
if r(N)==0 recast str9 raw_pengtk20
confirm variable raw_yprvcu20
quietly count if strlen(raw_yprvcu20)>11
if r(N)==0 recast str11 raw_yprvcu20
confirm variable raw_output20
quietly count if strlen(raw_output20)>11
if r(N)==0 recast str11 raw_output20
confirm variable raw_rtlvcu20
quietly count if strlen(raw_rtlvcu20)>10
if r(N)==0 recast str10 raw_rtlvcu20
confirm variable raw_iinput20
quietly count if strlen(raw_iinput20)>10
if r(N)==0 recast str10 raw_iinput20
confirm variable raw_vtlvcu20
quietly count if strlen(raw_vtlvcu20)>11
if r(N)==0 recast str11 raw_vtlvcu20
confirm variable raw_flag20
quietly count if strlen(raw_flag20)>2
if r(N)==0 recast str2 raw_flag20
confirm variable raw_lprnol20
quietly count if strlen(raw_lprnol20)>5
if r(N)==0 recast str5 raw_lprnol20
confirm variable raw_lprnof20
quietly count if strlen(raw_lprnof20)>3
if r(N)==0 recast str3 raw_lprnof20
confirm variable raw_lnpnof20
quietly count if strlen(raw_lnpnof20)>2
if r(N)==0 recast str2 raw_lnpnof20
confirm variable raw_lnpnol20
quietly count if strlen(raw_lnpnol20)>4
if r(N)==0 recast str4 raw_lnpnol20
confirm variable raw_pwtlpi20
quietly count if strlen(raw_pwtlpi20)>3
if r(N)==0 recast str3 raw_pwtlpi20
confirm variable raw_pwtppi20
quietly count if strlen(raw_pwtppi20)>4
if r(N)==0 recast str4 raw_pwtppi20
confirm variable raw_pttlpi20
quietly count if strlen(raw_pttlpi20)>3
if r(N)==0 recast str3 raw_pttlpi20
confirm variable raw_pttppi20
quietly count if strlen(raw_pttppi20)>4
if r(N)==0 recast str4 raw_pttppi20
confirm variable raw_ptdpri20
quietly count if strlen(raw_ptdpri20)>3
if r(N)==0 recast str3 raw_ptdpri20
confirm variable raw_pwtlpa20
quietly count if strlen(raw_pwtlpa20)>3
if r(N)==0 recast str3 raw_pwtlpa20
confirm variable raw_pwtppa20
quietly count if strlen(raw_pwtppa20)>2
if r(N)==0 recast str2 raw_pwtppa20
confirm variable raw_pttlpa20
quietly count if strlen(raw_pttlpa20)>3
if r(N)==0 recast str3 raw_pttlpa20
confirm variable raw_pttppa20
quietly count if strlen(raw_pttppa20)>2
if r(N)==0 recast str2 raw_pttppa20
confirm variable raw_ptdpra20
quietly count if strlen(raw_ptdpra20)>1
if r(N)==0 recast str1 raw_ptdpra20
confirm variable raw_pwtlni20
quietly count if strlen(raw_pwtlni20)>3
if r(N)==0 recast str3 raw_pwtlni20
confirm variable raw_pwtpni20
quietly count if strlen(raw_pwtpni20)>3
if r(N)==0 recast str3 raw_pwtpni20
confirm variable raw_pttlni20
quietly count if strlen(raw_pttlni20)>3
if r(N)==0 recast str3 raw_pttlni20
confirm variable raw_pttpni20
quietly count if strlen(raw_pttpni20)>3
if r(N)==0 recast str3 raw_pttpni20
confirm variable raw_ptdnpi20
quietly count if strlen(raw_ptdnpi20)>2
if r(N)==0 recast str2 raw_ptdnpi20
confirm variable raw_pwtlna20
quietly count if strlen(raw_pwtlna20)>2
if r(N)==0 recast str2 raw_pwtlna20
confirm variable raw_pwtpna20
quietly count if strlen(raw_pwtpna20)>2
if r(N)==0 recast str2 raw_pwtpna20
confirm variable raw_pttlna20
quietly count if strlen(raw_pttlna20)>2
if r(N)==0 recast str2 raw_pttlna20
confirm variable raw_pttpna20
quietly count if strlen(raw_pttpna20)>2
if r(N)==0 recast str2 raw_pttpna20
confirm variable raw_ptdnpa20
quietly count if strlen(raw_ptdnpa20)>2
if r(N)==0 recast str2 raw_ptdnpa20
confirm variable raw_ltlmhs20
quietly count if strlen(raw_ltlmhs20)>5
if r(N)==0 recast str5 raw_ltlmhs20
confirm variable raw_ltlshs20
quietly count if strlen(raw_ltlshs20)>4
if r(N)==0 recast str4 raw_ltlshs20
confirm variable raw_ltlmdi20
quietly count if strlen(raw_ltlmdi20)>3
if r(N)==0 recast str3 raw_ltlmdi20
confirm variable raw_ltlmsm20
quietly count if strlen(raw_ltlmsm20)>3
if r(N)==0 recast str3 raw_ltlmsm20
confirm variable raw_zptvcu20
quietly count if strlen(raw_zptvcu20)>9
if r(N)==0 recast str9 raw_zptvcu20
confirm variable raw_zpevcu20
quietly count if strlen(raw_zpevcu20)>8
if r(N)==0 recast str8 raw_zpevcu20
confirm variable raw_zphvcu20
quietly count if strlen(raw_zphvcu20)>8
if r(N)==0 recast str8 raw_zphvcu20
confirm variable raw_zprvcu20
quietly count if strlen(raw_zprvcu20)>9
if r(N)==0 recast str9 raw_zprvcu20
confirm variable raw_zntvcu20
quietly count if strlen(raw_zntvcu20)>9
if r(N)==0 recast str9 raw_zntvcu20
confirm variable raw_znevcu20
quietly count if strlen(raw_znevcu20)>8
if r(N)==0 recast str8 raw_znevcu20
confirm variable raw_znhvcu20
quietly count if strlen(raw_znhvcu20)>8
if r(N)==0 recast str8 raw_znhvcu20
confirm variable raw_znrvcu20
quietly count if strlen(raw_znrvcu20)>8
if r(N)==0 recast str8 raw_znrvcu20
confirm variable raw_rdnvcu20
quietly count if strlen(raw_rdnvcu20)>10
if r(N)==0 recast str10 raw_rdnvcu20
confirm variable raw_rimvcu20
quietly count if strlen(raw_rimvcu20)>10
if r(N)==0 recast str10 raw_rimvcu20
confirm variable raw_efuvcu20
quietly count if strlen(raw_efuvcu20)>9
if r(N)==0 recast str9 raw_efuvcu20
confirm variable raw_ibrvcu20
quietly count if strlen(raw_ibrvcu20)>9
if r(N)==0 recast str9 raw_ibrvcu20
confirm variable raw_iislov20
quietly count if strlen(raw_iislov20)>10
if r(N)==0 recast str10 raw_iislov20
confirm variable raw_iisfov20
quietly count if strlen(raw_iisfov20)>8
if r(N)==0 recast str8 raw_iisfov20
confirm variable raw_ipkvcu20
quietly count if strlen(raw_ipkvcu20)>9
if r(N)==0 recast str9 raw_ipkvcu20
confirm variable raw_irdvcu20
quietly count if strlen(raw_irdvcu20)>7
if r(N)==0 recast str7 raw_irdvcu20
confirm variable raw_iklvcu20
quietly count if strlen(raw_iklvcu20)>7
if r(N)==0 recast str7 raw_iklvcu20
confirm variable raw_ikovcu20
quietly count if strlen(raw_ikovcu20)>8
if r(N)==0 recast str8 raw_ikovcu20
confirm variable raw_iuwvcu20
quietly count if strlen(raw_iuwvcu20)>8
if r(N)==0 recast str8 raw_iuwvcu20
confirm variable raw_eplvcu20
quietly count if strlen(raw_eplvcu20)>9
if r(N)==0 recast str9 raw_eplvcu20
confirm variable raw_enpvcu20
quietly count if strlen(raw_enpvcu20)>8
if r(N)==0 recast str8 raw_enpvcu20
confirm variable raw_iotvcu20
quietly count if strlen(raw_iotvcu20)>10
if r(N)==0 recast str10 raw_iotvcu20
confirm variable raw_ilrvcu20
quietly count if strlen(raw_ilrvcu20)>8
if r(N)==0 recast str8 raw_ilrvcu20
confirm variable raw_itxvcu20
quietly count if strlen(raw_itxvcu20)>9
if r(N)==0 recast str9 raw_itxvcu20
confirm variable raw_iinvcu20
quietly count if strlen(raw_iinvcu20)>9
if r(N)==0 recast str9 raw_iinvcu20
confirm variable raw_icovcu20
quietly count if strlen(raw_icovcu20)>9
if r(N)==0 recast str9 raw_icovcu20
confirm variable raw_idevcu20
quietly count if strlen(raw_idevcu20)>9
if r(N)==0 recast str9 raw_idevcu20
confirm variable raw_iprvcu20
quietly count if strlen(raw_iprvcu20)>9
if r(N)==0 recast str9 raw_iprvcu20
confirm variable raw_it1vcu20
quietly count if strlen(raw_it1vcu20)>10
if r(N)==0 recast str10 raw_it1vcu20
confirm variable raw_yisvcu20
quietly count if strlen(raw_yisvcu20)>10
if r(N)==0 recast str10 raw_yisvcu20
confirm variable raw_yisvdo20
quietly count if strlen(raw_yisvdo20)>10
if r(N)==0 recast str10 raw_yisvdo20
confirm variable raw_yisvfo20
quietly count if strlen(raw_yisvfo20)>9
if r(N)==0 recast str9 raw_yisvfo20
confirm variable raw_yrsvcu20
quietly count if strlen(raw_yrsvcu20)>9
if r(N)==0 recast str9 raw_yrsvcu20
confirm variable raw_ykdvcu20
quietly count if strlen(raw_ykdvcu20)>1
if r(N)==0 recast str1 raw_ykdvcu20
confirm variable raw_ykfvcu20
quietly count if strlen(raw_ykfvcu20)>7
if r(N)==0 recast str7 raw_ykfvcu20
confirm variable raw_ysnvcu20
quietly count if strlen(raw_ysnvcu20)>8
if r(N)==0 recast str8 raw_ysnvcu20
confirm variable raw_yelvcu20
quietly count if strlen(raw_yelvcu20)>9
if r(N)==0 recast str9 raw_yelvcu20
confirm variable raw_shfvcu20
quietly count if strlen(raw_shfvcu20)>10
if r(N)==0 recast str10 raw_shfvcu20
confirm variable raw_yrnvcu20
quietly count if strlen(raw_yrnvcu20)>10
if r(N)==0 recast str10 raw_yrnvcu20
confirm variable raw_nopvcu20
quietly count if strlen(raw_nopvcu20)>9
if r(N)==0 recast str9 raw_nopvcu20
confirm variable raw_ytovcu20
quietly count if strlen(raw_ytovcu20)>10
if r(N)==0 recast str10 raw_ytovcu20
confirm variable raw_epevcu20
quietly count if strlen(raw_epevcu20)>8
if r(N)==0 recast str8 raw_epevcu20
confirm variable raw_esovcu20
quietly count if strlen(raw_esovcu20)>8
if r(N)==0 recast str8 raw_esovcu20
confirm variable raw_edivcu20
quietly count if strlen(raw_edivcu20)>8
if r(N)==0 recast str8 raw_edivcu20
confirm variable raw_eclvcu20
quietly count if strlen(raw_eclvcu20)>9
if r(N)==0 recast str9 raw_eclvcu20
confirm variable raw_ecbvcu20
quietly count if strlen(raw_ecbvcu20)>7
if r(N)==0 recast str7 raw_ecbvcu20
confirm variable raw_engvcu20
quietly count if strlen(raw_engvcu20)>9
if r(N)==0 recast str9 raw_engvcu20
confirm variable raw_efovcu20
quietly count if strlen(raw_efovcu20)>7
if r(N)==0 recast str7 raw_efovcu20
confirm variable raw_elpvcu20
quietly count if strlen(raw_elpvcu20)>8
if r(N)==0 recast str8 raw_elpvcu20
confirm variable raw_ecavcu20
quietly count if strlen(raw_ecavcu20)>9
if r(N)==0 recast str9 raw_ecavcu20
confirm variable raw_eluvcu20
quietly count if strlen(raw_eluvcu20)>8
if r(N)==0 recast str8 raw_eluvcu20
confirm variable raw_encvcu20
quietly count if strlen(raw_encvcu20)>9
if r(N)==0 recast str9 raw_encvcu20
confirm variable raw_efuvce20
quietly count if strlen(raw_efuvce20)>9
if r(N)==0 recast str9 raw_efuvce20
confirm variable raw_epevce20
quietly count if strlen(raw_epevce20)>6
if r(N)==0 recast str6 raw_epevce20
confirm variable raw_esovce20
quietly count if strlen(raw_esovce20)>8
if r(N)==0 recast str8 raw_esovce20
confirm variable raw_edivce20
quietly count if strlen(raw_edivce20)>7
if r(N)==0 recast str7 raw_edivce20
confirm variable raw_eclvce20
quietly count if strlen(raw_eclvce20)>9
if r(N)==0 recast str9 raw_eclvce20
confirm variable raw_ecbvce20
quietly count if strlen(raw_ecbvce20)>1
if r(N)==0 recast str1 raw_ecbvce20
confirm variable raw_engvce20
quietly count if strlen(raw_engvce20)>7
if r(N)==0 recast str7 raw_engvce20
confirm variable raw_efovce20
quietly count if strlen(raw_efovce20)>2
if r(N)==0 recast str2 raw_efovce20
confirm variable raw_elpvce20
quietly count if strlen(raw_elpvce20)>5
if r(N)==0 recast str5 raw_elpvce20
confirm variable raw_ecavce20
quietly count if strlen(raw_ecavce20)>7
if r(N)==0 recast str7 raw_ecavce20
confirm variable raw_eluvce20
quietly count if strlen(raw_eluvce20)>6
if r(N)==0 recast str6 raw_eluvce20
confirm variable raw_encvce20
quietly count if strlen(raw_encvce20)>9
if r(N)==0 recast str9 raw_encvce20
confirm variable raw_epeliu20
quietly count if strlen(raw_epeliu20)>7
if r(N)==0 recast str7 raw_epeliu20
confirm variable raw_esoliu20
quietly count if strlen(raw_esoliu20)>8
if r(N)==0 recast str8 raw_esoliu20
confirm variable raw_ediliu20
quietly count if strlen(raw_ediliu20)>8
if r(N)==0 recast str8 raw_ediliu20
confirm variable raw_eclkgu20
quietly count if strlen(raw_eclkgu20)>6
if r(N)==0 recast str6 raw_eclkgu20
confirm variable raw_ecbkgu20
quietly count if strlen(raw_ecbkgu20)>7
if r(N)==0 recast str7 raw_ecbkgu20
confirm variable raw_engkgu20
quietly count if strlen(raw_engkgu20)>8
if r(N)==0 recast str8 raw_engkgu20
confirm variable raw_efoliu20
quietly count if strlen(raw_efoliu20)>6
if r(N)==0 recast str6 raw_efoliu20
confirm variable raw_elpkgu20
quietly count if strlen(raw_elpkgu20)>7
if r(N)==0 recast str7 raw_elpkgu20
confirm variable raw_ecakgu20
quietly count if strlen(raw_ecakgu20)>9
if r(N)==0 recast str9 raw_ecakgu20
confirm variable raw_eluliu20
quietly count if strlen(raw_eluliu20)>6
if r(N)==0 recast str6 raw_eluliu20
confirm variable raw_epelie20
quietly count if strlen(raw_epelie20)>5
if r(N)==0 recast str5 raw_epelie20
confirm variable raw_esolie20
quietly count if strlen(raw_esolie20)>7
if r(N)==0 recast str7 raw_esolie20
confirm variable raw_edilie20
quietly count if strlen(raw_edilie20)>6
if r(N)==0 recast str6 raw_edilie20
confirm variable raw_eclkge20
quietly count if strlen(raw_eclkge20)>6
if r(N)==0 recast str6 raw_eclkge20
confirm variable raw_ecbkge20
quietly count if strlen(raw_ecbkge20)>1
if r(N)==0 recast str1 raw_ecbkge20
confirm variable raw_engkge20
quietly count if strlen(raw_engkge20)>4
if r(N)==0 recast str4 raw_engkge20
confirm variable raw_efolie20
quietly count if strlen(raw_efolie20)>1
if r(N)==0 recast str1 raw_efolie20
confirm variable raw_elpkge20
quietly count if strlen(raw_elpkge20)>4
if r(N)==0 recast str4 raw_elpkge20
confirm variable raw_ecakge20
quietly count if strlen(raw_ecakge20)>5
if r(N)==0 recast str5 raw_ecakge20
confirm variable raw_elulie20
quietly count if strlen(raw_elulie20)>8
if r(N)==0 recast str8 raw_elulie20
confirm variable raw_eplkhu20
quietly count if strlen(raw_eplkhu20)>9
if r(N)==0 recast str9 raw_eplkhu20
confirm variable raw_enpkhu20
quietly count if strlen(raw_enpkhu20)>8
if r(N)==0 recast str8 raw_enpkhu20
confirm variable raw_oelkhu20
quietly count if strlen(raw_oelkhu20)>8
if r(N)==0 recast str8 raw_oelkhu20
confirm variable raw_esgkhu20
quietly count if strlen(raw_esgkhu20)>9
if r(N)==0 recast str9 raw_esgkhu20
confirm variable raw_dpusda20
quietly count if strlen(raw_dpusda20)>17
if r(N)==0 recast str17 raw_dpusda20
confirm variable raw_dnfins20
quietly count if strlen(raw_dnfins20)>17
if r(N)==0 recast str17 raw_dnfins20
confirm variable raw_dfinsi20
quietly count if strlen(raw_dfinsi20)>14
if r(N)==0 recast str14 raw_dfinsi20
confirm variable raw_dasing20
quietly count if strlen(raw_dasing20)>6
if r(N)==0 recast str6 raw_dasing20
confirm variable raw_dnopro20
quietly count if strlen(raw_dnopro20)>17
if r(N)==0 recast str17 raw_dnopro20
confirm variable raw_dindiv20
quietly count if strlen(raw_dindiv20)>3
if r(N)==0 recast str3 raw_dindiv20
confirm variable raw_shjvcu20
quietly count if strlen(raw_shjvcu20)>10
if r(N)==0 recast str10 raw_shjvcu20
confirm variable raw_shdvcu20
quietly count if strlen(raw_shdvcu20)>10
if r(N)==0 recast str10 raw_shdvcu20
confirm variable raw_srjvcu20
quietly count if strlen(raw_srjvcu20)>10
if r(N)==0 recast str10 raw_srjvcu20
confirm variable raw_srdvcu20
quietly count if strlen(raw_srdvcu20)>10
if r(N)==0 recast str10 raw_srdvcu20
confirm variable raw_srmvcu20
quietly count if strlen(raw_srmvcu20)>10
if r(N)==0 recast str10 raw_srmvcu20
confirm variable raw_sfjvcu20
quietly count if strlen(raw_sfjvcu20)>10
if r(N)==0 recast str10 raw_sfjvcu20
confirm variable raw_sfdvcu20
quietly count if strlen(raw_sfdvcu20)>10
if r(N)==0 recast str10 raw_sfdvcu20
confirm variable raw_sfnvcu20
quietly count if strlen(raw_sfnvcu20)>10
if r(N)==0 recast str10 raw_sfnvcu20
confirm variable raw_stjvcu20
quietly count if strlen(raw_stjvcu20)>10
if r(N)==0 recast str10 raw_stjvcu20
confirm variable raw_stdvcu20
quietly count if strlen(raw_stdvcu20)>10
if r(N)==0 recast str10 raw_stdvcu20
confirm variable raw_stlvcu20
quietly count if strlen(raw_stlvcu20)>11
if r(N)==0 recast str11 raw_stlvcu20
confirm variable raw_prprca20
quietly count if strlen(raw_prprca20)>11
if r(N)==0 recast str11 raw_prprca20
confirm variable raw_prprex20
quietly count if strlen(raw_prprex20)>17
if r(N)==0 recast str17 raw_prprex20
confirm variable raw_clfpcu20
quietly count if strlen(raw_clfpcu20)>9
if r(N)==0 recast str9 raw_clfpcu20
confirm variable raw_clttcu20
quietly count if strlen(raw_clttcu20)>8
if r(N)==0 recast str8 raw_clttcu20
confirm variable raw_clsacu20
quietly count if strlen(raw_clsacu20)>7
if r(N)==0 recast str7 raw_clsacu20
confirm variable raw_cbfpcu20
quietly count if strlen(raw_cbfpcu20)>10
if r(N)==0 recast str10 raw_cbfpcu20
confirm variable raw_cbttcu20
quietly count if strlen(raw_cbttcu20)>9
if r(N)==0 recast str9 raw_cbttcu20
confirm variable raw_cbsacu20
quietly count if strlen(raw_cbsacu20)>8
if r(N)==0 recast str8 raw_cbsacu20
confirm variable raw_cmfpcu20
quietly count if strlen(raw_cmfpcu20)>10
if r(N)==0 recast str10 raw_cmfpcu20
confirm variable raw_cmttcu20
quietly count if strlen(raw_cmttcu20)>10
if r(N)==0 recast str10 raw_cmttcu20
confirm variable raw_cmsacu20
quietly count if strlen(raw_cmsacu20)>9
if r(N)==0 recast str9 raw_cmsacu20
confirm variable raw_cvfpcu20
quietly count if strlen(raw_cvfpcu20)>9
if r(N)==0 recast str9 raw_cvfpcu20
confirm variable raw_cvttcu20
quietly count if strlen(raw_cvttcu20)>10
if r(N)==0 recast str10 raw_cvttcu20
confirm variable raw_cvsacu20
quietly count if strlen(raw_cvsacu20)>8
if r(N)==0 recast str8 raw_cvsacu20
confirm variable raw_csfpcu20
quietly count if strlen(raw_csfpcu20)>9
if r(N)==0 recast str9 raw_csfpcu20
confirm variable raw_csttcu20
quietly count if strlen(raw_csttcu20)>8
if r(N)==0 recast str8 raw_csttcu20
confirm variable raw_cofpcu20
quietly count if strlen(raw_cofpcu20)>10
if r(N)==0 recast str10 raw_cofpcu20
confirm variable raw_cottcu20
quietly count if strlen(raw_cottcu20)>10
if r(N)==0 recast str10 raw_cottcu20
confirm variable raw_cosacu20
quietly count if strlen(raw_cosacu20)>8
if r(N)==0 recast str8 raw_cosacu20
confirm variable raw_ctfpcu20
quietly count if strlen(raw_ctfpcu20)>10
if r(N)==0 recast str10 raw_ctfpcu20
confirm variable raw_ctttcu20
quietly count if strlen(raw_ctttcu20)>10
if r(N)==0 recast str10 raw_ctttcu20
confirm variable raw_ctsacu20
quietly count if strlen(raw_ctsacu20)>9
if r(N)==0 recast str9 raw_ctsacu20
confirm variable raw_thnsur
quietly count if strlen(raw_thnsur)>4
if r(N)==0 recast str4 raw_thnsur
confirm variable raw_dbs20
quietly count if strlen(raw_dbs20)>1
if r(N)==0 recast str1 raw_dbs20
confirm variable raw_kdpos20
quietly count if strlen(raw_kdpos20)>3
if r(N)==0 recast str3 raw_kdpos20
confirm variable raw_websit20
quietly count if strlen(raw_websit20)>3
if r(N)==0 recast str3 raw_websit20
confirm variable raw_email20
quietly count if strlen(raw_email20)>3
if r(N)==0 recast str3 raw_email20
confirm variable raw_tlp20
quietly count if strlen(raw_tlp20)>3
if r(N)==0 recast str3 raw_tlp20
confirm variable raw_fax20
quietly count if strlen(raw_fax20)>3
if r(N)==0 recast str3 raw_fax20
confirm variable raw_kpusat20
quietly count if strlen(raw_kpusat20)>3
if r(N)==0 recast str3 raw_kpusat20
confirm variable raw_alpus20
quietly count if strlen(raw_alpus20)>3
if r(N)==0 recast str3 raw_alpus20
confirm variable raw_kdposp20
quietly count if strlen(raw_kdposp20)>3
if r(N)==0 recast str3 raw_kdposp20
confirm variable raw_webkps20
quietly count if strlen(raw_webkps20)>3
if r(N)==0 recast str3 raw_webkps20
confirm variable raw_emaikp20
quietly count if strlen(raw_emaikp20)>3
if r(N)==0 recast str3 raw_emaikp20
confirm variable raw_tlppus20
quietly count if strlen(raw_tlppus20)>3
if r(N)==0 recast str3 raw_tlppus20
confirm variable raw_faxpus20
quietly count if strlen(raw_faxpus20)>3
if r(N)==0 recast str3 raw_faxpus20
confirm variable raw_b1r105
quietly count if strlen(raw_b1r105)>1
if r(N)==0 recast str1 raw_b1r105
confirm variable raw_shiftm20
quietly count if strlen(raw_shiftm20)>2
if r(N)==0 recast str2 raw_shiftm20
confirm variable raw_shiftd20
quietly count if strlen(raw_shiftd20)>2
if r(N)==0 recast str2 raw_shiftd20
confirm variable raw_rdwhou20
quietly count if strlen(raw_rdwhou20)>1
if r(N)==0 recast str1 raw_rdwhou20
confirm variable raw_rrdwha20
quietly count if strlen(raw_rrdwha20)>1
if r(N)==0 recast str1 raw_rrdwha20
confirm variable raw_rrdwhb20
quietly count if strlen(raw_rrdwhb20)>1
if r(N)==0 recast str1 raw_rrdwhb20
confirm variable raw_rrdwhc20
quietly count if strlen(raw_rrdwhc20)>1
if r(N)==0 recast str1 raw_rrdwhc20
confirm variable raw_rrdwhd20
quietly count if strlen(raw_rrdwhd20)>1
if r(N)==0 recast str1 raw_rrdwhd20
confirm variable raw_rrdwhe20
quietly count if strlen(raw_rrdwhe20)>1
if r(N)==0 recast str1 raw_rrdwhe20
confirm variable raw_rrdwhl20
quietly count if strlen(raw_rrdwhl20)>61
if r(N)==0 recast str61 raw_rrdwhl20
confirm variable raw_ardwha20
quietly count if strlen(raw_ardwha20)>1
if r(N)==0 recast str1 raw_ardwha20
confirm variable raw_ardwhb20
quietly count if strlen(raw_ardwhb20)>1
if r(N)==0 recast str1 raw_ardwhb20
confirm variable raw_ardwhc20
quietly count if strlen(raw_ardwhc20)>1
if r(N)==0 recast str1 raw_ardwhc20
confirm variable raw_ardwhd20
quietly count if strlen(raw_ardwhd20)>1
if r(N)==0 recast str1 raw_ardwhd20
confirm variable raw_ardwhl20
quietly count if strlen(raw_ardwhl20)>65
if r(N)==0 recast str65 raw_ardwhl20
confirm variable raw_ltloff20
quietly count if strlen(raw_ltloff20)>4
if r(N)==0 recast str4 raw_ltloff20
confirm variable raw_hebtax20
quietly count if strlen(raw_hebtax20)>1
if r(N)==0 recast str1 raw_hebtax20
confirm variable raw_prospe20
quietly count if strlen(raw_prospe20)>1
if r(N)==0 recast str1 raw_prospe20
confirm variable raw_opipro20
quietly count if strlen(raw_opipro20)>200
if r(N)==0 recast str200 raw_opipro20
confirm variable raw_nameowno
quietly count if strlen(raw_nameowno)>17
if r(N)==0 recast str17 raw_nameowno
confirm variable raw_pryrom20
quietly count if strlen(raw_pryrom20)>17
if r(N)==0 recast str17 raw_pryrom20
confirm variable raw_pryrwh20
quietly count if strlen(raw_pryrwh20)>17
if r(N)==0 recast str17 raw_pryrwh20
confirm variable raw_pryrre20
quietly count if strlen(raw_pryrre20)>4
if r(N)==0 recast str4 raw_pryrre20
confirm variable raw_pryrin20
quietly count if strlen(raw_pryrin20)>4
if r(N)==0 recast str4 raw_pryrin20
confirm variable raw_pryrac20
quietly count if strlen(raw_pryrac20)>3
if r(N)==0 recast str3 raw_pryrac20
confirm variable raw_pryrho20
quietly count if strlen(raw_pryrho20)>3
if r(N)==0 recast str3 raw_pryrho20
confirm variable raw_pryrot20
quietly count if strlen(raw_pryrot20)>3
if r(N)==0 recast str3 raw_pryrot20
confirm variable raw_pryrod20
quietly count if strlen(raw_pryrod20)>67
if r(N)==0 recast str67 raw_pryrod20
confirm variable raw_ppr1rtl
quietly count if strlen(raw_ppr1rtl)>17
if r(N)==0 recast str17 raw_ppr1rtl
confirm variable raw_ppr1ypr
quietly count if strlen(raw_ppr1ypr)>17
if r(N)==0 recast str17 raw_ppr1ypr
confirm variable raw_snipro20
quietly count if strlen(raw_snipro20)>1
if r(N)==0 recast str1 raw_snipro20
confirm variable raw_sniiso20
quietly count if strlen(raw_sniiso20)>1
if r(N)==0 recast str1 raw_sniiso20
confirm variable raw_sniman20
quietly count if strlen(raw_sniman20)>1
if r(N)==0 recast str1 raw_sniman20
confirm variable raw_snioth20
quietly count if strlen(raw_snioth20)>1
if r(N)==0 recast str1 raw_snioth20
confirm variable raw_rnd20
quietly count if strlen(raw_rnd20)>1
if r(N)==0 recast str1 raw_rnd20
confirm variable raw_costrd20
quietly count if strlen(raw_costrd20)>1
if r(N)==0 recast str1 raw_costrd20
confirm variable raw_inov20
quietly count if strlen(raw_inov20)>1
if r(N)==0 recast str1 raw_inov20
confirm variable raw_green20
quietly count if strlen(raw_green20)>1
if r(N)==0 recast str1 raw_green20
confirm variable raw_rgreen20
quietly count if strlen(raw_rgreen20)>4
if r(N)==0 recast str4 raw_rgreen20
confirm variable raw_ygreen20
quietly count if strlen(raw_ygreen20)>1
if r(N)==0 recast str1 raw_ygreen20
confirm variable raw_pgreen20
quietly count if strlen(raw_pgreen20)>3
if r(N)==0 recast str3 raw_pgreen20
confirm variable raw_tgreen20
quietly count if strlen(raw_tgreen20)>1
if r(N)==0 recast str1 raw_tgreen20
confirm variable raw_ecolab20
quietly count if strlen(raw_ecolab20)>1
if r(N)==0 recast str1 raw_ecolab20
confirm variable raw_amdal20
quietly count if strlen(raw_amdal20)>1
if r(N)==0 recast str1 raw_amdal20
confirm variable raw_pplihi20
quietly count if strlen(raw_pplihi20)>1
if r(N)==0 recast str1 raw_pplihi20
confirm variable raw_spplhi20
quietly count if strlen(raw_spplhi20)>1
if r(N)==0 recast str1 raw_spplhi20
confirm variable raw_inspli20
quietly count if strlen(raw_inspli20)>1
if r(N)==0 recast str1 raw_inspli20
confirm variable raw_pltsur20
quietly count if strlen(raw_pltsur20)>1
if r(N)==0 recast str1 raw_pltsur20
confirm variable raw_pltair20
quietly count if strlen(raw_pltair20)>1
if r(N)==0 recast str1 raw_pltair20
confirm variable raw_pltang20
quietly count if strlen(raw_pltang20)>1
if r(N)==0 recast str1 raw_pltang20
confirm variable raw_pltdie20
quietly count if strlen(raw_pltdie20)>1
if r(N)==0 recast str1 raw_pltdie20
confirm variable raw_pltbio20
quietly count if strlen(raw_pltbio20)>1
if r(N)==0 recast str1 raw_pltbio20
confirm variable raw_pltgas20
quietly count if strlen(raw_pltgas20)>1
if r(N)==0 recast str1 raw_pltgas20
confirm variable raw_pltoth20
quietly count if strlen(raw_pltoth20)>1
if r(N)==0 recast str1 raw_pltoth20
confirm variable raw_pltotd20
quietly count if strlen(raw_pltotd20)>54
if r(N)==0 recast str54 raw_pltotd20
confirm variable raw_autoai20
quietly count if strlen(raw_autoai20)>1
if r(N)==0 recast str1 raw_autoai20
confirm variable raw_iui20
quietly count if strlen(raw_iui20)>1
if r(N)==0 recast str1 raw_iui20
confirm variable raw_ltlrnd20
quietly count if strlen(raw_ltlrnd20)>3
if r(N)==0 recast str3 raw_ltlrnd20
confirm variable raw_encdes20
quietly count if strlen(raw_encdes20)>28
if r(N)==0 recast str28 raw_encdes20
confirm variable raw_b3r302l_
quietly count if strlen(raw_b3r302l_)>1
if r(N)==0 recast str1 raw_b3r302l_
confirm variable raw_b3r302l0
quietly count if strlen(raw_b3r302l0)>1
if r(N)==0 recast str1 raw_b3r302l0
confirm variable raw_b3r302l1
quietly count if strlen(raw_b3r302l1)>1
if r(N)==0 recast str1 raw_b3r302l1
confirm variable raw_b3r302l2
quietly count if strlen(raw_b3r302l2)>1
if r(N)==0 recast str1 raw_b3r302l2
confirm variable raw_b3r302k3
quietly count if strlen(raw_b3r302k3)>6
if r(N)==0 recast str6 raw_b3r302k3
confirm variable raw_epckva20
quietly count if strlen(raw_epckva20)>8
if r(N)==0 recast str8 raw_epckva20
confirm variable raw_mgekin20
quietly count if strlen(raw_mgekin20)>43
if r(N)==0 recast str43 raw_mgekin20
confirm variable raw_mgenou20
quietly count if strlen(raw_mgenou20)>5
if r(N)==0 recast str5 raw_mgenou20
confirm variable raw_mgekwu20
quietly count if strlen(raw_mgekwu20)>9
if r(N)==0 recast str9 raw_mgekwu20
confirm variable raw_oeukhu20
quietly count if strlen(raw_oeukhu20)>9
if r(N)==0 recast str9 raw_oeukhu20
confirm variable raw_iisfmp20
quietly count if strlen(raw_iisfmp20)>3
if r(N)==0 recast str3 raw_iisfmp20
confirm variable raw_iisfmc20
quietly count if strlen(raw_iisfmc20)>1
if r(N)==0 recast str1 raw_iisfmc20
confirm variable raw_iisfmo20
quietly count if strlen(raw_iisfmo20)>1
if r(N)==0 recast str1 raw_iisfmo20
confirm variable raw_ikivmp20
quietly count if strlen(raw_ikivmp20)>3
if r(N)==0 recast str3 raw_ikivmp20
confirm variable raw_ikivmc20
quietly count if strlen(raw_ikivmc20)>16
if r(N)==0 recast str16 raw_ikivmc20
confirm variable raw_ikivmo20
quietly count if strlen(raw_ikivmo20)>3
if r(N)==0 recast str3 raw_ikivmo20
confirm variable raw_ekspor20
quietly count if strlen(raw_ekspor20)>1
if r(N)==0 recast str1 raw_ekspor20
confirm variable raw_r402bk2
quietly count if strlen(raw_r402bk2)>1
if r(N)==0 recast str1 raw_r402bk2
confirm variable raw_yisvmc20
quietly count if strlen(raw_yisvmc20)>16
if r(N)==0 recast str16 raw_yisvmc20
confirm variable raw_yisvmo20
quietly count if strlen(raw_yisvmo20)>4
if r(N)==0 recast str4 raw_yisvmo20
confirm variable raw_ykfvmp20
quietly count if strlen(raw_ykfvmp20)>1
if r(N)==0 recast str1 raw_ykfvmp20
confirm variable raw_ykfvmo20
quietly count if strlen(raw_ykfvmo20)>1
if r(N)==0 recast str1 raw_ykfvmo20
confirm variable raw_ykfvmc20
quietly count if strlen(raw_ykfvmc20)>1
if r(N)==0 recast str1 raw_ykfvmc20
confirm variable raw_v502b2b
quietly count if strlen(raw_v502b2b)>1
if r(N)==0 recast str1 raw_v502b2b
confirm variable raw_yrndes20
quietly count if strlen(raw_yrndes20)>50
if r(N)==0 recast str50 raw_yrndes20
confirm variable raw_r503dk2
quietly count if strlen(raw_r503dk2)>1
if r(N)==0 recast str1 raw_r503dk2
confirm variable raw_r503dk3
quietly count if strlen(raw_r503dk3)>1
if r(N)==0 recast str1 raw_r503dk3
confirm variable raw_sfsvcu20
quietly count if strlen(raw_sfsvcu20)>6
if r(N)==0 recast str6 raw_sfsvcu20
confirm variable raw_sfuvcu20
quietly count if strlen(raw_sfuvcu20)>10
if r(N)==0 recast str10 raw_sfuvcu20
confirm variable raw_sfcvcu20
quietly count if strlen(raw_sfcvcu20)>7
if r(N)==0 recast str7 raw_sfcvcu20
confirm variable raw_sfgvcu20
quietly count if strlen(raw_sfgvcu20)>8
if r(N)==0 recast str8 raw_sfgvcu20
confirm variable raw_sfbvcu20
quietly count if strlen(raw_sfbvcu20)>6
if r(N)==0 recast str6 raw_sfbvcu20
confirm variable raw_sfrvcu20
quietly count if strlen(raw_sfrvcu20)>7
if r(N)==0 recast str7 raw_sfrvcu20
confirm variable raw_sfkvcu20
quietly count if strlen(raw_sfkvcu20)>8
if r(N)==0 recast str8 raw_sfkvcu20
confirm variable raw_sfovcu20
quietly count if strlen(raw_sfovcu20)>6
if r(N)==0 recast str6 raw_sfovcu20
confirm variable raw_cssacu20
quietly count if strlen(raw_cssacu20)>8
if r(N)==0 recast str8 raw_cssacu20
confirm variable raw_r702
quietly count if strlen(raw_r702)>50
if r(N)==0 recast str50 raw_r702
confirm variable raw_r703a
quietly count if strlen(raw_r703a)>43
if r(N)==0 recast str43 raw_r703a
confirm variable raw_r703b
quietly count if strlen(raw_r703b)>48
if r(N)==0 recast str48 raw_r703b
confirm variable raw_r703c
quietly count if strlen(raw_r703c)>20
if r(N)==0 recast str20 raw_r703c
confirm variable raw_r703d
quietly count if strlen(raw_r703d)>50
if r(N)==0 recast str50 raw_r703d
confirm variable raw_r703e
quietly count if strlen(raw_r703e)>1
if r(N)==0 recast str1 raw_r703e
confirm variable raw_r703f
quietly count if strlen(raw_r703f)>5
if r(N)==0 recast str5 raw_r703f
confirm variable raw_r1001a
quietly count if strlen(raw_r1001a)>10
if r(N)==0 recast str10 raw_r1001a
confirm variable raw_r1001b
quietly count if strlen(raw_r1001b)>9
if r(N)==0 recast str9 raw_r1001b
confirm variable raw_r1001c
quietly count if strlen(raw_r1001c)>9
if r(N)==0 recast str9 raw_r1001c
confirm variable raw_r1001d
quietly count if strlen(raw_r1001d)>10
if r(N)==0 recast str10 raw_r1001d
confirm variable raw_r1001e
quietly count if strlen(raw_r1001e)>10
if r(N)==0 recast str10 raw_r1001e
confirm variable raw_r1001sum
quietly count if strlen(raw_r1001sum)>10
if r(N)==0 recast str10 raw_r1001sum
confirm variable raw_r1002a
quietly count if strlen(raw_r1002a)>10
if r(N)==0 recast str10 raw_r1002a
confirm variable raw_r1002b
quietly count if strlen(raw_r1002b)>10
if r(N)==0 recast str10 raw_r1002b
confirm variable raw_r1002c
quietly count if strlen(raw_r1002c)>10
if r(N)==0 recast str10 raw_r1002c
confirm variable raw_r1002d
quietly count if strlen(raw_r1002d)>10
if r(N)==0 recast str10 raw_r1002d
confirm variable raw_r1002sum
quietly count if strlen(raw_r1002sum)>10
if r(N)==0 recast str10 raw_r1002sum
confirm variable raw_r1003a
quietly count if strlen(raw_r1003a)>8
if r(N)==0 recast str8 raw_r1003a
confirm variable raw_r1003b
quietly count if strlen(raw_r1003b)>9
if r(N)==0 recast str9 raw_r1003b
confirm variable raw_r1003c
quietly count if strlen(raw_r1003c)>9
if r(N)==0 recast str9 raw_r1003c
confirm variable raw_r1003d
quietly count if strlen(raw_r1003d)>9
if r(N)==0 recast str9 raw_r1003d
confirm variable raw_r1003e
quietly count if strlen(raw_r1003e)>10
if r(N)==0 recast str10 raw_r1003e
confirm variable raw_r1003f
quietly count if strlen(raw_r1003f)>9
if r(N)==0 recast str9 raw_r1003f
confirm variable raw_r1003sum
quietly count if strlen(raw_r1003sum)>10
if r(N)==0 recast str10 raw_r1003sum
confirm variable raw_r1004
quietly count if strlen(raw_r1004)>10
if r(N)==0 recast str10 raw_r1004
confirm variable raw_r1101
quietly count if strlen(raw_r1101)>28
if r(N)==0 recast str28 raw_r1101
confirm variable raw_r1102
quietly count if strlen(raw_r1102)>1
if r(N)==0 recast str1 raw_r1102
confirm variable raw_r1103
quietly count if strlen(raw_r1103)>5
if r(N)==0 recast str5 raw_r1103
confirm variable raw_r1104
quietly count if strlen(raw_r1104)>1
if r(N)==0 recast str1 raw_r1104
confirm variable raw_stsdok
quietly count if strlen(raw_stsdok)>1
if r(N)==0 recast str1 raw_stsdok
confirm variable raw_opercrea
quietly count if strlen(raw_opercrea)>41
if r(N)==0 recast str41 raw_opercrea
confirm variable raw_opermodi
quietly count if strlen(raw_opermodi)>41
if r(N)==0 recast str41 raw_opermodi
confirm variable raw_datecrea
quietly count if strlen(raw_datecrea)>26
if r(N)==0 recast str26 raw_datecrea
confirm variable raw_datemodi
quietly count if strlen(raw_datemodi)>1
if r(N)==0 recast str1 raw_datemodi
confirm variable raw_idale
quietly count if strlen(raw_idale)>10
if r(N)==0 recast str10 raw_idale
confirm variable raw_ltl20
quietly count if strlen(raw_ltl20)>5
if r(N)==0 recast str5 raw_ltl20
confirm variable raw_iuwnou20
quietly count if strlen(raw_iuwnou20)>1
if r(N)==0 recast str1 raw_iuwnou20
confirm variable raw_yisvmp20
quietly count if strlen(raw_yisvmp20)>3
if r(N)==0 recast str3 raw_yisvmp20
confirm variable raw_lprnou20
quietly count if strlen(raw_lprnou20)>5
if r(N)==0 recast str5 raw_lprnou20
confirm variable raw_lnpnou20
quietly count if strlen(raw_lnpnou20)>4
if r(N)==0 recast str4 raw_lnpnou20
confirm variable raw_blkomer
quietly count if strlen(raw_blkomer)>2
if r(N)==0 recast str2 raw_blkomer
confirm variable raw_thkomer
quietly count if strlen(raw_thkomer)>4
if r(N)==0 recast str4 raw_thkomer
confirm variable raw_petugas
quietly count if strlen(raw_petugas)>30
if r(N)==0 recast str30 raw_petugas
confirm variable raw_usercrea
quietly count if strlen(raw_usercrea)>27
if r(N)==0 recast str27 raw_usercrea
confirm variable raw_usermodi
quietly count if strlen(raw_usermodi)>27
if r(N)==0 recast str27 raw_usermodi
confirm variable raw_dprovi21
quietly count if strlen(raw_dprovi21)>2
if r(N)==0 recast str2 raw_dprovi21
confirm variable raw_dkabup21
quietly count if strlen(raw_dkabup21)>3
if r(N)==0 recast str3 raw_dkabup21
confirm variable raw_dkecam21
quietly count if strlen(raw_dkecam21)>3
if r(N)==0 recast str3 raw_dkecam21
confirm variable raw_ddesa21
quietly count if strlen(raw_ddesa21)>3
if r(N)==0 recast str3 raw_ddesa21
confirm variable raw_dbs21
quietly count if strlen(raw_dbs21)>1
if r(N)==0 recast str1 raw_dbs21
confirm variable raw_nama21
quietly count if strlen(raw_nama21)>3
if r(N)==0 recast str3 raw_nama21
confirm variable raw_alamat21
quietly count if strlen(raw_alamat21)>3
if r(N)==0 recast str3 raw_alamat21
confirm variable raw_kdpos21
quietly count if strlen(raw_kdpos21)>3
if r(N)==0 recast str3 raw_kdpos21
confirm variable raw_websit21
quietly count if strlen(raw_websit21)>3
if r(N)==0 recast str3 raw_websit21
confirm variable raw_email21
quietly count if strlen(raw_email21)>3
if r(N)==0 recast str3 raw_email21
confirm variable raw_tlp21
quietly count if strlen(raw_tlp21)>3
if r(N)==0 recast str3 raw_tlp21
confirm variable raw_fax21
quietly count if strlen(raw_fax21)>3
if r(N)==0 recast str3 raw_fax21
confirm variable raw_kpusat21
quietly count if strlen(raw_kpusat21)>3
if r(N)==0 recast str3 raw_kpusat21
confirm variable raw_alpus21
quietly count if strlen(raw_alpus21)>3
if r(N)==0 recast str3 raw_alpus21
confirm variable raw_kdposp21
quietly count if strlen(raw_kdposp21)>3
if r(N)==0 recast str3 raw_kdposp21
confirm variable raw_webkps21
quietly count if strlen(raw_webkps21)>3
if r(N)==0 recast str3 raw_webkps21
confirm variable raw_emaikp21
quietly count if strlen(raw_emaikp21)>3
if r(N)==0 recast str3 raw_emaikp21
confirm variable raw_tlppus21
quietly count if strlen(raw_tlppus21)>3
if r(N)==0 recast str3 raw_tlppus21
confirm variable raw_faxpus21
quietly count if strlen(raw_faxpus21)>3
if r(N)==0 recast str3 raw_faxpus21
confirm variable raw_nib21
quietly count if strlen(raw_nib21)>3
if r(N)==0 recast str3 raw_nib21
confirm variable raw_disic521
quietly count if strlen(raw_disic521)>5
if r(N)==0 recast str5 raw_disic521
confirm variable raw_shiftm21
quietly count if strlen(raw_shiftm21)>2
if r(N)==0 recast str2 raw_shiftm21
confirm variable raw_shiftd21
quietly count if strlen(raw_shiftd21)>2
if r(N)==0 recast str2 raw_shiftd21
confirm variable raw_rdwhou21
quietly count if strlen(raw_rdwhou21)>1
if r(N)==0 recast str1 raw_rdwhou21
confirm variable raw_rrdwha21
quietly count if strlen(raw_rrdwha21)>1
if r(N)==0 recast str1 raw_rrdwha21
confirm variable raw_rrdwhb21
quietly count if strlen(raw_rrdwhb21)>1
if r(N)==0 recast str1 raw_rrdwhb21
confirm variable raw_rrdwhc21
quietly count if strlen(raw_rrdwhc21)>1
if r(N)==0 recast str1 raw_rrdwhc21
confirm variable raw_rrdwhd21
quietly count if strlen(raw_rrdwhd21)>1
if r(N)==0 recast str1 raw_rrdwhd21
confirm variable raw_rrdwhe21
quietly count if strlen(raw_rrdwhe21)>1
if r(N)==0 recast str1 raw_rrdwhe21
confirm variable raw_rrdwhl21
quietly count if strlen(raw_rrdwhl21)>50
if r(N)==0 recast str50 raw_rrdwhl21
confirm variable raw_ardwha21
quietly count if strlen(raw_ardwha21)>1
if r(N)==0 recast str1 raw_ardwha21
confirm variable raw_ardwhb21
quietly count if strlen(raw_ardwhb21)>1
if r(N)==0 recast str1 raw_ardwhb21
confirm variable raw_ardwhc21
quietly count if strlen(raw_ardwhc21)>1
if r(N)==0 recast str1 raw_ardwhc21
confirm variable raw_ardwhd21
quietly count if strlen(raw_ardwhd21)>1
if r(N)==0 recast str1 raw_ardwhd21
confirm variable raw_ardwhl21
quietly count if strlen(raw_ardwhl21)>53
if r(N)==0 recast str53 raw_ardwhl21
confirm variable raw_ltloff21
quietly count if strlen(raw_ltloff21)>3
if r(N)==0 recast str3 raw_ltloff21
confirm variable raw_hebtax21
quietly count if strlen(raw_hebtax21)>1
if r(N)==0 recast str1 raw_hebtax21
confirm variable raw_prospe21
quietly count if strlen(raw_prospe21)>1
if r(N)==0 recast str1 raw_prospe21
confirm variable raw_opipro21
quietly count if strlen(raw_opipro21)>277
if r(N)==0 recast str277 raw_opipro21
confirm variable raw_dpusda21
quietly count if strlen(raw_dpusda21)>17
if r(N)==0 recast str17 raw_dpusda21
confirm variable raw_dnfins21
quietly count if strlen(raw_dnfins21)>17
if r(N)==0 recast str17 raw_dnfins21
confirm variable raw_dfinsi21
quietly count if strlen(raw_dfinsi21)>17
if r(N)==0 recast str17 raw_dfinsi21
confirm variable raw_dnopro21
quietly count if strlen(raw_dnopro21)>17
if r(N)==0 recast str17 raw_dnopro21
confirm variable raw_dindiv21
quietly count if strlen(raw_dindiv21)>5
if r(N)==0 recast str5 raw_dindiv21
confirm variable raw_dasing21
quietly count if strlen(raw_dasing21)>17
if r(N)==0 recast str17 raw_dasing21
confirm variable raw_stockowo
quietly count if strlen(raw_stockowo)>5
if r(N)==0 recast str5 raw_stockowo
confirm variable raw_pryrom21
quietly count if strlen(raw_pryrom21)>5
if r(N)==0 recast str5 raw_pryrom21
confirm variable raw_pryrwh21
quietly count if strlen(raw_pryrwh21)>17
if r(N)==0 recast str17 raw_pryrwh21
confirm variable raw_pryrre21
quietly count if strlen(raw_pryrre21)>5
if r(N)==0 recast str5 raw_pryrre21
confirm variable raw_pryrin21
quietly count if strlen(raw_pryrin21)>4
if r(N)==0 recast str4 raw_pryrin21
confirm variable raw_pryrac21
quietly count if strlen(raw_pryrac21)>4
if r(N)==0 recast str4 raw_pryrac21
confirm variable raw_pryrho21
quietly count if strlen(raw_pryrho21)>3
if r(N)==0 recast str3 raw_pryrho21
confirm variable raw_pryrot21
quietly count if strlen(raw_pryrot21)>5
if r(N)==0 recast str5 raw_pryrot21
confirm variable raw_pryrod21
quietly count if strlen(raw_pryrod21)>82
if r(N)==0 recast str82 raw_pryrod21
confirm variable raw_snipro21
quietly count if strlen(raw_snipro21)>1
if r(N)==0 recast str1 raw_snipro21
confirm variable raw_sniiso21
quietly count if strlen(raw_sniiso21)>1
if r(N)==0 recast str1 raw_sniiso21
confirm variable raw_sniman21
quietly count if strlen(raw_sniman21)>1
if r(N)==0 recast str1 raw_sniman21
confirm variable raw_snioth21
quietly count if strlen(raw_snioth21)>1
if r(N)==0 recast str1 raw_snioth21
confirm variable raw_rnd21
quietly count if strlen(raw_rnd21)>1
if r(N)==0 recast str1 raw_rnd21
confirm variable raw_costrd21
quietly count if strlen(raw_costrd21)>1
if r(N)==0 recast str1 raw_costrd21
confirm variable raw_inov21
quietly count if strlen(raw_inov21)>1
if r(N)==0 recast str1 raw_inov21
confirm variable raw_green21
quietly count if strlen(raw_green21)>1
if r(N)==0 recast str1 raw_green21
confirm variable raw_rgreen21
quietly count if strlen(raw_rgreen21)>17
if r(N)==0 recast str17 raw_rgreen21
confirm variable raw_ygreen21
quietly count if strlen(raw_ygreen21)>1
if r(N)==0 recast str1 raw_ygreen21
confirm variable raw_pgreen21
quietly count if strlen(raw_pgreen21)>17
if r(N)==0 recast str17 raw_pgreen21
confirm variable raw_tgreen21
quietly count if strlen(raw_tgreen21)>1
if r(N)==0 recast str1 raw_tgreen21
confirm variable raw_ecolab21
quietly count if strlen(raw_ecolab21)>1
if r(N)==0 recast str1 raw_ecolab21
confirm variable raw_amdal21
quietly count if strlen(raw_amdal21)>1
if r(N)==0 recast str1 raw_amdal21
confirm variable raw_pplihi21
quietly count if strlen(raw_pplihi21)>1
if r(N)==0 recast str1 raw_pplihi21
confirm variable raw_spplhi21
quietly count if strlen(raw_spplhi21)>1
if r(N)==0 recast str1 raw_spplhi21
confirm variable raw_inspli21
quietly count if strlen(raw_inspli21)>1
if r(N)==0 recast str1 raw_inspli21
confirm variable raw_pltsur21
quietly count if strlen(raw_pltsur21)>1
if r(N)==0 recast str1 raw_pltsur21
confirm variable raw_pltair21
quietly count if strlen(raw_pltair21)>1
if r(N)==0 recast str1 raw_pltair21
confirm variable raw_pltang21
quietly count if strlen(raw_pltang21)>1
if r(N)==0 recast str1 raw_pltang21
confirm variable raw_pltdie21
quietly count if strlen(raw_pltdie21)>1
if r(N)==0 recast str1 raw_pltdie21
confirm variable raw_pltbio21
quietly count if strlen(raw_pltbio21)>1
if r(N)==0 recast str1 raw_pltbio21
confirm variable raw_pltgas21
quietly count if strlen(raw_pltgas21)>1
if r(N)==0 recast str1 raw_pltgas21
confirm variable raw_pltuap21
quietly count if strlen(raw_pltuap21)>1
if r(N)==0 recast str1 raw_pltuap21
confirm variable raw_pltotd21
quietly count if strlen(raw_pltotd21)>33
if r(N)==0 recast str33 raw_pltotd21
confirm variable raw_autoai21
quietly count if strlen(raw_autoai21)>1
if r(N)==0 recast str1 raw_autoai21
confirm variable raw_pwtlpi21
quietly count if strlen(raw_pwtlpi21)>3
if r(N)==0 recast str3 raw_pwtlpi21
confirm variable raw_pwtlpa21
quietly count if strlen(raw_pwtlpa21)>3
if r(N)==0 recast str3 raw_pwtlpa21
confirm variable raw_pwtlni21
quietly count if strlen(raw_pwtlni21)>4
if r(N)==0 recast str4 raw_pwtlni21
confirm variable raw_pwtlna21
quietly count if strlen(raw_pwtlna21)>2
if r(N)==0 recast str2 raw_pwtlna21
confirm variable raw_pwtppi21
quietly count if strlen(raw_pwtppi21)>5
if r(N)==0 recast str5 raw_pwtppi21
confirm variable raw_pwtppa21
quietly count if strlen(raw_pwtppa21)>1
if r(N)==0 recast str1 raw_pwtppa21
confirm variable raw_pwtpni21
quietly count if strlen(raw_pwtpni21)>3
if r(N)==0 recast str3 raw_pwtpni21
confirm variable raw_pwtpna21
quietly count if strlen(raw_pwtpna21)>2
if r(N)==0 recast str2 raw_pwtpna21
confirm variable raw_pttlpi21
quietly count if strlen(raw_pttlpi21)>3
if r(N)==0 recast str3 raw_pttlpi21
confirm variable raw_pttlpa21
quietly count if strlen(raw_pttlpa21)>3
if r(N)==0 recast str3 raw_pttlpa21
confirm variable raw_pttlni21
quietly count if strlen(raw_pttlni21)>4
if r(N)==0 recast str4 raw_pttlni21
confirm variable raw_pttlna21
quietly count if strlen(raw_pttlna21)>2
if r(N)==0 recast str2 raw_pttlna21
confirm variable raw_pttppi21
quietly count if strlen(raw_pttppi21)>4
if r(N)==0 recast str4 raw_pttppi21
confirm variable raw_pttppa21
quietly count if strlen(raw_pttppa21)>2
if r(N)==0 recast str2 raw_pttppa21
confirm variable raw_pttpni21
quietly count if strlen(raw_pttpni21)>3
if r(N)==0 recast str3 raw_pttpni21
confirm variable raw_pttpna21
quietly count if strlen(raw_pttpna21)>2
if r(N)==0 recast str2 raw_pttpna21
confirm variable raw_ptdpri21
quietly count if strlen(raw_ptdpri21)>2
if r(N)==0 recast str2 raw_ptdpri21
confirm variable raw_ptdpra21
quietly count if strlen(raw_ptdpra21)>1
if r(N)==0 recast str1 raw_ptdpra21
confirm variable raw_ptdnpi21
quietly count if strlen(raw_ptdnpi21)>2
if r(N)==0 recast str2 raw_ptdnpi21
confirm variable raw_ptdnpa21
quietly count if strlen(raw_ptdnpa21)>2
if r(N)==0 recast str2 raw_ptdnpa21
confirm variable raw_lprnol21
quietly count if strlen(raw_lprnol21)>5
if r(N)==0 recast str5 raw_lprnol21
confirm variable raw_lprnof21
quietly count if strlen(raw_lprnof21)>3
if r(N)==0 recast str3 raw_lprnof21
confirm variable raw_lnpnol21
quietly count if strlen(raw_lnpnol21)>4
if r(N)==0 recast str4 raw_lnpnol21
confirm variable raw_lnpnof21
quietly count if strlen(raw_lnpnof21)>2
if r(N)==0 recast str2 raw_lnpnof21
confirm variable raw_ltlmhs21
quietly count if strlen(raw_ltlmhs21)>5
if r(N)==0 recast str5 raw_ltlmhs21
confirm variable raw_ltlshs21
quietly count if strlen(raw_ltlshs21)>4
if r(N)==0 recast str4 raw_ltlshs21
confirm variable raw_ltlmdi21
quietly count if strlen(raw_ltlmdi21)>3
if r(N)==0 recast str3 raw_ltlmdi21
confirm variable raw_ltlmsm21
quietly count if strlen(raw_ltlmsm21)>4
if r(N)==0 recast str4 raw_ltlmsm21
confirm variable raw_ltlnou21
quietly count if strlen(raw_ltlnou21)>5
if r(N)==0 recast str5 raw_ltlnou21
confirm variable raw_ltlrnd21
quietly count if strlen(raw_ltlrnd21)>3
if r(N)==0 recast str3 raw_ltlrnd21
confirm variable raw_zptvcu21
quietly count if strlen(raw_zptvcu21)>10
if r(N)==0 recast str10 raw_zptvcu21
confirm variable raw_zpevcu21
quietly count if strlen(raw_zpevcu21)>9
if r(N)==0 recast str9 raw_zpevcu21
confirm variable raw_zphvcu21
quietly count if strlen(raw_zphvcu21)>9
if r(N)==0 recast str9 raw_zphvcu21
confirm variable raw_zprvcu21
quietly count if strlen(raw_zprvcu21)>8
if r(N)==0 recast str8 raw_zprvcu21
confirm variable raw_zntvcu21
quietly count if strlen(raw_zntvcu21)>9
if r(N)==0 recast str9 raw_zntvcu21
confirm variable raw_znevcu21
quietly count if strlen(raw_znevcu21)>8
if r(N)==0 recast str8 raw_znevcu21
confirm variable raw_znhvcu21
quietly count if strlen(raw_znhvcu21)>8
if r(N)==0 recast str8 raw_znhvcu21
confirm variable raw_znrvcu21
quietly count if strlen(raw_znrvcu21)>9
if r(N)==0 recast str9 raw_znrvcu21
confirm variable raw_zpdvcu21
quietly count if strlen(raw_zpdvcu21)>10
if r(N)==0 recast str10 raw_zpdvcu21
confirm variable raw_zndvcu21
quietly count if strlen(raw_zndvcu21)>9
if r(N)==0 recast str9 raw_zndvcu21
confirm variable raw_epeliu21
quietly count if strlen(raw_epeliu21)>8
if r(N)==0 recast str8 raw_epeliu21
confirm variable raw_epevcu21
quietly count if strlen(raw_epevcu21)>9
if r(N)==0 recast str9 raw_epevcu21
confirm variable raw_epelie21
quietly count if strlen(raw_epelie21)>5
if r(N)==0 recast str5 raw_epelie21
confirm variable raw_epevce21
quietly count if strlen(raw_epevce21)>6
if r(N)==0 recast str6 raw_epevce21
confirm variable raw_esoliu21
quietly count if strlen(raw_esoliu21)>8
if r(N)==0 recast str8 raw_esoliu21
confirm variable raw_esovcu21
quietly count if strlen(raw_esovcu21)>9
if r(N)==0 recast str9 raw_esovcu21
confirm variable raw_esolie21
quietly count if strlen(raw_esolie21)>8
if r(N)==0 recast str8 raw_esolie21
confirm variable raw_esovce21
quietly count if strlen(raw_esovce21)>9
if r(N)==0 recast str9 raw_esovce21
confirm variable raw_esdliu21
quietly count if strlen(raw_esdliu21)>6
if r(N)==0 recast str6 raw_esdliu21
confirm variable raw_esdvcu21
quietly count if strlen(raw_esdvcu21)>7
if r(N)==0 recast str7 raw_esdvcu21
confirm variable raw_esdlie21
quietly count if strlen(raw_esdlie21)>4
if r(N)==0 recast str4 raw_esdlie21
confirm variable raw_esdvce21
quietly count if strlen(raw_esdvce21)>5
if r(N)==0 recast str5 raw_esdvce21
confirm variable raw_ediliu21
quietly count if strlen(raw_ediliu21)>7
if r(N)==0 recast str7 raw_ediliu21
confirm variable raw_edivcu21
quietly count if strlen(raw_edivcu21)>8
if r(N)==0 recast str8 raw_edivcu21
confirm variable raw_edilie21
quietly count if strlen(raw_edilie21)>6
if r(N)==0 recast str6 raw_edilie21
confirm variable raw_edivce21
quietly count if strlen(raw_edivce21)>7
if r(N)==0 recast str7 raw_edivce21
confirm variable raw_eclkgu21
quietly count if strlen(raw_eclkgu21)>9
if r(N)==0 recast str9 raw_eclkgu21
confirm variable raw_eclvcu21
quietly count if strlen(raw_eclvcu21)>9
if r(N)==0 recast str9 raw_eclvcu21
confirm variable raw_eclkge21
quietly count if strlen(raw_eclkge21)>6
if r(N)==0 recast str6 raw_eclkge21
confirm variable raw_eclvce21
quietly count if strlen(raw_eclvce21)>9
if r(N)==0 recast str9 raw_eclvce21
confirm variable raw_ecbkgu21
quietly count if strlen(raw_ecbkgu21)>7
if r(N)==0 recast str7 raw_ecbkgu21
confirm variable raw_ecbvcu21
quietly count if strlen(raw_ecbvcu21)>7
if r(N)==0 recast str7 raw_ecbvcu21
confirm variable raw_ecbkge21
quietly count if strlen(raw_ecbkge21)>1
if r(N)==0 recast str1 raw_ecbkge21
confirm variable raw_ecbvce21
quietly count if strlen(raw_ecbvce21)>1
if r(N)==0 recast str1 raw_ecbvce21
confirm variable raw_engkgu21
quietly count if strlen(raw_engkgu21)>7
if r(N)==0 recast str7 raw_engkgu21
confirm variable raw_engvcu21
quietly count if strlen(raw_engvcu21)>9
if r(N)==0 recast str9 raw_engvcu21
confirm variable raw_engkge21
quietly count if strlen(raw_engkge21)>7
if r(N)==0 recast str7 raw_engkge21
confirm variable raw_engvce21
quietly count if strlen(raw_engvce21)>9
if r(N)==0 recast str9 raw_engvce21
confirm variable raw_efoliu21
quietly count if strlen(raw_efoliu21)>6
if r(N)==0 recast str6 raw_efoliu21
confirm variable raw_efovcu21
quietly count if strlen(raw_efovcu21)>7
if r(N)==0 recast str7 raw_efovcu21
confirm variable raw_efolie21
quietly count if strlen(raw_efolie21)>2
if r(N)==0 recast str2 raw_efolie21
confirm variable raw_efovce21
quietly count if strlen(raw_efovce21)>3
if r(N)==0 recast str3 raw_efovce21
confirm variable raw_elpkgu21
quietly count if strlen(raw_elpkgu21)>7
if r(N)==0 recast str7 raw_elpkgu21
confirm variable raw_elpvcu21
quietly count if strlen(raw_elpvcu21)>8
if r(N)==0 recast str8 raw_elpvcu21
confirm variable raw_elpkge21
quietly count if strlen(raw_elpkge21)>4
if r(N)==0 recast str4 raw_elpkge21
confirm variable raw_elpvce21
quietly count if strlen(raw_elpvce21)>5
if r(N)==0 recast str5 raw_elpvce21
confirm variable raw_ecades21
quietly count if strlen(raw_ecades21)>41
if r(N)==0 recast str41 raw_ecades21
confirm variable raw_ecakgu21
quietly count if strlen(raw_ecakgu21)>6
if r(N)==0 recast str6 raw_ecakgu21
confirm variable raw_ecavcu21
quietly count if strlen(raw_ecavcu21)>8
if r(N)==0 recast str8 raw_ecavcu21
confirm variable raw_ecakge21
quietly count if strlen(raw_ecakge21)>4
if r(N)==0 recast str4 raw_ecakge21
confirm variable raw_ecavce21
quietly count if strlen(raw_ecavce21)>7
if r(N)==0 recast str7 raw_ecavce21
confirm variable raw_encvcu21
quietly count if strlen(raw_encvcu21)>8
if r(N)==0 recast str8 raw_encvcu21
confirm variable raw_encvce21
quietly count if strlen(raw_encvce21)>7
if r(N)==0 recast str7 raw_encvce21
confirm variable raw_eluliu21
quietly count if strlen(raw_eluliu21)>6
if r(N)==0 recast str6 raw_eluliu21
confirm variable raw_eluvcu21
quietly count if strlen(raw_eluvcu21)>8
if r(N)==0 recast str8 raw_eluvcu21
confirm variable raw_elulie21
quietly count if strlen(raw_elulie21)>4
if r(N)==0 recast str4 raw_elulie21
confirm variable raw_eluvce21
quietly count if strlen(raw_eluvce21)>6
if r(N)==0 recast str6 raw_eluvce21
confirm variable raw_efuvcu21
quietly count if strlen(raw_efuvcu21)>9
if r(N)==0 recast str9 raw_efuvcu21
confirm variable raw_efuvce21
quietly count if strlen(raw_efuvce21)>9
if r(N)==0 recast str9 raw_efuvce21
confirm variable raw_epckva21
quietly count if strlen(raw_epckva21)>9
if r(N)==0 recast str9 raw_epckva21
confirm variable raw_eplkhu21
quietly count if strlen(raw_eplkhu21)>9
if r(N)==0 recast str9 raw_eplkhu21
confirm variable raw_eplvcu21
quietly count if strlen(raw_eplvcu21)>9
if r(N)==0 recast str9 raw_eplvcu21
confirm variable raw_enpkhu21
quietly count if strlen(raw_enpkhu21)>9
if r(N)==0 recast str9 raw_enpkhu21
confirm variable raw_enpvcu21
quietly count if strlen(raw_enpvcu21)>9
if r(N)==0 recast str9 raw_enpvcu21
confirm variable raw_mgekin21
quietly count if strlen(raw_mgekin21)>40
if r(N)==0 recast str40 raw_mgekin21
confirm variable raw_mgenou21
quietly count if strlen(raw_mgenou21)>8
if r(N)==0 recast str8 raw_mgenou21
confirm variable raw_mgekwu21
quietly count if strlen(raw_mgekwu21)>9
if r(N)==0 recast str9 raw_mgekwu21
confirm variable raw_esgkhu21
quietly count if strlen(raw_esgkhu21)>9
if r(N)==0 recast str9 raw_esgkhu21
confirm variable raw_oeukhu21
quietly count if strlen(raw_oeukhu21)>9
if r(N)==0 recast str9 raw_oeukhu21
confirm variable raw_oelkhu21
quietly count if strlen(raw_oelkhu21)>9
if r(N)==0 recast str9 raw_oelkhu21
confirm variable raw_ibrvcu21
quietly count if strlen(raw_ibrvcu21)>9
if r(N)==0 recast str9 raw_ibrvcu21
confirm variable raw_ilrvcu21
quietly count if strlen(raw_ilrvcu21)>8
if r(N)==0 recast str8 raw_ilrvcu21
confirm variable raw_itxvcu21
quietly count if strlen(raw_itxvcu21)>9
if r(N)==0 recast str9 raw_itxvcu21
confirm variable raw_iislov21
quietly count if strlen(raw_iislov21)>9
if r(N)==0 recast str9 raw_iislov21
confirm variable raw_iisfov21
quietly count if strlen(raw_iisfov21)>8
if r(N)==0 recast str8 raw_iisfov21
confirm variable raw_iisfmp21
quietly count if strlen(raw_iisfmp21)>1
if r(N)==0 recast str1 raw_iisfmp21
confirm variable raw_iisfmc21
quietly count if strlen(raw_iisfmc21)>5
if r(N)==0 recast str5 raw_iisfmc21
confirm variable raw_iisfmo21
quietly count if strlen(raw_iisfmo21)>1
if r(N)==0 recast str1 raw_iisfmo21
confirm variable raw_iinvcu21
quietly count if strlen(raw_iinvcu21)>9
if r(N)==0 recast str9 raw_iinvcu21
confirm variable raw_icovcu21
quietly count if strlen(raw_icovcu21)>8
if r(N)==0 recast str8 raw_icovcu21
confirm variable raw_ipkvcu21
quietly count if strlen(raw_ipkvcu21)>9
if r(N)==0 recast str9 raw_ipkvcu21
confirm variable raw_idevcu21
quietly count if strlen(raw_idevcu21)>10
if r(N)==0 recast str10 raw_idevcu21
confirm variable raw_iprvcu21
quietly count if strlen(raw_iprvcu21)>8
if r(N)==0 recast str8 raw_iprvcu21
confirm variable raw_irdvcu21
quietly count if strlen(raw_irdvcu21)>8
if r(N)==0 recast str8 raw_irdvcu21
confirm variable raw_iklvcu21
quietly count if strlen(raw_iklvcu21)>7
if r(N)==0 recast str7 raw_iklvcu21
confirm variable raw_ikovcu21
quietly count if strlen(raw_ikovcu21)>9
if r(N)==0 recast str9 raw_ikovcu21
confirm variable raw_ikivmp21
quietly count if strlen(raw_ikivmp21)>3
if r(N)==0 recast str3 raw_ikivmp21
confirm variable raw_ikivmc21
quietly count if strlen(raw_ikivmc21)>11
if r(N)==0 recast str11 raw_ikivmc21
confirm variable raw_ikivmo21
quietly count if strlen(raw_ikivmo21)>1
if r(N)==0 recast str1 raw_ikivmo21
confirm variable raw_iuwvcu21
quietly count if strlen(raw_iuwvcu21)>9
if r(N)==0 recast str9 raw_iuwvcu21
confirm variable raw_iotvcu21
quietly count if strlen(raw_iotvcu21)>11
if r(N)==0 recast str11 raw_iotvcu21
confirm variable raw_it1vcu21
quietly count if strlen(raw_it1vcu21)>11
if r(N)==0 recast str11 raw_it1vcu21
confirm variable raw_rdnvcu21
quietly count if strlen(raw_rdnvcu21)>11
if r(N)==0 recast str11 raw_rdnvcu21
confirm variable raw_rimvcu21
quietly count if strlen(raw_rimvcu21)>10
if r(N)==0 recast str10 raw_rimvcu21
confirm variable raw_prprca21
quietly count if strlen(raw_prprca21)>9
if r(N)==0 recast str9 raw_prprca21
confirm variable raw_ekspor21
quietly count if strlen(raw_ekspor21)>1
if r(N)==0 recast str1 raw_ekspor21
confirm variable raw_yprvcu21
quietly count if strlen(raw_yprvcu21)>11
if r(N)==0 recast str11 raw_yprvcu21
confirm variable raw_yisvdo21
quietly count if strlen(raw_yisvdo21)>10
if r(N)==0 recast str10 raw_yisvdo21
confirm variable raw_yisvfo21
quietly count if strlen(raw_yisvfo21)>9
if r(N)==0 recast str9 raw_yisvfo21
confirm variable raw_yisvmc21
quietly count if strlen(raw_yisvmc21)>15
if r(N)==0 recast str15 raw_yisvmc21
confirm variable raw_yisvmo21
quietly count if strlen(raw_yisvmo21)>2
if r(N)==0 recast str2 raw_yisvmo21
confirm variable raw_yisvcu21
quietly count if strlen(raw_yisvcu21)>10
if r(N)==0 recast str10 raw_yisvcu21
confirm variable raw_yrsvcu21
quietly count if strlen(raw_yrsvcu21)>10
if r(N)==0 recast str10 raw_yrsvcu21
confirm variable raw_b5r502bx
quietly count if strlen(raw_b5r502bx)>1
if r(N)==0 recast str1 raw_b5r502bx
confirm variable raw_ykdvcu21
quietly count if strlen(raw_ykdvcu21)>6
if r(N)==0 recast str6 raw_ykdvcu21
confirm variable raw_ykfvcu21
quietly count if strlen(raw_ykfvcu21)>7
if r(N)==0 recast str7 raw_ykfvcu21
confirm variable raw_ykfvmp21
quietly count if strlen(raw_ykfvmp21)>2
if r(N)==0 recast str2 raw_ykfvmp21
confirm variable raw_ykfvmc21
quietly count if strlen(raw_ykfvmc21)>1
if r(N)==0 recast str1 raw_ykfvmc21
confirm variable raw_ykfvmo21
quietly count if strlen(raw_ykfvmo21)>2
if r(N)==0 recast str2 raw_ykfvmo21
confirm variable raw_ysnvcu21
quietly count if strlen(raw_ysnvcu21)>9
if r(N)==0 recast str9 raw_ysnvcu21
confirm variable raw_yelvcu21
quietly count if strlen(raw_yelvcu21)>8
if r(N)==0 recast str8 raw_yelvcu21
confirm variable raw_nopvcu21
quietly count if strlen(raw_nopvcu21)>10
if r(N)==0 recast str10 raw_nopvcu21
confirm variable raw_yrnvcu21
quietly count if strlen(raw_yrnvcu21)>10
if r(N)==0 recast str10 raw_yrnvcu21
confirm variable raw_yrndes21
quietly count if strlen(raw_yrndes21)>49
if r(N)==0 recast str49 raw_yrndes21
confirm variable raw_ytovcu21
quietly count if strlen(raw_ytovcu21)>10
if r(N)==0 recast str10 raw_ytovcu21
confirm variable raw_srjvcu21
quietly count if strlen(raw_srjvcu21)>10
if r(N)==0 recast str10 raw_srjvcu21
confirm variable raw_srdvcu21
quietly count if strlen(raw_srdvcu21)>10
if r(N)==0 recast str10 raw_srdvcu21
confirm variable raw_shjvcu21
quietly count if strlen(raw_shjvcu21)>9
if r(N)==0 recast str9 raw_shjvcu21
confirm variable raw_shdvcu21
quietly count if strlen(raw_shdvcu21)>10
if r(N)==0 recast str10 raw_shdvcu21
confirm variable raw_sfjvcu21
quietly count if strlen(raw_sfjvcu21)>10
if r(N)==0 recast str10 raw_sfjvcu21
confirm variable raw_sfdvcu21
quietly count if strlen(raw_sfdvcu21)>10
if r(N)==0 recast str10 raw_sfdvcu21
confirm variable raw_stjvcu21
quietly count if strlen(raw_stjvcu21)>10
if r(N)==0 recast str10 raw_stjvcu21
confirm variable raw_stdvcu21
quietly count if strlen(raw_stdvcu21)>10
if r(N)==0 recast str10 raw_stdvcu21
confirm variable raw_sfsvcu21
quietly count if strlen(raw_sfsvcu21)>8
if r(N)==0 recast str8 raw_sfsvcu21
confirm variable raw_sfuvcu21
quietly count if strlen(raw_sfuvcu21)>7
if r(N)==0 recast str7 raw_sfuvcu21
confirm variable raw_sfcvcu21
quietly count if strlen(raw_sfcvcu21)>7
if r(N)==0 recast str7 raw_sfcvcu21
confirm variable raw_sfgvcu21
quietly count if strlen(raw_sfgvcu21)>4
if r(N)==0 recast str4 raw_sfgvcu21
confirm variable raw_sfbvcu21
quietly count if strlen(raw_sfbvcu21)>5
if r(N)==0 recast str5 raw_sfbvcu21
confirm variable raw_sfrvcu21
quietly count if strlen(raw_sfrvcu21)>8
if r(N)==0 recast str8 raw_sfrvcu21
confirm variable raw_sfkvcu21
quietly count if strlen(raw_sfkvcu21)>6
if r(N)==0 recast str6 raw_sfkvcu21
confirm variable raw_sfovcu21
quietly count if strlen(raw_sfovcu21)>7
if r(N)==0 recast str7 raw_sfovcu21
confirm variable raw_clfpcu21
quietly count if strlen(raw_clfpcu21)>11
if r(N)==0 recast str11 raw_clfpcu21
confirm variable raw_clttcu21
quietly count if strlen(raw_clttcu21)>11
if r(N)==0 recast str11 raw_clttcu21
confirm variable raw_clsacu21
quietly count if strlen(raw_clsacu21)>10
if r(N)==0 recast str10 raw_clsacu21
confirm variable raw_cbfpcu21
quietly count if strlen(raw_cbfpcu21)>11
if r(N)==0 recast str11 raw_cbfpcu21
confirm variable raw_cbttcu21
quietly count if strlen(raw_cbttcu21)>11
if r(N)==0 recast str11 raw_cbttcu21
confirm variable raw_cbsacu21
quietly count if strlen(raw_cbsacu21)>9
if r(N)==0 recast str9 raw_cbsacu21
confirm variable raw_cmfpcu21
quietly count if strlen(raw_cmfpcu21)>11
if r(N)==0 recast str11 raw_cmfpcu21
confirm variable raw_cmttcu21
quietly count if strlen(raw_cmttcu21)>11
if r(N)==0 recast str11 raw_cmttcu21
confirm variable raw_cmsacu21
quietly count if strlen(raw_cmsacu21)>11
if r(N)==0 recast str11 raw_cmsacu21
confirm variable raw_cvfpcu21
quietly count if strlen(raw_cvfpcu21)>11
if r(N)==0 recast str11 raw_cvfpcu21
confirm variable raw_cvttcu21
quietly count if strlen(raw_cvttcu21)>10
if r(N)==0 recast str10 raw_cvttcu21
confirm variable raw_cvsacu21
quietly count if strlen(raw_cvsacu21)>10
if r(N)==0 recast str10 raw_cvsacu21
confirm variable raw_csfpcu21
quietly count if strlen(raw_csfpcu21)>10
if r(N)==0 recast str10 raw_csfpcu21
confirm variable raw_csttcu21
quietly count if strlen(raw_csttcu21)>9
if r(N)==0 recast str9 raw_csttcu21
confirm variable raw_cssacu21
quietly count if strlen(raw_cssacu21)>8
if r(N)==0 recast str8 raw_cssacu21
confirm variable raw_cofpcu21
quietly count if strlen(raw_cofpcu21)>11
if r(N)==0 recast str11 raw_cofpcu21
confirm variable raw_cottcu21
quietly count if strlen(raw_cottcu21)>11
if r(N)==0 recast str11 raw_cottcu21
confirm variable raw_cosacu21
quietly count if strlen(raw_cosacu21)>10
if r(N)==0 recast str10 raw_cosacu21
confirm variable raw_ctfpcu21
quietly count if strlen(raw_ctfpcu21)>12
if r(N)==0 recast str12 raw_ctfpcu21
confirm variable raw_ctttcu21
quietly count if strlen(raw_ctttcu21)>11
if r(N)==0 recast str11 raw_ctttcu21
confirm variable raw_ctsacu21
quietly count if strlen(raw_ctsacu21)>11
if r(N)==0 recast str11 raw_ctsacu21
confirm variable raw_flg21
quietly count if strlen(raw_flg21)>1
if r(N)==0 recast str1 raw_flg21
confirm variable raw_bdnusaha
quietly count if strlen(raw_bdnusaha)>4
if r(N)==0 recast str4 raw_bdnusaha
confirm variable raw_blkom
quietly count if strlen(raw_blkom)>4
if r(N)==0 recast str4 raw_blkom
confirm variable raw_dyrstr21
quietly count if strlen(raw_dyrstr21)>4
if r(N)==0 recast str4 raw_dyrstr21
confirm variable raw_skalatk
quietly count if strlen(raw_skalatk)>4
if r(N)==0 recast str4 raw_skalatk
confirm variable raw_skalinv
quietly count if strlen(raw_skalinv)>4
if r(N)==0 recast str4 raw_skalinv
confirm variable raw_skalaoms
quietly count if strlen(raw_skalaoms)>4
if r(N)==0 recast str4 raw_skalaoms
confirm variable raw_pengtk21
quietly count if strlen(raw_pengtk21)>10
if r(N)==0 recast str10 raw_pengtk21
confirm variable raw_rtlvcu21
quietly count if strlen(raw_rtlvcu21)>11
if r(N)==0 recast str11 raw_rtlvcu21
confirm variable raw_output21
quietly count if strlen(raw_output21)>11
if r(N)==0 recast str11 raw_output21
confirm variable raw_iinput21
quietly count if strlen(raw_iinput21)>11
if r(N)==0 recast str11 raw_iinput21
confirm variable raw_vtlvcu21
quietly count if strlen(raw_vtlvcu21)>11
if r(N)==0 recast str11 raw_vtlvcu21
confirm variable raw_flag21
quietly count if strlen(raw_flag21)>2
if r(N)==0 recast str2 raw_flag21
confirm variable raw_prprex21
quietly count if strlen(raw_prprex21)>17
if r(N)==0 recast str17 raw_prprex21
confirm variable raw_srmvcu21
quietly count if strlen(raw_srmvcu21)>11
if r(N)==0 recast str11 raw_srmvcu21
confirm variable raw_shfvcu21
quietly count if strlen(raw_shfvcu21)>10
if r(N)==0 recast str10 raw_shfvcu21
confirm variable raw_sfnvcu21
quietly count if strlen(raw_sfnvcu21)>10
if r(N)==0 recast str10 raw_sfnvcu21
confirm variable raw_stlvcu21
quietly count if strlen(raw_stlvcu21)>11
if r(N)==0 recast str11 raw_stlvcu21
confirm variable raw_yisvmp21
quietly count if strlen(raw_yisvmp21)>3
if r(N)==0 recast str3 raw_yisvmp21
confirm variable raw_iuwnou21
quietly count if strlen(raw_iuwnou21)>1
if r(N)==0 recast str1 raw_iuwnou21
confirm variable raw_lprnou21
quietly count if strlen(raw_lprnou21)>5
if r(N)==0 recast str5 raw_lprnou21
confirm variable raw_lnpnou21
quietly count if strlen(raw_lnpnou21)>4
if r(N)==0 recast str4 raw_lnpnou21
confirm variable raw_dprovi22
quietly count if strlen(raw_dprovi22)>2
if r(N)==0 recast str2 raw_dprovi22
confirm variable raw_dkabup22
quietly count if strlen(raw_dkabup22)>3
if r(N)==0 recast str3 raw_dkabup22
confirm variable raw_dkecam22
quietly count if strlen(raw_dkecam22)>3
if r(N)==0 recast str3 raw_dkecam22
confirm variable raw_ddesa22
quietly count if strlen(raw_ddesa22)>3
if r(N)==0 recast str3 raw_ddesa22
confirm variable raw_dbs
quietly count if strlen(raw_dbs)>1
if r(N)==0 recast str1 raw_dbs
confirm variable raw_nama22
quietly count if strlen(raw_nama22)>3
if r(N)==0 recast str3 raw_nama22
confirm variable raw_alamat22
quietly count if strlen(raw_alamat22)>3
if r(N)==0 recast str3 raw_alamat22
confirm variable raw_kdpos22
quietly count if strlen(raw_kdpos22)>3
if r(N)==0 recast str3 raw_kdpos22
confirm variable raw_websit22
quietly count if strlen(raw_websit22)>3
if r(N)==0 recast str3 raw_websit22
confirm variable raw_email22
quietly count if strlen(raw_email22)>3
if r(N)==0 recast str3 raw_email22
confirm variable raw_tlp22
quietly count if strlen(raw_tlp22)>3
if r(N)==0 recast str3 raw_tlp22
confirm variable raw_fax22
quietly count if strlen(raw_fax22)>3
if r(N)==0 recast str3 raw_fax22
confirm variable raw_kpusat22
quietly count if strlen(raw_kpusat22)>3
if r(N)==0 recast str3 raw_kpusat22
confirm variable raw_alpus22
quietly count if strlen(raw_alpus22)>3
if r(N)==0 recast str3 raw_alpus22
confirm variable raw_kdposp22
quietly count if strlen(raw_kdposp22)>3
if r(N)==0 recast str3 raw_kdposp22
confirm variable raw_webkps22
quietly count if strlen(raw_webkps22)>3
if r(N)==0 recast str3 raw_webkps22
confirm variable raw_emaikp22
quietly count if strlen(raw_emaikp22)>3
if r(N)==0 recast str3 raw_emaikp22
confirm variable raw_tlppus22
quietly count if strlen(raw_tlppus22)>3
if r(N)==0 recast str3 raw_tlppus22
confirm variable raw_faxpus22
quietly count if strlen(raw_faxpus22)>3
if r(N)==0 recast str3 raw_faxpus22
confirm variable raw_nib22
quietly count if strlen(raw_nib22)>3
if r(N)==0 recast str3 raw_nib22
confirm variable raw_disic522
quietly count if strlen(raw_disic522)>5
if r(N)==0 recast str5 raw_disic522
confirm variable raw_shiftm22
quietly count if strlen(raw_shiftm22)>2
if r(N)==0 recast str2 raw_shiftm22
confirm variable raw_shiftd22
quietly count if strlen(raw_shiftd22)>2
if r(N)==0 recast str2 raw_shiftd22
confirm variable raw_dpusda22
quietly count if strlen(raw_dpusda22)>17
if r(N)==0 recast str17 raw_dpusda22
confirm variable raw_dnfins22
quietly count if strlen(raw_dnfins22)>17
if r(N)==0 recast str17 raw_dnfins22
confirm variable raw_dfinsi22
quietly count if strlen(raw_dfinsi22)>17
if r(N)==0 recast str17 raw_dfinsi22
confirm variable raw_dnopro22
quietly count if strlen(raw_dnopro22)>5
if r(N)==0 recast str5 raw_dnopro22
confirm variable raw_dindiv22
quietly count if strlen(raw_dindiv22)>17
if r(N)==0 recast str17 raw_dindiv22
confirm variable raw_dasing22
quietly count if strlen(raw_dasing22)>17
if r(N)==0 recast str17 raw_dasing22
confirm variable raw_rnd22
quietly count if strlen(raw_rnd22)>1
if r(N)==0 recast str1 raw_rnd22
confirm variable raw_costrd22
quietly count if strlen(raw_costrd22)>1
if r(N)==0 recast str1 raw_costrd22
confirm variable raw_inov22
quietly count if strlen(raw_inov22)>1
if r(N)==0 recast str1 raw_inov22
confirm variable raw_amdal22
quietly count if strlen(raw_amdal22)>1
if r(N)==0 recast str1 raw_amdal22
confirm variable raw_pplihi22
quietly count if strlen(raw_pplihi22)>1
if r(N)==0 recast str1 raw_pplihi22
confirm variable raw_spplhi22
quietly count if strlen(raw_spplhi22)>1
if r(N)==0 recast str1 raw_spplhi22
confirm variable raw_inspli22
quietly count if strlen(raw_inspli22)>1
if r(N)==0 recast str1 raw_inspli22
confirm variable raw_sowste22
quietly count if strlen(raw_sowste22)>1
if r(N)==0 recast str1 raw_sowste22
confirm variable raw_liwste22
quietly count if strlen(raw_liwste22)>1
if r(N)==0 recast str1 raw_liwste22
confirm variable raw_b3wste22
quietly count if strlen(raw_b3wste22)>1
if r(N)==0 recast str1 raw_b3wste22
confirm variable raw_lpmnop22
quietly count if strlen(raw_lpmnop22)>4
if r(N)==0 recast str4 raw_lpmnop22
confirm variable raw_lpmnon22
quietly count if strlen(raw_lpmnon22)>4
if r(N)==0 recast str4 raw_lpmnon22
confirm variable raw_lnmnop22
quietly count if strlen(raw_lnmnop22)>4
if r(N)==0 recast str4 raw_lnmnop22
confirm variable raw_lnmnon22
quietly count if strlen(raw_lnmnon22)>4
if r(N)==0 recast str4 raw_lnmnon22
confirm variable raw_lpwnop22
quietly count if strlen(raw_lpwnop22)>4
if r(N)==0 recast str4 raw_lpwnop22
confirm variable raw_lpwnon22
quietly count if strlen(raw_lpwnon22)>4
if r(N)==0 recast str4 raw_lpwnon22
confirm variable raw_lnwnop22
quietly count if strlen(raw_lnwnop22)>4
if r(N)==0 recast str4 raw_lnwnop22
confirm variable raw_lnwnon22
quietly count if strlen(raw_lnwnon22)>3
if r(N)==0 recast str3 raw_lnwnon22
confirm variable raw_lprnop22
quietly count if strlen(raw_lprnop22)>5
if r(N)==0 recast str5 raw_lprnop22
confirm variable raw_lprnon22
quietly count if strlen(raw_lprnon22)>4
if r(N)==0 recast str4 raw_lprnon22
confirm variable raw_lnpnop22
quietly count if strlen(raw_lnpnop22)>4
if r(N)==0 recast str4 raw_lnpnop22
confirm variable raw_lnpnon22
quietly count if strlen(raw_lnpnon22)>4
if r(N)==0 recast str4 raw_lnpnon22
confirm variable raw_ltlnof22
quietly count if strlen(raw_ltlnof22)>4
if r(N)==0 recast str4 raw_ltlnof22
confirm variable raw_ltlrnd22
quietly count if strlen(raw_ltlrnd22)>3
if r(N)==0 recast str3 raw_ltlrnd22
confirm variable raw_zptvcu22
quietly count if strlen(raw_zptvcu22)>9
if r(N)==0 recast str9 raw_zptvcu22
confirm variable raw_zntvcu22
quietly count if strlen(raw_zntvcu22)>9
if r(N)==0 recast str9 raw_zntvcu22
confirm variable raw_zprvcu22
quietly count if strlen(raw_zprvcu22)>9
if r(N)==0 recast str9 raw_zprvcu22
confirm variable raw_znrvcu22
quietly count if strlen(raw_znrvcu22)>8
if r(N)==0 recast str8 raw_znrvcu22
confirm variable raw_zpdvcu22
quietly count if strlen(raw_zpdvcu22)>9
if r(N)==0 recast str9 raw_zpdvcu22
confirm variable raw_zndvcu22
quietly count if strlen(raw_zndvcu22)>9
if r(N)==0 recast str9 raw_zndvcu22
confirm variable raw_epeliu22
quietly count if strlen(raw_epeliu22)>8
if r(N)==0 recast str8 raw_epeliu22
confirm variable raw_epevcu22
quietly count if strlen(raw_epevcu22)>9
if r(N)==0 recast str9 raw_epevcu22
confirm variable raw_epelie22
quietly count if strlen(raw_epelie22)>5
if r(N)==0 recast str5 raw_epelie22
confirm variable raw_epevce22
quietly count if strlen(raw_epevce22)>6
if r(N)==0 recast str6 raw_epevce22
confirm variable raw_esoliu22
quietly count if strlen(raw_esoliu22)>8
if r(N)==0 recast str8 raw_esoliu22
confirm variable raw_esovcu22
quietly count if strlen(raw_esovcu22)>9
if r(N)==0 recast str9 raw_esovcu22
confirm variable raw_esolie22
quietly count if strlen(raw_esolie22)>7
if r(N)==0 recast str7 raw_esolie22
confirm variable raw_esovce22
quietly count if strlen(raw_esovce22)>8
if r(N)==0 recast str8 raw_esovce22
confirm variable raw_esdliu22
quietly count if strlen(raw_esdliu22)>6
if r(N)==0 recast str6 raw_esdliu22
confirm variable raw_esdvcu22
quietly count if strlen(raw_esdvcu22)>7
if r(N)==0 recast str7 raw_esdvcu22
confirm variable raw_esdlie22
quietly count if strlen(raw_esdlie22)>6
if r(N)==0 recast str6 raw_esdlie22
confirm variable raw_esdvce22
quietly count if strlen(raw_esdvce22)>7
if r(N)==0 recast str7 raw_esdvce22
confirm variable raw_ediliu22
quietly count if strlen(raw_ediliu22)>8
if r(N)==0 recast str8 raw_ediliu22
confirm variable raw_edivcu22
quietly count if strlen(raw_edivcu22)>8
if r(N)==0 recast str8 raw_edivcu22
confirm variable raw_edilie22
quietly count if strlen(raw_edilie22)>7
if r(N)==0 recast str7 raw_edilie22
confirm variable raw_edivce22
quietly count if strlen(raw_edivce22)>8
if r(N)==0 recast str8 raw_edivce22
confirm variable raw_eclkgu22
quietly count if strlen(raw_eclkgu22)>6
if r(N)==0 recast str6 raw_eclkgu22
confirm variable raw_eclvcu22
quietly count if strlen(raw_eclvcu22)>9
if r(N)==0 recast str9 raw_eclvcu22
confirm variable raw_eclkge22
quietly count if strlen(raw_eclkge22)>6
if r(N)==0 recast str6 raw_eclkge22
confirm variable raw_eclvce22
quietly count if strlen(raw_eclvce22)>9
if r(N)==0 recast str9 raw_eclvce22
confirm variable raw_eckkgu22
quietly count if strlen(raw_eckkgu22)>1
if r(N)==0 recast str1 raw_eckkgu22
confirm variable raw_eckvcu22
quietly count if strlen(raw_eckvcu22)>1
if r(N)==0 recast str1 raw_eckvcu22
confirm variable raw_eckkge22
quietly count if strlen(raw_eckkge22)>1
if r(N)==0 recast str1 raw_eckkge22
confirm variable raw_eckvce22
quietly count if strlen(raw_eckvce22)>1
if r(N)==0 recast str1 raw_eckvce22
confirm variable raw_ecbkgu22
quietly count if strlen(raw_ecbkgu22)>7
if r(N)==0 recast str7 raw_ecbkgu22
confirm variable raw_ecbvcu22
quietly count if strlen(raw_ecbvcu22)>7
if r(N)==0 recast str7 raw_ecbvcu22
confirm variable raw_ecbkge
quietly count if strlen(raw_ecbkge)>1
if r(N)==0 recast str1 raw_ecbkge
confirm variable raw_ecbvce
quietly count if strlen(raw_ecbvce)>1
if r(N)==0 recast str1 raw_ecbvce
confirm variable raw_engkgu22
quietly count if strlen(raw_engkgu22)>7
if r(N)==0 recast str7 raw_engkgu22
confirm variable raw_engvcu22
quietly count if strlen(raw_engvcu22)>9
if r(N)==0 recast str9 raw_engvcu22
confirm variable raw_engkge22
quietly count if strlen(raw_engkge22)>6
if r(N)==0 recast str6 raw_engkge22
confirm variable raw_engvce22
quietly count if strlen(raw_engvce22)>8
if r(N)==0 recast str8 raw_engvce22
confirm variable raw_efoliu22
quietly count if strlen(raw_efoliu22)>6
if r(N)==0 recast str6 raw_efoliu22
confirm variable raw_efovcu22
quietly count if strlen(raw_efovcu22)>7
if r(N)==0 recast str7 raw_efovcu22
confirm variable raw_efolie22
quietly count if strlen(raw_efolie22)>6
if r(N)==0 recast str6 raw_efolie22
confirm variable raw_efovce22
quietly count if strlen(raw_efovce22)>7
if r(N)==0 recast str7 raw_efovce22
confirm variable raw_elpkgu22
quietly count if strlen(raw_elpkgu22)>7
if r(N)==0 recast str7 raw_elpkgu22
confirm variable raw_elpvcu22
quietly count if strlen(raw_elpvcu22)>8
if r(N)==0 recast str8 raw_elpvcu22
confirm variable raw_elpkge22
quietly count if strlen(raw_elpkge22)>6
if r(N)==0 recast str6 raw_elpkge22
confirm variable raw_elpvce22
quietly count if strlen(raw_elpvce22)>7
if r(N)==0 recast str7 raw_elpvce22
confirm variable raw_ecakgu22
quietly count if strlen(raw_ecakgu22)>7
if r(N)==0 recast str7 raw_ecakgu22
confirm variable raw_ecavcu22
quietly count if strlen(raw_ecavcu22)>8
if r(N)==0 recast str8 raw_ecavcu22
confirm variable raw_ecakge22
quietly count if strlen(raw_ecakge22)>4
if r(N)==0 recast str4 raw_ecakge22
confirm variable raw_ecavce22
quietly count if strlen(raw_ecavce22)>7
if r(N)==0 recast str7 raw_ecavce22
confirm variable raw_ecades22
quietly count if strlen(raw_ecades22)>30
if r(N)==0 recast str30 raw_ecades22
confirm variable raw_encvcu22
quietly count if strlen(raw_encvcu22)>8
if r(N)==0 recast str8 raw_encvcu22
confirm variable raw_encvce22
quietly count if strlen(raw_encvce22)>7
if r(N)==0 recast str7 raw_encvce22
confirm variable raw_encdes22
quietly count if strlen(raw_encdes22)>21
if r(N)==0 recast str21 raw_encdes22
confirm variable raw_eluliu22
quietly count if strlen(raw_eluliu22)>8
if r(N)==0 recast str8 raw_eluliu22
confirm variable raw_eluvcu22
quietly count if strlen(raw_eluvcu22)>9
if r(N)==0 recast str9 raw_eluvcu22
confirm variable raw_elulie22
quietly count if strlen(raw_elulie22)>6
if r(N)==0 recast str6 raw_elulie22
confirm variable raw_eluvce22
quietly count if strlen(raw_eluvce22)>7
if r(N)==0 recast str7 raw_eluvce22
confirm variable raw_efuvcu22
quietly count if strlen(raw_efuvcu22)>10
if r(N)==0 recast str10 raw_efuvcu22
confirm variable raw_efuvce22
quietly count if strlen(raw_efuvce22)>9
if r(N)==0 recast str9 raw_efuvce22
confirm variable raw_epckva22
quietly count if strlen(raw_epckva22)>10
if r(N)==0 recast str10 raw_epckva22
confirm variable raw_eplkhu22
quietly count if strlen(raw_eplkhu22)>9
if r(N)==0 recast str9 raw_eplkhu22
confirm variable raw_eplvcu22
quietly count if strlen(raw_eplvcu22)>9
if r(N)==0 recast str9 raw_eplvcu22
confirm variable raw_enpkhu22
quietly count if strlen(raw_enpkhu22)>8
if r(N)==0 recast str8 raw_enpkhu22
confirm variable raw_enpvcu22
quietly count if strlen(raw_enpvcu22)>9
if r(N)==0 recast str9 raw_enpvcu22
confirm variable raw_mgekin22
quietly count if strlen(raw_mgekin22)>32
if r(N)==0 recast str32 raw_mgekin22
confirm variable raw_mgenou22
quietly count if strlen(raw_mgenou22)>6
if r(N)==0 recast str6 raw_mgenou22
confirm variable raw_mgekwu22
quietly count if strlen(raw_mgekwu22)>8
if r(N)==0 recast str8 raw_mgekwu22
confirm variable raw_esgkhu22
quietly count if strlen(raw_esgkhu22)>10
if r(N)==0 recast str10 raw_esgkhu22
confirm variable raw_oeukhu22
quietly count if strlen(raw_oeukhu22)>9
if r(N)==0 recast str9 raw_oeukhu22
confirm variable raw_oelkhu22
quietly count if strlen(raw_oelkhu22)>6
if r(N)==0 recast str6 raw_oelkhu22
confirm variable raw_ibrvcu22
quietly count if strlen(raw_ibrvcu22)>9
if r(N)==0 recast str9 raw_ibrvcu22
confirm variable raw_ilrvcu22
quietly count if strlen(raw_ilrvcu22)>8
if r(N)==0 recast str8 raw_ilrvcu22
confirm variable raw_itxvcu22
quietly count if strlen(raw_itxvcu22)>9
if r(N)==0 recast str9 raw_itxvcu22
confirm variable raw_iislov22
quietly count if strlen(raw_iislov22)>9
if r(N)==0 recast str9 raw_iislov22
confirm variable raw_iisfov22
quietly count if strlen(raw_iisfov22)>8
if r(N)==0 recast str8 raw_iisfov22
confirm variable raw_iinvcu22
quietly count if strlen(raw_iinvcu22)>9
if r(N)==0 recast str9 raw_iinvcu22
confirm variable raw_icovcu22
quietly count if strlen(raw_icovcu22)>9
if r(N)==0 recast str9 raw_icovcu22
confirm variable raw_ipkvcu22
quietly count if strlen(raw_ipkvcu22)>9
if r(N)==0 recast str9 raw_ipkvcu22
confirm variable raw_idevcu22
quietly count if strlen(raw_idevcu22)>10
if r(N)==0 recast str10 raw_idevcu22
confirm variable raw_iprvcu22
quietly count if strlen(raw_iprvcu22)>10
if r(N)==0 recast str10 raw_iprvcu22
confirm variable raw_irdvcu22
quietly count if strlen(raw_irdvcu22)>9
if r(N)==0 recast str9 raw_irdvcu22
confirm variable raw_iklvcu22
quietly count if strlen(raw_iklvcu22)>9
if r(N)==0 recast str9 raw_iklvcu22
confirm variable raw_ikovcu22
quietly count if strlen(raw_ikovcu22)>9
if r(N)==0 recast str9 raw_ikovcu22
confirm variable raw_iuwvcu22
quietly count if strlen(raw_iuwvcu22)>9
if r(N)==0 recast str9 raw_iuwvcu22
confirm variable raw_iotvcu22
quietly count if strlen(raw_iotvcu22)>10
if r(N)==0 recast str10 raw_iotvcu22
confirm variable raw_it1vcu22
quietly count if strlen(raw_it1vcu22)>10
if r(N)==0 recast str10 raw_it1vcu22
confirm variable raw_impor22
quietly count if strlen(raw_impor22)>1
if r(N)==0 recast str1 raw_impor22
confirm variable raw_rdnvcu22
quietly count if strlen(raw_rdnvcu22)>11
if r(N)==0 recast str11 raw_rdnvcu22
confirm variable raw_rimvcu22
quietly count if strlen(raw_rimvcu22)>11
if r(N)==0 recast str11 raw_rimvcu22
confirm variable raw_prprca22
quietly count if strlen(raw_prprca22)>3
if r(N)==0 recast str3 raw_prprca22
confirm variable raw_ekspor22
quietly count if strlen(raw_ekspor22)>1
if r(N)==0 recast str1 raw_ekspor22
confirm variable raw_yprvcu22
quietly count if strlen(raw_yprvcu22)>17
if r(N)==0 recast str17 raw_yprvcu22
confirm variable raw_yisvdo22
quietly count if strlen(raw_yisvdo22)>11
if r(N)==0 recast str11 raw_yisvdo22
confirm variable raw_yisvfo22
quietly count if strlen(raw_yisvfo22)>9
if r(N)==0 recast str9 raw_yisvfo22
confirm variable raw_yisvcu22
quietly count if strlen(raw_yisvcu22)>11
if r(N)==0 recast str11 raw_yisvcu22
confirm variable raw_yrsvcu22
quietly count if strlen(raw_yrsvcu22)>9
if r(N)==0 recast str9 raw_yrsvcu22
confirm variable raw_ykdvcu22
quietly count if strlen(raw_ykdvcu22)>9
if r(N)==0 recast str9 raw_ykdvcu22
confirm variable raw_ykfvcu22
quietly count if strlen(raw_ykfvcu22)>1
if r(N)==0 recast str1 raw_ykfvcu22
confirm variable raw_ysnvcu22
quietly count if strlen(raw_ysnvcu22)>9
if r(N)==0 recast str9 raw_ysnvcu22
confirm variable raw_yelvcu22
quietly count if strlen(raw_yelvcu22)>7
if r(N)==0 recast str7 raw_yelvcu22
confirm variable raw_nopvcu22
quietly count if strlen(raw_nopvcu22)>9
if r(N)==0 recast str9 raw_nopvcu22
confirm variable raw_yrnvcu22
quietly count if strlen(raw_yrnvcu22)>10
if r(N)==0 recast str10 raw_yrnvcu22
confirm variable raw_yrndes22
quietly count if strlen(raw_yrndes22)>54
if r(N)==0 recast str54 raw_yrndes22
confirm variable raw_ytovcu22
quietly count if strlen(raw_ytovcu22)>10
if r(N)==0 recast str10 raw_ytovcu22
confirm variable raw_srjvcu22
quietly count if strlen(raw_srjvcu22)>10
if r(N)==0 recast str10 raw_srjvcu22
confirm variable raw_srdvcu22
quietly count if strlen(raw_srdvcu22)>10
if r(N)==0 recast str10 raw_srdvcu22
confirm variable raw_shjvcu22
quietly count if strlen(raw_shjvcu22)>9
if r(N)==0 recast str9 raw_shjvcu22
confirm variable raw_shdvcu22
quietly count if strlen(raw_shdvcu22)>10
if r(N)==0 recast str10 raw_shdvcu22
confirm variable raw_sfjvcu22
quietly count if strlen(raw_sfjvcu22)>10
if r(N)==0 recast str10 raw_sfjvcu22
confirm variable raw_sfdvcu22
quietly count if strlen(raw_sfdvcu22)>10
if r(N)==0 recast str10 raw_sfdvcu22
confirm variable raw_stjvcu22
quietly count if strlen(raw_stjvcu22)>11
if r(N)==0 recast str11 raw_stjvcu22
confirm variable raw_stdvcu22
quietly count if strlen(raw_stdvcu22)>10
if r(N)==0 recast str10 raw_stdvcu22
confirm variable raw_clfpcu22
quietly count if strlen(raw_clfpcu22)>11
if r(N)==0 recast str11 raw_clfpcu22
confirm variable raw_clttcu22
quietly count if strlen(raw_clttcu22)>11
if r(N)==0 recast str11 raw_clttcu22
confirm variable raw_clsacu22
quietly count if strlen(raw_clsacu22)>11
if r(N)==0 recast str11 raw_clsacu22
confirm variable raw_cbfpcu22
quietly count if strlen(raw_cbfpcu22)>11
if r(N)==0 recast str11 raw_cbfpcu22
confirm variable raw_cbttcu22
quietly count if strlen(raw_cbttcu22)>11
if r(N)==0 recast str11 raw_cbttcu22
confirm variable raw_cbsacu22
quietly count if strlen(raw_cbsacu22)>11
if r(N)==0 recast str11 raw_cbsacu22
confirm variable raw_cmfpcu22
quietly count if strlen(raw_cmfpcu22)>11
if r(N)==0 recast str11 raw_cmfpcu22
confirm variable raw_cmttcu22
quietly count if strlen(raw_cmttcu22)>11
if r(N)==0 recast str11 raw_cmttcu22
confirm variable raw_cmsacu22
quietly count if strlen(raw_cmsacu22)>11
if r(N)==0 recast str11 raw_cmsacu22
confirm variable raw_cvfpcu22
quietly count if strlen(raw_cvfpcu22)>11
if r(N)==0 recast str11 raw_cvfpcu22
confirm variable raw_cvttcu22
quietly count if strlen(raw_cvttcu22)>10
if r(N)==0 recast str10 raw_cvttcu22
confirm variable raw_cvsacu22
quietly count if strlen(raw_cvsacu22)>10
if r(N)==0 recast str10 raw_cvsacu22
confirm variable raw_csfpcu22
quietly count if strlen(raw_csfpcu22)>11
if r(N)==0 recast str11 raw_csfpcu22
confirm variable raw_csttcu22
quietly count if strlen(raw_csttcu22)>10
if r(N)==0 recast str10 raw_csttcu22
confirm variable raw_r601e_k4
quietly count if strlen(raw_r601e_k4)>8
if r(N)==0 recast str8 raw_r601e_k4
confirm variable raw_cofpcu22
quietly count if strlen(raw_cofpcu22)>11
if r(N)==0 recast str11 raw_cofpcu22
confirm variable raw_cottcu22
quietly count if strlen(raw_cottcu22)>10
if r(N)==0 recast str10 raw_cottcu22
confirm variable raw_cosacu22
quietly count if strlen(raw_cosacu22)>10
if r(N)==0 recast str10 raw_cosacu22
confirm variable raw_ctfpcu22
quietly count if strlen(raw_ctfpcu22)>12
if r(N)==0 recast str12 raw_ctfpcu22
confirm variable raw_ctttcu22
quietly count if strlen(raw_ctttcu22)>11
if r(N)==0 recast str11 raw_ctttcu22
confirm variable raw_ctsacu22
quietly count if strlen(raw_ctsacu22)>11
if r(N)==0 recast str11 raw_ctsacu22
confirm variable raw_r703fbln
quietly count if strlen(raw_r703fbln)>2
if r(N)==0 recast str2 raw_r703fbln
confirm variable raw_flg22p
quietly count if strlen(raw_flg22p)>4
if r(N)==0 recast str4 raw_flg22p
confirm variable raw_est
quietly count if strlen(raw_est)>1
if r(N)==0 recast str1 raw_est
confirm variable raw_lprnou22
quietly count if strlen(raw_lprnou22)>5
if r(N)==0 recast str5 raw_lprnou22
confirm variable raw_lnpnou22
quietly count if strlen(raw_lnpnou22)>4
if r(N)==0 recast str4 raw_lnpnou22
confirm variable raw_ltlnou22
quietly count if strlen(raw_ltlnou22)>5
if r(N)==0 recast str5 raw_ltlnou22
confirm variable raw_pengtk22
quietly count if strlen(raw_pengtk22)>10
if r(N)==0 recast str10 raw_pengtk22
confirm variable raw_rtlvcu22
quietly count if strlen(raw_rtlvcu22)>11
if r(N)==0 recast str11 raw_rtlvcu22
confirm variable raw_srmvcu22
quietly count if strlen(raw_srmvcu22)>11
if r(N)==0 recast str11 raw_srmvcu22
confirm variable raw_shfvcu22
quietly count if strlen(raw_shfvcu22)>10
if r(N)==0 recast str10 raw_shfvcu22
confirm variable raw_sfnvcu22
quietly count if strlen(raw_sfnvcu22)>11
if r(N)==0 recast str11 raw_sfnvcu22
confirm variable raw_stlvcu22
quietly count if strlen(raw_stlvcu22)>12
if r(N)==0 recast str12 raw_stlvcu22
confirm variable raw_output22
quietly count if strlen(raw_output22)>17
if r(N)==0 recast str17 raw_output22
confirm variable raw_iinput22
quietly count if strlen(raw_iinput22)>11
if r(N)==0 recast str11 raw_iinput22
confirm variable raw_vtlvcu22
quietly count if strlen(raw_vtlvcu22)>17
if r(N)==0 recast str17 raw_vtlvcu22
confirm variable st_amdal_raw
capture recast byte st_amdal_raw
confirm variable st_b3wste_raw
capture recast byte st_b3wste_raw
confirm variable st_capital_additions_nominal
capture recast byte st_capital_additions_nominal
confirm variable st_capital_nominal
capture recast byte st_capital_nominal
confirm variable st_capital_stock_nominal
capture recast byte st_capital_stock_nominal
confirm variable st_export_binary_raw
capture recast byte st_export_binary_raw
confirm variable st_export_share_pct
capture recast byte st_export_share_pct
confirm variable st_foreign_ownership_pct
capture recast byte st_foreign_ownership_pct
confirm variable st_gross_output_nominal
capture recast byte st_gross_output_nominal
confirm variable st_import_value_nominal
capture recast byte st_import_value_nominal
confirm variable st_innovation_marketing_raw
capture recast byte st_innovation_marketing_raw
confirm variable st_innovation_org_raw
capture recast byte st_innovation_org_raw
confirm variable st_innovation_process_raw
capture recast byte st_innovation_process_raw
confirm variable st_innovation_product_raw
capture recast byte st_innovation_product_raw
confirm variable st_innovation_raw
capture recast byte st_innovation_raw
confirm variable st_inspli_raw
capture recast byte st_inspli_raw
confirm variable st_intermediate_inputs_nominal
capture recast byte st_intermediate_inputs_nominal
confirm variable st_liwste_raw
capture recast byte st_liwste_raw
confirm variable st_pplihi_raw
capture recast byte st_pplihi_raw
confirm variable st_production_workers
capture recast byte st_production_workers
confirm variable st_rd_cost_nominal
capture recast byte st_rd_cost_nominal
confirm variable st_rd_indicator_raw
capture recast byte st_rd_indicator_raw
confirm variable st_rd_workers
capture recast byte st_rd_workers
confirm variable st_sowste_raw
capture recast byte st_sowste_raw
confirm variable st_spplhi_raw
capture recast byte st_spplhi_raw
confirm variable st_val_cbdacu
capture recast byte st_val_cbdacu
confirm variable st_val_cbfpcu
capture recast byte st_val_cbfpcu
confirm variable st_val_cbsacu
capture recast byte st_val_cbsacu
confirm variable st_val_cbttcu
capture recast byte st_val_cbttcu
confirm variable st_val_cldacu
capture recast byte st_val_cldacu
confirm variable st_val_clfpcu
capture recast byte st_val_clfpcu
confirm variable st_val_clsacu
capture recast byte st_val_clsacu
confirm variable st_val_clttcu
capture recast byte st_val_clttcu
confirm variable st_val_cmdacu
capture recast byte st_val_cmdacu
confirm variable st_val_cmfpcu
capture recast byte st_val_cmfpcu
confirm variable st_val_cmsacu
capture recast byte st_val_cmsacu
confirm variable st_val_cmttcu
capture recast byte st_val_cmttcu
confirm variable st_val_codacu
capture recast byte st_val_codacu
confirm variable st_val_cofpcu
capture recast byte st_val_cofpcu
confirm variable st_val_cosacu
capture recast byte st_val_cosacu
confirm variable st_val_costrd
capture recast byte st_val_costrd
confirm variable st_val_cottcu
capture recast byte st_val_cottcu
confirm variable st_val_csdacu
capture recast byte st_val_csdacu
confirm variable st_val_csfpcu
capture recast byte st_val_csfpcu
confirm variable st_val_cssacu
capture recast byte st_val_cssacu
confirm variable st_val_csttcu
capture recast byte st_val_csttcu
confirm variable st_val_ctdacu
capture recast byte st_val_ctdacu
confirm variable st_val_ctfpcu
capture recast byte st_val_ctfpcu
confirm variable st_val_ctsacu
capture recast byte st_val_ctsacu
confirm variable st_val_cttcu
capture recast byte st_val_cttcu
confirm variable st_val_ctttcu
capture recast byte st_val_ctttcu
confirm variable st_val_cvdacu
capture recast byte st_val_cvdacu
confirm variable st_val_cvfpcu
capture recast byte st_val_cvfpcu
confirm variable st_val_cvsacu
capture recast byte st_val_cvsacu
confirm variable st_val_cvttcu
capture recast byte st_val_cvttcu
confirm variable st_val_devvcu
capture recast byte st_val_devvcu
confirm variable st_val_ecavce
capture recast byte st_val_ecavce
confirm variable st_val_ecavcu
capture recast byte st_val_ecavcu
confirm variable st_val_ecbvce
capture recast byte st_val_ecbvce
confirm variable st_val_ecbvcu
capture recast byte st_val_ecbvcu
confirm variable st_val_eckvce
capture recast byte st_val_eckvce
confirm variable st_val_eckvcu
capture recast byte st_val_eckvcu
confirm variable st_val_eclvce
capture recast byte st_val_eclvce
confirm variable st_val_eclvcu
capture recast byte st_val_eclvcu
confirm variable st_val_edivce
capture recast byte st_val_edivce
confirm variable st_val_edivcu
capture recast byte st_val_edivcu
confirm variable st_val_efovce
capture recast byte st_val_efovce
confirm variable st_val_efovcu
capture recast byte st_val_efovcu
confirm variable st_val_efuvce
capture recast byte st_val_efuvce
confirm variable st_val_efuvcu
capture recast byte st_val_efuvcu
confirm variable st_val_egavce
capture recast byte st_val_egavce
confirm variable st_val_egavcu
capture recast byte st_val_egavcu
confirm variable st_val_egovce
capture recast byte st_val_egovce
confirm variable st_val_egovcu
capture recast byte st_val_egovcu
confirm variable st_val_elpvce
capture recast byte st_val_elpvce
confirm variable st_val_elpvcu
capture recast byte st_val_elpvcu
confirm variable st_val_eluvce
capture recast byte st_val_eluvce
confirm variable st_val_eluvcu
capture recast byte st_val_eluvcu
confirm variable st_val_encvce
capture recast byte st_val_encvce
confirm variable st_val_encvcu
capture recast byte st_val_encvcu
confirm variable st_val_engvce
capture recast byte st_val_engvce
confirm variable st_val_engvcu
capture recast byte st_val_engvcu
confirm variable st_val_enpvcu
capture recast byte st_val_enpvcu
confirm variable st_val_eoivce
capture recast byte st_val_eoivce
confirm variable st_val_eoivcu
capture recast byte st_val_eoivcu
confirm variable st_val_epevce
capture recast byte st_val_epevce
confirm variable st_val_epevcu
capture recast byte st_val_epevcu
confirm variable st_val_eplvcu
capture recast byte st_val_eplvcu
confirm variable st_val_esdvce
capture recast byte st_val_esdvce
confirm variable st_val_esdvcu
capture recast byte st_val_esdvcu
confirm variable st_val_esovce
capture recast byte st_val_esovce
confirm variable st_val_esovcu
capture recast byte st_val_esovcu
confirm variable st_val_ibrvcu
capture recast byte st_val_ibrvcu
confirm variable st_val_icovcu
capture recast byte st_val_icovcu
confirm variable st_val_idevcu
capture recast byte st_val_idevcu
confirm variable st_val_iinput
capture recast byte st_val_iinput
confirm variable st_val_iinvcu
capture recast byte st_val_iinvcu
confirm variable st_val_iisfov
capture recast byte st_val_iisfov
confirm variable st_val_iislov
capture recast byte st_val_iislov
confirm variable st_val_iisvcu
capture recast byte st_val_iisvcu
confirm variable st_val_ikivcu
capture recast byte st_val_ikivcu
confirm variable st_val_iklvcu
capture recast byte st_val_iklvcu
confirm variable st_val_ikovcu
capture recast byte st_val_ikovcu
confirm variable st_val_ilrvcu
capture recast byte st_val_ilrvcu
confirm variable st_val_insvcu
capture recast byte st_val_insvcu
confirm variable st_val_intvcu
capture recast byte st_val_intvcu
confirm variable st_val_iotvcu
capture recast byte st_val_iotvcu
confirm variable st_val_ipkvcu
capture recast byte st_val_ipkvcu
confirm variable st_val_iprvcu
capture recast byte st_val_iprvcu
confirm variable st_val_irdvcu
capture recast byte st_val_irdvcu
confirm variable st_val_irevcu
capture recast byte st_val_irevcu
confirm variable st_val_irrvcu
capture recast byte st_val_irrvcu
confirm variable st_val_itxvcu
capture recast byte st_val_itxvcu
confirm variable st_val_iuwvcu
capture recast byte st_val_iuwvcu
confirm variable st_val_nopvcu
capture recast byte st_val_nopvcu
confirm variable st_val_othvcu
capture recast byte st_val_othvcu
confirm variable st_val_output
capture recast byte st_val_output
confirm variable st_val_rdnvcu
capture recast byte st_val_rdnvcu
confirm variable st_val_renvcu
capture recast byte st_val_renvcu
confirm variable st_val_rimvcu
capture recast byte st_val_rimvcu
confirm variable st_val_rtlvcu
capture recast byte st_val_rtlvcu
confirm variable st_val_sfbvcu
capture recast byte st_val_sfbvcu
confirm variable st_val_sfcvcu
capture recast byte st_val_sfcvcu
confirm variable st_val_sfdvcu
capture recast byte st_val_sfdvcu
confirm variable st_val_sfgvcu
capture recast byte st_val_sfgvcu
confirm variable st_val_sfjvcu
capture recast byte st_val_sfjvcu
confirm variable st_val_sfkvcu
capture recast byte st_val_sfkvcu
confirm variable st_val_sfnvcu
capture recast byte st_val_sfnvcu
confirm variable st_val_sfovcu
capture recast byte st_val_sfovcu
confirm variable st_val_sfrvcu
capture recast byte st_val_sfrvcu
confirm variable st_val_sfsvcu
capture recast byte st_val_sfsvcu
confirm variable st_val_sfuvcu
capture recast byte st_val_sfuvcu
confirm variable st_val_shdvcu
capture recast byte st_val_shdvcu
confirm variable st_val_shfvcu
capture recast byte st_val_shfvcu
confirm variable st_val_shjvcu
capture recast byte st_val_shjvcu
confirm variable st_val_srdvcu
capture recast byte st_val_srdvcu
confirm variable st_val_srjvcu
capture recast byte st_val_srjvcu
confirm variable st_val_srmvcu
capture recast byte st_val_srmvcu
confirm variable st_val_stdvcu
capture recast byte st_val_stdvcu
confirm variable st_val_stjvcu
capture recast byte st_val_stjvcu
confirm variable st_val_stlvcu
capture recast byte st_val_stlvcu
confirm variable st_val_vtlvcu
capture recast byte st_val_vtlvcu
confirm variable st_val_yelvcu
capture recast byte st_val_yelvcu
confirm variable st_val_yisvcu
capture recast byte st_val_yisvcu
confirm variable st_val_yisvdo
capture recast byte st_val_yisvdo
confirm variable st_val_yisvfo
capture recast byte st_val_yisvfo
confirm variable st_val_ykdvcu
capture recast byte st_val_ykdvcu
confirm variable st_val_ykfvcu
capture recast byte st_val_ykfvcu
confirm variable st_val_ykivcu
capture recast byte st_val_ykivcu
confirm variable st_val_yprvcu
capture recast byte st_val_yprvcu
confirm variable st_val_yrnvcu
capture recast byte st_val_yrnvcu
confirm variable st_val_yrsvcu
capture recast byte st_val_yrsvcu
confirm variable st_val_ysnvcu
capture recast byte st_val_ysnvcu
confirm variable st_val_ytovcu
capture recast byte st_val_ytovcu
confirm variable st_val_znavcu
capture recast byte st_val_znavcu
confirm variable st_val_zndvcu
capture recast byte st_val_zndvcu
confirm variable st_val_znevcu
capture recast byte st_val_znevcu
confirm variable st_val_znhvcu
capture recast byte st_val_znhvcu
confirm variable st_val_znivcu
capture recast byte st_val_znivcu
confirm variable st_val_znovcu
capture recast byte st_val_znovcu
confirm variable st_val_znpvcu
capture recast byte st_val_znpvcu
confirm variable st_val_znrvcu
capture recast byte st_val_znrvcu
confirm variable st_val_znsvcu
capture recast byte st_val_znsvcu
confirm variable st_val_zntvcu
capture recast byte st_val_zntvcu
confirm variable st_val_zpavcu
capture recast byte st_val_zpavcu
confirm variable st_val_zpdvcu
capture recast byte st_val_zpdvcu
confirm variable st_val_zpevcu
capture recast byte st_val_zpevcu
confirm variable st_val_zphvcu
capture recast byte st_val_zphvcu
confirm variable st_val_zpivcu
capture recast byte st_val_zpivcu
confirm variable st_val_zpovcu
capture recast byte st_val_zpovcu
confirm variable st_val_zppvcu
capture recast byte st_val_zppvcu
confirm variable st_val_zprvcu
capture recast byte st_val_zprvcu
confirm variable st_val_zpsvcu
capture recast byte st_val_zpsvcu
confirm variable st_val_zptvcu
capture recast byte st_val_zptvcu
confirm variable st_value_added_nominal
capture recast byte st_value_added_nominal
confirm variable st_workers
capture recast byte st_workers
confirm variable st_elec_nonpln_kwh
capture recast byte st_elec_nonpln_kwh
confirm variable st_elec_nonpln_rp000
capture recast byte st_elec_nonpln_rp000
confirm variable st_elec_owngen_kwh
capture recast byte st_elec_owngen_kwh
confirm variable st_elec_pln_kwh
capture recast byte st_elec_pln_kwh
confirm variable st_elec_pln_rp000
capture recast byte st_elec_pln_rp000
confirm variable st_fuel_biodiesel_ltr
capture recast byte st_fuel_biodiesel_ltr
confirm variable st_fuel_biodiesel_rp000
capture recast byte st_fuel_biodiesel_rp000
confirm variable st_fuel_charcoal_kg
capture recast byte st_fuel_charcoal_kg
confirm variable st_fuel_charcoal_rp000
capture recast byte st_fuel_charcoal_rp000
confirm variable st_fuel_citygas_m3
capture recast byte st_fuel_citygas_m3
confirm variable st_fuel_citygas_rp000
capture recast byte st_fuel_citygas_rp000
confirm variable st_fuel_coal_kg
capture recast byte st_fuel_coal_kg
confirm variable st_fuel_coal_rp000
capture recast byte st_fuel_coal_rp000
confirm variable st_fuel_coalbriq_kg
capture recast byte st_fuel_coalbriq_kg
confirm variable st_fuel_coalbriq_rp000
capture recast byte st_fuel_coalbriq_rp000
confirm variable st_fuel_coke_kg
capture recast byte st_fuel_coke_kg
confirm variable st_fuel_coke_rp000
capture recast byte st_fuel_coke_rp000
confirm variable st_fuel_diesel_ltr
capture recast byte st_fuel_diesel_ltr
confirm variable st_fuel_diesel_rp000
capture recast byte st_fuel_diesel_rp000
confirm variable st_fuel_dieseloil_ltr
capture recast byte st_fuel_dieseloil_ltr
confirm variable st_fuel_dieseloil_rp000
capture recast byte st_fuel_dieseloil_rp000
confirm variable st_fuel_firewood_kg
capture recast byte st_fuel_firewood_kg
confirm variable st_fuel_firewood_rp000
capture recast byte st_fuel_firewood_rp000
confirm variable st_fuel_fueloil_ltr
capture recast byte st_fuel_fueloil_ltr
confirm variable st_fuel_fueloil_rp000
capture recast byte st_fuel_fueloil_rp000
confirm variable st_fuel_kerosene_ltr
capture recast byte st_fuel_kerosene_ltr
confirm variable st_fuel_kerosene_rp000
capture recast byte st_fuel_kerosene_rp000
confirm variable st_fuel_lpg_kg
capture recast byte st_fuel_lpg_kg
confirm variable st_fuel_lpg_rp000
capture recast byte st_fuel_lpg_rp000
confirm variable st_fuel_lubricant_ltr
capture recast byte st_fuel_lubricant_ltr
confirm variable st_fuel_lubricant_rp000
capture recast byte st_fuel_lubricant_rp000
confirm variable st_fuel_natgas_kg
capture recast byte st_fuel_natgas_kg
confirm variable st_fuel_natgas_rp000
capture recast byte st_fuel_natgas_rp000
confirm variable st_fuel_other_rp000
capture recast byte st_fuel_other_rp000
confirm variable st_fuel_othergas_m3
capture recast byte st_fuel_othergas_m3
confirm variable st_fuel_othergas_rp000
capture recast byte st_fuel_othergas_rp000
confirm variable st_fuel_petrol_ltr
capture recast byte st_fuel_petrol_ltr
confirm variable st_fuel_petrol_rp000
capture recast byte st_fuel_petrol_rp000
confirm variable st_fuel_total_reported_rp000
capture recast byte st_fuel_total_reported_rp000
confirm variable legacy_unit_contract
capture recast byte legacy_unit_contract
confirm variable unit_status
quietly count if strlen(unit_status)>63
if r(N)==0 recast str63 unit_status
confirm variable grid_factor_s1
capture recast double grid_factor_s1
confirm variable grid_factor_s2
capture recast double grid_factor_s2
confirm variable factor_status
quietly count if strlen(factor_status)>28
if r(N)==0 recast str28 factor_status
confirm variable factor_contract
quietly count if strlen(factor_contract)>48
if r(N)==0 recast str48 factor_contract
confirm variable any_negative_quantity
capture recast byte any_negative_quantity
confirm variable any_implausible_price
capture recast byte any_implausible_price
confirm variable cl_fuel_biodiesel_ltr
capture recast long cl_fuel_biodiesel_ltr
confirm variable cl_fuel_biodiesel_rp000
capture recast long cl_fuel_biodiesel_rp000
confirm variable cl_fuel_charcoal_kg
capture recast long cl_fuel_charcoal_kg
confirm variable cl_fuel_charcoal_rp000
capture recast long cl_fuel_charcoal_rp000
confirm variable cl_fuel_citygas_m3
capture recast long cl_fuel_citygas_m3
confirm variable cl_fuel_citygas_rp000
capture recast long cl_fuel_citygas_rp000
confirm variable cl_fuel_coal_kg
capture recast double cl_fuel_coal_kg
confirm variable cl_fuel_coal_rp000
capture recast long cl_fuel_coal_rp000
confirm variable cl_fuel_coalbriq_kg
capture recast long cl_fuel_coalbriq_kg
confirm variable cl_fuel_coalbriq_rp000
capture recast long cl_fuel_coalbriq_rp000
confirm variable cl_fuel_coke_kg
capture recast byte cl_fuel_coke_kg
confirm variable cl_fuel_coke_rp000
capture recast byte cl_fuel_coke_rp000
confirm variable cl_fuel_diesel_ltr
capture recast long cl_fuel_diesel_ltr
confirm variable cl_fuel_diesel_rp000
capture recast long cl_fuel_diesel_rp000
confirm variable cl_fuel_dieseloil_ltr
capture recast long cl_fuel_dieseloil_ltr
confirm variable cl_fuel_dieseloil_rp000
capture recast long cl_fuel_dieseloil_rp000
confirm variable cl_fuel_firewood_kg
capture recast byte cl_fuel_firewood_kg
confirm variable cl_fuel_firewood_rp000
capture recast byte cl_fuel_firewood_rp000
confirm variable cl_fuel_fueloil_ltr
capture recast long cl_fuel_fueloil_ltr
confirm variable cl_fuel_fueloil_rp000
capture recast long cl_fuel_fueloil_rp000
confirm variable cl_fuel_kerosene_ltr
capture recast long cl_fuel_kerosene_ltr
confirm variable cl_fuel_kerosene_rp000
capture recast long cl_fuel_kerosene_rp000
confirm variable cl_fuel_lpg_kg
capture recast long cl_fuel_lpg_kg
confirm variable cl_fuel_lpg_rp000
capture recast long cl_fuel_lpg_rp000
confirm variable cl_fuel_lubricant_ltr
capture recast long cl_fuel_lubricant_ltr
confirm variable cl_fuel_lubricant_rp000
capture recast long cl_fuel_lubricant_rp000
confirm variable cl_fuel_natgas_kg
capture recast long cl_fuel_natgas_kg
confirm variable cl_fuel_natgas_rp000
capture recast long cl_fuel_natgas_rp000
confirm variable cl_fuel_other_rp000
capture recast long cl_fuel_other_rp000
confirm variable cl_fuel_othergas_m3
capture recast long cl_fuel_othergas_m3
confirm variable cl_fuel_othergas_rp000
capture recast long cl_fuel_othergas_rp000
confirm variable cl_fuel_petrol_ltr
capture recast long cl_fuel_petrol_ltr
confirm variable cl_fuel_petrol_rp000
capture recast long cl_fuel_petrol_rp000
confirm variable cl_fuel_total_reported_rp000
capture recast long cl_fuel_total_reported_rp000
confirm variable cl_elec_nonpln_kwh
capture recast long cl_elec_nonpln_kwh
confirm variable cl_elec_nonpln_rp000
capture recast long cl_elec_nonpln_rp000
confirm variable cl_elec_owngen_kwh
capture recast long cl_elec_owngen_kwh
confirm variable cl_elec_pln_kwh
capture recast double cl_elec_pln_kwh
confirm variable cl_elec_pln_rp000
capture recast double cl_elec_pln_rp000
confirm variable price_diesel
capture recast double price_diesel
confirm variable p99_diesel
capture recast double p99_diesel
confirm variable price_petrol
capture recast double price_petrol
confirm variable p99_petrol
capture recast double p99_petrol
confirm variable price_kerosene
capture recast double price_kerosene
confirm variable p99_kerosene
capture recast double p99_kerosene
confirm variable price_coal
capture recast double price_coal
confirm variable price_lpg
capture recast double price_lpg
confirm variable p99_lpg
capture recast double p99_lpg
confirm variable price_citygas
capture recast double price_citygas
confirm variable p99_citygas
capture recast double p99_citygas
confirm variable price_othergas
capture recast double price_othergas
confirm variable p99_othergas
capture recast double p99_othergas
confirm variable price_coalbriq
capture recast double price_coalbriq
confirm variable p99_coalbriq
capture recast double p99_coalbriq
confirm variable price_coke
capture recast byte price_coke
confirm variable price_firewood
capture recast byte price_firewood
confirm variable p99_firewood
capture recast byte p99_firewood
confirm variable price_charcoal
capture recast double price_charcoal
confirm variable price_dieseloil
capture recast double price_dieseloil
confirm variable p99_dieseloil
capture recast double p99_dieseloil
confirm variable price_fueloil
capture recast double price_fueloil
confirm variable p99_fueloil
capture recast double p99_fueloil
confirm variable price_lubricant
capture recast double price_lubricant
confirm variable p99_lubricant
capture recast double p99_lubricant
confirm variable price_biodiesel
capture recast double price_biodiesel
confirm variable p99_biodiesel
capture recast double p99_biodiesel
confirm variable price_natgas
capture recast double price_natgas
confirm variable price_elec
capture recast double price_elec
confirm variable p99_elec
capture recast double p99_elec
confirm variable energy_outlier_flag
capture recast byte energy_outlier_flag
confirm variable energy_outlier_flag_legacy
capture recast byte energy_outlier_flag_legacy
confirm variable outlier_rule
quietly count if strlen(outlier_rule)>67
if r(N)==0 recast str67 outlier_rule
confirm variable cleaning_status
quietly count if strlen(cleaning_status)>48
if r(N)==0 recast str48 cleaning_status
confirm variable fuel_components_rp000
capture recast long fuel_components_rp000
confirm variable fuel_components_extended
capture recast long fuel_components_extended
confirm variable fuel_expenditure_rp000
capture recast long fuel_expenditure_rp000
confirm variable fuel_expenditure_basis
quietly count if strlen(fuel_expenditure_basis)>14
if r(N)==0 recast str14 fuel_expenditure_basis
confirm variable fuel_reconciliation_gap
capture recast long fuel_reconciliation_gap
confirm variable fuel_reconciliation_gap_extended
capture recast long fuel_reconciliation_gap_extended
confirm variable electricity_expenditure_rp000
capture recast double electricity_expenditure_rp000
confirm variable electricity_cost_n_observed
capture recast byte electricity_cost_n_observed
confirm variable energy_expenditure_rp000
capture recast double energy_expenditure_rp000
confirm variable export_share_valid
capture recast byte export_share_valid
confirm variable export_binary_valid
capture recast byte export_binary_valid
confirm variable export_flag_conditional
capture recast byte export_flag_conditional
confirm variable export_definition_conflict
capture recast byte export_definition_conflict
confirm variable export_binary_assumed_flag
capture recast byte export_binary_assumed_flag
confirm variable export_observed
capture recast byte export_observed
confirm variable export_definition_status
quietly count if strlen(export_definition_status)>53
if r(N)==0 recast str53 export_definition_status
confirm variable import_flag
capture recast byte import_flag
confirm variable import_observed
capture recast byte import_observed
confirm variable fdi_any_flag
capture recast byte fdi_any_flag
confirm variable fdi_10_flag
capture recast byte fdi_10_flag
confirm variable fdi_observed
capture recast byte fdi_observed
confirm variable large_gt100_flag
capture recast byte large_gt100_flag
confirm variable accounting_gap
capture recast double accounting_gap
confirm variable accounting_identity_valid
capture recast byte accounting_identity_valid
confirm variable inputs_definition_status
quietly count if strlen(inputs_definition_status)>65
if r(N)==0 recast str65 inputs_definition_status
confirm variable capital_prior_mixed_nominal
capture recast double capital_prior_mixed_nominal
confirm variable capital_stock_verified
capture recast byte capital_stock_verified
confirm variable capital_additions_verified
capture recast byte capital_additions_verified
confirm variable capital_definition_status
quietly count if strlen(capital_definition_status)>55
if r(N)==0 recast str55 capital_definition_status
confirm variable capital_prior_status
quietly count if strlen(capital_prior_status)>56
if r(N)==0 recast str56 capital_prior_status
confirm variable worker_denominator_state
capture recast byte worker_denominator_state
confirm variable labor_productivity_nominal
capture recast double labor_productivity_nominal
confirm variable output_per_worker_nominal
capture recast double output_per_worker_nominal
confirm variable capital_per_worker_nominal
capture recast double capital_per_worker_nominal
confirm variable inputs_per_worker_nominal
capture recast double inputs_per_worker_nominal
confirm variable rd_cost_per_worker_nominal
capture recast double rd_cost_per_worker_nominal
confirm variable energy_cost_per_worker
capture recast double energy_cost_per_worker
confirm variable total_gj_per_worker
capture recast double total_gj_per_worker
confirm variable co2_per_worker
capture recast double co2_per_worker
confirm variable capital_stock_per_worker
capture recast double capital_stock_per_worker
confirm variable ln_capital_stock_nominal
capture recast double ln_capital_stock_nominal
confirm variable capital_additions_per_worker
capture recast double capital_additions_per_worker
confirm variable ln_capital_additions_nominal
capture recast double ln_capital_additions_nominal
confirm variable value_added_share_of_output
capture recast double value_added_share_of_output
confirm variable energy_intensity_monetary
capture recast double energy_intensity_monetary
confirm variable energy_intensity_gj_nominal
capture recast double energy_intensity_gj_nominal
confirm variable co2_intensity_nominal
capture recast double co2_intensity_nominal
confirm variable ln_output_nominal
capture recast double ln_output_nominal
confirm variable ln_va_nominal
capture recast double ln_va_nominal
confirm variable ln_capital_nominal
capture recast double ln_capital_nominal
confirm variable ln_inputs_nominal
capture recast double ln_inputs_nominal
confirm variable ln_workers
capture recast double ln_workers
confirm variable ln_total_gj_s1
capture recast double ln_total_gj_s1
confirm variable ln_co2_total_s1
capture recast double ln_co2_total_s1
confirm variable ln_energy_expenditure
capture recast double ln_energy_expenditure
confirm variable ln_import_nominal
capture recast double ln_import_nominal
confirm variable ln_rd_cost_nominal
capture recast double ln_rd_cost_nominal
confirm variable ln_val_cbdacu
capture recast double ln_val_cbdacu
confirm variable pw_val_cbdacu
capture recast double pw_val_cbdacu
confirm variable ln_val_cbfpcu
capture recast double ln_val_cbfpcu
confirm variable pw_val_cbfpcu
capture recast double pw_val_cbfpcu
confirm variable ln_val_cbsacu
capture recast double ln_val_cbsacu
confirm variable pw_val_cbsacu
capture recast double pw_val_cbsacu
confirm variable ln_val_cbttcu
capture recast double ln_val_cbttcu
confirm variable pw_val_cbttcu
capture recast double pw_val_cbttcu
confirm variable ln_val_cldacu
capture recast double ln_val_cldacu
confirm variable pw_val_cldacu
capture recast double pw_val_cldacu
confirm variable ln_val_clfpcu
capture recast double ln_val_clfpcu
confirm variable pw_val_clfpcu
capture recast double pw_val_clfpcu
confirm variable ln_val_clsacu
capture recast double ln_val_clsacu
confirm variable pw_val_clsacu
capture recast double pw_val_clsacu
confirm variable ln_val_clttcu
capture recast double ln_val_clttcu
confirm variable pw_val_clttcu
capture recast double pw_val_clttcu
confirm variable ln_val_cmdacu
capture recast double ln_val_cmdacu
confirm variable pw_val_cmdacu
capture recast double pw_val_cmdacu
confirm variable ln_val_cmfpcu
capture recast double ln_val_cmfpcu
confirm variable pw_val_cmfpcu
capture recast double pw_val_cmfpcu
confirm variable ln_val_cmsacu
capture recast double ln_val_cmsacu
confirm variable pw_val_cmsacu
capture recast double pw_val_cmsacu
confirm variable ln_val_cmttcu
capture recast double ln_val_cmttcu
confirm variable pw_val_cmttcu
capture recast double pw_val_cmttcu
confirm variable ln_val_codacu
capture recast double ln_val_codacu
confirm variable pw_val_codacu
capture recast double pw_val_codacu
confirm variable ln_val_cofpcu
capture recast double ln_val_cofpcu
confirm variable pw_val_cofpcu
capture recast double pw_val_cofpcu
confirm variable ln_val_cosacu
capture recast double ln_val_cosacu
confirm variable pw_val_cosacu
capture recast double pw_val_cosacu
confirm variable ln_val_costrd
capture recast double ln_val_costrd
confirm variable pw_val_costrd
capture recast double pw_val_costrd
confirm variable ln_val_cottcu
capture recast double ln_val_cottcu
confirm variable pw_val_cottcu
capture recast double pw_val_cottcu
confirm variable ln_val_csdacu
capture recast double ln_val_csdacu
confirm variable pw_val_csdacu
capture recast double pw_val_csdacu
confirm variable ln_val_csfpcu
capture recast double ln_val_csfpcu
confirm variable pw_val_csfpcu
capture recast double pw_val_csfpcu
confirm variable ln_val_cssacu
capture recast double ln_val_cssacu
confirm variable pw_val_cssacu
capture recast double pw_val_cssacu
confirm variable ln_val_csttcu
capture recast double ln_val_csttcu
confirm variable pw_val_csttcu
capture recast double pw_val_csttcu
confirm variable ln_val_ctdacu
capture recast double ln_val_ctdacu
confirm variable pw_val_ctdacu
capture recast double pw_val_ctdacu
confirm variable ln_val_ctfpcu
capture recast double ln_val_ctfpcu
confirm variable pw_val_ctfpcu
capture recast double pw_val_ctfpcu
confirm variable ln_val_ctsacu
capture recast double ln_val_ctsacu
confirm variable pw_val_ctsacu
capture recast double pw_val_ctsacu
confirm variable ln_val_cttcu
capture recast double ln_val_cttcu
confirm variable pw_val_cttcu
capture recast double pw_val_cttcu
confirm variable ln_val_ctttcu
capture recast double ln_val_ctttcu
confirm variable pw_val_ctttcu
capture recast double pw_val_ctttcu
confirm variable ln_val_cvdacu
capture recast double ln_val_cvdacu
confirm variable pw_val_cvdacu
capture recast double pw_val_cvdacu
confirm variable ln_val_cvfpcu
capture recast double ln_val_cvfpcu
confirm variable pw_val_cvfpcu
capture recast double pw_val_cvfpcu
confirm variable ln_val_cvsacu
capture recast double ln_val_cvsacu
confirm variable pw_val_cvsacu
capture recast double pw_val_cvsacu
confirm variable ln_val_cvttcu
capture recast double ln_val_cvttcu
confirm variable pw_val_cvttcu
capture recast double pw_val_cvttcu
confirm variable ln_val_devvcu
capture recast double ln_val_devvcu
confirm variable pw_val_devvcu
capture recast double pw_val_devvcu
confirm variable ln_val_ecavce
capture recast double ln_val_ecavce
confirm variable pw_val_ecavce
capture recast double pw_val_ecavce
confirm variable ln_val_ecavcu
capture recast double ln_val_ecavcu
confirm variable pw_val_ecavcu
capture recast double pw_val_ecavcu
confirm variable ln_val_ecbvce
capture recast double ln_val_ecbvce
confirm variable pw_val_ecbvce
capture recast double pw_val_ecbvce
confirm variable ln_val_ecbvcu
capture recast double ln_val_ecbvcu
confirm variable pw_val_ecbvcu
capture recast double pw_val_ecbvcu
confirm variable ln_val_eckvce
capture recast byte ln_val_eckvce
confirm variable pw_val_eckvce
capture recast byte pw_val_eckvce
confirm variable ln_val_eckvcu
capture recast byte ln_val_eckvcu
confirm variable pw_val_eckvcu
capture recast byte pw_val_eckvcu
confirm variable ln_val_eclvce
capture recast double ln_val_eclvce
confirm variable pw_val_eclvce
capture recast double pw_val_eclvce
confirm variable ln_val_eclvcu
capture recast double ln_val_eclvcu
confirm variable pw_val_eclvcu
capture recast double pw_val_eclvcu
confirm variable ln_val_edivce
capture recast double ln_val_edivce
confirm variable pw_val_edivce
capture recast double pw_val_edivce
confirm variable ln_val_edivcu
capture recast double ln_val_edivcu
confirm variable pw_val_edivcu
capture recast double pw_val_edivcu
confirm variable ln_val_efovce
capture recast double ln_val_efovce
confirm variable pw_val_efovce
capture recast double pw_val_efovce
confirm variable ln_val_efovcu
capture recast double ln_val_efovcu
confirm variable pw_val_efovcu
capture recast double pw_val_efovcu
confirm variable ln_val_efuvce
capture recast double ln_val_efuvce
confirm variable pw_val_efuvce
capture recast double pw_val_efuvce
confirm variable ln_val_efuvcu
capture recast double ln_val_efuvcu
confirm variable pw_val_efuvcu
capture recast double pw_val_efuvcu
confirm variable ln_val_egavce
capture recast double ln_val_egavce
confirm variable pw_val_egavce
capture recast double pw_val_egavce
confirm variable ln_val_egavcu
capture recast double ln_val_egavcu
confirm variable pw_val_egavcu
capture recast double pw_val_egavcu
confirm variable ln_val_egovce
capture recast double ln_val_egovce
confirm variable pw_val_egovce
capture recast double pw_val_egovce
confirm variable ln_val_egovcu
capture recast double ln_val_egovcu
confirm variable pw_val_egovcu
capture recast double pw_val_egovcu
confirm variable ln_val_elpvce
capture recast double ln_val_elpvce
confirm variable pw_val_elpvce
capture recast double pw_val_elpvce
confirm variable ln_val_elpvcu
capture recast double ln_val_elpvcu
confirm variable pw_val_elpvcu
capture recast double pw_val_elpvcu
confirm variable ln_val_eluvce
capture recast double ln_val_eluvce
confirm variable pw_val_eluvce
capture recast double pw_val_eluvce
confirm variable ln_val_eluvcu
capture recast double ln_val_eluvcu
confirm variable pw_val_eluvcu
capture recast double pw_val_eluvcu
confirm variable ln_val_encvce
capture recast double ln_val_encvce
confirm variable pw_val_encvce
capture recast double pw_val_encvce
confirm variable ln_val_encvcu
capture recast double ln_val_encvcu
confirm variable pw_val_encvcu
capture recast double pw_val_encvcu
confirm variable ln_val_engvce
capture recast double ln_val_engvce
confirm variable pw_val_engvce
capture recast double pw_val_engvce
confirm variable ln_val_engvcu
capture recast double ln_val_engvcu
confirm variable pw_val_engvcu
capture recast double pw_val_engvcu
confirm variable ln_val_enpvcu
capture recast double ln_val_enpvcu
confirm variable pw_val_enpvcu
capture recast double pw_val_enpvcu
confirm variable ln_val_eoivce
capture recast double ln_val_eoivce
confirm variable pw_val_eoivce
capture recast double pw_val_eoivce
confirm variable ln_val_eoivcu
capture recast double ln_val_eoivcu
confirm variable pw_val_eoivcu
capture recast double pw_val_eoivcu
confirm variable ln_val_epevce
capture recast double ln_val_epevce
confirm variable pw_val_epevce
capture recast double pw_val_epevce
confirm variable ln_val_epevcu
capture recast double ln_val_epevcu
confirm variable pw_val_epevcu
capture recast double pw_val_epevcu
confirm variable ln_val_eplvcu
capture recast double ln_val_eplvcu
confirm variable pw_val_eplvcu
capture recast double pw_val_eplvcu
confirm variable ln_val_esdvce
capture recast double ln_val_esdvce
confirm variable pw_val_esdvce
capture recast double pw_val_esdvce
confirm variable ln_val_esdvcu
capture recast double ln_val_esdvcu
confirm variable pw_val_esdvcu
capture recast double pw_val_esdvcu
confirm variable ln_val_esovce
capture recast double ln_val_esovce
confirm variable pw_val_esovce
capture recast double pw_val_esovce
confirm variable ln_val_esovcu
capture recast double ln_val_esovcu
confirm variable pw_val_esovcu
capture recast double pw_val_esovcu
confirm variable ln_val_ibrvcu
capture recast double ln_val_ibrvcu
confirm variable pw_val_ibrvcu
capture recast double pw_val_ibrvcu
confirm variable ln_val_icovcu
capture recast double ln_val_icovcu
confirm variable pw_val_icovcu
capture recast double pw_val_icovcu
confirm variable ln_val_idevcu
capture recast double ln_val_idevcu
confirm variable pw_val_idevcu
capture recast double pw_val_idevcu
confirm variable ln_val_iinput
capture recast double ln_val_iinput
confirm variable pw_val_iinput
capture recast double pw_val_iinput
confirm variable ln_val_iinvcu
capture recast double ln_val_iinvcu
confirm variable pw_val_iinvcu
capture recast double pw_val_iinvcu
confirm variable ln_val_iisfov
capture recast double ln_val_iisfov
confirm variable pw_val_iisfov
capture recast double pw_val_iisfov
confirm variable ln_val_iislov
capture recast double ln_val_iislov
confirm variable pw_val_iislov
capture recast double pw_val_iislov
confirm variable ln_val_iisvcu
capture recast double ln_val_iisvcu
confirm variable pw_val_iisvcu
capture recast double pw_val_iisvcu
confirm variable ln_val_ikivcu
capture recast double ln_val_ikivcu
confirm variable pw_val_ikivcu
capture recast double pw_val_ikivcu
confirm variable ln_val_iklvcu
capture recast double ln_val_iklvcu
confirm variable pw_val_iklvcu
capture recast double pw_val_iklvcu
confirm variable ln_val_ikovcu
capture recast double ln_val_ikovcu
confirm variable pw_val_ikovcu
capture recast double pw_val_ikovcu
confirm variable ln_val_ilrvcu
capture recast double ln_val_ilrvcu
confirm variable pw_val_ilrvcu
capture recast double pw_val_ilrvcu
confirm variable ln_val_insvcu
capture recast double ln_val_insvcu
confirm variable pw_val_insvcu
capture recast double pw_val_insvcu
confirm variable ln_val_intvcu
capture recast double ln_val_intvcu
confirm variable pw_val_intvcu
capture recast double pw_val_intvcu
confirm variable ln_val_iotvcu
capture recast double ln_val_iotvcu
confirm variable pw_val_iotvcu
capture recast double pw_val_iotvcu
confirm variable ln_val_ipkvcu
capture recast double ln_val_ipkvcu
confirm variable pw_val_ipkvcu
capture recast double pw_val_ipkvcu
confirm variable ln_val_iprvcu
capture recast double ln_val_iprvcu
confirm variable pw_val_iprvcu
capture recast double pw_val_iprvcu
confirm variable ln_val_irdvcu
capture recast double ln_val_irdvcu
confirm variable pw_val_irdvcu
capture recast double pw_val_irdvcu
confirm variable ln_val_irevcu
capture recast double ln_val_irevcu
confirm variable pw_val_irevcu
capture recast double pw_val_irevcu
confirm variable ln_val_irrvcu
capture recast double ln_val_irrvcu
confirm variable pw_val_irrvcu
capture recast double pw_val_irrvcu
confirm variable ln_val_itxvcu
capture recast double ln_val_itxvcu
confirm variable pw_val_itxvcu
capture recast double pw_val_itxvcu
confirm variable ln_val_iuwvcu
capture recast double ln_val_iuwvcu
confirm variable pw_val_iuwvcu
capture recast double pw_val_iuwvcu
confirm variable ln_val_nopvcu
capture recast double ln_val_nopvcu
confirm variable pw_val_nopvcu
capture recast double pw_val_nopvcu
confirm variable ln_val_othvcu
capture recast double ln_val_othvcu
confirm variable pw_val_othvcu
capture recast double pw_val_othvcu
confirm variable ln_val_output
capture recast double ln_val_output
confirm variable pw_val_output
capture recast double pw_val_output
confirm variable ln_val_rdnvcu
capture recast double ln_val_rdnvcu
confirm variable pw_val_rdnvcu
capture recast double pw_val_rdnvcu
confirm variable ln_val_renvcu
capture recast double ln_val_renvcu
confirm variable pw_val_renvcu
capture recast double pw_val_renvcu
confirm variable ln_val_rimvcu
capture recast double ln_val_rimvcu
confirm variable pw_val_rimvcu
capture recast double pw_val_rimvcu
confirm variable ln_val_rtlvcu
capture recast double ln_val_rtlvcu
confirm variable pw_val_rtlvcu
capture recast double pw_val_rtlvcu
confirm variable ln_val_sfbvcu
capture recast double ln_val_sfbvcu
confirm variable pw_val_sfbvcu
capture recast double pw_val_sfbvcu
confirm variable ln_val_sfcvcu
capture recast double ln_val_sfcvcu
confirm variable pw_val_sfcvcu
capture recast double pw_val_sfcvcu
confirm variable ln_val_sfdvcu
capture recast double ln_val_sfdvcu
confirm variable pw_val_sfdvcu
capture recast double pw_val_sfdvcu
confirm variable ln_val_sfgvcu
capture recast double ln_val_sfgvcu
confirm variable pw_val_sfgvcu
capture recast double pw_val_sfgvcu
confirm variable ln_val_sfjvcu
capture recast double ln_val_sfjvcu
confirm variable pw_val_sfjvcu
capture recast double pw_val_sfjvcu
confirm variable ln_val_sfkvcu
capture recast double ln_val_sfkvcu
confirm variable pw_val_sfkvcu
capture recast double pw_val_sfkvcu
confirm variable ln_val_sfnvcu
capture recast double ln_val_sfnvcu
confirm variable pw_val_sfnvcu
capture recast double pw_val_sfnvcu
confirm variable ln_val_sfovcu
capture recast double ln_val_sfovcu
confirm variable pw_val_sfovcu
capture recast double pw_val_sfovcu
confirm variable ln_val_sfrvcu
capture recast double ln_val_sfrvcu
confirm variable pw_val_sfrvcu
capture recast double pw_val_sfrvcu
confirm variable ln_val_sfsvcu
capture recast double ln_val_sfsvcu
confirm variable pw_val_sfsvcu
capture recast double pw_val_sfsvcu
confirm variable ln_val_sfuvcu
capture recast double ln_val_sfuvcu
confirm variable pw_val_sfuvcu
capture recast double pw_val_sfuvcu
confirm variable ln_val_shdvcu
capture recast double ln_val_shdvcu
confirm variable pw_val_shdvcu
capture recast double pw_val_shdvcu
confirm variable ln_val_shfvcu
capture recast double ln_val_shfvcu
confirm variable pw_val_shfvcu
capture recast double pw_val_shfvcu
confirm variable ln_val_shjvcu
capture recast double ln_val_shjvcu
confirm variable pw_val_shjvcu
capture recast double pw_val_shjvcu
confirm variable ln_val_srdvcu
capture recast double ln_val_srdvcu
confirm variable pw_val_srdvcu
capture recast double pw_val_srdvcu
confirm variable ln_val_srjvcu
capture recast double ln_val_srjvcu
confirm variable pw_val_srjvcu
capture recast double pw_val_srjvcu
confirm variable ln_val_srmvcu
capture recast double ln_val_srmvcu
confirm variable pw_val_srmvcu
capture recast double pw_val_srmvcu
confirm variable ln_val_stdvcu
capture recast double ln_val_stdvcu
confirm variable pw_val_stdvcu
capture recast double pw_val_stdvcu
confirm variable ln_val_stjvcu
capture recast double ln_val_stjvcu
confirm variable pw_val_stjvcu
capture recast double pw_val_stjvcu
confirm variable ln_val_stlvcu
capture recast double ln_val_stlvcu
confirm variable pw_val_stlvcu
capture recast double pw_val_stlvcu
confirm variable ln_val_vtlvcu
capture recast double ln_val_vtlvcu
confirm variable pw_val_vtlvcu
capture recast double pw_val_vtlvcu
confirm variable ln_val_yelvcu
capture recast double ln_val_yelvcu
confirm variable pw_val_yelvcu
capture recast double pw_val_yelvcu
confirm variable ln_val_yisvcu
capture recast double ln_val_yisvcu
confirm variable pw_val_yisvcu
capture recast double pw_val_yisvcu
confirm variable ln_val_yisvdo
capture recast double ln_val_yisvdo
confirm variable pw_val_yisvdo
capture recast double pw_val_yisvdo
confirm variable ln_val_yisvfo
capture recast double ln_val_yisvfo
confirm variable pw_val_yisvfo
capture recast double pw_val_yisvfo
confirm variable ln_val_ykdvcu
capture recast double ln_val_ykdvcu
confirm variable pw_val_ykdvcu
capture recast double pw_val_ykdvcu
confirm variable ln_val_ykfvcu
capture recast double ln_val_ykfvcu
confirm variable pw_val_ykfvcu
capture recast double pw_val_ykfvcu
confirm variable ln_val_ykivcu
capture recast double ln_val_ykivcu
confirm variable pw_val_ykivcu
capture recast double pw_val_ykivcu
confirm variable ln_val_yprvcu
capture recast double ln_val_yprvcu
confirm variable pw_val_yprvcu
capture recast double pw_val_yprvcu
confirm variable ln_val_yrnvcu
capture recast double ln_val_yrnvcu
confirm variable pw_val_yrnvcu
capture recast double pw_val_yrnvcu
confirm variable ln_val_yrsvcu
capture recast double ln_val_yrsvcu
confirm variable pw_val_yrsvcu
capture recast double pw_val_yrsvcu
confirm variable ln_val_ysnvcu
capture recast double ln_val_ysnvcu
confirm variable pw_val_ysnvcu
capture recast double pw_val_ysnvcu
confirm variable ln_val_ytovcu
capture recast double ln_val_ytovcu
confirm variable pw_val_ytovcu
capture recast double pw_val_ytovcu
confirm variable ln_val_znavcu
capture recast double ln_val_znavcu
confirm variable pw_val_znavcu
capture recast double pw_val_znavcu
confirm variable ln_val_zndvcu
capture recast double ln_val_zndvcu
confirm variable pw_val_zndvcu
capture recast double pw_val_zndvcu
confirm variable ln_val_znevcu
capture recast double ln_val_znevcu
confirm variable pw_val_znevcu
capture recast double pw_val_znevcu
confirm variable ln_val_znhvcu
capture recast double ln_val_znhvcu
confirm variable pw_val_znhvcu
capture recast double pw_val_znhvcu
confirm variable ln_val_znivcu
capture recast double ln_val_znivcu
confirm variable pw_val_znivcu
capture recast double pw_val_znivcu
confirm variable ln_val_znovcu
capture recast double ln_val_znovcu
confirm variable pw_val_znovcu
capture recast double pw_val_znovcu
confirm variable ln_val_znpvcu
capture recast double ln_val_znpvcu
confirm variable pw_val_znpvcu
capture recast double pw_val_znpvcu
confirm variable ln_val_znrvcu
capture recast double ln_val_znrvcu
confirm variable pw_val_znrvcu
capture recast double pw_val_znrvcu
confirm variable ln_val_znsvcu
capture recast double ln_val_znsvcu
confirm variable pw_val_znsvcu
capture recast double pw_val_znsvcu
confirm variable ln_val_zntvcu
capture recast double ln_val_zntvcu
confirm variable pw_val_zntvcu
capture recast double pw_val_zntvcu
confirm variable ln_val_zpavcu
capture recast double ln_val_zpavcu
confirm variable pw_val_zpavcu
capture recast double pw_val_zpavcu
confirm variable ln_val_zpdvcu
capture recast double ln_val_zpdvcu
confirm variable pw_val_zpdvcu
capture recast double pw_val_zpdvcu
confirm variable ln_val_zpevcu
capture recast double ln_val_zpevcu
confirm variable pw_val_zpevcu
capture recast double pw_val_zpevcu
confirm variable ln_val_zphvcu
capture recast double ln_val_zphvcu
confirm variable pw_val_zphvcu
capture recast double pw_val_zphvcu
confirm variable ln_val_zpivcu
capture recast double ln_val_zpivcu
confirm variable pw_val_zpivcu
capture recast double pw_val_zpivcu
confirm variable ln_val_zpovcu
capture recast double ln_val_zpovcu
confirm variable pw_val_zpovcu
capture recast double pw_val_zpovcu
confirm variable ln_val_zppvcu
capture recast double ln_val_zppvcu
confirm variable pw_val_zppvcu
capture recast double pw_val_zppvcu
confirm variable ln_val_zprvcu
capture recast double ln_val_zprvcu
confirm variable pw_val_zprvcu
capture recast double pw_val_zprvcu
confirm variable ln_val_zpsvcu
capture recast double ln_val_zpsvcu
confirm variable pw_val_zpsvcu
capture recast double pw_val_zpsvcu
confirm variable ln_val_zptvcu
capture recast double ln_val_zptvcu
confirm variable pw_val_zptvcu
capture recast double pw_val_zptvcu
confirm variable out_gross_output_nominal
capture recast byte out_gross_output_nominal
confirm variable out_value_added_nominal
capture recast byte out_value_added_nominal
confirm variable out_capital_nominal
capture recast byte out_capital_nominal
confirm variable out_workers
capture recast byte out_workers
confirm variable source_id_observed
capture recast byte source_id_observed
confirm variable source_id_multiplicity
capture recast byte source_id_multiplicity
confirm variable source_id_tag
capture recast byte source_id_tag
confirm variable native_id_unique
capture recast byte native_id_unique
confirm variable real_panel_ready
capture recast byte real_panel_ready
confirm variable panel_status
quietly count if strlen(panel_status)>38
if r(N)==0 recast str38 panel_status
confirm variable classification_status
quietly count if strlen(classification_status)>43
if r(N)==0 recast str43 classification_status
confirm variable deflator_output
capture recast byte deflator_output
confirm variable deflator_inputs
capture recast byte deflator_inputs
confirm variable deflator_capital
capture recast byte deflator_capital
confirm variable deflator_wages
capture recast byte deflator_wages
confirm variable gross_output_real
capture recast byte gross_output_real
confirm variable value_added_real
capture recast byte value_added_real
confirm variable capital_real
capture recast byte capital_real
confirm variable intermediate_inputs_real
capture recast byte intermediate_inputs_real
confirm variable deflator_applied
capture recast byte deflator_applied
confirm variable deflator_status
quietly count if strlen(deflator_status)>56
if r(N)==0 recast str56 deflator_status
confirm variable legacy_output_wpi_year_exists
capture recast byte legacy_output_wpi_year_exists
confirm variable legacy_input_wpi_year_exists
capture recast byte legacy_input_wpi_year_exists
confirm variable money_unit_status
quietly count if strlen(money_unit_status)>53
if r(N)==0 recast str53 money_unit_status
confirm variable candidate_status
quietly count if strlen(candidate_status)>66
if r(N)==0 recast str66 candidate_status
confirm variable legacy_rd_cost_mislabelled
capture recast byte legacy_rd_cost_mislabelled
confirm variable legacy_export_share_flag
capture recast byte legacy_export_share_flag
confirm variable legacy_total_gj_s1
capture recast double legacy_total_gj_s1
confirm variable legacy_co2_total_s1
capture recast double legacy_co2_total_s1
confirm variable legacy_fuel_coal_alias
capture recast long legacy_fuel_coal_alias
confirm variable legacy_fuel_coke_alias
capture recast byte legacy_fuel_coke_alias
confirm variable legacy_fuel_natgas_alias
capture recast long legacy_fuel_natgas_alias
confirm variable legacy_fuel_charcoal_alias
capture recast long legacy_fuel_charcoal_alias
confirm variable amdal_raw
capture recast double amdal_raw
confirm variable vs_amdal_raw
capture recast byte vs_amdal_raw
confirm variable b3wste_raw
capture recast double b3wste_raw
confirm variable vs_b3wste_raw
capture recast byte vs_b3wste_raw
confirm variable capital_additions_nominal
capture recast double capital_additions_nominal
confirm variable vs_capital_additions_nominal
capture recast byte vs_capital_additions_nominal
confirm variable capital_nominal
capture recast double capital_nominal
confirm variable vs_capital_nominal
capture recast byte vs_capital_nominal
confirm variable capital_stock_nominal
capture recast double capital_stock_nominal
confirm variable vs_capital_stock_nominal
capture recast byte vs_capital_stock_nominal
confirm variable export_binary_raw
capture recast double export_binary_raw
confirm variable vs_export_binary_raw
capture recast byte vs_export_binary_raw
confirm variable export_share_pct
capture recast double export_share_pct
confirm variable vs_export_share_pct
capture recast byte vs_export_share_pct
confirm variable foreign_ownership_pct
capture recast double foreign_ownership_pct
confirm variable vs_foreign_ownership_pct
capture recast byte vs_foreign_ownership_pct
confirm variable gross_output_nominal
capture recast double gross_output_nominal
confirm variable vs_gross_output_nominal
capture recast byte vs_gross_output_nominal
confirm variable import_value_nominal
capture recast double import_value_nominal
confirm variable vs_import_value_nominal
capture recast byte vs_import_value_nominal
confirm variable innovation_marketing_raw
capture recast double innovation_marketing_raw
confirm variable vs_innovation_marketing_raw
capture recast byte vs_innovation_marketing_raw
confirm variable innovation_org_raw
capture recast double innovation_org_raw
confirm variable vs_innovation_org_raw
capture recast byte vs_innovation_org_raw
confirm variable innovation_process_raw
capture recast double innovation_process_raw
confirm variable vs_innovation_process_raw
capture recast byte vs_innovation_process_raw
confirm variable innovation_product_raw
capture recast double innovation_product_raw
confirm variable vs_innovation_product_raw
capture recast byte vs_innovation_product_raw
confirm variable innovation_raw
capture recast double innovation_raw
confirm variable vs_innovation_raw
capture recast byte vs_innovation_raw
confirm variable inspli_raw
capture recast double inspli_raw
confirm variable vs_inspli_raw
capture recast byte vs_inspli_raw
confirm variable intermediate_inputs_nominal
capture recast double intermediate_inputs_nominal
confirm variable vs_intermediate_inputs_nominal
capture recast byte vs_intermediate_inputs_nominal
confirm variable liwste_raw
capture recast double liwste_raw
confirm variable vs_liwste_raw
capture recast byte vs_liwste_raw
confirm variable pplihi_raw
capture recast double pplihi_raw
confirm variable vs_pplihi_raw
capture recast byte vs_pplihi_raw
confirm variable production_workers
capture recast double production_workers
confirm variable vs_production_workers
capture recast byte vs_production_workers
confirm variable rd_cost_nominal
capture recast double rd_cost_nominal
confirm variable vs_rd_cost_nominal
capture recast byte vs_rd_cost_nominal
confirm variable rd_indicator_raw
capture recast double rd_indicator_raw
confirm variable vs_rd_indicator_raw
capture recast byte vs_rd_indicator_raw
confirm variable rd_workers
capture recast double rd_workers
confirm variable vs_rd_workers
capture recast byte vs_rd_workers
confirm variable sowste_raw
capture recast double sowste_raw
confirm variable vs_sowste_raw
capture recast byte vs_sowste_raw
confirm variable spplhi_raw
capture recast double spplhi_raw
confirm variable vs_spplhi_raw
capture recast byte vs_spplhi_raw
confirm variable val_cbdacu
capture recast double val_cbdacu
confirm variable vs_val_cbdacu
capture recast byte vs_val_cbdacu
confirm variable val_cbfpcu
capture recast double val_cbfpcu
confirm variable vs_val_cbfpcu
capture recast byte vs_val_cbfpcu
confirm variable val_cbsacu
capture recast double val_cbsacu
confirm variable vs_val_cbsacu
capture recast byte vs_val_cbsacu
confirm variable val_cbttcu
capture recast double val_cbttcu
confirm variable vs_val_cbttcu
capture recast byte vs_val_cbttcu
confirm variable val_cldacu
capture recast double val_cldacu
confirm variable vs_val_cldacu
capture recast byte vs_val_cldacu
confirm variable val_clfpcu
capture recast double val_clfpcu
confirm variable vs_val_clfpcu
capture recast byte vs_val_clfpcu
confirm variable val_clsacu
capture recast double val_clsacu
confirm variable vs_val_clsacu
capture recast byte vs_val_clsacu
confirm variable val_clttcu
capture recast double val_clttcu
confirm variable vs_val_clttcu
capture recast byte vs_val_clttcu
confirm variable val_cmdacu
capture recast double val_cmdacu
confirm variable vs_val_cmdacu
capture recast byte vs_val_cmdacu
confirm variable val_cmfpcu
capture recast double val_cmfpcu
confirm variable vs_val_cmfpcu
capture recast byte vs_val_cmfpcu
confirm variable val_cmsacu
capture recast double val_cmsacu
confirm variable vs_val_cmsacu
capture recast byte vs_val_cmsacu
confirm variable val_cmttcu
capture recast double val_cmttcu
confirm variable vs_val_cmttcu
capture recast byte vs_val_cmttcu
confirm variable val_codacu
capture recast double val_codacu
confirm variable vs_val_codacu
capture recast byte vs_val_codacu
confirm variable val_cofpcu
capture recast double val_cofpcu
confirm variable vs_val_cofpcu
capture recast byte vs_val_cofpcu
confirm variable val_cosacu
capture recast double val_cosacu
confirm variable vs_val_cosacu
capture recast byte vs_val_cosacu
confirm variable val_costrd
capture recast double val_costrd
confirm variable vs_val_costrd
capture recast byte vs_val_costrd
confirm variable val_cottcu
capture recast double val_cottcu
confirm variable vs_val_cottcu
capture recast byte vs_val_cottcu
confirm variable val_csdacu
capture recast double val_csdacu
confirm variable vs_val_csdacu
capture recast byte vs_val_csdacu
confirm variable val_csfpcu
capture recast double val_csfpcu
confirm variable vs_val_csfpcu
capture recast byte vs_val_csfpcu
confirm variable val_cssacu
capture recast double val_cssacu
confirm variable vs_val_cssacu
capture recast byte vs_val_cssacu
confirm variable val_csttcu
capture recast double val_csttcu
confirm variable vs_val_csttcu
capture recast byte vs_val_csttcu
confirm variable val_ctdacu
capture recast double val_ctdacu
confirm variable vs_val_ctdacu
capture recast byte vs_val_ctdacu
confirm variable val_ctfpcu
capture recast double val_ctfpcu
confirm variable vs_val_ctfpcu
capture recast byte vs_val_ctfpcu
confirm variable val_ctsacu
capture recast double val_ctsacu
confirm variable vs_val_ctsacu
capture recast byte vs_val_ctsacu
confirm variable val_cttcu
capture recast double val_cttcu
confirm variable vs_val_cttcu
capture recast byte vs_val_cttcu
confirm variable val_ctttcu
capture recast double val_ctttcu
confirm variable vs_val_ctttcu
capture recast byte vs_val_ctttcu
confirm variable val_cvdacu
capture recast double val_cvdacu
confirm variable vs_val_cvdacu
capture recast byte vs_val_cvdacu
confirm variable val_cvfpcu
capture recast double val_cvfpcu
confirm variable vs_val_cvfpcu
capture recast byte vs_val_cvfpcu
confirm variable val_cvsacu
capture recast double val_cvsacu
confirm variable vs_val_cvsacu
capture recast byte vs_val_cvsacu
confirm variable val_cvttcu
capture recast double val_cvttcu
confirm variable vs_val_cvttcu
capture recast byte vs_val_cvttcu
confirm variable val_devvcu
capture recast double val_devvcu
confirm variable vs_val_devvcu
capture recast byte vs_val_devvcu
confirm variable val_ecavce
capture recast double val_ecavce
confirm variable vs_val_ecavce
capture recast byte vs_val_ecavce
confirm variable val_ecavcu
capture recast double val_ecavcu
confirm variable vs_val_ecavcu
capture recast byte vs_val_ecavcu
confirm variable val_ecbvce
capture recast double val_ecbvce
confirm variable vs_val_ecbvce
capture recast byte vs_val_ecbvce
confirm variable val_ecbvcu
capture recast double val_ecbvcu
confirm variable vs_val_ecbvcu
capture recast byte vs_val_ecbvcu
confirm variable val_eckvce
capture recast double val_eckvce
confirm variable vs_val_eckvce
capture recast byte vs_val_eckvce
confirm variable val_eckvcu
capture recast double val_eckvcu
confirm variable vs_val_eckvcu
capture recast byte vs_val_eckvcu
confirm variable val_eclvce
capture recast double val_eclvce
confirm variable vs_val_eclvce
capture recast byte vs_val_eclvce
confirm variable val_eclvcu
capture recast double val_eclvcu
confirm variable vs_val_eclvcu
capture recast byte vs_val_eclvcu
confirm variable val_edivce
capture recast double val_edivce
confirm variable vs_val_edivce
capture recast byte vs_val_edivce
confirm variable val_edivcu
capture recast double val_edivcu
confirm variable vs_val_edivcu
capture recast byte vs_val_edivcu
confirm variable val_efovce
capture recast double val_efovce
confirm variable vs_val_efovce
capture recast byte vs_val_efovce
confirm variable val_efovcu
capture recast double val_efovcu
confirm variable vs_val_efovcu
capture recast byte vs_val_efovcu
confirm variable val_efuvce
capture recast double val_efuvce
confirm variable vs_val_efuvce
capture recast byte vs_val_efuvce
confirm variable val_efuvcu
capture recast double val_efuvcu
confirm variable vs_val_efuvcu
capture recast byte vs_val_efuvcu
confirm variable val_egavce
capture recast double val_egavce
confirm variable vs_val_egavce
capture recast byte vs_val_egavce
confirm variable val_egavcu
capture recast double val_egavcu
confirm variable vs_val_egavcu
capture recast byte vs_val_egavcu
confirm variable val_egovce
capture recast double val_egovce
confirm variable vs_val_egovce
capture recast byte vs_val_egovce
confirm variable val_egovcu
capture recast double val_egovcu
confirm variable vs_val_egovcu
capture recast byte vs_val_egovcu
confirm variable val_elpvce
capture recast double val_elpvce
confirm variable vs_val_elpvce
capture recast byte vs_val_elpvce
confirm variable val_elpvcu
capture recast double val_elpvcu
confirm variable vs_val_elpvcu
capture recast byte vs_val_elpvcu
confirm variable val_eluvce
capture recast double val_eluvce
confirm variable vs_val_eluvce
capture recast byte vs_val_eluvce
confirm variable val_eluvcu
capture recast double val_eluvcu
confirm variable vs_val_eluvcu
capture recast byte vs_val_eluvcu
confirm variable val_encvce
capture recast double val_encvce
confirm variable vs_val_encvce
capture recast byte vs_val_encvce
confirm variable val_encvcu
capture recast double val_encvcu
confirm variable vs_val_encvcu
capture recast byte vs_val_encvcu
confirm variable val_engvce
capture recast double val_engvce
confirm variable vs_val_engvce
capture recast byte vs_val_engvce
confirm variable val_engvcu
capture recast double val_engvcu
confirm variable vs_val_engvcu
capture recast byte vs_val_engvcu
confirm variable val_enpvcu
capture recast double val_enpvcu
confirm variable vs_val_enpvcu
capture recast byte vs_val_enpvcu
confirm variable val_eoivce
capture recast double val_eoivce
confirm variable vs_val_eoivce
capture recast byte vs_val_eoivce
confirm variable val_eoivcu
capture recast double val_eoivcu
confirm variable vs_val_eoivcu
capture recast byte vs_val_eoivcu
confirm variable val_epevce
capture recast double val_epevce
confirm variable vs_val_epevce
capture recast byte vs_val_epevce
confirm variable val_epevcu
capture recast double val_epevcu
confirm variable vs_val_epevcu
capture recast byte vs_val_epevcu
confirm variable val_eplvcu
capture recast double val_eplvcu
confirm variable vs_val_eplvcu
capture recast byte vs_val_eplvcu
confirm variable val_esdvce
capture recast double val_esdvce
confirm variable vs_val_esdvce
capture recast byte vs_val_esdvce
confirm variable val_esdvcu
capture recast double val_esdvcu
confirm variable vs_val_esdvcu
capture recast byte vs_val_esdvcu
confirm variable val_esovce
capture recast double val_esovce
confirm variable vs_val_esovce
capture recast byte vs_val_esovce
confirm variable val_esovcu
capture recast double val_esovcu
confirm variable vs_val_esovcu
capture recast byte vs_val_esovcu
confirm variable val_ibrvcu
capture recast double val_ibrvcu
confirm variable vs_val_ibrvcu
capture recast byte vs_val_ibrvcu
confirm variable val_icovcu
capture recast double val_icovcu
confirm variable vs_val_icovcu
capture recast byte vs_val_icovcu
confirm variable val_idevcu
capture recast double val_idevcu
confirm variable vs_val_idevcu
capture recast byte vs_val_idevcu
confirm variable val_iinput
capture recast double val_iinput
confirm variable vs_val_iinput
capture recast byte vs_val_iinput
confirm variable val_iinvcu
capture recast double val_iinvcu
confirm variable vs_val_iinvcu
capture recast byte vs_val_iinvcu
confirm variable val_iisfov
capture recast double val_iisfov
confirm variable vs_val_iisfov
capture recast byte vs_val_iisfov
confirm variable val_iislov
capture recast double val_iislov
confirm variable vs_val_iislov
capture recast byte vs_val_iislov
confirm variable val_iisvcu
capture recast double val_iisvcu
confirm variable vs_val_iisvcu
capture recast byte vs_val_iisvcu
confirm variable val_ikivcu
capture recast double val_ikivcu
confirm variable vs_val_ikivcu
capture recast byte vs_val_ikivcu
confirm variable val_iklvcu
capture recast double val_iklvcu
confirm variable vs_val_iklvcu
capture recast byte vs_val_iklvcu
confirm variable val_ikovcu
capture recast double val_ikovcu
confirm variable vs_val_ikovcu
capture recast byte vs_val_ikovcu
confirm variable val_ilrvcu
capture recast double val_ilrvcu
confirm variable vs_val_ilrvcu
capture recast byte vs_val_ilrvcu
confirm variable val_insvcu
capture recast double val_insvcu
confirm variable vs_val_insvcu
capture recast byte vs_val_insvcu
confirm variable val_intvcu
capture recast double val_intvcu
confirm variable vs_val_intvcu
capture recast byte vs_val_intvcu
confirm variable val_iotvcu
capture recast double val_iotvcu
confirm variable vs_val_iotvcu
capture recast byte vs_val_iotvcu
confirm variable val_ipkvcu
capture recast double val_ipkvcu
confirm variable vs_val_ipkvcu
capture recast byte vs_val_ipkvcu
confirm variable val_iprvcu
capture recast double val_iprvcu
confirm variable vs_val_iprvcu
capture recast byte vs_val_iprvcu
confirm variable val_irdvcu
capture recast double val_irdvcu
confirm variable vs_val_irdvcu
capture recast byte vs_val_irdvcu
confirm variable val_irevcu
capture recast double val_irevcu
confirm variable vs_val_irevcu
capture recast byte vs_val_irevcu
confirm variable val_irrvcu
capture recast double val_irrvcu
confirm variable vs_val_irrvcu
capture recast byte vs_val_irrvcu
confirm variable val_itxvcu
capture recast double val_itxvcu
confirm variable vs_val_itxvcu
capture recast byte vs_val_itxvcu
confirm variable val_iuwvcu
capture recast double val_iuwvcu
confirm variable vs_val_iuwvcu
capture recast byte vs_val_iuwvcu
confirm variable val_nopvcu
capture recast double val_nopvcu
confirm variable vs_val_nopvcu
capture recast byte vs_val_nopvcu
confirm variable val_othvcu
capture recast double val_othvcu
confirm variable vs_val_othvcu
capture recast byte vs_val_othvcu
confirm variable val_output
capture recast double val_output
confirm variable vs_val_output
capture recast byte vs_val_output
confirm variable val_rdnvcu
capture recast double val_rdnvcu
confirm variable vs_val_rdnvcu
capture recast byte vs_val_rdnvcu
confirm variable val_renvcu
capture recast double val_renvcu
confirm variable vs_val_renvcu
capture recast byte vs_val_renvcu
confirm variable val_rimvcu
capture recast double val_rimvcu
confirm variable vs_val_rimvcu
capture recast byte vs_val_rimvcu
confirm variable val_rtlvcu
capture recast double val_rtlvcu
confirm variable vs_val_rtlvcu
capture recast byte vs_val_rtlvcu
confirm variable val_sfbvcu
capture recast double val_sfbvcu
confirm variable vs_val_sfbvcu
capture recast byte vs_val_sfbvcu
confirm variable val_sfcvcu
capture recast double val_sfcvcu
confirm variable vs_val_sfcvcu
capture recast byte vs_val_sfcvcu
confirm variable val_sfdvcu
capture recast double val_sfdvcu
confirm variable vs_val_sfdvcu
capture recast byte vs_val_sfdvcu
confirm variable val_sfgvcu
capture recast double val_sfgvcu
confirm variable vs_val_sfgvcu
capture recast byte vs_val_sfgvcu
confirm variable val_sfjvcu
capture recast double val_sfjvcu
confirm variable vs_val_sfjvcu
capture recast byte vs_val_sfjvcu
confirm variable val_sfkvcu
capture recast double val_sfkvcu
confirm variable vs_val_sfkvcu
capture recast byte vs_val_sfkvcu
confirm variable val_sfnvcu
capture recast double val_sfnvcu
confirm variable vs_val_sfnvcu
capture recast byte vs_val_sfnvcu
confirm variable val_sfovcu
capture recast double val_sfovcu
confirm variable vs_val_sfovcu
capture recast byte vs_val_sfovcu
confirm variable val_sfrvcu
capture recast double val_sfrvcu
confirm variable vs_val_sfrvcu
capture recast byte vs_val_sfrvcu
confirm variable val_sfsvcu
capture recast double val_sfsvcu
confirm variable vs_val_sfsvcu
capture recast byte vs_val_sfsvcu
confirm variable val_sfuvcu
capture recast double val_sfuvcu
confirm variable vs_val_sfuvcu
capture recast byte vs_val_sfuvcu
confirm variable val_shdvcu
capture recast double val_shdvcu
confirm variable vs_val_shdvcu
capture recast byte vs_val_shdvcu
confirm variable val_shfvcu
capture recast double val_shfvcu
confirm variable vs_val_shfvcu
capture recast byte vs_val_shfvcu
confirm variable val_shjvcu
capture recast double val_shjvcu
confirm variable vs_val_shjvcu
capture recast byte vs_val_shjvcu
confirm variable val_srdvcu
capture recast double val_srdvcu
confirm variable vs_val_srdvcu
capture recast byte vs_val_srdvcu
confirm variable val_srjvcu
capture recast double val_srjvcu
confirm variable vs_val_srjvcu
capture recast byte vs_val_srjvcu
confirm variable val_srmvcu
capture recast double val_srmvcu
confirm variable vs_val_srmvcu
capture recast byte vs_val_srmvcu
confirm variable val_stdvcu
capture recast double val_stdvcu
confirm variable vs_val_stdvcu
capture recast byte vs_val_stdvcu
confirm variable val_stjvcu
capture recast double val_stjvcu
confirm variable vs_val_stjvcu
capture recast byte vs_val_stjvcu
confirm variable val_stlvcu
capture recast double val_stlvcu
confirm variable vs_val_stlvcu
capture recast byte vs_val_stlvcu
confirm variable val_vtlvcu
capture recast double val_vtlvcu
confirm variable vs_val_vtlvcu
capture recast byte vs_val_vtlvcu
confirm variable val_yelvcu
capture recast double val_yelvcu
confirm variable vs_val_yelvcu
capture recast byte vs_val_yelvcu
confirm variable val_yisvcu
capture recast double val_yisvcu
confirm variable vs_val_yisvcu
capture recast byte vs_val_yisvcu
confirm variable val_yisvdo
capture recast double val_yisvdo
confirm variable vs_val_yisvdo
capture recast byte vs_val_yisvdo
confirm variable val_yisvfo
capture recast double val_yisvfo
confirm variable vs_val_yisvfo
capture recast byte vs_val_yisvfo
confirm variable val_ykdvcu
capture recast double val_ykdvcu
confirm variable vs_val_ykdvcu
capture recast byte vs_val_ykdvcu
confirm variable val_ykfvcu
capture recast double val_ykfvcu
confirm variable vs_val_ykfvcu
capture recast byte vs_val_ykfvcu
confirm variable val_ykivcu
capture recast double val_ykivcu
confirm variable vs_val_ykivcu
capture recast byte vs_val_ykivcu
confirm variable val_yprvcu
capture recast double val_yprvcu
confirm variable vs_val_yprvcu
capture recast byte vs_val_yprvcu
confirm variable val_yrnvcu
capture recast double val_yrnvcu
confirm variable vs_val_yrnvcu
capture recast byte vs_val_yrnvcu
confirm variable val_yrsvcu
capture recast double val_yrsvcu
confirm variable vs_val_yrsvcu
capture recast byte vs_val_yrsvcu
confirm variable val_ysnvcu
capture recast double val_ysnvcu
confirm variable vs_val_ysnvcu
capture recast byte vs_val_ysnvcu
confirm variable val_ytovcu
capture recast double val_ytovcu
confirm variable vs_val_ytovcu
capture recast byte vs_val_ytovcu
confirm variable val_znavcu
capture recast double val_znavcu
confirm variable vs_val_znavcu
capture recast byte vs_val_znavcu
confirm variable val_zndvcu
capture recast double val_zndvcu
confirm variable vs_val_zndvcu
capture recast byte vs_val_zndvcu
confirm variable val_znevcu
capture recast double val_znevcu
confirm variable vs_val_znevcu
capture recast byte vs_val_znevcu
confirm variable val_znhvcu
capture recast double val_znhvcu
confirm variable vs_val_znhvcu
capture recast byte vs_val_znhvcu
confirm variable val_znivcu
capture recast double val_znivcu
confirm variable vs_val_znivcu
capture recast byte vs_val_znivcu
confirm variable val_znovcu
capture recast double val_znovcu
confirm variable vs_val_znovcu
capture recast byte vs_val_znovcu
confirm variable val_znpvcu
capture recast double val_znpvcu
confirm variable vs_val_znpvcu
capture recast byte vs_val_znpvcu
confirm variable val_znrvcu
capture recast double val_znrvcu
confirm variable vs_val_znrvcu
capture recast byte vs_val_znrvcu
confirm variable val_znsvcu
capture recast double val_znsvcu
confirm variable vs_val_znsvcu
capture recast byte vs_val_znsvcu
confirm variable val_zntvcu
capture recast double val_zntvcu
confirm variable vs_val_zntvcu
capture recast byte vs_val_zntvcu
confirm variable val_zpavcu
capture recast double val_zpavcu
confirm variable vs_val_zpavcu
capture recast byte vs_val_zpavcu
confirm variable val_zpdvcu
capture recast double val_zpdvcu
confirm variable vs_val_zpdvcu
capture recast byte vs_val_zpdvcu
confirm variable val_zpevcu
capture recast double val_zpevcu
confirm variable vs_val_zpevcu
capture recast byte vs_val_zpevcu
confirm variable val_zphvcu
capture recast double val_zphvcu
confirm variable vs_val_zphvcu
capture recast byte vs_val_zphvcu
confirm variable val_zpivcu
capture recast double val_zpivcu
confirm variable vs_val_zpivcu
capture recast byte vs_val_zpivcu
confirm variable val_zpovcu
capture recast double val_zpovcu
confirm variable vs_val_zpovcu
capture recast byte vs_val_zpovcu
confirm variable val_zppvcu
capture recast double val_zppvcu
confirm variable vs_val_zppvcu
capture recast byte vs_val_zppvcu
confirm variable val_zprvcu
capture recast double val_zprvcu
confirm variable vs_val_zprvcu
capture recast byte vs_val_zprvcu
confirm variable val_zpsvcu
capture recast double val_zpsvcu
confirm variable vs_val_zpsvcu
capture recast byte vs_val_zpsvcu
confirm variable val_zptvcu
capture recast double val_zptvcu
confirm variable vs_val_zptvcu
capture recast byte vs_val_zptvcu
confirm variable value_added_nominal
capture recast double value_added_nominal
confirm variable vs_value_added_nominal
capture recast byte vs_value_added_nominal
confirm variable workers
capture recast double workers
confirm variable vs_workers
capture recast byte vs_workers
confirm variable source_id_raw
quietly count if strlen(source_id_raw)>64
if r(N)==0 recast str64 source_id_raw
confirm variable vs_source_id_raw
capture recast byte vs_source_id_raw
confirm variable district_code
quietly count if strlen(district_code)>64
if r(N)==0 recast str64 district_code
confirm variable vs_district_code
capture recast byte vs_district_code
confirm variable industry_code
quietly count if strlen(industry_code)>64
if r(N)==0 recast str64 industry_code
confirm variable vs_industry_code
capture recast byte vs_industry_code
confirm variable province_code
quietly count if strlen(province_code)>64
if r(N)==0 recast str64 province_code
confirm variable vs_province_code
capture recast byte vs_province_code
confirm variable elec_nonpln_kwh
capture recast double elec_nonpln_kwh
confirm variable vs_elec_nonpln_kwh
capture recast byte vs_elec_nonpln_kwh
confirm variable elec_nonpln_rp000
capture recast double elec_nonpln_rp000
confirm variable vs_elec_nonpln_rp000
capture recast byte vs_elec_nonpln_rp000
confirm variable elec_owngen_kwh
capture recast double elec_owngen_kwh
confirm variable vs_elec_owngen_kwh
capture recast byte vs_elec_owngen_kwh
confirm variable elec_pln_kwh
capture recast double elec_pln_kwh
confirm variable vs_elec_pln_kwh
capture recast byte vs_elec_pln_kwh
confirm variable elec_pln_rp000
capture recast double elec_pln_rp000
confirm variable vs_elec_pln_rp000
capture recast byte vs_elec_pln_rp000
confirm variable fuel_biodiesel_ltr
capture recast double fuel_biodiesel_ltr
confirm variable vs_fuel_biodiesel_ltr
capture recast byte vs_fuel_biodiesel_ltr
confirm variable fuel_biodiesel_rp000
capture recast double fuel_biodiesel_rp000
confirm variable vs_fuel_biodiesel_rp000
capture recast byte vs_fuel_biodiesel_rp000
confirm variable fuel_charcoal_kg
capture recast double fuel_charcoal_kg
confirm variable vs_fuel_charcoal_kg
capture recast byte vs_fuel_charcoal_kg
confirm variable fuel_charcoal_rp000
capture recast double fuel_charcoal_rp000
confirm variable vs_fuel_charcoal_rp000
capture recast byte vs_fuel_charcoal_rp000
confirm variable fuel_citygas_m3
capture recast double fuel_citygas_m3
confirm variable vs_fuel_citygas_m3
capture recast byte vs_fuel_citygas_m3
confirm variable fuel_citygas_rp000
capture recast double fuel_citygas_rp000
confirm variable vs_fuel_citygas_rp000
capture recast byte vs_fuel_citygas_rp000
confirm variable fuel_coal_kg
capture recast double fuel_coal_kg
confirm variable vs_fuel_coal_kg
capture recast byte vs_fuel_coal_kg
confirm variable fuel_coal_rp000
capture recast double fuel_coal_rp000
confirm variable vs_fuel_coal_rp000
capture recast byte vs_fuel_coal_rp000
confirm variable fuel_coalbriq_kg
capture recast double fuel_coalbriq_kg
confirm variable vs_fuel_coalbriq_kg
capture recast byte vs_fuel_coalbriq_kg
confirm variable fuel_coalbriq_rp000
capture recast double fuel_coalbriq_rp000
confirm variable vs_fuel_coalbriq_rp000
capture recast byte vs_fuel_coalbriq_rp000
confirm variable fuel_coke_kg
capture recast double fuel_coke_kg
confirm variable vs_fuel_coke_kg
capture recast byte vs_fuel_coke_kg
confirm variable fuel_coke_rp000
capture recast double fuel_coke_rp000
confirm variable vs_fuel_coke_rp000
capture recast byte vs_fuel_coke_rp000
confirm variable fuel_diesel_ltr
capture recast double fuel_diesel_ltr
confirm variable vs_fuel_diesel_ltr
capture recast byte vs_fuel_diesel_ltr
confirm variable fuel_diesel_rp000
capture recast double fuel_diesel_rp000
confirm variable vs_fuel_diesel_rp000
capture recast byte vs_fuel_diesel_rp000
confirm variable fuel_dieseloil_ltr
capture recast double fuel_dieseloil_ltr
confirm variable vs_fuel_dieseloil_ltr
capture recast byte vs_fuel_dieseloil_ltr
confirm variable fuel_dieseloil_rp000
capture recast double fuel_dieseloil_rp000
confirm variable vs_fuel_dieseloil_rp000
capture recast byte vs_fuel_dieseloil_rp000
confirm variable fuel_firewood_kg
capture recast double fuel_firewood_kg
confirm variable vs_fuel_firewood_kg
capture recast byte vs_fuel_firewood_kg
confirm variable fuel_firewood_rp000
capture recast double fuel_firewood_rp000
confirm variable vs_fuel_firewood_rp000
capture recast byte vs_fuel_firewood_rp000
confirm variable fuel_fueloil_ltr
capture recast double fuel_fueloil_ltr
confirm variable vs_fuel_fueloil_ltr
capture recast byte vs_fuel_fueloil_ltr
confirm variable fuel_fueloil_rp000
capture recast double fuel_fueloil_rp000
confirm variable vs_fuel_fueloil_rp000
capture recast byte vs_fuel_fueloil_rp000
confirm variable fuel_kerosene_ltr
capture recast double fuel_kerosene_ltr
confirm variable vs_fuel_kerosene_ltr
capture recast byte vs_fuel_kerosene_ltr
confirm variable fuel_kerosene_rp000
capture recast double fuel_kerosene_rp000
confirm variable vs_fuel_kerosene_rp000
capture recast byte vs_fuel_kerosene_rp000
confirm variable fuel_lpg_kg
capture recast double fuel_lpg_kg
confirm variable vs_fuel_lpg_kg
capture recast byte vs_fuel_lpg_kg
confirm variable fuel_lpg_rp000
capture recast double fuel_lpg_rp000
confirm variable vs_fuel_lpg_rp000
capture recast byte vs_fuel_lpg_rp000
confirm variable fuel_lubricant_ltr
capture recast double fuel_lubricant_ltr
confirm variable vs_fuel_lubricant_ltr
capture recast byte vs_fuel_lubricant_ltr
confirm variable fuel_lubricant_rp000
capture recast double fuel_lubricant_rp000
confirm variable vs_fuel_lubricant_rp000
capture recast byte vs_fuel_lubricant_rp000
confirm variable fuel_natgas_kg
capture recast double fuel_natgas_kg
confirm variable vs_fuel_natgas_kg
capture recast byte vs_fuel_natgas_kg
confirm variable fuel_natgas_rp000
capture recast double fuel_natgas_rp000
confirm variable vs_fuel_natgas_rp000
capture recast byte vs_fuel_natgas_rp000
confirm variable fuel_other_rp000
capture recast double fuel_other_rp000
confirm variable vs_fuel_other_rp000
capture recast byte vs_fuel_other_rp000
confirm variable fuel_othergas_m3
capture recast double fuel_othergas_m3
confirm variable vs_fuel_othergas_m3
capture recast byte vs_fuel_othergas_m3
confirm variable fuel_othergas_rp000
capture recast double fuel_othergas_rp000
confirm variable vs_fuel_othergas_rp000
capture recast byte vs_fuel_othergas_rp000
confirm variable fuel_petrol_ltr
capture recast double fuel_petrol_ltr
confirm variable vs_fuel_petrol_ltr
capture recast byte vs_fuel_petrol_ltr
confirm variable fuel_petrol_rp000
capture recast double fuel_petrol_rp000
confirm variable vs_fuel_petrol_rp000
capture recast byte vs_fuel_petrol_rp000
confirm variable fuel_total_reported_rp000
capture recast double fuel_total_reported_rp000
confirm variable vs_fuel_total_reported_rp000
capture recast byte vs_fuel_total_reported_rp000
confirm variable export_direct_flag
capture recast double export_direct_flag
confirm variable vs_export_direct_flag
capture recast byte vs_export_direct_flag
confirm variable env_amdal_flag
capture recast double env_amdal_flag
confirm variable vs_env_amdal_flag
capture recast byte vs_env_amdal_flag
confirm variable env_ukl_upl_flag
capture recast double env_ukl_upl_flag
confirm variable vs_env_ukl_upl_flag
capture recast byte vs_env_ukl_upl_flag
confirm variable env_sppl_flag
capture recast double env_sppl_flag
confirm variable vs_env_sppl_flag
capture recast byte vs_env_sppl_flag
confirm variable env_waste_treatment_flag
capture recast double env_waste_treatment_flag
confirm variable vs_env_waste_treatment_flag
capture recast byte vs_env_waste_treatment_flag
confirm variable waste_solid_flag
capture recast double waste_solid_flag
confirm variable vs_waste_solid_flag
capture recast byte vs_waste_solid_flag
confirm variable waste_liquid_flag
capture recast double waste_liquid_flag
confirm variable vs_waste_liquid_flag
capture recast byte vs_waste_liquid_flag
confirm variable waste_hazardous_flag
capture recast double waste_hazardous_flag
confirm variable vs_waste_hazardous_flag
capture recast byte vs_waste_hazardous_flag
confirm variable fuel_natgas_mmbtu
capture recast double fuel_natgas_mmbtu
confirm variable vs_fuel_natgas_mmbtu
capture recast byte vs_fuel_natgas_mmbtu
confirm variable fuel_biomass_kg
capture recast double fuel_biomass_kg
confirm variable vs_fuel_biomass_kg
capture recast byte vs_fuel_biomass_kg
confirm variable rd_cost_definition_status
quietly count if strlen(rd_cost_definition_status)>80
if r(N)==0 recast str80 rd_cost_definition_status
confirm variable export_verified_conflict
capture recast byte export_verified_conflict
confirm variable p99_coal
capture recast double p99_coal
confirm variable p99_coke
capture recast double p99_coke
confirm variable p99_natgas
capture recast double p99_natgas
confirm variable p99_charcoal
capture recast double p99_charcoal
confirm variable coal_unit_verified
capture recast byte coal_unit_verified
confirm variable coal_source_unit
quietly count if strlen(coal_source_unit)>16
if r(N)==0 recast str16 coal_source_unit
confirm variable co2_diesel_s1
capture recast double co2_diesel_s1
confirm variable co2_diesel_s2
capture recast double co2_diesel_s2
confirm variable gj_diesel
capture recast double gj_diesel
confirm variable co2_petrol_s1
capture recast double co2_petrol_s1
confirm variable co2_petrol_s2
capture recast double co2_petrol_s2
confirm variable gj_petrol
capture recast double gj_petrol
confirm variable co2_kerosene_s1
capture recast double co2_kerosene_s1
confirm variable co2_kerosene_s2
capture recast double co2_kerosene_s2
confirm variable gj_kerosene
capture recast double gj_kerosene
confirm variable co2_coal_s1
capture recast double co2_coal_s1
confirm variable co2_coal_s2
capture recast double co2_coal_s2
confirm variable gj_coal
capture recast double gj_coal
confirm variable co2_lpg_s1
capture recast double co2_lpg_s1
confirm variable co2_lpg_s2
capture recast double co2_lpg_s2
confirm variable gj_lpg
capture recast double gj_lpg
confirm variable co2_citygas_s1
capture recast double co2_citygas_s1
confirm variable co2_citygas_s2
capture recast double co2_citygas_s2
confirm variable gj_citygas
capture recast double gj_citygas
confirm variable co2_othergas_s1
capture recast double co2_othergas_s1
confirm variable co2_othergas_s2
capture recast double co2_othergas_s2
confirm variable gj_othergas
capture recast double gj_othergas
confirm variable co2_coalbriq_s1
capture recast double co2_coalbriq_s1
confirm variable co2_coalbriq_s2
capture recast double co2_coalbriq_s2
confirm variable gj_coalbriq
capture recast double gj_coalbriq
confirm variable co2_coke_s1
capture recast double co2_coke_s1
confirm variable co2_coke_s2
capture recast double co2_coke_s2
confirm variable gj_coke
capture recast double gj_coke
confirm variable co2_scope1_nfuels_s1
capture recast byte co2_scope1_nfuels_s1
confirm variable co2_scope1_s1
capture recast double co2_scope1_s1
confirm variable co2_scope1_s2
capture recast double co2_scope1_s2
confirm variable gj_fuel_s1
capture recast double gj_fuel_s1
confirm variable nine_fuels_complete
capture recast byte nine_fuels_complete
confirm variable electricity_n_observed
capture recast byte electricity_n_observed
confirm variable elec_purchased_kwh
capture recast double elec_purchased_kwh
confirm variable gj_electricity
capture recast double gj_electricity
confirm variable co2_scope2_s1
capture recast double co2_scope2_s1
confirm variable co2_scope2_s2
capture recast double co2_scope2_s2
confirm variable co2_total_s1
capture recast double co2_total_s1
confirm variable co2_total_s2
capture recast double co2_total_s2
confirm variable total_gj_s1
capture recast double total_gj_s1
confirm variable co2_scope1_complete
capture recast double co2_scope1_complete
confirm variable co2_scope2_complete
capture recast double co2_scope2_complete
confirm variable co2_total_complete
capture recast double co2_total_complete
confirm variable total_gj_complete
capture recast double total_gj_complete
confirm variable co2_variant_static_grid
capture recast double co2_variant_static_grid
confirm variable own_generation_reported
capture recast byte own_generation_reported
confirm variable own_generation_added
capture recast byte own_generation_added
confirm variable extra_fuel_positive
capture recast byte extra_fuel_positive
confirm variable energy_coverage_status
quietly count if strlen(energy_coverage_status)>80
if r(N)==0 recast str80 energy_coverage_status
confirm variable g0_schema_version
quietly count if strlen(g0_schema_version)>32
if r(N)==0 recast str32 g0_schema_version
confirm variable export_flag
capture recast byte export_flag
confirm variable export_any_binary
capture recast double export_any_binary
confirm variable vs_export_any_binary
capture recast byte vs_export_any_binary
confirm variable rd_activity_flag
capture recast double rd_activity_flag
confirm variable vs_rd_activity_flag
capture recast byte vs_rd_activity_flag
confirm variable rd_external_funding_flag
capture recast double rd_external_funding_flag
confirm variable vs_rd_external_funding_flag
capture recast byte vs_rd_external_funding_flag
confirm variable innovation_flag
capture recast double innovation_flag
confirm variable vs_innovation_flag
capture recast byte vs_innovation_flag
confirm variable v_export_any_binary
capture recast double v_export_any_binary
confirm variable v_rd_activity_flag
capture recast double v_rd_activity_flag
confirm variable v_rd_external_funding_flag
capture recast double v_rd_external_funding_flag
confirm variable innovation_product_flag
capture recast double innovation_product_flag
confirm variable v_innovation_product_flag
capture recast double v_innovation_product_flag
confirm variable vs_innovation_product_flag
capture recast byte vs_innovation_product_flag
confirm variable innovation_process_flag
capture recast double innovation_process_flag
confirm variable v_innovation_process_flag
capture recast double v_innovation_process_flag
confirm variable vs_innovation_process_flag
capture recast byte vs_innovation_process_flag
confirm variable innovation_marketing_flag
capture recast double innovation_marketing_flag
confirm variable v_innovation_marketing_flag
capture recast double v_innovation_marketing_flag
confirm variable vs_innovation_marketing_flag
capture recast byte vs_innovation_marketing_flag
confirm variable innovation_org_flag
capture recast double innovation_org_flag
confirm variable v_innovation_org_flag
capture recast double v_innovation_org_flag
confirm variable vs_innovation_org_flag
capture recast byte vs_innovation_org_flag
confirm variable v_innovation_flag
capture recast double v_innovation_flag
confirm variable v_export_flag
capture recast byte v_export_flag
confirm variable vs_export_flag
capture recast byte vs_export_flag
confirm variable export_assumption_conflict
capture recast byte export_assumption_conflict
confirm variable analysis_contract
quietly count if strlen(analysis_contract)>80
if r(N)==0 recast str80 analysis_contract
confirm variable identity_mode
quietly count if strlen(identity_mode)>8
if r(N)==0 recast str8 identity_mode
confirm variable identity_is_dummy
capture recast byte identity_is_dummy
confirm variable identity_real_link_verified
capture recast byte identity_real_link_verified
confirm variable identity_xtset_ready
capture recast byte identity_xtset_ready
confirm variable selected_firm_id
capture recast double selected_firm_id
confirm variable selected_district_code
quietly count if strlen(selected_district_code)>64
if r(N)==0 recast str64 selected_district_code
confirm variable dummy_firm_id
capture recast long dummy_firm_id
confirm variable dummy_district_code
quietly count if strlen(dummy_district_code)>64
if r(N)==0 recast str64 dummy_district_code
confirm variable identity_eligibility
quietly count if strlen(identity_eligibility)>80
if r(N)==0 recast str80 identity_eligibility
confirm variable identity_district_status
quietly count if strlen(identity_district_status)>80
if r(N)==0 recast str80 identity_district_status
confirm variable dummy_district_count
capture recast byte dummy_district_count
confirm variable identity_seed
capture recast long identity_seed
confirm variable identity_method
quietly count if strlen(identity_method)>80
if r(N)==0 recast str80 identity_method
confirm variable demo_province
quietly count if strlen(demo_province)>2
if r(N)==0 recast str2 demo_province
confirm variable demo_industry2
quietly count if strlen(demo_industry2)>2
if r(N)==0 recast str2 demo_industry2
confirm variable demo_slot
capture recast long demo_slot
confirm variable demo_district_slot
capture recast byte demo_district_slot
confirm variable wpi_bridge_merge
capture recast byte wpi_bridge_merge
confirm variable wpi_index_merge
capture recast byte wpi_index_merge
confirm variable wpi_mapping_status
quietly count if strlen(wpi_mapping_status)>40
if r(N)==0 recast str40 wpi_mapping_status
confirm variable wpi_isic4
capture recast int wpi_isic4
confirm variable wpi_output_index
capture recast double wpi_output_index
confirm variable wpi_spliced
capture recast byte wpi_spliced
confirm variable wpi_cagr
capture recast byte wpi_cagr
confirm variable wpi_base_year
capture recast int wpi_base_year
confirm variable real_va_is_single_proxy
capture recast byte real_va_is_single_proxy
confirm variable real_va_double_deflated
capture recast byte real_va_double_deflated
confirm variable ln_output_real
capture recast double ln_output_real
confirm variable ln_va_real_proxy
capture recast double ln_va_real_proxy
confirm variable output_real_per_worker
capture recast double output_real_per_worker
confirm variable va_real_proxy_per_worker
capture recast double va_real_proxy_per_worker
confirm variable gj_per_real_output
capture recast double gj_per_real_output
confirm variable co2_per_real_output
capture recast double co2_per_real_output
confirm variable p99_econ_output
capture recast double p99_econ_output
confirm variable out_checked_output
capture recast byte out_checked_output
confirm variable clean_output_nominal
capture recast double clean_output_nominal
confirm variable p99_econ_va
capture recast double p99_econ_va
confirm variable out_checked_va
capture recast byte out_checked_va
confirm variable clean_va_nominal
capture recast double clean_va_nominal
confirm variable p99_econ_stock
capture recast double p99_econ_stock
confirm variable out_checked_stock
capture recast byte out_checked_stock
confirm variable clean_stock_nominal
capture recast double clean_stock_nominal
confirm variable p99_econ_additions
capture recast double p99_econ_additions
confirm variable out_checked_additions
capture recast byte out_checked_additions
confirm variable clean_additions_nominal
capture recast double clean_additions_nominal
confirm variable p99_econ_workers
capture recast double p99_econ_workers
confirm variable out_checked_workers
capture recast byte out_checked_workers
confirm variable clean_workers_count
capture recast double clean_workers_count
confirm variable clean_output_per_worker
capture recast double clean_output_per_worker
confirm variable clean_va_per_worker
capture recast double clean_va_per_worker
confirm variable clean_stock_per_worker
capture recast double clean_stock_per_worker
confirm variable energy_all_sources_complete
capture recast byte energy_all_sources_complete
confirm variable energy_unit_gap_2018_19
capture recast byte energy_unit_gap_2018_19
confirm variable grid_factor_is_carried
capture recast byte grid_factor_is_carried
confirm variable gj_scope1_complete9
capture recast double gj_scope1_complete9
confirm variable gj_scope2_complete
capture recast double gj_scope2_complete
confirm variable co2_scope2_no_grid_carry
capture recast double co2_scope2_no_grid_carry
confirm variable total_gj_clean_sensitivity
capture recast double total_gj_clean_sensitivity
confirm variable gj_firewood_reference
capture recast double gj_firewood_reference
confirm variable gj_charcoal_reference
capture recast double gj_charcoal_reference
confirm variable gj_lubricant_potential
capture recast double gj_lubricant_potential
order source_year source_row raw_kipb raw_dprovi10 raw_dklui10 raw_dseqno10 raw_dstats10 raw_locati10 raw_jan10 raw_feb10 raw_mar10 raw_apr10 raw_mei10 raw_jun10 raw_jul10 raw_ags10 raw_sep10 raw_okt10 raw_nop10 raw_des10 raw_year10 raw_disic510 raw_mainpr10 raw_dpusat10 raw_dpemda10 raw_ddmstk10 raw_dasing10 raw_ceksum10 raw_lpmltl10 raw_lpwltl10 raw_lprnou10 raw_lnmltl10 raw_lnwltl10 raw_lnpnou10 raw_zpsvcu10 raw_zpovcu10 raw_zpivcu10 raw_zppvcu10 raw_zpavcu10 raw_zpdvcu10 raw_znsvcu10 raw_znovcu10 raw_znivcu10 raw_znpvcu10 raw_znavcu10 raw_zndvcu10 raw_epeliu10 raw_epevcu10 raw_epelie10 raw_epevce10 raw_esoliu10 raw_esovcu10 raw_esolie10 raw_esovce10 raw_eoiliu10 raw_eoivcu10 raw_eoilie10 raw_eoivce10 raw_eclkgu10 raw_eclvcu10 raw_eclkge10 raw_eclvce10 raw_egam3u10 raw_egavcu10 raw_egam3e10 raw_egavce10 raw_elpkgu10 raw_elpvcu10 raw_elpkge10 raw_elpvce10 raw_encvcu10 raw_encvce10 raw_eluliu10 raw_eluvcu10 raw_elulie10 raw_eluvce10 raw_efuvcu10 raw_efuvce10 raw_mgenou10 raw_mgekwu10 raw_eplkhu10 raw_eplvcu10 raw_enpkhu10 raw_enpvcu10 raw_esgkhu10 raw_oelkhu10 raw_yelvcu10 raw_ibrvcu10 raw_ilrvcu10 raw_itxvcu10 raw_iisvcu10 raw_iinvcu10 raw_icovcu10 raw_irrvcu10 raw_iotvcu10 raw_it1vcu10 raw_rdnvcu10 raw_rimvcu10 raw_rtlvcu10 raw_ekspor10 raw_yprvcu10 raw_prprca10 raw_yisvcu10 raw_yrnvcu10 raw_yt1vcu10 raw_srjvcu10 raw_srdvcu10 raw_srmvcu10 raw_shjvcu10 raw_shdvcu10 raw_shfvcu10 raw_sfjvcu10 raw_sfdvcu10 raw_sfnvcu10 raw_stjvcu10 raw_stdvcu10 raw_stlvcu10 raw_clttcu10 raw_clsacu10 raw_cldacu10 raw_v1101 raw_cbttcu10 raw_cbsacu10 raw_cbdacu10 raw_v1103 raw_cmttcu10 raw_cmsacu10 raw_cmdacu10 raw_v1106 raw_cvttcu10 raw_cvsacu10 raw_cvdacu10 raw_v1109 raw_cottcu10 raw_cosacu10 raw_codacu10 raw_v1112 raw_ctttcu10 raw_ctsacu10 raw_ctdacu10 raw_v1115 raw_iinput10 raw_output10 raw_vtlvcu10 raw_userid raw_klpdos1 raw_ltmnou10 raw_ltwnou10 raw_ltlnou10 raw_dkabup10 raw_dkecam10 raw_ddesa10 raw_flages raw_flg10 raw_kipn raw_kbli05 raw_prprex10 raw_dsrvyr10 raw_jan11 raw_feb11 raw_mar11 raw_apr11 raw_mei11 raw_jun11 raw_jul11 raw_agt11 raw_sep11 raw_okt11 raw_nov11 raw_des11 raw_year11 raw_dprovi11 raw_dklui11 raw_dseqno11 raw_mainpr11 raw_disic511 raw_dpusat11 raw_dpemda11 raw_ddmstk11 raw_dasing11 raw_ceksum11 raw_resech11 raw_innova11 raw_lpmnou11 raw_lnmnou11 raw_lfmnou11 raw_ltmnou11 raw_lpwnou11 raw_lnwnou11 raw_lfwnou11 raw_ltwnou11 raw_lprnou11 raw_lnpnou11 raw_lfanou11 raw_ltlnou11 raw_zpsvcu11 raw_znsvcu11 raw_zpovcu11 raw_znovcu11 raw_zpivcu11 raw_znivcu11 raw_zppvcu11 raw_znpvcu11 raw_zpavcu11 raw_znavcu11 raw_zpdvcu11 raw_zndvcu11 raw_epeliu11 raw_epevcu11 raw_epelie11 raw_epevce11 raw_esoliu11 raw_esovcu11 raw_esolie11 raw_esovce11 raw_eoiliu11 raw_eoivcu11 raw_eoilie11 raw_eoivce11 raw_eclkgu11 raw_eclvcu11 raw_eclkge11 raw_eclvce11 raw_egam3u11 raw_egavcu11 raw_egam3e11 raw_egavce11 raw_elpkgu11 raw_elpvcu11 raw_elpkge11 raw_elpvce11 raw_encvcu11 raw_encvce11 raw_eluliu11 raw_eluvcu11 raw_elulie11 raw_eluvce11 raw_efuvcu11 raw_efuvce11 raw_mgenou11 raw_mgekwu11 raw_eplkhu11 raw_eplvcu11 raw_enpkhu11 raw_enpvcu11 raw_esgkhu11 raw_oelkhu11 raw_yelvcu11 raw_ibrvcu11 raw_ilrvcu11 raw_itxvcu11 raw_iisvcu11 raw_iinvcu11 raw_icovcu11 raw_irrvcu11 raw_iotvcu11 raw_it1vcu11 raw_rdnvcu11 raw_rimvcu11 raw_rtlvcu11 raw_ekspor11 raw_yprvcu11 raw_prprca11 raw_yisvcu11 raw_yrnvcu11 raw_yt1vcu11 raw_srjvcu11 raw_srdvcu11 raw_srmvcu11 raw_shjvcu11 raw_shdvcu11 raw_shfvcu11 raw_sfjvcu11 raw_sfdvcu11 raw_sfnvcu11 raw_stjvcu11 raw_stdvcu11 raw_stlvcu11 raw_clttcu11 raw_clsacu11 raw_cldacu11 raw_cbttcu11 raw_cbsacu11 raw_cbdacu11 raw_cmttcu11 raw_cmsacu11 raw_cmdacu11 raw_cvttcu11 raw_cvsacu11 raw_cvdacu11 raw_cottcu11 raw_cosacu11 raw_codacu11 raw_ctttcu11 raw_ctsacu11 raw_ctdacu11 raw_vtlvcu11 raw_laki11 raw_perem11 raw_tottk11 raw_dstats11 raw_locati11 raw_v0408j raw_iinput11 raw_output11 raw_dkabup11 raw_dkecam11 raw_ddesa11 raw_ags11 raw_nop11 raw_prprex11 raw_kbli2 raw_jan12 raw_feb12 raw_mar12 raw_apr12 raw_mei12 raw_jun12 raw_jul12 raw_ags12 raw_sep12 raw_okt12 raw_nov12 raw_des12 raw_year12 raw_egam3u12 raw_egavcu12 raw_egam3e12 raw_egavce12 raw_dprovi12 raw_dklui12 raw_dseqno12 raw_iinput12 raw_output12 raw_disic512 raw_mainpr12 raw_dpusat12 raw_dpemda12 raw_ddmstk12 raw_dasing12 raw_ceksum12 raw_lpmnou12 raw_lpwnou12 raw_lprnou12 raw_lnmnou12 raw_lnwnou12 raw_lnpnou12 raw_zpsvcu12 raw_zpovcu12 raw_zpivcu12 raw_zppvcu12 raw_zpavcu12 raw_zpdvcu12 raw_znsvcu12 raw_znovcu12 raw_znivcu12 raw_znpvcu12 raw_znavcu12 raw_zndvcu12 raw_epeliu12 raw_epevcu12 raw_epelie12 raw_epevce12 raw_esoliu12 raw_esovcu12 raw_esolie12 raw_esovce12 raw_eoiliu12 raw_eoivcu12 raw_eoilie12 raw_eoivce12 raw_eclkgu12 raw_eclvcu12 raw_eclkge12 raw_eclvce12 raw_elpkgu12 raw_elpvcu12 raw_elpkge12 raw_elpvce12 raw_encvcu12 raw_encvce12 raw_eluliu12 raw_eluvcu12 raw_elulie12 raw_eluvce12 raw_efuvcu12 raw_efuvce12 raw_mgenou12 raw_mgekwu12 raw_eplkhu12 raw_eplvcu12 raw_enpkhu12 raw_enpvcu12 raw_esgkhu12 raw_oelkhu12 raw_yelvcu12 raw_ibrvcu12 raw_ilrvcu12 raw_itxvcu12 raw_iisvcu12 raw_iinvcu12 raw_icovcu12 raw_iotvcu12 raw_it1vcu12 raw_rdnvcu12 raw_rimvcu12 raw_rtlvcu12 raw_ekspor12 raw_yprvcu12 raw_prprca12 raw_yisvcu12 raw_yrnvcu12 raw_yt1vcu12 raw_srjvcu12 raw_srdvcu12 raw_srmvcu12 raw_shjvcu12 raw_shdvcu12 raw_shfvcu12 raw_sfjvcu12 raw_sfdvcu12 raw_sfnvcu12 raw_stjvcu12 raw_stdvcu12 raw_stlvcu12 raw_clttcu12 raw_clsacu12 raw_cldacu12 raw_cbttcu12 raw_cbsacu12 raw_cbdacu12 raw_cmttcu12 raw_cmsacu12 raw_cmdacu12 raw_cvttcu12 raw_cvsacu12 raw_cvdacu12 raw_cottcu12 raw_cosacu12 raw_codacu12 raw_ctttcu12 raw_ctsacu12 raw_ctdacu12 raw_vtlvcu12 raw_flgent raw_lfmnou12 raw_lfwnou12 raw_lfanou12 raw_ltmnou12 raw_ltwnou12 raw_ltlnou12 raw_ecbkgu12 raw_ecbvcu12 raw_ecbkge12 raw_ecbvce12 raw_egom3u12 raw_egovcu12 raw_egom3e12 raw_egovce12 raw_irrvcu12 raw_flg12 raw_dkabup12 raw_dkecam12 raw_ddesa12 raw_dstats12 raw_bdhukum raw_dyrstr12 raw_locati12 raw_prprex12 raw_dsrvyr12 raw_dprovi13___2 raw_dkabup13___3 raw_dkecam13___4 raw_jan13 raw_feb13 raw_mar13 raw_apr13 raw_mei13 raw_jun13 raw_jul13 raw_ags13 raw_sep13 raw_okt13 raw_nov13 raw_des13 raw_year13 raw_dprovi13___19 raw_dklui13 raw_dseqno13 raw_dstats13 raw_locati13 raw_disic513 raw_mainpr13 raw_dpusat13 raw_dpemda13 raw_ddmstk13 raw_dasing13 raw_ceksum13 raw_lpmnou13 raw_lpwnou13 raw_lprnou13 raw_lnmnou13 raw_lnwnou13 raw_lnpnou13 raw_lfmnou13 raw_lfwnou13 raw_lfanou13 raw_ltmnou13 raw_ltwnou13 raw_ltlnou13 raw_zpsvcu13 raw_zpovcu13 raw_zpivcu13 raw_zppvcu13 raw_zpavcu13 raw_zpdvcu13 raw_znsvcu13 raw_znovcu13 raw_znivcu13 raw_znpvcu13 raw_znavcu13 raw_zndvcu13 raw_epeliu13 raw_epevcu13 raw_epelie13 raw_epevce13 raw_esoliu13 raw_esovcu13 raw_esolie13 raw_esovce13 raw_eoiliu13 raw_eoivcu13 raw_eoilie13 raw_eoivce13 raw_eclkgu13 raw_eclvcu13 raw_eclkge13 raw_eclvce13 raw_ecbkgu13 raw_ecbvcu13 raw_ecbkge13 raw_ecbvce13 raw_egam3u13 raw_egavcu13 raw_egam3e13 raw_egavce13 raw_egom3u13 raw_egovcu13 raw_egom3e13 raw_egovce13 raw_elpkgu13 raw_elpvcu13 raw_elpkge13 raw_elpvce13 raw_encvcu13 raw_encvce13 raw_eluliu13 raw_eluvcu13 raw_elulie13 raw_eluvce13 raw_efuvcu13 raw_efuvce13 raw_mgenou13 raw_mgekwu13 raw_eplkhu13 raw_eplvcu13 raw_enpkhu13 raw_enpvcu13 raw_esgkhu13 raw_oelkhu13 raw_yelvcu13 raw_ibrvcu13 raw_ilrvcu13 raw_itxvcu13 raw_iinvcu13 raw_icovcu13 raw_irrvcu13 raw_iotvcu13 raw_it1vcu13 raw_rdnvcu13 raw_rimvcu13 raw_rtlvcu13 raw_ekspor13 raw_yprvcu13 raw_prprca13 raw_yisvcu13 raw_yrnvcu13 raw_yt1vcu13 raw_srjvcu13 raw_srdvcu13 raw_srmvcu13 raw_shjvcu13 raw_shdvcu13 raw_shfvcu13 raw_sfjvcu13 raw_sfdvcu13 raw_sfnvcu13 raw_stjvcu13 raw_stdvcu13 raw_stlvcu13 raw_clttcu13 raw_clsacu13 raw_cldacu13 raw_cbttcu13 raw_cbsacu13 raw_cbdacu13 raw_cmttcu13 raw_cmsacu13 raw_cmdacu13 raw_cvttcu13 raw_cvsacu13 raw_cvdacu13 raw_cottcu13 raw_cosacu13 raw_codacu13 raw_ctttcu13 raw_ctdacu13 raw_iinput13 raw_output13 raw_vtlvcu13 raw_kode raw_nama raw_alamat raw_stat raw_useridpu raw_kdkabu raw_kdkeca raw_kddesa raw_tahun raw_nama1 raw_alamat1 raw_email2 raw_stat1 raw_pekerja raw_bbakar raw_listrk raw_iisvcu13 raw_bbpen raw_inp raw_lisjual raw_prod raw_jasa raw_tambahn raw_stok raw_out raw_land raw_pajak raw_pinjam raw_derma raw_ntb1 raw_royal raw_ntb2 raw_ctsacu13 raw_dkabup13___194 raw_dkecam13___195 raw_ddesa13 raw_flg13 raw_prprex13 raw_dsrvyr13 raw_kip_syst raw_dprovi14 raw_dkabup14 raw_dkecam14 raw_ddesa14 raw_dstats14 raw_bhukum14 raw_disic514 raw_mainpr14 raw_ltlnou14 raw_vtlvcu14 raw_output14 raw_iinput14 raw_flg14 raw_yprvcu14 raw_yisvcu14 raw_yrnvcu14 raw_yelvcu14 raw_shfvcu14 raw_yt1vcu14 raw_rtlvcu14 raw_efuvcu14 raw_ibrvcu14 raw_iisvcu14 raw_irrvcu14 raw_eplvcu14 raw_enpvcu14 raw_iotvcu14 raw_epevcu14 raw_esovcu14 raw_eoivcu14 raw_eclvcu14 raw_ecbvcu14 raw_egavcu14 raw_egovcu14 raw_elpvcu14 raw_eluvcu14 raw_encvcu14 raw_efuvce14 raw_epevce14 raw_eluvce14 raw_esovce14 raw_eoivce14 raw_ecbvce14 raw_encvce14 raw_eclvce14 raw_eclkge14 raw_ecbkge14 raw_egavce14 raw_egam3e14 raw_egovce14 raw_egom3e14 raw_elpvce14 raw_elpkge14 raw_epeliu14 raw_esoliu14 raw_eoiliu14 raw_eclkgu14 raw_ecbkgu14 raw_egam3u14 raw_egom3u14 raw_elpkgu14 raw_eluliu14 raw_epelie14 raw_esolie14 raw_eoilie14 raw_elulie14 raw_eplkhu14 raw_enpkhu14 raw_oelkhu14 raw_esgkhu14 raw_srjvcu14 raw_shjvcu14 raw_sfjvcu14 raw_srmvcu14 raw_sfnvcu14 raw_srdvcu14 raw_shdvcu14 raw_sfdvcu14 raw_stjvcu14 raw_stdvcu14 raw_stlvcu14 raw_rdnvcu14 raw_rimvcu14 raw_lprnou14 raw_lfanou14 raw_lnpnou14 raw_lpmnou14 raw_lpwnou14 raw_lnmnou14 raw_lnwnou14 raw_lfmnou14 raw_lfwnou14 raw_ltmnou14 raw_ltwnou14 raw_zpdvcu14 raw_zndvcu14 raw_zpsvcu14 raw_zpovcu14 raw_zpivcu14 raw_zppvcu14 raw_zpavcu14 raw_znsvcu14 raw_znovcu14 raw_znivcu14 raw_znpvcu14 raw_znavcu14 raw_jan14 raw_feb14 raw_mar14 raw_apr14 raw_mei14 raw_jun14 raw_jul14 raw_ags14 raw_sep14 raw_okt14 raw_nov14 raw_des14 raw_year14 raw_dpusat14 raw_dpemda14 raw_ddmstk14 raw_dasing14 raw_ceksum14 raw_mgenou14 raw_mgekwu14 raw_ilrvcu14 raw_itxvcu14 raw_iinvcu14 raw_icovcu14 raw_prprca14 raw_clttcu14 raw_clsacu14 raw_cldacu14 raw_cbttcu14 raw_cbsacu14 raw_cbdacu14 raw_cmttcu14 raw_cmsacu14 raw_cmdacu14 raw_cvttcu14 raw_cvsacu14 raw_cvdacu14 raw_cottcu14 raw_cosacu14 raw_codacu14 raw_ctttcu14 raw_ctdacu14 raw_ctsacu14 raw_prprex14 raw_it1vcu14 raw_r12k10r raw_exp raw_r17ak4r raw_r17bk4r raw_r17ck4r raw_r21_1 raw_r21_2 raw_r21_3 raw_r21_4 raw_r21_5 raw_r21sum raw_r22_1 raw_r22_2 raw_r22_3 raw_r22_4 raw_r22_5 raw_r22sum raw_r23a1 raw_r23a2 raw_r23a3 raw_r23a4 raw_r23asum raw_r23b raw_locati14 raw_ekspor14 raw_reeksp14 raw_yisvdo14 raw_yisvfo14 raw_dsrvyr14 raw_dklui14 raw_dseqno14 raw_export raw_sdd raw_ctttcu15 raw_ras1 raw_kip raw_dprovi raw_kodekab raw_kodekec raw_kodedesa raw_bloksens raw_dstats raw_locati raw_jan raw_feb raw_mar raw_apr raw_mei raw_jun raw_jul raw_ags raw_sep raw_okt raw_nop raw_des raw_year raw_produksi raw_disic5 raw_dpusat raw_dpemda raw_ddmstk raw_dasing raw_ceksum raw_lpmltl raw_lnmltl raw_lfmnou raw_ltmnou raw_lpwltl raw_lnwltl raw_lfwnou raw_ltwnou raw_lprnou raw_lnpnou raw_lfanou raw_ltlnou raw_zpsvcu raw_znsvcu raw_zpovcu raw_znovcu raw_zpivcu raw_field46 raw_zppvcu raw_znpvcu raw_zpavcu raw_znavcu raw_zpdvcu raw_zndvcu raw_epeliu raw_epevcu raw_epelie raw_epevce raw_esoliu raw_esovcu raw_esolie raw_esovce raw_eoiliu raw_eoivcu raw_eoilie raw_eoivce raw_eclkgu raw_eclvcu raw_eclkge raw_eclvce raw_r6ek3 raw_r6ek4 raw_r6ek5 raw_r6ek6 raw_egam3u raw_egavcu raw_egam3e raw_egavce raw_r6gk3 raw_r6gk4 raw_r6gk5 raw_r6gk6 raw_elpkgu raw_elpvcu raw_elpkge raw_elpvce raw_encvcu raw_encvce raw_eluliu raw_eluvcu raw_elulie raw_eluvce raw_efuvcu raw_efuvce raw_mgenou raw_mgekwu raw_eplkhu raw_eplvcu raw_enpkhu raw_enpvcu raw_esgkhu raw_oelkhu raw_yelvcu raw_ibrvcu raw_ilrvcu raw_itxvcu raw_iisvcu raw_iinvcu raw_icovcu raw_irevcu raw_iotvcu raw_it1vcu raw_rdnvcu raw_rimvcu raw_rtlvcu raw_ekspor raw_yprvcu raw_prprca raw_r15a raw_r15b raw_yisvcu raw_yrnvcu raw_yt1vcu raw_srjvcu raw_srdvcu raw_srmvcu raw_shjvcu raw_shdvcu raw_shfvcu raw_sfjvcu raw_sfdvcu raw_sfnvcu raw_stjvcu raw_stdvcu raw_stlvcu raw_clttcu raw_clsacu raw_v12 raw_v11 raw_cbttcu raw_cbsacu raw_v15 raw_v13 raw_cmttcu raw_cmsacu raw_v18 raw_v16 raw_cvttcu raw_cvsacu raw_v1111 raw_v19 raw_cottcu raw_cosacu raw_v1114 raw_cttcu raw_ctsacu raw_v1117 raw_pprex2 raw_vtlvcu15 raw_output15 raw_iinput15 raw_flg15 raw_psid raw_dprovi17 raw_dkabup17 raw_nov raw_disic517 raw_dstats17 raw_dpusat17 raw_dpemda17 raw_ddmstk17 raw_dasing17 raw_iuib17 raw_iuim17 raw_iuik17 raw_tdi17 raw_tdp17 raw_izino17 raw_izino17k raw_sni17 raw_snipro17 raw_sniman17 raw_snimet17 raw_snipcs17 raw_snipsn17 raw_bensni17 raw_concst17 raw_consin17 raw_coninf17 raw_fitsni17 raw_demand17 raw_rnd17 raw_costrd17 raw_inoprd17 raw_inopcs17 raw_inomkt17 raw_inoorg17 raw_lpmnou17 raw_lnmnou17 raw_lfmnou17 raw_ltmnou17 raw_lpwnou17 raw_lnwnou17 raw_lfwnou17 raw_ltwnou17 raw_lprnou17 raw_lnpnou17 raw_lfanou17 raw_ltlnou17 raw_ltlrnd17 raw_zpsvcu17 raw_znsvcu17 raw_zpovcu17 raw_znovcu17 raw_zpivcu17 raw_znivcu17 raw_zppvcu17 raw_znpvcu17 raw_zpavcu17 raw_znavcu17 raw_zpdvcu17 raw_zndvcu17 raw_epeliu17 raw_epevcu17 raw_epelie17 raw_epevce17 raw_esoliu17 raw_esovcu17 raw_esolie17 raw_esovce17 raw_eclkgu17 raw_eclvcu17 raw_eclkge17 raw_eclvce17 raw_ecbkgu17 raw_ecbvcu17 raw_ecbkge17 raw_ecbvce17 raw_egam3u17 raw_egavcu17 raw_egam3e17 raw_egavce17 raw_egom3u17 raw_egovcu17 raw_egom3e17 raw_egovce17 raw_elpkgu17 raw_elpvcu17 raw_elpkge17 raw_elpvce17 raw_encvcu17 raw_encvce17 raw_eluliu17 raw_eluvcu17 raw_elulie17 raw_eluvce17 raw_efuvcu17 raw_efuvce17 raw_eplkhu17 raw_eplvcu17 raw_enpkhu17 raw_enpvcu17 raw_mgenou17 raw_mgekwu17 raw_esgkhu17 raw_oelkhu17 raw_yelvcu17 raw_ibrvcu17 raw_ilrvcu17 raw_itxvcu17 raw_iisvcu17 raw_iinvcu17 raw_icovcu17 raw_irrvcu17 raw_idevcu17 raw_iprvcu17 raw_irdvcu17 raw_ikivcu17 raw_iotvcu17 raw_it1vcu17 raw_rdnvcu17 raw_rimvcu17 raw_rtlvcu17 raw_ekspor17 raw_yprvcu17 raw_prprca17 raw_yisvdo17 raw_yisvfo17 raw_yisvcu17 raw_yrnvcu17 raw_yt1vcu17 raw_devvcu17 raw_intvcu17 raw_renvcu17 raw_insvcu17 raw_nopvcu17 raw_srjvcu17 raw_srdvcu17 raw_shjvcu17 raw_shdvcu17 raw_sfjvcu17 raw_sfdvcu17 raw_stjvcu17 raw_stdvcu17 raw_clttcu17 raw_clsacu17 raw_cldacu17 raw_cbttcu17 raw_cbsacu17 raw_cbdacu17 raw_cmttcu17 raw_cmsacu17 raw_cmdacu17 raw_cvttcu17 raw_cvsacu17 raw_cvdacu17 raw_csttcu17 raw_cssacu17 raw_csdacu17 raw_v1110 raw_cottcu17 raw_cosacu17 raw_codacu17 raw_ctttcu17 raw_ctsacu17 raw_ctdacu17 raw_srmvcu17 raw_shfvcu17 raw_sfnvcu17 raw_stlvcu17 raw_iinput17 raw_output17 raw_vtlvcu17 raw_disic417 raw_number raw_dprovi18 raw_dkabup18 raw_dkecam18 raw_ddesa18 raw_dbs18 raw_nama18 raw_alamat18 raw_kdpos18 raw_rtrw18 raw_email18 raw_wiltel18 raw_tlp18 raw_wilfax18 raw_fax18 raw_kpusat18 raw_kdpos18p raw_rtrw18p raw_email18p raw_wltel18p raw_tlp18p raw_wlfax18p raw_fax18p raw_locati18 raw_disic518 raw_dstats18 raw_dpusat18 raw_dpemda18 raw_ddmstk18 raw_dasing18 raw_nameown1 raw_controw1 raw_busines1 raw_stockow1 raw_nameown2 raw_controw2 raw_busines2 raw_stockow2 raw_nameown3 raw_controw3 raw_busines3 raw_stockow3 raw_nameown4 raw_controw4 raw_busines4 raw_stockow4 raw_nameown5 raw_controw5 raw_busines5 raw_stockow5 raw_prrmsm18 raw_prrmsp18 raw_prrmop18 raw_prrmoc18 raw_pryrsm18 raw_pryrsp18 raw_pryrop18 raw_pryroc18 raw_pryrsg18 raw_pryrom18 raw_pryrwh18 raw_pryrin18 raw_pryrot18 raw_pryrod18 raw_sni18 raw_snipro18 raw_sniman18 raw_snioth18 raw_rnd18 raw_costrd18 raw_inoprd18 raw_inopcs18 raw_inomkt18 raw_inoorg18 raw_lpmnol18 raw_lpmnof18 raw_lnmnol18 raw_lnmnof18 raw_lfmnou18 raw_ltmnou18 raw_lpwnol18 raw_lpwnof18 raw_lnwnol18 raw_lnwnof18 raw_lfwnou18 raw_ltwnou18 raw_lprnol18 raw_lprnof18 raw_lnpnol18 raw_lnpnof18 raw_lfanou18 raw_ltlnou18 raw_ltlrnd18 raw_zpsvcu18 raw_znsvcu18 raw_zpovcu18 raw_znovcu18 raw_zpivcu18 raw_znivcu18 raw_zppvcu18 raw_znpvcu18 raw_zpavcu18 raw_znavcu18 raw_zpdvcu18 raw_zndvcu18 raw_epeliu18 raw_epevcu18 raw_epelie18 raw_epevce18 raw_esoliu18 raw_esovcu18 raw_esolie18 raw_esovce18 raw_eclkgu18 raw_eclvcu18 raw_eclkge18 raw_eclvce18 raw_ecbkgu18 raw_ecbvcu18 raw_egam3u18 raw_egavcu18 raw_egam3e18 raw_egavce18 raw_egom3u18 raw_egovcu18 raw_egom3e18 raw_egovce18 raw_elpkgu18 raw_elpvcu18 raw_encvcu18 raw_eluliu18 raw_eluvcu18 raw_elulie18 raw_eluvce18 raw_efuvcu18 raw_efuvce18 raw_eplkhu18 raw_eplvcu18 raw_enpkhu18 raw_enpvcu18 raw_esgkhu18 raw_mgenou18 raw_mgekwu18 raw_oelkhu18 raw_yelvcu18 raw_ibrvcu18 raw_ilrvcu18 raw_itxvcu18 raw_iislov18 raw_iisfov18 raw_iinvcu18 raw_icovcu18 raw_irrvcu18 raw_idevcu18 raw_iprvcu18 raw_irdvcu18 raw_ikivcu18 raw_iotvcu18 raw_it1vcu18 raw_rdnvcu18 raw_rimvcu18 raw_rtlvcu18 raw_ekspor18 raw_exsrtl18 raw_yprvcu18 raw_prprca18 raw_yisvdo18 raw_yisvfo18 raw_yisvcu18 raw_yrnvcu18 raw_yt1vcu18 raw_devvcu18 raw_intvcu18 raw_renvcu18 raw_insvcu18 raw_nopvcu18 raw_srjvcu18 raw_srdvcu18 raw_shjvcu18 raw_shdvcu18 raw_sfjvcu18 raw_sfdvcu18 raw_stjvcu18 raw_stdvcu18 raw_clttcu18 raw_clsacu18 raw_cbttcu18 raw_cbsacu18 raw_cbdacu18 raw_cmttcu18 raw_cmsacu18 raw_cmdacu18 raw_cvttcu18 raw_cvsacu18 raw_cvdacu18 raw_csttcu18 raw_cssacu18 raw_cottcu18 raw_cosacu18 raw_codacu18 raw_ctttcu18 raw_ctsacu18 raw_ctdacu18 raw_p7r32a raw_p7r32p raw_p7r32c raw_p7r32d raw_p7r32e raw_p7r32f raw_p7r32gda raw_p7r32gmo raw_p7r32gye raw_p7r33a raw_p7r33b raw_p7r33c raw_p8 raw_p9r34a raw_p9r34b raw_p9r34c raw_p9r34d raw_p9r34e raw_p9r34sum raw_p9r35a raw_p9r35b raw_p9r35c raw_p9r35d raw_p9r35e raw_p9r35sum raw_p9r36a1 raw_p9r36a2 raw_p9r36a3 raw_p9r36a4 raw_p9r36a5 raw_p9r36asu raw_p9r36b raw_p10r37 raw_p10r38 raw_p10r39da raw_p10r39mo raw_p10r39ye raw_p10r40 raw_statusd raw_operat1 raw_operat2 raw_operat3 raw_jmlent raw_datecre raw_datemod raw_tahuns raw_field1x raw_field2x raw_field3x raw_field4x raw_field5x raw_keadaan raw_alasan raw_bltutup raw_thtutup raw_output18 raw_iinput18 raw_vtlvcu18 raw_pengtk18 raw_flg18 raw_shfvcu18 raw_srmvcu18 raw_sfnvcu18 raw_stlvcu18 raw_prprex18 raw_iisvcu18 raw_lpmnou18 raw_lpwnou18 raw_lnmnou18 raw_lnwnou18 raw_lprnou18 raw_lnpnou18 raw_dprovi19 raw_dkabup19 raw_dkecam19 raw_ddesa19 raw_dbs19 raw_nama19 raw_alamat19 raw_drt19 raw_drw19 raw_kdpos19 raw_email19 raw_websit19 raw_wiltel19 raw_tlp19 raw_wilfax19 raw_fax19 raw_kpusat19 raw_alpus19 raw_drtpus19 raw_drwpus19 raw_kdposp19 raw_email19p raw_web19p raw_wltel19p raw_tlppus19 raw_wlfax19p raw_faxpus19 raw_disic519 raw_dpusat19 raw_dpemda19 raw_ddmstk19 raw_dasing19 raw_pryrsg19 raw_pryrom19 raw_pryrwh19 raw_pryrre19 raw_pryrin19 raw_pryrot19 raw_pryrod19 raw_sni19 raw_rnd19 raw_costrd19 raw_lpmnol19 raw_lpmnof19 raw_lnmnol19 raw_lnmnof19 raw_lfmnou19 raw_ltmnou19 raw_lpwnol19 raw_lpwnof19 raw_lnwnol19 raw_lnwnof19 raw_lfwnou19 raw_ltwnou19 raw_lprnol19 raw_lprnof19 raw_lnpnol19 raw_lnpnof19 raw_lfanou19 raw_ltlnou19 raw_kategori raw_ltlrnd19 raw_zptvcu19 raw_zntvcu19 raw_zpevcu19 raw_znevcu19 raw_zphvcu19 raw_znhvcu19 raw_zprvcu19 raw_znrvcu19 raw_zpdvcu19 raw_zndvcu19 raw_epeliu19 raw_epevcu19 raw_epelie19 raw_epevce19 raw_esoliu19 raw_esovcu19 raw_esolie19 raw_esovce19 raw_eclkgu19 raw_eclvcu19 raw_eclkge19 raw_eclvce19 raw_ecbkgu19 raw_ecbvcu19 raw_ecbkge19 raw_ecbvce19 raw_egam3u19 raw_egavcu19 raw_egam3e19 raw_egavce19 raw_egom3u19 raw_egovcu19 raw_egom3e19 raw_egovce19 raw_elpkgu19 raw_elpvcu19 raw_elpkge19 raw_elpvce19 raw_encdes19 raw_encvcu19 raw_encvce19 raw_eluliu19 raw_eluvcu19 raw_elulie19 raw_eluvce19 raw_efuvcu19 raw_efuvce19 raw_epckva19 raw_eplkhu19 raw_eplvcu19 raw_enpkhu19 raw_enpvcu19 raw_mgenou19 raw_mgekwu19 raw_esgkhu19 raw_oelkhu19 raw_yelvcu19 raw_ibrvcu19 raw_ilrvcu19 raw_itxvcu19 raw_iislov19 raw_iisfov19 raw_iisfmc19 raw_iisfmp19 raw_iisfmo19 raw_iinvcu19 raw_icovcu19 raw_irrvcu19 raw_idevcu19 raw_iprvcu19 raw_irdvcu19 raw_iklvcu19 raw_ikovcu19 raw_ikivmc19 raw_ikivmp19 raw_ikivmo19 raw_iotvcu19 raw_it1vcu19 raw_rdnvcu19 raw_rimvcu19 raw_rtlvcu19 raw_namrtl raw_pr1rtl raw_prov1rtl raw_pprv1rtl raw_prov2rtl raw_pprv2rtl raw_prov3rtl raw_pprv3rtl raw_pprvortl raw_ekspor19 raw_exsrtl19 raw_yprvcu19 raw_namypr raw_pr1ypr raw_prov1ypr raw_pprv1ypr raw_prov2ypr raw_pprv2ypr raw_prov3ypr raw_pprv3ypr raw_pprvoypr raw_prprca19 raw_yisvdo19 raw_yisvfo19 raw_yisvmc19 raw_yisvmp19 raw_yisvmo19 raw_yisvcu19 raw_yrsvcu19 raw_ykivcu19 raw_ykdvcu19 raw_ykfvcu19 raw_ykfvmc19 raw_ykfvmp19 raw_ykfvmo19 raw_ysnvcu19 raw_yrnvcu19 raw_devvcu19 raw_intvcu19 raw_renvcu19 raw_insvcu19 raw_othvcu19 raw_nopvcu19 raw_srjvcu19 raw_srdvcu19 raw_shjvcu19 raw_shdvcu19 raw_sfjvcu19 raw_sfdvcu19 raw_stjvcu19 raw_stdvcu19 raw_clttcu19 raw_clsacu19 raw_cbttcu19 raw_cbsacu19 raw_cbdacu19 raw_cmttcu19 raw_cmsacu19 raw_cmdacu19 raw_cvttcu19 raw_cvsacu19 raw_cvdacu19 raw_csttcu19 raw_cssacu19 raw_cottcu19 raw_cosacu19 raw_codacu19 raw_ctttcu19 raw_ctsacu19 raw_ctdacu19 raw_r701 raw_r702a raw_r702b raw_r702c raw_r702d raw_r702e raw_r702fdat raw_r702fmon raw_r702fyea raw_rb8 raw_r901a raw_r901b raw_r901c raw_b9r1001a raw_b9r1001b raw_b9r1001c raw_b9r1001d raw_b9r1001e raw_b9r1001s raw_br1002a raw_br1002b raw_br1002c raw_br1002d raw_br1002e raw_br1002s raw_br1003a raw_br1003b raw_br1003c raw_br1003d raw_br1003e raw_br1003f raw_br1003s raw_br1004 raw_br1101 raw_br1102 raw_br1103da raw_br1103mo raw_br1103ye raw_br1104 raw_kondisi raw_lat raw_long raw_lokasi raw_deslokas raw_dstats19 raw_output19 raw_iinput19 raw_vtlvcu19 raw_pengtk19 raw_flag19 raw_flg19 raw_shfvcu19 raw_srmvcu19 raw_sfnvcu19 raw_stlvcu19 raw_prprex19 raw_iisvcu19 raw_lpmnou19 raw_lpwnou19 raw_lnmnou19 raw_lnwnou19 raw_lprnou19 raw_lnpnou19 raw_ikivcu19 raw_baku119 raw_prod119 raw_dprovi20 raw_dkabup20 raw_nama20 raw_disic520 raw_ltlnou20 raw_flg20 raw_dkecam20 raw_ddesa20 raw_alamat20 raw_dyrstr20 raw_zpdvcu20 raw_zndvcu20 raw_pengtk20 raw_yprvcu20 raw_output20 raw_rtlvcu20 raw_iinput20 raw_vtlvcu20 raw_flag20 raw_lprnol20 raw_lprnof20 raw_lnpnof20 raw_lnpnol20 raw_pwtlpi20 raw_pwtppi20 raw_pttlpi20 raw_pttppi20 raw_ptdpri20 raw_pwtlpa20 raw_pwtppa20 raw_pttlpa20 raw_pttppa20 raw_ptdpra20 raw_pwtlni20 raw_pwtpni20 raw_pttlni20 raw_pttpni20 raw_ptdnpi20 raw_pwtlna20 raw_pwtpna20 raw_pttlna20 raw_pttpna20 raw_ptdnpa20 raw_ltlmhs20 raw_ltlshs20 raw_ltlmdi20 raw_ltlmsm20 raw_zptvcu20 raw_zpevcu20 raw_zphvcu20 raw_zprvcu20 raw_zntvcu20 raw_znevcu20 raw_znhvcu20 raw_znrvcu20 raw_rdnvcu20 raw_rimvcu20 raw_efuvcu20 raw_ibrvcu20 raw_iislov20 raw_iisfov20 raw_ipkvcu20 raw_irdvcu20 raw_iklvcu20 raw_ikovcu20 raw_iuwvcu20 raw_eplvcu20 raw_enpvcu20 raw_iotvcu20 raw_ilrvcu20 raw_itxvcu20 raw_iinvcu20 raw_icovcu20 raw_idevcu20 raw_iprvcu20 raw_it1vcu20 raw_yisvcu20 raw_yisvdo20 raw_yisvfo20 raw_yrsvcu20 raw_ykdvcu20 raw_ykfvcu20 raw_ysnvcu20 raw_yelvcu20 raw_shfvcu20 raw_yrnvcu20 raw_nopvcu20 raw_ytovcu20 raw_epevcu20 raw_esovcu20 raw_edivcu20 raw_eclvcu20 raw_ecbvcu20 raw_engvcu20 raw_efovcu20 raw_elpvcu20 raw_ecavcu20 raw_eluvcu20 raw_encvcu20 raw_efuvce20 raw_epevce20 raw_esovce20 raw_edivce20 raw_eclvce20 raw_ecbvce20 raw_engvce20 raw_efovce20 raw_elpvce20 raw_ecavce20 raw_eluvce20 raw_encvce20 raw_epeliu20 raw_esoliu20 raw_ediliu20 raw_eclkgu20 raw_ecbkgu20 raw_engkgu20 raw_efoliu20 raw_elpkgu20 raw_ecakgu20 raw_eluliu20 raw_epelie20 raw_esolie20 raw_edilie20 raw_eclkge20 raw_ecbkge20 raw_engkge20 raw_efolie20 raw_elpkge20 raw_ecakge20 raw_elulie20 raw_eplkhu20 raw_enpkhu20 raw_oelkhu20 raw_esgkhu20 raw_dpusda20 raw_dnfins20 raw_dfinsi20 raw_dasing20 raw_dnopro20 raw_dindiv20 raw_shjvcu20 raw_shdvcu20 raw_srjvcu20 raw_srdvcu20 raw_srmvcu20 raw_sfjvcu20 raw_sfdvcu20 raw_sfnvcu20 raw_stjvcu20 raw_stdvcu20 raw_stlvcu20 raw_prprca20 raw_prprex20 raw_clfpcu20 raw_clttcu20 raw_clsacu20 raw_cbfpcu20 raw_cbttcu20 raw_cbsacu20 raw_cmfpcu20 raw_cmttcu20 raw_cmsacu20 raw_cvfpcu20 raw_cvttcu20 raw_cvsacu20 raw_csfpcu20 raw_csttcu20 raw_cofpcu20 raw_cottcu20 raw_cosacu20 raw_ctfpcu20 raw_ctttcu20 raw_ctsacu20 raw_thnsur raw_dbs20 raw_kdpos20 raw_websit20 raw_email20 raw_tlp20 raw_fax20 raw_kpusat20 raw_alpus20 raw_kdposp20 raw_webkps20 raw_emaikp20 raw_tlppus20 raw_faxpus20 raw_b1r105 raw_shiftm20 raw_shiftd20 raw_rdwhou20 raw_rrdwha20 raw_rrdwhb20 raw_rrdwhc20 raw_rrdwhd20 raw_rrdwhe20 raw_rrdwhl20 raw_ardwha20 raw_ardwhb20 raw_ardwhc20 raw_ardwhd20 raw_ardwhl20 raw_ltloff20 raw_hebtax20 raw_prospe20 raw_opipro20 raw_nameowno raw_pryrom20 raw_pryrwh20 raw_pryrre20 raw_pryrin20 raw_pryrac20 raw_pryrho20 raw_pryrot20 raw_pryrod20 raw_ppr1rtl raw_ppr1ypr raw_snipro20 raw_sniiso20 raw_sniman20 raw_snioth20 raw_rnd20 raw_costrd20 raw_inov20 raw_green20 raw_rgreen20 raw_ygreen20 raw_pgreen20 raw_tgreen20 raw_ecolab20 raw_amdal20 raw_pplihi20 raw_spplhi20 raw_inspli20 raw_pltsur20 raw_pltair20 raw_pltang20 raw_pltdie20 raw_pltbio20 raw_pltgas20 raw_pltoth20 raw_pltotd20 raw_autoai20 raw_iui20 raw_ltlrnd20 raw_encdes20 raw_b3r302l_ raw_b3r302l0 raw_b3r302l1 raw_b3r302l2 raw_b3r302k3 raw_epckva20 raw_mgekin20 raw_mgenou20 raw_mgekwu20 raw_oeukhu20 raw_iisfmp20 raw_iisfmc20 raw_iisfmo20 raw_ikivmp20 raw_ikivmc20 raw_ikivmo20 raw_ekspor20 raw_r402bk2 raw_yisvmc20 raw_yisvmo20 raw_ykfvmp20 raw_ykfvmo20 raw_ykfvmc20 raw_v502b2b raw_yrndes20 raw_r503dk2 raw_r503dk3 raw_sfsvcu20 raw_sfuvcu20 raw_sfcvcu20 raw_sfgvcu20 raw_sfbvcu20 raw_sfrvcu20 raw_sfkvcu20 raw_sfovcu20 raw_cssacu20 raw_r702 raw_r703a raw_r703b raw_r703c raw_r703d raw_r703e raw_r703f raw_r1001a raw_r1001b raw_r1001c raw_r1001d raw_r1001e raw_r1001sum raw_r1002a raw_r1002b raw_r1002c raw_r1002d raw_r1002sum raw_r1003a raw_r1003b raw_r1003c raw_r1003d raw_r1003e raw_r1003f raw_r1003sum raw_r1004 raw_r1101 raw_r1102 raw_r1103 raw_r1104 raw_stsdok raw_opercrea raw_opermodi raw_datecrea raw_datemodi raw_idale raw_ltl20 raw_iuwnou20 raw_yisvmp20 raw_lprnou20 raw_lnpnou20 raw_blkomer raw_thkomer raw_petugas raw_usercrea raw_usermodi raw_dprovi21 raw_dkabup21 raw_dkecam21 raw_ddesa21 raw_dbs21 raw_nama21 raw_alamat21 raw_kdpos21 raw_websit21 raw_email21 raw_tlp21 raw_fax21 raw_kpusat21 raw_alpus21 raw_kdposp21 raw_webkps21 raw_emaikp21 raw_tlppus21 raw_faxpus21 raw_nib21 raw_disic521 raw_shiftm21 raw_shiftd21 raw_rdwhou21 raw_rrdwha21 raw_rrdwhb21 raw_rrdwhc21 raw_rrdwhd21 raw_rrdwhe21 raw_rrdwhl21 raw_ardwha21 raw_ardwhb21 raw_ardwhc21 raw_ardwhd21 raw_ardwhl21 raw_ltloff21 raw_hebtax21 raw_prospe21 raw_opipro21 raw_dpusda21 raw_dnfins21 raw_dfinsi21 raw_dnopro21 raw_dindiv21 raw_dasing21 raw_stockowo raw_pryrom21 raw_pryrwh21 raw_pryrre21 raw_pryrin21 raw_pryrac21 raw_pryrho21 raw_pryrot21 raw_pryrod21 raw_snipro21 raw_sniiso21 raw_sniman21 raw_snioth21 raw_rnd21 raw_costrd21 raw_inov21 raw_green21 raw_rgreen21 raw_ygreen21 raw_pgreen21 raw_tgreen21 raw_ecolab21 raw_amdal21 raw_pplihi21 raw_spplhi21 raw_inspli21 raw_pltsur21 raw_pltair21 raw_pltang21 raw_pltdie21 raw_pltbio21 raw_pltgas21 raw_pltuap21 raw_pltotd21 raw_autoai21 raw_pwtlpi21 raw_pwtlpa21 raw_pwtlni21 raw_pwtlna21 raw_pwtppi21 raw_pwtppa21 raw_pwtpni21 raw_pwtpna21 raw_pttlpi21 raw_pttlpa21 raw_pttlni21 raw_pttlna21 raw_pttppi21 raw_pttppa21 raw_pttpni21 raw_pttpna21 raw_ptdpri21 raw_ptdpra21 raw_ptdnpi21 raw_ptdnpa21 raw_lprnol21 raw_lprnof21 raw_lnpnol21 raw_lnpnof21 raw_ltlmhs21 raw_ltlshs21 raw_ltlmdi21 raw_ltlmsm21 raw_ltlnou21 raw_ltlrnd21 raw_zptvcu21 raw_zpevcu21 raw_zphvcu21 raw_zprvcu21 raw_zntvcu21 raw_znevcu21 raw_znhvcu21 raw_znrvcu21 raw_zpdvcu21 raw_zndvcu21 raw_epeliu21 raw_epevcu21 raw_epelie21 raw_epevce21 raw_esoliu21 raw_esovcu21 raw_esolie21 raw_esovce21 raw_esdliu21 raw_esdvcu21 raw_esdlie21 raw_esdvce21 raw_ediliu21 raw_edivcu21 raw_edilie21 raw_edivce21 raw_eclkgu21 raw_eclvcu21 raw_eclkge21 raw_eclvce21 raw_ecbkgu21 raw_ecbvcu21 raw_ecbkge21 raw_ecbvce21 raw_engkgu21 raw_engvcu21 raw_engkge21 raw_engvce21 raw_efoliu21 raw_efovcu21 raw_efolie21 raw_efovce21 raw_elpkgu21 raw_elpvcu21 raw_elpkge21 raw_elpvce21 raw_ecades21 raw_ecakgu21 raw_ecavcu21 raw_ecakge21 raw_ecavce21 raw_encvcu21 raw_encvce21 raw_eluliu21 raw_eluvcu21 raw_elulie21 raw_eluvce21 raw_efuvcu21 raw_efuvce21 raw_epckva21 raw_eplkhu21 raw_eplvcu21 raw_enpkhu21 raw_enpvcu21 raw_mgekin21 raw_mgenou21 raw_mgekwu21 raw_esgkhu21 raw_oeukhu21 raw_oelkhu21 raw_ibrvcu21 raw_ilrvcu21 raw_itxvcu21 raw_iislov21 raw_iisfov21 raw_iisfmp21 raw_iisfmc21 raw_iisfmo21 raw_iinvcu21 raw_icovcu21 raw_ipkvcu21 raw_idevcu21 raw_iprvcu21 raw_irdvcu21 raw_iklvcu21 raw_ikovcu21 raw_ikivmp21 raw_ikivmc21 raw_ikivmo21 raw_iuwvcu21 raw_iotvcu21 raw_it1vcu21 raw_rdnvcu21 raw_rimvcu21 raw_prprca21 raw_ekspor21 raw_yprvcu21 raw_yisvdo21 raw_yisvfo21 raw_yisvmc21 raw_yisvmo21 raw_yisvcu21 raw_yrsvcu21 raw_b5r502bx raw_ykdvcu21 raw_ykfvcu21 raw_ykfvmp21 raw_ykfvmc21 raw_ykfvmo21 raw_ysnvcu21 raw_yelvcu21 raw_nopvcu21 raw_yrnvcu21 raw_yrndes21 raw_ytovcu21 raw_srjvcu21 raw_srdvcu21 raw_shjvcu21 raw_shdvcu21 raw_sfjvcu21 raw_sfdvcu21 raw_stjvcu21 raw_stdvcu21 raw_sfsvcu21 raw_sfuvcu21 raw_sfcvcu21 raw_sfgvcu21 raw_sfbvcu21 raw_sfrvcu21 raw_sfkvcu21 raw_sfovcu21 raw_clfpcu21 raw_clttcu21 raw_clsacu21 raw_cbfpcu21 raw_cbttcu21 raw_cbsacu21 raw_cmfpcu21 raw_cmttcu21 raw_cmsacu21 raw_cvfpcu21 raw_cvttcu21 raw_cvsacu21 raw_csfpcu21 raw_csttcu21 raw_cssacu21 raw_cofpcu21 raw_cottcu21 raw_cosacu21 raw_ctfpcu21 raw_ctttcu21 raw_ctsacu21 raw_flg21 raw_bdnusaha raw_blkom raw_dyrstr21 raw_skalatk raw_skalinv raw_skalaoms raw_pengtk21 raw_rtlvcu21 raw_output21 raw_iinput21 raw_vtlvcu21 raw_flag21 raw_prprex21 raw_srmvcu21 raw_shfvcu21 raw_sfnvcu21 raw_stlvcu21 raw_yisvmp21 raw_iuwnou21 raw_lprnou21 raw_lnpnou21 raw_dprovi22 raw_dkabup22 raw_dkecam22 raw_ddesa22 raw_dbs raw_nama22 raw_alamat22 raw_kdpos22 raw_websit22 raw_email22 raw_tlp22 raw_fax22 raw_kpusat22 raw_alpus22 raw_kdposp22 raw_webkps22 raw_emaikp22 raw_tlppus22 raw_faxpus22 raw_nib22 raw_disic522 raw_shiftm22 raw_shiftd22 raw_dpusda22 raw_dnfins22 raw_dfinsi22 raw_dnopro22 raw_dindiv22 raw_dasing22 raw_rnd22 raw_costrd22 raw_inov22 raw_amdal22 raw_pplihi22 raw_spplhi22 raw_inspli22 raw_sowste22 raw_liwste22 raw_b3wste22 raw_lpmnop22 raw_lpmnon22 raw_lnmnop22 raw_lnmnon22 raw_lpwnop22 raw_lpwnon22 raw_lnwnop22 raw_lnwnon22 raw_lprnop22 raw_lprnon22 raw_lnpnop22 raw_lnpnon22 raw_ltlnof22 raw_ltlrnd22 raw_zptvcu22 raw_zntvcu22 raw_zprvcu22 raw_znrvcu22 raw_zpdvcu22 raw_zndvcu22 raw_epeliu22 raw_epevcu22 raw_epelie22 raw_epevce22 raw_esoliu22 raw_esovcu22 raw_esolie22 raw_esovce22 raw_esdliu22 raw_esdvcu22 raw_esdlie22 raw_esdvce22 raw_ediliu22 raw_edivcu22 raw_edilie22 raw_edivce22 raw_eclkgu22 raw_eclvcu22 raw_eclkge22 raw_eclvce22 raw_eckkgu22 raw_eckvcu22 raw_eckkge22 raw_eckvce22 raw_ecbkgu22 raw_ecbvcu22 raw_ecbkge raw_ecbvce raw_engkgu22 raw_engvcu22 raw_engkge22 raw_engvce22 raw_efoliu22 raw_efovcu22 raw_efolie22 raw_efovce22 raw_elpkgu22 raw_elpvcu22 raw_elpkge22 raw_elpvce22 raw_ecakgu22 raw_ecavcu22 raw_ecakge22 raw_ecavce22 raw_ecades22 raw_encvcu22 raw_encvce22 raw_encdes22 raw_eluliu22 raw_eluvcu22 raw_elulie22 raw_eluvce22 raw_efuvcu22 raw_efuvce22 raw_epckva22 raw_eplkhu22 raw_eplvcu22 raw_enpkhu22 raw_enpvcu22 raw_mgekin22 raw_mgenou22 raw_mgekwu22 raw_esgkhu22 raw_oeukhu22 raw_oelkhu22 raw_ibrvcu22 raw_ilrvcu22 raw_itxvcu22 raw_iislov22 raw_iisfov22 raw_iinvcu22 raw_icovcu22 raw_ipkvcu22 raw_idevcu22 raw_iprvcu22 raw_irdvcu22 raw_iklvcu22 raw_ikovcu22 raw_iuwvcu22 raw_iotvcu22 raw_it1vcu22 raw_impor22 raw_rdnvcu22 raw_rimvcu22 raw_prprca22 raw_ekspor22 raw_yprvcu22 raw_yisvdo22 raw_yisvfo22 raw_yisvcu22 raw_yrsvcu22 raw_ykdvcu22 raw_ykfvcu22 raw_ysnvcu22 raw_yelvcu22 raw_nopvcu22 raw_yrnvcu22 raw_yrndes22 raw_ytovcu22 raw_srjvcu22 raw_srdvcu22 raw_shjvcu22 raw_shdvcu22 raw_sfjvcu22 raw_sfdvcu22 raw_stjvcu22 raw_stdvcu22 raw_clfpcu22 raw_clttcu22 raw_clsacu22 raw_cbfpcu22 raw_cbttcu22 raw_cbsacu22 raw_cmfpcu22 raw_cmttcu22 raw_cmsacu22 raw_cvfpcu22 raw_cvttcu22 raw_cvsacu22 raw_csfpcu22 raw_csttcu22 raw_r601e_k4 raw_cofpcu22 raw_cottcu22 raw_cosacu22 raw_ctfpcu22 raw_ctttcu22 raw_ctsacu22 raw_r703fbln raw_flg22p raw_est raw_lprnou22 raw_lnpnou22 raw_ltlnou22 raw_pengtk22 raw_rtlvcu22 raw_srmvcu22 raw_shfvcu22 raw_sfnvcu22 raw_stlvcu22 raw_output22 raw_iinput22 raw_vtlvcu22 st_amdal_raw st_b3wste_raw st_capital_additions_nominal st_capital_nominal st_capital_stock_nominal st_export_binary_raw st_export_share_pct st_foreign_ownership_pct st_gross_output_nominal st_import_value_nominal st_innovation_marketing_raw st_innovation_org_raw st_innovation_process_raw st_innovation_product_raw st_innovation_raw st_inspli_raw st_intermediate_inputs_nominal st_liwste_raw st_pplihi_raw st_production_workers st_rd_cost_nominal st_rd_indicator_raw st_rd_workers st_sowste_raw st_spplhi_raw st_val_cbdacu st_val_cbfpcu st_val_cbsacu st_val_cbttcu st_val_cldacu st_val_clfpcu st_val_clsacu st_val_clttcu st_val_cmdacu st_val_cmfpcu st_val_cmsacu st_val_cmttcu st_val_codacu st_val_cofpcu st_val_cosacu st_val_costrd st_val_cottcu st_val_csdacu st_val_csfpcu st_val_cssacu st_val_csttcu st_val_ctdacu st_val_ctfpcu st_val_ctsacu st_val_cttcu st_val_ctttcu st_val_cvdacu st_val_cvfpcu st_val_cvsacu st_val_cvttcu st_val_devvcu st_val_ecavce st_val_ecavcu st_val_ecbvce st_val_ecbvcu st_val_eckvce st_val_eckvcu st_val_eclvce st_val_eclvcu st_val_edivce st_val_edivcu st_val_efovce st_val_efovcu st_val_efuvce st_val_efuvcu st_val_egavce st_val_egavcu st_val_egovce st_val_egovcu st_val_elpvce st_val_elpvcu st_val_eluvce st_val_eluvcu st_val_encvce st_val_encvcu st_val_engvce st_val_engvcu st_val_enpvcu st_val_eoivce st_val_eoivcu st_val_epevce st_val_epevcu st_val_eplvcu st_val_esdvce st_val_esdvcu st_val_esovce st_val_esovcu st_val_ibrvcu st_val_icovcu st_val_idevcu st_val_iinput st_val_iinvcu st_val_iisfov st_val_iislov st_val_iisvcu st_val_ikivcu st_val_iklvcu st_val_ikovcu st_val_ilrvcu st_val_insvcu st_val_intvcu st_val_iotvcu st_val_ipkvcu st_val_iprvcu st_val_irdvcu st_val_irevcu st_val_irrvcu st_val_itxvcu st_val_iuwvcu st_val_nopvcu st_val_othvcu st_val_output st_val_rdnvcu st_val_renvcu st_val_rimvcu st_val_rtlvcu st_val_sfbvcu st_val_sfcvcu st_val_sfdvcu st_val_sfgvcu st_val_sfjvcu st_val_sfkvcu st_val_sfnvcu st_val_sfovcu st_val_sfrvcu st_val_sfsvcu st_val_sfuvcu st_val_shdvcu st_val_shfvcu st_val_shjvcu st_val_srdvcu st_val_srjvcu st_val_srmvcu st_val_stdvcu st_val_stjvcu st_val_stlvcu st_val_vtlvcu st_val_yelvcu st_val_yisvcu st_val_yisvdo st_val_yisvfo st_val_ykdvcu st_val_ykfvcu st_val_ykivcu st_val_yprvcu st_val_yrnvcu st_val_yrsvcu st_val_ysnvcu st_val_ytovcu st_val_znavcu st_val_zndvcu st_val_znevcu st_val_znhvcu st_val_znivcu st_val_znovcu st_val_znpvcu st_val_znrvcu st_val_znsvcu st_val_zntvcu st_val_zpavcu st_val_zpdvcu st_val_zpevcu st_val_zphvcu st_val_zpivcu st_val_zpovcu st_val_zppvcu st_val_zprvcu st_val_zpsvcu st_val_zptvcu st_value_added_nominal st_workers st_elec_nonpln_kwh st_elec_nonpln_rp000 st_elec_owngen_kwh st_elec_pln_kwh st_elec_pln_rp000 st_fuel_biodiesel_ltr st_fuel_biodiesel_rp000 st_fuel_charcoal_kg st_fuel_charcoal_rp000 st_fuel_citygas_m3 st_fuel_citygas_rp000 st_fuel_coal_kg st_fuel_coal_rp000 st_fuel_coalbriq_kg st_fuel_coalbriq_rp000 st_fuel_coke_kg st_fuel_coke_rp000 st_fuel_diesel_ltr st_fuel_diesel_rp000 st_fuel_dieseloil_ltr st_fuel_dieseloil_rp000 st_fuel_firewood_kg st_fuel_firewood_rp000 st_fuel_fueloil_ltr st_fuel_fueloil_rp000 st_fuel_kerosene_ltr st_fuel_kerosene_rp000 st_fuel_lpg_kg st_fuel_lpg_rp000 st_fuel_lubricant_ltr st_fuel_lubricant_rp000 st_fuel_natgas_kg st_fuel_natgas_rp000 st_fuel_other_rp000 st_fuel_othergas_m3 st_fuel_othergas_rp000 st_fuel_petrol_ltr st_fuel_petrol_rp000 st_fuel_total_reported_rp000 legacy_unit_contract unit_status grid_factor_s1 grid_factor_s2 factor_status factor_contract any_negative_quantity any_implausible_price cl_fuel_biodiesel_ltr cl_fuel_biodiesel_rp000 cl_fuel_charcoal_kg cl_fuel_charcoal_rp000 cl_fuel_citygas_m3 cl_fuel_citygas_rp000 cl_fuel_coal_kg cl_fuel_coal_rp000 cl_fuel_coalbriq_kg cl_fuel_coalbriq_rp000 cl_fuel_coke_kg cl_fuel_coke_rp000 cl_fuel_diesel_ltr cl_fuel_diesel_rp000 cl_fuel_dieseloil_ltr cl_fuel_dieseloil_rp000 cl_fuel_firewood_kg cl_fuel_firewood_rp000 cl_fuel_fueloil_ltr cl_fuel_fueloil_rp000 cl_fuel_kerosene_ltr cl_fuel_kerosene_rp000 cl_fuel_lpg_kg cl_fuel_lpg_rp000 cl_fuel_lubricant_ltr cl_fuel_lubricant_rp000 cl_fuel_natgas_kg cl_fuel_natgas_rp000 cl_fuel_other_rp000 cl_fuel_othergas_m3 cl_fuel_othergas_rp000 cl_fuel_petrol_ltr cl_fuel_petrol_rp000 cl_fuel_total_reported_rp000 cl_elec_nonpln_kwh cl_elec_nonpln_rp000 cl_elec_owngen_kwh cl_elec_pln_kwh cl_elec_pln_rp000 price_diesel p99_diesel price_petrol p99_petrol price_kerosene p99_kerosene price_coal price_lpg p99_lpg price_citygas p99_citygas price_othergas p99_othergas price_coalbriq p99_coalbriq price_coke price_firewood p99_firewood price_charcoal price_dieseloil p99_dieseloil price_fueloil p99_fueloil price_lubricant p99_lubricant price_biodiesel p99_biodiesel price_natgas price_elec p99_elec energy_outlier_flag energy_outlier_flag_legacy outlier_rule cleaning_status fuel_components_rp000 fuel_components_extended fuel_expenditure_rp000 fuel_expenditure_basis fuel_reconciliation_gap fuel_reconciliation_gap_extended electricity_expenditure_rp000 electricity_cost_n_observed energy_expenditure_rp000 export_share_valid export_binary_valid export_flag_conditional export_definition_conflict export_binary_assumed_flag export_observed export_definition_status import_flag import_observed fdi_any_flag fdi_10_flag fdi_observed large_gt100_flag accounting_gap accounting_identity_valid inputs_definition_status capital_prior_mixed_nominal capital_stock_verified capital_additions_verified capital_definition_status capital_prior_status worker_denominator_state labor_productivity_nominal output_per_worker_nominal capital_per_worker_nominal inputs_per_worker_nominal rd_cost_per_worker_nominal energy_cost_per_worker total_gj_per_worker co2_per_worker capital_stock_per_worker ln_capital_stock_nominal capital_additions_per_worker ln_capital_additions_nominal value_added_share_of_output energy_intensity_monetary energy_intensity_gj_nominal co2_intensity_nominal ln_output_nominal ln_va_nominal ln_capital_nominal ln_inputs_nominal ln_workers ln_total_gj_s1 ln_co2_total_s1 ln_energy_expenditure ln_import_nominal ln_rd_cost_nominal ln_val_cbdacu pw_val_cbdacu ln_val_cbfpcu pw_val_cbfpcu ln_val_cbsacu pw_val_cbsacu ln_val_cbttcu pw_val_cbttcu ln_val_cldacu pw_val_cldacu ln_val_clfpcu pw_val_clfpcu ln_val_clsacu pw_val_clsacu ln_val_clttcu pw_val_clttcu ln_val_cmdacu pw_val_cmdacu ln_val_cmfpcu pw_val_cmfpcu ln_val_cmsacu pw_val_cmsacu ln_val_cmttcu pw_val_cmttcu ln_val_codacu pw_val_codacu ln_val_cofpcu pw_val_cofpcu ln_val_cosacu pw_val_cosacu ln_val_costrd pw_val_costrd ln_val_cottcu pw_val_cottcu ln_val_csdacu pw_val_csdacu ln_val_csfpcu pw_val_csfpcu ln_val_cssacu pw_val_cssacu ln_val_csttcu pw_val_csttcu ln_val_ctdacu pw_val_ctdacu ln_val_ctfpcu pw_val_ctfpcu ln_val_ctsacu pw_val_ctsacu ln_val_cttcu pw_val_cttcu ln_val_ctttcu pw_val_ctttcu ln_val_cvdacu pw_val_cvdacu ln_val_cvfpcu pw_val_cvfpcu ln_val_cvsacu pw_val_cvsacu ln_val_cvttcu pw_val_cvttcu ln_val_devvcu pw_val_devvcu ln_val_ecavce pw_val_ecavce ln_val_ecavcu pw_val_ecavcu ln_val_ecbvce pw_val_ecbvce ln_val_ecbvcu pw_val_ecbvcu ln_val_eckvce pw_val_eckvce ln_val_eckvcu pw_val_eckvcu ln_val_eclvce pw_val_eclvce ln_val_eclvcu pw_val_eclvcu ln_val_edivce pw_val_edivce ln_val_edivcu pw_val_edivcu ln_val_efovce pw_val_efovce ln_val_efovcu pw_val_efovcu ln_val_efuvce pw_val_efuvce ln_val_efuvcu pw_val_efuvcu ln_val_egavce pw_val_egavce ln_val_egavcu pw_val_egavcu ln_val_egovce pw_val_egovce ln_val_egovcu pw_val_egovcu ln_val_elpvce pw_val_elpvce ln_val_elpvcu pw_val_elpvcu ln_val_eluvce pw_val_eluvce ln_val_eluvcu pw_val_eluvcu ln_val_encvce pw_val_encvce ln_val_encvcu pw_val_encvcu ln_val_engvce pw_val_engvce ln_val_engvcu pw_val_engvcu ln_val_enpvcu pw_val_enpvcu ln_val_eoivce pw_val_eoivce ln_val_eoivcu pw_val_eoivcu ln_val_epevce pw_val_epevce ln_val_epevcu pw_val_epevcu ln_val_eplvcu pw_val_eplvcu ln_val_esdvce pw_val_esdvce ln_val_esdvcu pw_val_esdvcu ln_val_esovce pw_val_esovce ln_val_esovcu pw_val_esovcu ln_val_ibrvcu pw_val_ibrvcu ln_val_icovcu pw_val_icovcu ln_val_idevcu pw_val_idevcu ln_val_iinput pw_val_iinput ln_val_iinvcu pw_val_iinvcu ln_val_iisfov pw_val_iisfov ln_val_iislov pw_val_iislov ln_val_iisvcu pw_val_iisvcu ln_val_ikivcu pw_val_ikivcu ln_val_iklvcu pw_val_iklvcu ln_val_ikovcu pw_val_ikovcu ln_val_ilrvcu pw_val_ilrvcu ln_val_insvcu pw_val_insvcu ln_val_intvcu pw_val_intvcu ln_val_iotvcu pw_val_iotvcu ln_val_ipkvcu pw_val_ipkvcu ln_val_iprvcu pw_val_iprvcu ln_val_irdvcu pw_val_irdvcu ln_val_irevcu pw_val_irevcu ln_val_irrvcu pw_val_irrvcu ln_val_itxvcu pw_val_itxvcu ln_val_iuwvcu pw_val_iuwvcu ln_val_nopvcu pw_val_nopvcu ln_val_othvcu pw_val_othvcu ln_val_output pw_val_output ln_val_rdnvcu pw_val_rdnvcu ln_val_renvcu pw_val_renvcu ln_val_rimvcu pw_val_rimvcu ln_val_rtlvcu pw_val_rtlvcu ln_val_sfbvcu pw_val_sfbvcu ln_val_sfcvcu pw_val_sfcvcu ln_val_sfdvcu pw_val_sfdvcu ln_val_sfgvcu pw_val_sfgvcu ln_val_sfjvcu pw_val_sfjvcu ln_val_sfkvcu pw_val_sfkvcu ln_val_sfnvcu pw_val_sfnvcu ln_val_sfovcu pw_val_sfovcu ln_val_sfrvcu pw_val_sfrvcu ln_val_sfsvcu pw_val_sfsvcu ln_val_sfuvcu pw_val_sfuvcu ln_val_shdvcu pw_val_shdvcu ln_val_shfvcu pw_val_shfvcu ln_val_shjvcu pw_val_shjvcu ln_val_srdvcu pw_val_srdvcu ln_val_srjvcu pw_val_srjvcu ln_val_srmvcu pw_val_srmvcu ln_val_stdvcu pw_val_stdvcu ln_val_stjvcu pw_val_stjvcu ln_val_stlvcu pw_val_stlvcu ln_val_vtlvcu pw_val_vtlvcu ln_val_yelvcu pw_val_yelvcu ln_val_yisvcu pw_val_yisvcu ln_val_yisvdo pw_val_yisvdo ln_val_yisvfo pw_val_yisvfo ln_val_ykdvcu pw_val_ykdvcu ln_val_ykfvcu pw_val_ykfvcu ln_val_ykivcu pw_val_ykivcu ln_val_yprvcu pw_val_yprvcu ln_val_yrnvcu pw_val_yrnvcu ln_val_yrsvcu pw_val_yrsvcu ln_val_ysnvcu pw_val_ysnvcu ln_val_ytovcu pw_val_ytovcu ln_val_znavcu pw_val_znavcu ln_val_zndvcu pw_val_zndvcu ln_val_znevcu pw_val_znevcu ln_val_znhvcu pw_val_znhvcu ln_val_znivcu pw_val_znivcu ln_val_znovcu pw_val_znovcu ln_val_znpvcu pw_val_znpvcu ln_val_znrvcu pw_val_znrvcu ln_val_znsvcu pw_val_znsvcu ln_val_zntvcu pw_val_zntvcu ln_val_zpavcu pw_val_zpavcu ln_val_zpdvcu pw_val_zpdvcu ln_val_zpevcu pw_val_zpevcu ln_val_zphvcu pw_val_zphvcu ln_val_zpivcu pw_val_zpivcu ln_val_zpovcu pw_val_zpovcu ln_val_zppvcu pw_val_zppvcu ln_val_zprvcu pw_val_zprvcu ln_val_zpsvcu pw_val_zpsvcu ln_val_zptvcu pw_val_zptvcu out_gross_output_nominal out_value_added_nominal out_capital_nominal out_workers source_id_observed source_id_multiplicity source_id_tag native_id_unique real_panel_ready panel_status classification_status deflator_output deflator_inputs deflator_capital deflator_wages gross_output_real value_added_real capital_real intermediate_inputs_real deflator_applied deflator_status legacy_output_wpi_year_exists legacy_input_wpi_year_exists money_unit_status candidate_status legacy_rd_cost_mislabelled legacy_export_share_flag legacy_total_gj_s1 legacy_co2_total_s1 legacy_fuel_coal_alias legacy_fuel_coke_alias legacy_fuel_natgas_alias legacy_fuel_charcoal_alias amdal_raw vs_amdal_raw b3wste_raw vs_b3wste_raw capital_additions_nominal vs_capital_additions_nominal capital_nominal vs_capital_nominal capital_stock_nominal vs_capital_stock_nominal export_binary_raw vs_export_binary_raw export_share_pct vs_export_share_pct foreign_ownership_pct vs_foreign_ownership_pct gross_output_nominal vs_gross_output_nominal import_value_nominal vs_import_value_nominal innovation_marketing_raw vs_innovation_marketing_raw innovation_org_raw vs_innovation_org_raw innovation_process_raw vs_innovation_process_raw innovation_product_raw vs_innovation_product_raw innovation_raw vs_innovation_raw inspli_raw vs_inspli_raw intermediate_inputs_nominal vs_intermediate_inputs_nominal liwste_raw vs_liwste_raw pplihi_raw vs_pplihi_raw production_workers vs_production_workers rd_cost_nominal vs_rd_cost_nominal rd_indicator_raw vs_rd_indicator_raw rd_workers vs_rd_workers sowste_raw vs_sowste_raw spplhi_raw vs_spplhi_raw val_cbdacu vs_val_cbdacu val_cbfpcu vs_val_cbfpcu val_cbsacu vs_val_cbsacu val_cbttcu vs_val_cbttcu val_cldacu vs_val_cldacu val_clfpcu vs_val_clfpcu val_clsacu vs_val_clsacu val_clttcu vs_val_clttcu val_cmdacu vs_val_cmdacu val_cmfpcu vs_val_cmfpcu val_cmsacu vs_val_cmsacu val_cmttcu vs_val_cmttcu val_codacu vs_val_codacu val_cofpcu vs_val_cofpcu val_cosacu vs_val_cosacu val_costrd vs_val_costrd val_cottcu vs_val_cottcu val_csdacu vs_val_csdacu val_csfpcu vs_val_csfpcu val_cssacu vs_val_cssacu val_csttcu vs_val_csttcu val_ctdacu vs_val_ctdacu val_ctfpcu vs_val_ctfpcu val_ctsacu vs_val_ctsacu val_cttcu vs_val_cttcu val_ctttcu vs_val_ctttcu val_cvdacu vs_val_cvdacu val_cvfpcu vs_val_cvfpcu val_cvsacu vs_val_cvsacu val_cvttcu vs_val_cvttcu val_devvcu vs_val_devvcu val_ecavce vs_val_ecavce val_ecavcu vs_val_ecavcu val_ecbvce vs_val_ecbvce val_ecbvcu vs_val_ecbvcu val_eckvce vs_val_eckvce val_eckvcu vs_val_eckvcu val_eclvce vs_val_eclvce val_eclvcu vs_val_eclvcu val_edivce vs_val_edivce val_edivcu vs_val_edivcu val_efovce vs_val_efovce val_efovcu vs_val_efovcu val_efuvce vs_val_efuvce val_efuvcu vs_val_efuvcu val_egavce vs_val_egavce val_egavcu vs_val_egavcu val_egovce vs_val_egovce val_egovcu vs_val_egovcu val_elpvce vs_val_elpvce val_elpvcu vs_val_elpvcu val_eluvce vs_val_eluvce val_eluvcu vs_val_eluvcu val_encvce vs_val_encvce val_encvcu vs_val_encvcu val_engvce vs_val_engvce val_engvcu vs_val_engvcu val_enpvcu vs_val_enpvcu val_eoivce vs_val_eoivce val_eoivcu vs_val_eoivcu val_epevce vs_val_epevce val_epevcu vs_val_epevcu val_eplvcu vs_val_eplvcu val_esdvce vs_val_esdvce val_esdvcu vs_val_esdvcu val_esovce vs_val_esovce val_esovcu vs_val_esovcu val_ibrvcu vs_val_ibrvcu val_icovcu vs_val_icovcu val_idevcu vs_val_idevcu val_iinput vs_val_iinput val_iinvcu vs_val_iinvcu val_iisfov vs_val_iisfov val_iislov vs_val_iislov val_iisvcu vs_val_iisvcu val_ikivcu vs_val_ikivcu val_iklvcu vs_val_iklvcu val_ikovcu vs_val_ikovcu val_ilrvcu vs_val_ilrvcu val_insvcu vs_val_insvcu val_intvcu vs_val_intvcu val_iotvcu vs_val_iotvcu val_ipkvcu vs_val_ipkvcu val_iprvcu vs_val_iprvcu val_irdvcu vs_val_irdvcu val_irevcu vs_val_irevcu val_irrvcu vs_val_irrvcu val_itxvcu vs_val_itxvcu val_iuwvcu vs_val_iuwvcu val_nopvcu vs_val_nopvcu val_othvcu vs_val_othvcu val_output vs_val_output val_rdnvcu vs_val_rdnvcu val_renvcu vs_val_renvcu val_rimvcu vs_val_rimvcu val_rtlvcu vs_val_rtlvcu val_sfbvcu vs_val_sfbvcu val_sfcvcu vs_val_sfcvcu val_sfdvcu vs_val_sfdvcu val_sfgvcu vs_val_sfgvcu val_sfjvcu vs_val_sfjvcu val_sfkvcu vs_val_sfkvcu val_sfnvcu vs_val_sfnvcu val_sfovcu vs_val_sfovcu val_sfrvcu vs_val_sfrvcu val_sfsvcu vs_val_sfsvcu val_sfuvcu vs_val_sfuvcu val_shdvcu vs_val_shdvcu val_shfvcu vs_val_shfvcu val_shjvcu vs_val_shjvcu val_srdvcu vs_val_srdvcu val_srjvcu vs_val_srjvcu val_srmvcu vs_val_srmvcu val_stdvcu vs_val_stdvcu val_stjvcu vs_val_stjvcu val_stlvcu vs_val_stlvcu val_vtlvcu vs_val_vtlvcu val_yelvcu vs_val_yelvcu val_yisvcu vs_val_yisvcu val_yisvdo vs_val_yisvdo val_yisvfo vs_val_yisvfo val_ykdvcu vs_val_ykdvcu val_ykfvcu vs_val_ykfvcu val_ykivcu vs_val_ykivcu val_yprvcu vs_val_yprvcu val_yrnvcu vs_val_yrnvcu val_yrsvcu vs_val_yrsvcu val_ysnvcu vs_val_ysnvcu val_ytovcu vs_val_ytovcu val_znavcu vs_val_znavcu val_zndvcu vs_val_zndvcu val_znevcu vs_val_znevcu val_znhvcu vs_val_znhvcu val_znivcu vs_val_znivcu val_znovcu vs_val_znovcu val_znpvcu vs_val_znpvcu val_znrvcu vs_val_znrvcu val_znsvcu vs_val_znsvcu val_zntvcu vs_val_zntvcu val_zpavcu vs_val_zpavcu val_zpdvcu vs_val_zpdvcu val_zpevcu vs_val_zpevcu val_zphvcu vs_val_zphvcu val_zpivcu vs_val_zpivcu val_zpovcu vs_val_zpovcu val_zppvcu vs_val_zppvcu val_zprvcu vs_val_zprvcu val_zpsvcu vs_val_zpsvcu val_zptvcu vs_val_zptvcu value_added_nominal vs_value_added_nominal workers vs_workers source_id_raw vs_source_id_raw district_code vs_district_code industry_code vs_industry_code province_code vs_province_code elec_nonpln_kwh vs_elec_nonpln_kwh elec_nonpln_rp000 vs_elec_nonpln_rp000 elec_owngen_kwh vs_elec_owngen_kwh elec_pln_kwh vs_elec_pln_kwh elec_pln_rp000 vs_elec_pln_rp000 fuel_biodiesel_ltr vs_fuel_biodiesel_ltr fuel_biodiesel_rp000 vs_fuel_biodiesel_rp000 fuel_charcoal_kg vs_fuel_charcoal_kg fuel_charcoal_rp000 vs_fuel_charcoal_rp000 fuel_citygas_m3 vs_fuel_citygas_m3 fuel_citygas_rp000 vs_fuel_citygas_rp000 fuel_coal_kg vs_fuel_coal_kg fuel_coal_rp000 vs_fuel_coal_rp000 fuel_coalbriq_kg vs_fuel_coalbriq_kg fuel_coalbriq_rp000 vs_fuel_coalbriq_rp000 fuel_coke_kg vs_fuel_coke_kg fuel_coke_rp000 vs_fuel_coke_rp000 fuel_diesel_ltr vs_fuel_diesel_ltr fuel_diesel_rp000 vs_fuel_diesel_rp000 fuel_dieseloil_ltr vs_fuel_dieseloil_ltr fuel_dieseloil_rp000 vs_fuel_dieseloil_rp000 fuel_firewood_kg vs_fuel_firewood_kg fuel_firewood_rp000 vs_fuel_firewood_rp000 fuel_fueloil_ltr vs_fuel_fueloil_ltr fuel_fueloil_rp000 vs_fuel_fueloil_rp000 fuel_kerosene_ltr vs_fuel_kerosene_ltr fuel_kerosene_rp000 vs_fuel_kerosene_rp000 fuel_lpg_kg vs_fuel_lpg_kg fuel_lpg_rp000 vs_fuel_lpg_rp000 fuel_lubricant_ltr vs_fuel_lubricant_ltr fuel_lubricant_rp000 vs_fuel_lubricant_rp000 fuel_natgas_kg vs_fuel_natgas_kg fuel_natgas_rp000 vs_fuel_natgas_rp000 fuel_other_rp000 vs_fuel_other_rp000 fuel_othergas_m3 vs_fuel_othergas_m3 fuel_othergas_rp000 vs_fuel_othergas_rp000 fuel_petrol_ltr vs_fuel_petrol_ltr fuel_petrol_rp000 vs_fuel_petrol_rp000 fuel_total_reported_rp000 vs_fuel_total_reported_rp000 export_direct_flag vs_export_direct_flag env_amdal_flag vs_env_amdal_flag env_ukl_upl_flag vs_env_ukl_upl_flag env_sppl_flag vs_env_sppl_flag env_waste_treatment_flag vs_env_waste_treatment_flag waste_solid_flag vs_waste_solid_flag waste_liquid_flag vs_waste_liquid_flag waste_hazardous_flag vs_waste_hazardous_flag fuel_natgas_mmbtu vs_fuel_natgas_mmbtu fuel_biomass_kg vs_fuel_biomass_kg rd_cost_definition_status export_verified_conflict p99_coal p99_coke p99_natgas p99_charcoal coal_unit_verified coal_source_unit co2_diesel_s1 co2_diesel_s2 gj_diesel co2_petrol_s1 co2_petrol_s2 gj_petrol co2_kerosene_s1 co2_kerosene_s2 gj_kerosene co2_coal_s1 co2_coal_s2 gj_coal co2_lpg_s1 co2_lpg_s2 gj_lpg co2_citygas_s1 co2_citygas_s2 gj_citygas co2_othergas_s1 co2_othergas_s2 gj_othergas co2_coalbriq_s1 co2_coalbriq_s2 gj_coalbriq co2_coke_s1 co2_coke_s2 gj_coke co2_scope1_nfuels_s1 co2_scope1_s1 co2_scope1_s2 gj_fuel_s1 nine_fuels_complete electricity_n_observed elec_purchased_kwh gj_electricity co2_scope2_s1 co2_scope2_s2 co2_total_s1 co2_total_s2 total_gj_s1 co2_scope1_complete co2_scope2_complete co2_total_complete total_gj_complete co2_variant_static_grid own_generation_reported own_generation_added extra_fuel_positive energy_coverage_status g0_schema_version export_flag export_any_binary vs_export_any_binary rd_activity_flag vs_rd_activity_flag rd_external_funding_flag vs_rd_external_funding_flag innovation_flag vs_innovation_flag v_export_any_binary v_rd_activity_flag v_rd_external_funding_flag innovation_product_flag v_innovation_product_flag vs_innovation_product_flag innovation_process_flag v_innovation_process_flag vs_innovation_process_flag innovation_marketing_flag v_innovation_marketing_flag vs_innovation_marketing_flag innovation_org_flag v_innovation_org_flag vs_innovation_org_flag v_innovation_flag v_export_flag vs_export_flag export_assumption_conflict analysis_contract identity_mode identity_is_dummy identity_real_link_verified identity_xtset_ready selected_firm_id selected_district_code dummy_firm_id dummy_district_code identity_eligibility identity_district_status dummy_district_count identity_seed identity_method demo_province demo_industry2 demo_slot demo_district_slot wpi_bridge_merge wpi_index_merge wpi_mapping_status wpi_isic4 wpi_output_index wpi_spliced wpi_cagr wpi_base_year real_va_is_single_proxy real_va_double_deflated ln_output_real ln_va_real_proxy output_real_per_worker va_real_proxy_per_worker gj_per_real_output co2_per_real_output p99_econ_output out_checked_output clean_output_nominal p99_econ_va out_checked_va clean_va_nominal p99_econ_stock out_checked_stock clean_stock_nominal p99_econ_additions out_checked_additions clean_additions_nominal p99_econ_workers out_checked_workers clean_workers_count clean_output_per_worker clean_va_per_worker clean_stock_per_worker energy_all_sources_complete energy_unit_gap_2018_19 grid_factor_is_carried gj_scope1_complete9 gj_scope2_complete co2_scope2_no_grid_carry total_gj_clean_sensitivity gj_firewood_reference gj_charcoal_reference gj_lubricant_potential
assert c(k)==3837
