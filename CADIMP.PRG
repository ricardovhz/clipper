#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"

USE CADS.DBF NEW
INDEX ON D_NOME TO CADIND
SETCOLOR("W+/RB")
CLS
@ 00,00,24,79 BOX B_DOUBLE+CHR(32)
@ 00,00,02,79 BOX B_DOUBLE
@ 02,00 SAY CHR(204)+REPLICATE( "Í",78 )+CHR(185)
@ 01,01 SAY PADC("PROGRAMA PARA IMPPRIMIR CADASTROS.",78)
@ 13,25 SAY "Tem certeza de imprimir? "
INKEY(0)
IF CHR(LASTKEY()) $ "Ss"
   WHILE !ISPRINTER()
      @ 23,01 SAY PADC("Impressora desligada. Ligue-a.",78)
      INKEY(0)
      IF LASTKEY()==K_ESC
         SETCOLOR("W/N")
         CLS
         RETURN NIL
      ENDIF
   END
   SET DEVICE TO PRINTER
   @ 00,00 SAY CHR(27)+CHR(69)+CHR(27)+CHR(52)
   @ 00,00 SAY PADC("CADASTROS DE PESSOAS",79)
   @ 00,43 SAY CHR(27)+CHR(53)+CHR(27)+CHR(70)
   @ 01,00 SAY CHR(14)
   @ 01,00 SAY "DE RICARDO"
   @ 01,11 SAY CHR(20)
   @ 02,00 SAY CHR(27)+CHR(77)+CHR(15)
   @ 03,00 SAY "+-------------------------------------+-------------------------------------+---------------------------+--------------------------+"
   @ 04,00 SAY "| Nome                                | Endere‡o                            | Bairro                    | Cidade                   |"
   @ 05,00 SAY "+-------------------------------------+-------------------------------------+---------------------------+--------------------------+"
   LI = 06
   WHILE !EOF()
      @ LI,00 SAY "| "+D_NOME+" | "+D_ENDE+" | "+D_BAIR+" | "+D_CIDADE+" |"
      LI += 1
      SKIP
   END
   @ LI,00 SAY "+-------------------------------------+-------------------------------------+---------------------------+--------------------------+"
   SET DEVICE TO SCREEN
   SETCOLOR("W/N")
   CLS
   RETURN NIL
ENDIF
IF LASTKEY() = K_ESC .OR. CHR(LASTKEY()) $ "Nn"
   SETCOLOR("W/N")
   CLS
   RETURN NIL
ENDIF
