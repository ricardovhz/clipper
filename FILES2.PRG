#INCLUDE "FILEIO.CH"
BOXS := { "ÚÄ¿³ÙÄÀ³ ","ÉÍ»º¼ÍÈº " }
SETCOLOR("W+/B,W+/BG,B,W+/BG")
CLS
SETCOLOR("W+/R")
@ 03,04,05,39 BOX BOXS[2]
@ 04,06 SAY 'Fazendo o arquivo "filetest.txt"'
INKEY(0)
@ 05,40,07,63 BOX BOXS[1]
@ 06,42 SAY "Aguarde... Gravando."
INKEY(0)
SETCOLOR("W+/B")
CLS
NOUTPUT := FCREATE( "FILTESTE2.TXT", FC_NORMAL )
FWRITE( NOUTPUT, "Eu sou o Ricardo Vanhoz Ribeiro."+CHR(13)+CHR(10)+"Leisgal!!!"+;
                 CHR(13)+CHR(10)+"Mais legal do mundo." )
SETCOLOR("W/N,W/N,N,W/N")
CLS
RETURN NIL
