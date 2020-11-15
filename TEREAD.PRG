CLS
COISO := 00000
@ 13,20 SAY "Escreva sua idade " GET COISO PICTURE "99999" VALID F_STRZERO( @COISO,5 )
READ
CLS
RETURN NIL

*********************************************
STATIC FUNCTION F_STRZERO( CCCLI, NQTDZEROS )
*********************************************
LOCAL NLOGICAL := .F.
IF .NOT. EMPTY( CCCLI )
   CCCLI := STRZERO( IIF( VALTYPE( CCCLI ) == "N", CCCLI, VAL( CCCLI ) ), NQTDZEROS )
   NLOGICAL := .T.
ENDIF
RETURN NLOGICAL
