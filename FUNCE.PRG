BORDA1 := "…Õª∫ºÕ»∫"

SET CURSOR OFF
SETCOLOR( "W+/R,W/N,R,W/N" )
CLS
@ 00,00,24,79 BOX BORDA1
ESCLEN( 13,25,"Ricardo Vanhoz Ribeiro",0.025 )
INKEY(0)
SETCOLOR( "W/N,W/N,N,W/N")
CLS
RETURN NIL

********************************************
STATIC FUNCTION ESCLEN( LI,CI,TEXT,SEC )
********************************************
PRIVATE NCT
FOR NCT = 1 TO LEN( TEXT )
   @ LI,CI-1+NCT SAY SUBS( TEXT,NCT,1 )
   INKEY( SEC )
NEXT
RETURN NIL
