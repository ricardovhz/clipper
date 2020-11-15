#INCLUDE "INKEY.CH"
SET SCOREBOARD OFF
USE C:\HUMBERTO\SMAR\ARQ5.DBF NEW
INDEX ON CONTATO TO C:\HUMBERTO\SMAR\ARQ5B
CLS
NOME := SPACE(30)
NAME := SPACE(30)
@ 00,00 SAY "Digite o seu nome"
@ 01,00 GET NOME PICTURE "@!" VALID CHECANOME( NOME )
@ 01,00 GET NOME PICTURE "@!"
@ 02,00 GET NAME PICTURE "@!"
READ
SETCOLOR("W/N,W/N")
CLS
RETURN NIL


STATIC FUNCTION CHECANOME( X )
IF !EMPTY( X ) .OR. DBSEEK( X )
   RETURN .T.
ENDIF
SAVE SCREEN
OB := TBROWSEDB()
OB:NTOP := 13
OB:NBOTTOM := 24
OB:NLEFT   := 00
OB:NRIGHT  := 79
OB:ADDCOLUMN( TBCOLUMNNEW( "CODIGO",{ || CODIGO } ) )
OB:ADDCOLUMN( TBCOLUMNNEW( "DTACHAMA",{ || DTACHAMA } ) )
OB:ADDCOLUMN( TBCOLUMNNEW( "HRACHAMA",{ || HRACHAMA } ) )
OB:ADDCOLUMN( TBCOLUMNNEW( "CONTATO",{ || CONTATO } ) )
DBROWSE( OB )
IF LASTKEY()==K_ENTER
   KEYBOARD CHR( K_CTRL_Y ) + CONTATO + CHR( K_ENTER )
ENDIF
SETCOLOR("W/N,N/W")
RESTORE SCREEN
RETURN .T.

**********************
FUNCTION DBROWSE( oB )
**********************
LOCAL OldColor

   SET CURSOR OFF
   cOldColor := SETCOLOR( "R/W,W/B,,,R/W" )
   *
   oB:Cargo    := IF( VALTYPE(oB:Cargo) != "B", { || .T. }, ob:Cargo )
   *
   oB:freeze   := 1
   oB:nTop     := IIF( EMPTY(oB:nTop),   06, oB:nTop )
   oB:nLeft    := IIF( EMPTY(oB:nLeft),  10, oB:nLeft )
   oB:nBottom  := IIF( EMPTY(oB:nBottom), MAXROW()-6, oB:nBottom)
   oB:nRight   := IIF( EMPTY(oB:nRight), MAXCOL()-10, oB:nRight )
   oB:headSep  := CHR(205) + CHR(209) + CHR(205)
   oB:ColSep   := CHR(032) + CHR(179) + CHR(032)
   oB:colorSpec:= SETCOLOR()
   *
   oB:skipBlock     := { |nSkip| SkipDB( nSkip, ob:Cargo ) }
   oB:goTopBlock    := { || GoTopDB( oB:Cargo ) }
   oB:goBottomBlock := { || GoBottomDB( ob:Cargo ) }
   *
   SAVE SCREEN
   SCROLL( oB:nTop, oB:nLeft, oB:nBottom, oB:nRight, 0)
   @  oB:nTop, oB:nLeft TO oB:nBottom, oB:nRight

   oB:nTop    += 1
   oB:nLeft   += 1
   oB:nBottom -= 1
   oB:nRight  -= 1

   //executa o objeto Browse
   WHILE .T.

      //Congela a primeira coluna
      IF oB:ColPos <= oB:Freeze
         oB:ColPos := oB:Freeze + 1
      ENDIF

      //Estabiliza
      WHILE (  !oB:stabilize()  )
         nKey := INKEY()
         IF nKey != 0
            EXIT
         ENDIF
      END

      IF oB:stable
         IF oB:hitTop .OR. oB:hitBottom
            TONE(500, 1)
         ENDIF
           //Aguarda a teclagem
          nKey := INKEY(0)
      ENDIF

      //Faz o UPPER
      nKey := IF( nKey >= 97 .AND. nKey <= 122, nKey - 32, nKey )

      DO CASE
      CASE nKey == 27 //K_ESC
         EXIT

      CASE nKey == 13 //K_ENTER
         EXIT

      OTHERWISE
         StandKey( oB, nKey )
      ENDCASE

   END
   SET CURSOR ON
   REST SCREEN

RETURN NIL

STATIC FUNCTION SkipDB( nSolicitado, bWhile )

LOCAL nSaltados := 0

   IF (nSolicitado == 0)
      SKIP 0

   ELSEIF (nSolicitado > 0 ) .AND. ( !EOF() )
      WHILE ( nSaltados < nSolicitado )
         SKIP

         IF !EVAL( bWhile ) .OR. EOF()
            SKIP -1
            EXIT

         ENDIF
         nSaltados++

      END

   ELSEIF (nSolicitado != 0)
      WHILE ( nSaltados > nSolicitado )
         SKIP -1
         IF BOF()
            EXIT
         ENDIF

         IF !EVAL( bWhile )
            SKIP
            EXIT
         ENDIF

         nsaltados--
      END

   ENDIF

RETURN (nSaltados)

STATIC FUNCTION GoTopDB( bWhile )

   WHILE EVAL( bWhile ) .AND. ( !BOF() )
      SKIP -1
      IF !EVAL( bWhile)
         SKIP
         EXIT
      ENDIF
   END

RETURN NIL

STATIC FUNCTION GoBottomDB( bWhile )

   WHILE EVAL( bWhile ) .AND. ( !EOF() )
      SKIP
   END

   SKIP -1

RETURN NIL

FUNCTION StandKey( oTBrowser, nKey )

   DO CASE
      CASE ( nKey == 24 ) //K_DOWN
         oTBrowser:down()

      CASE ( nKey == 5 ) //K_UP
           oTBrowser:up()

      CASE ( nKey == 3)   //K_PGDN
           oTBrowser:pagedown()

      CASE ( nKey == 18 ) //K_PGUP
           oTBrowser:pageUP()

      CASE ( nKey == 31 ) // K_CTRL_PGUP
           oTBrowser:goTop()

      CASE ( nKey == 30 ) //K_CTRL_PGDN
           oTBrowser:goBottom()

      CASE ( nKey == 4 )  //K_RIGHT
           oTBrowser:right()

      CASE ( nKey == 19 ) //K_LEFT
           oTBrowser:left()

      CASE ( nKey == 1 )  //K_HOME
           oTBrowser:home()

      CASE ( nKey == 6 )  //K_END
           oTBrowser:end()

      CASE ( nKey == 26 ) // K_CTRL_LEFT
           oTBrowser:panLeft()

      CASE ( nKey == 2 )  //K_CTRL_RIGHT
           oTBrowser:panRight()

      CASE ( nKey == 29 ) //K_CTRL_HOME
           oTBrowser:panHome()

      CASE ( nKey == 23 ) //K_CTRL_END
           oTBrowser:panEnd()

   ENDCASE

RETURN NIL

