#include "inkey.ch"
#include "box.ch"
#include "achoice.ch"
cls
lei := { "bay","Cay","Eay" }
cur_el  := 1
rel_row := 1
achoice( 00,00,02,02,lei,.F.,"i_func", cur_el, rel_row )
cls
return nil

function i_func
Parameters amod, sel
Private r
if amod = AC_NOITEM
   inkey(0)
   r = AC_ABORT
else
   r = AC_CONT
endif
return r
