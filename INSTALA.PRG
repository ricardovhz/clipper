#INCLUDE "INKEY.CH"
#INCLUDE "BOX.CH"
BORDA1 := CHR(219)+CHR(219)+CHR(219)+CHR(219)+CHR(219)+CHR(219)+CHR(219)+CHR(219)+"Û"
BORDA5 := CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+CHR(255)+" "
NL := 03
SECS := 0.075

CLS

WHILE .T.
   SETCOLOR("GR+/N")
   @ 00,00,24,79 BOX BORDA1
   INKEY(2)
   SETCOLOR("W+/R")
   @ 00,16 SAY " Instala. De Ricardo Vanhoz Ribeiro. Versao 1.0 "
   @ 24,34 SAY " Legal!!! "
   @ 02,00,22,79 BOX B_DOUBLE+CHR(32)
   @ 02,40 SAY "Ë"
   FOR I = 03 TO 21
      @ NL,40 SAY "º"
      NL += 1
   NEXT   
   @ 22,40 SAY "Ê"
   inkey(1)
   setcolor("w+/g")
   explod(19,53,20,59,0.075)
   @ 18,43 SAY "Para iniciar a instalacao,"
   @ 19,43 SAY "pressione [ENTER] ou [ESC] para"
   @ 20,43 SAY "terminar a instalacao."
   INKEY(0)
   IF LASTKEY()==K_ENTER
      INSTAL()
      EXIT
   ENDIF
   IF LASTKEY()==K_ESC
      EXIT
   ENDIF
END

SETCOLOR("W/N")
CLS
RETURN NIL

STATIC FUNCTION INSTAL()
   DRIVE := "A"
   SETCOLOR("W+/RB")
   @ 03,41,21,78 BOX BORDA5
   @ 09,42 SAY "Drive que inicializar  a instala‡ao."
   @ 09,78 GET DRIVE PICTURE "@!"
   READ
   IF DRIVE = "A"
      SETCOLOR("B/RB")
      @ 03,41 CLEAR TO 21,78
      SETCOLOR("B/G")
      @ 05,42,08,77 BOX B_SINGLE+CHR(32)
      @ 06,44 SAY "Verificando os arquivos."
      ELS()
      ELS()
      ELS()
      SETCOLOR("W+/R")
      @ 09,02 SAY "Aguarde..."
      @ 11,02 SAY REPLICATE(CHR(8),31)
      SETCOLOR("GR+/N")
      CPO(11,02,SECS)
      CPO(11,03,SECS)
      CPO(11,04,SECS)
      CPO(11,05,SECS)
      CPO(11,06,SECS)
      CPO(11,07,SECS)
      CPO(11,08,SECS)
      CPO(11,09,SECS)
      CPO(11,10,SECS)
      CPO(11,11,SECS)
      CPO(11,12,SECS)
      CPO(11,13,SECS)
      CPO(11,14,SECS)
      CPO(11,15,SECS)
      CPO(11,16,SECS)
      CPO(11,17,1)
      CPO(11,18,1)
      CPO(11,19,1)
      CPO(11,20,SECS)
      CPO(11,21,SECS)
      CPO(11,22,SECS)
      CPO(11,23,SECS)
      CPO(11,24,SECS)
      CPO(11,25,SECS)
      CPO(11,26,SECS)
      CPO(11,27,SECS)
      CPO(11,28,SECS)
      CPO(11,29,SECS)
      CPO(11,30,SECS)
      CPO(11,31,SECS)
      CPO(11,32,SECS)
      SETCOLOR("B/R")
      @ 03,01 CLEAR TO 21,39
      TONE(349.30,9)
      TONE(349.30,9)
      TONE(349.30,9)
      @ 19,03 SAY "Coloque o disquete no drive A e"
      @ 20,03 SAY "pressione qualquer tecla"
      INKEY(0)
      SETCOLOR("B/R*")
      @ 15,04 SAY "Aguarde. Copiando arquivos..."
      COPY FILE C:\RICARDO\CLIPPER\MAGICA.PRG TO A:\MAGICA.PRG
      COPY FILE C:\RICARDO\CLIPPER\COPA.DBF TO A:\COPA.DBF
      SETCOLOR("GR+/R")
      @ 12,03 SAY "Copia‡ao completa..."
      @ 13,03 SAY "Pressione qualquer tecla..."
      INKEY(0)
      SETCOLOR("W/N")
      CLS
      RETURN NIL
   ENDIF   

   IF DRIVE = "B"
      SETCOLOR("B/BG")
      @ 03,41 CLEAR TO 21,78
      SETCOLOR("B/G")
      @ 05,42,08,77 BOX B_SINGLE+CHR(32)
      @ 06,44 SAY "Verificando os arquivos."
      ELS()
      ELS()
      ELS()
      SETCOLOR("W+/R")
      @ 09,02 SAY "Aguarde..."
      @ 11,02 SAY REPLICATE(CHR(8),31)
      SETCOLOR("GR+/N")
      CPO(11,02,SECS)
      CPO(11,03,SECS)
      CPO(11,04,SECS)
      CPO(11,05,SECS)
      CPO(11,06,SECS)
      CPO(11,07,SECS)
      CPO(11,08,SECS)
      CPO(11,09,SECS)
      CPO(11,10,SECS)
      CPO(11,11,SECS)
      CPO(11,12,SECS)
      CPO(11,13,SECS)
      CPO(11,14,SECS)
      CPO(11,15,SECS)
      CPO(11,16,SECS)
      CPO(11,17,1)
      CPO(11,18,1)
      CPO(11,19,1)
      CPO(11,20,SECS)
      CPO(11,21,SECS)
      CPO(11,22,SECS)
      CPO(11,23,SECS)
      CPO(11,24,SECS)
      CPO(11,25,SECS)
      CPO(11,26,SECS)
      CPO(11,27,SECS)
      CPO(11,28,SECS)
      CPO(11,29,SECS)
      CPO(11,30,SECS)
      CPO(11,31,SECS)
      CPO(11,32,SECS)
      @ 03,01 CLEAR TO 21,39
      TONE(349.30,9)
      TONE(349.30,9)
      TONE(349.30,9)
      @ 19,03 SAY "Coloque o disquete no drive B e"
      @ 20,03 SAY "pressione qualquer tecla"
      INKEY(0)
      SETCOLOR("B/R*")
      @ 15,04 SAY "Aguarde. Copiando arquivos..."
      COPY FILE C:\RICARDO\CLIPPER\MAGICA.PRG TO B:\MAGICA.PRG
      COPY FILE C:\RICARDO\CLIPPER\COPA.DBF TO B:\COPA.DBF
      SETCOLOR("GR+/R")
      @ 12,03 SAY "Copia‡ao completa..."
      @ 13,03 SAY "Pressione qualquer tecla..."
      INKEY(0)
      SETCOLOR("W/N")
      CLS
      RETURN NIL
   ENDIF   

RETURN NIL

STATIC FUNCTION ELS()
      @ 07,45 SAY "|"
      INKEY(SECS)
      @ 07,45 SAY "/"
      INKEY(SECS)
      @ 07,45 SAY "Ä"
      INKEY(SECS)
      @ 07,45 SAY "\"
      INKEY(SECS)
      @ 07,45 SAY "|"
      INKEY(SECS)
      @ 07,45 SAY "/"
      INKEY(SECS)
      @ 07,45 SAY "Ä"
      INKEY(SECS)
      @ 07,45 SAY "|"
      INKEY(SECS)
RETURN NIL

STATIC FUNCTION CPO(NI,CR,SECO)
   @ NI,CR SAY CHR(8)
   INKEY(SECO)
RETURN NIL

STATIC FUNCTION EXPLOD(LI,CI,LF,CF,SEC)
   WHILE LI # 17
      @ LI,CI,LF,CF BOX B_SINGLE+CHR(32)
      LI -= 1
      CI -= 3
      LF += 1
      CF += 3
   END
@ 17,41,21,78 BOX B_SINGLE+CHR(32)
RETURN NIL
