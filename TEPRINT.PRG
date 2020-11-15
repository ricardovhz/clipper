#INCLUDE "INKEY.CH"

WHILE .T.
   CLS
   @ 13,20 SAY "Vou fazer um teste de impressora."
   @ 14,20 SAY "Pressione qualquer tecla para continuar..."
   INKEY(0)
   IF LASTKEY()==K_ESC
      EXIT
   ENDIF
   SET DEVICE TO PRINTER
   @ 00,00 SAY "Teste de impressoras"
   SET DEVICE TO SCREEN
END
CLS
RETURN NIL
