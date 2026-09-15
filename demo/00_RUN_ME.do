args owner_folder
if `"`owner_folder'"'=="" local owner_folder `"`c(pwd)'"'
do "`owner_folder'/00_MASTER.do" "`owner_folder'"
