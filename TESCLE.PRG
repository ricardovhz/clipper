#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"

SETCOLOR("W+/B,,B,,")
CLS
SETCOLOR("W+/R,W+/B,,,W+/B")
@ 10,23,13,52 BOX B_DOUBLE+CHR(32)
@ 11,26 SAY "Digite o nome do arquivo"
NOMARQ := ""
WHILE .T.
   SET CURSOR OFF
   NOMARQ := IIF( EMPTY( NOMARQ ), PED( "", 60 ), NOMARQ )
   SETCOLOR("W+/B")
   @ 12,33 SAY PED( NOMARQ, 8 )
   KEYSTROKE := INKEY(0)
   DO CASE
      CASE KEYSTROKE = K_ESC
         EXIT
      CASE KEYSTROKE <> K_ENTER .OR. KEYSTROKE <> K_LEFT .OR. KEYSTROKE <> K_RIGHT .OR.;
                        KEYSTROKE <> K_UP .OR. KEYSTROKE <> K_DOWN
         KEYBOARD CHR( KEYSTROKE )
      CASE KEYSTROKE = K_ENTER
         KEYBOARD ""
      OTHERWISE
         LOOP
   ENDCASE
   NSCROLL := "@K!S8"
   SETCURSOR( 3 )
   @ 12,33 GET NOMARQ PICTURE NSCROLL
   READ
   IF LASTKEY()==K_ESC
      CLEAR GETS
   ENDIF
   LOOP
END
SETCOLOR("W/N,W/N,N,W/N")
CLS
QUIT

***********************
FUNCTION PED( TEXT,SP )
***********************
RETURN SUBS( TEXT+SPACE(SP),1,SP )
