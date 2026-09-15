*! version 1.0.1 15Sep2016
*! version 1.0.2 22Sep2016
*! version 1.0.3 30Sep2016 Fixed a major bug, add first stage residuals options, seeds option, evaluator option and postestimation
*! version 1.0.4 10Feb2017 Fixed a major bugs in winitial() matrix in MrEst, fixed minor bug on Wrdg control and names, 
*!						   added translog production function, added starting points option for estimation, add check for multiple state and proxy
*! version 1.0.5 06Jun2017 Fixed minor bugs in control variable management, error management of translog production function, added a new feature 
*!						   in table reporting (prod function CB / Tranlsog), fixed major bugs in predict
*| version 1.0.6 15Oct2017 SJ review: Added the Wald test for constant return to scale, added the overidentification option for both ACF and WRDG
*! version 1.1.1 13Feb2018 SJ review: Fixed an issue with var names that prevented more than 10 state variable to be used at once, added the "Robinson/ACF" model, 
*!									  added the "gmm" option for Wrdg models, fixed the linear version of Wrdg model
*! version 1.1.2 14Mar2018 Added the eret loc FSres in case of first stage residuals, in order to ensure that predict, omega can be launched
*! version 1.2.1 26Jun2018 Made several minor fixes on helpfile and dofile suggested by Sven-Kristjan Bormann. Added his dialog box file to the package
*! version 1.2.2 30Jul2018 Added the controls to the Wooldridge - plain - method.
*! authors Gabriele Rovigatti, Bank of Italy, Rome, Italy. mailto: gabriele.rovigatti@gmail.com  |  gabriele.rovigatti@esterni.bancaditalia.it
*!         Vincenzo Mollisi, Bolzano University, Bolzano, Italy & Tor Vergata University, Rome, Italy. mailto: vincenzo.mollisi@gmail.com

/***************************************************************************
** Stata program for Production Function Estimation using the control function approach.
**
** Programmed by:   Gabriele Rovigatti

** Parts of the code are based on the xsmle module by Belotti, F., Hughes, G. and Piano Mortari, A. 
** and on the levpet module by Petrin, A., Poi, B. and Levinsohn, J.

**************************************************************************/

* WFDOC: Adapter ini menjalankan satu point fit per panggilan untuk cabang produksi nilai tambah yang dipatok; bukan estimasi empat metode sekaligus.
* WFDOC: y, free, state, dan proxy adalah log variabel yang definisi serta mode ukurannya harus dibuktikan oleh receipt pemanggil; adapter sendiri hanya memeriksa format numerik.
* WFDOC: id adalah perusahaan dan t tahun kalender aktual; wrapper G1 membentuk domain transisi t dengan t-1 kalender, sehingga celah tahun tidak menjadi lag satu tahun.
* WFDOC: OP menerima probabilitas exit dari wrapper yang memasang model pada seluruh risk set terautentikasi sebelum filter produksi; baris terakhir sampel tidak dianggap sebagai penutupan.
* WFDOC: Keluaran adalah koefisien point fit dan diagnostik; tidak ada kovarians bootstrap atau prediksi omega otomatis, dan kegagalan opsi, rank, atau konvergensi harus tetap terlihat.
capture program drop g1_prodest_point
program define g1_prodest_point, sortpreserve eclass
	version 10.0
	syntax varlist(numeric min=1 max=1) [if] [in], free(varlist numeric min=1) /*
		  */ proxy(varlist numeric min=1 max=2) state(varlist numeric min=1) /*
		  */ [control(varlist min=1) ENDOgenous(varlist min=1) id(varlist min=1 max=1) t(varlist min=1 max=1) reps(integer 5) /*
		  */ VAlueadded Level(int ${S_level}) OPTimizer(namelist min=1 max=3) MAXiter(integer 10000) /* OPTIMIZER: THERE IS THE POSSIBILITY TO WRITE technique(nr 100 nm 1000) with different optimizers after the number of iterations. 
		  */ poly(integer 3) METhod(name min=1 max=1) lags(integer 999) TOLerance(real 0.00001) gmm /*
		  */ ATTrition ACF INIT(string) FSRESiduals(name min=1 max=1) EVALuator(string) TRANSlog OVERidentification OPPROB(varname numeric)]  
	
	loc vv: di "version " string(min(max(10,c(stata_version)),14.0)) ", missing:" // we want a version 10 min, while a version 14.0 max (no version 14.2)
	loc depvar `varlist'
	marksample touse
	markout `touse' `free' `proxy' `state' `control' `endogenous' `id' `t' 
	
	/// checks for same variables in state - free - proxy - controls
	loc chk1: list free & state
	loc chk2: list free & control
	loc chk3: list free & proxy
	loc chk4: list state & control
	loc chk5: list state & proxy
	loc chk6: list control & proxy
	forval i = 1/6{
		if "`chk`i''" != ""{
			di as error "Same variables in free, state, control or proxy."
			exit 198
		}
	}
	/// check whether there are more than one state AND more than one proxy
	loc pnum: word count `proxy'
	loc snum: word count `state'
	if `pnum' > 1 & `snum' > 1{
		di as error "Cannot specify multiple state AND multiple proxy variables"
		exit 198
	}
	/// check for unavailable choice of models
	if (!inlist("`method'","op","lp","wrdg","mr","rob") & !mi("`method'")){
		di as error "Allowed methods are op, lp, wrdg, mr or rob. Default is lp"
		exit 198
	}
	else if ("`method'" == "mr" & c(stata_version) < 14.2){
		di as error "MrEst only available with Stata version 14.2 or higher"
		exit 198
	}
	else if mi("`method'"){
		loc method "lp"
	}
	/// Check for unpractical value of polynomial approximation
	if (`poly' >= 7 | `poly' < 2){
		di as error "Polynomial degree must lie between 2 and 6"
		exit 198
	}
	/// Syntax check: is data xtset? 
	if (mi("`id'") | mi("`t'")) {
	  capture xtset
	  if (_rc != 0) {
		 di as error "You must either xtset your data or specify both id() and t()"
		 error _rc
	  }
	  else {
		 loc id = r(panelvar)
		 loc t = r(timevar)
	  }
	}
	else {
	  qui xtset `id' `t'
	}
	/// Check for a valid confidence level 
	if (`level' < 10 | `level' > 99) {
		di as error "confidence level must be between 10 and 99"
		error 198
	}
	/// Value added or gross output? 
	if mi("`valueadded'"){
		loc model "grossoutput"
		loc proxyGO `proxy'
		loc lproxyGO l_gen`proxy'
	}
	else {
		loc model "valueadded"
	}
	/// Number of repetitions reasonable? 
* WFDOC: Adapter memaksa reps(1); 999 bootstrap tanaman dijalankan terpisah atas sumber lengkap agar sampel ulang memasang kembali lag dan tahapan OP bila dipilih.
	if `reps' != 1 {
        di as error "G1 adapter requires reps(1); bootstrap the full source/risk universe externally"
        exit 198
    }
    if "`valueadded'"=="" | !inlist("`method'","op","lp","wrdg") {
        di as error "G1 adapter supports only the registered value-added estimators"
        exit 198
    }
    if "`method'"=="wrdg" & "`gmm'"=="" exit 198
    if "`method'"=="op" & ("`attrition'"=="" | "`opprob'"=="") {
        di as error "OP requires authenticated external selection probabilities"
        exit 459
    }
    if "`init'"=="" {
        di as error "G1 requires an explicit deterministic starting vector"
        exit 198
    }

	/// optimizer choice
	if (!mi("`optimizer'") & !inlist("`optimizer'", "nm", "nr", "dfp", "bfgs", "bhhh", "gn")){
		di as error "Allowed optimizers are nm, nr, dfp, bfgs and bhhh or gn for wrdg and mr. Default is nm or gn for wrdg and mr"
		exit 198
	}
	else if inlist("`method'", "wrdg", "mr") & inlist("`optimizer'", "nm", "bhhh"){
		di as error "`optimizer' is not allowed with `method' method. Optimizer switched to gn (default)"
		loc optimizer "gn"
	}
	else if mi("`optimizer'") & !inlist("`method'", "wrdg", "mr"){
		loc optimizer "nm"
	}
	else if mi("`optimizer'"){
		loc optimizer "gn"
	}
	/// number of lags in MR metodology
	if ("`method'" == "mr" & mi("`lags'")){
		di as error "Method 'mr' requires a specification for lags. Switched to 'all possible lags' (default)"
		loc lags = .
	}
	else if ("`method'" == "mr" & (`lags' < 1)) {
		di as error "Minimum lag is 1"
		exit 198
	}
	else if ("`method'" == "mr" & (`lags' == 999)) {
		loc lags = .
	}
	/// check ACF correction in woolridge and mr cases
	if ("`method'" == "wrdg" | "`method'" == "mr") & !mi("`acf'"){
		di as error "`method' does not support ACF correction. Estimation run on baseline model"
		loc acf ""
	}
	/// feasible values of tolerance
	if mi(`tolerance') | `tolerance' > 0.01{
		di as error "maximum value of tolerance is 0.01. Changed to default of value of e-5"
		loc tolerance = 0.00001
	}
	if ("`method'" == "op") {
		loc proxyGO ""
		loc lproxyGO ""
	}
	/// define conv_nrtol for wooldridge and mr - NOT in case of GN
	if ("`method'" == "wrdg" | "`method'" == "mr") & "`optimizer'" != "gn"{
		loc conv_nrtol "conv_nrtol(`tolerance')"
	}
	if ("`method'" == "wrdg" | "`method'" == "mr") & !mi("`init'"){
		loc init = subinstr("`init'",","," ",.)
		foreach var in `free' `state'{
			gettoken val init: init
			loc init_gmm `init_gmm' `var' `val'
		}
		loc init_gmm from(`init_gmm')
	}
	if !mi("`fsresiduals'") & inlist("`method'", "wrdg", "mr", "rob"){
		di as error "fsresiduals is available with OP and LP methods only."
		exit 198
	}
	cap confirm var `fsresiduals'
	if !_rc{
		di as error "`fsresiduals' already exists"
		exit 198
	}
	/// define the evaluator type
	if mi("`evaluator'") & "`optimizer'" == "bhhh"{
		loc evaluator = "gf0"
	}
	else if mi("`evaluator'"){
		loc evaluator = "d0"
	}
	/// check the translog - only meaningful for ACF and Wooldridge methods
	if !mi("`translog'") & mi("`acf'") & "`method'" != "wrdg"{
		di as error "translog is available with Wooldridge or ACF-corrected models only"
		exit 198
	}
	else if !mi("`translog'") & !mi("`acf'"){
		loc transVars `free' `state' `proxyGO'
	}
	/// change the production function type
	if !mi("`translog'"){
		loc PFtype "translog"
	} 
	else{
		loc PFtype "Cobb-Douglas"
	}
	if !mi("`overidentification'") & mi("`acf'") & "`method'" != "wrdg"{
		di as error "overidentification is meaningful for ACF or WRDG methods only. Ignoring the option."
	}
	if !mi("`gmm'") & "`method'" != "wrdg"{
		di as error "gmm works for wrdg only. Ignoring the option."
		loc gmm ""
	}
	if !mi("`acf'") & "`model'" == "grossoutput"{
		di as error "Using ACF correction with GO output does not ensure a correct parameter identification. See ACF (2015)."
	}
	
	if "`method'" == "op" loc strMethod "Olley-Pakes"
	if "`method'" == "lp" loc strMethod "Levinsohn-Petrin"
	if "`method'" == "wrdg" loc strMethod "Wooldridge"
	if "`method'" == "rob" loc strMethod "Wooldridge/Robinson"
	if "`method'" == "mr" loc strMethod "Mollisi-Rovigatti"
	
	loc colnum: word count `free' `state' `control' `proxyGO' 
	
	/// initialize results matrices
	tempname firstb __b __V robV
	mat `__b' = J(`reps',`colnum',.)
	
	/// preserve the data before generating tons of variables
	preserve
		/// generate some locals to be used in order to display results
		qui xtdes if `touse' == 1, i(`id') t(`t')
		loc nObs = `r(sum)'
		loc nGroups = `r(N)'
		loc minGroup = `r(min)'
		loc meanGroup = `r(mean)'
		loc maxGroup = `r(max)'
		qui su `t' if `touse' == 1
		loc maxDate = `r(max)'
		
		/// directly keep only observations in IF and IN --> SAVE A TEMPORARY FILE 
* WFDOC: touse mencerminkan if/in dan kelengkapan variabel estimator, lalu file sementara hanya menyimpan domain koefisien; risk set OP sudah dinilai dan probabilitasnya dipasok wrapper sebelum penyempitan ini.
		tempfile temp
		qui keep if `touse' == 1
		keep `depvar' `free' `state' `proxy' `control' `id' `t' `touse' `endogenous' `opprob' 
        * Exit is NEVER derived from estimator-filtered record absence.
		qui save `temp', replace
				
		/// here we start with bootstrap repetitions
		forv b = 1/`reps'{
			/// print the number of reps each 10 of them
			if mod(`b'/10,1) == 0 & !inlist("`method'","wrdg","mr"){
				noi di "`b'" _continue
			}
			else if mod(`b'/10,1) != 0 & !inlist("`method'","wrdg","mr"){
				noi di "." _continue
			}
			if `b' > 1{
				use `temp', clear
				tempvar new_id
				qui bsample, cluster(`id') idcluster(`new_id')
				qui xtset `new_id' `t'
			}
			
			/// define all locals to run the command
			loc toLagVars `free' `state' `control' `proxyGO' 
			
			foreach var of local toLagVars{
				qui gen double l_gen`var' = l.`var'
				loc laggedVars `laggedVars' l_gen`var'  
			}
			foreach local in free state proxy control{
				loc `local'num: word count ``local''
				foreach var of local `local'{
					loc lag`local'Vars `lag`local'Vars' l_gen`var'
				}
			}
			
			loc instrumentVars `state' `lagfreeVars' `control' `lproxyGO'
			
			/// OP LP polyvars
			loc polyvars `state' `proxy'
			/// ACF requires free variables to be among the polynomial
			if !mi("`acf'"){
				loc polyvars `free' `polyvars' 
			}
			loc varnum: word count `polyvars'
			loc controlnum: word count `control'
			loc tolagnum: word count `toLagVars'
			
* WFDOC: Polinomial proxy membentuk semua monomial unik k^a p^b dengan derajat total 1 sampai d; regresi memasukkan konstanta. ACF menambahkan tenaga kerja ke basis, tanpa mengulang kolom linear.
			// poly-th degree polynomial
			loc n = 1
			foreach x of local polyvars{
				qui gen double var_`n' = `x'
				loc interactionvars `interactionvars' var_`n'
				loc ++n
			}

			forv i=1/`varnum'{
				forv j=`i'/`varnum'{
					qui gen double var_`i'_`j' = var_`i'*var_`j'
					loc interactionvars `interactionvars' var_`i'_`j'
					if `poly' > 2{
						forv z=`j'/`varnum'{
							qui gen double var_`i'_`j'_`z' = var_`i'*var_`j'*var_`z'
							loc interactionvars `interactionvars' var_`i'_`j'_`z'
							if `poly' > 3{
								forv g = `z'/`varnum'{
									qui gen double var_`i'_`j'_`z'_`g' = var_`i'*var_`j'*var_`z'*var_`g'
									loc interactionvars `interactionvars' var_`i'_`j'_`z'_`g'
									if `poly' > 4{
										forv v = `g'/`varnum'{
											qui gen double var_`i'_`j'_`z'_`g'_`v' = var_`i'*var_`j'*var_`z'*var_`g'*var_`v'
											loc interactionvars `interactionvars' var_`i'_`j'_`z'_`g'_`v'
											if `poly' > 5{
												forv s = `v'/`varnum'{
													qui gen double var_`i'_`j'_`z'_`g'_`v'_`s' = var_`i'*var_`j'*var_`z'*var_`g'*var_`v'*var_`s'
													loc interactionvars `interactionvars' var_`i'_`j'_`z'_`g'_`v'_`s'
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if /*("`method'" == "wrdg" | "`method'" == "mr")*/ inlist("`method'","wrdg","mr","rob"){
				/// generate GMM fit - for each state and free variables need to initiate the GMM
				foreach element in `free' `state' `proxyGO'{
					local gmmfit `gmmfit'-{`element'}*`element'
				}
				/// generate lag interactionvars
				foreach var of local interactionvars{
					cap gen double l_gen`var' = l.`var'
					loc lagInteractionvars `lagInteractionvars' l_gen`var'
				}
				if !mi("`translog'"){ /* generate the interactions + the square of free and state vars */
					foreach fvar in `free'{
						loc ++colnum
						qui gen double translog_var`fvar' = `fvar' * `fvar' /* generate squared free */
						loc translogFit `translogFit'-{translog_var`fvar'}*translog_var`fvar'
						loc transNames `transNames' "`fvar'*`fvar'"
						foreach svar in `state'{
							qui gen double translog_var`fvar'`svar' = `fvar' * `svar'
							cap gen double translog_var`svar'`svar' = `svar' * `svar'
							loc translogFit `translogFit'-{translog_var`fvar'`svar'}*translog_var`fvar'`svar'
							loc transNames `transNames' "`fvar'*`svar'"
							qui gen double translog_inst`fvar'`svar' = l_gen`fvar' * `svar'
							loc ++colnum
						}
					}
					loc translogVars translog_var* /* list of interaction + squares variables */
					loc translogInst translog_inst* /* list of interaction between lagged free and state var */
					loc wrdg_transVars1 "-{xp: translog_var*}"
					loc wrdg_transVars2 "-{xq: translog_var*}"
					di "`translogFit'"
					di "`translogVars'"
				}
				if "`method'" == "wrdg"{ /* WRDG */
					/*
					`vv' gmm (eq1: `depvar' `gmmfit' /*`translogFit'*/ -{xc: `interactionvars'} /*`wrdg_transVars1'*/ `wrdg_contr1' - {a0}) /* y - a0 - witB - xitJ - citL
						*/ (eq2: `depvar' `gmmfit' /*`translogFit'*/ -{xd: `lagInteractionvars'} /*`wrdg_transVars2'*/ `wrdg_contr2' - {a0} - {e0}), /* y - e0 - witB - xitJ - p(cit-1L) - ... - pg(cit-1L)^g
						*/ instruments(eq1: `free' `interactionvars' `control' `translogVars' `overidentification') /* Zit1 = (1,wit,xit,c0it)
						*/ instruments(eq2: `state' `lagfreeVars' `lagInteractionvars' `control' `translogVars' /*`translogInst'*/) /* Zit2 = (1,xit,wit-1,cit-1)
						*/ /*winitial(identity, independent) onestep*/ winitial(unadjusted, independent) nocommonesample technique(`optimizer') conv_maxiter(`maxiter') `conv_nrtol' `init_gmm'
					*/
					/*
					mat W = e(W)
					mat S = e(S)
					mat V = e(V)
					mat mV = e(V_modelbased)
					noi di "final weight matrix"
					mat list W
					noi di "S estimator is"
					mat list S
					noi di "var-covar matrix"
					mat list V
					di "modelbased varcovar matrix"
					mat list mV
					*/
* WFDOC: WRDG memakai sistem dua persamaan r1=y-beta_L*l-beta_K*k-a0-B_d(k_t,p_t)'theta dan r2=y-beta_L*l-beta_K*k-a0-e0-B_d(k_t-1,p_t-1)'theta dengan theta bersama.
* WFDOC: Instrumen primer adalah Z1=[1,l_t,B_d(k_t,p_t)] dan Z2=[1,k_t,l_t-1,B_d(k_t-1,p_t-1)]; kode wrapper tidak menambah instrumen atau kontrol opsional.
					if !mi("`overidentification'") | !mi("`gmm'") { // in case of overidentification, or in case the user specifies a preference for GMM, estimate a system GMM model, else go with the linear IV model
						if !mi("`overidentification'"){
							loc overidentification `lagfreeVars' `lagInteractionvars'
						}
						loc eq1counter = 0
                        loc g1_derivs ""
						foreach var of varlist `interactionvars'{
							loc ++eq1counter
							loc eq1vars `eq1vars' -{xb`eq1counter'}*`var'
                            loc g1_derivs `g1_derivs' derivative(eq1/xb`eq1counter' = -`var')
						}
						loc eq2counter = 0
						foreach var of varlist `lagInteractionvars'{
							loc ++eq2counter
							loc eq2vars `eq2vars' -{xb`eq2counter'}*`var'
                            loc g1_derivs `g1_derivs' derivative(eq2/xb`eq2counter' = -`var')
						}
						foreach element in `free' `state'{
                            loc g1_derivs `g1_derivs' derivative(eq1/`element' = -`element') derivative(eq2/`element' = -`element')
                        }
                        loc g1_derivs `g1_derivs' derivative(eq1/a0 = -1) derivative(eq2/a0 = -1) derivative(eq2/e0 = -1)
                        `vv' qui gmm (eq1: `depvar' `gmmfit' /*`translogFit'*/ `eq1vars' /*-{xc: `interactionvars'} `wrdg_transVars1'*/ `wrdg_contr1' - {a0}) /* y - a0 - witB - xitJ - citL
							*/ (eq2: `depvar' `gmmfit' /*`translogFit'*/ `eq2vars' /*-{xd: `lagInteractionvars'} `wrdg_transVars2'*/ `wrdg_contr2' - {a0} -{e0}), /* y - e0 - witB - xitJ - p(cit-1L) - ... - pg(cit-1L)^g
							*/ instruments(eq1: `free' /*`lagfreeVars'*/ `interactionvars' `control' `translogVars' /*`lagInteractionvars'*/ `overidentification') /* Zit1 = (1,wit,xit,c0it,cit-1)
							*/ instruments(eq2: `state' `lagfreeVars' `lagInteractionvars' `control' `translogVars' /*`translogInst'*/) /* Zit2 = (1,xit,wit-1,cit-1)
							*/ /*winitial(identity, independent) onestep*/ winitial(unadjusted, independent) /*nocommonesample*/ technique(`optimizer') conv_maxiter(`maxiter') `conv_nrtol' `init_gmm' `g1_derivs'
                        matrix G1_POINT_DIAG=(e(converged),e(Q),e(ic),e(N),e(n_moments),e(rank))
                        matrix G1_POINT_W=e(W)
                        matrix G1_POINT_S=e(S)
                        matrix G1_POINT_FULL_B=e(b)
                        matrix G1_POINT_V=e(V)

						/// save locals for Hanses's J and p-value
						qui estat overid
						loc hans_j: di %3.2f `r(J)'
						loc hans_p: di %3.2f `r(J_p)'
					}
					else{ /* WRDG - plain */
						tempfile wrdg
						qui save `wrdg'
							qui reg `depvar' `state' `proxyGO' `interactionvars' `free' `lagfreeVars' `control' // just to take the number of observations used in the estimation
							loc realObs = `e(N)'
							qui expand 2, gen(cons2) // double the dataset in order to stack dependent and regressors
							foreach var of local interactionvars{
								qui replace `var' = l_gen`var' if cons2 == 1 // change interactionvars to lagged values
							}
							qui ivregress gmm `depvar' `state' `proxyGO' `interactionvars' `control' (`free' = `lagfreeVars') cons2, wmatrix(unadjusted) c // run the IV regression 
							/// save locals for Hanses's J and its p-value
							loc hans_j: di %3.2f `e(J)'
							mat cV = colsof(e(V)) // find the number of instruments
							scalar cV = cV[1,1]
							loc jdf = cV - `e(rank)' + 1
							loc hans_p: di %3.2f chi2tail(`jdf', `hans_j') // this is the chi2 p-value of Hansen statistics
						qui use `wrdg', clear
						eret loc N `realObs' // post the real number of obseravtions used in estimation
					}
				}
				else if "`method'" == "mr"{ /* MrEst */
					if !mi("`overidentification'"){ // interactions are valid instruments, too
						loc overidentification  `lagInteractionvars' 
					}
					/// god forgive me: in order to overcome the difference equation in system GMM we launch both equations in level and take the initial weighting matrix
					loc instnum = (`freenum' + `statenum')
					forv i = 1/`instnum'{
						loc intVars `intVars' var_`i'
					}
					loc interinstr: list local interactionvars - intVars
					qui gmm (`depvar' `gmmfit' - {xh: `interactionvars'} `wrdg_contr1' - {a0}), quickd instruments(1: `interinstr') /*
						*/ xtinstruments(`free' `state', l(0/`lags')) winitial(xt L) onestep conv_maxiter(1)
					qui mat W1 = e(W)
					qui gmm (`depvar' `gmmfit' - {xj: `lagInteractionvars'} `wrdg_contr2' - {a0} - {e0}), quickd /*
						*/ instruments(`state' `lagInteractionvars') xtinstruments(`free' `state', l(2/`lags'))/*
						*/ /*xtinstruments(`state', l(0/`lags'))*/ winitial(xt L) onestep conv_maxiter(1)
					qui mat W2 = e(W)
					mata W_hat =  st_matrix("W1"),J(rows(st_matrix("W1")),cols(st_matrix("W2")),0) \ J(rows(st_matrix("W2")),cols(st_matrix("W1")),0), st_matrix("W2")
					mata st_matrix("W_hat", W_hat)
					/* generate the model for both equations - same parameter for c_{i,t} and c_{i,t-1} in WRDG terms */
					loc eq1counter = 0
                        loc g1_derivs ""
					foreach var of varlist `interactionvars' `control'{
						loc ++eq1counter
						loc eq1vars `eq1vars' "-{xb`eq1counter'}*`var'"
					}
					loc eq2counter = 0
					foreach var of varlist `lagInteractionvars' `control'{
						loc ++eq2counter
						loc eq2vars `eq2vars' "-{xb`eq2counter'}*`var'"
					}
					/// launch the gmm with the winitial built above
					`vv' qui gmm (1: `depvar' `gmmfit' `eq1vars' /*`wrdg_contr1'*/ - {a0}) /* y - a0 - witB - xitJ - citL
						*/ (2: `depvar' `gmmfit' `eq2vars' /*`wrdg_contr2'*/ - {a0} - {e0}),/* y - e0 - witB - xitJ - p(cit-1L) - ... - pg(cit-1L)^g, where p = g = 1
						*/ instruments(1: `interinstr' `overidentification' `control') xtinstruments(1: `free' `state', l(0/`lags')) /*  
						*/ xtinstruments(2: `free' `state', l(2/`lags')) instruments(2: `state' `lagInteractionvars' `control') /* 
						*/ onestep winitial("W_hat") nocommonesample quickd technique(`optimizer') conv_maxiter(`maxiter') `conv_nrtol' `init_gmm'
					/// save locals for Hanses's J and p-value
					qui estat overid
					loc hans_j: di %3.2f `r(J)'
					loc hans_p: di %3.2f `r(J_p)'
				}
				else{ /* Robinson / ACF */
					*qui gmm (`depvar' `gmmfit' - {xb: `lagInteractionvars'} - {a0}), instruments(`state' `lagfreeVars' `lagInteractionvars') onestep vce(cluster `id')
					*ivreg2 `depvar' `state' `proxyGO' `lagInteractionvars' ( `free' = `lagfreeVars' `overidentification'), gmm2s cluster(`id') /* this is working! */ 
					*ivregress gmm `depvar' `state' `proxyGO' `control' `lagInteractionvars' ( `free' = `lagfreeVars' `overidentification'), vce(cluster `id') /* this is working! */ 
					qui ivregress gmm `depvar' `state' `proxyGO' `control' `lagInteractionvars' (`free' = `lagfreeVars'), vce(cluster `id') /* this is working! */
					/// save locals for Hanses's J and its p-value
					loc hans_j: di %3.2f `e(J)'
					mat cV = colsof(e(V)) // find the number of instruments
					scalar cV = cV[1,1]
					loc jdf = cV - `e(rank)' + 1
					loc hans_p: di %3.2f chi2tail(`jdf', `hans_j') // this is the chi2 p-value of Hansen statistics
				}
				/// save elements for result posting
				loc nObs = `e(N)'
				loc numInstr1: word count `e(inst_1)'
				loc numInstr2: word count `e(inst_2)'
				mat `__b' = e(b)
				mat `__b' = `__b'[1...,1..`colnum']
				mat `__V' = e(V)
				mat `__V' = `__V'[1..`colnum',1..`colnum']
				/// save locals for Hanses's J and its p-value
				loc hans_j: di %3.2f `e(J)'
				mat cV = colsof(e(V)) // find the number of instruments
				scalar cV = cV[1,1]
				loc jdf = cV - `e(rank)' + 1
				loc hans_p: di %3.2f chi2tail(`jdf', `hans_j') // this is the chi2 p-value of Hansen statistics
				continue, break
			}
			else{ /* if it's not WRDG or MrEst */
                if "`method'"=="op" {
                    qui gen double Pr_hat = `opprob'
                    assert inrange(Pr_hat,0,1) if !missing(Pr_hat)
                }
                else qui gen double Pr_hat = .
				/// in case of ACF we don't want free variables to appear twice in the regression		
				if !mi("`acf'"){
					forv i = 1/`freenum'{
						loc freeVars `freeVars' var_`i'
					}
					loc interactionvars: list local interactionvars - freeVars
					/// generate the needed variables for translog: a local with all power of 2 + interactions and instruments - lag of free/proxy interacted with state
					if !mi("`translog'"){
						loc transNum: word count `transVars'
						forv i=1/`transNum'{
							forv j=`i'/`transNum'{
								loc interactionTransVars `interactionTransVars' var_`i'_`j'
								qui gen double lagTrans_`i'_`j' = l.var_`i'_`j'
								loc lagInteractionTransVars `lagInteractionTransVars' lagTrans_`i'_`j'
							}
						}
						foreach fvar in `free' `proxyGO'{
							tempvar d`fvar'
							qui gen double `d`fvar'' = `fvar'^2
							qui gen double lagInstr`fvar' = l.`d`fvar''
							loc instrumentTransVars `instrumentTransVars' lagInstr`fvar'
							foreach svar in `state'{
								qui gen double instr_`fvar'`svar' = lagInstr`fvar'*`svar'
								loc instrumentTransVars `instrumentTransVars' instr_`fvar'`svar'
							}
						}
						foreach svar in `state'{
							tempvar d`svar'
							qui gen double `d`svar'' = `svar'^2
							qui gen double lagInstr`svar' = l.`d`svar''
							loc instrumentTransVars `instrumentTransVars' lagInstr`svar'
						}
						if `b' == 1{
								loc colnum: word count `free' `state' `control' `proxyGO' `interactionTransVars'
								mat `__b' = J(`reps',`colnum',.)
						}
					}
				}
				loc regvars `free' `control' `interactionvars'
				loc firstRegNum: word count `regvars'
				loc regNum: word count `free' `state' `control' `proxyGO' `transVars'
				
* WFDOC: Tahap pertama OP/LP meregresikan y pada l dan B_d(k,p), lalu mengurangi beta_L*l dari nilai prediksi; tahap pertama ACF memakai seluruh monomial l,k,p dan mempertahankan fit penuh phi.
				/// first stage
				qui _xt, trequired
				qui reg `depvar' `regvars'
				/// generating "freeFit" as the fit of free variables to be subtracted to Y
				tempvar freeFit
				qui gen double `freeFit' = 0 
				foreach var in `free'{
					scalar b_`var' = _b[`var']
					qui replace `freeFit' = `freeFit' + (b_`var'*`var')
				}
				mat `firstb' = e(b)
				mat `robV' = e(V)
				qui predict double phihat if e(sample), xb
				qui gen double phihat_lag = l.phihat
				
				/// retrieve starting points through an OLS estimation --> first round only, not during bootstrap
				if `b' == 1{
					qui reg `depvar' `toLagVars' `interactionTransVars' if `touse' == 1
					if !mi("`init'"){
						mat ols_s = `init' // THIS PART IS JUST A TRYOUT IN ORDER TO MAKE THE COMMAND WORK FOR OUR PURPOSES
					}
					else{
						mat tmp = e(b)
						mata: st_matrix("ols_s",st_matrix("tmp"):+ rnormal(1,1,0,.01)) // we add some "noise" to OLS results in order not to block the optimizer
						*mat ols_s = e(b)
					}
					/// save the first stage results 
					if !mi("`fsresiduals'"){
						tempfile fsres
						tempvar FSfit
						mat score `FSfit' = `firstb'
						qui gen double `fsresiduals' = `depvar' - `FSfit'
						qui save `fsres'
					}
				}
				qui gen double res = 0
* WFDOC: Pada LP, omega=phi-beta_K*k diproyeksikan ke [1,omega_lag,omega_lag^2,omega_lag^3] dan beta_K meminimalkan jumlah kuadrat error produksi; LP primer tidak mengoreksi attrition.
* WFDOC: OP memakai objective yang sama tetapi menambah cubic probabilitas exit terprediksi dan interaksinya dengan omega_lag; probabilitas berasal dari risk/exit terautentikasi, dan gagal fit tidak berubah menjadi OP tanpa koreksi.
				if mi("`acf'"){ /* OP and LP (non-corrected) second stage */ 
					/// here we generate a tempvar with the fitted value of all the free variables 
					qui replace phihat = phihat - `freeFit'
					qui replace res = `depvar' - `freeFit'
					qui replace phihat_lag = l.phihat
					mat init = ols_s[1...,(`freenum'+1)..`regNum']'
					loc toLagVars `state' `control' `proxyGO'
					loc laggedVars: list local laggedVars - lagfreeVars
					loc instrumentVars `state' `control' `lproxyGO'
					/// here we launch the mata routine for OP or LP 
					foreach var of varlist `toLagVars' `laggedVars' /*`lagfreeVars'*/ phihat_lag phihat{
						qui drop if mi(`var')
					}
					if "`method'"=="op" assert !missing(Pr_hat)
					/// the routine cannot fail the first estimation - otherwise it would fail with the point estimates. We capture the boot repetitions
					if `b' == 1{
						qui mata: g1p_opt_mata(st_matrix("init"),&g1p_foplp(),"`optimizer'","phihat","phihat_lag",/*
							*/"`toLagVars'","`laggedVars'","`touse'",`maxiter',`tolerance',"`evaluator'","Pr_hat","res","`instrumentVars'","`endogenous'")
					}
					else{
						cap qui mata: g1p_opt_mata(st_matrix("init"),&g1p_foplp(),"`optimizer'","phihat","phihat_lag",/*
							*/"`toLagVars'","`laggedVars'","`touse'",`maxiter',`tolerance',"`evaluator'","Pr_hat","res","`instrumentVars'","`endogenous'")
						if _rc != 0{
							noi di "x" _continue
							loc laggedVars ""
							loc lagfreeVars ""
							loc lagstateVars ""
							loc interactionvars ""
							loc lagcontrolVars ""
							continue
						}
					}
					*mat `__b'[`b',1] = `firstb'[1...,1..(`freenum'+`controlnum')],r(betas) 
					mat `__b'[`b',1] = `firstb'[1...,1..(`freenum')],r(betas) 
				}
* WFDOC: ACF membentuk omega=phi-beta_L*l-beta_K*k, mengeluarkan inovasi xi setelah proyeksi kubik omega_lag, lalu meminimalkan (Z'xi)'W(Z'xi), Z=[lag(l),k], W=invsym(Z'Z)/N.
				else{ /* ACF second stage */ 
					if !mi("`overidentification'"){ // lag intereactions are valid instruments for the first equation, too
						loc overidentification `lagInteractionvars'
					}
					loc toLagVars `free' `state' `control' `proxyGO' `interactionTransVars'
					loc laggedVars `lagfreeVars' `lagstateVars' `lagcontrolVars' `lproxyGO' `lagInteractionTransVars'
					loc instrumentVars `lagfreeVars' `state' `control' `lproxyGO' `instrumentTransVars' `overidentification'
					/// here we launch the mata routine for ACF
					foreach var of varlist `laggedVars' `lagfreeVars' phihat_lag{
						qui drop if mi(`var')
					}
					loc betaNum: word count `free' `state' `proxyGO' `control' `interactionTransVars'
					mat init = ols_s[1...,1..(`betaNum')]'
					if `b' == 1{
						qui mata: g1p_opt_mata(st_matrix("init"),&g1p_facf(),"`optimizer'","phihat","phihat_lag",/*
							*/ "`toLagVars'","`laggedVars'","`touse'",`maxiter',`tolerance',"`evaluator'","Pr_hat","res","`instrumentVars'","`endogenous'")
					}
					else{
						cap qui mata: g1p_opt_mata(st_matrix("init"),&g1p_facf(),"`optimizer'","phihat","phihat_lag",/*
							*/ "`toLagVars'","`laggedVars'","`touse'",`maxiter',`tolerance',"`evaluator'","Pr_hat","res","`instrumentVars'","`endogenous'")
						if _rc != 0{
							noi di "x" _continue
							
							loc lagInteractionTransVars ""
							loc interactionTransVars ""
							loc instrumentTransVars ""
							
							loc laggedVars ""
							loc lagfreeVars ""
							loc lagstateVars ""
							loc interactionvars ""
							loc lagcontrolVars ""
							continue
						}
					}
					mat `__b'[`b',1] = r(betas)
				}
			}
			
			loc lagInteractionTransVars ""
			loc transNames `interactionTransVars'
			loc interactionTransVars ""
			loc instrumentTransVars ""
			
			loc laggedVars ""
			loc lagfreeVars ""
			loc lagstateVars ""
			loc interactionvars ""
			loc lagcontrolVars ""
		}
* WFDOC: Paket vendor semula dapat mengulang fit dan melaporkan inferensi internal; cabang G1 menyimpan satu baris koefisien saja, sementara bootstrap penuh dan kovariansnya ditangani program eksternal.
        * Single fit: there is no internal bootstrap covariance or Wald test.
        mat `__b' = `__b'[1,1...]

	restore 
	
* WFDOC: Jika fsresiduals diminta, merge 1:1 memakai id dan t untuk menempelkan residu tahap pertama ke baris sumber; caller tetap menilai kecocokan kunci, dan fitur ini bukan prediksi omega.
	/// merge the first stage residuals
	if !mi("`fsresiduals'"){
		qui merge 1:1 `id' `t' using `fsres', nogen keepusing(`fsresiduals')
	}
	
    mat coleq `__b' = ""
    mat colnames `__b' = `free' `state' `control' `proxyGO' `transNames'
    eret clear
    eret post `__b', e(`touse') obs(`nObs')
    loc waldT "."
    loc waldP "."

	if !mi("`acf'"){
		loc correction "ACF corrected"
	}
	if !mi("`fsresiduals'"){
		eret loc FSres "`fsresiduals'"
	}
	
* WFDOC: e() menyimpan nama metode, variabel, model, optimizer, domain dan diagnostik; hasil point fit tidak menyediakan covariance yang dapat dipakai sebagai standar error.
	eret loc cmd "g1_prodest_point"
	eret loc depvar "`depvar'"
	eret loc free "`free'"
	eret loc state "`state'"
	eret loc proxy "`proxy'"
	eret loc controls "`control'"
	eret loc endogenous "`endogenous'"
	eret loc method "`strMethod'"
	eret loc model "`model'"
	eret loc technique "`optimizer'"
	eret loc idvar "`id'"
	eret loc timevar "`t'"
	eret loc correction "`correction'"
	eret loc predict "G1_NO_AUTOMATIC_LATENT_PREDICTION"
	eret loc PFtype "`PFtype'"
	eret loc waldT "`waldT'"
	eret loc waldP "`waldP'"
	eret loc gmm "`gmm'"
	
	eret scalar N_g = `nGroups'
	eret scalar tmin = `minGroup'
	eret scalar tmean = `meanGroup'
	eret scalar tmax = `maxGroup'
	
	di _n _n
	di as text "`method' productivity estimator `gmm'" _continue
	di _col(49) "`PFtype' PF"
	di as text "`correction'"
	if ("`model'" == "grossoutput") {
		di as text "Dependent variable: revenue" _continue
	}
	else {
		di as text "Dependent variable: value added" _continue
	}
	di _col(49) as text "Number of obs      = " as result %9.0f `nObs'
	di as text "Group variable (id): `id'" _continue
	di _col(49) as text "Number of groups   = " as result %9.0f `nGroups'
	di as text "Time variable (t): `t'" 
	di _col(49) as text "Obs per group: min = " as result %9.0f `minGroup'
	di _col(49) as text "               avg = " as result %9.1f `meanGroup'
	di _col(49) as text "               max = " as result %9.0f `maxGroup'
	di
	mat list e(b)
	di "Wald test on Constant returns to scale: Chi2 = `e(waldT)'"
	di "					      p = (`e(waldP)')"
	if ("`method'" == "wrdg" | "`method'" == "mr") & !mi("`overidentification'"){
		eret loc hans_j "`hans_j'"
		eret loc hans_p "`hans_p'"
		di "Hansen's J statistic for overidentification = `hans_j'"
		di "                                          p = (`hans_p')"
	}
	else if !mi("`translog'"){
		di as text "Estimated parameters displayed. To see estimated input elasticities, type{stata predict, parameters: predict, parameters}"
	}
end program


//*---------------------------------------------------------------------*/

/// defining mata routines for optimization
capture mata mata drop g1p_opt_mata() 
capture mata mata drop g1p_facf()
capture mata mata drop g1_cf_mom()
capture mata mata drop g1p_foplp() 


*version 7
mata:
// WFDOC: Helper ACF mengembalikan momen sampel Z'xi/N untuk beta; Jacobian beda hingga di bawahnya adalah diagnostik rank lokal, bukan kovarians atau uji inferensial.
    real colvector g1_cf_mom(real rowvector b, real matrix X, real matrix lX,
        real colvector PHI, real colvector LPHI, real matrix Z) {
        real colvector om, lom, xi
        real matrix H
        om=PHI-X*b'; lom=LPHI-lX*b'
        H=(J(rows(om),1,1),lom,lom:^2,lom:^3)
        xi=om-H*qrsolve(H,om)
        return(Z'xi/rows(Z))
    }

/*---------------------------------------------------------------------*/

// WFDOC: Untuk OP/LP, omega=phi-X*beta dan omega_lag=phi_lag-X_lag*beta; regresi bantu H memproyeksikan produktivitas pada polinomial lag, lalu objective adalah jumlah kuadrat error produksi.
	void g1p_foplp(todo,betas,X,lX,PHI,LPHI,RES,Z,PR_HAT,ENDO,crit,g,H)
	{
		OMEGA = PHI-X*betas'
		OMEGA_lag = LPHI-lX*betas'
		OMEGA_lag2 = OMEGA_lag:*OMEGA_lag
		OMEGA_lag3 = OMEGA_lag2:*OMEGA_lag
		/* IF clause in order to see whether we have to use the "exit" variable */
		if (!missing(PR_HAT)){
			PR_HAT2 = PR_HAT:*PR_HAT
			PR_HAT3 = PR_HAT2:*PR_HAT
			OMEGA_lag_pol = (J(rows(PHI),1,1),OMEGA_lag,OMEGA_lag2,OMEGA_lag3,PR_HAT,PR_HAT2,PR_HAT3,PR_HAT:*OMEGA_lag,PR_HAT2:*OMEGA_lag,PR_HAT:*OMEGA_lag2,ENDO)
		}
		else{
			OMEGA_lag_pol = (J(rows(PHI),1,1),OMEGA_lag,OMEGA_lag2,OMEGA_lag3,ENDO)
		}
		g_b = qrsolve(OMEGA_lag_pol,OMEGA)
		XI = RES-X*betas'-OMEGA_lag_pol*g_b
		crit = (XI)'*(XI)
	}
	
/*---------------------------------------------------------------------*/
	
// WFDOC: Untuk ACF, bobot W=invsym(Z'Z)/N; setelah proyeksi omega pada polinomial lag, XI=omega-H*g dan objective menghukum momen Z'XI sesuai sumber.
	void g1p_facf(todo,betas,X,lX,PHI,LPHI,RES,Z,PR_HAT,ENDO,crit,g,H)
	{
		W = invsym(Z'Z)/(rows(Z))
		OMEGA = PHI-X*betas'
		OMEGA_lag = LPHI-lX*betas'
		OMEGA_lag2 = OMEGA_lag:*OMEGA_lag
		OMEGA_lag3 = OMEGA_lag2:*OMEGA_lag
		/* IF clause in order to see whether we have to use the "exit" variable */
		if (!missing(PR_HAT)){
			PR_HAT2 = PR_HAT:*PR_HAT
			PR_HAT3 = PR_HAT2:*PR_HAT
			OMEGA_lag_pol = (J(rows(PHI),1,1),OMEGA_lag,OMEGA_lag2,OMEGA_lag3,PR_HAT,PR_HAT2,PR_HAT3,PR_HAT:*OMEGA_lag,PR_HAT2:*OMEGA_lag,PR_HAT:*OMEGA_lag2,ENDO)
		}
		else{
			OMEGA_lag_pol = (J(rows(PHI),1,1),OMEGA_lag,OMEGA_lag2,OMEGA_lag3,ENDO)
		}
		g_b = qrsolve(OMEGA_lag_pol,OMEGA)
		XI = OMEGA-OMEGA_lag_pol*g_b
		crit = (Z'XI)'*W*(Z'XI)
	}
	
/*---------------------------------------------------------------------*/
	
// WFDOC: Optimizer menerima hanya baris touse dengan beta awal eksplisit; hasil menyimpan convergence, objective, iterasi, ukuran sampel, rank instrumen/transisi, kondisi matriks dan Jacobian ACF.
	void g1p_opt_mata(init, f, opt, phi, lphi, tolag, lagged, touse, maxiter, tol, eval, | Pr_hat, res, instr, endogenous)
	{
		st_view(RES=.,.,st_tsrevar(tokens(res)), touse)
		st_view(PHI=.,.,st_tsrevar(tokens(phi)), touse)
		st_view(LPHI=.,.,st_tsrevar(tokens(lphi)), touse)
		st_view(Z=.,.,st_tsrevar(tokens(instr)), touse)
		st_view(X=.,.,st_tsrevar(tokens(tolag)), touse)
		st_view(lX=.,.,st_tsrevar(tokens(lagged)), touse)
		st_view(PR_HAT=.,.,st_tsrevar(tokens(Pr_hat)), touse)
		st_view(ENDO=.,.,st_tsrevar(tokens(endogenous)), touse) 
		S = optimize_init()
		optimize_init_argument(S, 1, X)
		optimize_init_argument(S, 2, lX)
		optimize_init_argument(S, 3, PHI)
		optimize_init_argument(S, 4, LPHI)
		optimize_init_argument(S, 5, RES)
		optimize_init_argument(S, 6, Z)
		optimize_init_argument(S, 7, PR_HAT)
		optimize_init_argument(S, 8, ENDO)
		optimize_init_evaluator(S, f)
		/*optimize_init_evaluatortype(S, "d0")*/
		optimize_init_evaluatortype(S, eval)
		optimize_init_conv_maxiter(S, maxiter)
		optimize_init_conv_nrtol(S, tol)
		/*optimize_init_evaluatortype(S, "gf0")*/
		optimize_init_technique(S, opt)
		optimize_init_nmsimplexdeltas(S, 0.00001)
		optimize_init_which(S,"min")
		optimize_init_params(S,init')
		p = optimize(S)
        st_matrix("G1_POINT_DIAG", (optimize_result_converged(S), optimize_result_value(S), optimize_result_iterations(S), rows(X), cols(Z), rank(Z)))
        st_matrix("G1_POINT_GRADIENT", optimize_result_gradient(S))
        G1_lom=LPHI-lX*p'
        if (!missing(PR_HAT)) G1_transition=(J(rows(X),1,1),G1_lom,G1_lom:^2,G1_lom:^3,PR_HAT,PR_HAT:^2,PR_HAT:^3,PR_HAT:*G1_lom,(PR_HAT:^2):*G1_lom,PR_HAT:*(G1_lom:^2),ENDO)
        else G1_transition=(J(rows(X),1,1),G1_lom,G1_lom:^2,G1_lom:^3,ENDO)
        st_matrix("G1_TRANSITION_DIAG",(rows(G1_transition),cols(G1_transition),rank(G1_transition),cond(G1_transition)))

        if (cols(X)==2) {
            G1_mom = g1_cf_mom(p,X,lX,PHI,LPHI,Z)
            G1_D = J(rows(G1_mom),cols(X),.)
            for (G1_j=1;G1_j<=cols(X);G1_j++) {
                G1_plus=p; G1_minus=p
                G1_plus[G1_j]=G1_plus[G1_j]+1e-5
                G1_minus[G1_j]=G1_minus[G1_j]-1e-5
                G1_D[,G1_j]=(g1_cf_mom(G1_plus,X,lX,PHI,LPHI,Z)-g1_cf_mom(G1_minus,X,lX,PHI,LPHI,Z))/2e-5
            }
            st_matrix("G1_POINT_MOMENTS",G1_mom')
            st_matrix("G1_POINT_JACOBIAN",G1_D)
        }
		st_matrix("r(betas)", p)
		
		/* tryout to find Newey-type Cov estimator 
		st_matrix("r(gradient)", optimize_result_gradient(S))
		st_matrix("r(score)", optimize_result_scores(S))
		Hl = optimize_result_gradient(S)
		V = optimize_result_V(S)
		Vhh = invsym(Hl)*V*invsym(Hl)'
		st_matrix("r(Vhh)", Vhh)*/
	}
	
/*---------------------------------------------------------------------*/
	
end 

/*---------------------------------------------------------------------*/
/// SAVE MATA LIBRARIES ///
*global matadir "C:\Users\gabriele\Dropbox (Personale)\ACF_routine\dofile"
*cd "${matadir}"
*mata: mata mlib create l_prodest, replace
*mata: mata mlib add l_prodest *()



