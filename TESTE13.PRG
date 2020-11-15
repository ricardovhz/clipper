FUNCTION TESTE13( PARAM1 )
   IF EMPTY( PARAM1 )
      ? "Teste13 - Um teste"
      ? "Cancelando..."
      RETURN NIL
   ENDIF
   CLS
   nPos = RAT( ".",PARAM1 )
   P = ""
   IF "." $ PARAM1
      P = SUBS( PARAM1, 1, nPos-1 )
   ENDIF
   SETCOLOR( "N/W" )            
   @ 13,25 SAY P
   @ 15,25 SAY nPos
   INKEY( 0 )
   SETCOLOR( "W/N" )
   CLS
   RETURN NIL
