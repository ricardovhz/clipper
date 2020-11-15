#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"
SETCOLOR("W+/B,,B")
CLEAR
@ 00,00,24,79 BOX B_SINGLE
@ 21,00,24,79 BOX B_SINGLE
@ 21,00 SAY "Ã"
@ 21,79 SAY "´"
@ 03,01 SAY PADC( "Digite a senha",78 )
WHILE .T.
   SETPOS( 22,03 )
   INKEY(0)
   IF .NOT. CHR( LASTKEY() ) $ "Dd"
      LOOP
   ELSE
      INKEY(0)
      IF .NOT. CHR( LASTKEY() ) $ "Gg"
         LOOP
      ELSE
         INKEY(0)
         IF .NOT. CHR( LASTKEY() ) $ "Ff"
            LOOP
         ELSE
            INKEY(0)
            IF .NOT. CHR( LASTKEY() ) $ "Tt"
               LOOP
            ELSE
               INKEY(0)
               IF LASTKEY() != K_LEFT
                  LOOP
               ELSE
                  INKEY(0)
                  IF LASTKEY() != K_RIGHT
                     LOOP
                  ELSE
                     INKEY(0)
                     IF LASTKEY() != K_RIGHT
                        LOOP
                     ELSE
                        INKEY(0)
                        IF LASTKEY() != K_LEFT
                           LOOP
                        ELSE
                           @ 23,01 SAY PADC( "Senha certa",78 )
                           TONE( 493.90,9 )
                           @ 23,01 SAY PADC( " ",78 )
                           @ 24,01 SAY PADC( "Deseja executar novamente?",78 )
                           INKEY(0)
                           IF CHR( LASTKEY() ) $ "Nn" .OR. LASTKEY()==K_ESC
                              EXIT
                           ENDIF
                           @ 24,01 SAY PADC( " ",78 )
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
      ENDIF
   ENDIF
END
SETCOLOR("W/N,,N")
CLS
RETURN NIL
