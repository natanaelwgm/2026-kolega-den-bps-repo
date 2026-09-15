* Tujuan: Menyediakan helper R&D 2017 untuk klasifikasi token, status kandidat, rasio/hitungan, pemeriksaan skema, dan uji CSV. // WFDOC-INJECTED
* Input: token mentah dan flag keberadaan; tabel ringkas; atau CSV beserta nama skema yang dipilih pemanggil. // WFDOC-INJECTED
* Output: kelas/status kandidat, hitungan/rasio, dan tabel DTA/CSV yang diperiksa menurut skema. // WFDOC-INJECTED
* Batas: tahap audit dan tabel hitungan menulis measurement_admitted=0; label candidate tetap berarti hasil kandidat. // WFDOC-INJECTED
* Simpan judul langkah log di luar program agar batas ukuran Stata tidak terlampaui. // WFLOG-INJECTED
* Setiap panggilan tetap mencetak ID, urutan, blok, dan durasi yang sama; perhitungan tidak berubah. // WFLOG-INJECTED
global WFRD0001 `"start "rd2017/lib/shared.do:L136:program-body" "" "program" 1 1"' // WFLOG-INJECTED
global WFRD0002 `"start "rd2017/lib/shared.do:L137:step-syntax" "rd2017/lib/shared.do:L136:program-body" "statement" 1 19"' // WFLOG-INJECTED
global WFRD0003 `"end "rd2017/lib/shared.do:L137:step-syntax" "rd2017/lib/shared.do:L136:program-body" "statement" 1 19"' // WFLOG-INJECTED
global WFRD0004 `"start "rd2017/lib/shared.do:L138:step-import" "rd2017/lib/shared.do:L136:program-body" "statement" 2 19"' // WFLOG-INJECTED
global WFRD0005 `"end "rd2017/lib/shared.do:L138:step-import" "rd2017/lib/shared.do:L136:program-body" "statement" 2 19"' // WFLOG-INJECTED
global WFRD0006 `"start "rd2017/lib/shared.do:L139:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 3 19"' // WFLOG-INJECTED
global WFRD0007 `"start "rd2017/lib/shared.do:L139:block-body" "rd2017/lib/shared.do:L139:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0008 `"start "rd2017/lib/shared.do:L140:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 1 59"' // WFLOG-INJECTED
global WFRD0009 `"end "rd2017/lib/shared.do:L140:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 1 59"' // WFLOG-INJECTED
global WFRD0010 `"start "rd2017/lib/shared.do:L141:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 2 59"' // WFLOG-INJECTED
global WFRD0011 `"end "rd2017/lib/shared.do:L141:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 2 59"' // WFLOG-INJECTED
global WFRD0012 `"start "rd2017/lib/shared.do:L142:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 3 59"' // WFLOG-INJECTED
global WFRD0013 `"end "rd2017/lib/shared.do:L142:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 3 59"' // WFLOG-INJECTED
global WFRD0014 `"start "rd2017/lib/shared.do:L143:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 4 59"' // WFLOG-INJECTED
global WFRD0015 `"end "rd2017/lib/shared.do:L143:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 4 59"' // WFLOG-INJECTED
global WFRD0016 `"start "rd2017/lib/shared.do:L144:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 5 59"' // WFLOG-INJECTED
global WFRD0017 `"end "rd2017/lib/shared.do:L144:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 5 59"' // WFLOG-INJECTED
global WFRD0018 `"start "rd2017/lib/shared.do:L145:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 6 59"' // WFLOG-INJECTED
global WFRD0019 `"end "rd2017/lib/shared.do:L145:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 6 59"' // WFLOG-INJECTED
global WFRD0020 `"start "rd2017/lib/shared.do:L146:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 7 59"' // WFLOG-INJECTED
global WFRD0021 `"end "rd2017/lib/shared.do:L146:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 7 59"' // WFLOG-INJECTED
global WFRD0022 `"start "rd2017/lib/shared.do:L147:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 8 59"' // WFLOG-INJECTED
global WFRD0023 `"end "rd2017/lib/shared.do:L147:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 8 59"' // WFLOG-INJECTED
global WFRD0024 `"start "rd2017/lib/shared.do:L148:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 9 59"' // WFLOG-INJECTED
global WFRD0025 `"end "rd2017/lib/shared.do:L148:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 9 59"' // WFLOG-INJECTED
global WFRD0026 `"start "rd2017/lib/shared.do:L149:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 10 59"' // WFLOG-INJECTED
global WFRD0027 `"end "rd2017/lib/shared.do:L149:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 10 59"' // WFLOG-INJECTED
global WFRD0028 `"start "rd2017/lib/shared.do:L150:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 11 59"' // WFLOG-INJECTED
global WFRD0029 `"end "rd2017/lib/shared.do:L150:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 11 59"' // WFLOG-INJECTED
global WFRD0030 `"start "rd2017/lib/shared.do:L151:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 12 59"' // WFLOG-INJECTED
global WFRD0031 `"end "rd2017/lib/shared.do:L151:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 12 59"' // WFLOG-INJECTED
global WFRD0032 `"start "rd2017/lib/shared.do:L152:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 13 59"' // WFLOG-INJECTED
global WFRD0033 `"end "rd2017/lib/shared.do:L152:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 13 59"' // WFLOG-INJECTED
global WFRD0034 `"start "rd2017/lib/shared.do:L153:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 14 59"' // WFLOG-INJECTED
global WFRD0035 `"end "rd2017/lib/shared.do:L153:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 14 59"' // WFLOG-INJECTED
global WFRD0036 `"start "rd2017/lib/shared.do:L154:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 15 59"' // WFLOG-INJECTED
global WFRD0037 `"end "rd2017/lib/shared.do:L154:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 15 59"' // WFLOG-INJECTED
global WFRD0038 `"start "rd2017/lib/shared.do:L155:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 16 59"' // WFLOG-INJECTED
global WFRD0039 `"end "rd2017/lib/shared.do:L155:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 16 59"' // WFLOG-INJECTED
global WFRD0040 `"start "rd2017/lib/shared.do:L156:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 17 59"' // WFLOG-INJECTED
global WFRD0041 `"end "rd2017/lib/shared.do:L156:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 17 59"' // WFLOG-INJECTED
global WFRD0042 `"start "rd2017/lib/shared.do:L157:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 18 59"' // WFLOG-INJECTED
global WFRD0043 `"end "rd2017/lib/shared.do:L157:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 18 59"' // WFLOG-INJECTED
global WFRD0044 `"start "rd2017/lib/shared.do:L158:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 19 59"' // WFLOG-INJECTED
global WFRD0045 `"end "rd2017/lib/shared.do:L158:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 19 59"' // WFLOG-INJECTED
global WFRD0046 `"start "rd2017/lib/shared.do:L159:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 20 59"' // WFLOG-INJECTED
global WFRD0047 `"end "rd2017/lib/shared.do:L159:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 20 59"' // WFLOG-INJECTED
global WFRD0048 `"start "rd2017/lib/shared.do:L160:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 21 59"' // WFLOG-INJECTED
global WFRD0049 `"end "rd2017/lib/shared.do:L160:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 21 59"' // WFLOG-INJECTED
global WFRD0050 `"start "rd2017/lib/shared.do:L161:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 22 59"' // WFLOG-INJECTED
global WFRD0051 `"end "rd2017/lib/shared.do:L161:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 22 59"' // WFLOG-INJECTED
global WFRD0052 `"start "rd2017/lib/shared.do:L162:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 23 59"' // WFLOG-INJECTED
global WFRD0053 `"end "rd2017/lib/shared.do:L162:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 23 59"' // WFLOG-INJECTED
global WFRD0054 `"start "rd2017/lib/shared.do:L163:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 24 59"' // WFLOG-INJECTED
global WFRD0055 `"end "rd2017/lib/shared.do:L163:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 24 59"' // WFLOG-INJECTED
global WFRD0056 `"start "rd2017/lib/shared.do:L164:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 25 59"' // WFLOG-INJECTED
global WFRD0057 `"end "rd2017/lib/shared.do:L164:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 25 59"' // WFLOG-INJECTED
global WFRD0058 `"start "rd2017/lib/shared.do:L165:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 26 59"' // WFLOG-INJECTED
global WFRD0059 `"end "rd2017/lib/shared.do:L165:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 26 59"' // WFLOG-INJECTED
global WFRD0060 `"start "rd2017/lib/shared.do:L166:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 27 59"' // WFLOG-INJECTED
global WFRD0061 `"end "rd2017/lib/shared.do:L166:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 27 59"' // WFLOG-INJECTED
global WFRD0062 `"start "rd2017/lib/shared.do:L167:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 28 59"' // WFLOG-INJECTED
global WFRD0063 `"end "rd2017/lib/shared.do:L167:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 28 59"' // WFLOG-INJECTED
global WFRD0064 `"start "rd2017/lib/shared.do:L168:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 29 59"' // WFLOG-INJECTED
global WFRD0065 `"end "rd2017/lib/shared.do:L168:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 29 59"' // WFLOG-INJECTED
global WFRD0066 `"start "rd2017/lib/shared.do:L169:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 30 59"' // WFLOG-INJECTED
global WFRD0067 `"end "rd2017/lib/shared.do:L169:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 30 59"' // WFLOG-INJECTED
global WFRD0068 `"start "rd2017/lib/shared.do:L170:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 31 59"' // WFLOG-INJECTED
global WFRD0069 `"end "rd2017/lib/shared.do:L170:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 31 59"' // WFLOG-INJECTED
global WFRD0070 `"start "rd2017/lib/shared.do:L171:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 32 59"' // WFLOG-INJECTED
global WFRD0071 `"end "rd2017/lib/shared.do:L171:step-recast" "rd2017/lib/shared.do:L139:block-body" "statement" 32 59"' // WFLOG-INJECTED
global WFRD0072 `"start "rd2017/lib/shared.do:L172:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 33 59"' // WFLOG-INJECTED
global WFRD0073 `"end "rd2017/lib/shared.do:L172:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 33 59"' // WFLOG-INJECTED
global WFRD0074 `"start "rd2017/lib/shared.do:L173:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 34 59"' // WFLOG-INJECTED
global WFRD0075 `"end "rd2017/lib/shared.do:L173:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 34 59"' // WFLOG-INJECTED
global WFRD0076 `"start "rd2017/lib/shared.do:L174:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 35 59"' // WFLOG-INJECTED
global WFRD0077 `"end "rd2017/lib/shared.do:L174:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 35 59"' // WFLOG-INJECTED
global WFRD0078 `"start "rd2017/lib/shared.do:L175:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 36 59"' // WFLOG-INJECTED
global WFRD0079 `"end "rd2017/lib/shared.do:L175:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 36 59"' // WFLOG-INJECTED
global WFRD0080 `"start "rd2017/lib/shared.do:L176:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 37 59"' // WFLOG-INJECTED
global WFRD0081 `"end "rd2017/lib/shared.do:L176:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 37 59"' // WFLOG-INJECTED
global WFRD0082 `"start "rd2017/lib/shared.do:L177:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 38 59"' // WFLOG-INJECTED
global WFRD0083 `"end "rd2017/lib/shared.do:L177:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 38 59"' // WFLOG-INJECTED
global WFRD0084 `"start "rd2017/lib/shared.do:L178:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 39 59"' // WFLOG-INJECTED
global WFRD0085 `"end "rd2017/lib/shared.do:L178:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 39 59"' // WFLOG-INJECTED
global WFRD0086 `"start "rd2017/lib/shared.do:L179:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 40 59"' // WFLOG-INJECTED
global WFRD0087 `"end "rd2017/lib/shared.do:L179:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 40 59"' // WFLOG-INJECTED
global WFRD0088 `"start "rd2017/lib/shared.do:L180:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 41 59"' // WFLOG-INJECTED
global WFRD0089 `"end "rd2017/lib/shared.do:L180:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 41 59"' // WFLOG-INJECTED
global WFRD0090 `"start "rd2017/lib/shared.do:L181:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 42 59"' // WFLOG-INJECTED
global WFRD0091 `"end "rd2017/lib/shared.do:L181:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 42 59"' // WFLOG-INJECTED
global WFRD0092 `"start "rd2017/lib/shared.do:L182:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 43 59"' // WFLOG-INJECTED
global WFRD0093 `"end "rd2017/lib/shared.do:L182:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 43 59"' // WFLOG-INJECTED
global WFRD0094 `"start "rd2017/lib/shared.do:L183:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 44 59"' // WFLOG-INJECTED
global WFRD0095 `"end "rd2017/lib/shared.do:L183:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 44 59"' // WFLOG-INJECTED
global WFRD0096 `"start "rd2017/lib/shared.do:L184:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 45 59"' // WFLOG-INJECTED
global WFRD0097 `"end "rd2017/lib/shared.do:L184:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 45 59"' // WFLOG-INJECTED
global WFRD0098 `"start "rd2017/lib/shared.do:L185:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 46 59"' // WFLOG-INJECTED
global WFRD0099 `"end "rd2017/lib/shared.do:L185:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 46 59"' // WFLOG-INJECTED
global WFRD0100 `"start "rd2017/lib/shared.do:L186:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 47 59"' // WFLOG-INJECTED
global WFRD0101 `"end "rd2017/lib/shared.do:L186:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 47 59"' // WFLOG-INJECTED
global WFRD0102 `"start "rd2017/lib/shared.do:L187:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 48 59"' // WFLOG-INJECTED
global WFRD0103 `"end "rd2017/lib/shared.do:L187:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 48 59"' // WFLOG-INJECTED
global WFRD0104 `"start "rd2017/lib/shared.do:L188:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 49 59"' // WFLOG-INJECTED
global WFRD0105 `"end "rd2017/lib/shared.do:L188:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 49 59"' // WFLOG-INJECTED
global WFRD0106 `"start "rd2017/lib/shared.do:L189:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 50 59"' // WFLOG-INJECTED
global WFRD0107 `"end "rd2017/lib/shared.do:L189:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 50 59"' // WFLOG-INJECTED
global WFRD0108 `"start "rd2017/lib/shared.do:L190:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 51 59"' // WFLOG-INJECTED
global WFRD0109 `"end "rd2017/lib/shared.do:L190:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 51 59"' // WFLOG-INJECTED
global WFRD0110 `"start "rd2017/lib/shared.do:L191:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 52 59"' // WFLOG-INJECTED
global WFRD0111 `"end "rd2017/lib/shared.do:L191:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 52 59"' // WFLOG-INJECTED
global WFRD0112 `"start "rd2017/lib/shared.do:L192:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 53 59"' // WFLOG-INJECTED
global WFRD0113 `"end "rd2017/lib/shared.do:L192:step-rename" "rd2017/lib/shared.do:L139:block-body" "statement" 53 59"' // WFLOG-INJECTED
global WFRD0114 `"start "rd2017/lib/shared.do:L193:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 54 59"' // WFLOG-INJECTED
global WFRD0115 `"end "rd2017/lib/shared.do:L193:step-generate" "rd2017/lib/shared.do:L139:block-body" "statement" 54 59"' // WFLOG-INJECTED
global WFRD0116 `"start "rd2017/lib/shared.do:L194:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 55 59"' // WFLOG-INJECTED
global WFRD0117 `"end "rd2017/lib/shared.do:L194:step-assert" "rd2017/lib/shared.do:L139:block-body" "statement" 55 59"' // WFLOG-INJECTED
global WFRD0118 `"start "rd2017/lib/shared.do:L195:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 56 59"' // WFLOG-INJECTED
global WFRD0119 `"end "rd2017/lib/shared.do:L195:step-drop" "rd2017/lib/shared.do:L139:block-body" "statement" 56 59"' // WFLOG-INJECTED
global WFRD0120 `"start "rd2017/lib/shared.do:L196:step-order" "rd2017/lib/shared.do:L139:block-body" "statement" 57 59"' // WFLOG-INJECTED
global WFRD0121 `"end "rd2017/lib/shared.do:L196:step-order" "rd2017/lib/shared.do:L139:block-body" "statement" 57 59"' // WFLOG-INJECTED
global WFRD0122 `"start "rd2017/lib/shared.do:L197:step-rd17_schema" "rd2017/lib/shared.do:L139:block-body" "statement" 58 59"' // WFLOG-INJECTED
global WFRD0123 `"end "rd2017/lib/shared.do:L197:step-rd17_schema" "rd2017/lib/shared.do:L139:block-body" "statement" 58 59"' // WFLOG-INJECTED
global WFRD0124 `"start "rd2017/lib/shared.do:L198:step-exit" "rd2017/lib/shared.do:L139:block-body" "statement" 59 59"' // WFLOG-INJECTED
global WFRD0125 `"end "rd2017/lib/shared.do:L198:step-exit" "rd2017/lib/shared.do:L139:block-body" "statement" 59 59"' // WFLOG-INJECTED
global WFRD0126 `"end "rd2017/lib/shared.do:L139:block-body" "rd2017/lib/shared.do:L139:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0127 `"end "rd2017/lib/shared.do:L139:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 3 19"' // WFLOG-INJECTED
global WFRD0128 `"start "rd2017/lib/shared.do:L200:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 4 19"' // WFLOG-INJECTED
global WFRD0129 `"start "rd2017/lib/shared.do:L200:block-body" "rd2017/lib/shared.do:L200:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0130 `"start "rd2017/lib/shared.do:L201:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 1 23"' // WFLOG-INJECTED
global WFRD0131 `"end "rd2017/lib/shared.do:L201:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 1 23"' // WFLOG-INJECTED
global WFRD0132 `"start "rd2017/lib/shared.do:L202:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 2 23"' // WFLOG-INJECTED
global WFRD0133 `"end "rd2017/lib/shared.do:L202:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 2 23"' // WFLOG-INJECTED
global WFRD0134 `"start "rd2017/lib/shared.do:L203:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 3 23"' // WFLOG-INJECTED
global WFRD0135 `"end "rd2017/lib/shared.do:L203:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 3 23"' // WFLOG-INJECTED
global WFRD0136 `"start "rd2017/lib/shared.do:L204:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 4 23"' // WFLOG-INJECTED
global WFRD0137 `"end "rd2017/lib/shared.do:L204:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 4 23"' // WFLOG-INJECTED
global WFRD0138 `"start "rd2017/lib/shared.do:L205:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 5 23"' // WFLOG-INJECTED
global WFRD0139 `"end "rd2017/lib/shared.do:L205:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 5 23"' // WFLOG-INJECTED
global WFRD0140 `"start "rd2017/lib/shared.do:L206:step-recast" "rd2017/lib/shared.do:L200:block-body" "statement" 6 23"' // WFLOG-INJECTED
global WFRD0141 `"end "rd2017/lib/shared.do:L206:step-recast" "rd2017/lib/shared.do:L200:block-body" "statement" 6 23"' // WFLOG-INJECTED
global WFRD0142 `"start "rd2017/lib/shared.do:L207:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 7 23"' // WFLOG-INJECTED
global WFRD0143 `"end "rd2017/lib/shared.do:L207:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 7 23"' // WFLOG-INJECTED
global WFRD0144 `"start "rd2017/lib/shared.do:L208:step-recast" "rd2017/lib/shared.do:L200:block-body" "statement" 8 23"' // WFLOG-INJECTED
global WFRD0145 `"end "rd2017/lib/shared.do:L208:step-recast" "rd2017/lib/shared.do:L200:block-body" "statement" 8 23"' // WFLOG-INJECTED
global WFRD0146 `"start "rd2017/lib/shared.do:L209:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 9 23"' // WFLOG-INJECTED
global WFRD0147 `"end "rd2017/lib/shared.do:L209:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 9 23"' // WFLOG-INJECTED
global WFRD0148 `"start "rd2017/lib/shared.do:L210:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 10 23"' // WFLOG-INJECTED
global WFRD0149 `"end "rd2017/lib/shared.do:L210:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 10 23"' // WFLOG-INJECTED
global WFRD0150 `"start "rd2017/lib/shared.do:L211:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 11 23"' // WFLOG-INJECTED
global WFRD0151 `"end "rd2017/lib/shared.do:L211:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 11 23"' // WFLOG-INJECTED
global WFRD0152 `"start "rd2017/lib/shared.do:L212:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 12 23"' // WFLOG-INJECTED
global WFRD0153 `"end "rd2017/lib/shared.do:L212:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 12 23"' // WFLOG-INJECTED
global WFRD0154 `"start "rd2017/lib/shared.do:L213:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 13 23"' // WFLOG-INJECTED
global WFRD0155 `"end "rd2017/lib/shared.do:L213:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 13 23"' // WFLOG-INJECTED
global WFRD0156 `"start "rd2017/lib/shared.do:L214:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 14 23"' // WFLOG-INJECTED
global WFRD0157 `"end "rd2017/lib/shared.do:L214:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 14 23"' // WFLOG-INJECTED
global WFRD0158 `"start "rd2017/lib/shared.do:L215:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 15 23"' // WFLOG-INJECTED
global WFRD0159 `"end "rd2017/lib/shared.do:L215:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 15 23"' // WFLOG-INJECTED
global WFRD0160 `"start "rd2017/lib/shared.do:L216:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 16 23"' // WFLOG-INJECTED
global WFRD0161 `"end "rd2017/lib/shared.do:L216:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 16 23"' // WFLOG-INJECTED
global WFRD0162 `"start "rd2017/lib/shared.do:L217:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 17 23"' // WFLOG-INJECTED
global WFRD0163 `"end "rd2017/lib/shared.do:L217:step-rename" "rd2017/lib/shared.do:L200:block-body" "statement" 17 23"' // WFLOG-INJECTED
global WFRD0164 `"start "rd2017/lib/shared.do:L218:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 18 23"' // WFLOG-INJECTED
global WFRD0165 `"end "rd2017/lib/shared.do:L218:step-generate" "rd2017/lib/shared.do:L200:block-body" "statement" 18 23"' // WFLOG-INJECTED
global WFRD0166 `"start "rd2017/lib/shared.do:L219:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 19 23"' // WFLOG-INJECTED
global WFRD0167 `"end "rd2017/lib/shared.do:L219:step-assert" "rd2017/lib/shared.do:L200:block-body" "statement" 19 23"' // WFLOG-INJECTED
global WFRD0168 `"start "rd2017/lib/shared.do:L220:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 20 23"' // WFLOG-INJECTED
global WFRD0169 `"end "rd2017/lib/shared.do:L220:step-drop" "rd2017/lib/shared.do:L200:block-body" "statement" 20 23"' // WFLOG-INJECTED
global WFRD0170 `"start "rd2017/lib/shared.do:L221:step-order" "rd2017/lib/shared.do:L200:block-body" "statement" 21 23"' // WFLOG-INJECTED
global WFRD0171 `"end "rd2017/lib/shared.do:L221:step-order" "rd2017/lib/shared.do:L200:block-body" "statement" 21 23"' // WFLOG-INJECTED
global WFRD0172 `"start "rd2017/lib/shared.do:L222:step-rd17_schema" "rd2017/lib/shared.do:L200:block-body" "statement" 22 23"' // WFLOG-INJECTED
global WFRD0173 `"end "rd2017/lib/shared.do:L222:step-rd17_schema" "rd2017/lib/shared.do:L200:block-body" "statement" 22 23"' // WFLOG-INJECTED
global WFRD0174 `"start "rd2017/lib/shared.do:L223:step-exit" "rd2017/lib/shared.do:L200:block-body" "statement" 23 23"' // WFLOG-INJECTED
global WFRD0175 `"end "rd2017/lib/shared.do:L223:step-exit" "rd2017/lib/shared.do:L200:block-body" "statement" 23 23"' // WFLOG-INJECTED
global WFRD0176 `"end "rd2017/lib/shared.do:L200:block-body" "rd2017/lib/shared.do:L200:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0177 `"end "rd2017/lib/shared.do:L200:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 4 19"' // WFLOG-INJECTED
global WFRD0178 `"start "rd2017/lib/shared.do:L225:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 5 19"' // WFLOG-INJECTED
global WFRD0179 `"start "rd2017/lib/shared.do:L225:block-body" "rd2017/lib/shared.do:L225:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0180 `"start "rd2017/lib/shared.do:L226:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD0181 `"end "rd2017/lib/shared.do:L226:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD0182 `"start "rd2017/lib/shared.do:L227:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD0183 `"end "rd2017/lib/shared.do:L227:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD0184 `"start "rd2017/lib/shared.do:L228:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD0185 `"end "rd2017/lib/shared.do:L228:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD0186 `"start "rd2017/lib/shared.do:L229:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD0187 `"end "rd2017/lib/shared.do:L229:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD0188 `"start "rd2017/lib/shared.do:L230:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD0189 `"end "rd2017/lib/shared.do:L230:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD0190 `"start "rd2017/lib/shared.do:L231:step-recast" "rd2017/lib/shared.do:L225:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD0191 `"end "rd2017/lib/shared.do:L231:step-recast" "rd2017/lib/shared.do:L225:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD0192 `"start "rd2017/lib/shared.do:L232:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD0193 `"end "rd2017/lib/shared.do:L232:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD0194 `"start "rd2017/lib/shared.do:L233:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD0195 `"end "rd2017/lib/shared.do:L233:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD0196 `"start "rd2017/lib/shared.do:L234:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD0197 `"end "rd2017/lib/shared.do:L234:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD0198 `"start "rd2017/lib/shared.do:L235:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD0199 `"end "rd2017/lib/shared.do:L235:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD0200 `"start "rd2017/lib/shared.do:L236:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD0201 `"end "rd2017/lib/shared.do:L236:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD0202 `"start "rd2017/lib/shared.do:L237:step-recast" "rd2017/lib/shared.do:L225:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD0203 `"end "rd2017/lib/shared.do:L237:step-recast" "rd2017/lib/shared.do:L225:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD0204 `"start "rd2017/lib/shared.do:L238:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD0205 `"end "rd2017/lib/shared.do:L238:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD0206 `"start "rd2017/lib/shared.do:L239:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD0207 `"end "rd2017/lib/shared.do:L239:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD0208 `"start "rd2017/lib/shared.do:L240:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD0209 `"end "rd2017/lib/shared.do:L240:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD0210 `"start "rd2017/lib/shared.do:L241:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD0211 `"end "rd2017/lib/shared.do:L241:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD0212 `"start "rd2017/lib/shared.do:L242:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD0213 `"end "rd2017/lib/shared.do:L242:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD0214 `"start "rd2017/lib/shared.do:L243:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD0215 `"end "rd2017/lib/shared.do:L243:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD0216 `"start "rd2017/lib/shared.do:L244:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD0217 `"end "rd2017/lib/shared.do:L244:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD0218 `"start "rd2017/lib/shared.do:L245:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD0219 `"end "rd2017/lib/shared.do:L245:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD0220 `"start "rd2017/lib/shared.do:L246:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD0221 `"end "rd2017/lib/shared.do:L246:step-rename" "rd2017/lib/shared.do:L225:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD0222 `"start "rd2017/lib/shared.do:L247:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD0223 `"end "rd2017/lib/shared.do:L247:step-generate" "rd2017/lib/shared.do:L225:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD0224 `"start "rd2017/lib/shared.do:L248:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD0225 `"end "rd2017/lib/shared.do:L248:step-assert" "rd2017/lib/shared.do:L225:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD0226 `"start "rd2017/lib/shared.do:L249:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD0227 `"end "rd2017/lib/shared.do:L249:step-drop" "rd2017/lib/shared.do:L225:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD0228 `"start "rd2017/lib/shared.do:L250:step-order" "rd2017/lib/shared.do:L225:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD0229 `"end "rd2017/lib/shared.do:L250:step-order" "rd2017/lib/shared.do:L225:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD0230 `"start "rd2017/lib/shared.do:L251:step-rd17_schema" "rd2017/lib/shared.do:L225:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD0231 `"end "rd2017/lib/shared.do:L251:step-rd17_schema" "rd2017/lib/shared.do:L225:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD0232 `"start "rd2017/lib/shared.do:L252:step-exit" "rd2017/lib/shared.do:L225:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD0233 `"end "rd2017/lib/shared.do:L252:step-exit" "rd2017/lib/shared.do:L225:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD0234 `"end "rd2017/lib/shared.do:L225:block-body" "rd2017/lib/shared.do:L225:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0235 `"end "rd2017/lib/shared.do:L225:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 5 19"' // WFLOG-INJECTED
global WFRD0236 `"start "rd2017/lib/shared.do:L254:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 6 19"' // WFLOG-INJECTED
global WFRD0237 `"start "rd2017/lib/shared.do:L254:block-body" "rd2017/lib/shared.do:L254:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0238 `"start "rd2017/lib/shared.do:L255:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0239 `"end "rd2017/lib/shared.do:L255:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0240 `"start "rd2017/lib/shared.do:L256:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0241 `"end "rd2017/lib/shared.do:L256:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0242 `"start "rd2017/lib/shared.do:L257:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0243 `"end "rd2017/lib/shared.do:L257:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0244 `"start "rd2017/lib/shared.do:L258:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0245 `"end "rd2017/lib/shared.do:L258:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0246 `"start "rd2017/lib/shared.do:L259:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0247 `"end "rd2017/lib/shared.do:L259:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0248 `"start "rd2017/lib/shared.do:L260:step-recast" "rd2017/lib/shared.do:L254:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0249 `"end "rd2017/lib/shared.do:L260:step-recast" "rd2017/lib/shared.do:L254:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0250 `"start "rd2017/lib/shared.do:L261:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0251 `"end "rd2017/lib/shared.do:L261:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0252 `"start "rd2017/lib/shared.do:L262:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0253 `"end "rd2017/lib/shared.do:L262:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0254 `"start "rd2017/lib/shared.do:L263:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0255 `"end "rd2017/lib/shared.do:L263:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0256 `"start "rd2017/lib/shared.do:L264:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0257 `"end "rd2017/lib/shared.do:L264:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0258 `"start "rd2017/lib/shared.do:L265:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0259 `"end "rd2017/lib/shared.do:L265:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0260 `"start "rd2017/lib/shared.do:L266:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0261 `"end "rd2017/lib/shared.do:L266:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0262 `"start "rd2017/lib/shared.do:L267:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0263 `"end "rd2017/lib/shared.do:L267:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0264 `"start "rd2017/lib/shared.do:L268:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0265 `"end "rd2017/lib/shared.do:L268:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0266 `"start "rd2017/lib/shared.do:L269:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0267 `"end "rd2017/lib/shared.do:L269:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0268 `"start "rd2017/lib/shared.do:L270:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0269 `"end "rd2017/lib/shared.do:L270:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0270 `"start "rd2017/lib/shared.do:L271:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0271 `"end "rd2017/lib/shared.do:L271:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0272 `"start "rd2017/lib/shared.do:L272:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0273 `"end "rd2017/lib/shared.do:L272:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0274 `"start "rd2017/lib/shared.do:L273:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0275 `"end "rd2017/lib/shared.do:L273:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0276 `"start "rd2017/lib/shared.do:L274:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0277 `"end "rd2017/lib/shared.do:L274:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0278 `"start "rd2017/lib/shared.do:L275:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0279 `"end "rd2017/lib/shared.do:L275:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0280 `"start "rd2017/lib/shared.do:L276:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0281 `"end "rd2017/lib/shared.do:L276:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0282 `"start "rd2017/lib/shared.do:L277:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0283 `"end "rd2017/lib/shared.do:L277:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0284 `"start "rd2017/lib/shared.do:L278:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0285 `"end "rd2017/lib/shared.do:L278:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0286 `"start "rd2017/lib/shared.do:L279:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0287 `"end "rd2017/lib/shared.do:L279:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0288 `"start "rd2017/lib/shared.do:L280:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0289 `"end "rd2017/lib/shared.do:L280:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0290 `"start "rd2017/lib/shared.do:L281:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0291 `"end "rd2017/lib/shared.do:L281:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0292 `"start "rd2017/lib/shared.do:L282:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0293 `"end "rd2017/lib/shared.do:L282:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0294 `"start "rd2017/lib/shared.do:L283:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0295 `"end "rd2017/lib/shared.do:L283:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0296 `"start "rd2017/lib/shared.do:L284:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0297 `"end "rd2017/lib/shared.do:L284:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0298 `"start "rd2017/lib/shared.do:L285:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0299 `"end "rd2017/lib/shared.do:L285:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0300 `"start "rd2017/lib/shared.do:L286:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0301 `"end "rd2017/lib/shared.do:L286:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0302 `"start "rd2017/lib/shared.do:L287:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0303 `"end "rd2017/lib/shared.do:L287:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0304 `"start "rd2017/lib/shared.do:L288:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0305 `"end "rd2017/lib/shared.do:L288:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0306 `"start "rd2017/lib/shared.do:L289:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0307 `"end "rd2017/lib/shared.do:L289:step-rename" "rd2017/lib/shared.do:L254:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0308 `"start "rd2017/lib/shared.do:L290:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0309 `"end "rd2017/lib/shared.do:L290:step-generate" "rd2017/lib/shared.do:L254:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0310 `"start "rd2017/lib/shared.do:L291:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0311 `"end "rd2017/lib/shared.do:L291:step-assert" "rd2017/lib/shared.do:L254:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0312 `"start "rd2017/lib/shared.do:L292:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0313 `"end "rd2017/lib/shared.do:L292:step-drop" "rd2017/lib/shared.do:L254:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0314 `"start "rd2017/lib/shared.do:L293:step-order" "rd2017/lib/shared.do:L254:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0315 `"end "rd2017/lib/shared.do:L293:step-order" "rd2017/lib/shared.do:L254:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0316 `"start "rd2017/lib/shared.do:L294:step-rd17_schema" "rd2017/lib/shared.do:L254:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0317 `"end "rd2017/lib/shared.do:L294:step-rd17_schema" "rd2017/lib/shared.do:L254:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0318 `"start "rd2017/lib/shared.do:L295:step-exit" "rd2017/lib/shared.do:L254:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0319 `"end "rd2017/lib/shared.do:L295:step-exit" "rd2017/lib/shared.do:L254:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0320 `"end "rd2017/lib/shared.do:L254:block-body" "rd2017/lib/shared.do:L254:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0321 `"end "rd2017/lib/shared.do:L254:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 6 19"' // WFLOG-INJECTED
global WFRD0322 `"start "rd2017/lib/shared.do:L297:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 7 19"' // WFLOG-INJECTED
global WFRD0323 `"start "rd2017/lib/shared.do:L297:block-body" "rd2017/lib/shared.do:L297:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0324 `"start "rd2017/lib/shared.do:L298:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 1 39"' // WFLOG-INJECTED
global WFRD0325 `"end "rd2017/lib/shared.do:L298:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 1 39"' // WFLOG-INJECTED
global WFRD0326 `"start "rd2017/lib/shared.do:L299:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 2 39"' // WFLOG-INJECTED
global WFRD0327 `"end "rd2017/lib/shared.do:L299:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 2 39"' // WFLOG-INJECTED
global WFRD0328 `"start "rd2017/lib/shared.do:L300:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 3 39"' // WFLOG-INJECTED
global WFRD0329 `"end "rd2017/lib/shared.do:L300:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 3 39"' // WFLOG-INJECTED
global WFRD0330 `"start "rd2017/lib/shared.do:L301:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 4 39"' // WFLOG-INJECTED
global WFRD0331 `"end "rd2017/lib/shared.do:L301:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 4 39"' // WFLOG-INJECTED
global WFRD0332 `"start "rd2017/lib/shared.do:L302:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 5 39"' // WFLOG-INJECTED
global WFRD0333 `"end "rd2017/lib/shared.do:L302:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 5 39"' // WFLOG-INJECTED
global WFRD0334 `"start "rd2017/lib/shared.do:L303:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 6 39"' // WFLOG-INJECTED
global WFRD0335 `"end "rd2017/lib/shared.do:L303:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 6 39"' // WFLOG-INJECTED
global WFRD0336 `"start "rd2017/lib/shared.do:L304:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 7 39"' // WFLOG-INJECTED
global WFRD0337 `"end "rd2017/lib/shared.do:L304:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 7 39"' // WFLOG-INJECTED
global WFRD0338 `"start "rd2017/lib/shared.do:L305:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 8 39"' // WFLOG-INJECTED
global WFRD0339 `"end "rd2017/lib/shared.do:L305:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 8 39"' // WFLOG-INJECTED
global WFRD0340 `"start "rd2017/lib/shared.do:L306:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 9 39"' // WFLOG-INJECTED
global WFRD0341 `"end "rd2017/lib/shared.do:L306:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 9 39"' // WFLOG-INJECTED
global WFRD0342 `"start "rd2017/lib/shared.do:L307:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 10 39"' // WFLOG-INJECTED
global WFRD0343 `"end "rd2017/lib/shared.do:L307:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 10 39"' // WFLOG-INJECTED
global WFRD0344 `"start "rd2017/lib/shared.do:L308:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 11 39"' // WFLOG-INJECTED
global WFRD0345 `"end "rd2017/lib/shared.do:L308:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 11 39"' // WFLOG-INJECTED
global WFRD0346 `"start "rd2017/lib/shared.do:L309:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 12 39"' // WFLOG-INJECTED
global WFRD0347 `"end "rd2017/lib/shared.do:L309:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 12 39"' // WFLOG-INJECTED
global WFRD0348 `"start "rd2017/lib/shared.do:L310:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 13 39"' // WFLOG-INJECTED
global WFRD0349 `"end "rd2017/lib/shared.do:L310:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 13 39"' // WFLOG-INJECTED
global WFRD0350 `"start "rd2017/lib/shared.do:L311:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 14 39"' // WFLOG-INJECTED
global WFRD0351 `"end "rd2017/lib/shared.do:L311:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 14 39"' // WFLOG-INJECTED
global WFRD0352 `"start "rd2017/lib/shared.do:L312:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 15 39"' // WFLOG-INJECTED
global WFRD0353 `"end "rd2017/lib/shared.do:L312:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 15 39"' // WFLOG-INJECTED
global WFRD0354 `"start "rd2017/lib/shared.do:L313:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 16 39"' // WFLOG-INJECTED
global WFRD0355 `"end "rd2017/lib/shared.do:L313:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 16 39"' // WFLOG-INJECTED
global WFRD0356 `"start "rd2017/lib/shared.do:L314:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 17 39"' // WFLOG-INJECTED
global WFRD0357 `"end "rd2017/lib/shared.do:L314:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 17 39"' // WFLOG-INJECTED
global WFRD0358 `"start "rd2017/lib/shared.do:L315:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 18 39"' // WFLOG-INJECTED
global WFRD0359 `"end "rd2017/lib/shared.do:L315:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 18 39"' // WFLOG-INJECTED
global WFRD0360 `"start "rd2017/lib/shared.do:L316:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 19 39"' // WFLOG-INJECTED
global WFRD0361 `"end "rd2017/lib/shared.do:L316:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 19 39"' // WFLOG-INJECTED
global WFRD0362 `"start "rd2017/lib/shared.do:L317:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 20 39"' // WFLOG-INJECTED
global WFRD0363 `"end "rd2017/lib/shared.do:L317:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 20 39"' // WFLOG-INJECTED
global WFRD0364 `"start "rd2017/lib/shared.do:L318:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 21 39"' // WFLOG-INJECTED
global WFRD0365 `"end "rd2017/lib/shared.do:L318:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 21 39"' // WFLOG-INJECTED
global WFRD0366 `"start "rd2017/lib/shared.do:L319:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 22 39"' // WFLOG-INJECTED
global WFRD0367 `"end "rd2017/lib/shared.do:L319:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 22 39"' // WFLOG-INJECTED
global WFRD0368 `"start "rd2017/lib/shared.do:L320:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 23 39"' // WFLOG-INJECTED
global WFRD0369 `"end "rd2017/lib/shared.do:L320:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 23 39"' // WFLOG-INJECTED
global WFRD0370 `"start "rd2017/lib/shared.do:L321:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 24 39"' // WFLOG-INJECTED
global WFRD0371 `"end "rd2017/lib/shared.do:L321:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 24 39"' // WFLOG-INJECTED
global WFRD0372 `"start "rd2017/lib/shared.do:L322:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 25 39"' // WFLOG-INJECTED
global WFRD0373 `"end "rd2017/lib/shared.do:L322:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 25 39"' // WFLOG-INJECTED
global WFRD0374 `"start "rd2017/lib/shared.do:L323:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 26 39"' // WFLOG-INJECTED
global WFRD0375 `"end "rd2017/lib/shared.do:L323:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 26 39"' // WFLOG-INJECTED
global WFRD0376 `"start "rd2017/lib/shared.do:L324:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 27 39"' // WFLOG-INJECTED
global WFRD0377 `"end "rd2017/lib/shared.do:L324:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 27 39"' // WFLOG-INJECTED
global WFRD0378 `"start "rd2017/lib/shared.do:L325:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 28 39"' // WFLOG-INJECTED
global WFRD0379 `"end "rd2017/lib/shared.do:L325:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 28 39"' // WFLOG-INJECTED
global WFRD0380 `"start "rd2017/lib/shared.do:L326:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 29 39"' // WFLOG-INJECTED
global WFRD0381 `"end "rd2017/lib/shared.do:L326:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 29 39"' // WFLOG-INJECTED
global WFRD0382 `"start "rd2017/lib/shared.do:L327:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 30 39"' // WFLOG-INJECTED
global WFRD0383 `"end "rd2017/lib/shared.do:L327:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 30 39"' // WFLOG-INJECTED
global WFRD0384 `"start "rd2017/lib/shared.do:L328:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 31 39"' // WFLOG-INJECTED
global WFRD0385 `"end "rd2017/lib/shared.do:L328:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 31 39"' // WFLOG-INJECTED
global WFRD0386 `"start "rd2017/lib/shared.do:L329:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 32 39"' // WFLOG-INJECTED
global WFRD0387 `"end "rd2017/lib/shared.do:L329:step-recast" "rd2017/lib/shared.do:L297:block-body" "statement" 32 39"' // WFLOG-INJECTED
global WFRD0388 `"start "rd2017/lib/shared.do:L330:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 33 39"' // WFLOG-INJECTED
global WFRD0389 `"end "rd2017/lib/shared.do:L330:step-rename" "rd2017/lib/shared.do:L297:block-body" "statement" 33 39"' // WFLOG-INJECTED
global WFRD0390 `"start "rd2017/lib/shared.do:L331:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 34 39"' // WFLOG-INJECTED
global WFRD0391 `"end "rd2017/lib/shared.do:L331:step-generate" "rd2017/lib/shared.do:L297:block-body" "statement" 34 39"' // WFLOG-INJECTED
global WFRD0392 `"start "rd2017/lib/shared.do:L332:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 35 39"' // WFLOG-INJECTED
global WFRD0393 `"end "rd2017/lib/shared.do:L332:step-assert" "rd2017/lib/shared.do:L297:block-body" "statement" 35 39"' // WFLOG-INJECTED
global WFRD0394 `"start "rd2017/lib/shared.do:L333:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 36 39"' // WFLOG-INJECTED
global WFRD0395 `"end "rd2017/lib/shared.do:L333:step-drop" "rd2017/lib/shared.do:L297:block-body" "statement" 36 39"' // WFLOG-INJECTED
global WFRD0396 `"start "rd2017/lib/shared.do:L334:step-order" "rd2017/lib/shared.do:L297:block-body" "statement" 37 39"' // WFLOG-INJECTED
global WFRD0397 `"end "rd2017/lib/shared.do:L334:step-order" "rd2017/lib/shared.do:L297:block-body" "statement" 37 39"' // WFLOG-INJECTED
global WFRD0398 `"start "rd2017/lib/shared.do:L335:step-rd17_schema" "rd2017/lib/shared.do:L297:block-body" "statement" 38 39"' // WFLOG-INJECTED
global WFRD0399 `"end "rd2017/lib/shared.do:L335:step-rd17_schema" "rd2017/lib/shared.do:L297:block-body" "statement" 38 39"' // WFLOG-INJECTED
global WFRD0400 `"start "rd2017/lib/shared.do:L336:step-exit" "rd2017/lib/shared.do:L297:block-body" "statement" 39 39"' // WFLOG-INJECTED
global WFRD0401 `"end "rd2017/lib/shared.do:L336:step-exit" "rd2017/lib/shared.do:L297:block-body" "statement" 39 39"' // WFLOG-INJECTED
global WFRD0402 `"end "rd2017/lib/shared.do:L297:block-body" "rd2017/lib/shared.do:L297:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0403 `"end "rd2017/lib/shared.do:L297:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 7 19"' // WFLOG-INJECTED
global WFRD0404 `"start "rd2017/lib/shared.do:L338:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 8 19"' // WFLOG-INJECTED
global WFRD0405 `"start "rd2017/lib/shared.do:L338:block-body" "rd2017/lib/shared.do:L338:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0406 `"start "rd2017/lib/shared.do:L339:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 1 47"' // WFLOG-INJECTED
global WFRD0407 `"end "rd2017/lib/shared.do:L339:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 1 47"' // WFLOG-INJECTED
global WFRD0408 `"start "rd2017/lib/shared.do:L340:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 2 47"' // WFLOG-INJECTED
global WFRD0409 `"end "rd2017/lib/shared.do:L340:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 2 47"' // WFLOG-INJECTED
global WFRD0410 `"start "rd2017/lib/shared.do:L341:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 3 47"' // WFLOG-INJECTED
global WFRD0411 `"end "rd2017/lib/shared.do:L341:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 3 47"' // WFLOG-INJECTED
global WFRD0412 `"start "rd2017/lib/shared.do:L342:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 4 47"' // WFLOG-INJECTED
global WFRD0413 `"end "rd2017/lib/shared.do:L342:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 4 47"' // WFLOG-INJECTED
global WFRD0414 `"start "rd2017/lib/shared.do:L343:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 5 47"' // WFLOG-INJECTED
global WFRD0415 `"end "rd2017/lib/shared.do:L343:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 5 47"' // WFLOG-INJECTED
global WFRD0416 `"start "rd2017/lib/shared.do:L344:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 6 47"' // WFLOG-INJECTED
global WFRD0417 `"end "rd2017/lib/shared.do:L344:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 6 47"' // WFLOG-INJECTED
global WFRD0418 `"start "rd2017/lib/shared.do:L345:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 7 47"' // WFLOG-INJECTED
global WFRD0419 `"end "rd2017/lib/shared.do:L345:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 7 47"' // WFLOG-INJECTED
global WFRD0420 `"start "rd2017/lib/shared.do:L346:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 8 47"' // WFLOG-INJECTED
global WFRD0421 `"end "rd2017/lib/shared.do:L346:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 8 47"' // WFLOG-INJECTED
global WFRD0422 `"start "rd2017/lib/shared.do:L347:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 9 47"' // WFLOG-INJECTED
global WFRD0423 `"end "rd2017/lib/shared.do:L347:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 9 47"' // WFLOG-INJECTED
global WFRD0424 `"start "rd2017/lib/shared.do:L348:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 10 47"' // WFLOG-INJECTED
global WFRD0425 `"end "rd2017/lib/shared.do:L348:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 10 47"' // WFLOG-INJECTED
global WFRD0426 `"start "rd2017/lib/shared.do:L349:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 11 47"' // WFLOG-INJECTED
global WFRD0427 `"end "rd2017/lib/shared.do:L349:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 11 47"' // WFLOG-INJECTED
global WFRD0428 `"start "rd2017/lib/shared.do:L350:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 12 47"' // WFLOG-INJECTED
global WFRD0429 `"end "rd2017/lib/shared.do:L350:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 12 47"' // WFLOG-INJECTED
global WFRD0430 `"start "rd2017/lib/shared.do:L351:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 13 47"' // WFLOG-INJECTED
global WFRD0431 `"end "rd2017/lib/shared.do:L351:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 13 47"' // WFLOG-INJECTED
global WFRD0432 `"start "rd2017/lib/shared.do:L352:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 14 47"' // WFLOG-INJECTED
global WFRD0433 `"end "rd2017/lib/shared.do:L352:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 14 47"' // WFLOG-INJECTED
global WFRD0434 `"start "rd2017/lib/shared.do:L353:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 15 47"' // WFLOG-INJECTED
global WFRD0435 `"end "rd2017/lib/shared.do:L353:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 15 47"' // WFLOG-INJECTED
global WFRD0436 `"start "rd2017/lib/shared.do:L354:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 16 47"' // WFLOG-INJECTED
global WFRD0437 `"end "rd2017/lib/shared.do:L354:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 16 47"' // WFLOG-INJECTED
global WFRD0438 `"start "rd2017/lib/shared.do:L355:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 17 47"' // WFLOG-INJECTED
global WFRD0439 `"end "rd2017/lib/shared.do:L355:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 17 47"' // WFLOG-INJECTED
global WFRD0440 `"start "rd2017/lib/shared.do:L356:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 18 47"' // WFLOG-INJECTED
global WFRD0441 `"end "rd2017/lib/shared.do:L356:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 18 47"' // WFLOG-INJECTED
global WFRD0442 `"start "rd2017/lib/shared.do:L357:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 19 47"' // WFLOG-INJECTED
global WFRD0443 `"end "rd2017/lib/shared.do:L357:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 19 47"' // WFLOG-INJECTED
global WFRD0444 `"start "rd2017/lib/shared.do:L358:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 20 47"' // WFLOG-INJECTED
global WFRD0445 `"end "rd2017/lib/shared.do:L358:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 20 47"' // WFLOG-INJECTED
global WFRD0446 `"start "rd2017/lib/shared.do:L359:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 21 47"' // WFLOG-INJECTED
global WFRD0447 `"end "rd2017/lib/shared.do:L359:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 21 47"' // WFLOG-INJECTED
global WFRD0448 `"start "rd2017/lib/shared.do:L360:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 22 47"' // WFLOG-INJECTED
global WFRD0449 `"end "rd2017/lib/shared.do:L360:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 22 47"' // WFLOG-INJECTED
global WFRD0450 `"start "rd2017/lib/shared.do:L361:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 23 47"' // WFLOG-INJECTED
global WFRD0451 `"end "rd2017/lib/shared.do:L361:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 23 47"' // WFLOG-INJECTED
global WFRD0452 `"start "rd2017/lib/shared.do:L362:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 24 47"' // WFLOG-INJECTED
global WFRD0453 `"end "rd2017/lib/shared.do:L362:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 24 47"' // WFLOG-INJECTED
global WFRD0454 `"start "rd2017/lib/shared.do:L363:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 25 47"' // WFLOG-INJECTED
global WFRD0455 `"end "rd2017/lib/shared.do:L363:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 25 47"' // WFLOG-INJECTED
global WFRD0456 `"start "rd2017/lib/shared.do:L364:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 26 47"' // WFLOG-INJECTED
global WFRD0457 `"end "rd2017/lib/shared.do:L364:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 26 47"' // WFLOG-INJECTED
global WFRD0458 `"start "rd2017/lib/shared.do:L365:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 27 47"' // WFLOG-INJECTED
global WFRD0459 `"end "rd2017/lib/shared.do:L365:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 27 47"' // WFLOG-INJECTED
global WFRD0460 `"start "rd2017/lib/shared.do:L366:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 28 47"' // WFLOG-INJECTED
global WFRD0461 `"end "rd2017/lib/shared.do:L366:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 28 47"' // WFLOG-INJECTED
global WFRD0462 `"start "rd2017/lib/shared.do:L367:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 29 47"' // WFLOG-INJECTED
global WFRD0463 `"end "rd2017/lib/shared.do:L367:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 29 47"' // WFLOG-INJECTED
global WFRD0464 `"start "rd2017/lib/shared.do:L368:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 30 47"' // WFLOG-INJECTED
global WFRD0465 `"end "rd2017/lib/shared.do:L368:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 30 47"' // WFLOG-INJECTED
global WFRD0466 `"start "rd2017/lib/shared.do:L369:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 31 47"' // WFLOG-INJECTED
global WFRD0467 `"end "rd2017/lib/shared.do:L369:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 31 47"' // WFLOG-INJECTED
global WFRD0468 `"start "rd2017/lib/shared.do:L370:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 32 47"' // WFLOG-INJECTED
global WFRD0469 `"end "rd2017/lib/shared.do:L370:step-recast" "rd2017/lib/shared.do:L338:block-body" "statement" 32 47"' // WFLOG-INJECTED
global WFRD0470 `"start "rd2017/lib/shared.do:L371:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 33 47"' // WFLOG-INJECTED
global WFRD0471 `"end "rd2017/lib/shared.do:L371:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 33 47"' // WFLOG-INJECTED
global WFRD0472 `"start "rd2017/lib/shared.do:L372:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 34 47"' // WFLOG-INJECTED
global WFRD0473 `"end "rd2017/lib/shared.do:L372:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 34 47"' // WFLOG-INJECTED
global WFRD0474 `"start "rd2017/lib/shared.do:L373:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 35 47"' // WFLOG-INJECTED
global WFRD0475 `"end "rd2017/lib/shared.do:L373:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 35 47"' // WFLOG-INJECTED
global WFRD0476 `"start "rd2017/lib/shared.do:L374:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 36 47"' // WFLOG-INJECTED
global WFRD0477 `"end "rd2017/lib/shared.do:L374:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 36 47"' // WFLOG-INJECTED
global WFRD0478 `"start "rd2017/lib/shared.do:L375:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 37 47"' // WFLOG-INJECTED
global WFRD0479 `"end "rd2017/lib/shared.do:L375:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 37 47"' // WFLOG-INJECTED
global WFRD0480 `"start "rd2017/lib/shared.do:L376:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 38 47"' // WFLOG-INJECTED
global WFRD0481 `"end "rd2017/lib/shared.do:L376:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 38 47"' // WFLOG-INJECTED
global WFRD0482 `"start "rd2017/lib/shared.do:L377:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 39 47"' // WFLOG-INJECTED
global WFRD0483 `"end "rd2017/lib/shared.do:L377:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 39 47"' // WFLOG-INJECTED
global WFRD0484 `"start "rd2017/lib/shared.do:L378:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 40 47"' // WFLOG-INJECTED
global WFRD0485 `"end "rd2017/lib/shared.do:L378:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 40 47"' // WFLOG-INJECTED
global WFRD0486 `"start "rd2017/lib/shared.do:L379:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 41 47"' // WFLOG-INJECTED
global WFRD0487 `"end "rd2017/lib/shared.do:L379:step-rename" "rd2017/lib/shared.do:L338:block-body" "statement" 41 47"' // WFLOG-INJECTED
global WFRD0488 `"start "rd2017/lib/shared.do:L380:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 42 47"' // WFLOG-INJECTED
global WFRD0489 `"end "rd2017/lib/shared.do:L380:step-generate" "rd2017/lib/shared.do:L338:block-body" "statement" 42 47"' // WFLOG-INJECTED
global WFRD0490 `"start "rd2017/lib/shared.do:L381:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 43 47"' // WFLOG-INJECTED
global WFRD0491 `"end "rd2017/lib/shared.do:L381:step-assert" "rd2017/lib/shared.do:L338:block-body" "statement" 43 47"' // WFLOG-INJECTED
global WFRD0492 `"start "rd2017/lib/shared.do:L382:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 44 47"' // WFLOG-INJECTED
global WFRD0493 `"end "rd2017/lib/shared.do:L382:step-drop" "rd2017/lib/shared.do:L338:block-body" "statement" 44 47"' // WFLOG-INJECTED
global WFRD0494 `"start "rd2017/lib/shared.do:L383:step-order" "rd2017/lib/shared.do:L338:block-body" "statement" 45 47"' // WFLOG-INJECTED
global WFRD0495 `"end "rd2017/lib/shared.do:L383:step-order" "rd2017/lib/shared.do:L338:block-body" "statement" 45 47"' // WFLOG-INJECTED
global WFRD0496 `"start "rd2017/lib/shared.do:L384:step-rd17_schema" "rd2017/lib/shared.do:L338:block-body" "statement" 46 47"' // WFLOG-INJECTED
global WFRD0497 `"end "rd2017/lib/shared.do:L384:step-rd17_schema" "rd2017/lib/shared.do:L338:block-body" "statement" 46 47"' // WFLOG-INJECTED
global WFRD0498 `"start "rd2017/lib/shared.do:L385:step-exit" "rd2017/lib/shared.do:L338:block-body" "statement" 47 47"' // WFLOG-INJECTED
global WFRD0499 `"end "rd2017/lib/shared.do:L385:step-exit" "rd2017/lib/shared.do:L338:block-body" "statement" 47 47"' // WFLOG-INJECTED
global WFRD0500 `"end "rd2017/lib/shared.do:L338:block-body" "rd2017/lib/shared.do:L338:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0501 `"end "rd2017/lib/shared.do:L338:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 8 19"' // WFLOG-INJECTED
global WFRD0502 `"start "rd2017/lib/shared.do:L387:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 9 19"' // WFLOG-INJECTED
global WFRD0503 `"start "rd2017/lib/shared.do:L387:block-body" "rd2017/lib/shared.do:L387:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0504 `"start "rd2017/lib/shared.do:L388:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0505 `"end "rd2017/lib/shared.do:L388:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0506 `"start "rd2017/lib/shared.do:L389:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0507 `"end "rd2017/lib/shared.do:L389:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0508 `"start "rd2017/lib/shared.do:L390:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0509 `"end "rd2017/lib/shared.do:L390:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0510 `"start "rd2017/lib/shared.do:L391:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0511 `"end "rd2017/lib/shared.do:L391:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0512 `"start "rd2017/lib/shared.do:L392:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0513 `"end "rd2017/lib/shared.do:L392:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0514 `"start "rd2017/lib/shared.do:L393:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0515 `"end "rd2017/lib/shared.do:L393:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0516 `"start "rd2017/lib/shared.do:L394:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0517 `"end "rd2017/lib/shared.do:L394:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0518 `"start "rd2017/lib/shared.do:L395:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0519 `"end "rd2017/lib/shared.do:L395:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0520 `"start "rd2017/lib/shared.do:L396:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0521 `"end "rd2017/lib/shared.do:L396:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0522 `"start "rd2017/lib/shared.do:L397:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0523 `"end "rd2017/lib/shared.do:L397:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0524 `"start "rd2017/lib/shared.do:L398:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0525 `"end "rd2017/lib/shared.do:L398:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0526 `"start "rd2017/lib/shared.do:L399:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0527 `"end "rd2017/lib/shared.do:L399:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0528 `"start "rd2017/lib/shared.do:L400:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0529 `"end "rd2017/lib/shared.do:L400:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0530 `"start "rd2017/lib/shared.do:L401:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0531 `"end "rd2017/lib/shared.do:L401:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0532 `"start "rd2017/lib/shared.do:L402:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0533 `"end "rd2017/lib/shared.do:L402:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0534 `"start "rd2017/lib/shared.do:L403:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0535 `"end "rd2017/lib/shared.do:L403:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0536 `"start "rd2017/lib/shared.do:L404:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0537 `"end "rd2017/lib/shared.do:L404:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0538 `"start "rd2017/lib/shared.do:L405:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0539 `"end "rd2017/lib/shared.do:L405:step-recast" "rd2017/lib/shared.do:L387:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0540 `"start "rd2017/lib/shared.do:L406:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0541 `"end "rd2017/lib/shared.do:L406:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0542 `"start "rd2017/lib/shared.do:L407:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0543 `"end "rd2017/lib/shared.do:L407:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0544 `"start "rd2017/lib/shared.do:L408:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0545 `"end "rd2017/lib/shared.do:L408:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0546 `"start "rd2017/lib/shared.do:L409:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0547 `"end "rd2017/lib/shared.do:L409:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0548 `"start "rd2017/lib/shared.do:L410:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0549 `"end "rd2017/lib/shared.do:L410:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0550 `"start "rd2017/lib/shared.do:L411:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0551 `"end "rd2017/lib/shared.do:L411:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0552 `"start "rd2017/lib/shared.do:L412:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0553 `"end "rd2017/lib/shared.do:L412:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0554 `"start "rd2017/lib/shared.do:L413:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0555 `"end "rd2017/lib/shared.do:L413:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0556 `"start "rd2017/lib/shared.do:L414:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0557 `"end "rd2017/lib/shared.do:L414:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0558 `"start "rd2017/lib/shared.do:L415:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0559 `"end "rd2017/lib/shared.do:L415:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0560 `"start "rd2017/lib/shared.do:L416:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0561 `"end "rd2017/lib/shared.do:L416:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0562 `"start "rd2017/lib/shared.do:L417:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0563 `"end "rd2017/lib/shared.do:L417:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0564 `"start "rd2017/lib/shared.do:L418:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0565 `"end "rd2017/lib/shared.do:L418:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0566 `"start "rd2017/lib/shared.do:L419:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0567 `"end "rd2017/lib/shared.do:L419:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0568 `"start "rd2017/lib/shared.do:L420:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0569 `"end "rd2017/lib/shared.do:L420:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0570 `"start "rd2017/lib/shared.do:L421:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0571 `"end "rd2017/lib/shared.do:L421:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0572 `"start "rd2017/lib/shared.do:L422:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0573 `"end "rd2017/lib/shared.do:L422:step-rename" "rd2017/lib/shared.do:L387:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0574 `"start "rd2017/lib/shared.do:L423:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0575 `"end "rd2017/lib/shared.do:L423:step-generate" "rd2017/lib/shared.do:L387:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0576 `"start "rd2017/lib/shared.do:L424:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0577 `"end "rd2017/lib/shared.do:L424:step-assert" "rd2017/lib/shared.do:L387:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0578 `"start "rd2017/lib/shared.do:L425:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0579 `"end "rd2017/lib/shared.do:L425:step-drop" "rd2017/lib/shared.do:L387:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0580 `"start "rd2017/lib/shared.do:L426:step-order" "rd2017/lib/shared.do:L387:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0581 `"end "rd2017/lib/shared.do:L426:step-order" "rd2017/lib/shared.do:L387:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0582 `"start "rd2017/lib/shared.do:L427:step-rd17_schema" "rd2017/lib/shared.do:L387:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0583 `"end "rd2017/lib/shared.do:L427:step-rd17_schema" "rd2017/lib/shared.do:L387:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0584 `"start "rd2017/lib/shared.do:L428:step-exit" "rd2017/lib/shared.do:L387:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0585 `"end "rd2017/lib/shared.do:L428:step-exit" "rd2017/lib/shared.do:L387:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0586 `"end "rd2017/lib/shared.do:L387:block-body" "rd2017/lib/shared.do:L387:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0587 `"end "rd2017/lib/shared.do:L387:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 9 19"' // WFLOG-INJECTED
global WFRD0588 `"start "rd2017/lib/shared.do:L430:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 10 19"' // WFLOG-INJECTED
global WFRD0589 `"start "rd2017/lib/shared.do:L430:block-body" "rd2017/lib/shared.do:L430:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0590 `"start "rd2017/lib/shared.do:L431:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0591 `"end "rd2017/lib/shared.do:L431:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 1 41"' // WFLOG-INJECTED
global WFRD0592 `"start "rd2017/lib/shared.do:L432:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0593 `"end "rd2017/lib/shared.do:L432:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 2 41"' // WFLOG-INJECTED
global WFRD0594 `"start "rd2017/lib/shared.do:L433:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0595 `"end "rd2017/lib/shared.do:L433:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 3 41"' // WFLOG-INJECTED
global WFRD0596 `"start "rd2017/lib/shared.do:L434:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0597 `"end "rd2017/lib/shared.do:L434:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 4 41"' // WFLOG-INJECTED
global WFRD0598 `"start "rd2017/lib/shared.do:L435:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0599 `"end "rd2017/lib/shared.do:L435:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 5 41"' // WFLOG-INJECTED
global WFRD0600 `"start "rd2017/lib/shared.do:L436:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0601 `"end "rd2017/lib/shared.do:L436:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 6 41"' // WFLOG-INJECTED
global WFRD0602 `"start "rd2017/lib/shared.do:L437:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0603 `"end "rd2017/lib/shared.do:L437:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 7 41"' // WFLOG-INJECTED
global WFRD0604 `"start "rd2017/lib/shared.do:L438:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0605 `"end "rd2017/lib/shared.do:L438:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 8 41"' // WFLOG-INJECTED
global WFRD0606 `"start "rd2017/lib/shared.do:L439:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0607 `"end "rd2017/lib/shared.do:L439:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 9 41"' // WFLOG-INJECTED
global WFRD0608 `"start "rd2017/lib/shared.do:L440:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0609 `"end "rd2017/lib/shared.do:L440:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 10 41"' // WFLOG-INJECTED
global WFRD0610 `"start "rd2017/lib/shared.do:L441:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0611 `"end "rd2017/lib/shared.do:L441:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 11 41"' // WFLOG-INJECTED
global WFRD0612 `"start "rd2017/lib/shared.do:L442:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0613 `"end "rd2017/lib/shared.do:L442:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 12 41"' // WFLOG-INJECTED
global WFRD0614 `"start "rd2017/lib/shared.do:L443:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0615 `"end "rd2017/lib/shared.do:L443:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 13 41"' // WFLOG-INJECTED
global WFRD0616 `"start "rd2017/lib/shared.do:L444:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0617 `"end "rd2017/lib/shared.do:L444:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 14 41"' // WFLOG-INJECTED
global WFRD0618 `"start "rd2017/lib/shared.do:L445:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0619 `"end "rd2017/lib/shared.do:L445:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 15 41"' // WFLOG-INJECTED
global WFRD0620 `"start "rd2017/lib/shared.do:L446:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0621 `"end "rd2017/lib/shared.do:L446:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 16 41"' // WFLOG-INJECTED
global WFRD0622 `"start "rd2017/lib/shared.do:L447:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0623 `"end "rd2017/lib/shared.do:L447:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 17 41"' // WFLOG-INJECTED
global WFRD0624 `"start "rd2017/lib/shared.do:L448:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0625 `"end "rd2017/lib/shared.do:L448:step-recast" "rd2017/lib/shared.do:L430:block-body" "statement" 18 41"' // WFLOG-INJECTED
global WFRD0626 `"start "rd2017/lib/shared.do:L449:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0627 `"end "rd2017/lib/shared.do:L449:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 19 41"' // WFLOG-INJECTED
global WFRD0628 `"start "rd2017/lib/shared.do:L450:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0629 `"end "rd2017/lib/shared.do:L450:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 20 41"' // WFLOG-INJECTED
global WFRD0630 `"start "rd2017/lib/shared.do:L451:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0631 `"end "rd2017/lib/shared.do:L451:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 21 41"' // WFLOG-INJECTED
global WFRD0632 `"start "rd2017/lib/shared.do:L452:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0633 `"end "rd2017/lib/shared.do:L452:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 22 41"' // WFLOG-INJECTED
global WFRD0634 `"start "rd2017/lib/shared.do:L453:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0635 `"end "rd2017/lib/shared.do:L453:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 23 41"' // WFLOG-INJECTED
global WFRD0636 `"start "rd2017/lib/shared.do:L454:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0637 `"end "rd2017/lib/shared.do:L454:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 24 41"' // WFLOG-INJECTED
global WFRD0638 `"start "rd2017/lib/shared.do:L455:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0639 `"end "rd2017/lib/shared.do:L455:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 25 41"' // WFLOG-INJECTED
global WFRD0640 `"start "rd2017/lib/shared.do:L456:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0641 `"end "rd2017/lib/shared.do:L456:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 26 41"' // WFLOG-INJECTED
global WFRD0642 `"start "rd2017/lib/shared.do:L457:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0643 `"end "rd2017/lib/shared.do:L457:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 27 41"' // WFLOG-INJECTED
global WFRD0644 `"start "rd2017/lib/shared.do:L458:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0645 `"end "rd2017/lib/shared.do:L458:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 28 41"' // WFLOG-INJECTED
global WFRD0646 `"start "rd2017/lib/shared.do:L459:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0647 `"end "rd2017/lib/shared.do:L459:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 29 41"' // WFLOG-INJECTED
global WFRD0648 `"start "rd2017/lib/shared.do:L460:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0649 `"end "rd2017/lib/shared.do:L460:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 30 41"' // WFLOG-INJECTED
global WFRD0650 `"start "rd2017/lib/shared.do:L461:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0651 `"end "rd2017/lib/shared.do:L461:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 31 41"' // WFLOG-INJECTED
global WFRD0652 `"start "rd2017/lib/shared.do:L462:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0653 `"end "rd2017/lib/shared.do:L462:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 32 41"' // WFLOG-INJECTED
global WFRD0654 `"start "rd2017/lib/shared.do:L463:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0655 `"end "rd2017/lib/shared.do:L463:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 33 41"' // WFLOG-INJECTED
global WFRD0656 `"start "rd2017/lib/shared.do:L464:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0657 `"end "rd2017/lib/shared.do:L464:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 34 41"' // WFLOG-INJECTED
global WFRD0658 `"start "rd2017/lib/shared.do:L465:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0659 `"end "rd2017/lib/shared.do:L465:step-rename" "rd2017/lib/shared.do:L430:block-body" "statement" 35 41"' // WFLOG-INJECTED
global WFRD0660 `"start "rd2017/lib/shared.do:L466:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0661 `"end "rd2017/lib/shared.do:L466:step-generate" "rd2017/lib/shared.do:L430:block-body" "statement" 36 41"' // WFLOG-INJECTED
global WFRD0662 `"start "rd2017/lib/shared.do:L467:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0663 `"end "rd2017/lib/shared.do:L467:step-assert" "rd2017/lib/shared.do:L430:block-body" "statement" 37 41"' // WFLOG-INJECTED
global WFRD0664 `"start "rd2017/lib/shared.do:L468:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0665 `"end "rd2017/lib/shared.do:L468:step-drop" "rd2017/lib/shared.do:L430:block-body" "statement" 38 41"' // WFLOG-INJECTED
global WFRD0666 `"start "rd2017/lib/shared.do:L469:step-order" "rd2017/lib/shared.do:L430:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0667 `"end "rd2017/lib/shared.do:L469:step-order" "rd2017/lib/shared.do:L430:block-body" "statement" 39 41"' // WFLOG-INJECTED
global WFRD0668 `"start "rd2017/lib/shared.do:L470:step-rd17_schema" "rd2017/lib/shared.do:L430:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0669 `"end "rd2017/lib/shared.do:L470:step-rd17_schema" "rd2017/lib/shared.do:L430:block-body" "statement" 40 41"' // WFLOG-INJECTED
global WFRD0670 `"start "rd2017/lib/shared.do:L471:step-exit" "rd2017/lib/shared.do:L430:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0671 `"end "rd2017/lib/shared.do:L471:step-exit" "rd2017/lib/shared.do:L430:block-body" "statement" 41 41"' // WFLOG-INJECTED
global WFRD0672 `"end "rd2017/lib/shared.do:L430:block-body" "rd2017/lib/shared.do:L430:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0673 `"end "rd2017/lib/shared.do:L430:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 10 19"' // WFLOG-INJECTED
global WFRD0674 `"start "rd2017/lib/shared.do:L473:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 11 19"' // WFLOG-INJECTED
global WFRD0675 `"start "rd2017/lib/shared.do:L473:block-body" "rd2017/lib/shared.do:L473:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0676 `"start "rd2017/lib/shared.do:L474:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 1 77"' // WFLOG-INJECTED
global WFRD0677 `"end "rd2017/lib/shared.do:L474:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 1 77"' // WFLOG-INJECTED
global WFRD0678 `"start "rd2017/lib/shared.do:L475:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 2 77"' // WFLOG-INJECTED
global WFRD0679 `"end "rd2017/lib/shared.do:L475:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 2 77"' // WFLOG-INJECTED
global WFRD0680 `"start "rd2017/lib/shared.do:L476:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 3 77"' // WFLOG-INJECTED
global WFRD0681 `"end "rd2017/lib/shared.do:L476:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 3 77"' // WFLOG-INJECTED
global WFRD0682 `"start "rd2017/lib/shared.do:L477:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 4 77"' // WFLOG-INJECTED
global WFRD0683 `"end "rd2017/lib/shared.do:L477:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 4 77"' // WFLOG-INJECTED
global WFRD0684 `"start "rd2017/lib/shared.do:L478:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 5 77"' // WFLOG-INJECTED
global WFRD0685 `"end "rd2017/lib/shared.do:L478:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 5 77"' // WFLOG-INJECTED
global WFRD0686 `"start "rd2017/lib/shared.do:L479:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 6 77"' // WFLOG-INJECTED
global WFRD0687 `"end "rd2017/lib/shared.do:L479:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 6 77"' // WFLOG-INJECTED
global WFRD0688 `"start "rd2017/lib/shared.do:L480:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 7 77"' // WFLOG-INJECTED
global WFRD0689 `"end "rd2017/lib/shared.do:L480:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 7 77"' // WFLOG-INJECTED
global WFRD0690 `"start "rd2017/lib/shared.do:L481:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 8 77"' // WFLOG-INJECTED
global WFRD0691 `"end "rd2017/lib/shared.do:L481:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 8 77"' // WFLOG-INJECTED
global WFRD0692 `"start "rd2017/lib/shared.do:L482:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 9 77"' // WFLOG-INJECTED
global WFRD0693 `"end "rd2017/lib/shared.do:L482:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 9 77"' // WFLOG-INJECTED
global WFRD0694 `"start "rd2017/lib/shared.do:L483:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 10 77"' // WFLOG-INJECTED
global WFRD0695 `"end "rd2017/lib/shared.do:L483:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 10 77"' // WFLOG-INJECTED
global WFRD0696 `"start "rd2017/lib/shared.do:L484:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 11 77"' // WFLOG-INJECTED
global WFRD0697 `"end "rd2017/lib/shared.do:L484:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 11 77"' // WFLOG-INJECTED
global WFRD0698 `"start "rd2017/lib/shared.do:L485:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 12 77"' // WFLOG-INJECTED
global WFRD0699 `"end "rd2017/lib/shared.do:L485:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 12 77"' // WFLOG-INJECTED
global WFRD0700 `"start "rd2017/lib/shared.do:L486:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 13 77"' // WFLOG-INJECTED
global WFRD0701 `"end "rd2017/lib/shared.do:L486:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 13 77"' // WFLOG-INJECTED
global WFRD0702 `"start "rd2017/lib/shared.do:L487:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 14 77"' // WFLOG-INJECTED
global WFRD0703 `"end "rd2017/lib/shared.do:L487:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 14 77"' // WFLOG-INJECTED
global WFRD0704 `"start "rd2017/lib/shared.do:L488:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 15 77"' // WFLOG-INJECTED
global WFRD0705 `"end "rd2017/lib/shared.do:L488:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 15 77"' // WFLOG-INJECTED
global WFRD0706 `"start "rd2017/lib/shared.do:L489:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 16 77"' // WFLOG-INJECTED
global WFRD0707 `"end "rd2017/lib/shared.do:L489:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 16 77"' // WFLOG-INJECTED
global WFRD0708 `"start "rd2017/lib/shared.do:L490:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 17 77"' // WFLOG-INJECTED
global WFRD0709 `"end "rd2017/lib/shared.do:L490:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 17 77"' // WFLOG-INJECTED
global WFRD0710 `"start "rd2017/lib/shared.do:L491:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 18 77"' // WFLOG-INJECTED
global WFRD0711 `"end "rd2017/lib/shared.do:L491:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 18 77"' // WFLOG-INJECTED
global WFRD0712 `"start "rd2017/lib/shared.do:L492:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 19 77"' // WFLOG-INJECTED
global WFRD0713 `"end "rd2017/lib/shared.do:L492:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 19 77"' // WFLOG-INJECTED
global WFRD0714 `"start "rd2017/lib/shared.do:L493:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 20 77"' // WFLOG-INJECTED
global WFRD0715 `"end "rd2017/lib/shared.do:L493:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 20 77"' // WFLOG-INJECTED
global WFRD0716 `"start "rd2017/lib/shared.do:L494:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 21 77"' // WFLOG-INJECTED
global WFRD0717 `"end "rd2017/lib/shared.do:L494:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 21 77"' // WFLOG-INJECTED
global WFRD0718 `"start "rd2017/lib/shared.do:L495:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 22 77"' // WFLOG-INJECTED
global WFRD0719 `"end "rd2017/lib/shared.do:L495:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 22 77"' // WFLOG-INJECTED
global WFRD0720 `"start "rd2017/lib/shared.do:L496:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 23 77"' // WFLOG-INJECTED
global WFRD0721 `"end "rd2017/lib/shared.do:L496:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 23 77"' // WFLOG-INJECTED
global WFRD0722 `"start "rd2017/lib/shared.do:L497:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 24 77"' // WFLOG-INJECTED
global WFRD0723 `"end "rd2017/lib/shared.do:L497:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 24 77"' // WFLOG-INJECTED
global WFRD0724 `"start "rd2017/lib/shared.do:L498:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 25 77"' // WFLOG-INJECTED
global WFRD0725 `"end "rd2017/lib/shared.do:L498:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 25 77"' // WFLOG-INJECTED
global WFRD0726 `"start "rd2017/lib/shared.do:L499:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 26 77"' // WFLOG-INJECTED
global WFRD0727 `"end "rd2017/lib/shared.do:L499:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 26 77"' // WFLOG-INJECTED
global WFRD0728 `"start "rd2017/lib/shared.do:L500:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 27 77"' // WFLOG-INJECTED
global WFRD0729 `"end "rd2017/lib/shared.do:L500:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 27 77"' // WFLOG-INJECTED
global WFRD0730 `"start "rd2017/lib/shared.do:L501:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 28 77"' // WFLOG-INJECTED
global WFRD0731 `"end "rd2017/lib/shared.do:L501:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 28 77"' // WFLOG-INJECTED
global WFRD0732 `"start "rd2017/lib/shared.do:L502:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 29 77"' // WFLOG-INJECTED
global WFRD0733 `"end "rd2017/lib/shared.do:L502:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 29 77"' // WFLOG-INJECTED
global WFRD0734 `"start "rd2017/lib/shared.do:L503:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 30 77"' // WFLOG-INJECTED
global WFRD0735 `"end "rd2017/lib/shared.do:L503:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 30 77"' // WFLOG-INJECTED
global WFRD0736 `"start "rd2017/lib/shared.do:L504:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 31 77"' // WFLOG-INJECTED
global WFRD0737 `"end "rd2017/lib/shared.do:L504:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 31 77"' // WFLOG-INJECTED
global WFRD0738 `"start "rd2017/lib/shared.do:L505:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 32 77"' // WFLOG-INJECTED
global WFRD0739 `"end "rd2017/lib/shared.do:L505:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 32 77"' // WFLOG-INJECTED
global WFRD0740 `"start "rd2017/lib/shared.do:L506:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 33 77"' // WFLOG-INJECTED
global WFRD0741 `"end "rd2017/lib/shared.do:L506:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 33 77"' // WFLOG-INJECTED
global WFRD0742 `"start "rd2017/lib/shared.do:L507:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 34 77"' // WFLOG-INJECTED
global WFRD0743 `"end "rd2017/lib/shared.do:L507:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 34 77"' // WFLOG-INJECTED
global WFRD0744 `"start "rd2017/lib/shared.do:L508:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 35 77"' // WFLOG-INJECTED
global WFRD0745 `"end "rd2017/lib/shared.do:L508:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 35 77"' // WFLOG-INJECTED
global WFRD0746 `"start "rd2017/lib/shared.do:L509:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 36 77"' // WFLOG-INJECTED
global WFRD0747 `"end "rd2017/lib/shared.do:L509:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 36 77"' // WFLOG-INJECTED
global WFRD0748 `"start "rd2017/lib/shared.do:L510:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 37 77"' // WFLOG-INJECTED
global WFRD0749 `"end "rd2017/lib/shared.do:L510:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 37 77"' // WFLOG-INJECTED
global WFRD0750 `"start "rd2017/lib/shared.do:L511:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 38 77"' // WFLOG-INJECTED
global WFRD0751 `"end "rd2017/lib/shared.do:L511:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 38 77"' // WFLOG-INJECTED
global WFRD0752 `"start "rd2017/lib/shared.do:L512:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 39 77"' // WFLOG-INJECTED
global WFRD0753 `"end "rd2017/lib/shared.do:L512:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 39 77"' // WFLOG-INJECTED
global WFRD0754 `"start "rd2017/lib/shared.do:L513:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 40 77"' // WFLOG-INJECTED
global WFRD0755 `"end "rd2017/lib/shared.do:L513:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 40 77"' // WFLOG-INJECTED
global WFRD0756 `"start "rd2017/lib/shared.do:L514:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 41 77"' // WFLOG-INJECTED
global WFRD0757 `"end "rd2017/lib/shared.do:L514:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 41 77"' // WFLOG-INJECTED
global WFRD0758 `"start "rd2017/lib/shared.do:L515:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 42 77"' // WFLOG-INJECTED
global WFRD0759 `"end "rd2017/lib/shared.do:L515:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 42 77"' // WFLOG-INJECTED
global WFRD0760 `"start "rd2017/lib/shared.do:L516:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 43 77"' // WFLOG-INJECTED
global WFRD0761 `"end "rd2017/lib/shared.do:L516:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 43 77"' // WFLOG-INJECTED
global WFRD0762 `"start "rd2017/lib/shared.do:L517:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 44 77"' // WFLOG-INJECTED
global WFRD0763 `"end "rd2017/lib/shared.do:L517:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 44 77"' // WFLOG-INJECTED
global WFRD0764 `"start "rd2017/lib/shared.do:L518:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 45 77"' // WFLOG-INJECTED
global WFRD0765 `"end "rd2017/lib/shared.do:L518:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 45 77"' // WFLOG-INJECTED
global WFRD0766 `"start "rd2017/lib/shared.do:L519:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 46 77"' // WFLOG-INJECTED
global WFRD0767 `"end "rd2017/lib/shared.do:L519:step-recast" "rd2017/lib/shared.do:L473:block-body" "statement" 46 77"' // WFLOG-INJECTED
global WFRD0768 `"start "rd2017/lib/shared.do:L520:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 47 77"' // WFLOG-INJECTED
global WFRD0769 `"end "rd2017/lib/shared.do:L520:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 47 77"' // WFLOG-INJECTED
global WFRD0770 `"start "rd2017/lib/shared.do:L521:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 48 77"' // WFLOG-INJECTED
global WFRD0771 `"end "rd2017/lib/shared.do:L521:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 48 77"' // WFLOG-INJECTED
global WFRD0772 `"start "rd2017/lib/shared.do:L522:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 49 77"' // WFLOG-INJECTED
global WFRD0773 `"end "rd2017/lib/shared.do:L522:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 49 77"' // WFLOG-INJECTED
global WFRD0774 `"start "rd2017/lib/shared.do:L523:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 50 77"' // WFLOG-INJECTED
global WFRD0775 `"end "rd2017/lib/shared.do:L523:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 50 77"' // WFLOG-INJECTED
global WFRD0776 `"start "rd2017/lib/shared.do:L524:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 51 77"' // WFLOG-INJECTED
global WFRD0777 `"end "rd2017/lib/shared.do:L524:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 51 77"' // WFLOG-INJECTED
global WFRD0778 `"start "rd2017/lib/shared.do:L525:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 52 77"' // WFLOG-INJECTED
global WFRD0779 `"end "rd2017/lib/shared.do:L525:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 52 77"' // WFLOG-INJECTED
global WFRD0780 `"start "rd2017/lib/shared.do:L526:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 53 77"' // WFLOG-INJECTED
global WFRD0781 `"end "rd2017/lib/shared.do:L526:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 53 77"' // WFLOG-INJECTED
global WFRD0782 `"start "rd2017/lib/shared.do:L527:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 54 77"' // WFLOG-INJECTED
global WFRD0783 `"end "rd2017/lib/shared.do:L527:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 54 77"' // WFLOG-INJECTED
global WFRD0784 `"start "rd2017/lib/shared.do:L528:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 55 77"' // WFLOG-INJECTED
global WFRD0785 `"end "rd2017/lib/shared.do:L528:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 55 77"' // WFLOG-INJECTED
global WFRD0786 `"start "rd2017/lib/shared.do:L529:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 56 77"' // WFLOG-INJECTED
global WFRD0787 `"end "rd2017/lib/shared.do:L529:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 56 77"' // WFLOG-INJECTED
global WFRD0788 `"start "rd2017/lib/shared.do:L530:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 57 77"' // WFLOG-INJECTED
global WFRD0789 `"end "rd2017/lib/shared.do:L530:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 57 77"' // WFLOG-INJECTED
global WFRD0790 `"start "rd2017/lib/shared.do:L531:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 58 77"' // WFLOG-INJECTED
global WFRD0791 `"end "rd2017/lib/shared.do:L531:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 58 77"' // WFLOG-INJECTED
global WFRD0792 `"start "rd2017/lib/shared.do:L532:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 59 77"' // WFLOG-INJECTED
global WFRD0793 `"end "rd2017/lib/shared.do:L532:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 59 77"' // WFLOG-INJECTED
global WFRD0794 `"start "rd2017/lib/shared.do:L533:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 60 77"' // WFLOG-INJECTED
global WFRD0795 `"end "rd2017/lib/shared.do:L533:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 60 77"' // WFLOG-INJECTED
global WFRD0796 `"start "rd2017/lib/shared.do:L534:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 61 77"' // WFLOG-INJECTED
global WFRD0797 `"end "rd2017/lib/shared.do:L534:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 61 77"' // WFLOG-INJECTED
global WFRD0798 `"start "rd2017/lib/shared.do:L535:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 62 77"' // WFLOG-INJECTED
global WFRD0799 `"end "rd2017/lib/shared.do:L535:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 62 77"' // WFLOG-INJECTED
global WFRD0800 `"start "rd2017/lib/shared.do:L536:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 63 77"' // WFLOG-INJECTED
global WFRD0801 `"end "rd2017/lib/shared.do:L536:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 63 77"' // WFLOG-INJECTED
global WFRD0802 `"start "rd2017/lib/shared.do:L537:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 64 77"' // WFLOG-INJECTED
global WFRD0803 `"end "rd2017/lib/shared.do:L537:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 64 77"' // WFLOG-INJECTED
global WFRD0804 `"start "rd2017/lib/shared.do:L538:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 65 77"' // WFLOG-INJECTED
global WFRD0805 `"end "rd2017/lib/shared.do:L538:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 65 77"' // WFLOG-INJECTED
global WFRD0806 `"start "rd2017/lib/shared.do:L539:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 66 77"' // WFLOG-INJECTED
global WFRD0807 `"end "rd2017/lib/shared.do:L539:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 66 77"' // WFLOG-INJECTED
global WFRD0808 `"start "rd2017/lib/shared.do:L540:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 67 77"' // WFLOG-INJECTED
global WFRD0809 `"end "rd2017/lib/shared.do:L540:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 67 77"' // WFLOG-INJECTED
global WFRD0810 `"start "rd2017/lib/shared.do:L541:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 68 77"' // WFLOG-INJECTED
global WFRD0811 `"end "rd2017/lib/shared.do:L541:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 68 77"' // WFLOG-INJECTED
global WFRD0812 `"start "rd2017/lib/shared.do:L542:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 69 77"' // WFLOG-INJECTED
global WFRD0813 `"end "rd2017/lib/shared.do:L542:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 69 77"' // WFLOG-INJECTED
global WFRD0814 `"start "rd2017/lib/shared.do:L543:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 70 77"' // WFLOG-INJECTED
global WFRD0815 `"end "rd2017/lib/shared.do:L543:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 70 77"' // WFLOG-INJECTED
global WFRD0816 `"start "rd2017/lib/shared.do:L544:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 71 77"' // WFLOG-INJECTED
global WFRD0817 `"end "rd2017/lib/shared.do:L544:step-rename" "rd2017/lib/shared.do:L473:block-body" "statement" 71 77"' // WFLOG-INJECTED
global WFRD0818 `"start "rd2017/lib/shared.do:L545:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 72 77"' // WFLOG-INJECTED
global WFRD0819 `"end "rd2017/lib/shared.do:L545:step-generate" "rd2017/lib/shared.do:L473:block-body" "statement" 72 77"' // WFLOG-INJECTED
global WFRD0820 `"start "rd2017/lib/shared.do:L546:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 73 77"' // WFLOG-INJECTED
global WFRD0821 `"end "rd2017/lib/shared.do:L546:step-assert" "rd2017/lib/shared.do:L473:block-body" "statement" 73 77"' // WFLOG-INJECTED
global WFRD0822 `"start "rd2017/lib/shared.do:L547:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 74 77"' // WFLOG-INJECTED
global WFRD0823 `"end "rd2017/lib/shared.do:L547:step-drop" "rd2017/lib/shared.do:L473:block-body" "statement" 74 77"' // WFLOG-INJECTED
global WFRD0824 `"start "rd2017/lib/shared.do:L548:step-order" "rd2017/lib/shared.do:L473:block-body" "statement" 75 77"' // WFLOG-INJECTED
global WFRD0825 `"end "rd2017/lib/shared.do:L548:step-order" "rd2017/lib/shared.do:L473:block-body" "statement" 75 77"' // WFLOG-INJECTED
global WFRD0826 `"start "rd2017/lib/shared.do:L549:step-rd17_schema" "rd2017/lib/shared.do:L473:block-body" "statement" 76 77"' // WFLOG-INJECTED
global WFRD0827 `"end "rd2017/lib/shared.do:L549:step-rd17_schema" "rd2017/lib/shared.do:L473:block-body" "statement" 76 77"' // WFLOG-INJECTED
global WFRD0828 `"start "rd2017/lib/shared.do:L550:step-exit" "rd2017/lib/shared.do:L473:block-body" "statement" 77 77"' // WFLOG-INJECTED
global WFRD0829 `"end "rd2017/lib/shared.do:L550:step-exit" "rd2017/lib/shared.do:L473:block-body" "statement" 77 77"' // WFLOG-INJECTED
global WFRD0830 `"end "rd2017/lib/shared.do:L473:block-body" "rd2017/lib/shared.do:L473:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0831 `"end "rd2017/lib/shared.do:L473:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 11 19"' // WFLOG-INJECTED
global WFRD0832 `"start "rd2017/lib/shared.do:L552:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 12 19"' // WFLOG-INJECTED
global WFRD0833 `"start "rd2017/lib/shared.do:L552:block-body" "rd2017/lib/shared.do:L552:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0834 `"start "rd2017/lib/shared.do:L553:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 1 77"' // WFLOG-INJECTED
global WFRD0835 `"end "rd2017/lib/shared.do:L553:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 1 77"' // WFLOG-INJECTED
global WFRD0836 `"start "rd2017/lib/shared.do:L554:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 2 77"' // WFLOG-INJECTED
global WFRD0837 `"end "rd2017/lib/shared.do:L554:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 2 77"' // WFLOG-INJECTED
global WFRD0838 `"start "rd2017/lib/shared.do:L555:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 3 77"' // WFLOG-INJECTED
global WFRD0839 `"end "rd2017/lib/shared.do:L555:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 3 77"' // WFLOG-INJECTED
global WFRD0840 `"start "rd2017/lib/shared.do:L556:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 4 77"' // WFLOG-INJECTED
global WFRD0841 `"end "rd2017/lib/shared.do:L556:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 4 77"' // WFLOG-INJECTED
global WFRD0842 `"start "rd2017/lib/shared.do:L557:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 5 77"' // WFLOG-INJECTED
global WFRD0843 `"end "rd2017/lib/shared.do:L557:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 5 77"' // WFLOG-INJECTED
global WFRD0844 `"start "rd2017/lib/shared.do:L558:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 6 77"' // WFLOG-INJECTED
global WFRD0845 `"end "rd2017/lib/shared.do:L558:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 6 77"' // WFLOG-INJECTED
global WFRD0846 `"start "rd2017/lib/shared.do:L559:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 7 77"' // WFLOG-INJECTED
global WFRD0847 `"end "rd2017/lib/shared.do:L559:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 7 77"' // WFLOG-INJECTED
global WFRD0848 `"start "rd2017/lib/shared.do:L560:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 8 77"' // WFLOG-INJECTED
global WFRD0849 `"end "rd2017/lib/shared.do:L560:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 8 77"' // WFLOG-INJECTED
global WFRD0850 `"start "rd2017/lib/shared.do:L561:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 9 77"' // WFLOG-INJECTED
global WFRD0851 `"end "rd2017/lib/shared.do:L561:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 9 77"' // WFLOG-INJECTED
global WFRD0852 `"start "rd2017/lib/shared.do:L562:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 10 77"' // WFLOG-INJECTED
global WFRD0853 `"end "rd2017/lib/shared.do:L562:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 10 77"' // WFLOG-INJECTED
global WFRD0854 `"start "rd2017/lib/shared.do:L563:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 11 77"' // WFLOG-INJECTED
global WFRD0855 `"end "rd2017/lib/shared.do:L563:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 11 77"' // WFLOG-INJECTED
global WFRD0856 `"start "rd2017/lib/shared.do:L564:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 12 77"' // WFLOG-INJECTED
global WFRD0857 `"end "rd2017/lib/shared.do:L564:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 12 77"' // WFLOG-INJECTED
global WFRD0858 `"start "rd2017/lib/shared.do:L565:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 13 77"' // WFLOG-INJECTED
global WFRD0859 `"end "rd2017/lib/shared.do:L565:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 13 77"' // WFLOG-INJECTED
global WFRD0860 `"start "rd2017/lib/shared.do:L566:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 14 77"' // WFLOG-INJECTED
global WFRD0861 `"end "rd2017/lib/shared.do:L566:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 14 77"' // WFLOG-INJECTED
global WFRD0862 `"start "rd2017/lib/shared.do:L567:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 15 77"' // WFLOG-INJECTED
global WFRD0863 `"end "rd2017/lib/shared.do:L567:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 15 77"' // WFLOG-INJECTED
global WFRD0864 `"start "rd2017/lib/shared.do:L568:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 16 77"' // WFLOG-INJECTED
global WFRD0865 `"end "rd2017/lib/shared.do:L568:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 16 77"' // WFLOG-INJECTED
global WFRD0866 `"start "rd2017/lib/shared.do:L569:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 17 77"' // WFLOG-INJECTED
global WFRD0867 `"end "rd2017/lib/shared.do:L569:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 17 77"' // WFLOG-INJECTED
global WFRD0868 `"start "rd2017/lib/shared.do:L570:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 18 77"' // WFLOG-INJECTED
global WFRD0869 `"end "rd2017/lib/shared.do:L570:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 18 77"' // WFLOG-INJECTED
global WFRD0870 `"start "rd2017/lib/shared.do:L571:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 19 77"' // WFLOG-INJECTED
global WFRD0871 `"end "rd2017/lib/shared.do:L571:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 19 77"' // WFLOG-INJECTED
global WFRD0872 `"start "rd2017/lib/shared.do:L572:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 20 77"' // WFLOG-INJECTED
global WFRD0873 `"end "rd2017/lib/shared.do:L572:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 20 77"' // WFLOG-INJECTED
global WFRD0874 `"start "rd2017/lib/shared.do:L573:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 21 77"' // WFLOG-INJECTED
global WFRD0875 `"end "rd2017/lib/shared.do:L573:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 21 77"' // WFLOG-INJECTED
global WFRD0876 `"start "rd2017/lib/shared.do:L574:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 22 77"' // WFLOG-INJECTED
global WFRD0877 `"end "rd2017/lib/shared.do:L574:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 22 77"' // WFLOG-INJECTED
global WFRD0878 `"start "rd2017/lib/shared.do:L575:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 23 77"' // WFLOG-INJECTED
global WFRD0879 `"end "rd2017/lib/shared.do:L575:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 23 77"' // WFLOG-INJECTED
global WFRD0880 `"start "rd2017/lib/shared.do:L576:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 24 77"' // WFLOG-INJECTED
global WFRD0881 `"end "rd2017/lib/shared.do:L576:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 24 77"' // WFLOG-INJECTED
global WFRD0882 `"start "rd2017/lib/shared.do:L577:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 25 77"' // WFLOG-INJECTED
global WFRD0883 `"end "rd2017/lib/shared.do:L577:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 25 77"' // WFLOG-INJECTED
global WFRD0884 `"start "rd2017/lib/shared.do:L578:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 26 77"' // WFLOG-INJECTED
global WFRD0885 `"end "rd2017/lib/shared.do:L578:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 26 77"' // WFLOG-INJECTED
global WFRD0886 `"start "rd2017/lib/shared.do:L579:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 27 77"' // WFLOG-INJECTED
global WFRD0887 `"end "rd2017/lib/shared.do:L579:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 27 77"' // WFLOG-INJECTED
global WFRD0888 `"start "rd2017/lib/shared.do:L580:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 28 77"' // WFLOG-INJECTED
global WFRD0889 `"end "rd2017/lib/shared.do:L580:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 28 77"' // WFLOG-INJECTED
global WFRD0890 `"start "rd2017/lib/shared.do:L581:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 29 77"' // WFLOG-INJECTED
global WFRD0891 `"end "rd2017/lib/shared.do:L581:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 29 77"' // WFLOG-INJECTED
global WFRD0892 `"start "rd2017/lib/shared.do:L582:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 30 77"' // WFLOG-INJECTED
global WFRD0893 `"end "rd2017/lib/shared.do:L582:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 30 77"' // WFLOG-INJECTED
global WFRD0894 `"start "rd2017/lib/shared.do:L583:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 31 77"' // WFLOG-INJECTED
global WFRD0895 `"end "rd2017/lib/shared.do:L583:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 31 77"' // WFLOG-INJECTED
global WFRD0896 `"start "rd2017/lib/shared.do:L584:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 32 77"' // WFLOG-INJECTED
global WFRD0897 `"end "rd2017/lib/shared.do:L584:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 32 77"' // WFLOG-INJECTED
global WFRD0898 `"start "rd2017/lib/shared.do:L585:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 33 77"' // WFLOG-INJECTED
global WFRD0899 `"end "rd2017/lib/shared.do:L585:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 33 77"' // WFLOG-INJECTED
global WFRD0900 `"start "rd2017/lib/shared.do:L586:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 34 77"' // WFLOG-INJECTED
global WFRD0901 `"end "rd2017/lib/shared.do:L586:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 34 77"' // WFLOG-INJECTED
global WFRD0902 `"start "rd2017/lib/shared.do:L587:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 35 77"' // WFLOG-INJECTED
global WFRD0903 `"end "rd2017/lib/shared.do:L587:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 35 77"' // WFLOG-INJECTED
global WFRD0904 `"start "rd2017/lib/shared.do:L588:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 36 77"' // WFLOG-INJECTED
global WFRD0905 `"end "rd2017/lib/shared.do:L588:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 36 77"' // WFLOG-INJECTED
global WFRD0906 `"start "rd2017/lib/shared.do:L589:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 37 77"' // WFLOG-INJECTED
global WFRD0907 `"end "rd2017/lib/shared.do:L589:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 37 77"' // WFLOG-INJECTED
global WFRD0908 `"start "rd2017/lib/shared.do:L590:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 38 77"' // WFLOG-INJECTED
global WFRD0909 `"end "rd2017/lib/shared.do:L590:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 38 77"' // WFLOG-INJECTED
global WFRD0910 `"start "rd2017/lib/shared.do:L591:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 39 77"' // WFLOG-INJECTED
global WFRD0911 `"end "rd2017/lib/shared.do:L591:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 39 77"' // WFLOG-INJECTED
global WFRD0912 `"start "rd2017/lib/shared.do:L592:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 40 77"' // WFLOG-INJECTED
global WFRD0913 `"end "rd2017/lib/shared.do:L592:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 40 77"' // WFLOG-INJECTED
global WFRD0914 `"start "rd2017/lib/shared.do:L593:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 41 77"' // WFLOG-INJECTED
global WFRD0915 `"end "rd2017/lib/shared.do:L593:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 41 77"' // WFLOG-INJECTED
global WFRD0916 `"start "rd2017/lib/shared.do:L594:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 42 77"' // WFLOG-INJECTED
global WFRD0917 `"end "rd2017/lib/shared.do:L594:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 42 77"' // WFLOG-INJECTED
global WFRD0918 `"start "rd2017/lib/shared.do:L595:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 43 77"' // WFLOG-INJECTED
global WFRD0919 `"end "rd2017/lib/shared.do:L595:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 43 77"' // WFLOG-INJECTED
global WFRD0920 `"start "rd2017/lib/shared.do:L596:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 44 77"' // WFLOG-INJECTED
global WFRD0921 `"end "rd2017/lib/shared.do:L596:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 44 77"' // WFLOG-INJECTED
global WFRD0922 `"start "rd2017/lib/shared.do:L597:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 45 77"' // WFLOG-INJECTED
global WFRD0923 `"end "rd2017/lib/shared.do:L597:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 45 77"' // WFLOG-INJECTED
global WFRD0924 `"start "rd2017/lib/shared.do:L598:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 46 77"' // WFLOG-INJECTED
global WFRD0925 `"end "rd2017/lib/shared.do:L598:step-recast" "rd2017/lib/shared.do:L552:block-body" "statement" 46 77"' // WFLOG-INJECTED
global WFRD0926 `"start "rd2017/lib/shared.do:L599:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 47 77"' // WFLOG-INJECTED
global WFRD0927 `"end "rd2017/lib/shared.do:L599:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 47 77"' // WFLOG-INJECTED
global WFRD0928 `"start "rd2017/lib/shared.do:L600:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 48 77"' // WFLOG-INJECTED
global WFRD0929 `"end "rd2017/lib/shared.do:L600:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 48 77"' // WFLOG-INJECTED
global WFRD0930 `"start "rd2017/lib/shared.do:L601:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 49 77"' // WFLOG-INJECTED
global WFRD0931 `"end "rd2017/lib/shared.do:L601:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 49 77"' // WFLOG-INJECTED
global WFRD0932 `"start "rd2017/lib/shared.do:L602:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 50 77"' // WFLOG-INJECTED
global WFRD0933 `"end "rd2017/lib/shared.do:L602:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 50 77"' // WFLOG-INJECTED
global WFRD0934 `"start "rd2017/lib/shared.do:L603:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 51 77"' // WFLOG-INJECTED
global WFRD0935 `"end "rd2017/lib/shared.do:L603:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 51 77"' // WFLOG-INJECTED
global WFRD0936 `"start "rd2017/lib/shared.do:L604:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 52 77"' // WFLOG-INJECTED
global WFRD0937 `"end "rd2017/lib/shared.do:L604:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 52 77"' // WFLOG-INJECTED
global WFRD0938 `"start "rd2017/lib/shared.do:L605:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 53 77"' // WFLOG-INJECTED
global WFRD0939 `"end "rd2017/lib/shared.do:L605:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 53 77"' // WFLOG-INJECTED
global WFRD0940 `"start "rd2017/lib/shared.do:L606:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 54 77"' // WFLOG-INJECTED
global WFRD0941 `"end "rd2017/lib/shared.do:L606:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 54 77"' // WFLOG-INJECTED
global WFRD0942 `"start "rd2017/lib/shared.do:L607:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 55 77"' // WFLOG-INJECTED
global WFRD0943 `"end "rd2017/lib/shared.do:L607:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 55 77"' // WFLOG-INJECTED
global WFRD0944 `"start "rd2017/lib/shared.do:L608:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 56 77"' // WFLOG-INJECTED
global WFRD0945 `"end "rd2017/lib/shared.do:L608:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 56 77"' // WFLOG-INJECTED
global WFRD0946 `"start "rd2017/lib/shared.do:L609:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 57 77"' // WFLOG-INJECTED
global WFRD0947 `"end "rd2017/lib/shared.do:L609:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 57 77"' // WFLOG-INJECTED
global WFRD0948 `"start "rd2017/lib/shared.do:L610:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 58 77"' // WFLOG-INJECTED
global WFRD0949 `"end "rd2017/lib/shared.do:L610:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 58 77"' // WFLOG-INJECTED
global WFRD0950 `"start "rd2017/lib/shared.do:L611:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 59 77"' // WFLOG-INJECTED
global WFRD0951 `"end "rd2017/lib/shared.do:L611:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 59 77"' // WFLOG-INJECTED
global WFRD0952 `"start "rd2017/lib/shared.do:L612:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 60 77"' // WFLOG-INJECTED
global WFRD0953 `"end "rd2017/lib/shared.do:L612:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 60 77"' // WFLOG-INJECTED
global WFRD0954 `"start "rd2017/lib/shared.do:L613:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 61 77"' // WFLOG-INJECTED
global WFRD0955 `"end "rd2017/lib/shared.do:L613:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 61 77"' // WFLOG-INJECTED
global WFRD0956 `"start "rd2017/lib/shared.do:L614:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 62 77"' // WFLOG-INJECTED
global WFRD0957 `"end "rd2017/lib/shared.do:L614:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 62 77"' // WFLOG-INJECTED
global WFRD0958 `"start "rd2017/lib/shared.do:L615:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 63 77"' // WFLOG-INJECTED
global WFRD0959 `"end "rd2017/lib/shared.do:L615:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 63 77"' // WFLOG-INJECTED
global WFRD0960 `"start "rd2017/lib/shared.do:L616:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 64 77"' // WFLOG-INJECTED
global WFRD0961 `"end "rd2017/lib/shared.do:L616:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 64 77"' // WFLOG-INJECTED
global WFRD0962 `"start "rd2017/lib/shared.do:L617:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 65 77"' // WFLOG-INJECTED
global WFRD0963 `"end "rd2017/lib/shared.do:L617:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 65 77"' // WFLOG-INJECTED
global WFRD0964 `"start "rd2017/lib/shared.do:L618:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 66 77"' // WFLOG-INJECTED
global WFRD0965 `"end "rd2017/lib/shared.do:L618:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 66 77"' // WFLOG-INJECTED
global WFRD0966 `"start "rd2017/lib/shared.do:L619:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 67 77"' // WFLOG-INJECTED
global WFRD0967 `"end "rd2017/lib/shared.do:L619:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 67 77"' // WFLOG-INJECTED
global WFRD0968 `"start "rd2017/lib/shared.do:L620:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 68 77"' // WFLOG-INJECTED
global WFRD0969 `"end "rd2017/lib/shared.do:L620:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 68 77"' // WFLOG-INJECTED
global WFRD0970 `"start "rd2017/lib/shared.do:L621:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 69 77"' // WFLOG-INJECTED
global WFRD0971 `"end "rd2017/lib/shared.do:L621:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 69 77"' // WFLOG-INJECTED
global WFRD0972 `"start "rd2017/lib/shared.do:L622:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 70 77"' // WFLOG-INJECTED
global WFRD0973 `"end "rd2017/lib/shared.do:L622:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 70 77"' // WFLOG-INJECTED
global WFRD0974 `"start "rd2017/lib/shared.do:L623:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 71 77"' // WFLOG-INJECTED
global WFRD0975 `"end "rd2017/lib/shared.do:L623:step-rename" "rd2017/lib/shared.do:L552:block-body" "statement" 71 77"' // WFLOG-INJECTED
global WFRD0976 `"start "rd2017/lib/shared.do:L624:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 72 77"' // WFLOG-INJECTED
global WFRD0977 `"end "rd2017/lib/shared.do:L624:step-generate" "rd2017/lib/shared.do:L552:block-body" "statement" 72 77"' // WFLOG-INJECTED
global WFRD0978 `"start "rd2017/lib/shared.do:L625:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 73 77"' // WFLOG-INJECTED
global WFRD0979 `"end "rd2017/lib/shared.do:L625:step-assert" "rd2017/lib/shared.do:L552:block-body" "statement" 73 77"' // WFLOG-INJECTED
global WFRD0980 `"start "rd2017/lib/shared.do:L626:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 74 77"' // WFLOG-INJECTED
global WFRD0981 `"end "rd2017/lib/shared.do:L626:step-drop" "rd2017/lib/shared.do:L552:block-body" "statement" 74 77"' // WFLOG-INJECTED
global WFRD0982 `"start "rd2017/lib/shared.do:L627:step-order" "rd2017/lib/shared.do:L552:block-body" "statement" 75 77"' // WFLOG-INJECTED
global WFRD0983 `"end "rd2017/lib/shared.do:L627:step-order" "rd2017/lib/shared.do:L552:block-body" "statement" 75 77"' // WFLOG-INJECTED
global WFRD0984 `"start "rd2017/lib/shared.do:L628:step-rd17_schema" "rd2017/lib/shared.do:L552:block-body" "statement" 76 77"' // WFLOG-INJECTED
global WFRD0985 `"end "rd2017/lib/shared.do:L628:step-rd17_schema" "rd2017/lib/shared.do:L552:block-body" "statement" 76 77"' // WFLOG-INJECTED
global WFRD0986 `"start "rd2017/lib/shared.do:L629:step-exit" "rd2017/lib/shared.do:L552:block-body" "statement" 77 77"' // WFLOG-INJECTED
global WFRD0987 `"end "rd2017/lib/shared.do:L629:step-exit" "rd2017/lib/shared.do:L552:block-body" "statement" 77 77"' // WFLOG-INJECTED
global WFRD0988 `"end "rd2017/lib/shared.do:L552:block-body" "rd2017/lib/shared.do:L552:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0989 `"end "rd2017/lib/shared.do:L552:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 12 19"' // WFLOG-INJECTED
global WFRD0990 `"start "rd2017/lib/shared.do:L631:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 13 19"' // WFLOG-INJECTED
global WFRD0991 `"start "rd2017/lib/shared.do:L631:block-body" "rd2017/lib/shared.do:L631:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD0992 `"start "rd2017/lib/shared.do:L632:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 1 43"' // WFLOG-INJECTED
global WFRD0993 `"end "rd2017/lib/shared.do:L632:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 1 43"' // WFLOG-INJECTED
global WFRD0994 `"start "rd2017/lib/shared.do:L633:step-recast" "rd2017/lib/shared.do:L631:block-body" "statement" 2 43"' // WFLOG-INJECTED
global WFRD0995 `"end "rd2017/lib/shared.do:L633:step-recast" "rd2017/lib/shared.do:L631:block-body" "statement" 2 43"' // WFLOG-INJECTED
global WFRD0996 `"start "rd2017/lib/shared.do:L634:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 3 43"' // WFLOG-INJECTED
global WFRD0997 `"end "rd2017/lib/shared.do:L634:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 3 43"' // WFLOG-INJECTED
global WFRD0998 `"start "rd2017/lib/shared.do:L635:step-recast" "rd2017/lib/shared.do:L631:block-body" "statement" 4 43"' // WFLOG-INJECTED
global WFRD0999 `"end "rd2017/lib/shared.do:L635:step-recast" "rd2017/lib/shared.do:L631:block-body" "statement" 4 43"' // WFLOG-INJECTED
global WFRD1000 `"start "rd2017/lib/shared.do:L636:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 5 43"' // WFLOG-INJECTED
global WFRD1001 `"end "rd2017/lib/shared.do:L636:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 5 43"' // WFLOG-INJECTED
global WFRD1002 `"start "rd2017/lib/shared.do:L637:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 6 43"' // WFLOG-INJECTED
global WFRD1003 `"end "rd2017/lib/shared.do:L637:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 6 43"' // WFLOG-INJECTED
global WFRD1004 `"start "rd2017/lib/shared.do:L638:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 7 43"' // WFLOG-INJECTED
global WFRD1005 `"end "rd2017/lib/shared.do:L638:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 7 43"' // WFLOG-INJECTED
global WFRD1006 `"start "rd2017/lib/shared.do:L639:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 8 43"' // WFLOG-INJECTED
global WFRD1007 `"end "rd2017/lib/shared.do:L639:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 8 43"' // WFLOG-INJECTED
global WFRD1008 `"start "rd2017/lib/shared.do:L640:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 9 43"' // WFLOG-INJECTED
global WFRD1009 `"end "rd2017/lib/shared.do:L640:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 9 43"' // WFLOG-INJECTED
global WFRD1010 `"start "rd2017/lib/shared.do:L641:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 10 43"' // WFLOG-INJECTED
global WFRD1011 `"end "rd2017/lib/shared.do:L641:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 10 43"' // WFLOG-INJECTED
global WFRD1012 `"start "rd2017/lib/shared.do:L642:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 11 43"' // WFLOG-INJECTED
global WFRD1013 `"end "rd2017/lib/shared.do:L642:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 11 43"' // WFLOG-INJECTED
global WFRD1014 `"start "rd2017/lib/shared.do:L643:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 12 43"' // WFLOG-INJECTED
global WFRD1015 `"end "rd2017/lib/shared.do:L643:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 12 43"' // WFLOG-INJECTED
global WFRD1016 `"start "rd2017/lib/shared.do:L644:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 13 43"' // WFLOG-INJECTED
global WFRD1017 `"end "rd2017/lib/shared.do:L644:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 13 43"' // WFLOG-INJECTED
global WFRD1018 `"start "rd2017/lib/shared.do:L645:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 14 43"' // WFLOG-INJECTED
global WFRD1019 `"end "rd2017/lib/shared.do:L645:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 14 43"' // WFLOG-INJECTED
global WFRD1020 `"start "rd2017/lib/shared.do:L646:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 15 43"' // WFLOG-INJECTED
global WFRD1021 `"end "rd2017/lib/shared.do:L646:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 15 43"' // WFLOG-INJECTED
global WFRD1022 `"start "rd2017/lib/shared.do:L647:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 16 43"' // WFLOG-INJECTED
global WFRD1023 `"end "rd2017/lib/shared.do:L647:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 16 43"' // WFLOG-INJECTED
global WFRD1024 `"start "rd2017/lib/shared.do:L648:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 17 43"' // WFLOG-INJECTED
global WFRD1025 `"end "rd2017/lib/shared.do:L648:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 17 43"' // WFLOG-INJECTED
global WFRD1026 `"start "rd2017/lib/shared.do:L649:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 18 43"' // WFLOG-INJECTED
global WFRD1027 `"end "rd2017/lib/shared.do:L649:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 18 43"' // WFLOG-INJECTED
global WFRD1028 `"start "rd2017/lib/shared.do:L650:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 19 43"' // WFLOG-INJECTED
global WFRD1029 `"end "rd2017/lib/shared.do:L650:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 19 43"' // WFLOG-INJECTED
global WFRD1030 `"start "rd2017/lib/shared.do:L651:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 20 43"' // WFLOG-INJECTED
global WFRD1031 `"end "rd2017/lib/shared.do:L651:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 20 43"' // WFLOG-INJECTED
global WFRD1032 `"start "rd2017/lib/shared.do:L652:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 21 43"' // WFLOG-INJECTED
global WFRD1033 `"end "rd2017/lib/shared.do:L652:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 21 43"' // WFLOG-INJECTED
global WFRD1034 `"start "rd2017/lib/shared.do:L653:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 22 43"' // WFLOG-INJECTED
global WFRD1035 `"end "rd2017/lib/shared.do:L653:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 22 43"' // WFLOG-INJECTED
global WFRD1036 `"start "rd2017/lib/shared.do:L654:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 23 43"' // WFLOG-INJECTED
global WFRD1037 `"end "rd2017/lib/shared.do:L654:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 23 43"' // WFLOG-INJECTED
global WFRD1038 `"start "rd2017/lib/shared.do:L655:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 24 43"' // WFLOG-INJECTED
global WFRD1039 `"end "rd2017/lib/shared.do:L655:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 24 43"' // WFLOG-INJECTED
global WFRD1040 `"start "rd2017/lib/shared.do:L656:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 25 43"' // WFLOG-INJECTED
global WFRD1041 `"end "rd2017/lib/shared.do:L656:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 25 43"' // WFLOG-INJECTED
global WFRD1042 `"start "rd2017/lib/shared.do:L657:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 26 43"' // WFLOG-INJECTED
global WFRD1043 `"end "rd2017/lib/shared.do:L657:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 26 43"' // WFLOG-INJECTED
global WFRD1044 `"start "rd2017/lib/shared.do:L658:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 27 43"' // WFLOG-INJECTED
global WFRD1045 `"end "rd2017/lib/shared.do:L658:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 27 43"' // WFLOG-INJECTED
global WFRD1046 `"start "rd2017/lib/shared.do:L659:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 28 43"' // WFLOG-INJECTED
global WFRD1047 `"end "rd2017/lib/shared.do:L659:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 28 43"' // WFLOG-INJECTED
global WFRD1048 `"start "rd2017/lib/shared.do:L660:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 29 43"' // WFLOG-INJECTED
global WFRD1049 `"end "rd2017/lib/shared.do:L660:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 29 43"' // WFLOG-INJECTED
global WFRD1050 `"start "rd2017/lib/shared.do:L661:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 30 43"' // WFLOG-INJECTED
global WFRD1051 `"end "rd2017/lib/shared.do:L661:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 30 43"' // WFLOG-INJECTED
global WFRD1052 `"start "rd2017/lib/shared.do:L662:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 31 43"' // WFLOG-INJECTED
global WFRD1053 `"end "rd2017/lib/shared.do:L662:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 31 43"' // WFLOG-INJECTED
global WFRD1054 `"start "rd2017/lib/shared.do:L663:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 32 43"' // WFLOG-INJECTED
global WFRD1055 `"end "rd2017/lib/shared.do:L663:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 32 43"' // WFLOG-INJECTED
global WFRD1056 `"start "rd2017/lib/shared.do:L664:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 33 43"' // WFLOG-INJECTED
global WFRD1057 `"end "rd2017/lib/shared.do:L664:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 33 43"' // WFLOG-INJECTED
global WFRD1058 `"start "rd2017/lib/shared.do:L665:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 34 43"' // WFLOG-INJECTED
global WFRD1059 `"end "rd2017/lib/shared.do:L665:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 34 43"' // WFLOG-INJECTED
global WFRD1060 `"start "rd2017/lib/shared.do:L666:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 35 43"' // WFLOG-INJECTED
global WFRD1061 `"end "rd2017/lib/shared.do:L666:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 35 43"' // WFLOG-INJECTED
global WFRD1062 `"start "rd2017/lib/shared.do:L667:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 36 43"' // WFLOG-INJECTED
global WFRD1063 `"end "rd2017/lib/shared.do:L667:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 36 43"' // WFLOG-INJECTED
global WFRD1064 `"start "rd2017/lib/shared.do:L668:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 37 43"' // WFLOG-INJECTED
global WFRD1065 `"end "rd2017/lib/shared.do:L668:step-rename" "rd2017/lib/shared.do:L631:block-body" "statement" 37 43"' // WFLOG-INJECTED
global WFRD1066 `"start "rd2017/lib/shared.do:L669:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 38 43"' // WFLOG-INJECTED
global WFRD1067 `"end "rd2017/lib/shared.do:L669:step-generate" "rd2017/lib/shared.do:L631:block-body" "statement" 38 43"' // WFLOG-INJECTED
global WFRD1068 `"start "rd2017/lib/shared.do:L670:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 39 43"' // WFLOG-INJECTED
global WFRD1069 `"end "rd2017/lib/shared.do:L670:step-assert" "rd2017/lib/shared.do:L631:block-body" "statement" 39 43"' // WFLOG-INJECTED
global WFRD1070 `"start "rd2017/lib/shared.do:L671:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 40 43"' // WFLOG-INJECTED
global WFRD1071 `"end "rd2017/lib/shared.do:L671:step-drop" "rd2017/lib/shared.do:L631:block-body" "statement" 40 43"' // WFLOG-INJECTED
global WFRD1072 `"start "rd2017/lib/shared.do:L672:step-order" "rd2017/lib/shared.do:L631:block-body" "statement" 41 43"' // WFLOG-INJECTED
global WFRD1073 `"end "rd2017/lib/shared.do:L672:step-order" "rd2017/lib/shared.do:L631:block-body" "statement" 41 43"' // WFLOG-INJECTED
global WFRD1074 `"start "rd2017/lib/shared.do:L673:step-rd17_schema" "rd2017/lib/shared.do:L631:block-body" "statement" 42 43"' // WFLOG-INJECTED
global WFRD1075 `"end "rd2017/lib/shared.do:L673:step-rd17_schema" "rd2017/lib/shared.do:L631:block-body" "statement" 42 43"' // WFLOG-INJECTED
global WFRD1076 `"start "rd2017/lib/shared.do:L674:step-exit" "rd2017/lib/shared.do:L631:block-body" "statement" 43 43"' // WFLOG-INJECTED
global WFRD1077 `"end "rd2017/lib/shared.do:L674:step-exit" "rd2017/lib/shared.do:L631:block-body" "statement" 43 43"' // WFLOG-INJECTED
global WFRD1078 `"end "rd2017/lib/shared.do:L631:block-body" "rd2017/lib/shared.do:L631:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1079 `"end "rd2017/lib/shared.do:L631:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 13 19"' // WFLOG-INJECTED
global WFRD1080 `"start "rd2017/lib/shared.do:L676:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 14 19"' // WFLOG-INJECTED
global WFRD1081 `"start "rd2017/lib/shared.do:L676:block-body" "rd2017/lib/shared.do:L676:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1082 `"start "rd2017/lib/shared.do:L677:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 1 63"' // WFLOG-INJECTED
global WFRD1083 `"end "rd2017/lib/shared.do:L677:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 1 63"' // WFLOG-INJECTED
global WFRD1084 `"start "rd2017/lib/shared.do:L678:step-recast" "rd2017/lib/shared.do:L676:block-body" "statement" 2 63"' // WFLOG-INJECTED
global WFRD1085 `"end "rd2017/lib/shared.do:L678:step-recast" "rd2017/lib/shared.do:L676:block-body" "statement" 2 63"' // WFLOG-INJECTED
global WFRD1086 `"start "rd2017/lib/shared.do:L679:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 3 63"' // WFLOG-INJECTED
global WFRD1087 `"end "rd2017/lib/shared.do:L679:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 3 63"' // WFLOG-INJECTED
global WFRD1088 `"start "rd2017/lib/shared.do:L680:step-recast" "rd2017/lib/shared.do:L676:block-body" "statement" 4 63"' // WFLOG-INJECTED
global WFRD1089 `"end "rd2017/lib/shared.do:L680:step-recast" "rd2017/lib/shared.do:L676:block-body" "statement" 4 63"' // WFLOG-INJECTED
global WFRD1090 `"start "rd2017/lib/shared.do:L681:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 5 63"' // WFLOG-INJECTED
global WFRD1091 `"end "rd2017/lib/shared.do:L681:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 5 63"' // WFLOG-INJECTED
global WFRD1092 `"start "rd2017/lib/shared.do:L682:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 6 63"' // WFLOG-INJECTED
global WFRD1093 `"end "rd2017/lib/shared.do:L682:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 6 63"' // WFLOG-INJECTED
global WFRD1094 `"start "rd2017/lib/shared.do:L683:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 7 63"' // WFLOG-INJECTED
global WFRD1095 `"end "rd2017/lib/shared.do:L683:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 7 63"' // WFLOG-INJECTED
global WFRD1096 `"start "rd2017/lib/shared.do:L684:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 8 63"' // WFLOG-INJECTED
global WFRD1097 `"end "rd2017/lib/shared.do:L684:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 8 63"' // WFLOG-INJECTED
global WFRD1098 `"start "rd2017/lib/shared.do:L685:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 9 63"' // WFLOG-INJECTED
global WFRD1099 `"end "rd2017/lib/shared.do:L685:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 9 63"' // WFLOG-INJECTED
global WFRD1100 `"start "rd2017/lib/shared.do:L686:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 10 63"' // WFLOG-INJECTED
global WFRD1101 `"end "rd2017/lib/shared.do:L686:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 10 63"' // WFLOG-INJECTED
global WFRD1102 `"start "rd2017/lib/shared.do:L687:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 11 63"' // WFLOG-INJECTED
global WFRD1103 `"end "rd2017/lib/shared.do:L687:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 11 63"' // WFLOG-INJECTED
global WFRD1104 `"start "rd2017/lib/shared.do:L688:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 12 63"' // WFLOG-INJECTED
global WFRD1105 `"end "rd2017/lib/shared.do:L688:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 12 63"' // WFLOG-INJECTED
global WFRD1106 `"start "rd2017/lib/shared.do:L689:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 13 63"' // WFLOG-INJECTED
global WFRD1107 `"end "rd2017/lib/shared.do:L689:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 13 63"' // WFLOG-INJECTED
global WFRD1108 `"start "rd2017/lib/shared.do:L690:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 14 63"' // WFLOG-INJECTED
global WFRD1109 `"end "rd2017/lib/shared.do:L690:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 14 63"' // WFLOG-INJECTED
global WFRD1110 `"start "rd2017/lib/shared.do:L691:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 15 63"' // WFLOG-INJECTED
global WFRD1111 `"end "rd2017/lib/shared.do:L691:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 15 63"' // WFLOG-INJECTED
global WFRD1112 `"start "rd2017/lib/shared.do:L692:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 16 63"' // WFLOG-INJECTED
global WFRD1113 `"end "rd2017/lib/shared.do:L692:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 16 63"' // WFLOG-INJECTED
global WFRD1114 `"start "rd2017/lib/shared.do:L693:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 17 63"' // WFLOG-INJECTED
global WFRD1115 `"end "rd2017/lib/shared.do:L693:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 17 63"' // WFLOG-INJECTED
global WFRD1116 `"start "rd2017/lib/shared.do:L694:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 18 63"' // WFLOG-INJECTED
global WFRD1117 `"end "rd2017/lib/shared.do:L694:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 18 63"' // WFLOG-INJECTED
global WFRD1118 `"start "rd2017/lib/shared.do:L695:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 19 63"' // WFLOG-INJECTED
global WFRD1119 `"end "rd2017/lib/shared.do:L695:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 19 63"' // WFLOG-INJECTED
global WFRD1120 `"start "rd2017/lib/shared.do:L696:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 20 63"' // WFLOG-INJECTED
global WFRD1121 `"end "rd2017/lib/shared.do:L696:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 20 63"' // WFLOG-INJECTED
global WFRD1122 `"start "rd2017/lib/shared.do:L697:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 21 63"' // WFLOG-INJECTED
global WFRD1123 `"end "rd2017/lib/shared.do:L697:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 21 63"' // WFLOG-INJECTED
global WFRD1124 `"start "rd2017/lib/shared.do:L698:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 22 63"' // WFLOG-INJECTED
global WFRD1125 `"end "rd2017/lib/shared.do:L698:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 22 63"' // WFLOG-INJECTED
global WFRD1126 `"start "rd2017/lib/shared.do:L699:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 23 63"' // WFLOG-INJECTED
global WFRD1127 `"end "rd2017/lib/shared.do:L699:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 23 63"' // WFLOG-INJECTED
global WFRD1128 `"start "rd2017/lib/shared.do:L700:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 24 63"' // WFLOG-INJECTED
global WFRD1129 `"end "rd2017/lib/shared.do:L700:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 24 63"' // WFLOG-INJECTED
global WFRD1130 `"start "rd2017/lib/shared.do:L701:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 25 63"' // WFLOG-INJECTED
global WFRD1131 `"end "rd2017/lib/shared.do:L701:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 25 63"' // WFLOG-INJECTED
global WFRD1132 `"start "rd2017/lib/shared.do:L702:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 26 63"' // WFLOG-INJECTED
global WFRD1133 `"end "rd2017/lib/shared.do:L702:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 26 63"' // WFLOG-INJECTED
global WFRD1134 `"start "rd2017/lib/shared.do:L703:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 27 63"' // WFLOG-INJECTED
global WFRD1135 `"end "rd2017/lib/shared.do:L703:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 27 63"' // WFLOG-INJECTED
global WFRD1136 `"start "rd2017/lib/shared.do:L704:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 28 63"' // WFLOG-INJECTED
global WFRD1137 `"end "rd2017/lib/shared.do:L704:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 28 63"' // WFLOG-INJECTED
global WFRD1138 `"start "rd2017/lib/shared.do:L705:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 29 63"' // WFLOG-INJECTED
global WFRD1139 `"end "rd2017/lib/shared.do:L705:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 29 63"' // WFLOG-INJECTED
global WFRD1140 `"start "rd2017/lib/shared.do:L706:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 30 63"' // WFLOG-INJECTED
global WFRD1141 `"end "rd2017/lib/shared.do:L706:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 30 63"' // WFLOG-INJECTED
global WFRD1142 `"start "rd2017/lib/shared.do:L707:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 31 63"' // WFLOG-INJECTED
global WFRD1143 `"end "rd2017/lib/shared.do:L707:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 31 63"' // WFLOG-INJECTED
global WFRD1144 `"start "rd2017/lib/shared.do:L708:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 32 63"' // WFLOG-INJECTED
global WFRD1145 `"end "rd2017/lib/shared.do:L708:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 32 63"' // WFLOG-INJECTED
global WFRD1146 `"start "rd2017/lib/shared.do:L709:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 33 63"' // WFLOG-INJECTED
global WFRD1147 `"end "rd2017/lib/shared.do:L709:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 33 63"' // WFLOG-INJECTED
global WFRD1148 `"start "rd2017/lib/shared.do:L710:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 34 63"' // WFLOG-INJECTED
global WFRD1149 `"end "rd2017/lib/shared.do:L710:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 34 63"' // WFLOG-INJECTED
global WFRD1150 `"start "rd2017/lib/shared.do:L711:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 35 63"' // WFLOG-INJECTED
global WFRD1151 `"end "rd2017/lib/shared.do:L711:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 35 63"' // WFLOG-INJECTED
global WFRD1152 `"start "rd2017/lib/shared.do:L712:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 36 63"' // WFLOG-INJECTED
global WFRD1153 `"end "rd2017/lib/shared.do:L712:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 36 63"' // WFLOG-INJECTED
global WFRD1154 `"start "rd2017/lib/shared.do:L713:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 37 63"' // WFLOG-INJECTED
global WFRD1155 `"end "rd2017/lib/shared.do:L713:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 37 63"' // WFLOG-INJECTED
global WFRD1156 `"start "rd2017/lib/shared.do:L714:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 38 63"' // WFLOG-INJECTED
global WFRD1157 `"end "rd2017/lib/shared.do:L714:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 38 63"' // WFLOG-INJECTED
global WFRD1158 `"start "rd2017/lib/shared.do:L715:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 39 63"' // WFLOG-INJECTED
global WFRD1159 `"end "rd2017/lib/shared.do:L715:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 39 63"' // WFLOG-INJECTED
global WFRD1160 `"start "rd2017/lib/shared.do:L716:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 40 63"' // WFLOG-INJECTED
global WFRD1161 `"end "rd2017/lib/shared.do:L716:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 40 63"' // WFLOG-INJECTED
global WFRD1162 `"start "rd2017/lib/shared.do:L717:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 41 63"' // WFLOG-INJECTED
global WFRD1163 `"end "rd2017/lib/shared.do:L717:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 41 63"' // WFLOG-INJECTED
global WFRD1164 `"start "rd2017/lib/shared.do:L718:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 42 63"' // WFLOG-INJECTED
global WFRD1165 `"end "rd2017/lib/shared.do:L718:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 42 63"' // WFLOG-INJECTED
global WFRD1166 `"start "rd2017/lib/shared.do:L719:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 43 63"' // WFLOG-INJECTED
global WFRD1167 `"end "rd2017/lib/shared.do:L719:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 43 63"' // WFLOG-INJECTED
global WFRD1168 `"start "rd2017/lib/shared.do:L720:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 44 63"' // WFLOG-INJECTED
global WFRD1169 `"end "rd2017/lib/shared.do:L720:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 44 63"' // WFLOG-INJECTED
global WFRD1170 `"start "rd2017/lib/shared.do:L721:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 45 63"' // WFLOG-INJECTED
global WFRD1171 `"end "rd2017/lib/shared.do:L721:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 45 63"' // WFLOG-INJECTED
global WFRD1172 `"start "rd2017/lib/shared.do:L722:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 46 63"' // WFLOG-INJECTED
global WFRD1173 `"end "rd2017/lib/shared.do:L722:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 46 63"' // WFLOG-INJECTED
global WFRD1174 `"start "rd2017/lib/shared.do:L723:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 47 63"' // WFLOG-INJECTED
global WFRD1175 `"end "rd2017/lib/shared.do:L723:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 47 63"' // WFLOG-INJECTED
global WFRD1176 `"start "rd2017/lib/shared.do:L724:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 48 63"' // WFLOG-INJECTED
global WFRD1177 `"end "rd2017/lib/shared.do:L724:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 48 63"' // WFLOG-INJECTED
global WFRD1178 `"start "rd2017/lib/shared.do:L725:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 49 63"' // WFLOG-INJECTED
global WFRD1179 `"end "rd2017/lib/shared.do:L725:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 49 63"' // WFLOG-INJECTED
global WFRD1180 `"start "rd2017/lib/shared.do:L726:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 50 63"' // WFLOG-INJECTED
global WFRD1181 `"end "rd2017/lib/shared.do:L726:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 50 63"' // WFLOG-INJECTED
global WFRD1182 `"start "rd2017/lib/shared.do:L727:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 51 63"' // WFLOG-INJECTED
global WFRD1183 `"end "rd2017/lib/shared.do:L727:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 51 63"' // WFLOG-INJECTED
global WFRD1184 `"start "rd2017/lib/shared.do:L728:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 52 63"' // WFLOG-INJECTED
global WFRD1185 `"end "rd2017/lib/shared.do:L728:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 52 63"' // WFLOG-INJECTED
global WFRD1186 `"start "rd2017/lib/shared.do:L729:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 53 63"' // WFLOG-INJECTED
global WFRD1187 `"end "rd2017/lib/shared.do:L729:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 53 63"' // WFLOG-INJECTED
global WFRD1188 `"start "rd2017/lib/shared.do:L730:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 54 63"' // WFLOG-INJECTED
global WFRD1189 `"end "rd2017/lib/shared.do:L730:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 54 63"' // WFLOG-INJECTED
global WFRD1190 `"start "rd2017/lib/shared.do:L731:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 55 63"' // WFLOG-INJECTED
global WFRD1191 `"end "rd2017/lib/shared.do:L731:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 55 63"' // WFLOG-INJECTED
global WFRD1192 `"start "rd2017/lib/shared.do:L732:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 56 63"' // WFLOG-INJECTED
global WFRD1193 `"end "rd2017/lib/shared.do:L732:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 56 63"' // WFLOG-INJECTED
global WFRD1194 `"start "rd2017/lib/shared.do:L733:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 57 63"' // WFLOG-INJECTED
global WFRD1195 `"end "rd2017/lib/shared.do:L733:step-rename" "rd2017/lib/shared.do:L676:block-body" "statement" 57 63"' // WFLOG-INJECTED
global WFRD1196 `"start "rd2017/lib/shared.do:L734:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 58 63"' // WFLOG-INJECTED
global WFRD1197 `"end "rd2017/lib/shared.do:L734:step-generate" "rd2017/lib/shared.do:L676:block-body" "statement" 58 63"' // WFLOG-INJECTED
global WFRD1198 `"start "rd2017/lib/shared.do:L735:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 59 63"' // WFLOG-INJECTED
global WFRD1199 `"end "rd2017/lib/shared.do:L735:step-assert" "rd2017/lib/shared.do:L676:block-body" "statement" 59 63"' // WFLOG-INJECTED
global WFRD1200 `"start "rd2017/lib/shared.do:L736:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 60 63"' // WFLOG-INJECTED
global WFRD1201 `"end "rd2017/lib/shared.do:L736:step-drop" "rd2017/lib/shared.do:L676:block-body" "statement" 60 63"' // WFLOG-INJECTED
global WFRD1202 `"start "rd2017/lib/shared.do:L737:step-order" "rd2017/lib/shared.do:L676:block-body" "statement" 61 63"' // WFLOG-INJECTED
global WFRD1203 `"end "rd2017/lib/shared.do:L737:step-order" "rd2017/lib/shared.do:L676:block-body" "statement" 61 63"' // WFLOG-INJECTED
global WFRD1204 `"start "rd2017/lib/shared.do:L738:step-rd17_schema" "rd2017/lib/shared.do:L676:block-body" "statement" 62 63"' // WFLOG-INJECTED
global WFRD1205 `"end "rd2017/lib/shared.do:L738:step-rd17_schema" "rd2017/lib/shared.do:L676:block-body" "statement" 62 63"' // WFLOG-INJECTED
global WFRD1206 `"start "rd2017/lib/shared.do:L739:step-exit" "rd2017/lib/shared.do:L676:block-body" "statement" 63 63"' // WFLOG-INJECTED
global WFRD1207 `"end "rd2017/lib/shared.do:L739:step-exit" "rd2017/lib/shared.do:L676:block-body" "statement" 63 63"' // WFLOG-INJECTED
global WFRD1208 `"end "rd2017/lib/shared.do:L676:block-body" "rd2017/lib/shared.do:L676:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1209 `"end "rd2017/lib/shared.do:L676:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 14 19"' // WFLOG-INJECTED
global WFRD1210 `"start "rd2017/lib/shared.do:L741:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 15 19"' // WFLOG-INJECTED
global WFRD1211 `"start "rd2017/lib/shared.do:L741:block-body" "rd2017/lib/shared.do:L741:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1212 `"start "rd2017/lib/shared.do:L742:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 1 13"' // WFLOG-INJECTED
global WFRD1213 `"end "rd2017/lib/shared.do:L742:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 1 13"' // WFLOG-INJECTED
global WFRD1214 `"start "rd2017/lib/shared.do:L743:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 2 13"' // WFLOG-INJECTED
global WFRD1215 `"end "rd2017/lib/shared.do:L743:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 2 13"' // WFLOG-INJECTED
global WFRD1216 `"start "rd2017/lib/shared.do:L744:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 3 13"' // WFLOG-INJECTED
global WFRD1217 `"end "rd2017/lib/shared.do:L744:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 3 13"' // WFLOG-INJECTED
global WFRD1218 `"start "rd2017/lib/shared.do:L745:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 4 13"' // WFLOG-INJECTED
global WFRD1219 `"end "rd2017/lib/shared.do:L745:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 4 13"' // WFLOG-INJECTED
global WFRD1220 `"start "rd2017/lib/shared.do:L746:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 5 13"' // WFLOG-INJECTED
global WFRD1221 `"end "rd2017/lib/shared.do:L746:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 5 13"' // WFLOG-INJECTED
global WFRD1222 `"start "rd2017/lib/shared.do:L747:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 6 13"' // WFLOG-INJECTED
global WFRD1223 `"end "rd2017/lib/shared.do:L747:step-recast" "rd2017/lib/shared.do:L741:block-body" "statement" 6 13"' // WFLOG-INJECTED
global WFRD1224 `"start "rd2017/lib/shared.do:L748:step-rename" "rd2017/lib/shared.do:L741:block-body" "statement" 7 13"' // WFLOG-INJECTED
global WFRD1225 `"end "rd2017/lib/shared.do:L748:step-rename" "rd2017/lib/shared.do:L741:block-body" "statement" 7 13"' // WFLOG-INJECTED
global WFRD1226 `"start "rd2017/lib/shared.do:L749:step-generate" "rd2017/lib/shared.do:L741:block-body" "statement" 8 13"' // WFLOG-INJECTED
global WFRD1227 `"end "rd2017/lib/shared.do:L749:step-generate" "rd2017/lib/shared.do:L741:block-body" "statement" 8 13"' // WFLOG-INJECTED
global WFRD1228 `"start "rd2017/lib/shared.do:L750:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 9 13"' // WFLOG-INJECTED
global WFRD1229 `"end "rd2017/lib/shared.do:L750:step-assert" "rd2017/lib/shared.do:L741:block-body" "statement" 9 13"' // WFLOG-INJECTED
global WFRD1230 `"start "rd2017/lib/shared.do:L751:step-drop" "rd2017/lib/shared.do:L741:block-body" "statement" 10 13"' // WFLOG-INJECTED
global WFRD1231 `"end "rd2017/lib/shared.do:L751:step-drop" "rd2017/lib/shared.do:L741:block-body" "statement" 10 13"' // WFLOG-INJECTED
global WFRD1232 `"start "rd2017/lib/shared.do:L752:step-order" "rd2017/lib/shared.do:L741:block-body" "statement" 11 13"' // WFLOG-INJECTED
global WFRD1233 `"end "rd2017/lib/shared.do:L752:step-order" "rd2017/lib/shared.do:L741:block-body" "statement" 11 13"' // WFLOG-INJECTED
global WFRD1234 `"start "rd2017/lib/shared.do:L753:step-rd17_schema" "rd2017/lib/shared.do:L741:block-body" "statement" 12 13"' // WFLOG-INJECTED
global WFRD1235 `"end "rd2017/lib/shared.do:L753:step-rd17_schema" "rd2017/lib/shared.do:L741:block-body" "statement" 12 13"' // WFLOG-INJECTED
global WFRD1236 `"start "rd2017/lib/shared.do:L754:step-exit" "rd2017/lib/shared.do:L741:block-body" "statement" 13 13"' // WFLOG-INJECTED
global WFRD1237 `"end "rd2017/lib/shared.do:L754:step-exit" "rd2017/lib/shared.do:L741:block-body" "statement" 13 13"' // WFLOG-INJECTED
global WFRD1238 `"end "rd2017/lib/shared.do:L741:block-body" "rd2017/lib/shared.do:L741:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1239 `"end "rd2017/lib/shared.do:L741:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 15 19"' // WFLOG-INJECTED
global WFRD1240 `"start "rd2017/lib/shared.do:L756:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 16 19"' // WFLOG-INJECTED
global WFRD1241 `"start "rd2017/lib/shared.do:L756:block-body" "rd2017/lib/shared.do:L756:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1242 `"start "rd2017/lib/shared.do:L757:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 1 31"' // WFLOG-INJECTED
global WFRD1243 `"end "rd2017/lib/shared.do:L757:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 1 31"' // WFLOG-INJECTED
global WFRD1244 `"start "rd2017/lib/shared.do:L758:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 2 31"' // WFLOG-INJECTED
global WFRD1245 `"end "rd2017/lib/shared.do:L758:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 2 31"' // WFLOG-INJECTED
global WFRD1246 `"start "rd2017/lib/shared.do:L759:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 3 31"' // WFLOG-INJECTED
global WFRD1247 `"end "rd2017/lib/shared.do:L759:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 3 31"' // WFLOG-INJECTED
global WFRD1248 `"start "rd2017/lib/shared.do:L760:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 4 31"' // WFLOG-INJECTED
global WFRD1249 `"end "rd2017/lib/shared.do:L760:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 4 31"' // WFLOG-INJECTED
global WFRD1250 `"start "rd2017/lib/shared.do:L761:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 5 31"' // WFLOG-INJECTED
global WFRD1251 `"end "rd2017/lib/shared.do:L761:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 5 31"' // WFLOG-INJECTED
global WFRD1252 `"start "rd2017/lib/shared.do:L762:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 6 31"' // WFLOG-INJECTED
global WFRD1253 `"end "rd2017/lib/shared.do:L762:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 6 31"' // WFLOG-INJECTED
global WFRD1254 `"start "rd2017/lib/shared.do:L763:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 7 31"' // WFLOG-INJECTED
global WFRD1255 `"end "rd2017/lib/shared.do:L763:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 7 31"' // WFLOG-INJECTED
global WFRD1256 `"start "rd2017/lib/shared.do:L764:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 8 31"' // WFLOG-INJECTED
global WFRD1257 `"end "rd2017/lib/shared.do:L764:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 8 31"' // WFLOG-INJECTED
global WFRD1258 `"start "rd2017/lib/shared.do:L765:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 9 31"' // WFLOG-INJECTED
global WFRD1259 `"end "rd2017/lib/shared.do:L765:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 9 31"' // WFLOG-INJECTED
global WFRD1260 `"start "rd2017/lib/shared.do:L766:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 10 31"' // WFLOG-INJECTED
global WFRD1261 `"end "rd2017/lib/shared.do:L766:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 10 31"' // WFLOG-INJECTED
global WFRD1262 `"start "rd2017/lib/shared.do:L767:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 11 31"' // WFLOG-INJECTED
global WFRD1263 `"end "rd2017/lib/shared.do:L767:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 11 31"' // WFLOG-INJECTED
global WFRD1264 `"start "rd2017/lib/shared.do:L768:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 12 31"' // WFLOG-INJECTED
global WFRD1265 `"end "rd2017/lib/shared.do:L768:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 12 31"' // WFLOG-INJECTED
global WFRD1266 `"start "rd2017/lib/shared.do:L769:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 13 31"' // WFLOG-INJECTED
global WFRD1267 `"end "rd2017/lib/shared.do:L769:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 13 31"' // WFLOG-INJECTED
global WFRD1268 `"start "rd2017/lib/shared.do:L770:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 14 31"' // WFLOG-INJECTED
global WFRD1269 `"end "rd2017/lib/shared.do:L770:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 14 31"' // WFLOG-INJECTED
global WFRD1270 `"start "rd2017/lib/shared.do:L771:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 15 31"' // WFLOG-INJECTED
global WFRD1271 `"end "rd2017/lib/shared.do:L771:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 15 31"' // WFLOG-INJECTED
global WFRD1272 `"start "rd2017/lib/shared.do:L772:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 16 31"' // WFLOG-INJECTED
global WFRD1273 `"end "rd2017/lib/shared.do:L772:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 16 31"' // WFLOG-INJECTED
global WFRD1274 `"start "rd2017/lib/shared.do:L773:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 17 31"' // WFLOG-INJECTED
global WFRD1275 `"end "rd2017/lib/shared.do:L773:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 17 31"' // WFLOG-INJECTED
global WFRD1276 `"start "rd2017/lib/shared.do:L774:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 18 31"' // WFLOG-INJECTED
global WFRD1277 `"end "rd2017/lib/shared.do:L774:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 18 31"' // WFLOG-INJECTED
global WFRD1278 `"start "rd2017/lib/shared.do:L775:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 19 31"' // WFLOG-INJECTED
global WFRD1279 `"end "rd2017/lib/shared.do:L775:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 19 31"' // WFLOG-INJECTED
global WFRD1280 `"start "rd2017/lib/shared.do:L776:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 20 31"' // WFLOG-INJECTED
global WFRD1281 `"end "rd2017/lib/shared.do:L776:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 20 31"' // WFLOG-INJECTED
global WFRD1282 `"start "rd2017/lib/shared.do:L777:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 21 31"' // WFLOG-INJECTED
global WFRD1283 `"end "rd2017/lib/shared.do:L777:step-rename" "rd2017/lib/shared.do:L756:block-body" "statement" 21 31"' // WFLOG-INJECTED
global WFRD1284 `"start "rd2017/lib/shared.do:L778:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 22 31"' // WFLOG-INJECTED
global WFRD1285 `"end "rd2017/lib/shared.do:L778:step-generate" "rd2017/lib/shared.do:L756:block-body" "statement" 22 31"' // WFLOG-INJECTED
global WFRD1286 `"start "rd2017/lib/shared.do:L779:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 23 31"' // WFLOG-INJECTED
global WFRD1287 `"end "rd2017/lib/shared.do:L779:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 23 31"' // WFLOG-INJECTED
global WFRD1288 `"start "rd2017/lib/shared.do:L780:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 24 31"' // WFLOG-INJECTED
global WFRD1289 `"end "rd2017/lib/shared.do:L780:step-drop" "rd2017/lib/shared.do:L756:block-body" "statement" 24 31"' // WFLOG-INJECTED
global WFRD1290 `"start "rd2017/lib/shared.do:L781:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 25 31"' // WFLOG-INJECTED
global WFRD1291 `"end "rd2017/lib/shared.do:L781:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 25 31"' // WFLOG-INJECTED
global WFRD1292 `"start "rd2017/lib/shared.do:L782:step-recast" "rd2017/lib/shared.do:L756:block-body" "statement" 26 31"' // WFLOG-INJECTED
global WFRD1293 `"end "rd2017/lib/shared.do:L782:step-recast" "rd2017/lib/shared.do:L756:block-body" "statement" 26 31"' // WFLOG-INJECTED
global WFRD1294 `"start "rd2017/lib/shared.do:L783:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 27 31"' // WFLOG-INJECTED
global WFRD1295 `"end "rd2017/lib/shared.do:L783:step-assert" "rd2017/lib/shared.do:L756:block-body" "statement" 27 31"' // WFLOG-INJECTED
global WFRD1296 `"start "rd2017/lib/shared.do:L784:step-recast" "rd2017/lib/shared.do:L756:block-body" "statement" 28 31"' // WFLOG-INJECTED
global WFRD1297 `"end "rd2017/lib/shared.do:L784:step-recast" "rd2017/lib/shared.do:L756:block-body" "statement" 28 31"' // WFLOG-INJECTED
global WFRD1298 `"start "rd2017/lib/shared.do:L785:step-order" "rd2017/lib/shared.do:L756:block-body" "statement" 29 31"' // WFLOG-INJECTED
global WFRD1299 `"end "rd2017/lib/shared.do:L785:step-order" "rd2017/lib/shared.do:L756:block-body" "statement" 29 31"' // WFLOG-INJECTED
global WFRD1300 `"start "rd2017/lib/shared.do:L786:step-rd17_schema" "rd2017/lib/shared.do:L756:block-body" "statement" 30 31"' // WFLOG-INJECTED
global WFRD1301 `"end "rd2017/lib/shared.do:L786:step-rd17_schema" "rd2017/lib/shared.do:L756:block-body" "statement" 30 31"' // WFLOG-INJECTED
global WFRD1302 `"start "rd2017/lib/shared.do:L787:step-exit" "rd2017/lib/shared.do:L756:block-body" "statement" 31 31"' // WFLOG-INJECTED
global WFRD1303 `"end "rd2017/lib/shared.do:L787:step-exit" "rd2017/lib/shared.do:L756:block-body" "statement" 31 31"' // WFLOG-INJECTED
global WFRD1304 `"end "rd2017/lib/shared.do:L756:block-body" "rd2017/lib/shared.do:L756:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1305 `"end "rd2017/lib/shared.do:L756:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 16 19"' // WFLOG-INJECTED
global WFRD1306 `"start "rd2017/lib/shared.do:L789:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 17 19"' // WFLOG-INJECTED
global WFRD1307 `"start "rd2017/lib/shared.do:L789:block-body" "rd2017/lib/shared.do:L789:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1308 `"start "rd2017/lib/shared.do:L790:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 1 35"' // WFLOG-INJECTED
global WFRD1309 `"end "rd2017/lib/shared.do:L790:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 1 35"' // WFLOG-INJECTED
global WFRD1310 `"start "rd2017/lib/shared.do:L791:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 2 35"' // WFLOG-INJECTED
global WFRD1311 `"end "rd2017/lib/shared.do:L791:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 2 35"' // WFLOG-INJECTED
global WFRD1312 `"start "rd2017/lib/shared.do:L792:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 3 35"' // WFLOG-INJECTED
global WFRD1313 `"end "rd2017/lib/shared.do:L792:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 3 35"' // WFLOG-INJECTED
global WFRD1314 `"start "rd2017/lib/shared.do:L793:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 4 35"' // WFLOG-INJECTED
global WFRD1315 `"end "rd2017/lib/shared.do:L793:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 4 35"' // WFLOG-INJECTED
global WFRD1316 `"start "rd2017/lib/shared.do:L794:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 5 35"' // WFLOG-INJECTED
global WFRD1317 `"end "rd2017/lib/shared.do:L794:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 5 35"' // WFLOG-INJECTED
global WFRD1318 `"start "rd2017/lib/shared.do:L795:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 6 35"' // WFLOG-INJECTED
global WFRD1319 `"end "rd2017/lib/shared.do:L795:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 6 35"' // WFLOG-INJECTED
global WFRD1320 `"start "rd2017/lib/shared.do:L796:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 7 35"' // WFLOG-INJECTED
global WFRD1321 `"end "rd2017/lib/shared.do:L796:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 7 35"' // WFLOG-INJECTED
global WFRD1322 `"start "rd2017/lib/shared.do:L797:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 8 35"' // WFLOG-INJECTED
global WFRD1323 `"end "rd2017/lib/shared.do:L797:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 8 35"' // WFLOG-INJECTED
global WFRD1324 `"start "rd2017/lib/shared.do:L798:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 9 35"' // WFLOG-INJECTED
global WFRD1325 `"end "rd2017/lib/shared.do:L798:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 9 35"' // WFLOG-INJECTED
global WFRD1326 `"start "rd2017/lib/shared.do:L799:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 10 35"' // WFLOG-INJECTED
global WFRD1327 `"end "rd2017/lib/shared.do:L799:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 10 35"' // WFLOG-INJECTED
global WFRD1328 `"start "rd2017/lib/shared.do:L800:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 11 35"' // WFLOG-INJECTED
global WFRD1329 `"end "rd2017/lib/shared.do:L800:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 11 35"' // WFLOG-INJECTED
global WFRD1330 `"start "rd2017/lib/shared.do:L801:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 12 35"' // WFLOG-INJECTED
global WFRD1331 `"end "rd2017/lib/shared.do:L801:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 12 35"' // WFLOG-INJECTED
global WFRD1332 `"start "rd2017/lib/shared.do:L802:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 13 35"' // WFLOG-INJECTED
global WFRD1333 `"end "rd2017/lib/shared.do:L802:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 13 35"' // WFLOG-INJECTED
global WFRD1334 `"start "rd2017/lib/shared.do:L803:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 14 35"' // WFLOG-INJECTED
global WFRD1335 `"end "rd2017/lib/shared.do:L803:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 14 35"' // WFLOG-INJECTED
global WFRD1336 `"start "rd2017/lib/shared.do:L804:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 15 35"' // WFLOG-INJECTED
global WFRD1337 `"end "rd2017/lib/shared.do:L804:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 15 35"' // WFLOG-INJECTED
global WFRD1338 `"start "rd2017/lib/shared.do:L805:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 16 35"' // WFLOG-INJECTED
global WFRD1339 `"end "rd2017/lib/shared.do:L805:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 16 35"' // WFLOG-INJECTED
global WFRD1340 `"start "rd2017/lib/shared.do:L806:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 17 35"' // WFLOG-INJECTED
global WFRD1341 `"end "rd2017/lib/shared.do:L806:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 17 35"' // WFLOG-INJECTED
global WFRD1342 `"start "rd2017/lib/shared.do:L807:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 18 35"' // WFLOG-INJECTED
global WFRD1343 `"end "rd2017/lib/shared.do:L807:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 18 35"' // WFLOG-INJECTED
global WFRD1344 `"start "rd2017/lib/shared.do:L808:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 19 35"' // WFLOG-INJECTED
global WFRD1345 `"end "rd2017/lib/shared.do:L808:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 19 35"' // WFLOG-INJECTED
global WFRD1346 `"start "rd2017/lib/shared.do:L809:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 20 35"' // WFLOG-INJECTED
global WFRD1347 `"end "rd2017/lib/shared.do:L809:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 20 35"' // WFLOG-INJECTED
global WFRD1348 `"start "rd2017/lib/shared.do:L810:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 21 35"' // WFLOG-INJECTED
global WFRD1349 `"end "rd2017/lib/shared.do:L810:step-rename" "rd2017/lib/shared.do:L789:block-body" "statement" 21 35"' // WFLOG-INJECTED
global WFRD1350 `"start "rd2017/lib/shared.do:L811:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 22 35"' // WFLOG-INJECTED
global WFRD1351 `"end "rd2017/lib/shared.do:L811:step-generate" "rd2017/lib/shared.do:L789:block-body" "statement" 22 35"' // WFLOG-INJECTED
global WFRD1352 `"start "rd2017/lib/shared.do:L812:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 23 35"' // WFLOG-INJECTED
global WFRD1353 `"end "rd2017/lib/shared.do:L812:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 23 35"' // WFLOG-INJECTED
global WFRD1354 `"start "rd2017/lib/shared.do:L813:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 24 35"' // WFLOG-INJECTED
global WFRD1355 `"end "rd2017/lib/shared.do:L813:step-drop" "rd2017/lib/shared.do:L789:block-body" "statement" 24 35"' // WFLOG-INJECTED
global WFRD1356 `"start "rd2017/lib/shared.do:L814:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 25 35"' // WFLOG-INJECTED
global WFRD1357 `"end "rd2017/lib/shared.do:L814:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 25 35"' // WFLOG-INJECTED
global WFRD1358 `"start "rd2017/lib/shared.do:L815:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 26 35"' // WFLOG-INJECTED
global WFRD1359 `"end "rd2017/lib/shared.do:L815:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 26 35"' // WFLOG-INJECTED
global WFRD1360 `"start "rd2017/lib/shared.do:L816:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 27 35"' // WFLOG-INJECTED
global WFRD1361 `"end "rd2017/lib/shared.do:L816:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 27 35"' // WFLOG-INJECTED
global WFRD1362 `"start "rd2017/lib/shared.do:L817:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 28 35"' // WFLOG-INJECTED
global WFRD1363 `"end "rd2017/lib/shared.do:L817:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 28 35"' // WFLOG-INJECTED
global WFRD1364 `"start "rd2017/lib/shared.do:L818:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 29 35"' // WFLOG-INJECTED
global WFRD1365 `"end "rd2017/lib/shared.do:L818:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 29 35"' // WFLOG-INJECTED
global WFRD1366 `"start "rd2017/lib/shared.do:L819:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 30 35"' // WFLOG-INJECTED
global WFRD1367 `"end "rd2017/lib/shared.do:L819:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 30 35"' // WFLOG-INJECTED
global WFRD1368 `"start "rd2017/lib/shared.do:L820:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 31 35"' // WFLOG-INJECTED
global WFRD1369 `"end "rd2017/lib/shared.do:L820:step-assert" "rd2017/lib/shared.do:L789:block-body" "statement" 31 35"' // WFLOG-INJECTED
global WFRD1370 `"start "rd2017/lib/shared.do:L821:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 32 35"' // WFLOG-INJECTED
global WFRD1371 `"end "rd2017/lib/shared.do:L821:step-recast" "rd2017/lib/shared.do:L789:block-body" "statement" 32 35"' // WFLOG-INJECTED
global WFRD1372 `"start "rd2017/lib/shared.do:L822:step-order" "rd2017/lib/shared.do:L789:block-body" "statement" 33 35"' // WFLOG-INJECTED
global WFRD1373 `"end "rd2017/lib/shared.do:L822:step-order" "rd2017/lib/shared.do:L789:block-body" "statement" 33 35"' // WFLOG-INJECTED
global WFRD1374 `"start "rd2017/lib/shared.do:L823:step-rd17_schema" "rd2017/lib/shared.do:L789:block-body" "statement" 34 35"' // WFLOG-INJECTED
global WFRD1375 `"end "rd2017/lib/shared.do:L823:step-rd17_schema" "rd2017/lib/shared.do:L789:block-body" "statement" 34 35"' // WFLOG-INJECTED
global WFRD1376 `"start "rd2017/lib/shared.do:L824:step-exit" "rd2017/lib/shared.do:L789:block-body" "statement" 35 35"' // WFLOG-INJECTED
global WFRD1377 `"end "rd2017/lib/shared.do:L824:step-exit" "rd2017/lib/shared.do:L789:block-body" "statement" 35 35"' // WFLOG-INJECTED
global WFRD1378 `"end "rd2017/lib/shared.do:L789:block-body" "rd2017/lib/shared.do:L789:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1379 `"end "rd2017/lib/shared.do:L789:step-if" "rd2017/lib/shared.do:L136:program-body" "statement" 17 19"' // WFLOG-INJECTED
global WFRD1380 `"start "rd2017/lib/shared.do:L826:step-display" "rd2017/lib/shared.do:L136:program-body" "statement" 18 19"' // WFLOG-INJECTED
global WFRD1381 `"end "rd2017/lib/shared.do:L826:step-display" "rd2017/lib/shared.do:L136:program-body" "statement" 18 19"' // WFLOG-INJECTED
global WFRD1382 `"start "rd2017/lib/shared.do:L827:step-exit" "rd2017/lib/shared.do:L136:program-body" "statement" 19 19"' // WFLOG-INJECTED
global WFRD1383 `"end "rd2017/lib/shared.do:L827:step-exit" "rd2017/lib/shared.do:L136:program-body" "statement" 19 19"' // WFLOG-INJECTED
global WFRD1384 `"end "rd2017/lib/shared.do:L136:program-body" "" "program" 1 1"' // WFLOG-INJECTED
global WFRD1385 `"start "rd2017/lib/shared.do:L831:program-body" "" "program" 1 1"' // WFLOG-INJECTED
global WFRD1386 `"start "rd2017/lib/shared.do:L832:step-syntax" "rd2017/lib/shared.do:L831:program-body" "statement" 1 18"' // WFLOG-INJECTED
global WFRD1387 `"end "rd2017/lib/shared.do:L832:step-syntax" "rd2017/lib/shared.do:L831:program-body" "statement" 1 18"' // WFLOG-INJECTED
global WFRD1388 `"start "rd2017/lib/shared.do:L833:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 2 18"' // WFLOG-INJECTED
global WFRD1389 `"start "rd2017/lib/shared.do:L833:block-body" "rd2017/lib/shared.do:L833:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1390 `"start "rd2017/lib/shared.do:L834:step-unab" "rd2017/lib/shared.do:L833:block-body" "statement" 1 39"' // WFLOG-INJECTED
global WFRD1391 `"end "rd2017/lib/shared.do:L834:step-unab" "rd2017/lib/shared.do:L833:block-body" "statement" 1 39"' // WFLOG-INJECTED
global WFRD1392 `"start "rd2017/lib/shared.do:L835:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 2 39"' // WFLOG-INJECTED
global WFRD1393 `"end "rd2017/lib/shared.do:L835:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 2 39"' // WFLOG-INJECTED
global WFRD1394 `"start "rd2017/lib/shared.do:L836:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 3 39"' // WFLOG-INJECTED
global WFRD1395 `"end "rd2017/lib/shared.do:L836:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 3 39"' // WFLOG-INJECTED
global WFRD1396 `"start "rd2017/lib/shared.do:L837:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 4 39"' // WFLOG-INJECTED
global WFRD1397 `"end "rd2017/lib/shared.do:L837:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 4 39"' // WFLOG-INJECTED
global WFRD1398 `"start "rd2017/lib/shared.do:L838:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 5 39"' // WFLOG-INJECTED
global WFRD1399 `"end "rd2017/lib/shared.do:L838:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 5 39"' // WFLOG-INJECTED
global WFRD1400 `"start "rd2017/lib/shared.do:L839:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 6 39"' // WFLOG-INJECTED
global WFRD1401 `"end "rd2017/lib/shared.do:L839:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 6 39"' // WFLOG-INJECTED
global WFRD1402 `"start "rd2017/lib/shared.do:L840:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 7 39"' // WFLOG-INJECTED
global WFRD1403 `"end "rd2017/lib/shared.do:L840:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 7 39"' // WFLOG-INJECTED
global WFRD1404 `"start "rd2017/lib/shared.do:L841:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 8 39"' // WFLOG-INJECTED
global WFRD1405 `"end "rd2017/lib/shared.do:L841:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 8 39"' // WFLOG-INJECTED
global WFRD1406 `"start "rd2017/lib/shared.do:L842:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 9 39"' // WFLOG-INJECTED
global WFRD1407 `"end "rd2017/lib/shared.do:L842:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 9 39"' // WFLOG-INJECTED
global WFRD1408 `"start "rd2017/lib/shared.do:L843:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 10 39"' // WFLOG-INJECTED
global WFRD1409 `"end "rd2017/lib/shared.do:L843:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 10 39"' // WFLOG-INJECTED
global WFRD1410 `"start "rd2017/lib/shared.do:L844:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 11 39"' // WFLOG-INJECTED
global WFRD1411 `"end "rd2017/lib/shared.do:L844:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 11 39"' // WFLOG-INJECTED
global WFRD1412 `"start "rd2017/lib/shared.do:L845:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 12 39"' // WFLOG-INJECTED
global WFRD1413 `"end "rd2017/lib/shared.do:L845:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 12 39"' // WFLOG-INJECTED
global WFRD1414 `"start "rd2017/lib/shared.do:L846:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 13 39"' // WFLOG-INJECTED
global WFRD1415 `"end "rd2017/lib/shared.do:L846:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 13 39"' // WFLOG-INJECTED
global WFRD1416 `"start "rd2017/lib/shared.do:L847:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 14 39"' // WFLOG-INJECTED
global WFRD1417 `"end "rd2017/lib/shared.do:L847:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 14 39"' // WFLOG-INJECTED
global WFRD1418 `"start "rd2017/lib/shared.do:L848:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 15 39"' // WFLOG-INJECTED
global WFRD1419 `"end "rd2017/lib/shared.do:L848:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 15 39"' // WFLOG-INJECTED
global WFRD1420 `"start "rd2017/lib/shared.do:L849:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 16 39"' // WFLOG-INJECTED
global WFRD1421 `"end "rd2017/lib/shared.do:L849:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 16 39"' // WFLOG-INJECTED
global WFRD1422 `"start "rd2017/lib/shared.do:L850:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 17 39"' // WFLOG-INJECTED
global WFRD1423 `"end "rd2017/lib/shared.do:L850:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 17 39"' // WFLOG-INJECTED
global WFRD1424 `"start "rd2017/lib/shared.do:L851:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 18 39"' // WFLOG-INJECTED
global WFRD1425 `"end "rd2017/lib/shared.do:L851:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 18 39"' // WFLOG-INJECTED
global WFRD1426 `"start "rd2017/lib/shared.do:L852:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 19 39"' // WFLOG-INJECTED
global WFRD1427 `"end "rd2017/lib/shared.do:L852:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 19 39"' // WFLOG-INJECTED
global WFRD1428 `"start "rd2017/lib/shared.do:L853:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 20 39"' // WFLOG-INJECTED
global WFRD1429 `"end "rd2017/lib/shared.do:L853:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 20 39"' // WFLOG-INJECTED
global WFRD1430 `"start "rd2017/lib/shared.do:L854:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 21 39"' // WFLOG-INJECTED
global WFRD1431 `"end "rd2017/lib/shared.do:L854:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 21 39"' // WFLOG-INJECTED
global WFRD1432 `"start "rd2017/lib/shared.do:L855:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 22 39"' // WFLOG-INJECTED
global WFRD1433 `"end "rd2017/lib/shared.do:L855:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 22 39"' // WFLOG-INJECTED
global WFRD1434 `"start "rd2017/lib/shared.do:L856:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 23 39"' // WFLOG-INJECTED
global WFRD1435 `"end "rd2017/lib/shared.do:L856:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 23 39"' // WFLOG-INJECTED
global WFRD1436 `"start "rd2017/lib/shared.do:L857:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 24 39"' // WFLOG-INJECTED
global WFRD1437 `"end "rd2017/lib/shared.do:L857:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 24 39"' // WFLOG-INJECTED
global WFRD1438 `"start "rd2017/lib/shared.do:L858:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 25 39"' // WFLOG-INJECTED
global WFRD1439 `"end "rd2017/lib/shared.do:L858:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 25 39"' // WFLOG-INJECTED
global WFRD1440 `"start "rd2017/lib/shared.do:L859:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 26 39"' // WFLOG-INJECTED
global WFRD1441 `"end "rd2017/lib/shared.do:L859:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 26 39"' // WFLOG-INJECTED
global WFRD1442 `"start "rd2017/lib/shared.do:L860:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 27 39"' // WFLOG-INJECTED
global WFRD1443 `"end "rd2017/lib/shared.do:L860:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 27 39"' // WFLOG-INJECTED
global WFRD1444 `"start "rd2017/lib/shared.do:L861:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 28 39"' // WFLOG-INJECTED
global WFRD1445 `"end "rd2017/lib/shared.do:L861:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 28 39"' // WFLOG-INJECTED
global WFRD1446 `"start "rd2017/lib/shared.do:L862:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 29 39"' // WFLOG-INJECTED
global WFRD1447 `"end "rd2017/lib/shared.do:L862:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 29 39"' // WFLOG-INJECTED
global WFRD1448 `"start "rd2017/lib/shared.do:L863:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 30 39"' // WFLOG-INJECTED
global WFRD1449 `"end "rd2017/lib/shared.do:L863:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 30 39"' // WFLOG-INJECTED
global WFRD1450 `"start "rd2017/lib/shared.do:L864:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 31 39"' // WFLOG-INJECTED
global WFRD1451 `"end "rd2017/lib/shared.do:L864:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 31 39"' // WFLOG-INJECTED
global WFRD1452 `"start "rd2017/lib/shared.do:L865:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 32 39"' // WFLOG-INJECTED
global WFRD1453 `"end "rd2017/lib/shared.do:L865:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 32 39"' // WFLOG-INJECTED
global WFRD1454 `"start "rd2017/lib/shared.do:L866:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 33 39"' // WFLOG-INJECTED
global WFRD1455 `"end "rd2017/lib/shared.do:L866:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 33 39"' // WFLOG-INJECTED
global WFRD1456 `"start "rd2017/lib/shared.do:L867:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 34 39"' // WFLOG-INJECTED
global WFRD1457 `"end "rd2017/lib/shared.do:L867:step-local" "rd2017/lib/shared.do:L833:block-body" "statement" 34 39"' // WFLOG-INJECTED
global WFRD1458 `"start "rd2017/lib/shared.do:L868:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 35 39"' // WFLOG-INJECTED
global WFRD1459 `"end "rd2017/lib/shared.do:L868:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 35 39"' // WFLOG-INJECTED
global WFRD1460 `"start "rd2017/lib/shared.do:L869:step-isid" "rd2017/lib/shared.do:L833:block-body" "statement" 36 39"' // WFLOG-INJECTED
global WFRD1461 `"end "rd2017/lib/shared.do:L869:step-isid" "rd2017/lib/shared.do:L833:block-body" "statement" 36 39"' // WFLOG-INJECTED
global WFRD1462 `"start "rd2017/lib/shared.do:L870:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 37 39"' // WFLOG-INJECTED
global WFRD1463 `"end "rd2017/lib/shared.do:L870:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 37 39"' // WFLOG-INJECTED
global WFRD1464 `"start "rd2017/lib/shared.do:L871:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 38 39"' // WFLOG-INJECTED
global WFRD1465 `"end "rd2017/lib/shared.do:L871:step-assert" "rd2017/lib/shared.do:L833:block-body" "statement" 38 39"' // WFLOG-INJECTED
global WFRD1466 `"start "rd2017/lib/shared.do:L872:step-exit" "rd2017/lib/shared.do:L833:block-body" "statement" 39 39"' // WFLOG-INJECTED
global WFRD1467 `"end "rd2017/lib/shared.do:L872:step-exit" "rd2017/lib/shared.do:L833:block-body" "statement" 39 39"' // WFLOG-INJECTED
global WFRD1468 `"end "rd2017/lib/shared.do:L833:block-body" "rd2017/lib/shared.do:L833:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1469 `"end "rd2017/lib/shared.do:L833:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 2 18"' // WFLOG-INJECTED
global WFRD1470 `"start "rd2017/lib/shared.do:L874:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 3 18"' // WFLOG-INJECTED
global WFRD1471 `"start "rd2017/lib/shared.do:L874:block-body" "rd2017/lib/shared.do:L874:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1472 `"start "rd2017/lib/shared.do:L875:step-unab" "rd2017/lib/shared.do:L874:block-body" "statement" 1 17"' // WFLOG-INJECTED
global WFRD1473 `"end "rd2017/lib/shared.do:L875:step-unab" "rd2017/lib/shared.do:L874:block-body" "statement" 1 17"' // WFLOG-INJECTED
global WFRD1474 `"start "rd2017/lib/shared.do:L876:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 2 17"' // WFLOG-INJECTED
global WFRD1475 `"end "rd2017/lib/shared.do:L876:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 2 17"' // WFLOG-INJECTED
global WFRD1476 `"start "rd2017/lib/shared.do:L877:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 3 17"' // WFLOG-INJECTED
global WFRD1477 `"end "rd2017/lib/shared.do:L877:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 3 17"' // WFLOG-INJECTED
global WFRD1478 `"start "rd2017/lib/shared.do:L878:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 4 17"' // WFLOG-INJECTED
global WFRD1479 `"end "rd2017/lib/shared.do:L878:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 4 17"' // WFLOG-INJECTED
global WFRD1480 `"start "rd2017/lib/shared.do:L879:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 5 17"' // WFLOG-INJECTED
global WFRD1481 `"end "rd2017/lib/shared.do:L879:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 5 17"' // WFLOG-INJECTED
global WFRD1482 `"start "rd2017/lib/shared.do:L880:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 6 17"' // WFLOG-INJECTED
global WFRD1483 `"end "rd2017/lib/shared.do:L880:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 6 17"' // WFLOG-INJECTED
global WFRD1484 `"start "rd2017/lib/shared.do:L881:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 7 17"' // WFLOG-INJECTED
global WFRD1485 `"end "rd2017/lib/shared.do:L881:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 7 17"' // WFLOG-INJECTED
global WFRD1486 `"start "rd2017/lib/shared.do:L882:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 8 17"' // WFLOG-INJECTED
global WFRD1487 `"end "rd2017/lib/shared.do:L882:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 8 17"' // WFLOG-INJECTED
global WFRD1488 `"start "rd2017/lib/shared.do:L883:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 9 17"' // WFLOG-INJECTED
global WFRD1489 `"end "rd2017/lib/shared.do:L883:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 9 17"' // WFLOG-INJECTED
global WFRD1490 `"start "rd2017/lib/shared.do:L884:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 10 17"' // WFLOG-INJECTED
global WFRD1491 `"end "rd2017/lib/shared.do:L884:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 10 17"' // WFLOG-INJECTED
global WFRD1492 `"start "rd2017/lib/shared.do:L885:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 11 17"' // WFLOG-INJECTED
global WFRD1493 `"end "rd2017/lib/shared.do:L885:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 11 17"' // WFLOG-INJECTED
global WFRD1494 `"start "rd2017/lib/shared.do:L886:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 12 17"' // WFLOG-INJECTED
global WFRD1495 `"end "rd2017/lib/shared.do:L886:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 12 17"' // WFLOG-INJECTED
global WFRD1496 `"start "rd2017/lib/shared.do:L887:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 13 17"' // WFLOG-INJECTED
global WFRD1497 `"end "rd2017/lib/shared.do:L887:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 13 17"' // WFLOG-INJECTED
global WFRD1498 `"start "rd2017/lib/shared.do:L888:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 14 17"' // WFLOG-INJECTED
global WFRD1499 `"end "rd2017/lib/shared.do:L888:step-local" "rd2017/lib/shared.do:L874:block-body" "statement" 14 17"' // WFLOG-INJECTED
global WFRD1500 `"start "rd2017/lib/shared.do:L889:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 15 17"' // WFLOG-INJECTED
global WFRD1501 `"end "rd2017/lib/shared.do:L889:step-assert" "rd2017/lib/shared.do:L874:block-body" "statement" 15 17"' // WFLOG-INJECTED
global WFRD1502 `"start "rd2017/lib/shared.do:L890:step-isid" "rd2017/lib/shared.do:L874:block-body" "statement" 16 17"' // WFLOG-INJECTED
global WFRD1503 `"end "rd2017/lib/shared.do:L890:step-isid" "rd2017/lib/shared.do:L874:block-body" "statement" 16 17"' // WFLOG-INJECTED
global WFRD1504 `"start "rd2017/lib/shared.do:L891:step-exit" "rd2017/lib/shared.do:L874:block-body" "statement" 17 17"' // WFLOG-INJECTED
global WFRD1505 `"end "rd2017/lib/shared.do:L891:step-exit" "rd2017/lib/shared.do:L874:block-body" "statement" 17 17"' // WFLOG-INJECTED
global WFRD1506 `"end "rd2017/lib/shared.do:L874:block-body" "rd2017/lib/shared.do:L874:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1507 `"end "rd2017/lib/shared.do:L874:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 3 18"' // WFLOG-INJECTED
global WFRD1508 `"start "rd2017/lib/shared.do:L893:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 4 18"' // WFLOG-INJECTED
global WFRD1509 `"start "rd2017/lib/shared.do:L893:block-body" "rd2017/lib/shared.do:L893:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1510 `"start "rd2017/lib/shared.do:L894:step-unab" "rd2017/lib/shared.do:L893:block-body" "statement" 1 19"' // WFLOG-INJECTED
global WFRD1511 `"end "rd2017/lib/shared.do:L894:step-unab" "rd2017/lib/shared.do:L893:block-body" "statement" 1 19"' // WFLOG-INJECTED
global WFRD1512 `"start "rd2017/lib/shared.do:L895:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 2 19"' // WFLOG-INJECTED
global WFRD1513 `"end "rd2017/lib/shared.do:L895:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 2 19"' // WFLOG-INJECTED
global WFRD1514 `"start "rd2017/lib/shared.do:L896:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 3 19"' // WFLOG-INJECTED
global WFRD1515 `"end "rd2017/lib/shared.do:L896:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 3 19"' // WFLOG-INJECTED
global WFRD1516 `"start "rd2017/lib/shared.do:L897:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 4 19"' // WFLOG-INJECTED
global WFRD1517 `"end "rd2017/lib/shared.do:L897:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 4 19"' // WFLOG-INJECTED
global WFRD1518 `"start "rd2017/lib/shared.do:L898:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 5 19"' // WFLOG-INJECTED
global WFRD1519 `"end "rd2017/lib/shared.do:L898:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 5 19"' // WFLOG-INJECTED
global WFRD1520 `"start "rd2017/lib/shared.do:L899:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 6 19"' // WFLOG-INJECTED
global WFRD1521 `"end "rd2017/lib/shared.do:L899:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 6 19"' // WFLOG-INJECTED
global WFRD1522 `"start "rd2017/lib/shared.do:L900:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 7 19"' // WFLOG-INJECTED
global WFRD1523 `"end "rd2017/lib/shared.do:L900:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 7 19"' // WFLOG-INJECTED
global WFRD1524 `"start "rd2017/lib/shared.do:L901:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 8 19"' // WFLOG-INJECTED
global WFRD1525 `"end "rd2017/lib/shared.do:L901:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 8 19"' // WFLOG-INJECTED
global WFRD1526 `"start "rd2017/lib/shared.do:L902:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 9 19"' // WFLOG-INJECTED
global WFRD1527 `"end "rd2017/lib/shared.do:L902:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 9 19"' // WFLOG-INJECTED
global WFRD1528 `"start "rd2017/lib/shared.do:L903:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 10 19"' // WFLOG-INJECTED
global WFRD1529 `"end "rd2017/lib/shared.do:L903:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 10 19"' // WFLOG-INJECTED
global WFRD1530 `"start "rd2017/lib/shared.do:L904:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 11 19"' // WFLOG-INJECTED
global WFRD1531 `"end "rd2017/lib/shared.do:L904:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 11 19"' // WFLOG-INJECTED
global WFRD1532 `"start "rd2017/lib/shared.do:L905:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 12 19"' // WFLOG-INJECTED
global WFRD1533 `"end "rd2017/lib/shared.do:L905:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 12 19"' // WFLOG-INJECTED
global WFRD1534 `"start "rd2017/lib/shared.do:L906:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 13 19"' // WFLOG-INJECTED
global WFRD1535 `"end "rd2017/lib/shared.do:L906:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 13 19"' // WFLOG-INJECTED
global WFRD1536 `"start "rd2017/lib/shared.do:L907:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 14 19"' // WFLOG-INJECTED
global WFRD1537 `"end "rd2017/lib/shared.do:L907:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 14 19"' // WFLOG-INJECTED
global WFRD1538 `"start "rd2017/lib/shared.do:L908:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 15 19"' // WFLOG-INJECTED
global WFRD1539 `"end "rd2017/lib/shared.do:L908:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 15 19"' // WFLOG-INJECTED
global WFRD1540 `"start "rd2017/lib/shared.do:L909:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 16 19"' // WFLOG-INJECTED
global WFRD1541 `"end "rd2017/lib/shared.do:L909:step-local" "rd2017/lib/shared.do:L893:block-body" "statement" 16 19"' // WFLOG-INJECTED
global WFRD1542 `"start "rd2017/lib/shared.do:L910:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 17 19"' // WFLOG-INJECTED
global WFRD1543 `"end "rd2017/lib/shared.do:L910:step-assert" "rd2017/lib/shared.do:L893:block-body" "statement" 17 19"' // WFLOG-INJECTED
global WFRD1544 `"start "rd2017/lib/shared.do:L911:step-isid" "rd2017/lib/shared.do:L893:block-body" "statement" 18 19"' // WFLOG-INJECTED
global WFRD1545 `"end "rd2017/lib/shared.do:L911:step-isid" "rd2017/lib/shared.do:L893:block-body" "statement" 18 19"' // WFLOG-INJECTED
global WFRD1546 `"start "rd2017/lib/shared.do:L912:step-exit" "rd2017/lib/shared.do:L893:block-body" "statement" 19 19"' // WFLOG-INJECTED
global WFRD1547 `"end "rd2017/lib/shared.do:L912:step-exit" "rd2017/lib/shared.do:L893:block-body" "statement" 19 19"' // WFLOG-INJECTED
global WFRD1548 `"end "rd2017/lib/shared.do:L893:block-body" "rd2017/lib/shared.do:L893:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1549 `"end "rd2017/lib/shared.do:L893:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 4 18"' // WFLOG-INJECTED
global WFRD1550 `"start "rd2017/lib/shared.do:L914:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 5 18"' // WFLOG-INJECTED
global WFRD1551 `"start "rd2017/lib/shared.do:L914:block-body" "rd2017/lib/shared.do:L914:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1552 `"start "rd2017/lib/shared.do:L915:step-unab" "rd2017/lib/shared.do:L914:block-body" "statement" 1 25"' // WFLOG-INJECTED
global WFRD1553 `"end "rd2017/lib/shared.do:L915:step-unab" "rd2017/lib/shared.do:L914:block-body" "statement" 1 25"' // WFLOG-INJECTED
global WFRD1554 `"start "rd2017/lib/shared.do:L916:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 2 25"' // WFLOG-INJECTED
global WFRD1555 `"end "rd2017/lib/shared.do:L916:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 2 25"' // WFLOG-INJECTED
global WFRD1556 `"start "rd2017/lib/shared.do:L917:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 3 25"' // WFLOG-INJECTED
global WFRD1557 `"end "rd2017/lib/shared.do:L917:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 3 25"' // WFLOG-INJECTED
global WFRD1558 `"start "rd2017/lib/shared.do:L918:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 4 25"' // WFLOG-INJECTED
global WFRD1559 `"end "rd2017/lib/shared.do:L918:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 4 25"' // WFLOG-INJECTED
global WFRD1560 `"start "rd2017/lib/shared.do:L919:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 5 25"' // WFLOG-INJECTED
global WFRD1561 `"end "rd2017/lib/shared.do:L919:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 5 25"' // WFLOG-INJECTED
global WFRD1562 `"start "rd2017/lib/shared.do:L920:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 6 25"' // WFLOG-INJECTED
global WFRD1563 `"end "rd2017/lib/shared.do:L920:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 6 25"' // WFLOG-INJECTED
global WFRD1564 `"start "rd2017/lib/shared.do:L921:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 7 25"' // WFLOG-INJECTED
global WFRD1565 `"end "rd2017/lib/shared.do:L921:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 7 25"' // WFLOG-INJECTED
global WFRD1566 `"start "rd2017/lib/shared.do:L922:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 8 25"' // WFLOG-INJECTED
global WFRD1567 `"end "rd2017/lib/shared.do:L922:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 8 25"' // WFLOG-INJECTED
global WFRD1568 `"start "rd2017/lib/shared.do:L923:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 9 25"' // WFLOG-INJECTED
global WFRD1569 `"end "rd2017/lib/shared.do:L923:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 9 25"' // WFLOG-INJECTED
global WFRD1570 `"start "rd2017/lib/shared.do:L924:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 10 25"' // WFLOG-INJECTED
global WFRD1571 `"end "rd2017/lib/shared.do:L924:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 10 25"' // WFLOG-INJECTED
global WFRD1572 `"start "rd2017/lib/shared.do:L925:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 11 25"' // WFLOG-INJECTED
global WFRD1573 `"end "rd2017/lib/shared.do:L925:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 11 25"' // WFLOG-INJECTED
global WFRD1574 `"start "rd2017/lib/shared.do:L926:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 12 25"' // WFLOG-INJECTED
global WFRD1575 `"end "rd2017/lib/shared.do:L926:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 12 25"' // WFLOG-INJECTED
global WFRD1576 `"start "rd2017/lib/shared.do:L927:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 13 25"' // WFLOG-INJECTED
global WFRD1577 `"end "rd2017/lib/shared.do:L927:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 13 25"' // WFLOG-INJECTED
global WFRD1578 `"start "rd2017/lib/shared.do:L928:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 14 25"' // WFLOG-INJECTED
global WFRD1579 `"end "rd2017/lib/shared.do:L928:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 14 25"' // WFLOG-INJECTED
global WFRD1580 `"start "rd2017/lib/shared.do:L929:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 15 25"' // WFLOG-INJECTED
global WFRD1581 `"end "rd2017/lib/shared.do:L929:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 15 25"' // WFLOG-INJECTED
global WFRD1582 `"start "rd2017/lib/shared.do:L930:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 16 25"' // WFLOG-INJECTED
global WFRD1583 `"end "rd2017/lib/shared.do:L930:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 16 25"' // WFLOG-INJECTED
global WFRD1584 `"start "rd2017/lib/shared.do:L931:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 17 25"' // WFLOG-INJECTED
global WFRD1585 `"end "rd2017/lib/shared.do:L931:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 17 25"' // WFLOG-INJECTED
global WFRD1586 `"start "rd2017/lib/shared.do:L932:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 18 25"' // WFLOG-INJECTED
global WFRD1587 `"end "rd2017/lib/shared.do:L932:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 18 25"' // WFLOG-INJECTED
global WFRD1588 `"start "rd2017/lib/shared.do:L933:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 19 25"' // WFLOG-INJECTED
global WFRD1589 `"end "rd2017/lib/shared.do:L933:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 19 25"' // WFLOG-INJECTED
global WFRD1590 `"start "rd2017/lib/shared.do:L934:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 20 25"' // WFLOG-INJECTED
global WFRD1591 `"end "rd2017/lib/shared.do:L934:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 20 25"' // WFLOG-INJECTED
global WFRD1592 `"start "rd2017/lib/shared.do:L935:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 21 25"' // WFLOG-INJECTED
global WFRD1593 `"end "rd2017/lib/shared.do:L935:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 21 25"' // WFLOG-INJECTED
global WFRD1594 `"start "rd2017/lib/shared.do:L936:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 22 25"' // WFLOG-INJECTED
global WFRD1595 `"end "rd2017/lib/shared.do:L936:step-local" "rd2017/lib/shared.do:L914:block-body" "statement" 22 25"' // WFLOG-INJECTED
global WFRD1596 `"start "rd2017/lib/shared.do:L937:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 23 25"' // WFLOG-INJECTED
global WFRD1597 `"end "rd2017/lib/shared.do:L937:step-assert" "rd2017/lib/shared.do:L914:block-body" "statement" 23 25"' // WFLOG-INJECTED
global WFRD1598 `"start "rd2017/lib/shared.do:L938:step-isid" "rd2017/lib/shared.do:L914:block-body" "statement" 24 25"' // WFLOG-INJECTED
global WFRD1599 `"end "rd2017/lib/shared.do:L938:step-isid" "rd2017/lib/shared.do:L914:block-body" "statement" 24 25"' // WFLOG-INJECTED
global WFRD1600 `"start "rd2017/lib/shared.do:L939:step-exit" "rd2017/lib/shared.do:L914:block-body" "statement" 25 25"' // WFLOG-INJECTED
global WFRD1601 `"end "rd2017/lib/shared.do:L939:step-exit" "rd2017/lib/shared.do:L914:block-body" "statement" 25 25"' // WFLOG-INJECTED
global WFRD1602 `"end "rd2017/lib/shared.do:L914:block-body" "rd2017/lib/shared.do:L914:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1603 `"end "rd2017/lib/shared.do:L914:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 5 18"' // WFLOG-INJECTED
global WFRD1604 `"start "rd2017/lib/shared.do:L941:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 6 18"' // WFLOG-INJECTED
global WFRD1605 `"start "rd2017/lib/shared.do:L941:block-body" "rd2017/lib/shared.do:L941:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1606 `"start "rd2017/lib/shared.do:L942:step-unab" "rd2017/lib/shared.do:L941:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1607 `"end "rd2017/lib/shared.do:L942:step-unab" "rd2017/lib/shared.do:L941:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1608 `"start "rd2017/lib/shared.do:L943:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1609 `"end "rd2017/lib/shared.do:L943:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1610 `"start "rd2017/lib/shared.do:L944:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1611 `"end "rd2017/lib/shared.do:L944:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1612 `"start "rd2017/lib/shared.do:L945:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1613 `"end "rd2017/lib/shared.do:L945:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1614 `"start "rd2017/lib/shared.do:L946:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1615 `"end "rd2017/lib/shared.do:L946:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1616 `"start "rd2017/lib/shared.do:L947:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1617 `"end "rd2017/lib/shared.do:L947:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1618 `"start "rd2017/lib/shared.do:L948:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1619 `"end "rd2017/lib/shared.do:L948:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1620 `"start "rd2017/lib/shared.do:L949:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1621 `"end "rd2017/lib/shared.do:L949:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1622 `"start "rd2017/lib/shared.do:L950:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1623 `"end "rd2017/lib/shared.do:L950:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1624 `"start "rd2017/lib/shared.do:L951:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1625 `"end "rd2017/lib/shared.do:L951:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1626 `"start "rd2017/lib/shared.do:L952:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1627 `"end "rd2017/lib/shared.do:L952:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1628 `"start "rd2017/lib/shared.do:L953:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1629 `"end "rd2017/lib/shared.do:L953:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1630 `"start "rd2017/lib/shared.do:L954:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1631 `"end "rd2017/lib/shared.do:L954:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1632 `"start "rd2017/lib/shared.do:L955:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1633 `"end "rd2017/lib/shared.do:L955:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1634 `"start "rd2017/lib/shared.do:L956:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1635 `"end "rd2017/lib/shared.do:L956:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1636 `"start "rd2017/lib/shared.do:L957:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1637 `"end "rd2017/lib/shared.do:L957:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1638 `"start "rd2017/lib/shared.do:L958:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1639 `"end "rd2017/lib/shared.do:L958:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1640 `"start "rd2017/lib/shared.do:L959:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1641 `"end "rd2017/lib/shared.do:L959:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1642 `"start "rd2017/lib/shared.do:L960:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1643 `"end "rd2017/lib/shared.do:L960:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1644 `"start "rd2017/lib/shared.do:L961:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1645 `"end "rd2017/lib/shared.do:L961:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1646 `"start "rd2017/lib/shared.do:L962:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1647 `"end "rd2017/lib/shared.do:L962:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1648 `"start "rd2017/lib/shared.do:L963:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1649 `"end "rd2017/lib/shared.do:L963:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1650 `"start "rd2017/lib/shared.do:L964:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1651 `"end "rd2017/lib/shared.do:L964:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1652 `"start "rd2017/lib/shared.do:L965:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1653 `"end "rd2017/lib/shared.do:L965:step-local" "rd2017/lib/shared.do:L941:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1654 `"start "rd2017/lib/shared.do:L966:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1655 `"end "rd2017/lib/shared.do:L966:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1656 `"start "rd2017/lib/shared.do:L967:step-isid" "rd2017/lib/shared.do:L941:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1657 `"end "rd2017/lib/shared.do:L967:step-isid" "rd2017/lib/shared.do:L941:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1658 `"start "rd2017/lib/shared.do:L968:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1659 `"end "rd2017/lib/shared.do:L968:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1660 `"start "rd2017/lib/shared.do:L969:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1661 `"end "rd2017/lib/shared.do:L969:step-assert" "rd2017/lib/shared.do:L941:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1662 `"start "rd2017/lib/shared.do:L970:step-exit" "rd2017/lib/shared.do:L941:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1663 `"end "rd2017/lib/shared.do:L970:step-exit" "rd2017/lib/shared.do:L941:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1664 `"end "rd2017/lib/shared.do:L941:block-body" "rd2017/lib/shared.do:L941:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1665 `"end "rd2017/lib/shared.do:L941:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 6 18"' // WFLOG-INJECTED
global WFRD1666 `"start "rd2017/lib/shared.do:L972:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 7 18"' // WFLOG-INJECTED
global WFRD1667 `"start "rd2017/lib/shared.do:L972:block-body" "rd2017/lib/shared.do:L972:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1668 `"start "rd2017/lib/shared.do:L973:step-unab" "rd2017/lib/shared.do:L972:block-body" "statement" 1 33"' // WFLOG-INJECTED
global WFRD1669 `"end "rd2017/lib/shared.do:L973:step-unab" "rd2017/lib/shared.do:L972:block-body" "statement" 1 33"' // WFLOG-INJECTED
global WFRD1670 `"start "rd2017/lib/shared.do:L974:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 2 33"' // WFLOG-INJECTED
global WFRD1671 `"end "rd2017/lib/shared.do:L974:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 2 33"' // WFLOG-INJECTED
global WFRD1672 `"start "rd2017/lib/shared.do:L975:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 3 33"' // WFLOG-INJECTED
global WFRD1673 `"end "rd2017/lib/shared.do:L975:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 3 33"' // WFLOG-INJECTED
global WFRD1674 `"start "rd2017/lib/shared.do:L976:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 4 33"' // WFLOG-INJECTED
global WFRD1675 `"end "rd2017/lib/shared.do:L976:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 4 33"' // WFLOG-INJECTED
global WFRD1676 `"start "rd2017/lib/shared.do:L977:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 5 33"' // WFLOG-INJECTED
global WFRD1677 `"end "rd2017/lib/shared.do:L977:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 5 33"' // WFLOG-INJECTED
global WFRD1678 `"start "rd2017/lib/shared.do:L978:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 6 33"' // WFLOG-INJECTED
global WFRD1679 `"end "rd2017/lib/shared.do:L978:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 6 33"' // WFLOG-INJECTED
global WFRD1680 `"start "rd2017/lib/shared.do:L979:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 7 33"' // WFLOG-INJECTED
global WFRD1681 `"end "rd2017/lib/shared.do:L979:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 7 33"' // WFLOG-INJECTED
global WFRD1682 `"start "rd2017/lib/shared.do:L980:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 8 33"' // WFLOG-INJECTED
global WFRD1683 `"end "rd2017/lib/shared.do:L980:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 8 33"' // WFLOG-INJECTED
global WFRD1684 `"start "rd2017/lib/shared.do:L981:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 9 33"' // WFLOG-INJECTED
global WFRD1685 `"end "rd2017/lib/shared.do:L981:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 9 33"' // WFLOG-INJECTED
global WFRD1686 `"start "rd2017/lib/shared.do:L982:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 10 33"' // WFLOG-INJECTED
global WFRD1687 `"end "rd2017/lib/shared.do:L982:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 10 33"' // WFLOG-INJECTED
global WFRD1688 `"start "rd2017/lib/shared.do:L983:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 11 33"' // WFLOG-INJECTED
global WFRD1689 `"end "rd2017/lib/shared.do:L983:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 11 33"' // WFLOG-INJECTED
global WFRD1690 `"start "rd2017/lib/shared.do:L984:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 12 33"' // WFLOG-INJECTED
global WFRD1691 `"end "rd2017/lib/shared.do:L984:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 12 33"' // WFLOG-INJECTED
global WFRD1692 `"start "rd2017/lib/shared.do:L985:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 13 33"' // WFLOG-INJECTED
global WFRD1693 `"end "rd2017/lib/shared.do:L985:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 13 33"' // WFLOG-INJECTED
global WFRD1694 `"start "rd2017/lib/shared.do:L986:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 14 33"' // WFLOG-INJECTED
global WFRD1695 `"end "rd2017/lib/shared.do:L986:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 14 33"' // WFLOG-INJECTED
global WFRD1696 `"start "rd2017/lib/shared.do:L987:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 15 33"' // WFLOG-INJECTED
global WFRD1697 `"end "rd2017/lib/shared.do:L987:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 15 33"' // WFLOG-INJECTED
global WFRD1698 `"start "rd2017/lib/shared.do:L988:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 16 33"' // WFLOG-INJECTED
global WFRD1699 `"end "rd2017/lib/shared.do:L988:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 16 33"' // WFLOG-INJECTED
global WFRD1700 `"start "rd2017/lib/shared.do:L989:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 17 33"' // WFLOG-INJECTED
global WFRD1701 `"end "rd2017/lib/shared.do:L989:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 17 33"' // WFLOG-INJECTED
global WFRD1702 `"start "rd2017/lib/shared.do:L990:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 18 33"' // WFLOG-INJECTED
global WFRD1703 `"end "rd2017/lib/shared.do:L990:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 18 33"' // WFLOG-INJECTED
global WFRD1704 `"start "rd2017/lib/shared.do:L991:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 19 33"' // WFLOG-INJECTED
global WFRD1705 `"end "rd2017/lib/shared.do:L991:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 19 33"' // WFLOG-INJECTED
global WFRD1706 `"start "rd2017/lib/shared.do:L992:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 20 33"' // WFLOG-INJECTED
global WFRD1707 `"end "rd2017/lib/shared.do:L992:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 20 33"' // WFLOG-INJECTED
global WFRD1708 `"start "rd2017/lib/shared.do:L993:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 21 33"' // WFLOG-INJECTED
global WFRD1709 `"end "rd2017/lib/shared.do:L993:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 21 33"' // WFLOG-INJECTED
global WFRD1710 `"start "rd2017/lib/shared.do:L994:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 22 33"' // WFLOG-INJECTED
global WFRD1711 `"end "rd2017/lib/shared.do:L994:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 22 33"' // WFLOG-INJECTED
global WFRD1712 `"start "rd2017/lib/shared.do:L995:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 23 33"' // WFLOG-INJECTED
global WFRD1713 `"end "rd2017/lib/shared.do:L995:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 23 33"' // WFLOG-INJECTED
global WFRD1714 `"start "rd2017/lib/shared.do:L996:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 24 33"' // WFLOG-INJECTED
global WFRD1715 `"end "rd2017/lib/shared.do:L996:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 24 33"' // WFLOG-INJECTED
global WFRD1716 `"start "rd2017/lib/shared.do:L997:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 25 33"' // WFLOG-INJECTED
global WFRD1717 `"end "rd2017/lib/shared.do:L997:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 25 33"' // WFLOG-INJECTED
global WFRD1718 `"start "rd2017/lib/shared.do:L998:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 26 33"' // WFLOG-INJECTED
global WFRD1719 `"end "rd2017/lib/shared.do:L998:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 26 33"' // WFLOG-INJECTED
global WFRD1720 `"start "rd2017/lib/shared.do:L999:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 27 33"' // WFLOG-INJECTED
global WFRD1721 `"end "rd2017/lib/shared.do:L999:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 27 33"' // WFLOG-INJECTED
global WFRD1722 `"start "rd2017/lib/shared.do:L1000:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 28 33"' // WFLOG-INJECTED
global WFRD1723 `"end "rd2017/lib/shared.do:L1000:step-local" "rd2017/lib/shared.do:L972:block-body" "statement" 28 33"' // WFLOG-INJECTED
global WFRD1724 `"start "rd2017/lib/shared.do:L1001:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 29 33"' // WFLOG-INJECTED
global WFRD1725 `"end "rd2017/lib/shared.do:L1001:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 29 33"' // WFLOG-INJECTED
global WFRD1726 `"start "rd2017/lib/shared.do:L1002:step-isid" "rd2017/lib/shared.do:L972:block-body" "statement" 30 33"' // WFLOG-INJECTED
global WFRD1727 `"end "rd2017/lib/shared.do:L1002:step-isid" "rd2017/lib/shared.do:L972:block-body" "statement" 30 33"' // WFLOG-INJECTED
global WFRD1728 `"start "rd2017/lib/shared.do:L1003:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 31 33"' // WFLOG-INJECTED
global WFRD1729 `"end "rd2017/lib/shared.do:L1003:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 31 33"' // WFLOG-INJECTED
global WFRD1730 `"start "rd2017/lib/shared.do:L1004:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 32 33"' // WFLOG-INJECTED
global WFRD1731 `"end "rd2017/lib/shared.do:L1004:step-assert" "rd2017/lib/shared.do:L972:block-body" "statement" 32 33"' // WFLOG-INJECTED
global WFRD1732 `"start "rd2017/lib/shared.do:L1005:step-exit" "rd2017/lib/shared.do:L972:block-body" "statement" 33 33"' // WFLOG-INJECTED
global WFRD1733 `"end "rd2017/lib/shared.do:L1005:step-exit" "rd2017/lib/shared.do:L972:block-body" "statement" 33 33"' // WFLOG-INJECTED
global WFRD1734 `"end "rd2017/lib/shared.do:L972:block-body" "rd2017/lib/shared.do:L972:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1735 `"end "rd2017/lib/shared.do:L972:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 7 18"' // WFLOG-INJECTED
global WFRD1736 `"start "rd2017/lib/shared.do:L1007:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 8 18"' // WFLOG-INJECTED
global WFRD1737 `"start "rd2017/lib/shared.do:L1007:block-body" "rd2017/lib/shared.do:L1007:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1738 `"start "rd2017/lib/shared.do:L1008:step-unab" "rd2017/lib/shared.do:L1007:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1739 `"end "rd2017/lib/shared.do:L1008:step-unab" "rd2017/lib/shared.do:L1007:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1740 `"start "rd2017/lib/shared.do:L1009:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1741 `"end "rd2017/lib/shared.do:L1009:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1742 `"start "rd2017/lib/shared.do:L1010:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1743 `"end "rd2017/lib/shared.do:L1010:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1744 `"start "rd2017/lib/shared.do:L1011:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1745 `"end "rd2017/lib/shared.do:L1011:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1746 `"start "rd2017/lib/shared.do:L1012:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1747 `"end "rd2017/lib/shared.do:L1012:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1748 `"start "rd2017/lib/shared.do:L1013:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1749 `"end "rd2017/lib/shared.do:L1013:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1750 `"start "rd2017/lib/shared.do:L1014:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1751 `"end "rd2017/lib/shared.do:L1014:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1752 `"start "rd2017/lib/shared.do:L1015:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1753 `"end "rd2017/lib/shared.do:L1015:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1754 `"start "rd2017/lib/shared.do:L1016:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1755 `"end "rd2017/lib/shared.do:L1016:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1756 `"start "rd2017/lib/shared.do:L1017:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1757 `"end "rd2017/lib/shared.do:L1017:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1758 `"start "rd2017/lib/shared.do:L1018:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1759 `"end "rd2017/lib/shared.do:L1018:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1760 `"start "rd2017/lib/shared.do:L1019:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1761 `"end "rd2017/lib/shared.do:L1019:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1762 `"start "rd2017/lib/shared.do:L1020:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1763 `"end "rd2017/lib/shared.do:L1020:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1764 `"start "rd2017/lib/shared.do:L1021:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1765 `"end "rd2017/lib/shared.do:L1021:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1766 `"start "rd2017/lib/shared.do:L1022:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1767 `"end "rd2017/lib/shared.do:L1022:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1768 `"start "rd2017/lib/shared.do:L1023:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1769 `"end "rd2017/lib/shared.do:L1023:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1770 `"start "rd2017/lib/shared.do:L1024:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1771 `"end "rd2017/lib/shared.do:L1024:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1772 `"start "rd2017/lib/shared.do:L1025:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1773 `"end "rd2017/lib/shared.do:L1025:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1774 `"start "rd2017/lib/shared.do:L1026:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1775 `"end "rd2017/lib/shared.do:L1026:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1776 `"start "rd2017/lib/shared.do:L1027:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1777 `"end "rd2017/lib/shared.do:L1027:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1778 `"start "rd2017/lib/shared.do:L1028:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1779 `"end "rd2017/lib/shared.do:L1028:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1780 `"start "rd2017/lib/shared.do:L1029:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1781 `"end "rd2017/lib/shared.do:L1029:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1782 `"start "rd2017/lib/shared.do:L1030:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1783 `"end "rd2017/lib/shared.do:L1030:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1784 `"start "rd2017/lib/shared.do:L1031:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1785 `"end "rd2017/lib/shared.do:L1031:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1786 `"start "rd2017/lib/shared.do:L1032:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1787 `"end "rd2017/lib/shared.do:L1032:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1788 `"start "rd2017/lib/shared.do:L1033:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1789 `"end "rd2017/lib/shared.do:L1033:step-local" "rd2017/lib/shared.do:L1007:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1790 `"start "rd2017/lib/shared.do:L1034:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1791 `"end "rd2017/lib/shared.do:L1034:step-assert" "rd2017/lib/shared.do:L1007:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1792 `"start "rd2017/lib/shared.do:L1035:step-isid" "rd2017/lib/shared.do:L1007:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1793 `"end "rd2017/lib/shared.do:L1035:step-isid" "rd2017/lib/shared.do:L1007:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1794 `"start "rd2017/lib/shared.do:L1036:step-exit" "rd2017/lib/shared.do:L1007:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1795 `"end "rd2017/lib/shared.do:L1036:step-exit" "rd2017/lib/shared.do:L1007:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1796 `"end "rd2017/lib/shared.do:L1007:block-body" "rd2017/lib/shared.do:L1007:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1797 `"end "rd2017/lib/shared.do:L1007:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 8 18"' // WFLOG-INJECTED
global WFRD1798 `"start "rd2017/lib/shared.do:L1038:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 9 18"' // WFLOG-INJECTED
global WFRD1799 `"start "rd2017/lib/shared.do:L1038:block-body" "rd2017/lib/shared.do:L1038:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1800 `"start "rd2017/lib/shared.do:L1039:step-unab" "rd2017/lib/shared.do:L1038:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1801 `"end "rd2017/lib/shared.do:L1039:step-unab" "rd2017/lib/shared.do:L1038:block-body" "statement" 1 29"' // WFLOG-INJECTED
global WFRD1802 `"start "rd2017/lib/shared.do:L1040:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1803 `"end "rd2017/lib/shared.do:L1040:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 2 29"' // WFLOG-INJECTED
global WFRD1804 `"start "rd2017/lib/shared.do:L1041:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1805 `"end "rd2017/lib/shared.do:L1041:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 3 29"' // WFLOG-INJECTED
global WFRD1806 `"start "rd2017/lib/shared.do:L1042:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1807 `"end "rd2017/lib/shared.do:L1042:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 4 29"' // WFLOG-INJECTED
global WFRD1808 `"start "rd2017/lib/shared.do:L1043:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1809 `"end "rd2017/lib/shared.do:L1043:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 5 29"' // WFLOG-INJECTED
global WFRD1810 `"start "rd2017/lib/shared.do:L1044:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1811 `"end "rd2017/lib/shared.do:L1044:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 6 29"' // WFLOG-INJECTED
global WFRD1812 `"start "rd2017/lib/shared.do:L1045:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1813 `"end "rd2017/lib/shared.do:L1045:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 7 29"' // WFLOG-INJECTED
global WFRD1814 `"start "rd2017/lib/shared.do:L1046:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1815 `"end "rd2017/lib/shared.do:L1046:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 8 29"' // WFLOG-INJECTED
global WFRD1816 `"start "rd2017/lib/shared.do:L1047:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1817 `"end "rd2017/lib/shared.do:L1047:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 9 29"' // WFLOG-INJECTED
global WFRD1818 `"start "rd2017/lib/shared.do:L1048:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1819 `"end "rd2017/lib/shared.do:L1048:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 10 29"' // WFLOG-INJECTED
global WFRD1820 `"start "rd2017/lib/shared.do:L1049:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1821 `"end "rd2017/lib/shared.do:L1049:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 11 29"' // WFLOG-INJECTED
global WFRD1822 `"start "rd2017/lib/shared.do:L1050:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1823 `"end "rd2017/lib/shared.do:L1050:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 12 29"' // WFLOG-INJECTED
global WFRD1824 `"start "rd2017/lib/shared.do:L1051:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1825 `"end "rd2017/lib/shared.do:L1051:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 13 29"' // WFLOG-INJECTED
global WFRD1826 `"start "rd2017/lib/shared.do:L1052:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1827 `"end "rd2017/lib/shared.do:L1052:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 14 29"' // WFLOG-INJECTED
global WFRD1828 `"start "rd2017/lib/shared.do:L1053:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1829 `"end "rd2017/lib/shared.do:L1053:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 15 29"' // WFLOG-INJECTED
global WFRD1830 `"start "rd2017/lib/shared.do:L1054:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1831 `"end "rd2017/lib/shared.do:L1054:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 16 29"' // WFLOG-INJECTED
global WFRD1832 `"start "rd2017/lib/shared.do:L1055:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1833 `"end "rd2017/lib/shared.do:L1055:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 17 29"' // WFLOG-INJECTED
global WFRD1834 `"start "rd2017/lib/shared.do:L1056:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1835 `"end "rd2017/lib/shared.do:L1056:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 18 29"' // WFLOG-INJECTED
global WFRD1836 `"start "rd2017/lib/shared.do:L1057:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1837 `"end "rd2017/lib/shared.do:L1057:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 19 29"' // WFLOG-INJECTED
global WFRD1838 `"start "rd2017/lib/shared.do:L1058:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1839 `"end "rd2017/lib/shared.do:L1058:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 20 29"' // WFLOG-INJECTED
global WFRD1840 `"start "rd2017/lib/shared.do:L1059:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1841 `"end "rd2017/lib/shared.do:L1059:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 21 29"' // WFLOG-INJECTED
global WFRD1842 `"start "rd2017/lib/shared.do:L1060:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1843 `"end "rd2017/lib/shared.do:L1060:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 22 29"' // WFLOG-INJECTED
global WFRD1844 `"start "rd2017/lib/shared.do:L1061:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1845 `"end "rd2017/lib/shared.do:L1061:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 23 29"' // WFLOG-INJECTED
global WFRD1846 `"start "rd2017/lib/shared.do:L1062:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1847 `"end "rd2017/lib/shared.do:L1062:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 24 29"' // WFLOG-INJECTED
global WFRD1848 `"start "rd2017/lib/shared.do:L1063:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1849 `"end "rd2017/lib/shared.do:L1063:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 25 29"' // WFLOG-INJECTED
global WFRD1850 `"start "rd2017/lib/shared.do:L1064:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1851 `"end "rd2017/lib/shared.do:L1064:step-local" "rd2017/lib/shared.do:L1038:block-body" "statement" 26 29"' // WFLOG-INJECTED
global WFRD1852 `"start "rd2017/lib/shared.do:L1065:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1853 `"end "rd2017/lib/shared.do:L1065:step-assert" "rd2017/lib/shared.do:L1038:block-body" "statement" 27 29"' // WFLOG-INJECTED
global WFRD1854 `"start "rd2017/lib/shared.do:L1066:step-isid" "rd2017/lib/shared.do:L1038:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1855 `"end "rd2017/lib/shared.do:L1066:step-isid" "rd2017/lib/shared.do:L1038:block-body" "statement" 28 29"' // WFLOG-INJECTED
global WFRD1856 `"start "rd2017/lib/shared.do:L1067:step-exit" "rd2017/lib/shared.do:L1038:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1857 `"end "rd2017/lib/shared.do:L1067:step-exit" "rd2017/lib/shared.do:L1038:block-body" "statement" 29 29"' // WFLOG-INJECTED
global WFRD1858 `"end "rd2017/lib/shared.do:L1038:block-body" "rd2017/lib/shared.do:L1038:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1859 `"end "rd2017/lib/shared.do:L1038:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 9 18"' // WFLOG-INJECTED
global WFRD1860 `"start "rd2017/lib/shared.do:L1069:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 10 18"' // WFLOG-INJECTED
global WFRD1861 `"start "rd2017/lib/shared.do:L1069:block-body" "rd2017/lib/shared.do:L1069:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1862 `"start "rd2017/lib/shared.do:L1070:step-unab" "rd2017/lib/shared.do:L1069:block-body" "statement" 1 51"' // WFLOG-INJECTED
global WFRD1863 `"end "rd2017/lib/shared.do:L1070:step-unab" "rd2017/lib/shared.do:L1069:block-body" "statement" 1 51"' // WFLOG-INJECTED
global WFRD1864 `"start "rd2017/lib/shared.do:L1071:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 2 51"' // WFLOG-INJECTED
global WFRD1865 `"end "rd2017/lib/shared.do:L1071:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 2 51"' // WFLOG-INJECTED
global WFRD1866 `"start "rd2017/lib/shared.do:L1072:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 3 51"' // WFLOG-INJECTED
global WFRD1867 `"end "rd2017/lib/shared.do:L1072:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 3 51"' // WFLOG-INJECTED
global WFRD1868 `"start "rd2017/lib/shared.do:L1073:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 4 51"' // WFLOG-INJECTED
global WFRD1869 `"end "rd2017/lib/shared.do:L1073:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 4 51"' // WFLOG-INJECTED
global WFRD1870 `"start "rd2017/lib/shared.do:L1074:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 5 51"' // WFLOG-INJECTED
global WFRD1871 `"end "rd2017/lib/shared.do:L1074:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 5 51"' // WFLOG-INJECTED
global WFRD1872 `"start "rd2017/lib/shared.do:L1075:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 6 51"' // WFLOG-INJECTED
global WFRD1873 `"end "rd2017/lib/shared.do:L1075:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 6 51"' // WFLOG-INJECTED
global WFRD1874 `"start "rd2017/lib/shared.do:L1076:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 7 51"' // WFLOG-INJECTED
global WFRD1875 `"end "rd2017/lib/shared.do:L1076:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 7 51"' // WFLOG-INJECTED
global WFRD1876 `"start "rd2017/lib/shared.do:L1077:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 8 51"' // WFLOG-INJECTED
global WFRD1877 `"end "rd2017/lib/shared.do:L1077:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 8 51"' // WFLOG-INJECTED
global WFRD1878 `"start "rd2017/lib/shared.do:L1078:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 9 51"' // WFLOG-INJECTED
global WFRD1879 `"end "rd2017/lib/shared.do:L1078:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 9 51"' // WFLOG-INJECTED
global WFRD1880 `"start "rd2017/lib/shared.do:L1079:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 10 51"' // WFLOG-INJECTED
global WFRD1881 `"end "rd2017/lib/shared.do:L1079:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 10 51"' // WFLOG-INJECTED
global WFRD1882 `"start "rd2017/lib/shared.do:L1080:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 11 51"' // WFLOG-INJECTED
global WFRD1883 `"end "rd2017/lib/shared.do:L1080:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 11 51"' // WFLOG-INJECTED
global WFRD1884 `"start "rd2017/lib/shared.do:L1081:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 12 51"' // WFLOG-INJECTED
global WFRD1885 `"end "rd2017/lib/shared.do:L1081:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 12 51"' // WFLOG-INJECTED
global WFRD1886 `"start "rd2017/lib/shared.do:L1082:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 13 51"' // WFLOG-INJECTED
global WFRD1887 `"end "rd2017/lib/shared.do:L1082:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 13 51"' // WFLOG-INJECTED
global WFRD1888 `"start "rd2017/lib/shared.do:L1083:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 14 51"' // WFLOG-INJECTED
global WFRD1889 `"end "rd2017/lib/shared.do:L1083:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 14 51"' // WFLOG-INJECTED
global WFRD1890 `"start "rd2017/lib/shared.do:L1084:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 15 51"' // WFLOG-INJECTED
global WFRD1891 `"end "rd2017/lib/shared.do:L1084:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 15 51"' // WFLOG-INJECTED
global WFRD1892 `"start "rd2017/lib/shared.do:L1085:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 16 51"' // WFLOG-INJECTED
global WFRD1893 `"end "rd2017/lib/shared.do:L1085:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 16 51"' // WFLOG-INJECTED
global WFRD1894 `"start "rd2017/lib/shared.do:L1086:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 17 51"' // WFLOG-INJECTED
global WFRD1895 `"end "rd2017/lib/shared.do:L1086:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 17 51"' // WFLOG-INJECTED
global WFRD1896 `"start "rd2017/lib/shared.do:L1087:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 18 51"' // WFLOG-INJECTED
global WFRD1897 `"end "rd2017/lib/shared.do:L1087:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 18 51"' // WFLOG-INJECTED
global WFRD1898 `"start "rd2017/lib/shared.do:L1088:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 19 51"' // WFLOG-INJECTED
global WFRD1899 `"end "rd2017/lib/shared.do:L1088:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 19 51"' // WFLOG-INJECTED
global WFRD1900 `"start "rd2017/lib/shared.do:L1089:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 20 51"' // WFLOG-INJECTED
global WFRD1901 `"end "rd2017/lib/shared.do:L1089:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 20 51"' // WFLOG-INJECTED
global WFRD1902 `"start "rd2017/lib/shared.do:L1090:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 21 51"' // WFLOG-INJECTED
global WFRD1903 `"end "rd2017/lib/shared.do:L1090:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 21 51"' // WFLOG-INJECTED
global WFRD1904 `"start "rd2017/lib/shared.do:L1091:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 22 51"' // WFLOG-INJECTED
global WFRD1905 `"end "rd2017/lib/shared.do:L1091:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 22 51"' // WFLOG-INJECTED
global WFRD1906 `"start "rd2017/lib/shared.do:L1092:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 23 51"' // WFLOG-INJECTED
global WFRD1907 `"end "rd2017/lib/shared.do:L1092:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 23 51"' // WFLOG-INJECTED
global WFRD1908 `"start "rd2017/lib/shared.do:L1093:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 24 51"' // WFLOG-INJECTED
global WFRD1909 `"end "rd2017/lib/shared.do:L1093:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 24 51"' // WFLOG-INJECTED
global WFRD1910 `"start "rd2017/lib/shared.do:L1094:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 25 51"' // WFLOG-INJECTED
global WFRD1911 `"end "rd2017/lib/shared.do:L1094:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 25 51"' // WFLOG-INJECTED
global WFRD1912 `"start "rd2017/lib/shared.do:L1095:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 26 51"' // WFLOG-INJECTED
global WFRD1913 `"end "rd2017/lib/shared.do:L1095:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 26 51"' // WFLOG-INJECTED
global WFRD1914 `"start "rd2017/lib/shared.do:L1096:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 27 51"' // WFLOG-INJECTED
global WFRD1915 `"end "rd2017/lib/shared.do:L1096:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 27 51"' // WFLOG-INJECTED
global WFRD1916 `"start "rd2017/lib/shared.do:L1097:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 28 51"' // WFLOG-INJECTED
global WFRD1917 `"end "rd2017/lib/shared.do:L1097:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 28 51"' // WFLOG-INJECTED
global WFRD1918 `"start "rd2017/lib/shared.do:L1098:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 29 51"' // WFLOG-INJECTED
global WFRD1919 `"end "rd2017/lib/shared.do:L1098:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 29 51"' // WFLOG-INJECTED
global WFRD1920 `"start "rd2017/lib/shared.do:L1099:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 30 51"' // WFLOG-INJECTED
global WFRD1921 `"end "rd2017/lib/shared.do:L1099:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 30 51"' // WFLOG-INJECTED
global WFRD1922 `"start "rd2017/lib/shared.do:L1100:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 31 51"' // WFLOG-INJECTED
global WFRD1923 `"end "rd2017/lib/shared.do:L1100:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 31 51"' // WFLOG-INJECTED
global WFRD1924 `"start "rd2017/lib/shared.do:L1101:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 32 51"' // WFLOG-INJECTED
global WFRD1925 `"end "rd2017/lib/shared.do:L1101:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 32 51"' // WFLOG-INJECTED
global WFRD1926 `"start "rd2017/lib/shared.do:L1102:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 33 51"' // WFLOG-INJECTED
global WFRD1927 `"end "rd2017/lib/shared.do:L1102:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 33 51"' // WFLOG-INJECTED
global WFRD1928 `"start "rd2017/lib/shared.do:L1103:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 34 51"' // WFLOG-INJECTED
global WFRD1929 `"end "rd2017/lib/shared.do:L1103:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 34 51"' // WFLOG-INJECTED
global WFRD1930 `"start "rd2017/lib/shared.do:L1104:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 35 51"' // WFLOG-INJECTED
global WFRD1931 `"end "rd2017/lib/shared.do:L1104:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 35 51"' // WFLOG-INJECTED
global WFRD1932 `"start "rd2017/lib/shared.do:L1105:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 36 51"' // WFLOG-INJECTED
global WFRD1933 `"end "rd2017/lib/shared.do:L1105:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 36 51"' // WFLOG-INJECTED
global WFRD1934 `"start "rd2017/lib/shared.do:L1106:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 37 51"' // WFLOG-INJECTED
global WFRD1935 `"end "rd2017/lib/shared.do:L1106:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 37 51"' // WFLOG-INJECTED
global WFRD1936 `"start "rd2017/lib/shared.do:L1107:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 38 51"' // WFLOG-INJECTED
global WFRD1937 `"end "rd2017/lib/shared.do:L1107:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 38 51"' // WFLOG-INJECTED
global WFRD1938 `"start "rd2017/lib/shared.do:L1108:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 39 51"' // WFLOG-INJECTED
global WFRD1939 `"end "rd2017/lib/shared.do:L1108:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 39 51"' // WFLOG-INJECTED
global WFRD1940 `"start "rd2017/lib/shared.do:L1109:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 40 51"' // WFLOG-INJECTED
global WFRD1941 `"end "rd2017/lib/shared.do:L1109:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 40 51"' // WFLOG-INJECTED
global WFRD1942 `"start "rd2017/lib/shared.do:L1110:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 41 51"' // WFLOG-INJECTED
global WFRD1943 `"end "rd2017/lib/shared.do:L1110:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 41 51"' // WFLOG-INJECTED
global WFRD1944 `"start "rd2017/lib/shared.do:L1111:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 42 51"' // WFLOG-INJECTED
global WFRD1945 `"end "rd2017/lib/shared.do:L1111:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 42 51"' // WFLOG-INJECTED
global WFRD1946 `"start "rd2017/lib/shared.do:L1112:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 43 51"' // WFLOG-INJECTED
global WFRD1947 `"end "rd2017/lib/shared.do:L1112:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 43 51"' // WFLOG-INJECTED
global WFRD1948 `"start "rd2017/lib/shared.do:L1113:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 44 51"' // WFLOG-INJECTED
global WFRD1949 `"end "rd2017/lib/shared.do:L1113:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 44 51"' // WFLOG-INJECTED
global WFRD1950 `"start "rd2017/lib/shared.do:L1114:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 45 51"' // WFLOG-INJECTED
global WFRD1951 `"end "rd2017/lib/shared.do:L1114:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 45 51"' // WFLOG-INJECTED
global WFRD1952 `"start "rd2017/lib/shared.do:L1115:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 46 51"' // WFLOG-INJECTED
global WFRD1953 `"end "rd2017/lib/shared.do:L1115:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 46 51"' // WFLOG-INJECTED
global WFRD1954 `"start "rd2017/lib/shared.do:L1116:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 47 51"' // WFLOG-INJECTED
global WFRD1955 `"end "rd2017/lib/shared.do:L1116:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 47 51"' // WFLOG-INJECTED
global WFRD1956 `"start "rd2017/lib/shared.do:L1117:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 48 51"' // WFLOG-INJECTED
global WFRD1957 `"end "rd2017/lib/shared.do:L1117:step-local" "rd2017/lib/shared.do:L1069:block-body" "statement" 48 51"' // WFLOG-INJECTED
global WFRD1958 `"start "rd2017/lib/shared.do:L1118:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 49 51"' // WFLOG-INJECTED
global WFRD1959 `"end "rd2017/lib/shared.do:L1118:step-assert" "rd2017/lib/shared.do:L1069:block-body" "statement" 49 51"' // WFLOG-INJECTED
global WFRD1960 `"start "rd2017/lib/shared.do:L1119:step-isid" "rd2017/lib/shared.do:L1069:block-body" "statement" 50 51"' // WFLOG-INJECTED
global WFRD1961 `"end "rd2017/lib/shared.do:L1119:step-isid" "rd2017/lib/shared.do:L1069:block-body" "statement" 50 51"' // WFLOG-INJECTED
global WFRD1962 `"start "rd2017/lib/shared.do:L1120:step-exit" "rd2017/lib/shared.do:L1069:block-body" "statement" 51 51"' // WFLOG-INJECTED
global WFRD1963 `"end "rd2017/lib/shared.do:L1120:step-exit" "rd2017/lib/shared.do:L1069:block-body" "statement" 51 51"' // WFLOG-INJECTED
global WFRD1964 `"end "rd2017/lib/shared.do:L1069:block-body" "rd2017/lib/shared.do:L1069:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1965 `"end "rd2017/lib/shared.do:L1069:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 10 18"' // WFLOG-INJECTED
global WFRD1966 `"start "rd2017/lib/shared.do:L1122:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 11 18"' // WFLOG-INJECTED
global WFRD1967 `"start "rd2017/lib/shared.do:L1122:block-body" "rd2017/lib/shared.do:L1122:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD1968 `"start "rd2017/lib/shared.do:L1123:step-unab" "rd2017/lib/shared.do:L1122:block-body" "statement" 1 51"' // WFLOG-INJECTED
global WFRD1969 `"end "rd2017/lib/shared.do:L1123:step-unab" "rd2017/lib/shared.do:L1122:block-body" "statement" 1 51"' // WFLOG-INJECTED
global WFRD1970 `"start "rd2017/lib/shared.do:L1124:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 2 51"' // WFLOG-INJECTED
global WFRD1971 `"end "rd2017/lib/shared.do:L1124:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 2 51"' // WFLOG-INJECTED
global WFRD1972 `"start "rd2017/lib/shared.do:L1125:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 3 51"' // WFLOG-INJECTED
global WFRD1973 `"end "rd2017/lib/shared.do:L1125:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 3 51"' // WFLOG-INJECTED
global WFRD1974 `"start "rd2017/lib/shared.do:L1126:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 4 51"' // WFLOG-INJECTED
global WFRD1975 `"end "rd2017/lib/shared.do:L1126:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 4 51"' // WFLOG-INJECTED
global WFRD1976 `"start "rd2017/lib/shared.do:L1127:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 5 51"' // WFLOG-INJECTED
global WFRD1977 `"end "rd2017/lib/shared.do:L1127:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 5 51"' // WFLOG-INJECTED
global WFRD1978 `"start "rd2017/lib/shared.do:L1128:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 6 51"' // WFLOG-INJECTED
global WFRD1979 `"end "rd2017/lib/shared.do:L1128:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 6 51"' // WFLOG-INJECTED
global WFRD1980 `"start "rd2017/lib/shared.do:L1129:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 7 51"' // WFLOG-INJECTED
global WFRD1981 `"end "rd2017/lib/shared.do:L1129:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 7 51"' // WFLOG-INJECTED
global WFRD1982 `"start "rd2017/lib/shared.do:L1130:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 8 51"' // WFLOG-INJECTED
global WFRD1983 `"end "rd2017/lib/shared.do:L1130:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 8 51"' // WFLOG-INJECTED
global WFRD1984 `"start "rd2017/lib/shared.do:L1131:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 9 51"' // WFLOG-INJECTED
global WFRD1985 `"end "rd2017/lib/shared.do:L1131:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 9 51"' // WFLOG-INJECTED
global WFRD1986 `"start "rd2017/lib/shared.do:L1132:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 10 51"' // WFLOG-INJECTED
global WFRD1987 `"end "rd2017/lib/shared.do:L1132:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 10 51"' // WFLOG-INJECTED
global WFRD1988 `"start "rd2017/lib/shared.do:L1133:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 11 51"' // WFLOG-INJECTED
global WFRD1989 `"end "rd2017/lib/shared.do:L1133:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 11 51"' // WFLOG-INJECTED
global WFRD1990 `"start "rd2017/lib/shared.do:L1134:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 12 51"' // WFLOG-INJECTED
global WFRD1991 `"end "rd2017/lib/shared.do:L1134:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 12 51"' // WFLOG-INJECTED
global WFRD1992 `"start "rd2017/lib/shared.do:L1135:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 13 51"' // WFLOG-INJECTED
global WFRD1993 `"end "rd2017/lib/shared.do:L1135:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 13 51"' // WFLOG-INJECTED
global WFRD1994 `"start "rd2017/lib/shared.do:L1136:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 14 51"' // WFLOG-INJECTED
global WFRD1995 `"end "rd2017/lib/shared.do:L1136:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 14 51"' // WFLOG-INJECTED
global WFRD1996 `"start "rd2017/lib/shared.do:L1137:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 15 51"' // WFLOG-INJECTED
global WFRD1997 `"end "rd2017/lib/shared.do:L1137:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 15 51"' // WFLOG-INJECTED
global WFRD1998 `"start "rd2017/lib/shared.do:L1138:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 16 51"' // WFLOG-INJECTED
global WFRD1999 `"end "rd2017/lib/shared.do:L1138:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 16 51"' // WFLOG-INJECTED
global WFRD2000 `"start "rd2017/lib/shared.do:L1139:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 17 51"' // WFLOG-INJECTED
global WFRD2001 `"end "rd2017/lib/shared.do:L1139:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 17 51"' // WFLOG-INJECTED
global WFRD2002 `"start "rd2017/lib/shared.do:L1140:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 18 51"' // WFLOG-INJECTED
global WFRD2003 `"end "rd2017/lib/shared.do:L1140:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 18 51"' // WFLOG-INJECTED
global WFRD2004 `"start "rd2017/lib/shared.do:L1141:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 19 51"' // WFLOG-INJECTED
global WFRD2005 `"end "rd2017/lib/shared.do:L1141:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 19 51"' // WFLOG-INJECTED
global WFRD2006 `"start "rd2017/lib/shared.do:L1142:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 20 51"' // WFLOG-INJECTED
global WFRD2007 `"end "rd2017/lib/shared.do:L1142:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 20 51"' // WFLOG-INJECTED
global WFRD2008 `"start "rd2017/lib/shared.do:L1143:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 21 51"' // WFLOG-INJECTED
global WFRD2009 `"end "rd2017/lib/shared.do:L1143:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 21 51"' // WFLOG-INJECTED
global WFRD2010 `"start "rd2017/lib/shared.do:L1144:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 22 51"' // WFLOG-INJECTED
global WFRD2011 `"end "rd2017/lib/shared.do:L1144:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 22 51"' // WFLOG-INJECTED
global WFRD2012 `"start "rd2017/lib/shared.do:L1145:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 23 51"' // WFLOG-INJECTED
global WFRD2013 `"end "rd2017/lib/shared.do:L1145:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 23 51"' // WFLOG-INJECTED
global WFRD2014 `"start "rd2017/lib/shared.do:L1146:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 24 51"' // WFLOG-INJECTED
global WFRD2015 `"end "rd2017/lib/shared.do:L1146:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 24 51"' // WFLOG-INJECTED
global WFRD2016 `"start "rd2017/lib/shared.do:L1147:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 25 51"' // WFLOG-INJECTED
global WFRD2017 `"end "rd2017/lib/shared.do:L1147:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 25 51"' // WFLOG-INJECTED
global WFRD2018 `"start "rd2017/lib/shared.do:L1148:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 26 51"' // WFLOG-INJECTED
global WFRD2019 `"end "rd2017/lib/shared.do:L1148:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 26 51"' // WFLOG-INJECTED
global WFRD2020 `"start "rd2017/lib/shared.do:L1149:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 27 51"' // WFLOG-INJECTED
global WFRD2021 `"end "rd2017/lib/shared.do:L1149:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 27 51"' // WFLOG-INJECTED
global WFRD2022 `"start "rd2017/lib/shared.do:L1150:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 28 51"' // WFLOG-INJECTED
global WFRD2023 `"end "rd2017/lib/shared.do:L1150:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 28 51"' // WFLOG-INJECTED
global WFRD2024 `"start "rd2017/lib/shared.do:L1151:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 29 51"' // WFLOG-INJECTED
global WFRD2025 `"end "rd2017/lib/shared.do:L1151:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 29 51"' // WFLOG-INJECTED
global WFRD2026 `"start "rd2017/lib/shared.do:L1152:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 30 51"' // WFLOG-INJECTED
global WFRD2027 `"end "rd2017/lib/shared.do:L1152:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 30 51"' // WFLOG-INJECTED
global WFRD2028 `"start "rd2017/lib/shared.do:L1153:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 31 51"' // WFLOG-INJECTED
global WFRD2029 `"end "rd2017/lib/shared.do:L1153:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 31 51"' // WFLOG-INJECTED
global WFRD2030 `"start "rd2017/lib/shared.do:L1154:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 32 51"' // WFLOG-INJECTED
global WFRD2031 `"end "rd2017/lib/shared.do:L1154:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 32 51"' // WFLOG-INJECTED
global WFRD2032 `"start "rd2017/lib/shared.do:L1155:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 33 51"' // WFLOG-INJECTED
global WFRD2033 `"end "rd2017/lib/shared.do:L1155:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 33 51"' // WFLOG-INJECTED
global WFRD2034 `"start "rd2017/lib/shared.do:L1156:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 34 51"' // WFLOG-INJECTED
global WFRD2035 `"end "rd2017/lib/shared.do:L1156:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 34 51"' // WFLOG-INJECTED
global WFRD2036 `"start "rd2017/lib/shared.do:L1157:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 35 51"' // WFLOG-INJECTED
global WFRD2037 `"end "rd2017/lib/shared.do:L1157:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 35 51"' // WFLOG-INJECTED
global WFRD2038 `"start "rd2017/lib/shared.do:L1158:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 36 51"' // WFLOG-INJECTED
global WFRD2039 `"end "rd2017/lib/shared.do:L1158:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 36 51"' // WFLOG-INJECTED
global WFRD2040 `"start "rd2017/lib/shared.do:L1159:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 37 51"' // WFLOG-INJECTED
global WFRD2041 `"end "rd2017/lib/shared.do:L1159:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 37 51"' // WFLOG-INJECTED
global WFRD2042 `"start "rd2017/lib/shared.do:L1160:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 38 51"' // WFLOG-INJECTED
global WFRD2043 `"end "rd2017/lib/shared.do:L1160:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 38 51"' // WFLOG-INJECTED
global WFRD2044 `"start "rd2017/lib/shared.do:L1161:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 39 51"' // WFLOG-INJECTED
global WFRD2045 `"end "rd2017/lib/shared.do:L1161:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 39 51"' // WFLOG-INJECTED
global WFRD2046 `"start "rd2017/lib/shared.do:L1162:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 40 51"' // WFLOG-INJECTED
global WFRD2047 `"end "rd2017/lib/shared.do:L1162:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 40 51"' // WFLOG-INJECTED
global WFRD2048 `"start "rd2017/lib/shared.do:L1163:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 41 51"' // WFLOG-INJECTED
global WFRD2049 `"end "rd2017/lib/shared.do:L1163:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 41 51"' // WFLOG-INJECTED
global WFRD2050 `"start "rd2017/lib/shared.do:L1164:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 42 51"' // WFLOG-INJECTED
global WFRD2051 `"end "rd2017/lib/shared.do:L1164:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 42 51"' // WFLOG-INJECTED
global WFRD2052 `"start "rd2017/lib/shared.do:L1165:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 43 51"' // WFLOG-INJECTED
global WFRD2053 `"end "rd2017/lib/shared.do:L1165:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 43 51"' // WFLOG-INJECTED
global WFRD2054 `"start "rd2017/lib/shared.do:L1166:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 44 51"' // WFLOG-INJECTED
global WFRD2055 `"end "rd2017/lib/shared.do:L1166:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 44 51"' // WFLOG-INJECTED
global WFRD2056 `"start "rd2017/lib/shared.do:L1167:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 45 51"' // WFLOG-INJECTED
global WFRD2057 `"end "rd2017/lib/shared.do:L1167:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 45 51"' // WFLOG-INJECTED
global WFRD2058 `"start "rd2017/lib/shared.do:L1168:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 46 51"' // WFLOG-INJECTED
global WFRD2059 `"end "rd2017/lib/shared.do:L1168:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 46 51"' // WFLOG-INJECTED
global WFRD2060 `"start "rd2017/lib/shared.do:L1169:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 47 51"' // WFLOG-INJECTED
global WFRD2061 `"end "rd2017/lib/shared.do:L1169:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 47 51"' // WFLOG-INJECTED
global WFRD2062 `"start "rd2017/lib/shared.do:L1170:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 48 51"' // WFLOG-INJECTED
global WFRD2063 `"end "rd2017/lib/shared.do:L1170:step-local" "rd2017/lib/shared.do:L1122:block-body" "statement" 48 51"' // WFLOG-INJECTED
global WFRD2064 `"start "rd2017/lib/shared.do:L1171:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 49 51"' // WFLOG-INJECTED
global WFRD2065 `"end "rd2017/lib/shared.do:L1171:step-assert" "rd2017/lib/shared.do:L1122:block-body" "statement" 49 51"' // WFLOG-INJECTED
global WFRD2066 `"start "rd2017/lib/shared.do:L1172:step-isid" "rd2017/lib/shared.do:L1122:block-body" "statement" 50 51"' // WFLOG-INJECTED
global WFRD2067 `"end "rd2017/lib/shared.do:L1172:step-isid" "rd2017/lib/shared.do:L1122:block-body" "statement" 50 51"' // WFLOG-INJECTED
global WFRD2068 `"start "rd2017/lib/shared.do:L1173:step-exit" "rd2017/lib/shared.do:L1122:block-body" "statement" 51 51"' // WFLOG-INJECTED
global WFRD2069 `"end "rd2017/lib/shared.do:L1173:step-exit" "rd2017/lib/shared.do:L1122:block-body" "statement" 51 51"' // WFLOG-INJECTED
global WFRD2070 `"end "rd2017/lib/shared.do:L1122:block-body" "rd2017/lib/shared.do:L1122:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2071 `"end "rd2017/lib/shared.do:L1122:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 11 18"' // WFLOG-INJECTED
global WFRD2072 `"start "rd2017/lib/shared.do:L1175:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 12 18"' // WFLOG-INJECTED
global WFRD2073 `"start "rd2017/lib/shared.do:L1175:block-body" "rd2017/lib/shared.do:L1175:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2074 `"start "rd2017/lib/shared.do:L1176:step-unab" "rd2017/lib/shared.do:L1175:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD2075 `"end "rd2017/lib/shared.do:L1176:step-unab" "rd2017/lib/shared.do:L1175:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD2076 `"start "rd2017/lib/shared.do:L1177:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD2077 `"end "rd2017/lib/shared.do:L1177:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD2078 `"start "rd2017/lib/shared.do:L1178:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD2079 `"end "rd2017/lib/shared.do:L1178:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD2080 `"start "rd2017/lib/shared.do:L1179:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD2081 `"end "rd2017/lib/shared.do:L1179:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD2082 `"start "rd2017/lib/shared.do:L1180:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD2083 `"end "rd2017/lib/shared.do:L1180:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD2084 `"start "rd2017/lib/shared.do:L1181:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD2085 `"end "rd2017/lib/shared.do:L1181:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD2086 `"start "rd2017/lib/shared.do:L1182:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD2087 `"end "rd2017/lib/shared.do:L1182:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD2088 `"start "rd2017/lib/shared.do:L1183:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD2089 `"end "rd2017/lib/shared.do:L1183:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD2090 `"start "rd2017/lib/shared.do:L1184:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD2091 `"end "rd2017/lib/shared.do:L1184:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD2092 `"start "rd2017/lib/shared.do:L1185:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD2093 `"end "rd2017/lib/shared.do:L1185:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD2094 `"start "rd2017/lib/shared.do:L1186:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD2095 `"end "rd2017/lib/shared.do:L1186:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD2096 `"start "rd2017/lib/shared.do:L1187:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD2097 `"end "rd2017/lib/shared.do:L1187:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD2098 `"start "rd2017/lib/shared.do:L1188:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD2099 `"end "rd2017/lib/shared.do:L1188:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD2100 `"start "rd2017/lib/shared.do:L1189:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD2101 `"end "rd2017/lib/shared.do:L1189:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD2102 `"start "rd2017/lib/shared.do:L1190:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD2103 `"end "rd2017/lib/shared.do:L1190:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD2104 `"start "rd2017/lib/shared.do:L1191:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD2105 `"end "rd2017/lib/shared.do:L1191:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD2106 `"start "rd2017/lib/shared.do:L1192:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD2107 `"end "rd2017/lib/shared.do:L1192:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD2108 `"start "rd2017/lib/shared.do:L1193:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD2109 `"end "rd2017/lib/shared.do:L1193:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD2110 `"start "rd2017/lib/shared.do:L1194:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD2111 `"end "rd2017/lib/shared.do:L1194:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD2112 `"start "rd2017/lib/shared.do:L1195:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD2113 `"end "rd2017/lib/shared.do:L1195:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD2114 `"start "rd2017/lib/shared.do:L1196:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD2115 `"end "rd2017/lib/shared.do:L1196:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD2116 `"start "rd2017/lib/shared.do:L1197:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD2117 `"end "rd2017/lib/shared.do:L1197:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD2118 `"start "rd2017/lib/shared.do:L1198:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD2119 `"end "rd2017/lib/shared.do:L1198:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD2120 `"start "rd2017/lib/shared.do:L1199:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD2121 `"end "rd2017/lib/shared.do:L1199:step-local" "rd2017/lib/shared.do:L1175:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD2122 `"start "rd2017/lib/shared.do:L1200:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD2123 `"end "rd2017/lib/shared.do:L1200:step-assert" "rd2017/lib/shared.do:L1175:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD2124 `"start "rd2017/lib/shared.do:L1201:step-isid" "rd2017/lib/shared.do:L1175:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD2125 `"end "rd2017/lib/shared.do:L1201:step-isid" "rd2017/lib/shared.do:L1175:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD2126 `"start "rd2017/lib/shared.do:L1202:step-exit" "rd2017/lib/shared.do:L1175:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD2127 `"end "rd2017/lib/shared.do:L1202:step-exit" "rd2017/lib/shared.do:L1175:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD2128 `"end "rd2017/lib/shared.do:L1175:block-body" "rd2017/lib/shared.do:L1175:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2129 `"end "rd2017/lib/shared.do:L1175:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 12 18"' // WFLOG-INJECTED
global WFRD2130 `"start "rd2017/lib/shared.do:L1204:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 13 18"' // WFLOG-INJECTED
global WFRD2131 `"start "rd2017/lib/shared.do:L1204:block-body" "rd2017/lib/shared.do:L1204:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2132 `"start "rd2017/lib/shared.do:L1205:step-unab" "rd2017/lib/shared.do:L1204:block-body" "statement" 1 37"' // WFLOG-INJECTED
global WFRD2133 `"end "rd2017/lib/shared.do:L1205:step-unab" "rd2017/lib/shared.do:L1204:block-body" "statement" 1 37"' // WFLOG-INJECTED
global WFRD2134 `"start "rd2017/lib/shared.do:L1206:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 2 37"' // WFLOG-INJECTED
global WFRD2135 `"end "rd2017/lib/shared.do:L1206:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 2 37"' // WFLOG-INJECTED
global WFRD2136 `"start "rd2017/lib/shared.do:L1207:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 3 37"' // WFLOG-INJECTED
global WFRD2137 `"end "rd2017/lib/shared.do:L1207:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 3 37"' // WFLOG-INJECTED
global WFRD2138 `"start "rd2017/lib/shared.do:L1208:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 4 37"' // WFLOG-INJECTED
global WFRD2139 `"end "rd2017/lib/shared.do:L1208:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 4 37"' // WFLOG-INJECTED
global WFRD2140 `"start "rd2017/lib/shared.do:L1209:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 5 37"' // WFLOG-INJECTED
global WFRD2141 `"end "rd2017/lib/shared.do:L1209:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 5 37"' // WFLOG-INJECTED
global WFRD2142 `"start "rd2017/lib/shared.do:L1210:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 6 37"' // WFLOG-INJECTED
global WFRD2143 `"end "rd2017/lib/shared.do:L1210:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 6 37"' // WFLOG-INJECTED
global WFRD2144 `"start "rd2017/lib/shared.do:L1211:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 7 37"' // WFLOG-INJECTED
global WFRD2145 `"end "rd2017/lib/shared.do:L1211:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 7 37"' // WFLOG-INJECTED
global WFRD2146 `"start "rd2017/lib/shared.do:L1212:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 8 37"' // WFLOG-INJECTED
global WFRD2147 `"end "rd2017/lib/shared.do:L1212:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 8 37"' // WFLOG-INJECTED
global WFRD2148 `"start "rd2017/lib/shared.do:L1213:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 9 37"' // WFLOG-INJECTED
global WFRD2149 `"end "rd2017/lib/shared.do:L1213:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 9 37"' // WFLOG-INJECTED
global WFRD2150 `"start "rd2017/lib/shared.do:L1214:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 10 37"' // WFLOG-INJECTED
global WFRD2151 `"end "rd2017/lib/shared.do:L1214:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 10 37"' // WFLOG-INJECTED
global WFRD2152 `"start "rd2017/lib/shared.do:L1215:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 11 37"' // WFLOG-INJECTED
global WFRD2153 `"end "rd2017/lib/shared.do:L1215:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 11 37"' // WFLOG-INJECTED
global WFRD2154 `"start "rd2017/lib/shared.do:L1216:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 12 37"' // WFLOG-INJECTED
global WFRD2155 `"end "rd2017/lib/shared.do:L1216:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 12 37"' // WFLOG-INJECTED
global WFRD2156 `"start "rd2017/lib/shared.do:L1217:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 13 37"' // WFLOG-INJECTED
global WFRD2157 `"end "rd2017/lib/shared.do:L1217:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 13 37"' // WFLOG-INJECTED
global WFRD2158 `"start "rd2017/lib/shared.do:L1218:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 14 37"' // WFLOG-INJECTED
global WFRD2159 `"end "rd2017/lib/shared.do:L1218:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 14 37"' // WFLOG-INJECTED
global WFRD2160 `"start "rd2017/lib/shared.do:L1219:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 15 37"' // WFLOG-INJECTED
global WFRD2161 `"end "rd2017/lib/shared.do:L1219:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 15 37"' // WFLOG-INJECTED
global WFRD2162 `"start "rd2017/lib/shared.do:L1220:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 16 37"' // WFLOG-INJECTED
global WFRD2163 `"end "rd2017/lib/shared.do:L1220:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 16 37"' // WFLOG-INJECTED
global WFRD2164 `"start "rd2017/lib/shared.do:L1221:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 17 37"' // WFLOG-INJECTED
global WFRD2165 `"end "rd2017/lib/shared.do:L1221:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 17 37"' // WFLOG-INJECTED
global WFRD2166 `"start "rd2017/lib/shared.do:L1222:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 18 37"' // WFLOG-INJECTED
global WFRD2167 `"end "rd2017/lib/shared.do:L1222:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 18 37"' // WFLOG-INJECTED
global WFRD2168 `"start "rd2017/lib/shared.do:L1223:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 19 37"' // WFLOG-INJECTED
global WFRD2169 `"end "rd2017/lib/shared.do:L1223:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 19 37"' // WFLOG-INJECTED
global WFRD2170 `"start "rd2017/lib/shared.do:L1224:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 20 37"' // WFLOG-INJECTED
global WFRD2171 `"end "rd2017/lib/shared.do:L1224:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 20 37"' // WFLOG-INJECTED
global WFRD2172 `"start "rd2017/lib/shared.do:L1225:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 21 37"' // WFLOG-INJECTED
global WFRD2173 `"end "rd2017/lib/shared.do:L1225:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 21 37"' // WFLOG-INJECTED
global WFRD2174 `"start "rd2017/lib/shared.do:L1226:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 22 37"' // WFLOG-INJECTED
global WFRD2175 `"end "rd2017/lib/shared.do:L1226:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 22 37"' // WFLOG-INJECTED
global WFRD2176 `"start "rd2017/lib/shared.do:L1227:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 23 37"' // WFLOG-INJECTED
global WFRD2177 `"end "rd2017/lib/shared.do:L1227:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 23 37"' // WFLOG-INJECTED
global WFRD2178 `"start "rd2017/lib/shared.do:L1228:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 24 37"' // WFLOG-INJECTED
global WFRD2179 `"end "rd2017/lib/shared.do:L1228:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 24 37"' // WFLOG-INJECTED
global WFRD2180 `"start "rd2017/lib/shared.do:L1229:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 25 37"' // WFLOG-INJECTED
global WFRD2181 `"end "rd2017/lib/shared.do:L1229:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 25 37"' // WFLOG-INJECTED
global WFRD2182 `"start "rd2017/lib/shared.do:L1230:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 26 37"' // WFLOG-INJECTED
global WFRD2183 `"end "rd2017/lib/shared.do:L1230:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 26 37"' // WFLOG-INJECTED
global WFRD2184 `"start "rd2017/lib/shared.do:L1231:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 27 37"' // WFLOG-INJECTED
global WFRD2185 `"end "rd2017/lib/shared.do:L1231:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 27 37"' // WFLOG-INJECTED
global WFRD2186 `"start "rd2017/lib/shared.do:L1232:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 28 37"' // WFLOG-INJECTED
global WFRD2187 `"end "rd2017/lib/shared.do:L1232:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 28 37"' // WFLOG-INJECTED
global WFRD2188 `"start "rd2017/lib/shared.do:L1233:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 29 37"' // WFLOG-INJECTED
global WFRD2189 `"end "rd2017/lib/shared.do:L1233:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 29 37"' // WFLOG-INJECTED
global WFRD2190 `"start "rd2017/lib/shared.do:L1234:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 30 37"' // WFLOG-INJECTED
global WFRD2191 `"end "rd2017/lib/shared.do:L1234:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 30 37"' // WFLOG-INJECTED
global WFRD2192 `"start "rd2017/lib/shared.do:L1235:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 31 37"' // WFLOG-INJECTED
global WFRD2193 `"end "rd2017/lib/shared.do:L1235:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 31 37"' // WFLOG-INJECTED
global WFRD2194 `"start "rd2017/lib/shared.do:L1236:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 32 37"' // WFLOG-INJECTED
global WFRD2195 `"end "rd2017/lib/shared.do:L1236:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 32 37"' // WFLOG-INJECTED
global WFRD2196 `"start "rd2017/lib/shared.do:L1237:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 33 37"' // WFLOG-INJECTED
global WFRD2197 `"end "rd2017/lib/shared.do:L1237:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 33 37"' // WFLOG-INJECTED
global WFRD2198 `"start "rd2017/lib/shared.do:L1238:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 34 37"' // WFLOG-INJECTED
global WFRD2199 `"end "rd2017/lib/shared.do:L1238:step-local" "rd2017/lib/shared.do:L1204:block-body" "statement" 34 37"' // WFLOG-INJECTED
global WFRD2200 `"start "rd2017/lib/shared.do:L1239:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 35 37"' // WFLOG-INJECTED
global WFRD2201 `"end "rd2017/lib/shared.do:L1239:step-assert" "rd2017/lib/shared.do:L1204:block-body" "statement" 35 37"' // WFLOG-INJECTED
global WFRD2202 `"start "rd2017/lib/shared.do:L1240:step-isid" "rd2017/lib/shared.do:L1204:block-body" "statement" 36 37"' // WFLOG-INJECTED
global WFRD2203 `"end "rd2017/lib/shared.do:L1240:step-isid" "rd2017/lib/shared.do:L1204:block-body" "statement" 36 37"' // WFLOG-INJECTED
global WFRD2204 `"start "rd2017/lib/shared.do:L1241:step-exit" "rd2017/lib/shared.do:L1204:block-body" "statement" 37 37"' // WFLOG-INJECTED
global WFRD2205 `"end "rd2017/lib/shared.do:L1241:step-exit" "rd2017/lib/shared.do:L1204:block-body" "statement" 37 37"' // WFLOG-INJECTED
global WFRD2206 `"end "rd2017/lib/shared.do:L1204:block-body" "rd2017/lib/shared.do:L1204:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2207 `"end "rd2017/lib/shared.do:L1204:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 13 18"' // WFLOG-INJECTED
global WFRD2208 `"start "rd2017/lib/shared.do:L1243:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 14 18"' // WFLOG-INJECTED
global WFRD2209 `"start "rd2017/lib/shared.do:L1243:block-body" "rd2017/lib/shared.do:L1243:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2210 `"start "rd2017/lib/shared.do:L1244:step-unab" "rd2017/lib/shared.do:L1243:block-body" "statement" 1 16"' // WFLOG-INJECTED
global WFRD2211 `"end "rd2017/lib/shared.do:L1244:step-unab" "rd2017/lib/shared.do:L1243:block-body" "statement" 1 16"' // WFLOG-INJECTED
global WFRD2212 `"start "rd2017/lib/shared.do:L1245:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 2 16"' // WFLOG-INJECTED
global WFRD2213 `"end "rd2017/lib/shared.do:L1245:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 2 16"' // WFLOG-INJECTED
global WFRD2214 `"start "rd2017/lib/shared.do:L1246:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 3 16"' // WFLOG-INJECTED
global WFRD2215 `"end "rd2017/lib/shared.do:L1246:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 3 16"' // WFLOG-INJECTED
global WFRD2216 `"start "rd2017/lib/shared.do:L1247:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 4 16"' // WFLOG-INJECTED
global WFRD2217 `"end "rd2017/lib/shared.do:L1247:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 4 16"' // WFLOG-INJECTED
global WFRD2218 `"start "rd2017/lib/shared.do:L1248:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 5 16"' // WFLOG-INJECTED
global WFRD2219 `"end "rd2017/lib/shared.do:L1248:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 5 16"' // WFLOG-INJECTED
global WFRD2220 `"start "rd2017/lib/shared.do:L1249:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 6 16"' // WFLOG-INJECTED
global WFRD2221 `"end "rd2017/lib/shared.do:L1249:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 6 16"' // WFLOG-INJECTED
global WFRD2222 `"start "rd2017/lib/shared.do:L1250:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 7 16"' // WFLOG-INJECTED
global WFRD2223 `"end "rd2017/lib/shared.do:L1250:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 7 16"' // WFLOG-INJECTED
global WFRD2224 `"start "rd2017/lib/shared.do:L1251:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 8 16"' // WFLOG-INJECTED
global WFRD2225 `"end "rd2017/lib/shared.do:L1251:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 8 16"' // WFLOG-INJECTED
global WFRD2226 `"start "rd2017/lib/shared.do:L1252:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 9 16"' // WFLOG-INJECTED
global WFRD2227 `"end "rd2017/lib/shared.do:L1252:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 9 16"' // WFLOG-INJECTED
global WFRD2228 `"start "rd2017/lib/shared.do:L1253:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 10 16"' // WFLOG-INJECTED
global WFRD2229 `"end "rd2017/lib/shared.do:L1253:step-local" "rd2017/lib/shared.do:L1243:block-body" "statement" 10 16"' // WFLOG-INJECTED
global WFRD2230 `"start "rd2017/lib/shared.do:L1254:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 11 16"' // WFLOG-INJECTED
global WFRD2231 `"end "rd2017/lib/shared.do:L1254:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 11 16"' // WFLOG-INJECTED
global WFRD2232 `"start "rd2017/lib/shared.do:L1255:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 12 16"' // WFLOG-INJECTED
global WFRD2233 `"end "rd2017/lib/shared.do:L1255:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 12 16"' // WFLOG-INJECTED
global WFRD2234 `"start "rd2017/lib/shared.do:L1256:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 13 16"' // WFLOG-INJECTED
global WFRD2235 `"end "rd2017/lib/shared.do:L1256:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 13 16"' // WFLOG-INJECTED
global WFRD2236 `"start "rd2017/lib/shared.do:L1257:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 14 16"' // WFLOG-INJECTED
global WFRD2237 `"end "rd2017/lib/shared.do:L1257:step-assert" "rd2017/lib/shared.do:L1243:block-body" "statement" 14 16"' // WFLOG-INJECTED
global WFRD2238 `"start "rd2017/lib/shared.do:L1258:step-isid" "rd2017/lib/shared.do:L1243:block-body" "statement" 15 16"' // WFLOG-INJECTED
global WFRD2239 `"end "rd2017/lib/shared.do:L1258:step-isid" "rd2017/lib/shared.do:L1243:block-body" "statement" 15 16"' // WFLOG-INJECTED
global WFRD2240 `"start "rd2017/lib/shared.do:L1259:step-exit" "rd2017/lib/shared.do:L1243:block-body" "statement" 16 16"' // WFLOG-INJECTED
global WFRD2241 `"end "rd2017/lib/shared.do:L1259:step-exit" "rd2017/lib/shared.do:L1243:block-body" "statement" 16 16"' // WFLOG-INJECTED
global WFRD2242 `"end "rd2017/lib/shared.do:L1243:block-body" "rd2017/lib/shared.do:L1243:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2243 `"end "rd2017/lib/shared.do:L1243:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 14 18"' // WFLOG-INJECTED
global WFRD2244 `"start "rd2017/lib/shared.do:L1261:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 15 18"' // WFLOG-INJECTED
global WFRD2245 `"start "rd2017/lib/shared.do:L1261:block-body" "rd2017/lib/shared.do:L1261:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2246 `"start "rd2017/lib/shared.do:L1262:step-unab" "rd2017/lib/shared.do:L1261:block-body" "statement" 1 21"' // WFLOG-INJECTED
global WFRD2247 `"end "rd2017/lib/shared.do:L1262:step-unab" "rd2017/lib/shared.do:L1261:block-body" "statement" 1 21"' // WFLOG-INJECTED
global WFRD2248 `"start "rd2017/lib/shared.do:L1263:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 2 21"' // WFLOG-INJECTED
global WFRD2249 `"end "rd2017/lib/shared.do:L1263:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 2 21"' // WFLOG-INJECTED
global WFRD2250 `"start "rd2017/lib/shared.do:L1264:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 3 21"' // WFLOG-INJECTED
global WFRD2251 `"end "rd2017/lib/shared.do:L1264:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 3 21"' // WFLOG-INJECTED
global WFRD2252 `"start "rd2017/lib/shared.do:L1265:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 4 21"' // WFLOG-INJECTED
global WFRD2253 `"end "rd2017/lib/shared.do:L1265:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 4 21"' // WFLOG-INJECTED
global WFRD2254 `"start "rd2017/lib/shared.do:L1266:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 5 21"' // WFLOG-INJECTED
global WFRD2255 `"end "rd2017/lib/shared.do:L1266:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 5 21"' // WFLOG-INJECTED
global WFRD2256 `"start "rd2017/lib/shared.do:L1267:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 6 21"' // WFLOG-INJECTED
global WFRD2257 `"end "rd2017/lib/shared.do:L1267:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 6 21"' // WFLOG-INJECTED
global WFRD2258 `"start "rd2017/lib/shared.do:L1268:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 7 21"' // WFLOG-INJECTED
global WFRD2259 `"end "rd2017/lib/shared.do:L1268:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 7 21"' // WFLOG-INJECTED
global WFRD2260 `"start "rd2017/lib/shared.do:L1269:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 8 21"' // WFLOG-INJECTED
global WFRD2261 `"end "rd2017/lib/shared.do:L1269:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 8 21"' // WFLOG-INJECTED
global WFRD2262 `"start "rd2017/lib/shared.do:L1270:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 9 21"' // WFLOG-INJECTED
global WFRD2263 `"end "rd2017/lib/shared.do:L1270:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 9 21"' // WFLOG-INJECTED
global WFRD2264 `"start "rd2017/lib/shared.do:L1271:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 10 21"' // WFLOG-INJECTED
global WFRD2265 `"end "rd2017/lib/shared.do:L1271:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 10 21"' // WFLOG-INJECTED
global WFRD2266 `"start "rd2017/lib/shared.do:L1272:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 11 21"' // WFLOG-INJECTED
global WFRD2267 `"end "rd2017/lib/shared.do:L1272:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 11 21"' // WFLOG-INJECTED
global WFRD2268 `"start "rd2017/lib/shared.do:L1273:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 12 21"' // WFLOG-INJECTED
global WFRD2269 `"end "rd2017/lib/shared.do:L1273:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 12 21"' // WFLOG-INJECTED
global WFRD2270 `"start "rd2017/lib/shared.do:L1274:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 13 21"' // WFLOG-INJECTED
global WFRD2271 `"end "rd2017/lib/shared.do:L1274:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 13 21"' // WFLOG-INJECTED
global WFRD2272 `"start "rd2017/lib/shared.do:L1275:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 14 21"' // WFLOG-INJECTED
global WFRD2273 `"end "rd2017/lib/shared.do:L1275:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 14 21"' // WFLOG-INJECTED
global WFRD2274 `"start "rd2017/lib/shared.do:L1276:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 15 21"' // WFLOG-INJECTED
global WFRD2275 `"end "rd2017/lib/shared.do:L1276:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 15 21"' // WFLOG-INJECTED
global WFRD2276 `"start "rd2017/lib/shared.do:L1277:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 16 21"' // WFLOG-INJECTED
global WFRD2277 `"end "rd2017/lib/shared.do:L1277:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 16 21"' // WFLOG-INJECTED
global WFRD2278 `"start "rd2017/lib/shared.do:L1278:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 17 21"' // WFLOG-INJECTED
global WFRD2279 `"end "rd2017/lib/shared.do:L1278:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 17 21"' // WFLOG-INJECTED
global WFRD2280 `"start "rd2017/lib/shared.do:L1279:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 18 21"' // WFLOG-INJECTED
global WFRD2281 `"end "rd2017/lib/shared.do:L1279:step-local" "rd2017/lib/shared.do:L1261:block-body" "statement" 18 21"' // WFLOG-INJECTED
global WFRD2282 `"start "rd2017/lib/shared.do:L1280:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 19 21"' // WFLOG-INJECTED
global WFRD2283 `"end "rd2017/lib/shared.do:L1280:step-assert" "rd2017/lib/shared.do:L1261:block-body" "statement" 19 21"' // WFLOG-INJECTED
global WFRD2284 `"start "rd2017/lib/shared.do:L1281:step-isid" "rd2017/lib/shared.do:L1261:block-body" "statement" 20 21"' // WFLOG-INJECTED
global WFRD2285 `"end "rd2017/lib/shared.do:L1281:step-isid" "rd2017/lib/shared.do:L1261:block-body" "statement" 20 21"' // WFLOG-INJECTED
global WFRD2286 `"start "rd2017/lib/shared.do:L1282:step-exit" "rd2017/lib/shared.do:L1261:block-body" "statement" 21 21"' // WFLOG-INJECTED
global WFRD2287 `"end "rd2017/lib/shared.do:L1282:step-exit" "rd2017/lib/shared.do:L1261:block-body" "statement" 21 21"' // WFLOG-INJECTED
global WFRD2288 `"end "rd2017/lib/shared.do:L1261:block-body" "rd2017/lib/shared.do:L1261:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2289 `"end "rd2017/lib/shared.do:L1261:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 15 18"' // WFLOG-INJECTED
global WFRD2290 `"start "rd2017/lib/shared.do:L1284:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 16 18"' // WFLOG-INJECTED
global WFRD2291 `"start "rd2017/lib/shared.do:L1284:block-body" "rd2017/lib/shared.do:L1284:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2292 `"start "rd2017/lib/shared.do:L1285:step-unab" "rd2017/lib/shared.do:L1284:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD2293 `"end "rd2017/lib/shared.do:L1285:step-unab" "rd2017/lib/shared.do:L1284:block-body" "statement" 1 27"' // WFLOG-INJECTED
global WFRD2294 `"start "rd2017/lib/shared.do:L1286:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD2295 `"end "rd2017/lib/shared.do:L1286:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 2 27"' // WFLOG-INJECTED
global WFRD2296 `"start "rd2017/lib/shared.do:L1287:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD2297 `"end "rd2017/lib/shared.do:L1287:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 3 27"' // WFLOG-INJECTED
global WFRD2298 `"start "rd2017/lib/shared.do:L1288:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD2299 `"end "rd2017/lib/shared.do:L1288:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 4 27"' // WFLOG-INJECTED
global WFRD2300 `"start "rd2017/lib/shared.do:L1289:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD2301 `"end "rd2017/lib/shared.do:L1289:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 5 27"' // WFLOG-INJECTED
global WFRD2302 `"start "rd2017/lib/shared.do:L1290:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD2303 `"end "rd2017/lib/shared.do:L1290:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 6 27"' // WFLOG-INJECTED
global WFRD2304 `"start "rd2017/lib/shared.do:L1291:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD2305 `"end "rd2017/lib/shared.do:L1291:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 7 27"' // WFLOG-INJECTED
global WFRD2306 `"start "rd2017/lib/shared.do:L1292:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD2307 `"end "rd2017/lib/shared.do:L1292:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 8 27"' // WFLOG-INJECTED
global WFRD2308 `"start "rd2017/lib/shared.do:L1293:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD2309 `"end "rd2017/lib/shared.do:L1293:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 9 27"' // WFLOG-INJECTED
global WFRD2310 `"start "rd2017/lib/shared.do:L1294:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD2311 `"end "rd2017/lib/shared.do:L1294:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 10 27"' // WFLOG-INJECTED
global WFRD2312 `"start "rd2017/lib/shared.do:L1295:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD2313 `"end "rd2017/lib/shared.do:L1295:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 11 27"' // WFLOG-INJECTED
global WFRD2314 `"start "rd2017/lib/shared.do:L1296:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD2315 `"end "rd2017/lib/shared.do:L1296:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 12 27"' // WFLOG-INJECTED
global WFRD2316 `"start "rd2017/lib/shared.do:L1297:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD2317 `"end "rd2017/lib/shared.do:L1297:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 13 27"' // WFLOG-INJECTED
global WFRD2318 `"start "rd2017/lib/shared.do:L1298:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD2319 `"end "rd2017/lib/shared.do:L1298:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 14 27"' // WFLOG-INJECTED
global WFRD2320 `"start "rd2017/lib/shared.do:L1299:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD2321 `"end "rd2017/lib/shared.do:L1299:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 15 27"' // WFLOG-INJECTED
global WFRD2322 `"start "rd2017/lib/shared.do:L1300:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD2323 `"end "rd2017/lib/shared.do:L1300:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 16 27"' // WFLOG-INJECTED
global WFRD2324 `"start "rd2017/lib/shared.do:L1301:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD2325 `"end "rd2017/lib/shared.do:L1301:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 17 27"' // WFLOG-INJECTED
global WFRD2326 `"start "rd2017/lib/shared.do:L1302:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD2327 `"end "rd2017/lib/shared.do:L1302:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 18 27"' // WFLOG-INJECTED
global WFRD2328 `"start "rd2017/lib/shared.do:L1303:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD2329 `"end "rd2017/lib/shared.do:L1303:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 19 27"' // WFLOG-INJECTED
global WFRD2330 `"start "rd2017/lib/shared.do:L1304:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD2331 `"end "rd2017/lib/shared.do:L1304:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 20 27"' // WFLOG-INJECTED
global WFRD2332 `"start "rd2017/lib/shared.do:L1305:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD2333 `"end "rd2017/lib/shared.do:L1305:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 21 27"' // WFLOG-INJECTED
global WFRD2334 `"start "rd2017/lib/shared.do:L1306:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD2335 `"end "rd2017/lib/shared.do:L1306:step-local" "rd2017/lib/shared.do:L1284:block-body" "statement" 22 27"' // WFLOG-INJECTED
global WFRD2336 `"start "rd2017/lib/shared.do:L1307:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD2337 `"end "rd2017/lib/shared.do:L1307:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 23 27"' // WFLOG-INJECTED
global WFRD2338 `"start "rd2017/lib/shared.do:L1308:step-isid" "rd2017/lib/shared.do:L1284:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD2339 `"end "rd2017/lib/shared.do:L1308:step-isid" "rd2017/lib/shared.do:L1284:block-body" "statement" 24 27"' // WFLOG-INJECTED
global WFRD2340 `"start "rd2017/lib/shared.do:L1309:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD2341 `"end "rd2017/lib/shared.do:L1309:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 25 27"' // WFLOG-INJECTED
global WFRD2342 `"start "rd2017/lib/shared.do:L1310:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD2343 `"end "rd2017/lib/shared.do:L1310:step-assert" "rd2017/lib/shared.do:L1284:block-body" "statement" 26 27"' // WFLOG-INJECTED
global WFRD2344 `"start "rd2017/lib/shared.do:L1311:step-exit" "rd2017/lib/shared.do:L1284:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD2345 `"end "rd2017/lib/shared.do:L1311:step-exit" "rd2017/lib/shared.do:L1284:block-body" "statement" 27 27"' // WFLOG-INJECTED
global WFRD2346 `"end "rd2017/lib/shared.do:L1284:block-body" "rd2017/lib/shared.do:L1284:step-if" "block" 1 1"' // WFLOG-INJECTED
global WFRD2347 `"end "rd2017/lib/shared.do:L1284:step-if" "rd2017/lib/shared.do:L831:program-body" "statement" 16 18"' // WFLOG-INJECTED
global WFRD2348 `"start "rd2017/lib/shared.do:L1313:step-display" "rd2017/lib/shared.do:L831:program-body" "statement" 17 18"' // WFLOG-INJECTED
global WFRD2349 `"end "rd2017/lib/shared.do:L1313:step-display" "rd2017/lib/shared.do:L831:program-body" "statement" 17 18"' // WFLOG-INJECTED
global WFRD2350 `"start "rd2017/lib/shared.do:L1314:step-exit" "rd2017/lib/shared.do:L831:program-body" "statement" 18 18"' // WFLOG-INJECTED
global WFRD2351 `"end "rd2017/lib/shared.do:L1314:step-exit" "rd2017/lib/shared.do:L831:program-body" "statement" 18 18"' // WFLOG-INJECTED
global WFRD2352 `"end "rd2017/lib/shared.do:L831:program-body" "" "program" 1 1"' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1:step-version" "rd2017/lib/shared.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
version 17
capture noisily __wf_progress end "rd2017/lib/shared.do:L1:step-version" "rd2017/lib/shared.do:L1:file" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L2:step-set" "rd2017/lib/shared.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
set varabbrev off
capture noisily __wf_progress end "rd2017/lib/shared.do:L2:step-set" "rd2017/lib/shared.do:L1:file" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L3:step-program" "rd2017/lib/shared.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture program drop rd17_candidate
capture noisily __wf_progress end "rd2017/lib/shared.do:L3:step-program" "rd2017/lib/shared.do:L1:file" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L4:step-program" "rd2017/lib/shared.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_candidate; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Definisikan perintah pembentuk kandidat; opsi stage memilih bagian token, status universe, jawaban, atau audit yang dijalankan. // WFDOC-INJECTED
program define rd17_candidate
capture noisily __wf_progress start "rd2017/lib/shared.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L5:step-syntax" "rd2017/lib/shared.do:L4:program-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
 syntax, STAGE(string)
capture noisily __wf_progress end "rd2017/lib/shared.do:L5:step-syntax" "rd2017/lib/shared.do:L4:program-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L6:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "tokens". // WFDOC-INJECTED
* Pada stage tokens, pastikan raw_rnd17/raw_costrd17 berupa teks, rapikan spasi luar, lalu bedakan jawaban 1/2, teks kosong, sumber absen, dan teks lain. // WFDOC-INJECTED
 if "`stage'"=="tokens" {
capture noisily __wf_progress start "rd2017/lib/shared.do:L6:block-body" "rd2017/lib/shared.do:L6:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L7:step-confirm" "rd2017/lib/shared.do:L6:block-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
  confirm string variable raw_rnd17 raw_costrd17
capture noisily __wf_progress end "rd2017/lib/shared.do:L7:step-confirm" "rd2017/lib/shared.do:L6:block-body" "statement" 1 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L8:step-assert" "rd2017/lib/shared.do:L6:block-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
  assert inlist(parent_present,0,1) & inlist(child_present,0,1)
capture noisily __wf_progress end "rd2017/lib/shared.do:L8:step-assert" "rd2017/lib/shared.do:L6:block-body" "statement" 2 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L9:step-clonevar" "rd2017/lib/shared.do:L6:block-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
  clonevar parent_token=raw_rnd17
capture noisily __wf_progress end "rd2017/lib/shared.do:L9:step-clonevar" "rd2017/lib/shared.do:L6:block-body" "statement" 3 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L10:step-clonevar" "rd2017/lib/shared.do:L6:block-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
  clonevar child_token=raw_costrd17
capture noisily __wf_progress end "rd2017/lib/shared.do:L10:step-clonevar" "rd2017/lib/shared.do:L6:block-body" "statement" 4 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L11:step-replace" "rd2017/lib/shared.do:L6:block-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
  replace parent_token=ustrtrim(parent_token)
capture noisily __wf_progress end "rd2017/lib/shared.do:L11:step-replace" "rd2017/lib/shared.do:L6:block-body" "statement" 5 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L12:step-replace" "rd2017/lib/shared.do:L6:block-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
  replace child_token=ustrtrim(child_token)
capture noisily __wf_progress end "rd2017/lib/shared.do:L12:step-replace" "rd2017/lib/shared.do:L6:block-body" "statement" 6 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L13:step-foreach" "rd2017/lib/shared.do:L6:block-body" "loop" 7 8 `=_rc' "in" `"parent child"' // WFLOG-INJECTED
* Ulangi blok untuk side: parent, child. // WFDOC-INJECTED
  foreach side in parent child {
capture noisily __wf_progress start "rd2017/lib/shared.do:L13:iteration-body" "rd2017/lib/shared.do:L13:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L14:step-generate" "rd2017/lib/shared.do:L13:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
   generate str6 `side'_token_class="other"
capture noisily __wf_progress end "rd2017/lib/shared.do:L14:step-generate" "rd2017/lib/shared.do:L13:iteration-body" "statement" 1 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L15:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
   replace `side'_token_class=`side'_token if inlist(`side'_token,"1","2")
capture noisily __wf_progress end "rd2017/lib/shared.do:L15:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 2 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L16:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
   replace `side'_token_class="blank" if `side'_token==""
capture noisily __wf_progress end "rd2017/lib/shared.do:L16:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 3 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L17:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
   replace `side'_token_class="absent" if `side'_present==0
capture noisily __wf_progress end "rd2017/lib/shared.do:L17:step-replace" "rd2017/lib/shared.do:L13:iteration-body" "statement" 4 4 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L13:iteration-body" "rd2017/lib/shared.do:L13:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
  }
capture noisily __wf_progress end "rd2017/lib/shared.do:L13:step-foreach" "rd2017/lib/shared.do:L6:block-body" "loop" 7 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L19:step-exit" "rd2017/lib/shared.do:L6:block-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/shared.do:L19:step-exit" "rd2017/lib/shared.do:L6:block-body" "statement" 8 8 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L6:block-body" "rd2017/lib/shared.do:L6:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/shared.do:L6:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L21:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "universe". // WFDOC-INJECTED
* Pada stage universe, kode kandidat parent menjadi 0 untuk token 2, 1 untuk token 1, 2 untuk blank/other, dan 3 untuk absent; ini kelas kerja, bukan keputusan rilis. // WFDOC-INJECTED
 if "`stage'"=="universe" {
capture noisily __wf_progress start "rd2017/lib/shared.do:L21:block-body" "rd2017/lib/shared.do:L21:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L22:step-generate" "rd2017/lib/shared.do:L21:block-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L22:step-generate" "rd2017/lib/shared.do:L21:block-body" "statement" 1 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L23:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=0 if parent_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/shared.do:L23:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 2 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L24:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=1 if parent_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/shared.do:L24:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L25:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=2 if inlist(parent_token_class,"blank","other")
capture noisily __wf_progress end "rd2017/lib/shared.do:L25:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L26:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
  replace rd_universe_candidate=3 if parent_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/shared.do:L26:step-replace" "rd2017/lib/shared.do:L21:block-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L27:step-assert" "rd2017/lib/shared.do:L21:block-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
  assert inrange(rd_universe_candidate,0,3)
capture noisily __wf_progress end "rd2017/lib/shared.do:L27:step-assert" "rd2017/lib/shared.do:L21:block-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L28:step-exit" "rd2017/lib/shared.do:L21:block-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/shared.do:L28:step-exit" "rd2017/lib/shared.do:L21:block-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L21:block-body" "rd2017/lib/shared.do:L21:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/shared.do:L21:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 3 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L30:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "answer". // WFDOC-INJECTED
* Pada stage answer, jika universe=0, kelas child 1/2/blank/other/absent dipetakan ke status 0/1/2/3/6; universe=1 mendapat 4 dan universe=2/3 mendapat 5. external_candidate hanya 1 untuk status 0 atau 0 untuk status 1; lainnya tetap kosong. // WFDOC-INJECTED
 if "`stage'"=="answer" {
capture noisily __wf_progress start "rd2017/lib/shared.do:L30:block-body" "rd2017/lib/shared.do:L30:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L31:step-generate" "rd2017/lib/shared.do:L30:block-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L31:step-generate" "rd2017/lib/shared.do:L30:block-body" "statement" 1 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L32:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=4 if rd_universe_candidate==1
capture noisily __wf_progress end "rd2017/lib/shared.do:L32:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 2 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L33:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=5 if inlist(rd_universe_candidate,2,3)
capture noisily __wf_progress end "rd2017/lib/shared.do:L33:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 3 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L34:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=0 if rd_universe_candidate==0 & child_token_class=="1"
capture noisily __wf_progress end "rd2017/lib/shared.do:L34:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L35:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=1 if rd_universe_candidate==0 & child_token_class=="2"
capture noisily __wf_progress end "rd2017/lib/shared.do:L35:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L36:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=2 if rd_universe_candidate==0 & child_token_class=="blank"
capture noisily __wf_progress end "rd2017/lib/shared.do:L36:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 6 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L37:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=3 if rd_universe_candidate==0 & child_token_class=="other"
capture noisily __wf_progress end "rd2017/lib/shared.do:L37:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L38:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
  replace rd_answer_state_candidate=6 if rd_universe_candidate==0 & child_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/shared.do:L38:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 8 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L39:step-assert" "rd2017/lib/shared.do:L30:block-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
  assert inrange(rd_answer_state_candidate,0,6)
capture noisily __wf_progress end "rd2017/lib/shared.do:L39:step-assert" "rd2017/lib/shared.do:L30:block-body" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L40:step-generate" "rd2017/lib/shared.do:L30:block-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L40:step-generate" "rd2017/lib/shared.do:L30:block-body" "statement" 10 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L41:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
  replace rd_external_candidate=1 if rd_answer_state_candidate==0
capture noisily __wf_progress end "rd2017/lib/shared.do:L41:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L42:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
  replace rd_external_candidate=0 if rd_answer_state_candidate==1
capture noisily __wf_progress end "rd2017/lib/shared.do:L42:step-replace" "rd2017/lib/shared.do:L30:block-body" "statement" 12 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L43:step-assert" "rd2017/lib/shared.do:L30:block-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
  assert missing(rd_external_candidate) if !inlist(rd_answer_state_candidate,0,1)
capture noisily __wf_progress end "rd2017/lib/shared.do:L43:step-assert" "rd2017/lib/shared.do:L30:block-body" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L44:step-exit" "rd2017/lib/shared.do:L30:block-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/shared.do:L44:step-exit" "rd2017/lib/shared.do:L30:block-body" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L30:block-body" "rd2017/lib/shared.do:L30:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/shared.do:L30:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 4 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L46:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`stage'" sama dengan "audit". // WFDOC-INJECTED
* Stage audit menandai child nonblank di luar universe, memastikan flag audit sesuai gerbang, dan menetapkan measurement_admitted=0 serta primary_release=0. // WFDOC-INJECTED
 if "`stage'"=="audit" {
capture noisily __wf_progress start "rd2017/lib/shared.do:L46:block-body" "rd2017/lib/shared.do:L46:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L47:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
  generate byte outside_answer_candidate=rd_universe_candidate==1 & inlist(child_token_class,"1","2","other")
capture noisily __wf_progress end "rd2017/lib/shared.do:L47:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 1 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L48:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=0
capture noisily __wf_progress end "rd2017/lib/shared.do:L48:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 2 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L49:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=0
capture noisily __wf_progress end "rd2017/lib/shared.do:L49:step-generate" "rd2017/lib/shared.do:L46:block-body" "statement" 3 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L50:step-assert" "rd2017/lib/shared.do:L46:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
  assert missing(rd_external_candidate) if rd_universe_candidate!=0
capture noisily __wf_progress end "rd2017/lib/shared.do:L50:step-assert" "rd2017/lib/shared.do:L46:block-body" "statement" 4 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L51:step-assert" "rd2017/lib/shared.do:L46:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
  assert outside_answer_candidate==0 if rd_universe_candidate!=1
capture noisily __wf_progress end "rd2017/lib/shared.do:L51:step-assert" "rd2017/lib/shared.do:L46:block-body" "statement" 5 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L52:step-exit" "rd2017/lib/shared.do:L46:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress end "rd2017/lib/shared.do:L52:step-exit" "rd2017/lib/shared.do:L46:block-body" "statement" 6 6 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L46:block-body" "rd2017/lib/shared.do:L46:step-if" "block" 1 1 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/shared.do:L46:step-if" "rd2017/lib/shared.do:L4:program-body" "statement" 5 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L54:step-display" "rd2017/lib/shared.do:L4:program-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
 display as error "Undeclared classifier stage"
capture noisily __wf_progress end "rd2017/lib/shared.do:L54:step-display" "rd2017/lib/shared.do:L4:program-body" "statement" 6 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L55:step-exit" "rd2017/lib/shared.do:L4:program-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
 exit 198
capture noisily __wf_progress end "rd2017/lib/shared.do:L55:step-exit" "rd2017/lib/shared.do:L4:program-body" "statement" 7 7 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L4:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L4:step-program" "rd2017/lib/shared.do:L1:file" "statement" 4 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L57:step-program" "rd2017/lib/shared.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture program drop rd17_ratio
capture noisily __wf_progress end "rd2017/lib/shared.do:L57:step-program" "rd2017/lib/shared.do:L1:file" "statement" 5 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L58:step-program" "rd2017/lib/shared.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_ratio; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Definisikan dua rasio kandidat: yes/(yes+no) untuk yes di antara eligible yang diketahui, dan (yes+no)/eligible_n untuk cakupan jawaban diketahui; rasio hanya dihitung bila denominator positif, lalu percent=100×ratio. // WFDOC-INJECTED
program define rd17_ratio
capture noisily __wf_progress start "rd2017/lib/shared.do:L58:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L59:step-confirm" "rd2017/lib/shared.do:L58:program-body" "statement" 1 15 `=_rc' // WFLOG-INJECTED
 confirm numeric variable eligible_yes_n eligible_no_n eligible_n
capture noisily __wf_progress end "rd2017/lib/shared.do:L59:step-confirm" "rd2017/lib/shared.do:L58:program-body" "statement" 1 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L60:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 2 15 `=_rc' // WFLOG-INJECTED
 assert !missing(eligible_yes_n,eligible_no_n,eligible_n)
capture noisily __wf_progress end "rd2017/lib/shared.do:L60:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 2 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L61:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 3 15 `=_rc' // WFLOG-INJECTED
 assert eligible_yes_n>=0 & eligible_no_n>=0 & eligible_n>=eligible_yes_n+eligible_no_n
capture noisily __wf_progress end "rd2017/lib/shared.do:L61:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 3 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L62:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 4 15 `=_rc' // WFLOG-INJECTED
 assert inlist(estimate_id,"candidate_yes_among_known_eligible","candidate_known_response_coverage")
capture noisily __wf_progress end "rd2017/lib/shared.do:L62:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 4 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L63:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 5 15 `=_rc' // WFLOG-INJECTED
 generate long numerator_n=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L63:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 5 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L64:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 6 15 `=_rc' // WFLOG-INJECTED
 generate long denominator_n=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L64:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 6 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L65:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 7 15 `=_rc' // WFLOG-INJECTED
 replace numerator_n=eligible_yes_n if estimate_id=="candidate_yes_among_known_eligible"
capture noisily __wf_progress end "rd2017/lib/shared.do:L65:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 7 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L66:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 8 15 `=_rc' // WFLOG-INJECTED
 replace denominator_n=eligible_yes_n+eligible_no_n if estimate_id=="candidate_yes_among_known_eligible"
capture noisily __wf_progress end "rd2017/lib/shared.do:L66:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 8 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L67:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 9 15 `=_rc' // WFLOG-INJECTED
 replace numerator_n=eligible_yes_n+eligible_no_n if estimate_id=="candidate_known_response_coverage"
capture noisily __wf_progress end "rd2017/lib/shared.do:L67:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 9 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L68:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 10 15 `=_rc' // WFLOG-INJECTED
 replace denominator_n=eligible_n if estimate_id=="candidate_known_response_coverage"
capture noisily __wf_progress end "rd2017/lib/shared.do:L68:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 10 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L69:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 11 15 `=_rc' // WFLOG-INJECTED
 generate double ratio=.
capture noisily __wf_progress end "rd2017/lib/shared.do:L69:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 11 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L70:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 12 15 `=_rc' // WFLOG-INJECTED
 replace ratio=numerator_n/denominator_n if denominator_n>0 & !missing(denominator_n,numerator_n)
capture noisily __wf_progress end "rd2017/lib/shared.do:L70:step-replace" "rd2017/lib/shared.do:L58:program-body" "statement" 12 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L71:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 13 15 `=_rc' // WFLOG-INJECTED
 generate double percent=100*ratio if !missing(ratio)
capture noisily __wf_progress end "rd2017/lib/shared.do:L71:step-generate" "rd2017/lib/shared.do:L58:program-body" "statement" 13 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L72:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 14 15 `=_rc' // WFLOG-INJECTED
 assert missing(ratio) & missing(percent) if denominator_n==0
capture noisily __wf_progress end "rd2017/lib/shared.do:L72:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 14 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L73:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 15 15 `=_rc' // WFLOG-INJECTED
 assert inrange(ratio,0,1) & inrange(percent,0,100) if denominator_n>0
capture noisily __wf_progress end "rd2017/lib/shared.do:L73:step-assert" "rd2017/lib/shared.do:L58:program-body" "statement" 15 15 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L58:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L58:step-program" "rd2017/lib/shared.do:L1:file" "statement" 6 14 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/lib/shared.do:L76:step-program" "rd2017/lib/shared.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture program drop rd17_counts
capture noisily __wf_progress end "rd2017/lib/shared.do:L76:step-program" "rd2017/lib/shared.do:L1:file" "statement" 7 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L77:step-program" "rd2017/lib/shared.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_counts; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Hitung jumlah per tahun 2017 dan kategori token/status, pastikan pecahannya saling cocok dengan total, lalu siapkan tabel group counts yang ditandai candidate_only=1 dan measurement_admitted=0. // WFDOC-INJECTED
program define rd17_counts
capture noisily __wf_progress start "rd2017/lib/shared.do:L77:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L78:step-syntax" "rd2017/lib/shared.do:L77:program-body" "statement" 1 55 `=_rc' // WFLOG-INJECTED
 syntax, SAVING(string) EXPECTED(integer)
capture noisily __wf_progress end "rd2017/lib/shared.do:L78:step-syntax" "rd2017/lib/shared.do:L77:program-body" "statement" 1 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L79:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 2 55 `=_rc' // WFLOG-INJECTED
 assert _N==`expected'
capture noisily __wf_progress end "rd2017/lib/shared.do:L79:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 2 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L80:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 3 55 `=_rc' // WFLOG-INJECTED
 assert source_year==2017
capture noisily __wf_progress end "rd2017/lib/shared.do:L80:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 3 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L81:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 4 55 `=_rc' // WFLOG-INJECTED
 quietly count if source_year==2017
capture noisily __wf_progress end "rd2017/lib/shared.do:L81:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 4 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L82:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 5 55 `=_rc' // WFLOG-INJECTED
 local C1=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L82:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 5 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L83:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 6 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_universe_candidate==0
capture noisily __wf_progress end "rd2017/lib/shared.do:L83:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 6 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L84:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 7 55 `=_rc' // WFLOG-INJECTED
 local C2=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L84:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 7 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L85:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 8 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_universe_candidate==1
capture noisily __wf_progress end "rd2017/lib/shared.do:L85:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 8 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L86:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 9 55 `=_rc' // WFLOG-INJECTED
 local C3=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L86:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 9 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L87:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 10 55 `=_rc' // WFLOG-INJECTED
 quietly count if parent_token_class=="blank"
capture noisily __wf_progress end "rd2017/lib/shared.do:L87:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 10 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L88:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 11 55 `=_rc' // WFLOG-INJECTED
 local C4=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L88:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 11 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L89:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 12 55 `=_rc' // WFLOG-INJECTED
 quietly count if parent_token_class=="other"
capture noisily __wf_progress end "rd2017/lib/shared.do:L89:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 12 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L90:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 13 55 `=_rc' // WFLOG-INJECTED
 local C5=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L90:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 13 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L91:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 14 55 `=_rc' // WFLOG-INJECTED
 quietly count if parent_token_class=="absent"
capture noisily __wf_progress end "rd2017/lib/shared.do:L91:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 14 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L92:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 15 55 `=_rc' // WFLOG-INJECTED
 local C6=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L92:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 15 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L93:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 16 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_answer_state_candidate==0
capture noisily __wf_progress end "rd2017/lib/shared.do:L93:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 16 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L94:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 17 55 `=_rc' // WFLOG-INJECTED
 local C7=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L94:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 17 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L95:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 18 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_answer_state_candidate==1
capture noisily __wf_progress end "rd2017/lib/shared.do:L95:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 18 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L96:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 19 55 `=_rc' // WFLOG-INJECTED
 local C8=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L96:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 19 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L97:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 20 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_answer_state_candidate==2
capture noisily __wf_progress end "rd2017/lib/shared.do:L97:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 20 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L98:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 21 55 `=_rc' // WFLOG-INJECTED
 local C9=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L98:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 21 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L99:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 22 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_answer_state_candidate==3
capture noisily __wf_progress end "rd2017/lib/shared.do:L99:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 22 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L100:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 23 55 `=_rc' // WFLOG-INJECTED
 local C10=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L100:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 23 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L101:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 24 55 `=_rc' // WFLOG-INJECTED
 quietly count if rd_answer_state_candidate==6
capture noisily __wf_progress end "rd2017/lib/shared.do:L101:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 24 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L102:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 25 55 `=_rc' // WFLOG-INJECTED
 local C11=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L102:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 25 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L103:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 26 55 `=_rc' // WFLOG-INJECTED
 quietly count if inlist(rd_answer_state_candidate,0,1)
capture noisily __wf_progress end "rd2017/lib/shared.do:L103:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 26 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L104:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 27 55 `=_rc' // WFLOG-INJECTED
 local C12=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L104:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 27 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L105:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 28 55 `=_rc' // WFLOG-INJECTED
 quietly count if outside_answer_candidate==1
capture noisily __wf_progress end "rd2017/lib/shared.do:L105:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 28 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L106:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 29 55 `=_rc' // WFLOG-INJECTED
 local C13=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L106:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 29 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L107:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 30 55 `=_rc' // WFLOG-INJECTED
 quietly count if inlist(rd_universe_candidate,2,3) & inlist(child_token_class,"1","2","other")
capture noisily __wf_progress end "rd2017/lib/shared.do:L107:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 30 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L108:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 31 55 `=_rc' // WFLOG-INJECTED
 local C14=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L108:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 31 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L109:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 32 55 `=_rc' // WFLOG-INJECTED
 quietly count if inlist(rd_universe_candidate,2,3)
capture noisily __wf_progress end "rd2017/lib/shared.do:L109:step-count" "rd2017/lib/shared.do:L77:program-body" "statement" 32 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L110:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 33 55 `=_rc' // WFLOG-INJECTED
 local C15=r(N)
capture noisily __wf_progress end "rd2017/lib/shared.do:L110:step-local" "rd2017/lib/shared.do:L77:program-body" "statement" 33 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L111:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 34 55 `=_rc' // WFLOG-INJECTED
 assert `C1'==`C2'+`C3'+`C4'+`C5'+`C6'
capture noisily __wf_progress end "rd2017/lib/shared.do:L111:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 34 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L112:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 35 55 `=_rc' // WFLOG-INJECTED
 assert `C2'==`C7'+`C8'+`C9'+`C10'+`C11'
capture noisily __wf_progress end "rd2017/lib/shared.do:L112:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 35 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L113:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 36 55 `=_rc' // WFLOG-INJECTED
 assert `C12'==`C7'+`C8'
capture noisily __wf_progress end "rd2017/lib/shared.do:L113:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 36 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L114:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 37 55 `=_rc' // WFLOG-INJECTED
 assert `C15'==`C4'+`C5'+`C6'
capture noisily __wf_progress end "rd2017/lib/shared.do:L114:step-assert" "rd2017/lib/shared.do:L77:program-body" "statement" 37 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L115:step-tempname" "rd2017/lib/shared.do:L77:program-body" "statement" 38 55 `=_rc' // WFLOG-INJECTED
 tempname POST
capture noisily __wf_progress end "rd2017/lib/shared.do:L115:step-tempname" "rd2017/lib/shared.do:L77:program-body" "statement" 38 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L116:step-postfile" "rd2017/lib/shared.do:L77:program-body" "statement" 39 55 `=_rc' // WFLOG-INJECTED
* Siapkan tabel ringkasan; perintah post di bawah menambahkan hitungan atau hasil per kelompok. // WFDOC-INJECTED
 postfile `POST' int source_year str40 group_id long numerator_n str40 denominator_id long denominator_n byte candidate_only byte measurement_admitted using "`saving'", replace
capture noisily __wf_progress end "rd2017/lib/shared.do:L116:step-postfile" "rd2017/lib/shared.do:L77:program-body" "statement" 39 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L117:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 40 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("all_rows") (`C1') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L117:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 40 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L118:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 41 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible") (`C2') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L118:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 41 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L119:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 42 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("structural_skip") (`C3') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L119:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 42 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L120:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 43 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("parent_blank") (`C4') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L120:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 43 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L121:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 44 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("parent_invalid") (`C5') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L121:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 44 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L122:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 45 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("parent_absent") (`C6') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L122:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 45 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L123:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 46 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_yes") (`C7') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L123:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 46 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L124:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 47 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_no") (`C8') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L124:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 47 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L125:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 48 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_blank") (`C9') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L125:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 48 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L126:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 49 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_invalid") (`C10') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L126:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 49 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L127:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 50 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_child_absent") (`C11') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L127:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 50 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L128:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 51 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("eligible_known") (`C12') ("eligible") (`C2') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L128:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 51 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L129:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 52 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("outside_nonblank_child") (`C13') ("structural_skip") (`C3') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L129:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 52 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L130:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 53 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("unknown_parent_child_nonblank") (`C14') ("unknown_parent") (`C15') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L130:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 53 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L131:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 54 55 `=_rc' // WFLOG-INJECTED
 post `POST' (2017) ("unknown_parent") (`C15') ("all_rows") (`C1') (1) (0)
capture noisily __wf_progress end "rd2017/lib/shared.do:L131:step-post" "rd2017/lib/shared.do:L77:program-body" "statement" 54 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L132:step-postclose" "rd2017/lib/shared.do:L77:program-body" "statement" 55 55 `=_rc' // WFLOG-INJECTED
 postclose `POST'
capture noisily __wf_progress end "rd2017/lib/shared.do:L132:step-postclose" "rd2017/lib/shared.do:L77:program-body" "statement" 55 55 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L77:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L77:step-program" "rd2017/lib/shared.do:L1:file" "statement" 8 14 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/lib/shared.do:L135:step-program" "rd2017/lib/shared.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture program drop rd17_import
capture noisily __wf_progress end "rd2017/lib/shared.do:L135:step-program" "rd2017/lib/shared.do:L1:file" "statement" 9 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L136:step-program" "rd2017/lib/shared.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_import; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Impor CSV sebagai teks untuk semua kolom, dengan kutip ketat dan UTF-8; spec memilih kolom yang dikonversi, sedangkan teks nonkosong/non-titik yang gagal dibaca sebagai angka membuat assert berhenti. // WFDOC-INJECTED
program define rd17_import
capture noisily __wf_progress $WFRD0001 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0002 `=_rc' // WFLOG-INJECTED
 syntax, FILE(string) SPEC(string)
capture noisily __wf_progress $WFRD0003 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0004 `=_rc' // WFLOG-INJECTED
 import delimited using "`file'", varnames(1) case(preserve) stringcols(_all) bindquote(strict) encoding("UTF-8") clear
capture noisily __wf_progress $WFRD0005 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0006 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "candidate_2017". // WFDOC-INJECTED
 if "`spec'"=="candidate_2017" {
capture noisily __wf_progress $WFRD0007 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0008 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0009 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0010 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0012 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0013 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0014 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0015 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0016 `=_rc' // WFLOG-INJECTED
  rename source_row __rd17_raw
capture noisily __wf_progress $WFRD0017 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0018 `=_rc' // WFLOG-INJECTED
  generate int source_row=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0019 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0020 `=_rc' // WFLOG-INJECTED
  assert !missing(source_row) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0021 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0022 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0023 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0024 `=_rc' // WFLOG-INJECTED
  rename rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0025 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0026 `=_rc' // WFLOG-INJECTED
  generate double rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0027 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0028 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0029 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0030 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0031 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0032 `=_rc' // WFLOG-INJECTED
  rename val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0033 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0034 `=_rc' // WFLOG-INJECTED
  generate double val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0035 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0036 `=_rc' // WFLOG-INJECTED
  assert !missing(val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0037 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0038 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0039 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0040 `=_rc' // WFLOG-INJECTED
  rename vs_rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0041 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0042 `=_rc' // WFLOG-INJECTED
  generate byte vs_rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0043 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0044 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0045 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0046 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0047 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0048 `=_rc' // WFLOG-INJECTED
  rename vs_val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0049 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0050 `=_rc' // WFLOG-INJECTED
  generate byte vs_val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0051 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0052 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0053 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0054 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0055 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0056 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_own_token_class)<=6
capture noisily __wf_progress $WFRD0057 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0058 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_own_token_class
capture noisily __wf_progress $WFRD0059 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0060 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_external_token_class)<=6
capture noisily __wf_progress $WFRD0061 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0062 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_external_token_class
capture noisily __wf_progress $WFRD0063 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0064 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0065 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0066 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0067 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0068 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0069 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0070 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0071 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0072 `=_rc' // WFLOG-INJECTED
  rename rd_universe_candidate __rd17_raw
capture noisily __wf_progress $WFRD0073 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0074 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0075 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0076 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_universe_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0077 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0078 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0079 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0080 `=_rc' // WFLOG-INJECTED
  rename rd_answer_state_candidate __rd17_raw
capture noisily __wf_progress $WFRD0081 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0082 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0083 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0084 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_answer_state_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0085 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0086 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0087 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0088 `=_rc' // WFLOG-INJECTED
  rename rd_external_candidate __rd17_raw
capture noisily __wf_progress $WFRD0089 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0090 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0091 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0092 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_external_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0093 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0094 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0095 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0096 `=_rc' // WFLOG-INJECTED
  rename outside_answer_candidate __rd17_raw
capture noisily __wf_progress $WFRD0097 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0098 `=_rc' // WFLOG-INJECTED
  generate byte outside_answer_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0099 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0100 `=_rc' // WFLOG-INJECTED
  assert !missing(outside_answer_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0101 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0102 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0104 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0105 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0106 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0107 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0108 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0109 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0110 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0111 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0112 `=_rc' // WFLOG-INJECTED
  rename primary_release __rd17_raw
capture noisily __wf_progress $WFRD0113 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0114 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0115 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0116 `=_rc' // WFLOG-INJECTED
  assert !missing(primary_release) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0117 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0118 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0119 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0120 `=_rc' // WFLOG-INJECTED
  order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release
capture noisily __wf_progress $WFRD0121 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0122 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("candidate_2017")
capture noisily __wf_progress $WFRD0123 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0124 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0125 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0126 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0127 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0128 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "joint_counts". // WFDOC-INJECTED
 if "`spec'"=="joint_counts" {
capture noisily __wf_progress $WFRD0129 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0130 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0131 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0132 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0133 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0134 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0135 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0136 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0137 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0138 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0139 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0140 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0141 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0142 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0143 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0144 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0145 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0146 `=_rc' // WFLOG-INJECTED
  rename n __rd17_raw
capture noisily __wf_progress $WFRD0147 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0148 `=_rc' // WFLOG-INJECTED
  generate long n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0149 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0150 `=_rc' // WFLOG-INJECTED
  assert !missing(n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0151 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0152 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0153 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0154 `=_rc' // WFLOG-INJECTED
  rename all_rows __rd17_raw
capture noisily __wf_progress $WFRD0155 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0156 `=_rc' // WFLOG-INJECTED
  generate long all_rows=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0157 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0158 `=_rc' // WFLOG-INJECTED
  assert !missing(all_rows) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0159 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0160 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0161 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0162 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0163 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0164 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0165 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0166 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0167 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0168 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0169 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0170 `=_rc' // WFLOG-INJECTED
  order source_year parent_token_class child_token_class n all_rows measurement_admitted
capture noisily __wf_progress $WFRD0171 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0172 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("joint_counts")
capture noisily __wf_progress $WFRD0173 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0174 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0175 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0176 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0177 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0178 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "group_counts". // WFDOC-INJECTED
 if "`spec'"=="group_counts" {
capture noisily __wf_progress $WFRD0179 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0180 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0181 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0182 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0184 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0185 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0186 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0187 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0188 `=_rc' // WFLOG-INJECTED
  assert strlen(group_id)<=40
capture noisily __wf_progress $WFRD0189 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0190 `=_rc' // WFLOG-INJECTED
  recast str40 group_id
capture noisily __wf_progress $WFRD0191 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0192 `=_rc' // WFLOG-INJECTED
  rename numerator_n __rd17_raw
capture noisily __wf_progress $WFRD0193 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0194 `=_rc' // WFLOG-INJECTED
  generate long numerator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0195 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0196 `=_rc' // WFLOG-INJECTED
  assert !missing(numerator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0197 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0198 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0199 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0200 `=_rc' // WFLOG-INJECTED
  assert strlen(denominator_id)<=40
capture noisily __wf_progress $WFRD0201 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0202 `=_rc' // WFLOG-INJECTED
  recast str40 denominator_id
capture noisily __wf_progress $WFRD0203 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0204 `=_rc' // WFLOG-INJECTED
  rename denominator_n __rd17_raw
capture noisily __wf_progress $WFRD0205 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0206 `=_rc' // WFLOG-INJECTED
  generate long denominator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0207 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0208 `=_rc' // WFLOG-INJECTED
  assert !missing(denominator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0209 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0210 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0211 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0212 `=_rc' // WFLOG-INJECTED
  rename candidate_only __rd17_raw
capture noisily __wf_progress $WFRD0213 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0214 `=_rc' // WFLOG-INJECTED
  generate byte candidate_only=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0215 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0216 `=_rc' // WFLOG-INJECTED
  assert !missing(candidate_only) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0217 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0218 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0219 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0220 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0221 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0222 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0223 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0224 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0225 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0226 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0227 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0228 `=_rc' // WFLOG-INJECTED
  order source_year group_id numerator_n denominator_id denominator_n candidate_only measurement_admitted
capture noisily __wf_progress $WFRD0229 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0230 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("group_counts")
capture noisily __wf_progress $WFRD0231 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0232 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0233 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0234 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0235 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0236 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "candidate_ratios". // WFDOC-INJECTED
 if "`spec'"=="candidate_ratios" {
capture noisily __wf_progress $WFRD0237 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0238 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0239 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0240 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0241 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0242 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0243 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0244 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0245 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0246 `=_rc' // WFLOG-INJECTED
  assert strlen(estimate_id)<=40
capture noisily __wf_progress $WFRD0247 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0248 `=_rc' // WFLOG-INJECTED
  recast str40 estimate_id
capture noisily __wf_progress $WFRD0249 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0250 `=_rc' // WFLOG-INJECTED
  rename numerator_n __rd17_raw
capture noisily __wf_progress $WFRD0251 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0252 `=_rc' // WFLOG-INJECTED
  generate long numerator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0253 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0254 `=_rc' // WFLOG-INJECTED
  assert !missing(numerator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0255 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0256 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0257 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0258 `=_rc' // WFLOG-INJECTED
  rename denominator_n __rd17_raw
capture noisily __wf_progress $WFRD0259 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0260 `=_rc' // WFLOG-INJECTED
  generate long denominator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0261 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0262 `=_rc' // WFLOG-INJECTED
  assert !missing(denominator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0263 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0264 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0265 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0266 `=_rc' // WFLOG-INJECTED
  rename ratio __rd17_raw
capture noisily __wf_progress $WFRD0267 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0268 `=_rc' // WFLOG-INJECTED
  generate double ratio=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0269 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0270 `=_rc' // WFLOG-INJECTED
  assert !missing(ratio) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0271 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0272 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0273 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0274 `=_rc' // WFLOG-INJECTED
  rename percent __rd17_raw
capture noisily __wf_progress $WFRD0275 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0276 `=_rc' // WFLOG-INJECTED
  generate double percent=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0277 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0278 `=_rc' // WFLOG-INJECTED
  assert !missing(percent) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0279 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0280 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0281 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0282 `=_rc' // WFLOG-INJECTED
  rename accepted_eligible_n __rd17_raw
capture noisily __wf_progress $WFRD0283 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0284 `=_rc' // WFLOG-INJECTED
  generate long accepted_eligible_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0285 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0286 `=_rc' // WFLOG-INJECTED
  assert !missing(accepted_eligible_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0287 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0288 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0289 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0290 `=_rc' // WFLOG-INJECTED
  rename accepted_positive_share __rd17_raw
capture noisily __wf_progress $WFRD0291 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0292 `=_rc' // WFLOG-INJECTED
  generate double accepted_positive_share=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0293 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0294 `=_rc' // WFLOG-INJECTED
  assert !missing(accepted_positive_share) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0295 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0296 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0297 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0298 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0299 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0300 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0301 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0302 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0303 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0304 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0305 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0306 `=_rc' // WFLOG-INJECTED
  rename primary_release __rd17_raw
capture noisily __wf_progress $WFRD0307 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0308 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0309 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0310 `=_rc' // WFLOG-INJECTED
  assert !missing(primary_release) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0311 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0312 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0313 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0314 `=_rc' // WFLOG-INJECTED
  order source_year estimate_id numerator_n denominator_n ratio percent accepted_eligible_n accepted_positive_share measurement_admitted primary_release
capture noisily __wf_progress $WFRD0315 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0316 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("candidate_ratios")
capture noisily __wf_progress $WFRD0317 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0318 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0319 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0320 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0321 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0322 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "universe_2017". // WFDOC-INJECTED
 if "`spec'"=="universe_2017" {
capture noisily __wf_progress $WFRD0323 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0324 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0325 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0326 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0327 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0328 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0329 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0330 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0331 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0332 `=_rc' // WFLOG-INJECTED
  rename source_row __rd17_raw
capture noisily __wf_progress $WFRD0333 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0334 `=_rc' // WFLOG-INJECTED
  generate int source_row=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0335 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0336 `=_rc' // WFLOG-INJECTED
  assert !missing(source_row) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0337 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0338 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0339 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0340 `=_rc' // WFLOG-INJECTED
  rename rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0341 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0342 `=_rc' // WFLOG-INJECTED
  generate double rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0343 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0344 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0345 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0346 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0347 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0348 `=_rc' // WFLOG-INJECTED
  rename val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0349 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0350 `=_rc' // WFLOG-INJECTED
  generate double val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0351 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0352 `=_rc' // WFLOG-INJECTED
  assert !missing(val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0353 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0354 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0355 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0356 `=_rc' // WFLOG-INJECTED
  rename vs_rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0357 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0358 `=_rc' // WFLOG-INJECTED
  generate byte vs_rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0359 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0360 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0361 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0362 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0363 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0364 `=_rc' // WFLOG-INJECTED
  rename vs_val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0365 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0366 `=_rc' // WFLOG-INJECTED
  generate byte vs_val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0367 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0368 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0369 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0370 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0371 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0372 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_own_token_class)<=6
capture noisily __wf_progress $WFRD0373 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0374 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_own_token_class
capture noisily __wf_progress $WFRD0375 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0376 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_external_token_class)<=6
capture noisily __wf_progress $WFRD0377 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0378 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_external_token_class
capture noisily __wf_progress $WFRD0379 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0380 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0381 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0382 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0383 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0384 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0385 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0386 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0387 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0388 `=_rc' // WFLOG-INJECTED
  rename rd_universe_candidate __rd17_raw
capture noisily __wf_progress $WFRD0389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0390 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0391 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0392 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_universe_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0393 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0394 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0395 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0396 `=_rc' // WFLOG-INJECTED
  order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate
capture noisily __wf_progress $WFRD0397 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0398 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("universe_2017")
capture noisily __wf_progress $WFRD0399 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0400 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0401 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0402 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0403 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0404 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "answer_2017". // WFDOC-INJECTED
 if "`spec'"=="answer_2017" {
capture noisily __wf_progress $WFRD0405 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0406 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD0407 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0408 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0409 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0410 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0411 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0412 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0413 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0414 `=_rc' // WFLOG-INJECTED
  rename source_row __rd17_raw
capture noisily __wf_progress $WFRD0415 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0416 `=_rc' // WFLOG-INJECTED
  generate int source_row=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0417 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0418 `=_rc' // WFLOG-INJECTED
  assert !missing(source_row) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0419 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0420 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0421 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0422 `=_rc' // WFLOG-INJECTED
  rename rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0423 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0424 `=_rc' // WFLOG-INJECTED
  generate double rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0425 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0426 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0427 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0428 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0429 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0430 `=_rc' // WFLOG-INJECTED
  rename val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0431 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0432 `=_rc' // WFLOG-INJECTED
  generate double val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0433 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0434 `=_rc' // WFLOG-INJECTED
  assert !missing(val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0435 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0436 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0437 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0438 `=_rc' // WFLOG-INJECTED
  rename vs_rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD0439 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0440 `=_rc' // WFLOG-INJECTED
  generate byte vs_rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0441 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0442 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0443 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0444 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0445 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0446 `=_rc' // WFLOG-INJECTED
  rename vs_val_costrd __rd17_raw
capture noisily __wf_progress $WFRD0447 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0448 `=_rc' // WFLOG-INJECTED
  generate byte vs_val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0449 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0450 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0451 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0452 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0453 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0454 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_own_token_class)<=6
capture noisily __wf_progress $WFRD0455 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0456 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_own_token_class
capture noisily __wf_progress $WFRD0457 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0458 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_external_token_class)<=6
capture noisily __wf_progress $WFRD0459 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0460 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_external_token_class
capture noisily __wf_progress $WFRD0461 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0462 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0463 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0464 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0465 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0466 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0467 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0468 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0469 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0470 `=_rc' // WFLOG-INJECTED
  rename rd_universe_candidate __rd17_raw
capture noisily __wf_progress $WFRD0471 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0472 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0473 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0474 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_universe_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0475 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0476 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0477 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0478 `=_rc' // WFLOG-INJECTED
  rename rd_answer_state_candidate __rd17_raw
capture noisily __wf_progress $WFRD0479 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0480 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0481 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0482 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_answer_state_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0483 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0484 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0485 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0486 `=_rc' // WFLOG-INJECTED
  rename rd_external_candidate __rd17_raw
capture noisily __wf_progress $WFRD0487 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0488 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0489 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0490 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_external_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0491 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0492 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0493 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0494 `=_rc' // WFLOG-INJECTED
  order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate
capture noisily __wf_progress $WFRD0495 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0496 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("answer_2017")
capture noisily __wf_progress $WFRD0497 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0498 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0499 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0500 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0501 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0502 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "literal_parser_inputs". // WFDOC-INJECTED
 if "`spec'"=="literal_parser_inputs" {
capture noisily __wf_progress $WFRD0503 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0504 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD0505 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0506 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD0507 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0508 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_rnd17)<=40
capture noisily __wf_progress $WFRD0509 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0510 `=_rc' // WFLOG-INJECTED
  recast str40 raw_rnd17
capture noisily __wf_progress $WFRD0511 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0512 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_costrd17)<=40
capture noisily __wf_progress $WFRD0513 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0514 `=_rc' // WFLOG-INJECTED
  recast str40 raw_costrd17
capture noisily __wf_progress $WFRD0515 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0516 `=_rc' // WFLOG-INJECTED
  rename parent_present __rd17_raw
capture noisily __wf_progress $WFRD0517 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0518 `=_rc' // WFLOG-INJECTED
  generate byte parent_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0519 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0520 `=_rc' // WFLOG-INJECTED
  assert !missing(parent_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0521 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0522 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0523 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0524 `=_rc' // WFLOG-INJECTED
  rename child_present __rd17_raw
capture noisily __wf_progress $WFRD0525 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0526 `=_rc' // WFLOG-INJECTED
  generate byte child_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0527 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0528 `=_rc' // WFLOG-INJECTED
  assert !missing(child_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0529 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0530 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0531 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0532 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_parent_class)<=6
capture noisily __wf_progress $WFRD0533 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0534 `=_rc' // WFLOG-INJECTED
  recast str6 expected_parent_class
capture noisily __wf_progress $WFRD0535 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0536 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_child_class)<=6
capture noisily __wf_progress $WFRD0537 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0538 `=_rc' // WFLOG-INJECTED
  recast str6 expected_child_class
capture noisily __wf_progress $WFRD0539 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0540 `=_rc' // WFLOG-INJECTED
  rename expected_universe __rd17_raw
capture noisily __wf_progress $WFRD0541 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0542 `=_rc' // WFLOG-INJECTED
  generate byte expected_universe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0543 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0544 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_universe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0545 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0546 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0547 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0548 `=_rc' // WFLOG-INJECTED
  rename expected_answer_state __rd17_raw
capture noisily __wf_progress $WFRD0549 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0550 `=_rc' // WFLOG-INJECTED
  generate byte expected_answer_state=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0551 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0552 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_answer_state) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0553 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0554 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0555 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0556 `=_rc' // WFLOG-INJECTED
  rename expected_external __rd17_raw
capture noisily __wf_progress $WFRD0557 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0558 `=_rc' // WFLOG-INJECTED
  generate byte expected_external=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0559 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0560 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_external) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0561 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0562 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0563 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0564 `=_rc' // WFLOG-INJECTED
  rename expected_outside __rd17_raw
capture noisily __wf_progress $WFRD0565 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0566 `=_rc' // WFLOG-INJECTED
  generate byte expected_outside=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0567 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0568 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_outside) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0569 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0570 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0571 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0572 `=_rc' // WFLOG-INJECTED
  rename expected_admission __rd17_raw
capture noisily __wf_progress $WFRD0573 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0574 `=_rc' // WFLOG-INJECTED
  generate byte expected_admission=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0575 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0576 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_admission) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0577 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0578 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0579 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0580 `=_rc' // WFLOG-INJECTED
  order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission
capture noisily __wf_progress $WFRD0581 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0582 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("literal_parser_inputs")
capture noisily __wf_progress $WFRD0583 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0584 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0585 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0586 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0587 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0588 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "truth25_literal_inputs". // WFDOC-INJECTED
 if "`spec'"=="truth25_literal_inputs" {
capture noisily __wf_progress $WFRD0589 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0590 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD0591 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0592 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD0593 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0594 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_rnd17)<=40
capture noisily __wf_progress $WFRD0595 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0596 `=_rc' // WFLOG-INJECTED
  recast str40 raw_rnd17
capture noisily __wf_progress $WFRD0597 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0598 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_costrd17)<=40
capture noisily __wf_progress $WFRD0599 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0600 `=_rc' // WFLOG-INJECTED
  recast str40 raw_costrd17
capture noisily __wf_progress $WFRD0601 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0602 `=_rc' // WFLOG-INJECTED
  rename parent_present __rd17_raw
capture noisily __wf_progress $WFRD0603 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0604 `=_rc' // WFLOG-INJECTED
  generate byte parent_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0605 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0606 `=_rc' // WFLOG-INJECTED
  assert !missing(parent_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0607 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0608 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0609 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0610 `=_rc' // WFLOG-INJECTED
  rename child_present __rd17_raw
capture noisily __wf_progress $WFRD0611 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0612 `=_rc' // WFLOG-INJECTED
  generate byte child_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0613 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0614 `=_rc' // WFLOG-INJECTED
  assert !missing(child_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0615 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0616 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0617 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0618 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_parent_class)<=6
capture noisily __wf_progress $WFRD0619 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0620 `=_rc' // WFLOG-INJECTED
  recast str6 expected_parent_class
capture noisily __wf_progress $WFRD0621 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0622 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_child_class)<=6
capture noisily __wf_progress $WFRD0623 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0624 `=_rc' // WFLOG-INJECTED
  recast str6 expected_child_class
capture noisily __wf_progress $WFRD0625 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0626 `=_rc' // WFLOG-INJECTED
  rename expected_universe __rd17_raw
capture noisily __wf_progress $WFRD0627 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0628 `=_rc' // WFLOG-INJECTED
  generate byte expected_universe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0629 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0630 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_universe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0631 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0632 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0633 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0634 `=_rc' // WFLOG-INJECTED
  rename expected_answer_state __rd17_raw
capture noisily __wf_progress $WFRD0635 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0636 `=_rc' // WFLOG-INJECTED
  generate byte expected_answer_state=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0637 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0638 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_answer_state) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0639 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0640 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0641 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0642 `=_rc' // WFLOG-INJECTED
  rename expected_external __rd17_raw
capture noisily __wf_progress $WFRD0643 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0644 `=_rc' // WFLOG-INJECTED
  generate byte expected_external=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0645 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0646 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_external) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0647 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0648 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0649 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0650 `=_rc' // WFLOG-INJECTED
  rename expected_outside __rd17_raw
capture noisily __wf_progress $WFRD0651 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0652 `=_rc' // WFLOG-INJECTED
  generate byte expected_outside=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0653 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0654 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_outside) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0655 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0656 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0657 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0658 `=_rc' // WFLOG-INJECTED
  rename expected_admission __rd17_raw
capture noisily __wf_progress $WFRD0659 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0660 `=_rc' // WFLOG-INJECTED
  generate byte expected_admission=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0661 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0662 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_admission) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0663 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0664 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0665 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0666 `=_rc' // WFLOG-INJECTED
  order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission
capture noisily __wf_progress $WFRD0667 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0668 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("truth25_literal_inputs")
capture noisily __wf_progress $WFRD0669 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0670 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0671 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0672 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0673 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0674 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_literal_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_literal_results" {
capture noisily __wf_progress $WFRD0675 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0676 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD0677 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0678 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD0679 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0680 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_rnd17)<=40
capture noisily __wf_progress $WFRD0681 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0682 `=_rc' // WFLOG-INJECTED
  recast str40 raw_rnd17
capture noisily __wf_progress $WFRD0683 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0684 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_costrd17)<=40
capture noisily __wf_progress $WFRD0685 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0686 `=_rc' // WFLOG-INJECTED
  recast str40 raw_costrd17
capture noisily __wf_progress $WFRD0687 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0688 `=_rc' // WFLOG-INJECTED
  rename parent_present __rd17_raw
capture noisily __wf_progress $WFRD0689 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0690 `=_rc' // WFLOG-INJECTED
  generate byte parent_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0691 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0692 `=_rc' // WFLOG-INJECTED
  assert !missing(parent_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0693 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0694 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0695 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0696 `=_rc' // WFLOG-INJECTED
  rename child_present __rd17_raw
capture noisily __wf_progress $WFRD0697 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0698 `=_rc' // WFLOG-INJECTED
  generate byte child_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0699 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0700 `=_rc' // WFLOG-INJECTED
  assert !missing(child_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0701 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0702 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0703 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0704 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_parent_class)<=6
capture noisily __wf_progress $WFRD0705 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0706 `=_rc' // WFLOG-INJECTED
  recast str6 expected_parent_class
capture noisily __wf_progress $WFRD0707 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0708 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_child_class)<=6
capture noisily __wf_progress $WFRD0709 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0710 `=_rc' // WFLOG-INJECTED
  recast str6 expected_child_class
capture noisily __wf_progress $WFRD0711 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0712 `=_rc' // WFLOG-INJECTED
  rename expected_universe __rd17_raw
capture noisily __wf_progress $WFRD0713 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0714 `=_rc' // WFLOG-INJECTED
  generate byte expected_universe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0715 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0716 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_universe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0717 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0718 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0719 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0720 `=_rc' // WFLOG-INJECTED
  rename expected_answer_state __rd17_raw
capture noisily __wf_progress $WFRD0721 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0722 `=_rc' // WFLOG-INJECTED
  generate byte expected_answer_state=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0723 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0724 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_answer_state) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0725 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0726 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0727 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0728 `=_rc' // WFLOG-INJECTED
  rename expected_external __rd17_raw
capture noisily __wf_progress $WFRD0729 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0730 `=_rc' // WFLOG-INJECTED
  generate byte expected_external=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0731 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0732 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_external) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0733 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0734 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0735 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0736 `=_rc' // WFLOG-INJECTED
  rename expected_outside __rd17_raw
capture noisily __wf_progress $WFRD0737 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0738 `=_rc' // WFLOG-INJECTED
  generate byte expected_outside=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0739 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0740 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_outside) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0741 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0742 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0743 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0744 `=_rc' // WFLOG-INJECTED
  rename expected_admission __rd17_raw
capture noisily __wf_progress $WFRD0745 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0746 `=_rc' // WFLOG-INJECTED
  generate byte expected_admission=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0747 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0748 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_admission) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0749 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0750 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0751 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0752 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token)<=40
capture noisily __wf_progress $WFRD0753 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0754 `=_rc' // WFLOG-INJECTED
  recast str40 parent_token
capture noisily __wf_progress $WFRD0755 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0756 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token)<=40
capture noisily __wf_progress $WFRD0757 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0758 `=_rc' // WFLOG-INJECTED
  recast str40 child_token
capture noisily __wf_progress $WFRD0759 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0760 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0761 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0762 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0763 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0764 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0765 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0766 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0767 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0768 `=_rc' // WFLOG-INJECTED
  rename rd_universe_candidate __rd17_raw
capture noisily __wf_progress $WFRD0769 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0770 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0771 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0772 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_universe_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0773 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0774 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0775 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0776 `=_rc' // WFLOG-INJECTED
  rename rd_answer_state_candidate __rd17_raw
capture noisily __wf_progress $WFRD0777 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0778 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0779 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0780 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_answer_state_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0781 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0782 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0783 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0784 `=_rc' // WFLOG-INJECTED
  rename rd_external_candidate __rd17_raw
capture noisily __wf_progress $WFRD0785 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0786 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0787 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0788 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_external_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0789 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0790 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0791 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0792 `=_rc' // WFLOG-INJECTED
  rename outside_answer_candidate __rd17_raw
capture noisily __wf_progress $WFRD0793 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0794 `=_rc' // WFLOG-INJECTED
  generate byte outside_answer_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0795 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0796 `=_rc' // WFLOG-INJECTED
  assert !missing(outside_answer_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0797 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0798 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0799 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0800 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0801 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0802 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0803 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0804 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0805 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0806 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0807 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0808 `=_rc' // WFLOG-INJECTED
  rename primary_release __rd17_raw
capture noisily __wf_progress $WFRD0809 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0810 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0811 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0812 `=_rc' // WFLOG-INJECTED
  assert !missing(primary_release) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0813 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0814 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0815 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0816 `=_rc' // WFLOG-INJECTED
  rename passed __rd17_raw
capture noisily __wf_progress $WFRD0817 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0818 `=_rc' // WFLOG-INJECTED
  generate byte passed=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0819 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0820 `=_rc' // WFLOG-INJECTED
  assert !missing(passed) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0821 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0822 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0823 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0824 `=_rc' // WFLOG-INJECTED
  order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed
capture noisily __wf_progress $WFRD0825 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0826 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("fixture_literal_results")
capture noisily __wf_progress $WFRD0827 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0828 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0829 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0830 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0831 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0832 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_truth25_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_truth25_results" {
capture noisily __wf_progress $WFRD0833 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0834 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD0835 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0836 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD0837 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0838 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_rnd17)<=40
capture noisily __wf_progress $WFRD0839 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0840 `=_rc' // WFLOG-INJECTED
  recast str40 raw_rnd17
capture noisily __wf_progress $WFRD0841 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0842 `=_rc' // WFLOG-INJECTED
  assert strlen(raw_costrd17)<=40
capture noisily __wf_progress $WFRD0843 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0844 `=_rc' // WFLOG-INJECTED
  recast str40 raw_costrd17
capture noisily __wf_progress $WFRD0845 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0846 `=_rc' // WFLOG-INJECTED
  rename parent_present __rd17_raw
capture noisily __wf_progress $WFRD0847 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0848 `=_rc' // WFLOG-INJECTED
  generate byte parent_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0849 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0850 `=_rc' // WFLOG-INJECTED
  assert !missing(parent_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0851 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0852 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0853 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0854 `=_rc' // WFLOG-INJECTED
  rename child_present __rd17_raw
capture noisily __wf_progress $WFRD0855 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0856 `=_rc' // WFLOG-INJECTED
  generate byte child_present=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0857 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0858 `=_rc' // WFLOG-INJECTED
  assert !missing(child_present) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0859 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0860 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0861 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0862 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_parent_class)<=6
capture noisily __wf_progress $WFRD0863 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0864 `=_rc' // WFLOG-INJECTED
  recast str6 expected_parent_class
capture noisily __wf_progress $WFRD0865 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0866 `=_rc' // WFLOG-INJECTED
  assert strlen(expected_child_class)<=6
capture noisily __wf_progress $WFRD0867 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0868 `=_rc' // WFLOG-INJECTED
  recast str6 expected_child_class
capture noisily __wf_progress $WFRD0869 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0870 `=_rc' // WFLOG-INJECTED
  rename expected_universe __rd17_raw
capture noisily __wf_progress $WFRD0871 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0872 `=_rc' // WFLOG-INJECTED
  generate byte expected_universe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0873 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0874 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_universe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0875 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0876 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0877 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0878 `=_rc' // WFLOG-INJECTED
  rename expected_answer_state __rd17_raw
capture noisily __wf_progress $WFRD0879 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0880 `=_rc' // WFLOG-INJECTED
  generate byte expected_answer_state=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0881 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0882 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_answer_state) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0883 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0884 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0885 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0886 `=_rc' // WFLOG-INJECTED
  rename expected_external __rd17_raw
capture noisily __wf_progress $WFRD0887 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0888 `=_rc' // WFLOG-INJECTED
  generate byte expected_external=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0889 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0890 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_external) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0891 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0892 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0893 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0894 `=_rc' // WFLOG-INJECTED
  rename expected_outside __rd17_raw
capture noisily __wf_progress $WFRD0895 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0896 `=_rc' // WFLOG-INJECTED
  generate byte expected_outside=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0897 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0898 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_outside) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0899 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0900 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0901 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0902 `=_rc' // WFLOG-INJECTED
  rename expected_admission __rd17_raw
capture noisily __wf_progress $WFRD0903 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0904 `=_rc' // WFLOG-INJECTED
  generate byte expected_admission=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0905 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0906 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_admission) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0907 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0908 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0909 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0910 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token)<=40
capture noisily __wf_progress $WFRD0911 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0912 `=_rc' // WFLOG-INJECTED
  recast str40 parent_token
capture noisily __wf_progress $WFRD0913 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0914 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token)<=40
capture noisily __wf_progress $WFRD0915 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0916 `=_rc' // WFLOG-INJECTED
  recast str40 child_token
capture noisily __wf_progress $WFRD0917 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0918 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD0919 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0920 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD0921 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0922 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD0923 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0924 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD0925 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0926 `=_rc' // WFLOG-INJECTED
  rename rd_universe_candidate __rd17_raw
capture noisily __wf_progress $WFRD0927 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0928 `=_rc' // WFLOG-INJECTED
  generate byte rd_universe_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0929 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0930 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_universe_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0931 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0932 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0933 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0934 `=_rc' // WFLOG-INJECTED
  rename rd_answer_state_candidate __rd17_raw
capture noisily __wf_progress $WFRD0935 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0936 `=_rc' // WFLOG-INJECTED
  generate byte rd_answer_state_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0937 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0938 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_answer_state_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0939 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0940 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0941 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0942 `=_rc' // WFLOG-INJECTED
  rename rd_external_candidate __rd17_raw
capture noisily __wf_progress $WFRD0943 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0944 `=_rc' // WFLOG-INJECTED
  generate byte rd_external_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0945 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0946 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_external_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0947 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0948 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0949 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0950 `=_rc' // WFLOG-INJECTED
  rename outside_answer_candidate __rd17_raw
capture noisily __wf_progress $WFRD0951 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0952 `=_rc' // WFLOG-INJECTED
  generate byte outside_answer_candidate=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0953 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0954 `=_rc' // WFLOG-INJECTED
  assert !missing(outside_answer_candidate) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0955 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0956 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0957 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0958 `=_rc' // WFLOG-INJECTED
  rename measurement_admitted __rd17_raw
capture noisily __wf_progress $WFRD0959 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0960 `=_rc' // WFLOG-INJECTED
  generate byte measurement_admitted=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0961 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0962 `=_rc' // WFLOG-INJECTED
  assert !missing(measurement_admitted) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0963 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0964 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0965 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0966 `=_rc' // WFLOG-INJECTED
  rename primary_release __rd17_raw
capture noisily __wf_progress $WFRD0967 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0968 `=_rc' // WFLOG-INJECTED
  generate byte primary_release=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0969 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0970 `=_rc' // WFLOG-INJECTED
  assert !missing(primary_release) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0971 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0972 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0973 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0974 `=_rc' // WFLOG-INJECTED
  rename passed __rd17_raw
capture noisily __wf_progress $WFRD0975 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0976 `=_rc' // WFLOG-INJECTED
  generate byte passed=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD0977 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0978 `=_rc' // WFLOG-INJECTED
  assert !missing(passed) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD0979 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0980 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD0981 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0982 `=_rc' // WFLOG-INJECTED
  order fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed
capture noisily __wf_progress $WFRD0983 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0984 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("fixture_truth25_results")
capture noisily __wf_progress $WFRD0985 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0986 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD0987 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0988 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD0989 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0990 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "ratio_fixture_inputs". // WFDOC-INJECTED
 if "`spec'"=="ratio_fixture_inputs" {
capture noisily __wf_progress $WFRD0991 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0992 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD0993 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0994 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD0995 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0996 `=_rc' // WFLOG-INJECTED
  assert strlen(estimate_id)<=40
capture noisily __wf_progress $WFRD0997 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD0998 `=_rc' // WFLOG-INJECTED
  recast str40 estimate_id
capture noisily __wf_progress $WFRD0999 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1000 `=_rc' // WFLOG-INJECTED
  rename eligible_yes_n __rd17_raw
capture noisily __wf_progress $WFRD1001 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1002 `=_rc' // WFLOG-INJECTED
  generate long eligible_yes_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1003 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1004 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_yes_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1005 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1006 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1007 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1008 `=_rc' // WFLOG-INJECTED
  rename eligible_no_n __rd17_raw
capture noisily __wf_progress $WFRD1009 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1010 `=_rc' // WFLOG-INJECTED
  generate long eligible_no_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1012 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_no_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1013 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1014 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1015 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1016 `=_rc' // WFLOG-INJECTED
  rename eligible_n __rd17_raw
capture noisily __wf_progress $WFRD1017 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1018 `=_rc' // WFLOG-INJECTED
  generate long eligible_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1019 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1020 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1021 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1022 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1023 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1024 `=_rc' // WFLOG-INJECTED
  rename expected_numerator_n __rd17_raw
capture noisily __wf_progress $WFRD1025 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1026 `=_rc' // WFLOG-INJECTED
  generate long expected_numerator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1027 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1028 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_numerator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1029 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1030 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1031 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1032 `=_rc' // WFLOG-INJECTED
  rename expected_denominator_n __rd17_raw
capture noisily __wf_progress $WFRD1033 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1034 `=_rc' // WFLOG-INJECTED
  generate long expected_denominator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1035 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1036 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_denominator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1037 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1038 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1039 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1040 `=_rc' // WFLOG-INJECTED
  rename expected_ratio __rd17_raw
capture noisily __wf_progress $WFRD1041 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1042 `=_rc' // WFLOG-INJECTED
  generate double expected_ratio=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1043 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1044 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_ratio) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1045 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1046 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1047 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1048 `=_rc' // WFLOG-INJECTED
  rename expected_percent __rd17_raw
capture noisily __wf_progress $WFRD1049 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1050 `=_rc' // WFLOG-INJECTED
  generate double expected_percent=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1051 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1052 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_percent) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1053 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1054 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1055 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1056 `=_rc' // WFLOG-INJECTED
  rename expected_missing __rd17_raw
capture noisily __wf_progress $WFRD1057 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1058 `=_rc' // WFLOG-INJECTED
  generate byte expected_missing=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1059 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1060 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_missing) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1061 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1062 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1063 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1064 `=_rc' // WFLOG-INJECTED
  rename precision_probe __rd17_raw
capture noisily __wf_progress $WFRD1065 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1066 `=_rc' // WFLOG-INJECTED
  generate byte precision_probe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1067 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1068 `=_rc' // WFLOG-INJECTED
  assert !missing(precision_probe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1069 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1070 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1071 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1072 `=_rc' // WFLOG-INJECTED
  order fixture_id estimate_id eligible_yes_n eligible_no_n eligible_n expected_numerator_n expected_denominator_n expected_ratio expected_percent expected_missing precision_probe
capture noisily __wf_progress $WFRD1073 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1074 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("ratio_fixture_inputs")
capture noisily __wf_progress $WFRD1075 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1076 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1077 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1078 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1079 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1080 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_ratio_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_ratio_results" {
capture noisily __wf_progress $WFRD1081 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1082 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD1083 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1084 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD1085 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1086 `=_rc' // WFLOG-INJECTED
  assert strlen(estimate_id)<=40
capture noisily __wf_progress $WFRD1087 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1088 `=_rc' // WFLOG-INJECTED
  recast str40 estimate_id
capture noisily __wf_progress $WFRD1089 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1090 `=_rc' // WFLOG-INJECTED
  rename eligible_yes_n __rd17_raw
capture noisily __wf_progress $WFRD1091 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1092 `=_rc' // WFLOG-INJECTED
  generate long eligible_yes_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1093 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1094 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_yes_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1095 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1096 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1097 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1098 `=_rc' // WFLOG-INJECTED
  rename eligible_no_n __rd17_raw
capture noisily __wf_progress $WFRD1099 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1100 `=_rc' // WFLOG-INJECTED
  generate long eligible_no_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1101 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1102 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_no_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1104 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1105 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1106 `=_rc' // WFLOG-INJECTED
  rename eligible_n __rd17_raw
capture noisily __wf_progress $WFRD1107 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1108 `=_rc' // WFLOG-INJECTED
  generate long eligible_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1109 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1110 `=_rc' // WFLOG-INJECTED
  assert !missing(eligible_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1111 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1112 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1113 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1114 `=_rc' // WFLOG-INJECTED
  rename expected_numerator_n __rd17_raw
capture noisily __wf_progress $WFRD1115 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1116 `=_rc' // WFLOG-INJECTED
  generate long expected_numerator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1117 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1118 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_numerator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1119 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1120 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1121 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1122 `=_rc' // WFLOG-INJECTED
  rename expected_denominator_n __rd17_raw
capture noisily __wf_progress $WFRD1123 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1124 `=_rc' // WFLOG-INJECTED
  generate long expected_denominator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1125 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1126 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_denominator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1127 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1128 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1129 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1130 `=_rc' // WFLOG-INJECTED
  rename expected_ratio __rd17_raw
capture noisily __wf_progress $WFRD1131 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1132 `=_rc' // WFLOG-INJECTED
  generate double expected_ratio=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1133 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1134 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_ratio) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1135 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1136 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1137 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1138 `=_rc' // WFLOG-INJECTED
  rename expected_percent __rd17_raw
capture noisily __wf_progress $WFRD1139 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1140 `=_rc' // WFLOG-INJECTED
  generate double expected_percent=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1141 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1142 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_percent) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1143 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1144 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1145 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1146 `=_rc' // WFLOG-INJECTED
  rename expected_missing __rd17_raw
capture noisily __wf_progress $WFRD1147 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1148 `=_rc' // WFLOG-INJECTED
  generate byte expected_missing=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1149 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1150 `=_rc' // WFLOG-INJECTED
  assert !missing(expected_missing) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1151 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1152 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1153 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1154 `=_rc' // WFLOG-INJECTED
  rename precision_probe __rd17_raw
capture noisily __wf_progress $WFRD1155 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1156 `=_rc' // WFLOG-INJECTED
  generate byte precision_probe=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1157 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1158 `=_rc' // WFLOG-INJECTED
  assert !missing(precision_probe) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1159 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1160 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1161 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1162 `=_rc' // WFLOG-INJECTED
  rename numerator_n __rd17_raw
capture noisily __wf_progress $WFRD1163 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1164 `=_rc' // WFLOG-INJECTED
  generate long numerator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1165 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1166 `=_rc' // WFLOG-INJECTED
  assert !missing(numerator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1167 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1168 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1169 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1170 `=_rc' // WFLOG-INJECTED
  rename denominator_n __rd17_raw
capture noisily __wf_progress $WFRD1171 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1172 `=_rc' // WFLOG-INJECTED
  generate long denominator_n=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1173 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1174 `=_rc' // WFLOG-INJECTED
  assert !missing(denominator_n) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1175 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1176 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1177 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1178 `=_rc' // WFLOG-INJECTED
  rename ratio __rd17_raw
capture noisily __wf_progress $WFRD1179 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1180 `=_rc' // WFLOG-INJECTED
  generate double ratio=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1181 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1182 `=_rc' // WFLOG-INJECTED
  assert !missing(ratio) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1184 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1185 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1186 `=_rc' // WFLOG-INJECTED
  rename percent __rd17_raw
capture noisily __wf_progress $WFRD1187 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1188 `=_rc' // WFLOG-INJECTED
  generate double percent=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1189 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1190 `=_rc' // WFLOG-INJECTED
  assert !missing(percent) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1191 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1192 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1193 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1194 `=_rc' // WFLOG-INJECTED
  rename passed __rd17_raw
capture noisily __wf_progress $WFRD1195 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1196 `=_rc' // WFLOG-INJECTED
  generate byte passed=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1197 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1198 `=_rc' // WFLOG-INJECTED
  assert !missing(passed) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1199 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1200 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1201 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1202 `=_rc' // WFLOG-INJECTED
  order fixture_id estimate_id eligible_yes_n eligible_no_n eligible_n expected_numerator_n expected_denominator_n expected_ratio expected_percent expected_missing precision_probe numerator_n denominator_n ratio percent passed
capture noisily __wf_progress $WFRD1203 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1204 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("fixture_ratio_results")
capture noisily __wf_progress $WFRD1205 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1206 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1207 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1208 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1209 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1210 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_results" {
capture noisily __wf_progress $WFRD1211 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1212 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_family)<=12
capture noisily __wf_progress $WFRD1213 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1214 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_family
capture noisily __wf_progress $WFRD1215 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1216 `=_rc' // WFLOG-INJECTED
  assert strlen(fixture_id)<=12
capture noisily __wf_progress $WFRD1217 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1218 `=_rc' // WFLOG-INJECTED
  recast str12 fixture_id
capture noisily __wf_progress $WFRD1219 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1220 `=_rc' // WFLOG-INJECTED
  assert strlen(estimate_id)<=40
capture noisily __wf_progress $WFRD1221 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1222 `=_rc' // WFLOG-INJECTED
  recast str40 estimate_id
capture noisily __wf_progress $WFRD1223 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1224 `=_rc' // WFLOG-INJECTED
  rename passed __rd17_raw
capture noisily __wf_progress $WFRD1225 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1226 `=_rc' // WFLOG-INJECTED
  generate byte passed=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1227 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1228 `=_rc' // WFLOG-INJECTED
  assert !missing(passed) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1229 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1230 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1231 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1232 `=_rc' // WFLOG-INJECTED
  order fixture_family fixture_id estimate_id passed
capture noisily __wf_progress $WFRD1233 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1234 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("fixture_results")
capture noisily __wf_progress $WFRD1235 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1236 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1237 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1238 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1239 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1240 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "wave_2017_projection". // WFDOC-INJECTED
 if "`spec'"=="wave_2017_projection" {
capture noisily __wf_progress $WFRD1241 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1242 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD1243 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1244 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1245 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1246 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1247 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1248 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1249 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1250 `=_rc' // WFLOG-INJECTED
  rename source_row __rd17_raw
capture noisily __wf_progress $WFRD1251 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1252 `=_rc' // WFLOG-INJECTED
  generate int source_row=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1253 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1254 `=_rc' // WFLOG-INJECTED
  assert !missing(source_row) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1255 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1256 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1257 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1258 `=_rc' // WFLOG-INJECTED
  rename rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD1259 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1260 `=_rc' // WFLOG-INJECTED
  generate double rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1261 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1262 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1263 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1264 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1265 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1266 `=_rc' // WFLOG-INJECTED
  rename val_costrd __rd17_raw
capture noisily __wf_progress $WFRD1267 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1268 `=_rc' // WFLOG-INJECTED
  generate double val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1269 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1270 `=_rc' // WFLOG-INJECTED
  assert !missing(val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1271 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1272 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1273 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1274 `=_rc' // WFLOG-INJECTED
  rename vs_rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD1275 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1276 `=_rc' // WFLOG-INJECTED
  generate byte vs_rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1277 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1278 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1279 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1280 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1281 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1282 `=_rc' // WFLOG-INJECTED
  rename vs_val_costrd __rd17_raw
capture noisily __wf_progress $WFRD1283 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1284 `=_rc' // WFLOG-INJECTED
  generate byte vs_val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1285 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1286 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1287 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1288 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1289 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1290 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_own_token_class)<=6
capture noisily __wf_progress $WFRD1291 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1292 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_own_token_class
capture noisily __wf_progress $WFRD1293 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1294 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_external_token_class)<=6
capture noisily __wf_progress $WFRD1295 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1296 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_external_token_class
capture noisily __wf_progress $WFRD1297 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1298 `=_rc' // WFLOG-INJECTED
  order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class
capture noisily __wf_progress $WFRD1299 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1300 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("wave_2017_projection")
capture noisily __wf_progress $WFRD1301 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1302 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1303 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1304 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1305 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1306 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "canonical_decisions_2017". // WFDOC-INJECTED
 if "`spec'"=="canonical_decisions_2017" {
capture noisily __wf_progress $WFRD1307 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1308 `=_rc' // WFLOG-INJECTED
  rename source_year __rd17_raw
capture noisily __wf_progress $WFRD1309 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1310 `=_rc' // WFLOG-INJECTED
  generate int source_year=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1311 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1312 `=_rc' // WFLOG-INJECTED
  assert !missing(source_year) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1313 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1314 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1315 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1316 `=_rc' // WFLOG-INJECTED
  rename source_row __rd17_raw
capture noisily __wf_progress $WFRD1317 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1318 `=_rc' // WFLOG-INJECTED
  generate int source_row=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1319 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1320 `=_rc' // WFLOG-INJECTED
  assert !missing(source_row) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1321 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1322 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1323 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1324 `=_rc' // WFLOG-INJECTED
  rename rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD1325 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1326 `=_rc' // WFLOG-INJECTED
  generate double rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1327 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1328 `=_rc' // WFLOG-INJECTED
  assert !missing(rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1329 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1330 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1331 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1332 `=_rc' // WFLOG-INJECTED
  rename val_costrd __rd17_raw
capture noisily __wf_progress $WFRD1333 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1334 `=_rc' // WFLOG-INJECTED
  generate double val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1335 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1336 `=_rc' // WFLOG-INJECTED
  assert !missing(val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1337 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1338 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1339 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1340 `=_rc' // WFLOG-INJECTED
  rename vs_rd_indicator_raw __rd17_raw
capture noisily __wf_progress $WFRD1341 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1342 `=_rc' // WFLOG-INJECTED
  generate byte vs_rd_indicator_raw=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1343 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1344 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_rd_indicator_raw) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1345 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1346 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1347 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1348 `=_rc' // WFLOG-INJECTED
  rename vs_val_costrd __rd17_raw
capture noisily __wf_progress $WFRD1349 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1350 `=_rc' // WFLOG-INJECTED
  generate byte vs_val_costrd=real(strtrim(__rd17_raw))
capture noisily __wf_progress $WFRD1351 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1352 `=_rc' // WFLOG-INJECTED
  assert !missing(vs_val_costrd) if strtrim(__rd17_raw)!="" & substr(strtrim(__rd17_raw),1,1)!="."
capture noisily __wf_progress $WFRD1353 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1354 `=_rc' // WFLOG-INJECTED
  drop __rd17_raw
capture noisily __wf_progress $WFRD1355 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1356 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_own_token_class)<=6
capture noisily __wf_progress $WFRD1357 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1358 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_own_token_class
capture noisily __wf_progress $WFRD1359 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1360 `=_rc' // WFLOG-INJECTED
  assert strlen(rd17_external_token_class)<=6
capture noisily __wf_progress $WFRD1361 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1362 `=_rc' // WFLOG-INJECTED
  recast str6 rd17_external_token_class
capture noisily __wf_progress $WFRD1363 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1364 `=_rc' // WFLOG-INJECTED
  assert strlen(parent_token_class)<=6
capture noisily __wf_progress $WFRD1365 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1366 `=_rc' // WFLOG-INJECTED
  recast str6 parent_token_class
capture noisily __wf_progress $WFRD1367 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1368 `=_rc' // WFLOG-INJECTED
  assert strlen(child_token_class)<=6
capture noisily __wf_progress $WFRD1369 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1370 `=_rc' // WFLOG-INJECTED
  recast str6 child_token_class
capture noisily __wf_progress $WFRD1371 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1372 `=_rc' // WFLOG-INJECTED
  order source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class
capture noisily __wf_progress $WFRD1373 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1374 `=_rc' // WFLOG-INJECTED
  rd17_schema, spec("canonical_decisions_2017")
capture noisily __wf_progress $WFRD1375 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1376 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1377 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1378 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1379 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1380 `=_rc' // WFLOG-INJECTED
 display as error "Undeclared import schema"
capture noisily __wf_progress $WFRD1381 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1382 `=_rc' // WFLOG-INJECTED
 exit 198
capture noisily __wf_progress $WFRD1383 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1384 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L136:step-program" "rd2017/lib/shared.do:L1:file" "statement" 10 14 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/lib/shared.do:L830:step-program" "rd2017/lib/shared.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
* Definisikan pemeriksa skema: untuk spec yang dipilih, cocokkan urutan/nama kolom, jumlah baris, tipe, kunci, dan rentang yang ditetapkan; skema salah menghentikan proses. // WFDOC-INJECTED
capture program drop rd17_schema
capture noisily __wf_progress end "rd2017/lib/shared.do:L830:step-program" "rd2017/lib/shared.do:L1:file" "statement" 11 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L831:step-program" "rd2017/lib/shared.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_schema; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
program define rd17_schema
capture noisily __wf_progress $WFRD1385 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1386 `=_rc' // WFLOG-INJECTED
 syntax, SPEC(string)
capture noisily __wf_progress $WFRD1387 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1388 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "candidate_2017". // WFDOC-INJECTED
 if "`spec'"=="candidate_2017" {
capture noisily __wf_progress $WFRD1389 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1390 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1391 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1392 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release"
capture noisily __wf_progress $WFRD1393 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1394 `=_rc' // WFLOG-INJECTED
  assert _N==3357
capture noisily __wf_progress $WFRD1395 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1396 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1397 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1398 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1399 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1400 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_row
capture noisily __wf_progress $WFRD1401 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1402 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1403 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1404 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_indicator_raw
capture noisily __wf_progress $WFRD1405 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1406 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1407 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1408 `=_rc' // WFLOG-INJECTED
  local actual_type : type val_costrd
capture noisily __wf_progress $WFRD1409 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1410 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1411 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1412 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_rd_indicator_raw
capture noisily __wf_progress $WFRD1413 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1414 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1415 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1416 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_val_costrd
capture noisily __wf_progress $WFRD1417 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1418 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1419 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1420 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_own_token_class
capture noisily __wf_progress $WFRD1421 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1422 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1423 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1424 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_external_token_class
capture noisily __wf_progress $WFRD1425 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1426 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1427 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1428 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD1429 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1430 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1431 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1432 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD1433 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1434 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1435 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1436 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_universe_candidate
capture noisily __wf_progress $WFRD1437 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1438 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1439 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1440 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_answer_state_candidate
capture noisily __wf_progress $WFRD1441 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1442 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1443 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1444 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_external_candidate
capture noisily __wf_progress $WFRD1445 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1446 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1447 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1448 `=_rc' // WFLOG-INJECTED
  local actual_type : type outside_answer_candidate
capture noisily __wf_progress $WFRD1449 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1450 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1451 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1452 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD1453 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1454 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1455 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1456 `=_rc' // WFLOG-INJECTED
  local actual_type : type primary_release
capture noisily __wf_progress $WFRD1457 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1458 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1459 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1460 `=_rc' // WFLOG-INJECTED
  isid source_year source_row
capture noisily __wf_progress $WFRD1461 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1462 `=_rc' // WFLOG-INJECTED
  assert source_year==2017
capture noisily __wf_progress $WFRD1463 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1464 `=_rc' // WFLOG-INJECTED
  assert inrange(source_row,1,3357)
capture noisily __wf_progress $WFRD1465 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1466 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1467 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1468 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1469 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1470 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "joint_counts". // WFDOC-INJECTED
 if "`spec'"=="joint_counts" {
capture noisily __wf_progress $WFRD1471 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1472 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1473 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1474 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year parent_token_class child_token_class n all_rows measurement_admitted"
capture noisily __wf_progress $WFRD1475 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1476 `=_rc' // WFLOG-INJECTED
  assert _N==25
capture noisily __wf_progress $WFRD1477 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1478 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1479 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1480 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1481 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1482 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD1483 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1484 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1485 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1486 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD1487 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1488 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1489 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1490 `=_rc' // WFLOG-INJECTED
  local actual_type : type n
capture noisily __wf_progress $WFRD1491 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1492 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1493 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1494 `=_rc' // WFLOG-INJECTED
  local actual_type : type all_rows
capture noisily __wf_progress $WFRD1495 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1496 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1497 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1498 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD1499 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1500 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1501 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1502 `=_rc' // WFLOG-INJECTED
  isid source_year parent_token_class child_token_class
capture noisily __wf_progress $WFRD1503 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1504 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1505 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1506 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1507 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1508 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "group_counts". // WFDOC-INJECTED
 if "`spec'"=="group_counts" {
capture noisily __wf_progress $WFRD1509 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1510 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1511 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1512 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year group_id numerator_n denominator_id denominator_n candidate_only measurement_admitted"
capture noisily __wf_progress $WFRD1513 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1514 `=_rc' // WFLOG-INJECTED
  assert _N==15
capture noisily __wf_progress $WFRD1515 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1516 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1517 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1518 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1519 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1520 `=_rc' // WFLOG-INJECTED
  local actual_type : type group_id
capture noisily __wf_progress $WFRD1521 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1522 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1523 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1524 `=_rc' // WFLOG-INJECTED
  local actual_type : type numerator_n
capture noisily __wf_progress $WFRD1525 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1526 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1527 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1528 `=_rc' // WFLOG-INJECTED
  local actual_type : type denominator_id
capture noisily __wf_progress $WFRD1529 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1530 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1531 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1532 `=_rc' // WFLOG-INJECTED
  local actual_type : type denominator_n
capture noisily __wf_progress $WFRD1533 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1534 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1535 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1536 `=_rc' // WFLOG-INJECTED
  local actual_type : type candidate_only
capture noisily __wf_progress $WFRD1537 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1538 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1539 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1540 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD1541 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1542 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1543 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1544 `=_rc' // WFLOG-INJECTED
  isid source_year group_id
capture noisily __wf_progress $WFRD1545 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1546 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1547 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1548 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1549 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1550 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "candidate_ratios". // WFDOC-INJECTED
 if "`spec'"=="candidate_ratios" {
capture noisily __wf_progress $WFRD1551 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1552 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1553 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1554 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year estimate_id numerator_n denominator_n ratio percent accepted_eligible_n accepted_positive_share measurement_admitted primary_release"
capture noisily __wf_progress $WFRD1555 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1556 `=_rc' // WFLOG-INJECTED
  assert _N==2
capture noisily __wf_progress $WFRD1557 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1558 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1559 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1560 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1561 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1562 `=_rc' // WFLOG-INJECTED
  local actual_type : type estimate_id
capture noisily __wf_progress $WFRD1563 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1564 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1565 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1566 `=_rc' // WFLOG-INJECTED
  local actual_type : type numerator_n
capture noisily __wf_progress $WFRD1567 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1568 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1569 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1570 `=_rc' // WFLOG-INJECTED
  local actual_type : type denominator_n
capture noisily __wf_progress $WFRD1571 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1572 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1573 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1574 `=_rc' // WFLOG-INJECTED
  local actual_type : type ratio
capture noisily __wf_progress $WFRD1575 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1576 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1577 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1578 `=_rc' // WFLOG-INJECTED
  local actual_type : type percent
capture noisily __wf_progress $WFRD1579 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1580 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1581 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1582 `=_rc' // WFLOG-INJECTED
  local actual_type : type accepted_eligible_n
capture noisily __wf_progress $WFRD1583 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1584 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD1585 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1586 `=_rc' // WFLOG-INJECTED
  local actual_type : type accepted_positive_share
capture noisily __wf_progress $WFRD1587 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1588 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1589 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1590 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD1591 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1592 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1593 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1594 `=_rc' // WFLOG-INJECTED
  local actual_type : type primary_release
capture noisily __wf_progress $WFRD1595 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1596 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1597 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1598 `=_rc' // WFLOG-INJECTED
  isid source_year estimate_id
capture noisily __wf_progress $WFRD1599 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1600 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1601 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1602 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1603 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1604 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "universe_2017". // WFDOC-INJECTED
 if "`spec'"=="universe_2017" {
capture noisily __wf_progress $WFRD1605 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1606 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1607 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1608 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate"
capture noisily __wf_progress $WFRD1609 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1610 `=_rc' // WFLOG-INJECTED
  assert _N==3357
capture noisily __wf_progress $WFRD1611 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1612 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1613 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1614 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1615 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1616 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_row
capture noisily __wf_progress $WFRD1617 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1618 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1619 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1620 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_indicator_raw
capture noisily __wf_progress $WFRD1621 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1622 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1623 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1624 `=_rc' // WFLOG-INJECTED
  local actual_type : type val_costrd
capture noisily __wf_progress $WFRD1625 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1626 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1627 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1628 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_rd_indicator_raw
capture noisily __wf_progress $WFRD1629 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1630 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1631 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1632 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_val_costrd
capture noisily __wf_progress $WFRD1633 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1634 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1635 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1636 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_own_token_class
capture noisily __wf_progress $WFRD1637 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1638 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1639 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1640 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_external_token_class
capture noisily __wf_progress $WFRD1641 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1642 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1643 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1644 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD1645 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1646 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1647 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1648 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD1649 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1650 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1651 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1652 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_universe_candidate
capture noisily __wf_progress $WFRD1653 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1654 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1655 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1656 `=_rc' // WFLOG-INJECTED
  isid source_year source_row
capture noisily __wf_progress $WFRD1657 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1658 `=_rc' // WFLOG-INJECTED
  assert source_year==2017
capture noisily __wf_progress $WFRD1659 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1660 `=_rc' // WFLOG-INJECTED
  assert inrange(source_row,1,3357)
capture noisily __wf_progress $WFRD1661 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1662 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1663 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1664 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1665 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1666 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "answer_2017". // WFDOC-INJECTED
 if "`spec'"=="answer_2017" {
capture noisily __wf_progress $WFRD1667 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1668 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1669 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1670 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate"
capture noisily __wf_progress $WFRD1671 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1672 `=_rc' // WFLOG-INJECTED
  assert _N==3357
capture noisily __wf_progress $WFRD1673 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1674 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD1675 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1676 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1677 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1678 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_row
capture noisily __wf_progress $WFRD1679 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1680 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD1681 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1682 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_indicator_raw
capture noisily __wf_progress $WFRD1683 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1684 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1685 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1686 `=_rc' // WFLOG-INJECTED
  local actual_type : type val_costrd
capture noisily __wf_progress $WFRD1687 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1688 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD1689 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1690 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_rd_indicator_raw
capture noisily __wf_progress $WFRD1691 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1692 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1693 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1694 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_val_costrd
capture noisily __wf_progress $WFRD1695 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1696 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1697 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1698 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_own_token_class
capture noisily __wf_progress $WFRD1699 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1700 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1701 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1702 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_external_token_class
capture noisily __wf_progress $WFRD1703 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1704 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1705 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1706 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD1707 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1708 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1709 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1710 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD1711 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1712 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1713 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1714 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_universe_candidate
capture noisily __wf_progress $WFRD1715 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1716 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1717 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1718 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_answer_state_candidate
capture noisily __wf_progress $WFRD1719 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1720 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1721 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1722 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_external_candidate
capture noisily __wf_progress $WFRD1723 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1724 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1725 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1726 `=_rc' // WFLOG-INJECTED
  isid source_year source_row
capture noisily __wf_progress $WFRD1727 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1728 `=_rc' // WFLOG-INJECTED
  assert source_year==2017
capture noisily __wf_progress $WFRD1729 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1730 `=_rc' // WFLOG-INJECTED
  assert inrange(source_row,1,3357)
capture noisily __wf_progress $WFRD1731 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1732 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1733 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1734 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1735 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1736 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "literal_parser_inputs". // WFDOC-INJECTED
 if "`spec'"=="literal_parser_inputs" {
capture noisily __wf_progress $WFRD1737 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1738 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1739 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1740 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission"
capture noisily __wf_progress $WFRD1741 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1742 `=_rc' // WFLOG-INJECTED
  assert _N==24
capture noisily __wf_progress $WFRD1743 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1744 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD1745 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1746 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD1747 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1748 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_rnd17
capture noisily __wf_progress $WFRD1749 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1750 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1751 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1752 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_costrd17
capture noisily __wf_progress $WFRD1753 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1754 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1755 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1756 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_present
capture noisily __wf_progress $WFRD1757 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1758 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1759 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1760 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_present
capture noisily __wf_progress $WFRD1761 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1762 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1763 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1764 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_parent_class
capture noisily __wf_progress $WFRD1765 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1766 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1767 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1768 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_child_class
capture noisily __wf_progress $WFRD1769 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1770 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1771 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1772 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_universe
capture noisily __wf_progress $WFRD1773 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1774 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1775 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1776 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_answer_state
capture noisily __wf_progress $WFRD1777 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1778 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1779 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1780 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_external
capture noisily __wf_progress $WFRD1781 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1782 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1783 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1784 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_outside
capture noisily __wf_progress $WFRD1785 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1786 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1787 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1788 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_admission
capture noisily __wf_progress $WFRD1789 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1790 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1791 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1792 `=_rc' // WFLOG-INJECTED
  isid fixture_id
capture noisily __wf_progress $WFRD1793 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1794 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1795 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1796 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1797 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1798 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "truth25_literal_inputs". // WFDOC-INJECTED
 if "`spec'"=="truth25_literal_inputs" {
capture noisily __wf_progress $WFRD1799 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1800 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1801 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1802 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission"
capture noisily __wf_progress $WFRD1803 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1804 `=_rc' // WFLOG-INJECTED
  assert _N==25
capture noisily __wf_progress $WFRD1805 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1806 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD1807 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1808 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD1809 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1810 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_rnd17
capture noisily __wf_progress $WFRD1811 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1812 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1813 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1814 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_costrd17
capture noisily __wf_progress $WFRD1815 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1816 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1817 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1818 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_present
capture noisily __wf_progress $WFRD1819 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1820 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1821 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1822 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_present
capture noisily __wf_progress $WFRD1823 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1824 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1825 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1826 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_parent_class
capture noisily __wf_progress $WFRD1827 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1828 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1829 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1830 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_child_class
capture noisily __wf_progress $WFRD1831 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1832 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1833 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1834 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_universe
capture noisily __wf_progress $WFRD1835 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1836 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1837 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1838 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_answer_state
capture noisily __wf_progress $WFRD1839 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1840 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1841 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1842 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_external
capture noisily __wf_progress $WFRD1843 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1844 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1845 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1846 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_outside
capture noisily __wf_progress $WFRD1847 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1848 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1849 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1850 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_admission
capture noisily __wf_progress $WFRD1851 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1852 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1853 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1854 `=_rc' // WFLOG-INJECTED
  isid fixture_id
capture noisily __wf_progress $WFRD1855 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1856 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1857 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1858 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1859 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1860 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_literal_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_literal_results" {
capture noisily __wf_progress $WFRD1861 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1862 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1863 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1864 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed"
capture noisily __wf_progress $WFRD1865 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1866 `=_rc' // WFLOG-INJECTED
  assert _N==24
capture noisily __wf_progress $WFRD1867 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1868 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD1869 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1870 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD1871 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1872 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_rnd17
capture noisily __wf_progress $WFRD1873 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1874 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1875 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1876 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_costrd17
capture noisily __wf_progress $WFRD1877 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1878 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1879 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1880 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_present
capture noisily __wf_progress $WFRD1881 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1882 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1883 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1884 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_present
capture noisily __wf_progress $WFRD1885 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1886 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1887 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1888 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_parent_class
capture noisily __wf_progress $WFRD1889 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1890 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1891 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1892 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_child_class
capture noisily __wf_progress $WFRD1893 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1894 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1895 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1896 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_universe
capture noisily __wf_progress $WFRD1897 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1898 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1899 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1900 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_answer_state
capture noisily __wf_progress $WFRD1901 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1902 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1903 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1904 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_external
capture noisily __wf_progress $WFRD1905 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1906 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1907 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1908 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_outside
capture noisily __wf_progress $WFRD1909 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1910 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1911 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1912 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_admission
capture noisily __wf_progress $WFRD1913 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1914 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1915 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1916 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token
capture noisily __wf_progress $WFRD1917 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1918 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1919 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1920 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token
capture noisily __wf_progress $WFRD1921 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1922 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1923 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1924 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD1925 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1926 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1927 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1928 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD1929 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1930 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1931 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1932 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_universe_candidate
capture noisily __wf_progress $WFRD1933 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1934 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1935 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1936 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_answer_state_candidate
capture noisily __wf_progress $WFRD1937 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1938 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1939 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1940 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_external_candidate
capture noisily __wf_progress $WFRD1941 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1942 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1943 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1944 `=_rc' // WFLOG-INJECTED
  local actual_type : type outside_answer_candidate
capture noisily __wf_progress $WFRD1945 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1946 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1947 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1948 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD1949 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1950 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1951 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1952 `=_rc' // WFLOG-INJECTED
  local actual_type : type primary_release
capture noisily __wf_progress $WFRD1953 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1954 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1955 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1956 `=_rc' // WFLOG-INJECTED
  local actual_type : type passed
capture noisily __wf_progress $WFRD1957 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1958 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1959 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1960 `=_rc' // WFLOG-INJECTED
  isid fixture_id
capture noisily __wf_progress $WFRD1961 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1962 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD1963 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1964 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD1965 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1966 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_truth25_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_truth25_results" {
capture noisily __wf_progress $WFRD1967 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1968 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD1969 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1970 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id raw_rnd17 raw_costrd17 parent_present child_present expected_parent_class expected_child_class expected_universe expected_answer_state expected_external expected_outside expected_admission parent_token child_token parent_token_class child_token_class rd_universe_candidate rd_answer_state_candidate rd_external_candidate outside_answer_candidate measurement_admitted primary_release passed"
capture noisily __wf_progress $WFRD1971 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1972 `=_rc' // WFLOG-INJECTED
  assert _N==25
capture noisily __wf_progress $WFRD1973 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1974 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD1975 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1976 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD1977 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1978 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_rnd17
capture noisily __wf_progress $WFRD1979 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1980 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1981 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1982 `=_rc' // WFLOG-INJECTED
  local actual_type : type raw_costrd17
capture noisily __wf_progress $WFRD1983 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1984 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD1985 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1986 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_present
capture noisily __wf_progress $WFRD1987 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1988 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1989 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1990 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_present
capture noisily __wf_progress $WFRD1991 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1992 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD1993 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1994 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_parent_class
capture noisily __wf_progress $WFRD1995 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1996 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD1997 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD1998 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_child_class
capture noisily __wf_progress $WFRD1999 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2000 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2001 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2002 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_universe
capture noisily __wf_progress $WFRD2003 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2004 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2005 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2006 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_answer_state
capture noisily __wf_progress $WFRD2007 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2008 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2009 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2010 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_external
capture noisily __wf_progress $WFRD2011 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2012 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2013 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2014 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_outside
capture noisily __wf_progress $WFRD2015 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2016 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2017 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2018 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_admission
capture noisily __wf_progress $WFRD2019 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2020 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2021 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2022 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token
capture noisily __wf_progress $WFRD2023 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2024 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD2025 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2026 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token
capture noisily __wf_progress $WFRD2027 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2028 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD2029 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2030 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD2031 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2032 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2033 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2034 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD2035 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2036 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2037 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2038 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_universe_candidate
capture noisily __wf_progress $WFRD2039 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2040 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2041 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2042 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_answer_state_candidate
capture noisily __wf_progress $WFRD2043 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2044 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2045 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2046 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_external_candidate
capture noisily __wf_progress $WFRD2047 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2048 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2049 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2050 `=_rc' // WFLOG-INJECTED
  local actual_type : type outside_answer_candidate
capture noisily __wf_progress $WFRD2051 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2052 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2053 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2054 `=_rc' // WFLOG-INJECTED
  local actual_type : type measurement_admitted
capture noisily __wf_progress $WFRD2055 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2056 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2057 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2058 `=_rc' // WFLOG-INJECTED
  local actual_type : type primary_release
capture noisily __wf_progress $WFRD2059 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2060 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2061 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2062 `=_rc' // WFLOG-INJECTED
  local actual_type : type passed
capture noisily __wf_progress $WFRD2063 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2064 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2065 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2066 `=_rc' // WFLOG-INJECTED
  isid fixture_id
capture noisily __wf_progress $WFRD2067 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2068 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2069 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2070 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2071 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2072 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "ratio_fixture_inputs". // WFDOC-INJECTED
 if "`spec'"=="ratio_fixture_inputs" {
capture noisily __wf_progress $WFRD2073 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2074 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD2075 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2076 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id estimate_id eligible_yes_n eligible_no_n eligible_n expected_numerator_n expected_denominator_n expected_ratio expected_percent expected_missing precision_probe"
capture noisily __wf_progress $WFRD2077 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2078 `=_rc' // WFLOG-INJECTED
  assert _N==12
capture noisily __wf_progress $WFRD2079 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2080 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD2081 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2082 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD2083 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2084 `=_rc' // WFLOG-INJECTED
  local actual_type : type estimate_id
capture noisily __wf_progress $WFRD2085 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2086 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD2087 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2088 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_yes_n
capture noisily __wf_progress $WFRD2089 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2090 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2091 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2092 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_no_n
capture noisily __wf_progress $WFRD2093 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2094 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2095 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2096 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_n
capture noisily __wf_progress $WFRD2097 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2098 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2099 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2100 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_numerator_n
capture noisily __wf_progress $WFRD2101 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2102 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2103 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2104 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_denominator_n
capture noisily __wf_progress $WFRD2105 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2106 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2107 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2108 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_ratio
capture noisily __wf_progress $WFRD2109 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2110 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2111 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2112 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_percent
capture noisily __wf_progress $WFRD2113 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2114 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2115 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2116 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_missing
capture noisily __wf_progress $WFRD2117 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2118 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2119 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2120 `=_rc' // WFLOG-INJECTED
  local actual_type : type precision_probe
capture noisily __wf_progress $WFRD2121 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2122 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2123 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2124 `=_rc' // WFLOG-INJECTED
  isid fixture_id estimate_id
capture noisily __wf_progress $WFRD2125 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2126 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2127 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2128 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2129 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2130 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_ratio_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_ratio_results" {
capture noisily __wf_progress $WFRD2131 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2132 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD2133 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2134 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_id estimate_id eligible_yes_n eligible_no_n eligible_n expected_numerator_n expected_denominator_n expected_ratio expected_percent expected_missing precision_probe numerator_n denominator_n ratio percent passed"
capture noisily __wf_progress $WFRD2135 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2136 `=_rc' // WFLOG-INJECTED
  assert _N==12
capture noisily __wf_progress $WFRD2137 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2138 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD2139 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2140 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD2141 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2142 `=_rc' // WFLOG-INJECTED
  local actual_type : type estimate_id
capture noisily __wf_progress $WFRD2143 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2144 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD2145 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2146 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_yes_n
capture noisily __wf_progress $WFRD2147 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2148 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2149 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2150 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_no_n
capture noisily __wf_progress $WFRD2151 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2152 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2153 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2154 `=_rc' // WFLOG-INJECTED
  local actual_type : type eligible_n
capture noisily __wf_progress $WFRD2155 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2156 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2157 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2158 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_numerator_n
capture noisily __wf_progress $WFRD2159 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2160 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2161 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2162 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_denominator_n
capture noisily __wf_progress $WFRD2163 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2164 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2165 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2166 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_ratio
capture noisily __wf_progress $WFRD2167 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2168 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2169 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2170 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_percent
capture noisily __wf_progress $WFRD2171 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2172 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2173 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2174 `=_rc' // WFLOG-INJECTED
  local actual_type : type expected_missing
capture noisily __wf_progress $WFRD2175 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2176 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2177 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2178 `=_rc' // WFLOG-INJECTED
  local actual_type : type precision_probe
capture noisily __wf_progress $WFRD2179 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2180 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2181 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2182 `=_rc' // WFLOG-INJECTED
  local actual_type : type numerator_n
capture noisily __wf_progress $WFRD2183 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2184 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2185 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2186 `=_rc' // WFLOG-INJECTED
  local actual_type : type denominator_n
capture noisily __wf_progress $WFRD2187 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2188 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="long"
capture noisily __wf_progress $WFRD2189 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2190 `=_rc' // WFLOG-INJECTED
  local actual_type : type ratio
capture noisily __wf_progress $WFRD2191 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2192 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2193 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2194 `=_rc' // WFLOG-INJECTED
  local actual_type : type percent
capture noisily __wf_progress $WFRD2195 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2196 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2197 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2198 `=_rc' // WFLOG-INJECTED
  local actual_type : type passed
capture noisily __wf_progress $WFRD2199 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2200 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2201 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2202 `=_rc' // WFLOG-INJECTED
  isid fixture_id estimate_id
capture noisily __wf_progress $WFRD2203 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2204 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2205 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2206 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2207 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2208 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "fixture_results". // WFDOC-INJECTED
 if "`spec'"=="fixture_results" {
capture noisily __wf_progress $WFRD2209 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2210 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD2211 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2212 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="fixture_family fixture_id estimate_id passed"
capture noisily __wf_progress $WFRD2213 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2214 `=_rc' // WFLOG-INJECTED
  assert _N==61
capture noisily __wf_progress $WFRD2215 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2216 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_family
capture noisily __wf_progress $WFRD2217 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2218 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD2219 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2220 `=_rc' // WFLOG-INJECTED
  local actual_type : type fixture_id
capture noisily __wf_progress $WFRD2221 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2222 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str12"
capture noisily __wf_progress $WFRD2223 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2224 `=_rc' // WFLOG-INJECTED
  local actual_type : type estimate_id
capture noisily __wf_progress $WFRD2225 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2226 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str40"
capture noisily __wf_progress $WFRD2227 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2228 `=_rc' // WFLOG-INJECTED
  local actual_type : type passed
capture noisily __wf_progress $WFRD2229 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2230 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2231 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2232 `=_rc' // WFLOG-INJECTED
  assert !missing(fixture_family) & !missing(fixture_id)
capture noisily __wf_progress $WFRD2233 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2234 `=_rc' // WFLOG-INJECTED
  assert missing(estimate_id) if inlist(fixture_family,"truth25","literal")
capture noisily __wf_progress $WFRD2235 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2236 `=_rc' // WFLOG-INJECTED
  assert !missing(estimate_id) if fixture_family=="ratio"
capture noisily __wf_progress $WFRD2237 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2238 `=_rc' // WFLOG-INJECTED
  isid fixture_family fixture_id estimate_id, missok
capture noisily __wf_progress $WFRD2239 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2240 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2241 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2242 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2243 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2244 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "wave_2017_projection". // WFDOC-INJECTED
 if "`spec'"=="wave_2017_projection" {
capture noisily __wf_progress $WFRD2245 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2246 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD2247 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2248 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class"
capture noisily __wf_progress $WFRD2249 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2250 `=_rc' // WFLOG-INJECTED
  assert _N==3357
capture noisily __wf_progress $WFRD2251 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2252 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD2253 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2254 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD2255 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2256 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_row
capture noisily __wf_progress $WFRD2257 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2258 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD2259 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2260 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_indicator_raw
capture noisily __wf_progress $WFRD2261 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2262 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2263 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2264 `=_rc' // WFLOG-INJECTED
  local actual_type : type val_costrd
capture noisily __wf_progress $WFRD2265 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2266 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2267 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2268 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_rd_indicator_raw
capture noisily __wf_progress $WFRD2269 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2270 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2271 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2272 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_val_costrd
capture noisily __wf_progress $WFRD2273 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2274 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2275 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2276 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_own_token_class
capture noisily __wf_progress $WFRD2277 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2278 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2279 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2280 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_external_token_class
capture noisily __wf_progress $WFRD2281 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2282 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2283 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2284 `=_rc' // WFLOG-INJECTED
  isid source_year source_row
capture noisily __wf_progress $WFRD2285 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2286 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2287 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2288 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2289 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2290 `=_rc' // WFLOG-INJECTED
* Isi blok hanya dijalankan bila "`spec'" sama dengan "canonical_decisions_2017". // WFDOC-INJECTED
 if "`spec'"=="canonical_decisions_2017" {
capture noisily __wf_progress $WFRD2291 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2292 `=_rc' // WFLOG-INJECTED
  unab actual_order : _all
capture noisily __wf_progress $WFRD2293 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2294 `=_rc' // WFLOG-INJECTED
  assert "`actual_order'"=="source_year source_row rd_indicator_raw val_costrd vs_rd_indicator_raw vs_val_costrd rd17_own_token_class rd17_external_token_class parent_token_class child_token_class"
capture noisily __wf_progress $WFRD2295 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2296 `=_rc' // WFLOG-INJECTED
  assert _N==3357
capture noisily __wf_progress $WFRD2297 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2298 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_year
capture noisily __wf_progress $WFRD2299 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2300 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD2301 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2302 `=_rc' // WFLOG-INJECTED
  local actual_type : type source_row
capture noisily __wf_progress $WFRD2303 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2304 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="int"
capture noisily __wf_progress $WFRD2305 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2306 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd_indicator_raw
capture noisily __wf_progress $WFRD2307 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2308 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2309 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2310 `=_rc' // WFLOG-INJECTED
  local actual_type : type val_costrd
capture noisily __wf_progress $WFRD2311 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2312 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="double"
capture noisily __wf_progress $WFRD2313 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2314 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_rd_indicator_raw
capture noisily __wf_progress $WFRD2315 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2316 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2317 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2318 `=_rc' // WFLOG-INJECTED
  local actual_type : type vs_val_costrd
capture noisily __wf_progress $WFRD2319 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2320 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="byte"
capture noisily __wf_progress $WFRD2321 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2322 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_own_token_class
capture noisily __wf_progress $WFRD2323 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2324 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2325 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2326 `=_rc' // WFLOG-INJECTED
  local actual_type : type rd17_external_token_class
capture noisily __wf_progress $WFRD2327 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2328 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2329 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2330 `=_rc' // WFLOG-INJECTED
  local actual_type : type parent_token_class
capture noisily __wf_progress $WFRD2331 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2332 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2333 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2334 `=_rc' // WFLOG-INJECTED
  local actual_type : type child_token_class
capture noisily __wf_progress $WFRD2335 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2336 `=_rc' // WFLOG-INJECTED
  assert "`actual_type'"=="str6"
capture noisily __wf_progress $WFRD2337 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2338 `=_rc' // WFLOG-INJECTED
  isid source_year source_row
capture noisily __wf_progress $WFRD2339 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2340 `=_rc' // WFLOG-INJECTED
  assert source_year==2017
capture noisily __wf_progress $WFRD2341 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2342 `=_rc' // WFLOG-INJECTED
  assert inrange(source_row,1,3357)
capture noisily __wf_progress $WFRD2343 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2344 `=_rc' // WFLOG-INJECTED
  exit
capture noisily __wf_progress $WFRD2345 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2346 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress $WFRD2347 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2348 `=_rc' // WFLOG-INJECTED
 display as error "Undeclared output schema"
capture noisily __wf_progress $WFRD2349 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2350 `=_rc' // WFLOG-INJECTED
 exit 198
capture noisily __wf_progress $WFRD2351 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress $WFRD2352 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L831:step-program" "rd2017/lib/shared.do:L1:file" "statement" 12 14 `=_rc' // WFLOG-INJECTED

capture noisily __wf_progress start "rd2017/lib/shared.do:L1317:step-program" "rd2017/lib/shared.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture program drop rd17_export
capture noisily __wf_progress end "rd2017/lib/shared.do:L1317:step-program" "rd2017/lib/shared.do:L1:file" "statement" 13 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1318:step-program" "rd2017/lib/shared.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
* Definisikan perintah bantu rd17_export; isi blok berjalan saat perintah ini dipanggil. // WFDOC-INJECTED
* Ekspor hanya setelah skema lulus: simpan DTA acuan, format angka, tulis CSV, impor ulang menurut spec, cocokkan jumlah baris/kolom dan semua nilai, cek skema lagi, lalu muat kembali DTA acuan. // WFDOC-INJECTED
program define rd17_export
capture noisily __wf_progress start "rd2017/lib/shared.do:L1318:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1319:step-syntax" "rd2017/lib/shared.do:L1318:program-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
 syntax, STEM(string) SPEC(string)
capture noisily __wf_progress end "rd2017/lib/shared.do:L1319:step-syntax" "rd2017/lib/shared.do:L1318:program-body" "statement" 1 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1320:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
 rd17_schema, spec("`spec'")
capture noisily __wf_progress end "rd2017/lib/shared.do:L1320:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 2 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1321:step-save" "rd2017/lib/shared.do:L1318:program-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
 save "`stem'.dta", replace
capture noisily __wf_progress end "rd2017/lib/shared.do:L1321:step-save" "rd2017/lib/shared.do:L1318:program-body" "statement" 3 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1322:step-unab" "rd2017/lib/shared.do:L1318:program-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
 unab original_order : _all
capture noisily __wf_progress end "rd2017/lib/shared.do:L1322:step-unab" "rd2017/lib/shared.do:L1318:program-body" "statement" 4 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1323:step-ds" "rd2017/lib/shared.do:L1318:program-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
 quietly ds, has(type numeric)
capture noisily __wf_progress end "rd2017/lib/shared.do:L1323:step-ds" "rd2017/lib/shared.do:L1318:program-body" "statement" 5 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1324:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
 local numeric `r(varlist)'
capture noisily __wf_progress end "rd2017/lib/shared.do:L1324:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 6 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1325:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
 local types
capture noisily __wf_progress end "rd2017/lib/shared.do:L1325:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 7 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1326:step-foreach" "rd2017/lib/shared.do:L1318:program-body" "loop" 8 18 `=_rc' "local-expanded" `"`numeric'"' // WFLOG-INJECTED
* Ulangi blok untuk tiap v dalam daftar local numeric. // WFDOC-INJECTED
 foreach v of local numeric {
capture noisily __wf_progress start "rd2017/lib/shared.do:L1326:iteration-body" "rd2017/lib/shared.do:L1326:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1327:step-local" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
  local t : type `v'
capture noisily __wf_progress end "rd2017/lib/shared.do:L1327:step-local" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 1 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1328:step-local" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
  local types "`types' `t'"
capture noisily __wf_progress end "rd2017/lib/shared.do:L1328:step-local" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 2 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1329:step-format" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
  format `v' %24.17g
capture noisily __wf_progress end "rd2017/lib/shared.do:L1329:step-format" "rd2017/lib/shared.do:L1326:iteration-body" "statement" 3 3 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L1326:iteration-body" "rd2017/lib/shared.do:L1326:step-foreach" "iteration" 0 0 `=_rc' // WFLOG-INJECTED
 }
capture noisily __wf_progress end "rd2017/lib/shared.do:L1326:step-foreach" "rd2017/lib/shared.do:L1318:program-body" "loop" 8 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1331:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 9 18 `=_rc' // WFLOG-INJECTED
 local rows=_N
capture noisily __wf_progress end "rd2017/lib/shared.do:L1331:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 9 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1332:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
 local columns=c(k)
capture noisily __wf_progress end "rd2017/lib/shared.do:L1332:step-local" "rd2017/lib/shared.do:L1318:program-body" "statement" 10 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1333:step-export" "rd2017/lib/shared.do:L1318:program-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
* Tulis tabel yang sedang terbuka ke CSV pada nama file di perintah ini. // WFDOC-INJECTED
 export delimited using "`stem'.csv", datafmt nolabel quote replace
capture noisily __wf_progress end "rd2017/lib/shared.do:L1333:step-export" "rd2017/lib/shared.do:L1318:program-body" "statement" 11 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1334:step-rd17_import" "rd2017/lib/shared.do:L1318:program-body" "statement" 12 18 `=_rc' // WFLOG-INJECTED
 rd17_import, file("`stem'.csv") spec("`spec'")
capture noisily __wf_progress end "rd2017/lib/shared.do:L1334:step-rd17_import" "rd2017/lib/shared.do:L1318:program-body" "statement" 12 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1335:step-assert" "rd2017/lib/shared.do:L1318:program-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
 assert _N==`rows' & c(k)==`columns'
capture noisily __wf_progress end "rd2017/lib/shared.do:L1335:step-assert" "rd2017/lib/shared.do:L1318:program-body" "statement" 13 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1336:step-cf" "rd2017/lib/shared.do:L1318:program-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
 cf _all using "`stem'.dta"
capture noisily __wf_progress end "rd2017/lib/shared.do:L1336:step-cf" "rd2017/lib/shared.do:L1318:program-body" "statement" 14 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1337:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
 rd17_schema, spec("`spec'")
capture noisily __wf_progress end "rd2017/lib/shared.do:L1337:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 15 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1338:step-use" "rd2017/lib/shared.do:L1318:program-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
 use "`stem'.dta", clear
capture noisily __wf_progress end "rd2017/lib/shared.do:L1338:step-use" "rd2017/lib/shared.do:L1318:program-body" "statement" 16 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1339:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
 rd17_schema, spec("`spec'")
capture noisily __wf_progress end "rd2017/lib/shared.do:L1339:step-rd17_schema" "rd2017/lib/shared.do:L1318:program-body" "statement" 17 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress start "rd2017/lib/shared.do:L1340:step-display" "rd2017/lib/shared.do:L1318:program-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
 display "RD17_ROUNDTRIP_PASS `stem'"
capture noisily __wf_progress end "rd2017/lib/shared.do:L1340:step-display" "rd2017/lib/shared.do:L1318:program-body" "statement" 18 18 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L1318:program-body" "" "program" 1 1 `=_rc' // WFLOG-INJECTED
end
capture noisily __wf_progress end "rd2017/lib/shared.do:L1318:step-program" "rd2017/lib/shared.do:L1:file" "statement" 14 14 `=_rc' // WFLOG-INJECTED
capture noisily __wf_progress end "rd2017/lib/shared.do:L1:file" "" "file" 1 1 `=_rc' // WFLOG-INJECTED
