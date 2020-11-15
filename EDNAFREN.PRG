FUNCTION EDNAFREN(ARQUIVO,cPRINT)
   SAVE SCREEN
   RELEASE ALL
   LINHA := CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+" "
   BORDA := "ÚÄ¿³ÙÄÀ³ "
   #INCLUDE "INKEY.CH"
   #INCLUDE "BOX.CH"

   IF EMPTY( ARQUIVO )
      ? "EDNAFREN - Editor - De Ricardo Vanhoz Ribeiro."
      ? "Vocˆ tem que colocar um nome de ARQ. Cancelando..."
      ?
      RETURN NIL
   ENDIF   
   NPIS := RAT( "\", UPPER( ARQUIVO ) )
   ARQ  := SUBS( ARQUIVO, NPIS + 1 )
   IF FILE( "AJUDA.HLP" )
      HELPFILE := "AJUDA.HLP"
   ELSE
      HELPFILE := GETDBF( "AJUDA.HLP" )
   ENDIF
   SET KEY K_INS TO TOINS
   SET SCOREBOARD OFF
   SET KEY K_F1 TO AJUDA
   SET KEY K_F10 TO DOS
      
   IF cPRINT = "/P" .OR. cPRINT = "/p"
      IF !FILE(UPPER(ARQUIVO))
         SETCOLOR("W+/BG")
         @ 13,19,18,60 BOX B_SINGLE+CHR(32)
         SETCOLOR("W+/G")
         SOMBRAR(13,19,18,60)
         SETCOLOR("W+/BG")
         @ 15,19 SAY "Ã"
         @ 15,20 SAY REPLICATE("Ä",40)
         @ 15,60 SAY "´"
         @ 14,29 SAY "ARQ nao existente."
         @ 16,26 SAY "Pressione qualquer tecla..."
         INKEY(0)
         RESTORE SCREEN
         RETURN NIL
      ELSE
         ?? "Ligue a impressora, coloque o papel e pressione [ENTER] ou pressione [ESC] para"
         ?  "voltar."
         INKEY(0)
         IF LASTKEY()==K_ESC
            SETCOLOR("W/N")
            RETURN NIL
         ENDIF
         WHILE !ISPRINTER() .AND. .T.
            ? "Impressora desligada. Ligue-a..."
            INKEY(0)
            IF LASTKEY()==K_ESC
               SETCOLOR("W/N")
               RETURN NIL
            ENDIF
         END
            CLEAR TYPEAHEAD
            SET DEVICE TO PRINTER
            SETPRC(00,00)
            NOUTPUT := FOPEN( UPPER( ARQUIVO ) )
            NLINHAS := MLCOUNT( NOUTPUT, 77 )
            LI := 0
            FOR NCURRLIN = 1 TO NLINHAS
               CLINHAS := MEMOLINE( NOUTPUT, 77, NCURRLIN )
               @ LI,00 SAY CLINHAS
               LI += 1
            NEXT
            SET DEVICE TO SCREEN
            CLEAR ALL
            CLOSE DATABASES
            RETURN NIL
      ENDIF      
   ENDIF
   
   
   IF !FILE( UPPER( ARQUIVO ) )
      SETCOLOR( "W+/N" )
      CLS
      @ 00,00,24,79 BOX BORDA
      SETCOLOR( "N/GR" )
      @ 24,01,24,78 BOX LINHA
      @ 24,01 SAY PADC("DE RICARDO VANHOZ RIBEIRO E HUMBERTO ROSADO RIBEIRO.",78)
      @ 24,02 SAY "F1 - Ajuda"
      @ 24,69 SAY "F10 - Dos"
      LEIS := SAVESCREEN()
      SETCOLOR( "W+/G,GR+/R" )
      @ 13,13,19,60 BOX BORDA
      SETCOLOR( "R/R" )
      SOMBRAR( 13,13,19,60 )
      SETCOLOR( "W+/G,GR+/R" )
      @ 15,13 SAY CHR(195)+REPLICATE("Ä",46)+CHR(180)
      @ 14,21 SAY "ARQ n„o existente. Fazer agora?"
      EDIT := 1
      @ 18,15 PROMPT " <Fazer> "
      @ 18,51 PROMPT " <Sair> "
      MENU TO EDIT
      DO CASE
         CASE EDIT=1
            RESTSCREEN( ,,,,LEIS )
            SETCOLOR( "N/GR" )
            @ 00,( 80 - ( LEN( ARQ )+2 ) ) / 2 SAY SPACE( LEN( ARQ )+2 )
            ESCLEN( 00,( ( 80 - ( LEN( ARQ )+2 ) ) / 2 ) + 1, UPPER( ARQ ),0.025 )
            SETCOLOR("RB/N,RB+/N,,,RB/N")
            NOUTPUT := FCREATE( UPPER( ARQUIVO ), 0 )
            CLINE   := SPACE( 10 )
            cTEXTO := MEMOEDIT( CLINE,01,01,23,78,.T.,,2032 )
            IF LASTKEY()==K_ESC
               SETCOLOR("W/N,W/N,,,W/N")
               CLS
               RESTORE SCREEN
               RETURN NIL
            ENDIF   
            FWRITE( NOUTPUT, CTEXTO )
            FCLOSE( NOUTPUT )
            SETCOLOR("W/N,W/N,,,W/N")
            CLS
            RESTORE SCREEN
            RETURN NIL  
         CASE EDIT=2
            SETCOLOR( "W/N,W/N,N,W/N" )
            CLS
            RETURN NIL
      ENDCASE
   ELSE
      CLS
      SETCOLOR("W+/N")
      @ 00,00,24,79 BOX B_SINGLE+CHR(32)
      SETCOLOR("N/GR")
      @ 24,01,24,78 BOX LINHA
      @ 24,01 SAY PADC("DE RICARDO VANHOZ RIBEIRO E HUMBERTO ROSADO RIBEIRO.",78)
      @ 24,02 SAY "F1 - Ajuda"
      @ 24,69 SAY "F10 - Dos"
      SETCOLOR("N/RB")
      @ 00,( 80 - ( LEN( ARQ )+2 ) ) / 2  SAY SPACE( LEN( ARQ )+2 )
      ESCLEN( 00,( ( 80 - (  LEN( ARQ )+2 ) ) / 2 ) + 1,UPPER( ARQ ),0.025 )
      SETCOLOR("RB/N,RB+/N,,,RB/N")
      CLINE  := MEMOREAD( ARQUIVO )
      NOUP   := FCREATE( "EDNAFREN.TXT", 0 )
      cTEXTO := MEMOEDIT( CLINE,01,01,23,78,.T.,,2032 )
      IF LASTKEY()==K_ESC
         SETCOLOR("W/N,W/N,,,W/N")
         CLS
         RESTORE SCREEN
         RETURN NIL
      ENDIF   
      FWRITE( NOUP, cTEXTO )
      FCLOSE( NOUP )
      IF "\" $ ARQUIVO
         ERASE (ARQUIVO)
         COPY FILE EDNAFREN.TXT TO (ARQUIVO)
      ELSE
         ERASE (ARQUIVO)
         RENAME EDNAFREN.TXT TO (ARQUIVO)
      ENDIF
      SETCOLOR("W/N,W/N,,,W/N")
      CLS
      RESTORE SCREEN
      RETURN NIL  
   ENDIF
// DESENHA UMA SOMBRA PARA A JANELA

FUNCTION SOMBRAR( LI,CI,LF,CF )

PRIVATE C1

@ LF+1, CI+2 SAY REPLICATE( " ", CF-CI )
FOR L1 = LI+1 TO LF+1
    @ L1,CF+1 SAY "  "
NEXT

RETURN NIL

**********************
STATIC FUNCTION TOINS
**********************
   SET KEY K_INS TO
   COR_VI := SETCOLOR()
   SETCOLOR("N/GR")
   READINSERT(!READINSERT())
   SETCURSOR(IF (READINSERT(), 3, 1))
   SETCOLOR( COR_VI )
   SET KEY K_INS TO TOINS
   RETURN NIL

*********************
STATIC FUNCTION AJUDA
*********************
SET KEY K_F1 TO
IF EMPTY( HELPFILE )
   LEI   := ROW()
   COU   := COL()
   SCOR  := SETCOLOR()
   STELA := SAVESCREEN()
   SETCOLOR("GR+/R")
   @ 02,24,14,78 BOX B_DOUBLE+CHR(32)
   @ 03,78 SAY CHR(24)
   LI := 04
   FOR I = 4 TO 12
      @ LI,78 SAY CHR(176)
      LI += 1
   NEXT
   @ 13,78 SAY CHR(25)
   @ 08,36 SAY "ARQUIVO AJUDA.HLP n„o encontrado!"
   INKEY(0)
   SET KEY K_F1 TO AJUDA
   RESTSCREEN( ,,,,STELA )
   SETCOLOR( SCOR )
   SETPOS( LEI,COU )
   RETURN NIL
ENDIF
HTEXT := HELPTEXT( HELPFILE )
SET KEY K_ENTER TO RETUFALSE
SETCURSOR( 0 )
LEI   := ROW()
COU   := COL()
SCOR  := SETCOLOR()
STELA := SAVESCREEN()
SETCURF := SETCURSOR()
SETCOLOR("GR+/R")
@ 02,24,14,78 BOX B_DOUBLE+CHR(32)
@ 03,78 SAY CHR(24)
LI := 04
FOR I = 4 TO 12
   @ LI,78 SAY CHR(176)
   LI += 1
NEXT
@ 13,78 SAY CHR(25)
MEMOEDIT( HTEXT,03,26,13,77,.F. )
SETPOS( LEI,COU )
SETCURSOR( SETCURF )
RESTSCREEN( ,,,,STELA )
SETCOLOR( SCOR )
SET KEY K_F1 TO AJUDA
SET KEY K_ENTER TO
RETURN NIL

*************************
STATIC FUNCTION RETUFALSE
*************************
RETURN ( .F. )

*******************
STATIC FUNCTION DOS
*******************
STELA2 := SAVESCREEN()
SCOR2 := SETCOLOR()
SCURS := SETCURSOR()
LIN := ROW()
COH := COL()
SETCOLOR("W+/N")
EXPLOD( 10,38,11,40,00,00,24,79,LINHA,0,0.015 )
SET CURSOR ON
@ 00,00 SAY 'Digite "Exit" Para voltar ao EDNAFREN'
?
RUN \COMMAND
EXPLOD( 10,38,11,40,00,00,24,79,LINHA,0,0.015 )
SETCOLOR( SCOR2 )
SETCURSOR( SCURS )
RESTSCREEN( ,,,,STELA2 )
SETPOS( LIN,COH )
RETURN NIL

****************************************
STATIC FUNCTION ESCLEN( LI,CI,TEXT,SEC )
****************************************
PRIVATE NCT
FOR NCT = 1 TO LEN( TEXT )
   @ LI,CI-1+NCT SAY SUBS( TEXT,NCT,1 )
   INKEY( SEC )
NEXT
RETURN NIL

**************************
FUNCTION GETDBF( ARQFILE )
**************************
LOCAL cPath := GETENV( "PATH" )
LOCAL nPos  := 1

WHILE ( nPos != 0 )

   nPos := AT( ";",cPath )

   IF ( SUBS( cPath, nPos - 1, 1 ) == "\" )
      cFile := SUBS( cPath,1, IIF( nPos == 0,LEN( cPath ), nPos - 1 ) )+ARQFILE
   ELSE
      cFile := SUBS( cPath,1, IIF( nPos == 0,LEN( cPath ), nPos - 1 ) )+"\"+ARQFILE
   ENDIF

   IF FILE( cFile )
      EXIT
   ENDIF

   IF ( nPos == 0 )
      cFile := ""
   ELSE
      cPath := SUBS( cPath, nPos + 1 )
   ENDIF
END
RETURN ( cFile )

FUNCTION helptext

PARAMETERS hfile
PRIVATE htbuf, hoff, hhandle

* open the file and get handle
hhandle = FOPEN(M->hfile)
hoff    = DIRECTORY( hfile, "D" )

IF FERROR() = 0
	* allocate 512 byte buffer
        htbuf = SPACE( hoff[1][2] )

	* read the file header into memory
        FREAD( M->hhandle, @htbuf, hoff[1][2] ) 
ENDIF

* close the file and release the handle
FCLOSE(M->hhandle)
RETURN M->htbuf
