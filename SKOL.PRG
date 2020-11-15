#INCLUDE "INKEY.CH"
SETCOLOR("W+/B,N/W,B,W/N")
CLS
nTOP     := 00
nLEFT    := 00
nBOTTOM  := 00
nRIGHT   := 00
@ 10,00 SAY "Topo " GET nTOP PICTURE "99"
@ 11,00 SAY "Esquerda " GET nLEFT PICTURE "99"
@ 12,00 SAY "Fim " GET nBOTTOM PICTURE "99"
@ 13,00 SAY "Direita " GET nRIGHT PICTURE "99"
READ
WHILE .T.
   @ 00,00 CLEAR TO 24,79
   @ 00,00 SAY " F1        F2        F3        F4        F5        F6        F7        F8       "
   @ 01,00 SAY " Help      Open      Create    Save      Browse    Utility   Move      Set      "
   @ 02,00 SAY REPLICATE( "ฤ",79 )
   @ 04,37 SAY "Files"
   @ 05,27 SAY "ออออออออออออัออออออออออออ"
   @ 06,27 SAY "            ณ"
   @ 08,37 SAY "Indexes"
   @ 09,27 SAY "ออออออออออออัออออออออออออ"
   @ 10,27 SAY "            ณ"
   @ 11,27 SAY "            ณ"
   @ 12,27 SAY "            ณ"
   @ 14,37 SAY "Fields"
   @ 05,27 SAY "ออออออออออออัออออออออออออ"
   @ 06,27 SAY "            ณ"
   FOR I = 17 TO 22
      @ I, 27 SAY "           ณ"
   NEXT
   SETCURSOR( 0 )
   INKEY(0)
   DO CASE
      CASE LASTKEY()==K_ESC
         SETCOLOR("W/N,W/N,N,W/N")
         CLS
         RETURN NIL
      CASE LASTKEY()==K_UP
         SCROLL( nTOP, nLEFT, nBOTTOM, nRIGHT, -1 )
         NLIN := NLIN - 1
         LOOP
      CASE LASTKEY()==K_DOWN
         SCROLL( nTOP, nLEFT, nBOTTOM, nRIGHT, 1 )
         @ 24,00 SAY "Pressione qualquer tecla..."
         INKEY(0)
         LOOP
      CASE LASTKEY()==K_LEFT
         SCROLL( nTOP, nLEFT, nBOTTOM, nRIGHT,, 1 )
         @ 24,00 SAY "Pressione qualquer tecla..."
         INKEY(0)
         LOOP
      CASE LASTKEY()==K_RIGHT
         SCROLL( nTOP, nLEFT, nBOTTOM, nRIGHT,, -1 )
         @ 24,00 SAY "Pressione qualquer tecla..."
         INKEY(0)
         LOOP
   ENDCASE
END
