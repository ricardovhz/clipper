#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"

TABCORI := { "Preto","Azul","Verde","Cyano","Vermelho","Magenta","Marrom","Branco",;
             "Preto Pis.","Azul Pis.","Verde Pis.","Cyano Pis.","Vermelho Pis.","Magenta Pis.","Marrom Pis.","Branco Pis." }
TABCORP := { "Preto","Azul","Verde","Cyano","Vermelho","Magenta","Marrom","Branco",;
             "Cinza","Azul Claro","Verde Claro","Cyano Claro","Vermelho Claro","Magenta Claro","Amarelo","Branco Intenso" }
TABCORL := { "N","B","G","BG","R","RB","GR","W","N+","B+","G+","BG+","R+","RB+","GR+","W+" }
TABCORF := { "N","B","G","BG","R","RB","GR","W","N*","B*","G*","BG*","R*","RB*","GR*","W*" }
IND1    := 1
IND2    := 1
IND3    := 1
IND4    := 1
LEN     := 5
SAVAIND := 0
SET CURSOR OFF
SETCOLOR( "W+/N" )
CLS
@ 00,00,24,79 BOX B_DOUBLE+CHR(32)
@ 03,01 SAY PADC("CORSE - DE RICARDO VANHOZ RIBEIRO",78)
LI      := 5
FOR IND1 = 1 TO 16
   @ IND1+4, 03 SAY TABCORI[IND1]
NEXT
FOR IND2 = 1 TO 16
   @ IND2+4, 55 SAY TABCORP[IND2]
NEXT

IND1 := 1
IND2 := 8
IND3 := 1
IND4 := 8
MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3], "  Teste de cores.  " )
SETCOLOR("N/N")
WHILE .T.
   MUCOR( LI,03,"N/W",  TABCORI[IND1] )
   INKEY(0)
   IF LASTKEY() != K_ESC .AND. LASTKEY() != K_DOWN .AND. LASTKEY() != K_UP .AND. LASTKEY() != K_RIGHT .AND. LASTKEY() != K_ENTER
      LOOP
   ENDIF
   IF LASTKEY()==K_ESC
      EXIT
   ENDIF
   IF LASTKEY()==K_DOWN
      MUCOR( LI,03,"W+/N", TABCORI[IND1] )
      LI += 1
      IND1 += 1
      IND3 += 1
      IF IND1 > 16
         LI := 5
         IND1 := 1
         IND3 := 1
         MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
         LOOP
      ELSE
         MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
         LOOP
      ENDIF
   ENDIF
   IF LASTKEY()==K_UP
      MUCOR( LI,03,"W+/N", TABCORI[IND1] )
      LI -= 1
      IND1 -= 1
      IND3 -= 1
      IF IND1 = 0
         LI := 20
         IND1 := 16
         IND3 := 16
         MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
         LOOP
      ELSE
         MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
         LOOP
      ENDIF
   ENDIF
   IF LASTKEY()==K_ENTER
      SETCOLOR( TABCORL[IND4]+"/"+TABCORF[IND3] )
      CLS
      RETURN NIL
   ENDIF
   IF LASTKEY()==K_RIGHT
      MUCOR( LI,03,"W/N",TABCORI[IND1] )
      LEN := LI
      WHILE .T.
         IF SAVAIND > 0
            LI := SAVAIND
         ELSE
            LI := 12
         ENDIF
         WHILE .T.
            MUCOR( LI,55,"N/W",TABCORP[IND2] )
            INKEY(0)
            IF LASTKEY() != K_ESC .AND. LASTKEY() != K_DOWN .AND. LASTKEY() != K_UP .AND. LASTKEY() != K_LEFT .AND. LASTKEY() != K_ENTER
               LOOP
            ENDIF
            IF LASTKEY()==K_ESC
               SETCOLOR("W/N")
               CLS
               RETURN NIL
            ENDIF
            IF LASTKEY()==K_DOWN
               MUCOR( LI,55,"W+/N", TABCORP[IND2] )
               LI += 1
               IND2 += 1
               IND4 += 1
               IF IND2 > 16
                  LI := 5
                  IND2 := 1
                  IND4 := 1
                  MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
                  LOOP
               ELSE
                  MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
                  LOOP
               ENDIF
            ENDIF
            IF LASTKEY()==K_UP
               MUCOR( LI,55,"W+/N", TABCORP[IND2] )
               LI -= 1
               IND2 -= 1
               IND4 -= 1
               IF IND2 = 0
                  LI := 20
                  IND2 := 16
                  IND4 := 16
                  MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
                  LOOP
               ELSE
                  MUCOR( 22,29,TABCORL[IND4]+"/"+TABCORF[IND3],"  Teste de cores.  " )
                  LOOP
               ENDIF
            ENDIF
            IF LASTKEY()==K_LEFT
               MUCOR( LI,55,"W/N", TABCORP[IND2] )
               SAVAIND  := LI
               LI := LEN
               EXIT
            ENDIF
            IF LASTKEY()==K_ENTER
               SETCOLOR( TABCORL[IND4]+"/"+TABCORF[IND3] )
               CLS
               RETURN NIL
            ENDIF
         END
         EXIT
      END
      LOOP
   ENDIF
END
SETCOLOR("W/N")
CLS
RETURN NIL

***************
FUNCTION MUCOR
***************
PARAMETERS LF, CF, COR, MESSAGE
PRIVATE SAVECOR
SAVECOR := SETCOLOR()
SETCOLOR( COR )
@ LF,CF SAY MESSAGE
SETCOLOR( SAVECOR )
RETURN NIL
