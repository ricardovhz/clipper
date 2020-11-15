#include "inkey.ch"
local cVar1 := space(10), nVar := 2550,;
      cVar2 := space(10)
clear
@ 09,10 get cVar1
@ 10,10 get cVar2 WHEN pcklist()
@ 11,10 get nVar
READ

FUNCTION pcklist
   STATIC aList := { "First","Second","Three","Four" }
   LOCAL cScreen, nChoice, nKey := LASTKEY()
   cScreen := SaveScreen( 10,10,14,20 )
   @ 10,10 to 14,20 DOUBLE
   IF (nChoice := ACHOICE( 11,11,13,19,aList )) != 0
      KEYBOARD CHR( K_CTRL_Y ) + aList[nChoice] + CHR( nKey )
   ENDIF
   RESTSCREEN( 10,10,14,20, cScreen )
   RETURN .T.
