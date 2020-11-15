#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"

SET SCOREBOARD OFF
SET CONFIRM ON


SETCOLOR("W+/B,W+/R,B,W+/R")
CLS
@ 00,00,24,79 BOX B_DOUBLE+CHR(32)
SETCOLOR("W+/R,N/W")
@ 11,21,17,58 BOX B_DOUBLE+CHR(32)
@ 14,21 SAY "ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹"
USE CADTEL.DBF ALIAS CT NEW
INDEX ON D_NOME TO CADTEL
INDEX ON D_TELE TO CADTEL2
INDEX ON D_ENDE TO CADTEL3
SET INDEX TO CADTEL, CADTEL2, CADTEL3

WHILE .T.
   MP=1
   @ 12,22 PROMPT " 1 - Cadastrar telefones.           "
   @ 16,22 PROMPT " 2 - Ver o telefone                 "
   MENU TO MP
   DO CASE 
      CASE MP = 1 .OR. CHR( LASTKEY() ) = "1"
         DO CADTEL
      CASE MP = 2 .OR. CHR( LASTKEY() ) = "2"
         DO VERTEL
      CASE LASTKEY() == K_ESC
         EXIT
   ENDCASE
END
SETCOLOR("W/N,W/N,N,W/N")
CLS
CLOSE DATABASES
QUIT

****************
PROCEDURE CADTEL
****************
SAVE SCREEN
SAVECOLOR := SETCOLOR()
SETCOLOR("W+/B,GR+/R,,,W+/B")
@ 01,01 CLEAR TO 23,78

WHILE .T.
   NOM := SPACE( 30 )
   END := SPACE( 30 )
   TEL := SPACE( 12 )
   SET ORDER TO 2
   @ 11,06 SAY "Telefone"
   @ 15,06 SAY "Nome                                 Endere‡o"
   @ 23,01 SAY PADC( "ESC - Volta ao menu.",78 )
   @ 13,06 GET TEL PICTURE "@R (9999)9999-9999" 
   READ
   IF LASTKEY()==K_ESC
      EXIT
   ENDIF
   IF  !DBSEEK( TEL )
       APPEND BLANK
   ELSE
      @ 17,06 SAY D_NOME
      @ 17,43 SAY D_ENDE
      NOM := D_NOME
      END := D_ENDE
   ENDIF
   @ 23,01 SAY PADC( "ESC - Volta a digitar o telefone",78 )
   @ 17,06 GET NOM PICTURE "@!" 
   @ 17,43 GET END PICTURE "@!"
   READ
   IF LASTKEY()==K_ESC
      LOOP
   ENDIF
       
   NRESP := "S"
   @ 23,67 SAY "OK? (S/N) "
   @ 23,77 GET NRESP PICTURE "@!"
   READ
   IF NRESP = "S"
      REPLACE CT->D_TELE WITH TEL
      REPLACE CT->D_NOME WITH NOM
      REPLACE CT->D_ENDE WITH END
   ELSEIF NRESP = "N"
      LOOP
   ENDIF
END
RESTORE SCREEN
SETCOLOR( SAVECOLOR )
RETURN

****************
PROCEDURE VERTEL
****************
SAVETEL := SAVESCREEN( 00,00,24,79 )
SAVECOLOR := SETCOLOR()
SETCOLOR( "W+/B" )
@ 01,01 CLEAR TO 23,78

PRIVATE getList := {},;
        oB,;
        bWhile := { || .T. },;
        nOpcao  := 0,;
        lReturn := .F.,;
        cStart  := "",;
        cMsg    := "",;
        aMenu   := {  "1-Nome        ",;
                      "2-Endere‡o    " }
  
   SELECT CT
   WHILE .T.
      SETCOLOR( "W+/R,N/W" )
      @ 11,31 TO 14,47
      SCROLL(12,32,13,46,0 )
      nOpcao := achoice( 12,32,13,46,aMenu )
      SETCOLOR("W+/B")
      @ 11,31 CLEAR TO 14,47
      IF LASTKEY() = 27 .OR. nOpcao = 0
         EXIT
      ENDIF
      SET COLOR TO W+/B,N/W,,,W+/B

      @ 23,03 say space(75)
      DO CASE
         CASE nOpcao = 1
              SET ORDER TO 1
              cStart := SPACE(30)
              @ 23,10 say "N o m e   Inicial: " GET cStart
         CASE nOpcao = 2
              SET ORDER TO 3
              cStart := SPACE(30)
              @ 23,10 say "Endere‡o Inicial: " GET cStart
      ENDCASE
      READ
      SET COLOR TO W/B,N/W,,,W+/B
      @ 23,10 CLEAR TO 23,78

      IF LASTKEY() = 27
         EXIT
      ENDIF

      IF nOpcao = 1
         bWhile := { || CT->D_NOME # SPACE(30) }
      ELSE   
         bWhile := { || CT->D_ENDE # SPACE(30) }
      ENDIF

      IF ! DBSEEK( ALLTRIM(cStart),.T.  )
         GO TOP
      ENDIF

      IF EVAL( bWhile )
         ob:= TBrowseDB()
         ob:nTop   := 06
         ob:nLeft  := 1
         ob:nBottom:= 21
         ob:nRight := MAXCOL()-1
         ob:addColumn(  TBColumnNew( "FONE",{ || CT->D_TELE } )  )
         ob:addColumn(  TBColumnNew( "NOME",{ || CT->D_NOME } )  )
         ob:addColumn(  TBColumnNew( "ENDERE€O",{ || CT->D_ENDE } )  )
         ob:Cargo := bWhile
         dBrowse( oB )
      ENDIF
   END

RESTSCREEN( ,,,,SAVETEL )
SETCOLOR( SAVECOLOR )
RETURN

