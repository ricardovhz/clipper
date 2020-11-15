Function Tecad( Nomarq )
#include "Inkey.ch"
set century on
use ( Nomarq ) new
cls
cnome := space(20)
cidad := ctod("  /  /    ")
@ 00,00 say "Digite o seu nome "
@ 00,18 get cnome picture "@!" valid checanome( cnome )
read
@ 00,18 get cnome picture "@!"
@ 02,00 get cidad picture "@E"
read
inkey(0)
cls
return nil

***********************
function checanome( x )
***********************
borda := "’Õ∏≥æÕ‘≥ "
declare Contar[ Fcount() ]
Afields( Contar )
If !empty( x ) .and. dbseek( x )
   Return .T.
Endif
Setcolor("w+/bg,w+/b")
@ 13,00,20,79 box borda
dbedit( 14,01,19,78,Contar )
keyboard &(Contar[ 1 ])
setcolor("w/n,n/w")
Return .T.
