#include "inkey.ch"
clear
nvar := space( 10 )
cvar := space( 10 )
@ 09,10 get nvar picture "!"
@ 11,10 get cvar when ricd()
read
return

function ricd()
cscreen := savescreen(10,10,14,20)
nkey := lastkey()
alist := { "Um","Dois","Tres","Quatro" }
@ 10,10 to 14,20 double
if (nchoice := achoice( 11,11,13,19, alist )) != 0
   keyboard alist[nchoice]
endif
restscreen(10,10,14,20,cscreen)
return .T.
