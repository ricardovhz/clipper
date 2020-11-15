#INCLUDE "BOX.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "ACHOICE.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "MEMOEDIT.CH"

PUBLIC NVALOR2, NDRIVE, NDIRES, NVALOR3, NCAG, NITEM, NROW, NBITEM2, NBOW2, BAIA, NARQS,;
       NVALOR5, CARAMBA, NBIXA, NVILIR, NVALAR, NPARA, NBABA, NBIBI, NPERE, CHIU,NCD

SET KEY K_F1 TO AJUDA
SET KEY K_F10 TO RUNDOS
SET SCOREBOARD OFF
SET CONFIRM ON
SETCOLOR( "W+/B,N/W,B" )
CLS
NCAG := ""
CHIU := .F.
NPERE := {}
NVILIR := 0
NARQS := {}
NPARA := 0
NBABA := 0
NBIBI := 0
NVALOR2 := 0
NVALOR0 := 6
NVALOR5 := 0
NBIXA := 0
BAIA := 0
NCD := 1
WHILE .T.
   @ 00,00,04,79 BOX B_DOUBLE+CHR( 32 )
   @ 02,00 SAY "ฬ"+REPLICATE( "อ",78 )+"น"
   MUDCOR( 01,03,"REXPLOER","GR+/B" )
   @ 01,12 SAY "- Programa explorador de arquivos - Ver. 1.0 - Ricardo V. Ribeiro"
   @ 03,04 SAY "Teclas: ESC = Saกda, F1 = Ajuda, CTRL-ENTER = Lista Arquivos Execut veis"
   SETCOLOR( "W+/BG,GR+/R,B" )
   FOR I = NVALOR0 TO 17
      @ I,08 SAY "บ                 บ                     บ                    บ"
   NEXT
   @ 05,08 SAY "ษอออออออออออออออออหอออออออออออออออออออออหออออออออออออออออออออป"
   @ 06,08 SAY "บ  Nome do drive  บ  Nome do diretขrio  บ  Nome do arquivo   บ"
   @ 07,08 SAY "ฬอออออออออออออออออฮอออออออออออออออออออออฮออออออออออออออออออออน"
   @ 18,08 SAY "ศอออออออออออออออออสอออออออออออออออออออออสออออออออออออออออออออผ"
   @ 20,00,24,79 BOX B_DOUBLE+CHR(32)
   @ 22,00 SAY "ฬ"+REPLICATE( "อ",78 )+"น"
   @ 22,39 SAY "ห"
   @ 23,39 SAY "บ"
   @ 24,39 SAY "ส"
   @ 23,18 SAY "Bytes Livres"
   MUDCOR( 23,02,TRANSFORM( DISKSPACE(),"@E 999,999,999,999" ),"GR+/BG" )
   @ 21,02 SAY "DIRETเRIO DE"
   NCOISO20 := CFUNCTION()
   EXIT
END
SET KEY K_F1 TO
SETCOLOR("W/N,W/N,N,W/N")
CLS
QUIT
   
********************
FUNCTION CFUNCTION()
********************
NDRIVE := SPACE( 02 )
WHILE .T.
   NDRIVE := PED( NDRIVE,2 )
   SETCOLOR( "GR+/R" )
   SETCURSOR( 0 )
   @ 09,17 SAY PED( NDRIVE,2 )
   NKEYPAD := INKEY(0)
   DO CASE
      CASE NKEYPAD = K_ENTER
         NVALOR := 0
      CASE NKEYPAD = K_UP .OR. NKEYPAD = K_DOWN .OR. NKEYPAD = K_LEFT
         NVALOR := 1
      CASE NKEYPAD = K_RIGHT
         IF NVALOR2 = 1
            SETCOLOR("W+/BG")
            @ 09,17 SAY PED( NDRIVE,2 )
            CDIREC()
            LOOP
         ELSE
            NVALOR := 1
         ENDIF
      CASE NKEYPAD = K_ESC
         EXIT
      CASE NKEYPAD = K_F1
         AJUDA()
         NVALOR := 1
      CASE NKEYPAD = K_F10
         RUNDOS()
         NVALOR := 1
      CASE NKEYPAD >= 65 .AND. NKEYPAD <= 122
         KEYBOARD CHR( NKEYPAD )
         NVALOR := 0
      OTHERWISE
         NVALOR := 1
   ENDCASE
   IF NVALOR = 1
      NVALOR3 := 3
      LOOP
   ENDIF
   SET KEY K_INS TO UNSERT
   SETCURSOR( 1 )
   @ 09,17 GET NDRIVE PICTURE "@!"
   READ
   SET KEY K_INS TO
   IF LASTKEY() == K_ESC
      CLEAR GETS
      LOOP
   ENDIF
   SETCOLOR("W+/BG")
   @ 09,33 CLEAR TO 17,42
   @ 09,54 CLEAR TO 17,66
   @ 21,02 SAY "DIRETขRIO DE "
   NDRIVE := IIF( ":" $ NDRIVE,NDRIVE,ALLTRIM( NDRIVE )+":" )
   IF EMPTY( DIRECTORY( ALLTRIM( NDRIVE )+"\","D" ) )
      @ 09,54 SAY "< Nenhum >"
      @ 09,33 SAY "< Nenhum >  "
      NVALOR2 := 0
      LOOP
   ENDIF
   IF !"C" $ NDRIVE
      NSAVE := SETCOLOR()
      SETCOLOR( "GR+/BG" )
      @ 23,02 SAY TRANS( DISKSPACE( ASC( SUBS( NDRIVE,1,1 ) ) - 64 ),"@E 999,999,999,999" )
      SETCOLOR( NSAVE )
   ENDIF
   MUDCOR( 21,15,IIF( ":" $ NDRIVE,NDRIVE,ALLTRIM( NDRIVE )+":" )+"\","GR+/BG" )
   NCAG := IIF( ":" $ NDRIVE,NDRIVE,ALLTRIM( NDRIVE )+":" )+"\"
   NPARA := 0
   NVALAR := 0
   NVILIR := 0
   NITEM := 1
   NROW := 5
   NBITEM2 := 1
   NBOW2 := 5
   IIF( ":" $ NDRIVE,NDRIVE,ALLTRIM( NDRIVE )+":" )
   @ 09,17 SAY PED( IIF( ":" $ NDRIVE,NDRIVE,ALLTRIM( NDRIVE )+":" ),2 )
   CDIREC()
END
RETURN

*****************
FUNCTION CDIREC()
*****************
NCAG := NCAG
WHILE .T.
   NDIRES := DIRECTORY( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*","D" )
   DECLARE EARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
   ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" ),EARQS )
   @ 23,41 SAY SPACE( 21 )
   CAR := 1
   NCHOR := {}
   NVALOR4 := 0
   NCAMP2 := 1
   CARAMBA := 0
   IF !EMPTY( NDIRES )
      NBYE := NDIRES[ NCAMP2 ][5]
      WHILE .T.
         IF CAR > LEN( NDIRES )
            IF EMPTY( NCHOR )
               NVALOR4 := 1
               EXIT
            ELSE
               EXIT
            ENDIF
         ENDIF
         NBYE := NDIRES[ NCAMP2 ][ 5 ]
         IF NBYE = "D" .OR. NBYE = "RD"
            AADD( NCHOR, NDIRES[ NCAMP2 ][ 1 ] )
         ENDIF
         CAR += 1
         NCAMP2 += 1
      END
   ENDIF
   IF EMPTY( EARQS )
      CARAMBA := 1
      @ 09,54 SAY "< Nenhum >  "
   ELSEIF NPARA = 0
      IF LEN( EARQS ) > 9
         NG := 9
      ELSE
         NG := LEN( EARQS )
      ENDIF
      NARRAY := 1
      FOR IR = 01 TO NG
         @ NARRAY+08,54 SAY EARQS[ NARRAY ]
         NARRAY += 1
      NEXT
      BAIA := 1
   ENDIF
   IF EMPTY( NCHOR )
      @ 09,33 SAY "< Nenhum >"
      IF CARAMBA = 1
         NVALOR2 := 0
         RETURN
      ENDIF
      NCOR := CARQS()
      IF NCOR = 1
         @ 09,33 CLEAR TO 17,42
         @ 09,54 CLEAR TO 17,66
         RETURN
      ENDIF
   ENDIF
   NBOR := ACHOICE( 09,33,17,42,NCHOR,.T.,"CACH",NITEM,NROW )
   IF EMPTY( NCHOR )
      IF EMPTY( NARQS )
         LOOP
      ENDIF
   ENDIF
   IF NBIXA = 1
      @ 09,33 CLEAR TO 17,42
      @ 09,54 CLEAR TO 17,66
      NDRIVE := "  "
      @ 21,02 SAY "DIRETเRIO DE"+SPACE( 65 )
      NBIXA := 0
      NVALOR2 := 0
      RETURN
   ENDIF
   IF NBABA = 1
      NBABA := 0
      LOOP
   ENDIF
   IF LASTKEY()==K_LEFT
      NVALOR2 := 1
      RETURN
   ENDIF
   IF LASTKEY()==K_ESC
      @ 09,33 CLEAR TO 17,42
      @ 09,54 CLEAR TO 17,66
      @ 21,02 SAY "DIRETเRIO DE"+SPACE( 65 )
      NDRIVE := SPACE( 2 )
      NITEM := 1
      NROW := 5
      NBITEM2 := 1
      NBOW2 := 5
      NVALOR2 := 0
      RETURN
   ENDIF
   IF NCHOR[ NBOR ] = "." .OR. NCHOR[ NBOR ] = ".."
      NPOS := RAT( "\",NCAG )
      NCAG := SUBS( NCAG,1,NPOS-1 )
   ELSE
      NCAG := NCAG+IIF( NVILIR = 0,"","\" )+NCHOR[ NBOR ]
   ENDIF
   @ 09,33 CLEAR TO 17,42
   @ 09,54 CLEAR TO 17,66
   @ 21,02 SAY "DIRETเRIO DE "
   MUDCOR( 21,15,NCAG+"\"+SPACE( 76 - ( 13 + LEN( NCAG ) ) ),"GR+/BG" )
   NVALAR := 1
   NVILIR := 1
   NITEM := 1
   NPARA := 0
   NROW := 4
   NBITEM2 := 1
   NBOW2 := 09
   LOOP
END

****************
FUNCTION CARQS()
****************
BIUR := 0
NBIBI := 0
DECLARE SARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" ),SARQS )
NARQS := SARQS
WHILE .T.
   DECLARE BARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
   ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*",BARQS )
   NPERE := DIRECTORY( IIF( NVILIR = 0,NCAG,NCAG+"\" )+BARQS[ IIF( NVALAR = 0,1,NBITEM2 ) ] )
   MUDCOR( 23,41,TRANSFORM( NPERE[ 1 ][ 2 ], "@E 999,999,999,999" ),"GR+/BG" )
   @ 23,57 SAY "Bytes"
   @ 09,54 CLEAR TO 17,66
   NXOR := ACHOICE( 09,54,17,66,NARQS,.T.,"VARQS",NBITEM2,NBOW2 )
   NVALAR := 1
   IF NBIBI = 1
      DECLARE SARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
      ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" ),SARQS )
      NARQS := SARQS
      @ 10,54 CLEAR TO 17,66
      IF EMPTY( NARQS )
         @ 09,54 SAY "< Nenhum >  "
         @ 23,49 SAY SPACE( 30 )
         CARAMBA := 1
         EXIT
      ENDIF
      NBIBI := 0
      IF NBITEM2 = 1
         NBITEM2 := 1
      ELSE
         NBITEM2 -= 1
      ENDIF
      LOOP
   ENDIF
   IF LASTKEY()==K_LEFT
      @ 23,41 SAY SPACE( 22 )
      NBIC := "R"
      EXIT
   ENDIF
   IF LASTKEY()==K_ESC
      @ 23,49 SAY SPACE( 30 )
      NITEM := 1
      NROW := 5
      NBITEM2 := 1
      NBOW2 := 5
      BIUR := 1
      NBIC := "R"
      EXIT
   ENDIF
   NSOR := NCAG+IIF( NVILIR = 0, "","\" )+NARQS[ NXOR ]
   NVOR := NCAG+IIF( NVILIR = 0, "","\" )
   IF ".EXE" $ NSOR .OR. ".COM" $ NSOR .OR. ".BAT" $ NSOR
      IF ".BAT" $ NSOR
         NELIGA := MEMOREAD( NCAG+IIF( NVILIR = 0,"","\" )+NARQS[ NXOR ] )
         FOR L = 1 TO MLCOUNT( NELIGA,254 )
            CLINHAS := MEMOLINE( NELIGA,254,L )
            IF "%1" $ CLINHAS
               NSAVE := SETCOLOR()
               SAVE SCREEN TO NTELA
               NCURS := SETCURSOR()
               SETCOLOR( "B/W,W/B,,,N/W" )
               @ 04,05,07,65 BOX B_DOUBLE+CHR( 32 )
               @ 05,07 SAY "Escreva um parmetro"
               SETCURSOR( 1 )
               SET KEY K_INS TO UNSERT
               NPAR := SPACE( 100 )
               @ 06,07 GET NPAR PICTURE "@K!S56"
               READ
               IF LASTKEY() = K_ESC
                  SETCOLOR( NSAVE )
                  RESTORE SCREEN FROM NTELA
                  SETCURSOR( NCURS )
                  EXIT
               ENDIF
               IF !EMPTY( ALLTRIM( NPAR ) )
                  NSOR := NSOR+" "+NPAR
                  SETCOLOR( NSAVE )
                  RESTORE SCREEN FROM NTELA
                  SETCURSOR( NCURS )
                  EXIT
               ENDIF
            ENDIF
         NEXT
      ENDIF
      SAVE SCREEN
      SETCOLOR( "W+/B" )
      CLS
      RUN (NSOR)
      SETCOLOR( "W+/BG" )
      RESTORE SCREEN
      SETCURSOR( 0 )
   ELSE
      SAVE SCREEN
      SETCOLOR( "B/W" )
      @ 04,10 TO 21,68 DOUBLE
      MUDCOR( 04,( ( 80 - ( LEN( NSOR )+2 ) ) / 2 )," "+NSOR+" ","GR+/R" )
      NHANDLE := FCREATE( NVOR+"WWWQA.DCV",FC_NORMAL )
      NMEMO := MEMOREAD( NSOR )
      SET KEY K_INS TO INSERT
      IF READINSERT()
         SETCURSOR( 3 )
         @ 21,54 SAY "<Insert>"
      ELSE
         SETCURSOR( 1 )
      ENDIF
      CHIU := .F.
      SET KEY K_CTRL_P TO IMPRIME
      NTEXTO := MEMOEDIT( NMEMO,05,11,20,67,.T.,"MEMOS",5553 )
      SET KEY K_CTRL_P TO
      IF LASTKEY() == K_ESC
         SETCOLOR( "W+/BG" )
         RESTORE SCREEN
         FCLOSE( NHANDLE )
         ERASE ( NVOR+"WWWQA.DCV" )
         SET KEY K_INS TO
         SETCURSOR( 0 )
      ELSE
         FWRITE( NHANDLE, NTEXTO )
         FCLOSE( NHANDLE )
         COPY FILE ( NVOR+"WWWQA.DCV" ) TO ( NSOR )
         ERASE ( NVOR+"WWWQA.DCV" )
         SETCOLOR( "W+/BG" )
         SET KEY K_INS TO
         SETCURSOR( 0 )
         RESTORE SCREEN
      ENDIF
   ENDIF
END
RETURN BIUR
      
**********************************
FUNCTION CACH( NMODE,NBITEM,NBOW )
**********************************
LOCAL NRETVAL := AC_CONT
LOCAL NKEY := LASTKEY()
NITEM := NBITEM
NROW := NBOW

DO CASE
   CASE NMODE = AC_NOITEM
      NCD := 0
      NRETVAL := AC_ABORT
   CASE NMODE = AC_EXCEPT
      IF NKEY = K_ESC
         NRETVAL := AC_ABORT
      ENDIF
      IF NKEY = K_ENTER
         NRETVAL := AC_SELECT
      ENDIF
      IF NKEY = K_RIGHT
         IF CARAMBA = 0
            NPARA := 1
            NCOISO := CARQS()
            IF NCOISO = 1
               NBIXA := 1
               NRETVAL := AC_ABORT
            ENDIF
         ENDIF
      ENDIF
      IF NKEY = K_LEFT
         NRETVAL := AC_ABORT
      ENDIF
ENDCASE
RETURN NRETVAL   

**************************************
FUNCTION VARQS( NMODE, NITEM2, NROW2 )
**************************************
LOCAL NRETVAL := AC_CONT
LOCAL NKEY := LASTKEY()
NBITEM2 := NITEM2
NBOW2 := NROW2
IF NKEY = K_ESC .OR. NKEY = K_LEFT
   @ 00,00 SAY ""
ELSE
   DECLARE BARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
   ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*",BARQS )
   NPERE := DIRECTORY( IIF( NVILIR = 0,NCAG,NCAG+"\" )+BARQS[ NITEM2 ],"D" )
   MUDCOR( 23,41,TRANSFORM( NPERE[ 1 ][ 2 ], "@E 999,999,999,999" ), "GR+/BG" )
ENDIF

DO CASE
   CASE NMODE = AC_EXCEPT
      IF NKEY = K_ESC
         NRETVAL := AC_ABORT
      ENDIF
      IF NKEY = K_ENTER
         NRETVAL := AC_SELECT
      ENDIF
      IF NKEY = K_CTRL_ENTER
         LEXE( IIF( NVILIR = 0,NCAG,NCAG+"\" )+NPERE[ 1 ][ 1 ] )
      ENDIF
      IF NKEY = K_LEFT
         NRETVAL := AC_ABORT
      ENDIF
      IF NKEY = K_DEL
         NCAGO := DELETA( "RICARDO",IIF( NVILIR = 0,NCAG,NCAG+"\" )+NPERE[ 1 ][ 1 ] )
         IF NCAGO = 1
            NBIBI := 1
            NBITEM2 -= 1
            NRETVAL := AC_ABORT
         ENDIF
      ENDIF
ENDCASE
RETURN NRETVAL   


************************
FUNCTION PED( NLETR,SP )
************************
RETURN SUBS( NLETR+SPACE( SP ),1,SP )

***********************************************
FUNCTION MUDCOR( NLINHA, NCOLUNA, TEXTO, NCOR )
***********************************************
LOCAL SAVECOR := SETCOLOR()
SETCOLOR( NCOR )
@ NLINHA,NCOLUNA SAY TEXTO
SETCOLOR( SAVECOR )
RETURN

****************
FUNCTION AJUDA()
****************
SAVECURSOR := SETCURSOR()
SAVELINA := ROW()
SAVECOLA := COL()
SETCURSOR( 0 )
SET KEY K_F1 TO
SAVECOLOR := SETCOLOR()
NSAVE := SAVESCREEN( 00,00,24,79 )
SETCOLOR( "W+/R" )
@ 05,20,15,60 BOX B_DOUBLE+CHR( 32 )
MUDCOR( 05,( ( 80 - 13 ) /2 )," "+"Informaไes"+" ","R/W" )
IF !FILE( "REXPLOER.HLP" )
   @ 08,22 SAY "Arquivo REXPLOER.HLP nฦo encontrado."
   INKEY(0)
   @ 08,22 SAY SPACE( 35 )
   SETCOLOR( SAVECOLOR )
   RESTSCREEN( ,,,,NSAVE )
   RETURN
ENDIF
NMEMO := MEMOREAD( "REXPLOER.HLP" )
MEMOEDIT( NMEMO,06,21,14,59,.F. )
SETCOLOR( SAVECOLOR )
SETCURSOR( SAVECURSOR )
RESTSCREEN( ,,,,NSAVE )
SETPOS( SAVELINA,SAVECOLA )
SET KEY K_F1 TO AJUDA
RETURN

*************************
FUNCTION LEXE( NARQUIVO )
*************************
SETCURSOR( 0 )
SAVECOLOR := SETCOLOR()
NSAVO := SAVESCREEN( 00,00,24,79 )
SETCOLOR( "B/W" )
NXOR := RAT( "\",NARQUIVO )
NVOR := SUBS( NARQUIVO,1,NXOR )
@ 04,10,21,68 BOX B_DOUBLE+CHR( 32 )
MUDCOR( 04,( ( 80 - ( LEN( NARQUIVO )+2 ) ) / 2 )," "+NARQUIVO+" ","GR+/R" )
NHANDLE := FCREATE( NVOR+"WWWQA.DCV",FC_NORMAL )
NMEMO := MEMOREAD( NARQUIVO )
SET KEY K_INS TO INSERT
IF READINSERT()
   SETCURSOR( 3 )
   @ 21,54 SAY "<Insert>"
ELSE
   SETCURSOR( 1 )
ENDIF
CHIU := .F.
SET KEY K_CTRL_P TO IMPRIME
NTEXTO := MEMOEDIT( NMEMO,05,11,20,67,.T.,"MEMOS",5553 )
SET KEY K_CTRL_P TO
IF LASTKEY() == K_ESC
   SETCOLOR( "W+/BG" )
   RESTORE SCREEN
   FCLOSE( NHANDLE )
   ERASE ( NVOR+"WWWQA.DCV" )
   SET KEY K_INS TO
   SETCURSOR( 0 )
ELSE
   FWRITE( NHANDLE, NTEXTO )
   FCLOSE( NHANDLE )
   COPY FILE ( NVOR+"WWWQA.DCV" ) TO ( NARQUIVO )
   ERASE ( NVOR+"WWWQA.DCV" )
   SETCOLOR( "W+/BG" )
   SET KEY K_INS TO
   SETCURSOR( 0 )
   RESTORE SCREEN
ENDIF
SETCOLOR( SAVECOLOR )
RESTSCREEN( ,,,,NSAVO )
RETURN

***************************
FUNCTION DELETA( TIPO,NEI )
***************************
DECLARE BARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*",BARQS )
NOPTIONS := { "Ok","Cancela" }
SAVE SCREEN
NCHOICE := ALERT( "Tem certeza de deletar?",NOPTIONS )
IF NCHOICE = 1
   ERASE (NEI)
   NBUR := 1
ELSE
   NBUR := 0
ENDIF
RESTORE SCREEN
RETURN NBUR

*****************
FUNCTION INSERT()
*****************
LIN = ROW()
CYL = COL()   
SET KEY K_INS TO
READINSERT( !READINSERT() )
MUDCOR( 21,54,IIF( READINSERT(),"<Insert>","ออออออออ" ),"B/W" )
IF READINSERT()
   SETCURSOR( 3 )
ENDIF
IF !READINSERT()
   SETCURSOR( 1 )
ENDIF   
SET KEY K_INS TO INSERT
SETCOLOR( "B/W" )
SETPOS( LIN,CYL )
RETURN (0)

*****************
FUNCTION UNSERT()
*****************
LIN = ROW()
CYL = COL()
NCOLOR := SETCOLOR()
SETCOLOR( "W+/BG" )
SET KEY K_INS TO
READINSERT( !READINSERT() )
MUDCOR( 18,54,IIF( READINSERT(),"<Insert>","อออออออออ" ),"W+/BG" )
IF READINSERT()
   SETCURSOR( 3 )
ELSE
   SETCURSOR( 1 )
ENDIF
SETCOLOR( NCOLOR )
SET KEY K_INS TO UNSERT
SETPOS( LIN,CYL )
RETURN (0)

*********************************
FUNCTION MEMOS( NMODE,NLIN,NCOL )
*********************************
NSAVE := SETCOLOR()
NROW := NLIN
NCUL := NCOL
NRETVIL := ME_DEFAULT
SETCOLOR( "B/W" )
@ 21,12 SAY "L "+ALLTRIM( STR( NLIN ) )+"     "
@ 21,20 SAY "C "+ALLTRIM( STR( NCOL+1 ) )+"ออออออ"
DO CASE
   CASE NMODE = ME_UNKEY
      IF LASTKEY() == K_ESC
         NRETVIL := ME_DEFAULT
      ENDIF
      IF LASTKEY() == K_CTRL_W
         NRETVIL := ME_DEFAULT
      ENDIF
   CASE NMODE = ME_UNKEYX
      IF LASTKEY() == K_CTRL_W
         NOP := { "Ok","Nฦo","Cancela" }
         NCHICE := ALERT( "Deseja Salvar?",NOP )
         IF NCHICE = 1
            NRETVIL := ME_DEFAULT
            CHIU := .F.
         ENDIF
         IF NCHICE = 2
            KEYBOARD CHR( K_ESC )
            CHIU := .T.
            NRETVIL := ME_IGNORE
         ENDIF
         IF NCHICE = 3
            CHIU := .F.
            NRETVIL := ME_IGNORE
         ENDIF
      ELSEIF LASTKEY() == K_ESC
         IF CHIU
            NRETVIL := ME_DEFAULT
         ELSE
            NOP := { "Sim","Nฦo" }
            NCHICE := ALERT( "Sair Do Editor Sem Salvar?",NOP )
            IF NCHICE = 1
               NRETVIL := ME_DEFAULT
            ENDIF
            IF NCHICE = 2
               NRETVIL := ME_IGNORE
               CHIU := .F.
            ENDIF
            IF NCHICE = 3
               NRETVIL := ME_IGNORE
               CHIU := .F.
            ENDIF
         ENDIF
      ENDIF
ENDCASE
SETCOLOR( NSAVE )
RETURN NRETVIL

*****************
FUNCTION RUNDOS()
*****************
SAVETULA := SAVESCREEN( 00,00,24,79 )
SAVECULOR := SETCOLOR()
SAVECURS := SETCURSOR()
SAVELIN := ROW()
SAVECO := COL()
SETCOLOR( "W/N,W/N,N,W/N" )
CLS
SETCURSOR( 1 )
RUN \COMMAND
SETCOLOR( SAVECULOR )
SETCURSOR( SAVECURS )
CLS
RESTSCREEN( ,,,,SAVETULA )
SETPOS( SAVELIN,SAVECO )
RETURN

****************
FUNCTION IMPRIME
****************
DECLARE BARQS[ ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*" ) ]
ADIR( IIF( NVILIR = 0,NCAG,NCAG+"\" )+"*.*",BARQS )
NOTPRIN := .T.
NAP := { "Ok","Cancela" }
NOUTPUT := MEMOREAD( BARQS[ NBITEM2 ] )
CLINHAS := MEMOLINE( NOUTPUT, 254, 1 )
WHILE !ISPRINTER()
   NCHAICE := ALERT( "Ligue a impressora!",NAP )
   IF NCHAICE = 1
      NOTPRIN := .F.
   ELSE
      RETURN
   ENDIF
END
IF NOTPRIN
   NCHAICE := ALERT( "Tem certeza de imprimir?",NAP )
   IF NCHAICE = 2
      RETURN
   ENDIF
ENDIF
CLEAR TYPEAHEAD
SET DEVICE TO PRINTER
SETPRC(00,00)
NOUTPUT := MEMOREAD( BARQS[ NBITEM2 ] )
NLINHAS := MLCOUNT( NOUTPUT, 254 )
FOR NCURRLIN = 1 TO NLINHAS
   CLINHAS := MEMOLINE( NOUTPUT, 254, NCURRLIN )
   @ NCURRLIN-1,00 SAY CLINHAS
NEXT
SET DEVICE TO SCREEN
CLEAR ALL
CLEAR TYPEAHEAD
RETURN NIL
