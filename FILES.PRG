#INCLUDE "INKEY.CH"
#INCLUDE "FILEIO.CH"
BOXS := { "ÚÄ¿³ÙÄÀ³ ", "ÉÍ»º¼ÍÈº " }

SETCOLOR("W+/B,W/N,B,W/N")
CLEAR
SETCOLOR("W+/R")
@ 03,04,05,39 BOX BOXS[2]
@ 04,06 SAY 'Fazendo o arquivo "filetest.txt"'
INKEY(0)
@ 05,40,07,63 BOX BOXS[1]
@ 06,42 SAY "Aguarde... Gravando."
INKEY(0)
CLS
MED     := SPACE(10)
LI      := 1
NOUTPUT := FCREATE( "FILETEST.TXT", FC_NORMAL )
CAIZ    := MEMOEDIT( MED,00,00,24,79,.T. )
FWRITE( NOUTPUT, CAIZ )
FCLOSE( NOUTPUT )
SETCOLOR("W/N,W/N,N,W/N")
CLEAR
RETURN NIL
