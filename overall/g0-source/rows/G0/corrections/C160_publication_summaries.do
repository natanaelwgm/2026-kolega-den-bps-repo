* Tujuan: Bentuk statistik ringkas per tahun dan variabel—jumlah baris, terisi/kosong, nol, negatif, rerata, simpangan baku, rentang, dan persentil—bersama status rilisnya. // WFDOC-INJECTED
* Input: data/analysis/G0_analysis_ready.dta // WFDOC-INJECTED
* Output: corrections/reports/core_descriptive_statistics.dta; corrections/data/C160.dta // WFDOC-INJECTED
* Jika perintah atau syarat berhenti dengan error, hasil belum selesai; cek pesan error dan baris terakhir di log. // WFDOC-INJECTED
version 17
do "/Users/natanaelmassie/Documents/Codex/2026-09-13/hai/work/G0-wave-foundation-v2/rows/G0/corrections/_utils.do"
g0c_begin "C160_publication_summaries"
* Buat ringkasan per tahun/variabel: jumlah baris, nilai terisi/kosong, nol, negatif, rerata, simpangan baku, rentang, dan persentil; status rilis tetap menyertai angka. // WFDOC-INJECTED
use "data/analysis/G0_analysis_ready.dta", clear
tempname post
postfile `post' str32 variable int source_year str32 bound_field str35 release_status long rows long n long missing_rows long zero long negative double mean double sd double min double p1 double p5 double p10 double p25 double p50 double p75 double p90 double p95 double p99 double max using "corrections/reports/core_descriptive_statistics.dta", replace
quietly count if source_year==2010
local total=r(N)
generate double __v=workers if source_year==2010 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2010) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=workers if source_year==2011 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2011) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=workers if source_year==2012 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2012) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=workers if source_year==2013 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2013) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=workers if source_year==2014 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2014) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=workers if source_year==2015 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2015) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=workers if source_year==2017 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2017) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=workers if source_year==2018 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2018) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=workers if source_year==2019 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2019) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=workers if source_year==2020 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2020) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=workers if source_year==2021 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2021) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=workers if source_year==2022 & !missing(workers) & workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("workers") (2022) ("workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=production_workers if source_year==2010 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2010) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=production_workers if source_year==2011 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2011) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=production_workers if source_year==2012 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2012) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=production_workers if source_year==2013 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2013) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=production_workers if source_year==2014 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2014) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=production_workers if source_year==2015 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2015) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=production_workers if source_year==2017 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2017) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=production_workers if source_year==2018 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2018) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=production_workers if source_year==2019 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2019) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=production_workers if source_year==2020 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2020) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=production_workers if source_year==2021 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2021) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=production_workers if source_year==2022 & !missing(production_workers) & production_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("production_workers") (2022) ("production_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=gross_output_nominal if source_year==2010 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2010) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=gross_output_nominal if source_year==2011 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2011) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=gross_output_nominal if source_year==2012 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2012) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=gross_output_nominal if source_year==2013 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2013) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=gross_output_nominal if source_year==2014 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2014) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=gross_output_nominal if source_year==2015 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2015) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=gross_output_nominal if source_year==2017 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2017) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=gross_output_nominal if source_year==2018 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2018) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=gross_output_nominal if source_year==2019 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2019) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=gross_output_nominal if source_year==2020 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2020) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=gross_output_nominal if source_year==2021 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2021) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=gross_output_nominal if source_year==2022 & !missing(gross_output_nominal) & gross_output_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gross_output_nominal") (2022) ("gross_output_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2010 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2010) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2011 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2011) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2012 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2012) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2013 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2013) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2014 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2014) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2015 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2015) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2017 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2017) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2018 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2018) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2019 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2019) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2020 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2020) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2021 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2021) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=intermediate_inputs_nominal if source_year==2022 & !missing(intermediate_inputs_nominal) & intermediate_inputs_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("intermediate_inputs_nominal") (2022) ("intermediate_inputs_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=va_signed_nominal if source_year==2010 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2010) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=va_signed_nominal if source_year==2011 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2011) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=va_signed_nominal if source_year==2012 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2012) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=va_signed_nominal if source_year==2013 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2013) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=va_signed_nominal if source_year==2014 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2014) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=va_signed_nominal if source_year==2015 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2015) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=va_signed_nominal if source_year==2017 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2017) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=va_signed_nominal if source_year==2018 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2018) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=va_signed_nominal if source_year==2019 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2019) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=va_signed_nominal if source_year==2020 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2020) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=va_signed_nominal if source_year==2021 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2021) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=va_signed_nominal if source_year==2022 & !missing(va_signed_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("value_added_nominal") (2022) ("va_signed_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2010 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2010) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2011 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2011) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2012 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2012) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2013 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2013) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2014 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2014) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2015 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2015) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2017 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2017) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2018 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2018) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2019 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2019) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2020 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2020) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2021 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2021) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_output_per_worker_nominal if source_year==2022 & !missing(r_output_per_worker_nominal) & r_output_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("output_per_worker_nominal") (2022) ("r_output_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2010 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2010) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2011 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2011) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2012 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2012) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2013 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2013) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2014 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2014) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2015 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2015) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2017 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2017) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2018 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2018) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2019 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2019) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2020 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2020) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2021 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2021) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_labor_productivity_nominal if source_year==2022 & !missing(r_labor_productivity_nominal)
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("labor_productivity_nominal") (2022) ("r_labor_productivity_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2010 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2010) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2011 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2011) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2012 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2012) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2013 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2013) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2014 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2014) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2015 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2015) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2017 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2017) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2018 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2018) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2019 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2019) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2020 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2020) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2021 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2021) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_inputs_per_worker_nominal if source_year==2022 & !missing(r_inputs_per_worker_nominal) & r_inputs_per_worker_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("inputs_per_worker_nominal") (2022) ("r_inputs_per_worker_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2010 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2010) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2011 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2011) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2012 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2012) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2013 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2013) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2014 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2014) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2015 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2015) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2017 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2017) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2018 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2018) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2019 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2019) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2020 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2020) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2021 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2021) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=capital_stock_nominal if source_year==2022 & !missing(capital_stock_nominal) & capital_stock_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_nominal") (2022) ("capital_stock_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2010 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2010) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2011 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2011) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2012 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2012) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2013 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2013) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2014 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2014) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2015 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2015) ("capital_additions_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2017 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2017) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2018 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2018) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2019 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2019) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2020 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2020) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2021 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2021) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=capital_additions_nominal if source_year==2022 & !missing(capital_additions_nominal) & capital_additions_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_nominal") (2022) ("capital_additions_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2010 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2010) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2011 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2011) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2012 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2012) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2013 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2013) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2014 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2014) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2015 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2015) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2017 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2017) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2018 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2018) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2019 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2019) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2020 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2020) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2021 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2021) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_capital_stock_per_worker if source_year==2022 & !missing(r_capital_stock_per_worker) & r_capital_stock_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_stock_per_worker") (2022) ("r_capital_stock_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2010 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2010) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2011 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2011) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2012 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2012) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2013 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2013) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2014 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2014) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2015 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2015) ("r_capital_additions_per_worker") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2017 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2017) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2018 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2018) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2019 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2019) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2020 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2020) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2021 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2021) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_capital_additions_per_worker if source_year==2022 & !missing(r_capital_additions_per_worker) & r_capital_additions_per_worker>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("capital_additions_per_worker") (2022) ("r_capital_additions_per_worker") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2010 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2010) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2011 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2011) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2012 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2012) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2013 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2013) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2014 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2014) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2015 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2015) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2017 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2017) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2018 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2018) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2019 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2019) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2020 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2020) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2021 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2021) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_elec_purchased_kwh if source_year==2022 & !missing(r_elec_purchased_kwh) & r_elec_purchased_kwh>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("elec_purchased_kwh") (2022) ("r_elec_purchased_kwh") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_gj_electricity if source_year==2010 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2010) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_gj_electricity if source_year==2011 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2011) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_gj_electricity if source_year==2012 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2012) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_gj_electricity if source_year==2013 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2013) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_gj_electricity if source_year==2014 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2014) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_gj_electricity if source_year==2015 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2015) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_gj_electricity if source_year==2017 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2017) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_gj_electricity if source_year==2018 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2018) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_gj_electricity if source_year==2019 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2019) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_gj_electricity if source_year==2020 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2020) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_gj_electricity if source_year==2021 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2021) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_gj_electricity if source_year==2022 & !missing(r_gj_electricity) & r_gj_electricity>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_electricity") (2022) ("r_gj_electricity") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2010 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2010) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2011 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2011) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2012 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2012) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2013 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2013) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2014 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2014) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2015 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2015) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2017 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2017) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2018 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2018) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2019 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2019) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2020 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2020) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2021 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2021) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_gj_fuel_s1 if source_year==2022 & !missing(r_gj_fuel_s1) & r_gj_fuel_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("gj_fuel_s1") (2022) ("r_gj_fuel_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2010 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2010) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2011 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2011) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2012 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2012) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2013 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2013) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2014 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2014) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2015 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2015) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2017 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2017) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2018 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2018) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2019 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2019) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2020 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2020) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2021 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2021) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_total_gj_s1 if source_year==2022 & !missing(r_total_gj_s1) & r_total_gj_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("total_gj_s1") (2022) ("r_total_gj_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2010 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2010) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2011 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2011) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2012 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2012) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2013 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2013) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2014 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2014) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2015 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2015) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2017 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2017) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2018 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2018) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2019 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2019) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2020 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2020) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2021 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2021) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_co2_scope1_s1 if source_year==2022 & !missing(r_co2_scope1_s1) & r_co2_scope1_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope1_s1") (2022) ("r_co2_scope1_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2010 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2010) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2011 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2011) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2012 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2012) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2013 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2013) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2014 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2014) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2015 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2015) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2017 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2017) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2018 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2018) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2019 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2019) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2020 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2020) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2021 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2021) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_co2_scope2_s1 if source_year==2022 & !missing(r_co2_scope2_s1) & r_co2_scope2_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_scope2_s1") (2022) ("r_co2_scope2_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2010 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2010) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2011 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2011) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2012 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2012) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2013 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2013) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2014 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2014) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2015 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2015) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2017 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2017) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2018 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2018) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2019 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2019) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2020 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2020) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2021 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2021) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=r_co2_total_s1 if source_year==2022 & !missing(r_co2_total_s1) & r_co2_total_s1>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("co2_total_s1") (2022) ("r_co2_total_s1") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2010 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2010) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2011 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2011) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2012 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2012) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2013 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2013) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2014 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2014) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2015 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2015) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2017 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2017) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2018 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2018) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2019 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2019) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2020 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2020) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2021 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2021) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=energy_exp_observed_repaired if source_year==2022 & !missing(energy_exp_observed_repaired) & energy_exp_observed_repaired>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("energy_expenditure_rp000") (2022) ("energy_exp_observed_repaired") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2010 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2010) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2011 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2011) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2012 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2012) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2013 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2013) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2014 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2014) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2015 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2015) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2017 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2017) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2018 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2018) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2019 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2019) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2020 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2020) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2021 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2021) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=fuel_coal_kg if source_year==2022 & !missing(fuel_coal_kg) & fuel_coal_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_coal_kg") (2022) ("fuel_coal_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2010 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2010) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2011 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2011) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2012 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2012) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2013 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2013) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2014 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2014) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2015 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2015) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2017 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2017) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2018 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2018) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2019 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2019) ("fuel_biomass_kg") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2020 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2020) ("fuel_biomass_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2021 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2021) ("fuel_biomass_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=fuel_biomass_kg if source_year==2022 & !missing(fuel_biomass_kg) & fuel_biomass_kg>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_biomass_kg") (2022) ("fuel_biomass_kg") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2010 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2010) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2011 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2011) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2012 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2012) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2013 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2013) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2014 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2014) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2015 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2015) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2017 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2017) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2018 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2018) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2019 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2019) ("fuel_natgas_mmbtu") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2020 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2020) ("fuel_natgas_mmbtu") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2021 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2021) ("fuel_natgas_mmbtu") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=fuel_natgas_mmbtu if source_year==2022 & !missing(fuel_natgas_mmbtu) & fuel_natgas_mmbtu>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("fuel_natgas_mmbtu") (2022) ("fuel_natgas_mmbtu") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=import_value_nominal if source_year==2010 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2010) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=import_value_nominal if source_year==2011 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2011) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=import_value_nominal if source_year==2012 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2012) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=import_value_nominal if source_year==2013 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2013) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=import_value_nominal if source_year==2014 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2014) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=import_value_nominal if source_year==2015 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2015) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=import_value_nominal if source_year==2017 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2017) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=import_value_nominal if source_year==2018 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2018) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=import_value_nominal if source_year==2019 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2019) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=import_value_nominal if source_year==2020 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2020) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=import_value_nominal if source_year==2021 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2021) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=import_value_nominal if source_year==2022 & !missing(import_value_nominal) & import_value_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("import_value_nominal") (2022) ("import_value_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2010 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2010) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2011 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2011) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2012 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2012) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2013 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2013) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2014 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2014) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2015 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2015) ("rd_cost_nominal") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2017 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2017) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2018 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2018) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2019 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2019) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2020 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2020) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2021 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2021) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=rd_cost_nominal if source_year==2022 & !missing(rd_cost_nominal) & rd_cost_nominal>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_cost_nominal") (2022) ("rd_cost_nominal") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2010
local total=r(N)
generate double __v=rd_workers if source_year==2010 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2010) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2011
local total=r(N)
generate double __v=rd_workers if source_year==2011 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2011) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2012
local total=r(N)
generate double __v=rd_workers if source_year==2012 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2012) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2013
local total=r(N)
generate double __v=rd_workers if source_year==2013 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2013) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2014
local total=r(N)
generate double __v=rd_workers if source_year==2014 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2014) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2015
local total=r(N)
generate double __v=rd_workers if source_year==2015 & !missing(rd_workers) & rd_workers>=0
replace __v=.
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2015) ("rd_workers") ("unavailable_source_gate") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2017
local total=r(N)
generate double __v=rd_workers if source_year==2017 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2017) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2018
local total=r(N)
generate double __v=rd_workers if source_year==2018 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2018) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2019
local total=r(N)
generate double __v=rd_workers if source_year==2019 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2019) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2020
local total=r(N)
generate double __v=rd_workers if source_year==2020 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2020) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2021
local total=r(N)
generate double __v=rd_workers if source_year==2021 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2021) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
quietly count if source_year==2022
local total=r(N)
generate double __v=rd_workers if source_year==2022 & !missing(rd_workers) & rd_workers>=0
quietly summarize __v, detail
local n=r(N)
local mean=cond(`n'>0,r(mean),.)
local sd=cond(`n'>0,r(sd),.)
local min=cond(`n'>0,r(min),.)
local p1=cond(`n'>0,r(p1),.)
local p5=cond(`n'>0,r(p5),.)
local p10=cond(`n'>0,r(p10),.)
local p25=cond(`n'>0,r(p25),.)
local p50=cond(`n'>0,r(p50),.)
local p75=cond(`n'>0,r(p75),.)
local p90=cond(`n'>0,r(p90),.)
local p95=cond(`n'>0,r(p95),.)
local p99=cond(`n'>0,r(p99),.)
local max=cond(`n'>0,r(max),.)
quietly count if __v==0
local zeros=r(N)
quietly count if __v<0 & !missing(__v)
local negatives=r(N)
assert `zeros'+`negatives'<=`n'
post `post' ("rd_workers") (2022) ("rd_workers") ("legacy_candidate_display_only") (`total') (`n') (`total'-`n') (`zeros') (`negatives') (`mean') (`sd') (`min') (`p1') (`p5') (`p10') (`p25') (`p50') (`p75') (`p90') (`p95') (`p99') (`max')
drop __v
postclose `post'
use "corrections/reports/core_descriptive_statistics.dta", clear
isid variable source_year release_status
assert n+missing_rows==rows
assert zero>=0 & negative>=0 & zero+negative<=n & n<=rows
assert min<=p1 & p1<=p5 & p5<=p10 & p10<=p25 & p25<=p50 & p50<=p75 & p75<=p90 & p90<=p95 & p95<=p99 & p99<=max if n>0
assert mean>=min & mean<=max if n>0
keep variable source_year release_status bound_field rows n missing_rows zero negative mean sd min p1 p5 p10 p25 p50 p75 p90 p95 p99 max
order variable source_year release_status
* Tutup log, simpan hasil koreksi bernama ID di baris ini, lalu catat jumlah baris/kolom. // WFDOC-INJECTED
g0c_finish "C160_publication_summaries" "C160"
