PUBLIC KEYSTROKE
#INCLUDE "INKEY.CH"
#INCLUDE "ACHOICE.CH"
MFRAME := "ÕÍ¸³¾ÍÔ³"
BFRAME := "ÑÍ¸³¾ÍÏ³"
SETCOLOR("W+/B,W/N,B")
CLS
WHILE .T.
   IF !FILE( "SWPANDO.PTG" )
      SETCURSOR( 0 )
      @ 13,00 SAY PADC( "Arquivo SWPANDO.PTG n„o est  contigo",79 )
      INKEY(0)
      SETCOLOR("W/N,W/N,N")
      CLS
      SETCURSOR( 1 )
      QUIT
   ELSE
      NRESP := RESPIE()
      IF NRESP = "S"
         EXIT
      ENDIF
      IF NRESP = "N"
         SETCURSOR( 0 )
         @ 12,20 TO 14,67
         @ 13,22 SAY "Este programa ‚ pirata. Copia de um original."
         INKEY(0)
         SETCOLOR("W/N,W/N,N")
         CLS
         SETCURSOR( 1 )
         QUIT
      ENDIF
   ENDIF
END
IF !FILE( "*.DBF" )
   @ 24,00 SAY PADC("No Files",79 )
   INKEY(0)
   SETCOLOR("W/N,W/N,N,W/N")
   CLS
   RETURN NIL
ENDIF
SETCOLOR("R/BG,W+/B,,,W+/B")
SCROLL( 07,24,14,59,0 )
@ 07,24,14,59 BOX MFRAME
@ 07,44,14,59 BOX BFRAME
@ 10,26 SAY "File "
@ 13,26 SAY " Ok      Cancela "
@ 08,44 SAY "ÃÄÄÄÄÄ*.DBFÄÄÄÄ´"
DECLARE DBF_LIST[ ADIR( "*.DBF" ) ]
ADIR( "*.DBF", DBF_LIST )
FILENAME := ""

WHILE.T.
   SETCOLOR("R/BG,W+/B,,,W+/B")
   NSEL := ACHOICE( 09,45,13,58, DBF_LIST, .T., "MU_FUNC" )
   IF LASTKEY()==K_ESC
      EXIT
   ENDIF
   IF NSEL = 0
      FILENAME := IIF( EMPTY( FILENAME ), PED( "",60 ), FILENAME )
   ELSE
      FILENAME := PED( DBF_LIST[ NSEL ], 60 )
   ENDIF
   KEYSTROKE := LASTKEY()
   DO CASE
   CASE KEYSTROKE = K_LEFT .OR. KEYSTROKE = K_ENTER
      WHILE .T.
         COISO := 0
         SETCOLOR("W+/B")
         @ 10,32 SAY PED( FILENAME, 10 )
         SETCURSOR( 0 )
         KEYSTROKE := INKEY(0)
         IF LASTKEY()==K_ESC
            EXIT
         ENDIF
         IF LASTKEY()==K_LEFT
            LOOP
         ENDIF
         BAI := BAICASE()
         IF BAI = 1
            SETCOLOR("R/BG")
            @ 10,32 SAY PED( FILENAME, 10 )
            NED := ESCOLHA()
            IF NED = 0
               LOOP
            ENDIF
            IF NED = 1
               COISO := 1
               EXIT
            ENDIF
            IF NED = 2
               EXIT
            ENDIF
         ENDIF
         IF BAI = 2
            SETCOLOR("R/BG")
            @ 10,32 SAY PED( FILENAME, 10 )
            COISO := 1
            EXIT
         ENDIF
         NSCROLL := "@K!S10"
         SETCURSOR( 1 )
         @ 10,32 GET FILENAME PICTURE NSCROLL
         READ
         KEYSTROKE := LASTKEY()
         DO CASE
         CASE KEYSTROKE = K_ESC
            EXIT
         ENDCASE
      END
   ENDCASE
   IF COISO = 1
      LOOP
   ELSE
      EXIT
   ENDIF
END
SETCOLOR("W/N,W/N,N,W/N")
CLS
RETURN NIL

****************
FUNCTION MU_FUNC
****************
PARAMETERS AMOD
PRIVATE NRET
NRET := AC_CONT
IF AMOD = 3
   KEYSTROKE := LASTKEY()
   DO CASE
   CASE KEYSTROKE = K_LEFT .OR. KEYSTROKE = K_ESC
      NRET = AC_ABORT
   CASE KEYSTROKE = K_ENTER
      NRET = AC_SELECT
   ENDCASE
ENDIF
RETURN NRET

****************
FUNCTION BAICASE
****************
LOCAL RET := 0
DO CASE
CASE KEYSTROKE > 48 .AND. KEYSTROKE < 123
   KEYBOARD CHR( KEYSTROKE )
CASE KEYSTROKE = K_ENTER
   RET := 0
CASE KEYSTROKE = K_DOWN
   RET := 1
CASE KEYSTROKE = K_RIGHT
   RET := 2
ENDCASE
RETURN RET

*****************
FUNCTION ESCOLHA
*****************
LOCAL NOPCS := { " Ok "," Cancela " }, IND := 1, NRETVAL := 1, NCOL := 26
SAVEINS := SETCURSOR()
SAVECOLOR := SETCOLOR()
SETCURSOR( 0 )
WHILE .T.
   SETCOLOR("W+/B")
   @ 13,NCOL SAY NOPCS[ IND ]
   INKEY(0)
   IF LASTKEY()==K_UP
      SETCOLOR("R/BG")
      @ 13,NCOL SAY NOPCS[ IND ]
      NRETVAL := 0
      EXIT
   ENDIF
   IF LASTKEY()==K_LEFT
      SETCOLOR("R/BG")
      @ 13,NCOL SAY NOPCS[ IND ]
      IND -= 1
      NCOL := 26
      IF IND = 0
         IND := 1
         NCOL := 26
      ENDIF
   ENDIF
   IF LASTKEY()==K_RIGHT
      SETCOLOR("R/BG")
      @ 13,NCOL SAY NOPCS[ IND ]
      IND += 1
      NCOL := 34
      IF IND > 2
         NRETVAL := 1
         EXIT
      ENDIF
   ENDIF
   IF LASTKEY()==K_ENTER
      NRETVAL := 2
      EXIT
   ENDIF
END
SETCOLOR( SAVECOLOR )
SETCURSOR( SAVEINS )
RETURN NRETVAL

************
FUNCTION PED
************
PARAMETERS MENSSAGE, SP
RETURN SUBS( MENSSAGE+SPACE(SP),1,SP )

*****************
FUNCTION RESPIE()
*****************
RUN REN SWPANDO.PTG SWPANDO.ARJ
RUN ARJ E SWPANDO.ARJ !LEI!RI.RIC > NUL
RUN REN SWPANDO.ARJ SWPANDO.PTG
IF !FILE( "!LEI!RI.RIC" )
   NCAG := "S"
ELSE
   NCAG := "S"
ENDIF
ERASE !LEI!RI.RIC
RETURN NCAG
