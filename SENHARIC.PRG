#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"

PUBLIC CTELA

CTELA := SAVESCREEN( ROW()-1,00,ROW()-1,79 )
SAVE SCREEN
SETCOLOR( "W+/RB,,,RB" )
CLS
@ 00,00,24,79 BOX B_DOUBLE+CHR( 32 )
SAVECOLOR := SETCOLOR()
SETCOLOR( "W+/B" )
@ 01,01 SAY PADC( "Programa de fazer senha - Ricardo Vanhoz Ribeiro",78 )
SETCOLOR( SAVECOLOR )
@ 05,10 SAY "Escreva sua senha aqui"
@ 06,10 SAY "         "+CHR( 25 )
WHILE .T.
   SETCOLOR( "N/W" )
   @ 07,10 SAY "                    "
   SETPOS( 07,10 )
   CSENHA := RESENHA()
   IF CSENHA = "LINGUEIR" .OR. CSENHA = "lingueir"
      SAVECOLOR2 := SETCOLOR()
      @ 08,20,13,36 BOX B_DOUBLE+CHR( 32 )
      @ 10,21,12,35 BOX B_SINGLE+CHR( 32 )
      @ 11,22 SAY "    Ok"
      SETCOLOR( "W+/B" )
      @ 09,21 SAY "  Senha Exata  "
      SETCURSOR( 0 )
      INKEY( 0 )
      SETCOLOR( SAVECOLOR )
      EXIT
   ELSE
      SAVETELA := SAVESCREEN()
      SAVECOLOR2 := SETCOLOR()
      @ 08,20,13,35 BOX B_DOUBLE+CHR( 32 )
      @ 10,21,12,33 BOX B_SINGLE+CHR( 32 )
      @ 11,22 SAY "    Ok"
      SETCOLOR( "W+/B" )
      @ 09,21 SAY " Senha Errada "
      SETCURSOR( 0 )
      INKEY( 0 )
      SETCOLOR( SAVECOLOR )
      RESTSCREEN( ,,,,SAVETELA )
      LOOP
   ENDIF
END
RESTORE SCREEN
SETCOLOR( COLORI( CTELA ) )
? "A palavra que vocˆ escolheu foi &CSENHA"
QUIT

******************
FUNCTION RESENHA()
******************
NMESS := ""
NINS := 2
SETCURSOR( 1 )
I := 1
WHILE .T.
   NKEY := INKEY( 0 )
   DO CASE
      CASE NKEY = K_BS
         IF EMPTY( NMESS )
            I -= 1
         ELSE
            IF I = LEN( NMESS )+1
               NMESS := SUBS( NMESS,1,LEN( NMESS )-1 )
               @ 07,10 SAY SPACE( 20 )
               @ 07,10 SAY PED( REPLICATE( "*",LEN( NMESS ) ),20 )
               I := LEN( NMESS )+1
               SETPOS( 07,I+9 )
            ELSE
               NAA := SUBS( NMESS,1,I-3 )
               NBB := SUBS( NMESS,I-1 )
               NMESS := NAA+NBB
               @ 07,10 SAY SPACE( 20 )
               @ 07,10 SAY PED( REPLICATE( "*",LEN( NMESS ) ),20 )
               I -= 1
               SETPOS( 07,I+9 )
            ENDIF
            LOOP
         ENDIF
      CASE NKEY = K_ESC
         RESTORE SCREEN
         SETCOLOR( COLORI( CTELA ) )
         ? "A palavra que vocˆ escolheu foi &NMESS"
         QUIT
      CASE NKEY = K_LEFT
         IF EMPTY( NMESS ) .OR. I+9 = 11
            I -= 1
         ELSE
            IF LEN( NMESS ) = I-1
               I -= 1
               SETPOS( 07,I+9 )
               I += 1
            ELSE
               I -= 2
               SETPOS( 07,I+9 )
            ENDIF
         ENDIF
      CASE NKEY = K_RIGHT
         IF EMPTY( NMESS ) .OR. I+9 = 30
            I -= 1
         ELSE
            SETPOS( 07,I+9 )
         ENDIF
      CASE I = 20
         IF LASTKEY() == K_ESC .OR. LASTKEY() == K_ENTER
            EXIT
         ELSE
            NMESS := NMESS+CHR( NKEY )
            @ 07,I+9 SAY "*"
            EXIT
         ENDIF
      CASE NKEY = K_ENTER
         EXIT
      CASE NKEY >= 32 .AND. NKEY <= 237
         @ 07,I+9 SAY "*"
         NMESS := NMESS+CHR( NKEY )
      CASE NKEY = K_END
         IF EMPTY( NMESS )
            I -=1
         ELSE
            I = LEN( NMESS )
            SETPOS( 07,I+10 )
         ENDIF
      CASE NKEY = K_HOME
         SETPOS( 07,10 )
         I = 0
      CASE NKEY = K_INS
         IF NINS = 2
            SETCURSOR( 3 )
            NINS -= 1
         ELSE
            SETCURSOR( 1 )
            NINS += 1
         ENDIF
         I -= 1
      CASE NKEY = K_DEL
         IF EMPTY( NMESS ) .OR. I-1 = LEN( NMESS )
            I -= 1
         ELSE
            NBOS := SUBS( NMESS,1,I-2 )
            NCAG := SUBS( NMESS,I )
            NMESS := NBOS+NCAG
            @ 07,10 SAY SPACE( 20 )
            @ 07,10 SAY PED( REPLICATE( "*",LEN( NMESS ) ),20 )
            SETPOS( 07,I+9 )
         ENDIF
      OTHERWISE
         I -= 1
   ENDCASE
   I += 1
END
RETURN NMESS

*************************
FUNCTION COLORI( CTELA1 )
*************************
LOCAL PARCOR := SUBS( CTELA1,2,1 )
NLETRA := { "N","B","G","BG","R","RB","GR","W",;
            "N+","B+","G+","BG+","R+","RB+","GR+","W+" }
NCORDF := { "N","B","G","BG","R","RB","GR","W",;
            "N*","B*","G*","BG*","R*","RB*","GR*","W*" }
CBAI := ASC( PARCOR )
N2   := CBAI
// DESCOBRE A COR DO FUNDO
WHILE .T.
   IF CBAI < 16
      NFUNDO := 0
   ELSE
      NFUNDO := CBAI / 16
   ENDIF
   IF NFUNDO > 16
      LOOP
   ENDIF
   NFUNDO += 1
   EXIT
END
// DESCOBRE A COR DA LETRA
WHILE .T.
   IF N2 <= 16 .AND. NFUNDO = 1
      NTOTAL := N2
      NTOTAL += 1
   ELSE
      NTOTAL := N2 -= 16
      NTOTAL += 1
   ENDIF
   IF NTOTAL > 16
      LOOP
   ENDIF
   EXIT
END
NLET := NLETRA[ NTOTAL ]+"/"+NCORDF[ NFUNDO ]
RETURN NLET


************************
FUNCTION PED( TEXTO,SP )
************************
RETURN SUBS( TEXTO+SPACE( SP ),1,SP )
