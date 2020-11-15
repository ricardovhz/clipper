#INCLUDE "BOX.CH"
#INCLUDE "INKEY.CH"
FUNCTION EXERIC( NARQ )
PUBLIC I,CLINHAS
SET SCOREBOARD OFF
SET KEY K_ALT_X TO CANCELAR
IF EMPTY( NARQ )
   RETURN NIL
ENDIF
CLINHAS := ""
NOP   := { "Sair" }
CAMPOS := {}
VALORS := {}
NMEMO := MEMOREAD( NARQ+IIF( ".RIC" $ NARQ,"",".RIC" ) )
NLINHAS := MLCOUNT( NMEMO,254 )
IF .NOT. "COMECA" $ MEMOLINE( NMEMO,254,1 )
   ? "Este arquivo nao pode executar o "+NARQ+IIF( ".RIC" $ NARQ,"",".RIC" )+;
     ". Este arquivo nao e .RIC."
   ? "Cancelando..."
   RETURN NIL
ENDIF
FOR I = 2 TO NLINHAS
   CLINHAS := MEMOLINE( NMEMO,254,I )
   DO CASE
   CASE LASTKEY() = K_ALT_X
      ? "Cancelando na linha "+ALLTRIM( STR( I-1 ) )
      RETURN NIL
   CASE "CLS COLOR" $ UPPER( CLINHAS )
      NPOS := AT( '"',CLINHAS )
      IF NPOS = 0
         NCOLOR := "W/N,W/N,N,W/N"
      ELSE
         NCOLOR := SUBS( CLINHAS,NPOS )
      ENDIF
      SETCOLOR( NCOLOR )
      CLS
   CASE "SELECT COLOR" $ UPPER( CLINHAS )
      NPOS := AT( '"',CLINHAS )
      IF NPOS = 0
         NCOLOR := "W/N,N/W,N,W/N"
      ELSE
         NCOLOR := SUBS( CLINHAS,NPOS )
      ENDIF
      SETCOLOR( NCOLOR )
   CASE "@" $ CLINHAS
      POS   := AT( "@",CLINHAS )
      LINHA := SUBS( ALLTRIM( CLINHAS ),POS+2,7)
      IF "ESCREVA" $ UPPER( LINHA )
         NPOS := AT( ',',CLINHAS )
         IF NPOS = 0
            ALERT( "Erro. Argumento incompleto",nOp )
            @ 24,00 SAY "Erro na linha "+STR ( I )
            RETURN NIL
         ELSE
            CSUBS := SUBS( ALLTRIM( CLINHAS ),NPOS+4 )
            CPOS  := AT( '"',CLINHAS )
            IF CPOS = 0
               VPOS := ASCAN( CAMPOS,CSUBS )
               CHOR := 1
               FOR L = 1 TO LEN( CAMPOS )
                  IF EMPTY( CAMPOS )
                     EXIT
                  ENDIF
                  IF CAMPOS[ L ] = CSUBS
                     CHOR := 0
                     EXIT
                  ENDIF
               NEXT
               IF CHOR = 1
                  ALERT( "Erro. Variavel n∆o existente: "+CSUBS,nOp )
                  @ 24,00 SAY "Erro na linha "+STR( I )
                  RETURN NIL
               ENDIF
               CSUBS := VALORS[ VPOS ]
               BPOS := AT( '"',CSUBS )
               IF BPOS = 0
                  CSUBS := '"'+CSUBS+'"'
               ENDIF
            ENDIF
            NLINH1 := VAL( SUBS( CLINHAS,NPOS-2,2 ) )-1
            NCOLU2 := VAL( SUBS( CLINHAS,NPOS+1,2 ) )-1
            @ NLINH1,NCOLU2 SAY &CSUBS
         ENDIF
      ENDIF
      IF "BOX" $ UPPER( LINHA )
         NPOS := AT( ",",CLINHAS )-2
         IF NPOS = 0
            ALERT( "Erro. Argumento incompleto",nOp )
            @ 24,00 SAY "Erro na linha "+STR( I )
            RETURN NIL
         ELSE
            IF "DOUBLE" $ SUBS( CLINHAS,RAT( ",",CLINHAS )+1 )
               NTIPO := '"'+B_DOUBLE+CHR( 32 )+'"'
            ELSEIF "SINGLE" $ SUBS( CLINHAS,RAT( ",",CLINHAS )+1 )
               NTIPO := '"'+B_SINGLE+CHR( 32 )+'"'
            ELSEIF "DOUBLE_SINGLE" $ SUBS( CLINHAS,RAT( ",",CLINHAS )+1 )
               NTIPO := '"'+B_DOUBLE_SINGLE+CHR( 32 )+'"'
            ELSEIF "SINGLE_DOUBLE" $ SUBS( CLINHAS,RAT( ",",CLINHAS )+1 )
               NTIPO := '"'+B_SINGLE_DOUBLE+CHR( 32 )+'"'
            ELSE
               NTIPO := SUBS( ALLTRIM( CLINHAS ),RAT( ",",CLINHAS )+1 )
               CPOS  := AT( '"',CLINHAS )
               IF CPOS = 0
                  VPOS := ASCAN( CAMPOS,NTIPO )
                  CHOR := 1
                  FOR L = 1 TO LEN( CAMPOS )
                     IF EMPTY( CAMPOS )
                        EXIT
                     ENDIF
                     IF CAMPOS[ L ] = NTIPO
                        CHOR := 0
                     ENDIF
                  NEXT
                  IF CHOR = 1
                     ALERT( "Erro. Variavel n∆o existente: "+NTIPO,nOp )
                     @ 24,00 SAY "Erro na linha "+STR( I )
                     RETURN NIL
                  ENDIF
                  NTIPO := VALORS[ VPOS ]
               ELSE
                  NTIPO := SUBS( ALLTRIM( CLINHAS ),RAT( ",",CLINHAS )+1 )
               ENDIF
            ENDIF
            NLIN1 := VAL( SUBS( CLINHAS,NPOS,2 ) )-1
            NCOL1 := VAL( SUBS( CLINHAS,NPOS+3,2 ) )-1
            NLIN2 := VAL( SUBS( CLINHAS,NPOS+6,2 ) )-1
            NCOL2 := VAL( SUBS( CLINHAS,NPOS+9,2 ) )-1
            @ NLIN1,NCOL1,NLIN2,NCOL2 BOX &NTIPO
         ENDIF
      ENDIF
      IF "PROMPT" $ UPPER( LINHA )
         NPOS := AT( ",",CLINHAS )
         IF NPOS = 0
            ALERT( "Erro. Argumento incompleto",nOp )
            @ 24,00 SAY "Erro na linha "+STR( I )
            RETURN NIL
         ELSE
            CSUBS := SUBS( ALLTRIM( CLINHAS ),NPOS+4 )
            CPOS  := AT( '"',CLINHAS )
            IF CPOS = 0
               VPOS := ASCAN( CAMPOS,CSUBS )
               CHOR := 1
               FOR L = 1 TO LEN( CAMPOS )
                  IF EMPTY( CAMPOS )
                     EXIT
                  ENDIF
                  IF CAMPOS[ L ] = CSUBS
                     CHOR := 0
                  ENDIF
               NEXT
               IF CHOR = 1
                  ALERT( "Erro. Variavel n∆o existente: "+CSUBS,nOp )
                  @ 24,00 SAY "Erro na linha "+STR( I )
                  RETURN NIL
               ENDIF
               CSUBS := VALORS[ VPOS ]
            ENDIF
            @ VAL( SUBS( CLINHAS,NPOS-2 ) )-1,VAL( SUBS( CLINHAS,NPOS+1 ) )-1 PROMPT &CSUBS
         ENDIF
      ENDIF
      IF "GET" $ UPPER( LINHA )
         NPOS := AT( ",",CLINHAS )
         IF NPOS = 0
            ALERT( "Erro. Agurmento incompleto",nOp )
            @ 24,00 SAY "Erro na linha "+STR( I )
            RETURN NIL
         ELSE
            PARTE := SUBS( ALLTRIM( CLINHAS ),NPOS+4 )
            CPOS  := AT( '"',CLINHAS )
            IF CPOS = 0
               VPOS := ASCAN( CAMPOS,PARTE )
               CHOR := 1
               FOR L = 1 TO LEN( CAMPOS )
                  IF EMPTY( CAMPOS )
                     EXIT
                  ENDIF
                  IF CAMPOS[ L ] = PARTE
                     CHOR := 0
                  ENDIF
               NEXT
               IF CHOR = 1
                  ALERT( "Erro. Variavel n∆o existente: "+PARTE,nOp )
                  @ 24,00 SAY "Erro na linha "+STR( I )
                  RETURN NIL
               ENDIF
               VALOS := VALORS[ VPOS ]
               PARTE := &VALOS
            ELSE
               PARTE := &PARTE
            ENDIF
            NLINH1 := VAL( SUBS( CLINHAS,NPOS-2,2 ) )-1
            NCOL1  := VAL( SUBS( CLINHAS,NPOS+1,2 ) )-1
            @ NLINH1,NCOL1 GET PARTE
            READ
            VALORS[ VPOS ] := PARTE
         ENDIF
      ENDIF
      IF "LIMPAR" $ UPPER( LINHA )
         NPOS := AT( ",",CLINHAS )
         IF NPOS = 0
            ALERT( "Erro. Argumento incompleto",NOP )
            @ 24,00 SAY "Erro na linha "+STR( I )
            RETURN NIL
         ENDIF
         NLINH1 := VAL( SUBS( CLINHAS,NPOS-2,2 ) )
         NCOL1  := VAL( SUBS( CLINHAS,NPOS+1,2 ) )
         NLINH2 := VAL( SUBS( CLINHAS,NPOS+4,2 ) )
         NCOL2  := VAL( SUBS( CLINHAS,NPOS+7,2 ) )
         @ NLINH1,NCOL1 CLEAR TO NLINH2,NCOL2
      ENDIF
   CASE "MENU" $ UPPER( CLINHAS )
      NPOS := AT( ",",CLINHAS )
      IF NPOS = 0
         ALERT( "Erro. Argumento incompleto",nOp )
         @ 24,00 SAY "Erro na linha "+STR( I )
         RETURN NIL
      ELSE
         NMENU := VAL( SUBS( ALLTRIM( CLINHAS ),NPOS+1 ) )
         MENU TO NMENU
      ENDIF
   CASE "DESLIGA CURSOR" $ UPPER( CLINHAS )
      SETCURSOR( 0 )
   CASE "LIGA CURSOR" $ UPPER( CLINHAS )
      NPOS := AT( ",",CLINHAS )
      IF NPOS = 0
         SETCURSOR( 1 )
      ELSE
         TIPOCURSOR := { "MEIO INFERIOR","BLOCO CHEIO","MEIO SUPERIOR" }
         SAVECURSOR := SUBS( ALLTRIM( CLINHAS ),NPOS+1 )
         CURSESC := ASCAN( TIPOCURSOR,SAVECURSOR )+1
         NBOT := 1
         FOR L = 1 TO 3
            IF SAVECURSOR = TIPOCURSOR[ L ]
               NBOT := 0
            ENDIF
         NEXT
         IF NBOT = 1
            ALERT( "Erro. Tipo de cursor inexistente: "+SAVECURSOR,nOp )
            @ 24,00 SAY "Erro na linha "+STR( I )
            RETURN NIL
         ENDIF
         SETCURSOR( CURSESC )
      ENDIF
   CASE "ESPERAR" $ UPPER( CLINHAS )
      NPOS := AT( ",",CLINHAS )
      IF NPOS = 0
         INKEY( 0 )
      ELSE
         NSEG := VAL( SUBS( ALLTRIM( CLINHAS ),NPOS+1 ) )
         INKEY( NSEG )
      ENDIF
   CASE "SAIR" $ UPPER( CLINHAS )
      RETURN NIL
   CASE ":=" $ CLINHAS
      NPOS := AT( "=",CLINHAS )
      IF NPOS = 0
         ALERT( "Erro. Procedimento incompleto.",nOp )
         @ 24,00 SAY "Erro na linha "+STR( I )
         RETURN NIL
      ENDIF
      CCAMPO := SUBS( ALLTRIM( CLINHAS ),1,NPOS-3 )
      CVALOR := SUBS( ALLTRIM( CLINHAS ),NPOS+2 )
      AADD( CAMPOS,CCAMPO )
      AADD( VALORS,CVALOR )
   CASE "VOLTAR PROGRAMA" $ UPPER( CLINHAS )
      CAMPOS := {}
      VALORS := {}
      I := 1
   CASE "EXECUTE" $ SUBS( ALLTRIM( CLINHAS ),1,8 )
      EXED( CLINHAS )
   OTHERWISE
      ALERT( "Erro. Comando inexistente",nOp )
      @ 24,00 SAY "Erro na linha "+STR( I )
      RETURN NIL
   ENDCASE
NEXT
RETURN NIL

*******************
FUNCTION CANCELAR()
*******************
? "Cancelando na linha "+ALLTRIM( STR( I ) )
RETURN NIL

*************************
FUNCTION EXED( NARQUIVO )
*************************
NPOS := AT( ",",CLINHAS )
NVOS := RAT( ",",CLINHAS )
IF NPOS = 0 .OR. NVOS = NPOS
   ALERT( "Erro. Argumento incompleto",NOP )
   @ 24,00 SAY "Erro na linha "+STR( I )
   RETURN NIL
ENDIF
NEXE := SUBS( ALLTRIM( CLINHAS ),NPOS+1,NVOS-1 )+'"'
NOPS := AT( '"',CLINHAS )
IF NOPS = 0
   VPOS := ASCAN( CAMPOS,PARTE )
   CHOR := 1
   FOR L = 1 TO LEN( CAMPOS )
      IF EMPTY( CAMPOS )
         EXIT
      ENDIF
      IF CAMPOS[ L ] = NEXE
         CHOR := 0
      ENDIF
   NEXT
   IF CHOR = 1
      ALERT( "Erro. Variavel n∆o existente: "+NEXE,nOp )
      @ 24,00 SAY "Erro na linha "+STR( I )
      RETURN NIL
   ENDIF
   VALOS := VALORS[ VPOS ]
   NEXE := &VALOS
ELSE
   NEXE := &NEXE
ENDIF
NTIPO := SUBS( ALLTRIM( CLINHAS ),NVOS+1 )
DO CASE
   CASE NTIPO = "NORMAL"
      RUN &NEXE
   CASE NTIPO = "EXERIC"
      EXERIC( NEXE )
   OTHERWISE
      ALERT( "Erro. Os tipos de executavel s∆o: NORMAL e EXERIC.",NOP )
      @ 24,79 SAY "Erro na linha "+STR( I )
      RETURN NIL
ENDCASE
RETURN
